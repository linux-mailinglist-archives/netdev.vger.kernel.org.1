Return-Path: <netdev+bounces-266233-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oGROAsVFsGnFhgIAu9opvQ
	(envelope-from <netdev+bounces-266233-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 17:24:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D89254A9B
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 17:24:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 61DA331DF62C
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 15:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E9040DFB3;
	Tue, 10 Mar 2026 15:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="fEPH/Uyu"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AE0327BFA;
	Tue, 10 Mar 2026 15:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773157938; cv=none; b=piAk3/EqfWFnD87WaoMl8Hq6UCC2/3okTCud+THg9jgjBmfXKJl2L1PP4P8O044wvWBDGdu8vWXhtKWrJnW0CFxZJ+KdcaWZGLmdjAwr1uNUk1kRHCOx/93frMfzp+pRs2P1CQ0qYfS8UaX5sY/eqiT2eFIgvPy06N0/+e06kd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773157938; c=relaxed/simple;
	bh=nPSOw4Lmnu+4vxpqa4s1Zh62JgzepqmnWq3Dn4hj1CI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=npjYO5af4nuVuNgJyOQ1PBEn0MNYe/VsPdnAhF/fK47cKSGS0vZlfR97OA7gGGVeZ0QUPbMnh0fo3rVOldS2GuvX5QvzXwjnd+z8XmjZxWENKDyJgK1u6oZQDzn2KqUkonGE6y9FWWmarWaM0T7iJShhPc1PsZAgzy7qgdAHFLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=fEPH/Uyu; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Mm5ZdlYa6HH91EKrqW/ftb9Mw44uy3yVXV+QGoBnUFQ=; b=fEPH/UyuwAtwpUkLnoj4GRMGvZ
	M0NExu5BDlW78HxiHgnS6hzN2FIsPt2yVPHbq7DzXhu2HDaYjUZ8NPI+ryDbdGFFF5RK25xq1+QPH
	BCfDe8TufhVv+CI048L+CYVlsgyu6ED2AviVUtqOWHFux13XuYbf/L2MGeF1PrZOrVsQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vzzNN-00B39f-CK; Tue, 10 Mar 2026 16:52:05 +0100
Date: Tue, 10 Mar 2026 16:52:05 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
Cc: hkallweit1@gmail.com, ojeda@kernel.org, linux@armlinux.org.uk,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next] net: phy: rust: add experimental Davicom
 PHY driver
Message-ID: <917edd8c-cda0-4d35-8300-47205a975a81@lunn.ch>
References: <20260310151935.33197-1-muchamadcoirulanwar@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310151935.33197-1-muchamadcoirulanwar@gmail.com>
X-Rspamd-Queue-Id: 74D89254A9B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266233-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,armlinux.org.uk,davemloft.net,google.com,redhat.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,lunn.ch:dkim,lunn.ch:mid]
X-Rspamd-Action: no action

On Tue, Mar 10, 2026 at 10:19:35PM +0700, Muchamad Coirul Anwar wrote:
> This is an experimental Rust port of the legacy Davicom PHY driver
> (davicom.c) to explore the boundaries of the current PHY abstractions.
> 
> During the porting process, a few limitations in the current
> `net::phy::Driver` trait were observed:
> 1. Callbacks for `config_init`, `config_intr`, and `handle_interrupt`
>    are not yet exposed.
> 2. `bindings::genphy_config_aneg` is not yet wrapped.
> 
> In this RFC, the logic for these missing callbacks is implemented
> and marked with `#[allow(dead_code)]` to demonstrate the required
> hardware logic. Additionally, `unsafe` blocks are used as a temporary
> workaround for `genphy_config_aneg` and interface checking.
> 
> Note: I don't have access to the physical Davicom hardware.
> This patch is compile-tested and verified via QEMU only. It is
> submitted as an RFC to share findings regarding the missing
> abstractions and gather feedback on the Rust PHY usage.

How good is the QEMU emulation of this PHY? What features does it
support, compared to the real thing?

Adding support for interrupts to the Rust API seems useful, but does
the QEMU emulator support it? What emulated board are you using with
this PHY? Does that board have interrupts wired up? Can you triggering
interrupts by changing the link state?

> +/// Register 0x10: Scrambler Control Register (SCR)
> +const SCR: C22 = C22::vendor_specific::<0x10>();
> +const SCR_INIT: u16 = 0x0610;
> +const SCR_RMII: u16 = 0x0100;

Does QEMU have the scrambler? What happens if you wrongly configure
the scrambler.

> +/// Configures PHY Auto-Negotiation.
> +///
> +/// Isolates the PHY during configuration, then calls the generic `genphy_config_aneg`
> +/// via unsafe C bindings because Rust abstractions don't expose it directly yet.
> +fn dm9161_config_aneg(dev: &mut phy::Device) -> Result {
> +    dev.write(C22::BMCR, bindings::BMCR_ISOLATE as u16)?;

What does the emulation do if you don't isolate the PHY? Is there an
errata for this PHY which tells you why it needs isolating?

I don't want to add code which cannot be tested. Ideally, it should be
tested on real hardware. We also are pushing back on duplicate C and
Rust. So if you want to write a Rust PHY driver, i suggest you find
some hardware which does not have a C driver, and add support for it
using Rust. Then i would be happy to expand the Rust binding as
needed.

    Andrew

---
pw-bot: cr

