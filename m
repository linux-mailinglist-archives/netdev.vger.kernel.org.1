Return-Path: <netdev+bounces-261109-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MLRQJaWbn2mucwQAu9opvQ
	(envelope-from <netdev+bounces-261109-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 02:02:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 123B019FB32
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 02:02:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B8103038148
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 01:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE6B2D77FF;
	Thu, 26 Feb 2026 01:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X0btu3bc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468FA27FB37;
	Thu, 26 Feb 2026 01:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772067717; cv=none; b=EZfLc85zJghU324/o1Wz3Sk9dupPKWl+mNaV0A2QcNOjA0Tz+YHa82iOtrNEV+6vC4Ai37zD05fywlHQ1JHi4NXNYci/MHTEZeY4zoAD8PcdWtMGQwRVwN4nqYVfdssCPxhZlPkW/0ncEzQ9Em/swoO0pI8x6KkgjDVxuswlPZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772067717; c=relaxed/simple;
	bh=oB228p0BQr3mdBj41NSgv8fiVLBopb401P2liBaWaHk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OXarfpvCDZUOjcVhCFxtI6XAeNNR0XBMvqm8G6uBl8CV59wHMJ3BfKsj1Qiy3DorFxwnHHrQ0tcJTHfj3llEdJLVoXhbC4yxDElLyPIudav6bPM6FWdd4RNvTMfBzcWZ8xD64KPCZDesZIoGd24Pausl4FjkULGI/SXmoOUhdu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X0btu3bc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A65D6C4AF09;
	Thu, 26 Feb 2026 01:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772067717;
	bh=oB228p0BQr3mdBj41NSgv8fiVLBopb401P2liBaWaHk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=X0btu3bcn1UEmgBxv4I24illLT5FQsCs3pDlve2DE8im51JMQlLjuwWkBp71Bckuq
	 zOOgQCBjwrdRQRV4UQ5nooj3i3tc+ovdvVShCc8wlpRlxz9J27Qn5adNKdxmT/N6xB
	 7dSt2OQVf5ktINLtKWz/1E4kPSa3PPjDsLI2NVs4i3vl3ZpEC8t2+QCcEa3Lk4de4B
	 JALvzmtta9H0tQd4vVTNpLM4/22PFKXes+hqu83a3kGwvw5ys5be+D73H/6RTc1DJ8
	 7YvvQUOyEC1iEbKkYPSkO6ATFAZ0WHssD5o/Juawalz4Tj6zPuwPxwoRIIlh86VtXg
	 G5/aZEmtTCC3g==
Date: Wed, 25 Feb 2026 17:01:55 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Daniele Palmas <dnlplm@gmail.com>
Cc: Laurent Vivier <lvivier@redhat.com>, Koen Vandeputte
 <koen.vandeputte@citymesh.com>, oneukum@suse.com, andrew+netdev@lunn.ch,
 Eric Dumazet <edumazet@google.com>, pabeni@redhat.com, netdev
 <netdev@vger.kernel.org>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: commit 662dc80a5e86 breaks rmnet over usb
Message-ID: <20260225170155.0ae83ae9@kernel.org>
In-Reply-To: <CAGRyCJE85fLOahUR3PAUnS_jH4+qpBq37qpged=nvObbg1m+Qw@mail.gmail.com>
References: <CAPh3n803k8JcBPV5qEzUB-oKzWkAs-D5CU7z=Vd_nLRCr5ZqQg@mail.gmail.com>
	<95ccf5a6-975b-4543-80a3-595f1ee20543@redhat.com>
	<CAGRyCJE85fLOahUR3PAUnS_jH4+qpBq37qpged=nvObbg1m+Qw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261109-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 123B019FB32
X-Rspamd-Action: no action

On Wed, 25 Feb 2026 08:19:46 +0100 Daniele Palmas wrote:
> > Could you try something like:
> >
> > diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
> > index 3a4985b582cb..6b4796fac692 100644
> > --- a/drivers/net/usb/qmi_wwan.c
> > +++ b/drivers/net/usb/qmi_wwan.c
> > @@ -788,6 +788,8 @@ static int qmi_wwan_bind(struct usbnet *dev, struct usb_interface *intf)
> >                  usbnet_get_ethernet_addr(dev, cdc_ether->iMACAddress);
> >          }
> >
> > +       dev->rx_urb_size = 32768;
> > +  
> 
> So far userspace tools (e.g. also the most important one which is
> ModemManager) rely on changing the rx_urb_size by changing the MTU: I
> know this is ugly, but it is a behavior that has been there since a
> lot of time, not sure how many tools based on this assumption could
> break.

What's the policy in ModemManager to change the rx_urb_size?
Increase it to make sure it can hold some specific cmd / packet?

I wonder if having rx_urb_size max of (mtu, 32k) would break anything.

Since we're talking about rx buffer config the right API to configure
it is likely ethtool -G rx-buf-len :(

> There's also the chance that there are modems which require a higher
> rx_urb_size, so having this fixed could not work well.
> 
> Unfortunately usbnet serves many drivers, I agree with Koen that a
> revert is the safest option.

Then again the usbnet driver is brittle enough as is, if it's just qmi
that needs this workaround we would be making common code less robust
for a benefit of a single "hack" (for lack of a better term)

