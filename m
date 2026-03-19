Return-Path: <netdev+bounces-269404-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +AboBAHYu2k6pAIAu9opvQ
	(envelope-from <netdev+bounces-269404-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 12:03:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 152402C9F56
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 12:03:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 52E763009820
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 11:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B59C3C345D;
	Thu, 19 Mar 2026 11:03:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5CC36895E
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 11:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773918196; cv=none; b=C2OmB5OELuhTCnQKnv+6SF234zU6cg3H26PL12vxIij52vJJuRGPoNzJ5vP46crCQgZNOktTE+QmROj5jPCzqtHW/MlDHRFBl15+KH6/qy4Iab4BtYdU7hSkcIUgEgt/w+B+27nbrxjntkw2KADzOT4QhmCgoIWnMmC3nwFSF4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773918196; c=relaxed/simple;
	bh=PawUjAff15+oRA7Q1xArUU/n6HG5b2GHGK00XVwvUqs=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CYTCHdSe5O2uRoi2iWx4a4OSpndB9EyOiEAwmismMbXJLOANbmJU3JxmRgYvwKSycgD6Nf4tWSZYjIgWItwMH28tK8Pfyt5YSNy9QyDIg2ux7/yDCmEJ0MWh082h70lW61JSVO8skKGud7dWniwcqfapCOlNeHRV42nG37rQH28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-43b3d9d0695so615836f8f.0
        for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 04:03:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773918192; x=1774522992;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:cc:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UoKglMvUMd6qCbtIePCE65BAuCUK+BeoobLWHIfF0VM=;
        b=nmuQLf4xf22BkAUkG4kAWRLFkX4UTHAPPv4gWiOXUZGSuxPCjEM1VTlMm0oC5YQH3O
         u8HykwkVuHMfpqU4Gb3no8MiM7CERratW1EEtEOVceso2CZ8ha6Rd+IouA8kn6LoYVgJ
         lm56FCDXQw51I7jpN4gzLNZKAtVXLK/8VsBvVJZ+iDPm4dPYUKzwlJetiDmP4Y8iywJm
         vCpu3syYuS7fI+a70FxquWOOQZR5WZoZcOr4BWhHrXv1yslaAw+nJ7cQ6ban87eBSUIE
         uHSj2qBRucxYWhzx41MythHkykDx18dRcfrmO6uePwBYLNPEMUm1e3iUtrFx0uPZ2uv8
         92aw==
X-Forwarded-Encrypted: i=1; AJvYcCVOUg68XYdau32qJrxxY0WfSyWCwomtDCwwK/T0xMkQVMvMVKOVR8yZHfMyGgBDJCm7Bcni7EU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7TbFK6WWyL1nTRG9uVdNgESOoxLkAHKSCNuNuqNcC57zsf+Ly
	WduG9g83oX/roKd/UMveVGOn8SuxIkY4Kvh2PvWNW/tZSlMU2OXIipEM9V+QQM14LZcsBQ==
X-Gm-Gg: ATEYQzzNZSQDr28lcrCwLHBvUCpKnWYjByKL83GkMhYL93d9cOgD4MNljpyiymWqfnM
	fY14gu2ANED8uBW/uMCsCUY6nIbStnYl2n8f9DyaZ6SUth7r/EZXJyOs4vrW4OvQI3jrLe2ph4b
	nVr1k1fPbaMZbvqL6vTkh2S9pmGCQGQ+AWmGsQ1tuO/JsNQNzg8vcYDhra5IEoJW126K+xLaKYH
	KkZQomwTHSCbrCpeokYr2GudH+L6EP90CY0IX8M8tB7+/bS4zsO1+xeDkIy7wcf1EDlnZtFO95l
	wX+qWkdDDHLKflKej3WTd/4GBv3ssdOkHbfK3KMnL0Vfcs1VlebqBBOloimIkVnAmqFs4B1vHYM
	oAtBKrNVQ5sFzS/dYUTl7FlS6OPAqHKgnPk6MXqQQdpD1ojIs8gLoEFxeeOQWQicEYg9vI3B35F
	WcXzXFaaCga1QwRoUnoEi9oC83KpVdFMYeKkX4/QY1lEsCOm4dtsjNyms=
X-Received: by 2002:a05:6000:2509:b0:43b:3dcc:8b02 with SMTP id ffacd0b85a97d-43b576f09f0mr6087670f8f.1.1773918191220;
        Thu, 19 Mar 2026 04:03:11 -0700 (PDT)
Received: from [192.168.88.241] (89-24-32-126.nat.epc.tmcz.cz. [89.24.32.126])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b51852ab3sm15164849f8f.12.2026.03.19.04.03.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2026 04:03:10 -0700 (PDT)
Message-ID: <130badaf-cf19-493d-8221-09d439323af8@ovn.org>
Date: Thu, 19 Mar 2026 12:03:08 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: i.maximets@ovn.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, tgraf@suug.ch,
 netdev@vger.kernel.org, dev@openvswitch.org, linux-kernel@vger.kernel.org,
 yifanwucs@gmail.com, tomapufckgml@gmail.com, tanyuan98@outlook.com,
 bird@lzu.edu.cn
Subject: Re: [PATCH net] openvswitch: defer tunnel netdev_put to RCU release
To: Yang Yang <n05ec@lzu.edu.cn>, aconole@redhat.com, echaudro@redhat.com
References: <20260319074241.3405262-1-n05ec@lzu.edu.cn>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <20260319074241.3405262-1-n05ec@lzu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[ovn.org,davemloft.net,google.com,kernel.org,redhat.com,suug.ch,vger.kernel.org,openvswitch.org,gmail.com,outlook.com,lzu.edu.cn];
	TAGGED_FROM(0.00)[bounces-269404-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[ovn.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[i.maximets@ovn.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.828];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:email,ovn.org:email,ovn.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 152402C9F56
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/19/26 8:42 AM, Yang Yang wrote:
> ovs_netdev_tunnel_destroy() may run after NETDEV_UNREGISTER already
> detached the device. Dropping the netdev reference in destroy can race
> with concurrent readers that still observe vport->dev.
> 
> Do not release vport->dev in ovs_netdev_tunnel_destroy(). Instead, let
> vport_netdev_free() drop the reference from the RCU callback, matching
> the non-tunnel destroy path and avoiding additional synchronization
> under RTNL.
> 
> Fixes: a9020fde67a6 ("openvswitch: Move tunnel destroy function to oppenvswitch module.")
> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Tested-by: Ao Zhou <n05ec@lzu.edu.cn>
> Co-developed-by: Yuan Tan <tanyuan98@outlook.com>
> Signed-off-by: Yuan Tan <tanyuan98@outlook.com>
> Suggested-by: Xin Liu <bird@lzu.edu.cn>
> Signed-off-by: Yang Yang <n05ec@lzu.edu.cn>
> ---
> 
>  net/openvswitch/vport-netdev.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/net/openvswitch/vport-netdev.c b/net/openvswitch/vport-netdev.c
> index 6574f9bcdc026..44dbe8a9b0778 100644
> --- a/net/openvswitch/vport-netdev.c
> +++ b/net/openvswitch/vport-netdev.c
> @@ -189,8 +189,6 @@ void ovs_netdev_tunnel_destroy(struct vport *vport)
>  	 */
>  	if (vport->dev->reg_state == NETREG_REGISTERED)
>  		rtnl_delete_link(vport->dev, 0, NULL);
> -	netdev_put(vport->dev, &vport->dev_tracker);
> -	vport->dev = NULL;
>  	rtnl_unlock();
>  
>  	call_rcu(&vport->rcu, vport_netdev_free);

This should solve the issue indeed.  I ran OVS testsuite with
this as well, and it works fine.  Thanks!

Reviewed-by: Ilya Maximets <i.maximets@ovn.org>

