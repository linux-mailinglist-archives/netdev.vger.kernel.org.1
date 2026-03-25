Return-Path: <netdev+bounces-271659-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eExfLAQVxGmfwAQAu9opvQ
	(envelope-from <netdev+bounces-271659-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 18:01:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC9C32983D
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 18:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6A7583074DE4
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 16:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0269E3F9F22;
	Wed, 25 Mar 2026 16:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZK19vgAS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED553F7E60;
	Wed, 25 Mar 2026 16:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774457068; cv=none; b=HqGpeIphD1NAfFeddPtjMuwgXUJ1sCw6JN7bW/nfBlst3Fwn4JjNMzpYWPnUjb4UU41cPADz6xoYRKqnbgkZWF7pv/85F0hb+7pIQIMAHPBS0hGFr+Dry6Q45AVL5thWtqisRS8MtSxzENe2x1p0TgNnzwSqsbw2m9qBmorfbjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774457068; c=relaxed/simple;
	bh=p1acyll1bR0nEEnbxjVK4uNTIZyXUWRjCnNxTq33pMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AFveNHu2kN/1q8mZnpBtX+tRsr/j2SSzxN77eA24yqJnthJmU9egH3tE7vRWtfuNQbGiHEww3E9JD7UVCKahJYpbtH9ajX5jckIp8GlsTy2M+YBlW4fkBOFZbniSMnXhFjx40zuRvoYGURvMkcqFvRudhKuWmqtf+aXXbgwDpxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZK19vgAS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8356C4CEF7;
	Wed, 25 Mar 2026 16:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774457068;
	bh=p1acyll1bR0nEEnbxjVK4uNTIZyXUWRjCnNxTq33pMI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZK19vgAS8miXRfQna05EA3PaFDTJrgsk7EjO5enW3EhW4qxu32QMfiaMf3cUr00hC
	 PXI7/tlscjxS4LueKgf/KVTiU/K7P+yKlSV4AKLbt1A/MmatmYXgG7b+hH2boSsX9H
	 7cM48XUdYr/ckGy8a+eCRDyeyMaT0jA2j4yScaTRNkfdaqZmm46E12JmAzxvfNbvAZ
	 PpfmOshQSFHjsrmTXq/2WU3Ln486qFBW7WCzlNd/okXE0xltCsmZ6i8oS3H57ia9RT
	 qk3n+OsRGzWpGmwmJa/oek1yAd/sQzV4UaLcWE2iFfLgamCPyTTxKwI5vvoiAfatbv
	 2prasgiCofRFg==
Date: Wed, 25 Mar 2026 16:44:24 +0000
From: Simon Horman <horms@kernel.org>
To: Chih Kai Hsu <hsu.chih.kai@realtek.com>
Cc: nic_swsd <nic_swsd@realtek.com>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"bjorn@mork.no" <bjorn@mork.no>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>
Subject: Re: [PATCH net-next v3 1/2] r8152: add helper functions for PLA/USB
 OCP registers
Message-ID: <20260325164424.GG111839@horms.kernel.org>
References: <20260323082226.2601-451-nic_swsd@realtek.com>
 <20260324180532.261099-1-horms@kernel.org>
 <9be8e74588604d9d9f5c10d33c6881e3@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9be8e74588604d9d9f5c10d33c6881e3@realtek.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-271659-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.dev:url,horms.kernel.org:mid]
X-Rspamd-Queue-Id: ABC9C32983D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 25, 2026 at 03:35:24AM +0000, Chih Kai Hsu wrote:
> On 25/03/26 2:06 am, Simon Horman wrote:
> > 
> > This is an AI-generated review of your patch. The human sending this email has
> > considered the AI review valid, or at least plausible.
> > 
> > For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
> > ---
> > r8152: add helper functions for PLA/USB OCP registers
> > 
> > This commit introduces new helper functions (ocp_dword_w0w1,
> > ocp_word_w0w1, ocp_byte_w0w1, and their _clr_bits/_set_bits variants) to
> > simplify bitwise operations on PLA/USB OCP registers throughout the
> > r8152 driver.
> > 
> > > diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c index
> > > 3b6d4252d34c..ba6dc4dbfd80 100644
> > > --- a/drivers/net/usb/r8152.c
> > > +++ b/drivers/net/usb/r8152.c
> > 
> > [ ... ]
> > 
> > > @@ -3875,35 +3873,30 @@ static void r8153c_ups_en(struct r8152 *tp,
> > > bool enable)
> > >
> > >  static void r8156_ups_en(struct r8152 *tp, bool enable)  {
> > > -     u32 ocp_data = ocp_read_byte(tp, MCU_TYPE_USB,
> > USB_POWER_CUT);
> > > -
> > >       if (enable) {
> > >               r8156_ups_flags(tp);
> > >
> > > -             ocp_data |= UPS_EN | USP_PREWAKE | PHASE2_EN;
> > > -             ocp_write_byte(tp, MCU_TYPE_USB, USB_POWER_CUT,
> > ocp_data);
> > > +             ocp_byte_set_bits(tp, MCU_TYPE_USB, USB_POWER_CUT,
> > > +                               UPS_EN | USP_PREWAKE |
> > PHASE2_EN);
> > >
> > > -             ocp_data = ocp_read_byte(tp, MCU_TYPE_USB,
> > USB_MISC_2);
> > > -             ocp_data |= UPS_FORCE_PWR_DOWN;
> > > -             ocp_write_byte(tp, MCU_TYPE_USB, USB_MISC_2,
> > ocp_data);
> > > +             ocp_byte_set_bits(tp, MCU_TYPE_USB, USB_MISC_2,
> > > +                               UPS_FORCE_PWR_DOWN);
> > >
> > >               switch (tp->version) {
> > >               case RTL_VER_13:
> > >               case RTL_VER_15:
> > > -                     ocp_data = ocp_read_word(tp, MCU_TYPE_USB,
> > USB_UPHY_XTAL);
> > > -                     ocp_data &= ~OOBS_POLLING;
> > > -                     ocp_write_byte(tp, MCU_TYPE_USB,
> > USB_UPHY_XTAL, ocp_data);
> > > +                     ocp_word_clr_bits(tp, MCU_TYPE_USB,
> > USB_UPHY_XTAL,
> > > +                                       OOBS_POLLING);
> >                               ^^^^
> > 
> > Does this actually change the hardware behavior for RTL_VER_13 and
> > RTL_VER_15?
> > 
> > The old code read a 16-bit word with ocp_read_word() to get OOBS_POLLING
> > (BIT(8)), then cleared BIT(8) in the local variable, but wrote it back using
> > ocp_write_byte(). Since ocp_write_byte() masks the data with 0xff, the write
> > operation would only touch the low 8 bits and never actually clear BIT(8) in
> > the hardware register. This made the old code effectively a no-op for clearing
> > OOBS_POLLING.
> > 
> > The new code uses ocp_word_clr_bits() which calls ocp_word_w0w1(), and
> > that performs a proper 16-bit read-modify-write cycle with ocp_write_word().
> > This means BIT(8) will now actually be cleared in the hardware.
> > 
> The OOBS_POLLING (BIT(8)) must be cleared in the USB_UPHY_XTAL register.
> The old code using ocp_write_byte() is wrong.

I expect the best way forward here is to submit a fix for (only) that
problem to net-next.

> 
> > While this looks like it fixes a latent bug where OOBS_POLLING was never
> > being cleared, the commit message describes this as pure refactoring to
> > simplify the code with no mention of a behavioral change.
> > 
> I will mention this fix in the v4 commit message.
> 
> Thanks for your review.
> 
> Best Regards,
> Chih-Kai

