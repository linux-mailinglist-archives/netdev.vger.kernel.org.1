Return-Path: <netdev+bounces-261258-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALSZIL0NoGnbfQQAu9opvQ
	(envelope-from <netdev+bounces-261258-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 10:09:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0A11A32A4
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 10:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 764B23023167
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 09:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C10C395DA4;
	Thu, 26 Feb 2026 09:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AswNszO9";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="fiNf8/ac"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D242522A7
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 09:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772096955; cv=none; b=pGjfozVdFIMq3WiNWoW35dMu6xLcgUu7KwFLwVSaUB1nA0sP+vmSFRC6OK0RJtC4Qkyvn2ygMfb+aLcf/p6NGgkAEMhy+iDuaLYMBmBwSallwucA/kALrp/BxCeZ3TqMSAwEkmfMdPRjMCKtOj2ZxBz8Iz3pKowfSuR1JDhxTH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772096955; c=relaxed/simple;
	bh=qltUIzMojJ2OvidN3CUSmUUBPTAyMnwdssckTiQE9aA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=twgV1suI0Sf6ZjujwGszVp7PaLRDjY8gjKusq0Ve0HPEREFj2kaeHd5bOvbPjtXQDfIIRvRH9g4Y5x+ElWtSE7eCyCa+uwEfaa+1Ae/ySeT/yzdu697TTFf5LvF1GmM7nnencYTSXoFSDBS0kjZvBgzhpbZPaga5Y9ih9maqXxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AswNszO9; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fiNf8/ac; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772096952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=UsAnFN0hwUbuvioHE0pqsuIkZlEOesrcgpyhMU7ZUp4=;
	b=AswNszO9ks1v7bRbjb1BZx1Yypp0MNBOFbxzzcEOqHZJBOLZB+6AROUxPGWtUQDiPwwgwB
	Sb+qMmGXky4i4x5wcir7NBzYPAY45JvXhTjTOIclgs3AaNgKDhVWqKFGWt0tTtu5SUy+dN
	dGmuG5fBLObRS++xyAgCV/s8bbdEGEQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-115-YIIte0XjO2aTuoWcPyZ5Ag-1; Thu, 26 Feb 2026 04:09:11 -0500
X-MC-Unique: YIIte0XjO2aTuoWcPyZ5Ag-1
X-Mimecast-MFC-AGG-ID: YIIte0XjO2aTuoWcPyZ5Ag_1772096950
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-482d8e6e13aso5382965e9.3
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 01:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772096950; x=1772701750; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UsAnFN0hwUbuvioHE0pqsuIkZlEOesrcgpyhMU7ZUp4=;
        b=fiNf8/acPJeJNSQILF9lImp9vb3IyBtRQo5zfwo6QTB6msHSA5L1NaFu0rA5tMoqB/
         3zgfceGzZCd9OTZoETFbqO89XXkphWK5ijpjx3SNp8ljilTr8BEasId/178vVqaAMO9B
         HVFZJnCoeqWcuZq/m6B/1uHk9ozDNI/5a099ortUltXldZyqW4PlDTv/geFEEWZMA68W
         9rNHN0buTiuTTZEu4JuCS9TVmWWJqq8V6e2SEGierzQ6yXENKbnVgYHakuY6x7WWVBZs
         3SE/0OqJ603WlQh/FxlN1HLc4XeleeqhtxB3rKKqvYHuchfbrr3fhXSR4oEPzFrRtqbm
         9bew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772096950; x=1772701750;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UsAnFN0hwUbuvioHE0pqsuIkZlEOesrcgpyhMU7ZUp4=;
        b=kbjmYpD9RWrf1huS4wwaAtoTbzKtDY4rIsDIVi+l2MozUbecCdJB/Fs0g/yOLFt0We
         5K1UuuvB9fDt3ujKRPA2iiWJFIhd9g4uN42HVKP/KVD1BIFA5tlOasSAgsfJMTmRLv1K
         rM9EjVmeOWOk1rl1ydEgLI81Z/xEykv9isqvP2cjjIoYDT+bWSP/FuDC/mn2h+WFaCR4
         1pLcH3A68qfl5PTWIXqY+72mbPEARDmWG4jxN4dgHYNA7G0ZoiLh0t/1ZfOv4LYb2iLn
         VKIMUz3BCHWH8li7WxRT3hmV/nUiZXsPk0LrBRc7Yz0a8TeSJXx+CMuHgjGvEKNkP/aD
         0tyg==
X-Forwarded-Encrypted: i=1; AJvYcCWQ+IY8EB3lzuM6owdRIReApDfz2adBHao9pR8xUsy4eOzlUrNueM/nYpoofVU//vklWlXh4dI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvCVfrkwMUUPzfyrFR9Ta+DXej8rXxOOmEk5uk8u3blywEOPnD
	KfLXHdkFp/TFAc8l0JQSC1yAv4wkoAHuET7NoHc4po+IUT3681qxdmXYvzLnnwbslJ0lAcXyklI
	Kerjw0GkOR+peko94YXqCVGDqOMJpDWw9zdyWZm3HxRPs9YHBNE3jNR4ZRg==
X-Gm-Gg: ATEYQzxiv3R/P1GuiAANUPI3iqsTaosCMRbrkw0PK63UuHdt6HfBYxIylxH8RoC7POe
	8aSYK1n0lIqu1/PxQQDmAaWWFu2GIrqw0/ZQJ0wlmWNGq0bLDfgJdy3ILWXeNk5f1ljuC0ofTxC
	1FZEtuKCLLS8X08oPdBxs0n2y7qxAK78TwxDeNDu8QeuSGZZ/qtoYQAP1RDfF5gZXmKOBX6/YUu
	8kxU/FSbOSVeiBLRvQg5laHtZyFxh3noQjKW0k893WY7I5wrxd6C1/Hh4YiJa/1yhKndh3Uv/4D
	NndB5AZy91ey7sKkT6q5LfN+4GlcEo9X+wsbnRhqcVP//e9d01ioY7ab/2tM1bvGAgl0NONvq/i
	/B2lRWskrscqaW8bhxtHLVrXle/DqZLpWY9HV6arwLtLt57yeH5bX2dNu+fnKT/KJSidFRekxki
	8DmDrHjyIV76WzNQJNCJ6nAX1TDeK2AGt3axVbkv96J5lCaU6npgpw1UuI
X-Received: by 2002:a05:600c:3111:b0:483:612d:7a9a with SMTP id 5b1f17b1804b1-483a95622f5mr326792315e9.0.1772096949706;
        Thu, 26 Feb 2026 01:09:09 -0800 (PST)
X-Received: by 2002:a05:600c:3111:b0:483:612d:7a9a with SMTP id 5b1f17b1804b1-483a95622f5mr326791685e9.0.1772096949181;
        Thu, 26 Feb 2026 01:09:09 -0800 (PST)
Received: from ?IPV6:2a01:cb00:8ef9:5300:877b:aaab:2ea7:8695? (2a01cb008ef95300877baaab2ea78695.ipv6.abo.wanadoo.fr. [2a01:cb00:8ef9:5300:877b:aaab:2ea7:8695])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd7031f3sm117403225e9.6.2026.02.26.01.09.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Feb 2026 01:09:08 -0800 (PST)
Message-ID: <a481bb1e-d0a9-4545-bb8b-beb72506478a@redhat.com>
Date: Thu, 26 Feb 2026 10:09:07 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: commit 662dc80a5e86 breaks rmnet over usb
To: Daniele Palmas <dnlplm@gmail.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Koen Vandeputte <koen.vandeputte@citymesh.com>, oneukum@suse.com,
 andrew+netdev@lunn.ch, Eric Dumazet <edumazet@google.com>,
 pabeni@redhat.com, netdev <netdev@vger.kernel.org>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CAPh3n803k8JcBPV5qEzUB-oKzWkAs-D5CU7z=Vd_nLRCr5ZqQg@mail.gmail.com>
 <95ccf5a6-975b-4543-80a3-595f1ee20543@redhat.com>
 <CAGRyCJE85fLOahUR3PAUnS_jH4+qpBq37qpged=nvObbg1m+Qw@mail.gmail.com>
 <20260225170155.0ae83ae9@kernel.org>
 <CAGRyCJGYLemYFDNw8cfcCHoxe8YqfRRgnJXgz03WVssKDYXhUA@mail.gmail.com>
Content-Language: en-US
From: Laurent Vivier <lvivier@redhat.com>
Autocrypt: addr=lvivier@redhat.com; keydata=
 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
In-Reply-To: <CAGRyCJGYLemYFDNw8cfcCHoxe8YqfRRgnJXgz03WVssKDYXhUA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-261258-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lvivier@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1C0A11A32A4
X-Rspamd-Action: no action

On 2/26/26 09:26, Daniele Palmas wrote:
> Hello Jakub,
> 
> Il giorno gio 26 feb 2026 alle ore 02:01 Jakub Kicinski
> <kuba@kernel.org> ha scritto:
>>
>> On Wed, 25 Feb 2026 08:19:46 +0100 Daniele Palmas wrote:
>>>> Could you try something like:
>>>>
>>>> diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
>>>> index 3a4985b582cb..6b4796fac692 100644
>>>> --- a/drivers/net/usb/qmi_wwan.c
>>>> +++ b/drivers/net/usb/qmi_wwan.c
>>>> @@ -788,6 +788,8 @@ static int qmi_wwan_bind(struct usbnet *dev, struct usb_interface *intf)
>>>>                   usbnet_get_ethernet_addr(dev, cdc_ether->iMACAddress);
>>>>           }
>>>>
>>>> +       dev->rx_urb_size = 32768;
>>>> +
>>>
>>> So far userspace tools (e.g. also the most important one which is
>>> ModemManager) rely on changing the rx_urb_size by changing the MTU: I
>>> know this is ugly, but it is a behavior that has been there since a
>>> lot of time, not sure how many tools based on this assumption could
>>> break.
>>
>> What's the policy in ModemManager to change the rx_urb_size?
>> Increase it to make sure it can hold some specific cmd / packet?
>>
>> I wonder if having rx_urb_size max of (mtu, 32k) would break anything.
>>
> 
> Typically the host sends a QMI request to the modem for setting the
> size of the maximum QMAP aggregated packets block. Then the modem
> replies with the maximum size it supports and that one is then set by
> the host through changing the MTU of the netdevice. Low-cat modems
> usually support 4-8 KB, while 5G 16-32KB.
> 
> On ModemManager side this is currently fixed at 16KB, but one can use
> other tools e.g. qmicli to set custom values as far as they are
> supported by the modem.
> 
>> Since we're talking about rx buffer config the right API to configure
>> it is likely ethtool -G rx-buf-len :(
>>
> 
> Thanks for the hint, I'll try to have a look at that to improve qmi_wwan.
> 
>>> There's also the chance that there are modems which require a higher
>>> rx_urb_size, so having this fixed could not work well.
>>>
>>> Unfortunately usbnet serves many drivers, I agree with Koen that a
>>> revert is the safest option.
>>
>> Then again the usbnet driver is brittle enough as is, if it's just qmi
>> that needs this workaround we would be making common code less robust
>> for a benefit of a single "hack" (for lack of a better term)
> 
> Makes sense, also Laurent proposed a solution to keep his fix in
> usbnet and make qmi_wwan the exception.

I was thinking to something like that (see below), but I'm not really able to test it. If 
everyone thinks it's the path to follow, I can send a patch.

Thanks,
Laurent

diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index 3a4985b582cb..05acac10cd2b 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -928,7 +928,7 @@ static int qmi_wwan_resume(struct usb_interface *intf)

  static const struct driver_info	qmi_wwan_info = {
  	.description	= "WWAN/QMI device",
-	.flags		= FLAG_WWAN | FLAG_SEND_ZLP,
+	.flags		= FLAG_WWAN | FLAG_NOMAXMTU | FLAG_SEND_ZLP,
  	.bind		= qmi_wwan_bind,
  	.unbind		= qmi_wwan_unbind,
  	.manage_power	= qmi_wwan_manage_power,
@@ -937,7 +937,7 @@ static const struct driver_info	qmi_wwan_info = {

  static const struct driver_info	qmi_wwan_info_quirk_dtr = {
  	.description	= "WWAN/QMI device",
-	.flags		= FLAG_WWAN | FLAG_SEND_ZLP,
+	.flags		= FLAG_WWAN | FLAG_NOMAXMTU | FLAG_SEND_ZLP,
  	.bind		= qmi_wwan_bind,
  	.unbind		= qmi_wwan_unbind,
  	.manage_power	= qmi_wwan_manage_power,
diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index ed86ba87ca4e..b72ba0803392 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -1829,11 +1829,12 @@ usbnet_probe(struct usb_interface *udev, const struct 
usb_device_id *prod)
  		if ((dev->driver_info->flags & FLAG_NOARP) != 0)
  			net->flags |= IFF_NOARP;

-		if (net->max_mtu > (dev->hard_mtu - net->hard_header_len))
+		if ((dev->driver_info->flags & FLAG_NOMAXMTU) == 0 &&
+		    net->max_mtu > (dev->hard_mtu - net->hard_header_len))
  			net->max_mtu = dev->hard_mtu - net->hard_header_len;

-		if (net->mtu > net->max_mtu)
-			net->mtu = net->max_mtu;
+		if (net->mtu > (dev->hard_mtu - net->hard_header_len))
+			net->mtu = dev->hard_mtu - net->hard_header_len;

  	} else if (!info->in || !info->out)
  		status = usbnet_get_endpoints(dev, udev);
diff --git a/include/linux/usb/usbnet.h b/include/linux/usb/usbnet.h
index b0e84896e6ac..bbf799ccf3b3 100644
--- a/include/linux/usb/usbnet.h
+++ b/include/linux/usb/usbnet.h
@@ -132,6 +132,7 @@ struct driver_info {
  #define FLAG_MULTI_PACKET	0x2000
  #define FLAG_RX_ASSEMBLE	0x4000	/* rx packets may span >1 frames */
  #define FLAG_NOARP		0x8000	/* device can't do ARP */
+#define FLAG_NOMAXMTU		0x10000	/* allow max_mtu above hard_mtu */

  	/* init device ... can sleep, or cause probe() failure */
  	int	(*bind)(struct usbnet *, struct usb_interface *);



