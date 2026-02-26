Return-Path: <netdev+bounces-261230-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKhjN98DoGl/fQQAu9opvQ
	(envelope-from <netdev+bounces-261230-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 09:27:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C5F1A286D
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 09:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F0673047E70
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 08:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F57B38F230;
	Thu, 26 Feb 2026 08:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UbdKFfrR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231AB2AE68
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 08:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772094387; cv=pass; b=kwg7pEZy5iMpbz+CVcXRLMqt+bUh9OHfwWQBn3cx9OJ9T0TVT8Ls8fx2Ko8IRZgMVAI080t54KVdPjphmPKMRIpP5TnsbdeRkuxVq9Qy/Cz4IiC060i5/hT212I4auVFSbm2hfO6Nz7wcmqFXYOyocdKvGDfSPC7G9gx9Othzbw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772094387; c=relaxed/simple;
	bh=dSbRnTtbphPH/CVU76suyGb8H6esoTis5rJLM+HBS2k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dIjdiGW6qBoYR75bNzUgwiBWM8FYuM8YpoA+j1wEEFxTgYhyprwJwRilxk99Ron3fcCd7wCJzw8QekK5vuFsx6Kir8a3wqm4MugT9n60iU07aRLg1bbJDY6TZ7kHc91OMwWND5vSfqmlinpf8vCI4rk6Uah0O444Q97B9CB5QPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UbdKFfrR; arc=pass smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43767807da6so359141f8f.2
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 00:26:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772094384; cv=none;
        d=google.com; s=arc-20240605;
        b=kHHjef7C6Ve0hUfHtQLOT9WF9HR/uwAJXGJbEt+eyoNyKLL4WvFPgvrjKlgGmVjNqR
         VgqirjtU5z5LY5qF7NLlYGZ0fBDyC5DkzB+msDutO3+zcVHFD8giz4kd1CNfkFK6qj/i
         DPR21PBAUZ17MPl60SSWs3kifrCmYhidLwMVXdTw9L58XMrpVSOWNFtfgjAeUm38En/N
         DV8fKsD0o9qbm6CjKutBEIaj6kW/E8oyQTohU7OrVahIaBnIJMsxvUjc5SxXO+RnxDA0
         Xbe8hNGZ60NVnvjc5J2ZW5agQGBrdFwrdmziyZfP9z2/1xlnC7U9EAKzuc6X8QQB4673
         +fxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=p8tFDUI/IrHDdHe0oMgvftUeNiQenULG77NWOiabLck=;
        fh=q9arsb+XP23/FtlzKx4t+g1QYtxhNYaoy3MbapfGAPg=;
        b=FfiPSqEIb6oM+NgY6cZvU65KAaHS/M8slxHSDzgt/n8otpTlYQxn/HRtOPFUxhMpBX
         4CjoF4bVzN+xlJFeZ9GRYamDC1SlJmjNNq5NQc4FKeuemZIGtqASbu8fSeH7TOibU7PL
         lAOOa7RCfoiuqDd3aZp3NZu6jCaunJgKpgOd9VXmYKEwcO29yaO6W7MzEWRUM9U0g4UL
         CEzmLjQiFY36fcWEN92WVJlEGKdOdam+dGQNm4syDoDjLJPCoQpgnTTq/SnUVs4bBMC7
         wYcbLRI6wKgnOzXoYLE/gWAIt0LWaXusY4wD0xqlQoh31F/juahaFZeAbzah2/0PzoMz
         Ueag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772094384; x=1772699184; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=p8tFDUI/IrHDdHe0oMgvftUeNiQenULG77NWOiabLck=;
        b=UbdKFfrRIuoE+NPjCjrp3b5Fi5iZjQrTqUSSVbgIjGRHmU5cJy6Ik9z2Ejq2qk6uYX
         znU/JPq2+5E40iQUH1MvGEixQ0nnbAgXtNJ+eo5ayxRgw1EBZob6C6V0cQNLhlhTLKgZ
         Thf1L6WQHkbyvSNxVN3fhAX3gcICxzO+ME1+0uXBwjz/+GehBBAqwlF8OLay9Bz1YK/T
         VznmC4xf9ZZkfa4dpnaIGlwQxuxq4bjzTM8IwzxxeNYPXK1alIjpRrENTkTOJ2kDuL8M
         OPU2I//+xuXnHL2aUBjBB05I9YIPA39n6i6D1YwBsr7FhZCTgIIWOxNqZg/2jKSRMdeI
         L1Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772094384; x=1772699184;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p8tFDUI/IrHDdHe0oMgvftUeNiQenULG77NWOiabLck=;
        b=MpUuZ4TwD8mDJ/0ch0e4dxLwSn9xiWUZjbaIBH1W1Ld/mC1cjIKp4jX0jQ8YB4SuDS
         Jj1cUWJev4+oC0Wood6YYjhOIU78wo/crMvC85tYWpavov7KIGW6XGipAAW00NeVWnTn
         oEe0rALZMxbBAVQ13d91k9+mNUEYDwIV2fNc3AsEg06gWJPGmeojlsGC72427Kkluff2
         Vnc7GF3mCCDR5S2KNg/+abNdft4AMPWJ+d2t4d751SYQplzzzSYpu3pE825abJhTIV7x
         o4GIpOtpnNINGAqsnqcz2ic5DMozpemBE8/0a+G8Myw2qqXCG4mNcfcMv8eaeit3iNr5
         GT8A==
X-Forwarded-Encrypted: i=1; AJvYcCUehGyr0gwAiU1AYG+q0y1jN4lIPvmDgdVOczmRzK/+ISbPkAvfYNOYiFUrAzw6MojrFZAElYc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwWhRQZWGqXIRNu0WqUSw6TuUNdg1WuFunJKnYTCrxiA9xxa+G
	cMWDMQFdeUQM1perPFdl/ies5dUQCzrFLVv8ahW7X4zv0Og5VDuXWJmx3BLzhfLvKOCAYExlcxE
	erc0DWNR5b8wH/c65Npk2cT7Yrbf+aG4=
X-Gm-Gg: ATEYQzyeRv7QROd+Z057knbbO0DEwZgXLFLYHC16JXs2bu8F1xFITPVoa67kmdy8qrS
	4GwfY5jKr76rXgrcuJMHVpbbFMczbu2K/4RotcMTcz2MrmhtbdhNwcRwCHDz+zlf62Xp7wXEzJS
	GovcJwrv77Zo+9wUGZN+dq7mx8xMzXXvneVFOJtddVnUlXokuu+CVAU1Nm1kRXC17lvuVTdTWDf
	g8Y+bBCi29MM1qS0mEVts7DvIyLgLeyuwB13wyLz59DGnUSbDdfbrBZSW9SO8/CrQayJ7DRxIue
	rAkR6ILvxaQALcqR5g==
X-Received: by 2002:a05:6000:1a8c:b0:439:9124:f2b7 with SMTP id
 ffacd0b85a97d-43997f341bemr2365098f8f.29.1772094384270; Thu, 26 Feb 2026
 00:26:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPh3n803k8JcBPV5qEzUB-oKzWkAs-D5CU7z=Vd_nLRCr5ZqQg@mail.gmail.com>
 <95ccf5a6-975b-4543-80a3-595f1ee20543@redhat.com> <CAGRyCJE85fLOahUR3PAUnS_jH4+qpBq37qpged=nvObbg1m+Qw@mail.gmail.com>
 <20260225170155.0ae83ae9@kernel.org>
In-Reply-To: <20260225170155.0ae83ae9@kernel.org>
From: Daniele Palmas <dnlplm@gmail.com>
Date: Thu, 26 Feb 2026 09:26:11 +0100
X-Gm-Features: AaiRm50DmBPE8bIbQbuDkJOR9inJwsjkwvr1SpWPBNCMnCqpiSUe-nkgxF4o3fM
Message-ID: <CAGRyCJGYLemYFDNw8cfcCHoxe8YqfRRgnJXgz03WVssKDYXhUA@mail.gmail.com>
Subject: Re: commit 662dc80a5e86 breaks rmnet over usb
To: Jakub Kicinski <kuba@kernel.org>
Cc: Laurent Vivier <lvivier@redhat.com>, Koen Vandeputte <koen.vandeputte@citymesh.com>, oneukum@suse.com, 
	andrew+netdev@lunn.ch, Eric Dumazet <edumazet@google.com>, pabeni@redhat.com, 
	netdev <netdev@vger.kernel.org>, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261230-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dnlplm@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 39C5F1A286D
X-Rspamd-Action: no action

Hello Jakub,

Il giorno gio 26 feb 2026 alle ore 02:01 Jakub Kicinski
<kuba@kernel.org> ha scritto:
>
> On Wed, 25 Feb 2026 08:19:46 +0100 Daniele Palmas wrote:
> > > Could you try something like:
> > >
> > > diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
> > > index 3a4985b582cb..6b4796fac692 100644
> > > --- a/drivers/net/usb/qmi_wwan.c
> > > +++ b/drivers/net/usb/qmi_wwan.c
> > > @@ -788,6 +788,8 @@ static int qmi_wwan_bind(struct usbnet *dev, struct usb_interface *intf)
> > >                  usbnet_get_ethernet_addr(dev, cdc_ether->iMACAddress);
> > >          }
> > >
> > > +       dev->rx_urb_size = 32768;
> > > +
> >
> > So far userspace tools (e.g. also the most important one which is
> > ModemManager) rely on changing the rx_urb_size by changing the MTU: I
> > know this is ugly, but it is a behavior that has been there since a
> > lot of time, not sure how many tools based on this assumption could
> > break.
>
> What's the policy in ModemManager to change the rx_urb_size?
> Increase it to make sure it can hold some specific cmd / packet?
>
> I wonder if having rx_urb_size max of (mtu, 32k) would break anything.
>

Typically the host sends a QMI request to the modem for setting the
size of the maximum QMAP aggregated packets block. Then the modem
replies with the maximum size it supports and that one is then set by
the host through changing the MTU of the netdevice. Low-cat modems
usually support 4-8 KB, while 5G 16-32KB.

On ModemManager side this is currently fixed at 16KB, but one can use
other tools e.g. qmicli to set custom values as far as they are
supported by the modem.

> Since we're talking about rx buffer config the right API to configure
> it is likely ethtool -G rx-buf-len :(
>

Thanks for the hint, I'll try to have a look at that to improve qmi_wwan.

> > There's also the chance that there are modems which require a higher
> > rx_urb_size, so having this fixed could not work well.
> >
> > Unfortunately usbnet serves many drivers, I agree with Koen that a
> > revert is the safest option.
>
> Then again the usbnet driver is brittle enough as is, if it's just qmi
> that needs this workaround we would be making common code less robust
> for a benefit of a single "hack" (for lack of a better term)

Makes sense, also Laurent proposed a solution to keep his fix in
usbnet and make qmi_wwan the exception.

Regards,
Daniele

