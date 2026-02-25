Return-Path: <netdev+bounces-260784-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OH23Kd2mnmmrWgQAu9opvQ
	(envelope-from <netdev+bounces-260784-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 08:38:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B190193908
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 08:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A8A6530131E9
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 07:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD462F7478;
	Wed, 25 Feb 2026 07:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PUG0fwgp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A352E0938
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 07:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772004977; cv=pass; b=Rb8Lxqc0LTTZua0hYe6nOaPQAwSxVu7BHFsu6aCeZXGzsNVVZwmNJRfOuznrVMqO9aOXgavdsoQrdGNsOSOZJnkY6N879WUAgZM/QA6jAXFsh19lP3eABsDJ3oHAEy7Sm3GQJYpwTXQD9lpgjaIfzB3kyJXj3ADriqvomZDlG/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772004977; c=relaxed/simple;
	bh=qPMyRmiQw7pJhER5YKqD7lk1WLwtH8C/KfNioQXmSXY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nMG9O9DrNYRgCrM7hJ15DYTgnEvPbw/IexQTYM5wlg5HMthYM9tAixQvCo/OKYDLi1PTXxC90bR22uEnJl6JQR/UgRDdSKgY3kFcqTsHnlgLiYI/K3p+bM2AWTlmvYTJRiuE32+nwQ/oLEtQOBtKvs/GTGLu/zUgaoIhPOmqXMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PUG0fwgp; arc=pass smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43984d7e49bso1346986f8f.2
        for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 23:36:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772004974; cv=none;
        d=google.com; s=arc-20240605;
        b=Bx/N9XopshQN1VlLONaYujZQLjrqEiEr5vpcdHOBQDtp04TpTLIfOQWaIczIBgIKwK
         H8O7iQ/5i6+GQvQ8P7vq+H0WZormKGtT43FmT1zMOBhmtZ8N2hFz3GPImbW5DBCoQjaV
         QL4Xg6TvxZb+Oi8xN6C5DaYziUs1ZlOf3TfPNrqKwUFMBaUzZUGWZXaRK81qpwBFoabM
         54NjLgIlctLXKNo4xMl3xn3oUCySeXUe9JdA6i1TrsTv0EgLRHH8UFiZuAH9x4Qxv2hD
         QBXaiLanwdPOq+lHt/n//L+YJJHGWObf4hON0cn1JGpCMSG0Qa1VCWRKGWaqXUyYmbWC
         RMNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=cPsEREjpbbRl+Ykcb3p5rXFShnBdQuEGwwIZOOJ5aCo=;
        fh=FmPeW7fpm18BmxHH5bTwO42lg9wwF+kG4Ilj8tqK4QA=;
        b=TNusb4Jz60bacsQI/1GoB8pQ9UT2VDYKf4wFhr5d5zycubCbAftKgH+RFh2MFQHeBy
         +bzB8U3VkbRRa+wSyuJzI2vauKyVzTTgBvfC0h+yIF4SvALH+cikrxnDBVlRdV2+VWSx
         s1l5E3IB+xfF3JyvFVQmsSp6GgCGmDUMBeigisN2mIoFPygXs4dxVYJBU6Ze04M5pOec
         wJIJOp+RvhQdJXc5qOXErhSlkhCtT+YHGF2364zxKOa933TNn44g0I0jNQYwTdIzKzL8
         SLcnJ0pEk1i49hm2zhO4bDL1jnxdrd2TifhbjeRPsnrblapzTsR9QodgRi7eJRcVlT1T
         EO5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772004974; x=1772609774; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cPsEREjpbbRl+Ykcb3p5rXFShnBdQuEGwwIZOOJ5aCo=;
        b=PUG0fwgplVBzSMC2G2vQcXHqb6X/6eDcrRJdxegwb+lxeVbWESdRNczbsXGyZOA+zD
         ZSM6t/28ah8E7kaHKovf8z1mtBKT7t+GgLFtBx3mUrvbD5U9SarbLPyczDV9611so0uz
         LPoRafj2E4W7HflbslC5IUoim3oNT+ra8ZpkupeAeIl/io25q3akz4y/bb2CFIg8EqCR
         Y3De+1SMPE6MfKtTKxNs6VwRjDBVsL1GkuETnScJsy0H/i1cQSQoqfZ4Wsve52nPb7EO
         VEn5vrlI/yy+ylH+mEFm8a2p2omh6i9V14vB1UCwroCPSzUOtryW/RyxV3gNsM30T7T2
         JYDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772004974; x=1772609774;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cPsEREjpbbRl+Ykcb3p5rXFShnBdQuEGwwIZOOJ5aCo=;
        b=pEo6yxg+kcooIFrdfTrai2svOVUcSUjRHV3X3RAXFqN68Tgf6Q/B7DaqaI7HeKgqe/
         DAwmrLElEuMqh9mbNEFzPqVnot+lUMn2gz3ebYCS1pGKPZyh54/Xhk5iQyQFIfpVvJCy
         dlWNuGTgHPLye75/34LDu2LcFnomfy4PudYZqX+f9oLBu1ZnbfpFzWfSfo1DDP0/riSC
         rjqfgYogbEKPTxIIoEbg+SUAF+LiGpIiFFEESFBdnSWTpUq22rMWjvcfBZwOZ++hP6wX
         vQxYMojRIxjPjwhJJGPz6MXOFURMVF26g9LgEyq9kruwDB7/LBfdy4wS5z5VeGkqcwN4
         wKVg==
X-Forwarded-Encrypted: i=1; AJvYcCVJAGDr6USZifOiLttTRKV6CXe5MZ4RnED/YNq+PqYJuqYq+aXMrM2f4rgnEZ/SLkAQfQOywdM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFuVKbeLoOxWth6VgA+rHkzQWreNq4dZcb6LnJwIng7b6DyAiV
	azk9/bzgHunRVgSzCKKjM0GherlRcHmYvSAztCLRJkwx0KSZqqa2mxJOdRb1IMbQ3hhVk3M0iJY
	YoTAVajHHNm+IQY7PibnZUMurIZ5U8jY=
X-Gm-Gg: ATEYQzxvbqwU6EBIXsExL0XSstm96qxNsqlWzTY8pCbGlNjTwCxkZKpdxd1b0+w3zXI
	xvr/wtZ4rTXXiGe0+uQvuhO6i7WIeJMVIWv6xf1khQzfVfgqBhgRev6ROT7/xYnyY5aYW9PZaKV
	KvcnZvMPRwApT7cOObIeha0g0rMyG1pRans+J3pFxP4R/zOSaMKD+a/mY6YoKqHqTL4gHdYTvl1
	Zd2aAbpLUPjVDKkX7cWk9v6zPz0oak1v8mhPMNaRAOs1BuDpITfaxbPRE83dRwqmcUyWvLJKyaF
	CGRnOQm6gFLawUo=
X-Received: by 2002:a05:6000:438a:b0:437:6661:fcc9 with SMTP id
 ffacd0b85a97d-4396f17d264mr27401304f8f.50.1772004973270; Tue, 24 Feb 2026
 23:36:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPh3n803k8JcBPV5qEzUB-oKzWkAs-D5CU7z=Vd_nLRCr5ZqQg@mail.gmail.com>
 <95ccf5a6-975b-4543-80a3-595f1ee20543@redhat.com>
In-Reply-To: <95ccf5a6-975b-4543-80a3-595f1ee20543@redhat.com>
From: Daniele Palmas <dnlplm@gmail.com>
Date: Wed, 25 Feb 2026 08:19:46 +0100
X-Gm-Features: AaiRm53G8wva2-r8k7hpjoD_2UgFtTWerh0eqF47qBCR6-DpITxxvsKCTqNKHBU
Message-ID: <CAGRyCJE85fLOahUR3PAUnS_jH4+qpBq37qpged=nvObbg1m+Qw@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260784-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dnlplm@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 0B190193908
X-Rspamd-Action: no action

Hello,

Il giorno lun 23 feb 2026 alle ore 15:08 Laurent Vivier
<lvivier@redhat.com> ha scritto:
>
> On 2/23/26 13:04, Koen Vandeputte wrote:
> > Hi Laurent,
>
> Hi Koen,
>
> > I'm testing the latest openwrt state and found an issue probably
> > caused by your usb mtu limit patch :-)
> >
> > I'm talking about this one:
> > 662dc80a5e86 ("usbnet: limit max_mtu based on device's hard_mtu")
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=v6.12.74&id=662dc80a5e86b35bbf339e0b87b7cc3f07c09de1
> >
> >
> > When using wwan0 iface normally, this makes sense, but the problem is
> > when using QMI modems combined with the rmnet driver and aggregated
> > frames.
> >
> > - The modem is configured to frame sizes of 16383 or 32767 using QMI
> > - wwan0 (using qmi_wwan) is configured to match this frame size by
> > setting it's MTU to the same value
> > - Frames of this size are sent over to qmi_wwan driver (containing
> > multiple data packets)
> > - Frames are then forwarded to the rmnet driver
> > - Frames get de-aggregated here and sent to the network stack for processing.
> >
> > The reason here is to reduce USB transfers heavily.
> >
> >
> > As you see, it's perfectly possible here to use very large MTU sizes
> > as the aggregation feature by rmnet relies on this.
> > Also the modem can be perfectly configured to send very large aggregated frames.
> >
> > After your patch, wwan0 is limited to 1500 bytes it seems, effectively
> > breaking aggregation.
> >
> > On my tests, download speeds are reduced from >300Mbps to ~.8Mbps
> >
> > I also made a build reverting this patch and all works well again.
> >
> >
> > Is there any other solution to fix this?
> > I guess it should be reverted otherwise :-)
>
> It's weird to be able to set an MTU that is not supported by the hardware.
>
> To restore performance I think the rx_usb_size should be decoupled from MTU max in qmi_wwan.
>
> Could you try something like:
>
> diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
> index 3a4985b582cb..6b4796fac692 100644
> --- a/drivers/net/usb/qmi_wwan.c
> +++ b/drivers/net/usb/qmi_wwan.c
> @@ -788,6 +788,8 @@ static int qmi_wwan_bind(struct usbnet *dev, struct usb_interface *intf)
>                  usbnet_get_ethernet_addr(dev, cdc_ether->iMACAddress);
>          }
>
> +       dev->rx_urb_size = 32768;
> +

So far userspace tools (e.g. also the most important one which is
ModemManager) rely on changing the rx_urb_size by changing the MTU: I
know this is ugly, but it is a behavior that has been there since a
lot of time, not sure how many tools based on this assumption could
break.

There's also the chance that there are modems which require a higher
rx_urb_size, so having this fixed could not work well.

Unfortunately usbnet serves many drivers, I agree with Koen that a
revert is the safest option.

Regards,
Daniele

>          /* claim data interface and set it up */
>          if (info->control != info->data) {
>                  status = usb_driver_claim_interface(driver, info->data, dev);
>
> Thanks,
> Laurent
>
>

