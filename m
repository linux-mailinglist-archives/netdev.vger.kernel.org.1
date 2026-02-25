Return-Path: <netdev+bounces-260988-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDImMrAHn2neYgQAu9opvQ
	(envelope-from <netdev+bounces-260988-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 15:31:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 431C6198C3D
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 15:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3B8D53028353
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 14:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5F12798EA;
	Wed, 25 Feb 2026 14:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EgOEHalo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAA32741B6
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 14:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772029870; cv=pass; b=KahbRI9YazRIIrqxNrFAb3zY4NArsql6RNrR1l1uRskjYj+r5Y32ydtgYm900FK5R2LCh7KxVXO8lsj5FikedovxiapE41Cz5yfrMJ9Eb5iXwHDuMlhUhWwrN8TsNbRZ+Ido1ctI99+s5PdBRj+nBh4DhMFLIDWy0Y/d9AOLHxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772029870; c=relaxed/simple;
	bh=lDxrNwvH+u8AghB7OKYDxs/bjbeo+2dtgxLhG3lixOY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QrBgwFBOzvXiaXbR1vZPrspxfaPe84f1F+shORvT7Z4wK22vw+tevMX0RqUQVttk46q0R0jiqzsDT25B8uCZYot/x+aj5QjWtEk9+l1HKMfQJSXIiWpqASsJBmhHqFKKSuktm18XtqyUtAY7wmqHypzi5hsTcicZJtl7mknXCfg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EgOEHalo; arc=pass smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4398f8403edso630541f8f.1
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 06:31:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772029867; cv=none;
        d=google.com; s=arc-20240605;
        b=I2QGaRfTSrnYXbc/XJ5Q5UFpVWbjC1CEokc/QG2/w+F1+tL6MJPN7sDlV/11QCLMO1
         wZyFK8AhChYMq0OijjZempIq4yKnFyR6Ysk3udKYPz9jPZtzNc/tMrlhu6aq9gapiXf8
         CwjKQDBk1xyUDFbo9FJmNNSMHonFniEIg778Ff5Pphv8EDhJxIzzIftleSeB+WjFL2Vt
         mV/bcoXrEN/+vwItm2zL4iLH23/vv89pmTwqAOF0IvJYkwwrg4bzUv4jD5uxskCll6Hm
         vaeeL8tLOkHPNQWm24XmZxzi4+nPN8/WUNs8ZyYuLm/bXCLt219A9C8nXUCScUHAGeBZ
         xpzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=N+RRuRzUdPwGiiltiKyCGpUNsVVNigyNyxP5XZc6I3k=;
        fh=uPNcLMrAKOfrt35BuzmxqveqYvL0b/lhuiSPqnfDLpY=;
        b=U8j+C9JjTy6mS0qqyizTwh+5QJrwhuBYEm8LxYAK5FBBTM0odYNCQPknOFmNAmQNvf
         1qE29L0QB41fVg++0wTXxRlyKwz41QlCXVgKmS7yBUyUekDoIY6hxSmi/2z41OF+J/bG
         ND4jF3rgAIpZxTHH3ouG22bq6JOg9xZcfKTwFaKsq16kAbCXnOBqu0zy/GbE8ewO1E8y
         8yncXIUlj/SH2s6WAnX5Ynz9KFxKuvLwYRJvCGpgDhgLSLp5o3CZLJqIxdgBswZuEJ5g
         b8dYTBW6Kp1zqo+u4WTPSc7Er0xm855IRZFu3G6bdbma4rQYL8Zq5M5peU6LZ7nI558A
         hSwQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772029867; x=1772634667; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=N+RRuRzUdPwGiiltiKyCGpUNsVVNigyNyxP5XZc6I3k=;
        b=EgOEHalozD8k3buBX6hM+9xA87q6KhR5nqjP9M1TiTMEt8oR9p6vBT7y2B55Vem6V/
         6ES0J8oaw0E1feC8LSY+6pylTe2qyyEBxMPngdz2y5ZYB6PVO6Pb4EwYdSBZm/7HU80M
         t3k2xkGQ9/tBZn410FCVQGYIPsY12D1Ml1hS9nd08vj5liG3O3FanoMpfn+32kqEqiE5
         Mqauimqv7938QjXoi9jg8Xl5sbGJeUwU21Nyj4GKXOjaRJs/AVhJrRpiCbKXX/5BqRsu
         qEiSLV5j9pfE/OBdtSQP+CBWD8GYHcmav5mu9xcT+MhXKvBraT92HFxvtSaQqX6hAsJf
         qeEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772029867; x=1772634667;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N+RRuRzUdPwGiiltiKyCGpUNsVVNigyNyxP5XZc6I3k=;
        b=kxu9nsIvYpg6aMTCzyKQNLpjXx9PEBPIkw6skuejNzNPTB+FTDjkUz0umG0XKWwvez
         0vNpUKKnDKneNne3AGw3DGzY+g1Gyx/O2IR4oA/u/BizYwM4OKwj3xIdSMgMhUcrdrF7
         8SZst1l6Ru010QsWDTjq7ruCPx3ZcSK2r3Zz5Xysr20r6uwE6PwOxd2Mxv+a/BevD1bt
         IJJy8ZzpS/qRwQmnQ3U0krDcFbEhvAMA5v+EFAkrVGuHxCnQUBeOzFe7SqaXo2ZyYFWn
         k5zYRzeFS82+S4m7nn+zfFSDZPopmIpxnGPSZwOhIIQpxy8SRmydpAQkIhIo7Bv1frVy
         niIw==
X-Forwarded-Encrypted: i=1; AJvYcCXuonF9mgHujdy4L+CYzC2sawQ5PbydOhh/Ws+H2hDlf7JJyVtpolagdhaTMptDG2Xm0KMVz3c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJVcXI6YI6lnB+GlbaWKg03PDE8qJDeDgEd7FpHgeP7OwMxxBV
	2II+hvlCGMqzV5xZhj/4we22nnLLmPhDmTISijNnVdyWXILoNg28GAd72JuEWWo5jQnB9Kmv4Tt
	OYeONUSRhTFPU90u342BUqXk6sUbtxYA=
X-Gm-Gg: ATEYQzzpqw/OXUrfBsQp0/CycetG9Tqq/6Bic3/brmyYdrkNJdOrJqrTb2/jd0kmQh5
	fwx0P0StK2cBed7UWfmqJm3/WGQ27EEc1YJYjw9IkY5fW37uqUCQ2jpQIhPwH0CnUHR7Ux40edP
	VglkNT+GXVpjM/hfhmB/KUaz1Ci58h+JDzB+O79ig46EJYtBQ85z766uS4GAb/aO5A1EmX/iqRG
	zII5zb6Znd4dGmVgahFuIb2WzquVwUj4G3kCXylcrsfnR2xkJoCjZjSzyiB3lzFyadaJGJmil7a
	uIRY
X-Received: by 2002:a5d:5f93:0:b0:430:f985:a7b2 with SMTP id
 ffacd0b85a97d-43994305922mr1343790f8f.51.1772029863933; Wed, 25 Feb 2026
 06:31:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPh3n803k8JcBPV5qEzUB-oKzWkAs-D5CU7z=Vd_nLRCr5ZqQg@mail.gmail.com>
 <95ccf5a6-975b-4543-80a3-595f1ee20543@redhat.com> <CAGRyCJE85fLOahUR3PAUnS_jH4+qpBq37qpged=nvObbg1m+Qw@mail.gmail.com>
 <28cd2d03-6491-490d-89e2-19f81e9bad69@redhat.com> <9c187cb6-6ab1-40f1-a1d8-d47012e3835b@redhat.com>
In-Reply-To: <9c187cb6-6ab1-40f1-a1d8-d47012e3835b@redhat.com>
From: Daniele Palmas <dnlplm@gmail.com>
Date: Wed, 25 Feb 2026 15:14:36 +0100
X-Gm-Features: AaiRm53nFhKaiAdPQ5DDmF3jLatuagDM8Lva7zfZ3Nt2XYtEoP8FuPBhZ0MmVLk
Message-ID: <CAGRyCJEG8aCLwysgZzuRVKGDOPaVhCChtajmj450mCpGHJK1Ww@mail.gmail.com>
Subject: Re: commit 662dc80a5e86 breaks rmnet over usb
To: Laurent Vivier <lvivier@redhat.com>
Cc: Koen Vandeputte <koen.vandeputte@citymesh.com>, oneukum@suse.com, andrew+netdev@lunn.ch, 
	Eric Dumazet <edumazet@google.com>, kuba@kernel.org, pabeni@redhat.com, 
	netdev <netdev@vger.kernel.org>, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260988-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dnlplm@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 431C6198C3D
X-Rspamd-Action: no action

Hello Laurent,

Il giorno mer 25 feb 2026 alle ore 12:04 Laurent Vivier
<lvivier@redhat.com> ha scritto:
>
> On 2/25/26 08:48, Laurent Vivier wrote:
> > On 2/25/26 08:19, Daniele Palmas wrote:
> >> Hello,
> >
> > Hello Daniele,
> >
> >>
> >> Il giorno lun 23 feb 2026 alle ore 15:08 Laurent Vivier
> >> <lvivier@redhat.com> ha scritto:
> >>>
> >>> On 2/23/26 13:04, Koen Vandeputte wrote:
> >>>> Hi Laurent,
> >>>
> >>> Hi Koen,
> >>>
> >>>> I'm testing the latest openwrt state and found an issue probably
> >>>> caused by your usb mtu limit patch :-)
> >>>>
> >>>> I'm talking about this one:
> >>>> 662dc80a5e86 ("usbnet: limit max_mtu based on device's hard_mtu")
> >>>>
> >>>> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?
> >>>> h=v6.12.74&id=662dc80a5e86b35bbf339e0b87b7cc3f07c09de1
> >>>>
> >>>>
> >>>> When using wwan0 iface normally, this makes sense, but the problem is
> >>>> when using QMI modems combined with the rmnet driver and aggregated
> >>>> frames.
> >>>>
> >>>> - The modem is configured to frame sizes of 16383 or 32767 using QMI
> >>>> - wwan0 (using qmi_wwan) is configured to match this frame size by
> >>>> setting it's MTU to the same value
> >>>> - Frames of this size are sent over to qmi_wwan driver (containing
> >>>> multiple data packets)
> >>>> - Frames are then forwarded to the rmnet driver
> >>>> - Frames get de-aggregated here and sent to the network stack for processing.
> >>>>
> >>>> The reason here is to reduce USB transfers heavily.
> >>>>
> >>>>
> >>>> As you see, it's perfectly possible here to use very large MTU sizes
> >>>> as the aggregation feature by rmnet relies on this.
> >>>> Also the modem can be perfectly configured to send very large aggregated frames.
> >>>>
> >>>> After your patch, wwan0 is limited to 1500 bytes it seems, effectively
> >>>> breaking aggregation.
> >>>>
> >>>> On my tests, download speeds are reduced from >300Mbps to ~.8Mbps
> >>>>
> >>>> I also made a build reverting this patch and all works well again.
> >>>>
> >>>>
> >>>> Is there any other solution to fix this?
> >>>> I guess it should be reverted otherwise :-)
> >>>
> >>> It's weird to be able to set an MTU that is not supported by the hardware.
> >>>
> >>> To restore performance I think the rx_usb_size should be decoupled from MTU max in
> >>> qmi_wwan.
> >>>
> >>> Could you try something like:
> >>>
> >>> diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
> >>> index 3a4985b582cb..6b4796fac692 100644
> >>> --- a/drivers/net/usb/qmi_wwan.c
> >>> +++ b/drivers/net/usb/qmi_wwan.c
> >>> @@ -788,6 +788,8 @@ static int qmi_wwan_bind(struct usbnet *dev, struct usb_interface
> >>> *intf)
> >>>                   usbnet_get_ethernet_addr(dev, cdc_ether->iMACAddress);
> >>>           }
> >>>
> >>> +       dev->rx_urb_size = 32768;
> >>> +
> >>
> >> So far userspace tools (e.g. also the most important one which is
> >> ModemManager) rely on changing the rx_urb_size by changing the MTU: I
> >> know this is ugly, but it is a behavior that has been there since a
> >> lot of time, not sure how many tools based on this assumption could
> >> break.
> >>
> >> There's also the chance that there are modems which require a higher
> >> rx_urb_size, so having this fixed could not work well.
> >>
> >> Unfortunately usbnet serves many drivers, I agree with Koen that a
> >> revert is the safest option.
> >
> > And there is no intermediate driver (qmi_wwan or rmnet) that can define a max_mtu higher
> > than that defined by usbnet?
>
> Perhaps we can remove the change from usbnet and move it to the device bind function?
>
> diff --git a/drivers/net/usb/cdc_ether.c b/drivers/net/usb/cdc_ether.c
> index a032c1ded406..836915e4abad 100644
> --- a/drivers/net/usb/cdc_ether.c
> +++ b/drivers/net/usb/cdc_ether.c
> @@ -235,6 +235,8 @@ int usbnet_generic_cdc_bind(struct usbnet *dev, struct usb_interface
> *intf)
>
>         if (header.usb_cdc_ether_desc && info->ether->wMaxSegmentSize) {
>                 dev->hard_mtu = le16_to_cpu(info->ether->wMaxSegmentSize);
> +               if (dev->net->max_mtu > (dev->hard_mtu - dev->net->hard_header_len))
> +                       dev->net->max_mtu = dev->hard_mtu - dev->net->hard_header_len;
>                 /* because of Zaurus, we may be ignoring the host
>                  * side link address we were given.
>                  */
> diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
> index ed86ba87ca4e..295c3614878b 100644
> --- a/drivers/net/usb/usbnet.c
> +++ b/drivers/net/usb/usbnet.c
> @@ -1829,11 +1829,9 @@ usbnet_probe(struct usb_interface *udev, const struct usb_device_id
> *prod)
>                 if ((dev->driver_info->flags & FLAG_NOARP) != 0)
>                         net->flags |= IFF_NOARP;
>
> -               if (net->max_mtu > (dev->hard_mtu - net->hard_header_len))
> -                       net->max_mtu = dev->hard_mtu - net->hard_header_len;
> -
> -               if (net->mtu > net->max_mtu)
> -                       net->mtu = net->max_mtu;
> +               /* maybe the remote can't receive an Ethernet MTU */
> +               if (net->mtu > (dev->hard_mtu - net->hard_header_len))
> +                       net->mtu = dev->hard_mtu - net->hard_header_len;
>
>         } else if (!info->in || !info->out)
>                 status = usbnet_get_endpoints(dev, udev);
>
> An other solution would be to add a FLAG_NOMAXMTU in qmi_wwan driver_info->flags to
> disable the setting of max_mtu in usbnet_probe() to keep the change generic and qmi_wwan
> the exception.
>

Both solutions look good to me.

If you think that your change provides benefit to other usbnet users,
then keeping qmi_wwan the exception is probably better.

Thanks,
Daniele

> Thanks,
> Laurent
>

