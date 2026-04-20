Return-Path: <netdev+bounces-279872-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cOjOBY9t5mmBwAEAu9opvQ
	(envelope-from <netdev+bounces-279872-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 20:16:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B5888432A1A
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 20:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 140D03272CEA
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 16:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF40374726;
	Mon, 20 Apr 2026 16:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="na9xfB9j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4520A372EF3
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 16:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776703562; cv=none; b=tnMJ8d1HocvZo56rIUX+XwDZbuFBg5i7kdNzNH6074qtm/kZ2ZGQfesH4EKtG5eIVnw6IXF24oZQSvjxRlTIowKjuoYKw7GwzlFxTaa9d0IZxCDMC6Vc4Bp58iZ1A4z3TysS351Qx5uMWOyOR57z0ihf7B/1DxMd5Xbby1ha758=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776703562; c=relaxed/simple;
	bh=8FNY7MbtkgjbsRoI1I6nx/707r+HF/T/RNrqqCg5fjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pG26U/EiAtMy4Jf+LKseM+6aD3R3aA4EWhLLIUAMNEuz8QC7g8r3/inzeYH+OvVJfmsXejt4N8XRrCqab9jZ0fGWulkczvNQuiGC7GgfeLKH2G9NAI6SLu9RUlPn8NiNclZ4Bm9k+C0QIvInlWsTh/18hnEn6HMY+gYlKa7zkag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=na9xfB9j; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43fe62837baso1990932f8f.3
        for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 09:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776703559; x=1777308359; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5E+UKYZ+gXk3KKDw9hC2HFOEQBrHQpFIVrnj4wNYvlY=;
        b=na9xfB9jpuFmJCc52HHYeE622o7SbJJRZ28mr/+yN1E3II021zrVR7B8EIIRf98THp
         dtnJRY6CB4tHq5uVirkx2KSPii/nD1tCAi2KpyHCOfa/46xPwMT2UQo+c1F1JGVRVaBx
         VAUFIeHFEOsOGkZ2B/8rtqByBqX4LCu3cWdyrSfFaYd2ouAgyy2Ho21ulFUy3/cnsa1r
         dWJXBh9V8IXRNxXppP06aDB7rBhVxSuAezrbY2CcWSqVWbmLOHERo9cpvPnNnfCabiS8
         GninTvkORT/UGZEMwE1BYzGEJEg1kmp3Q86ugdQ0L4xBEKK5bW2z/wyBmnz5tDMyuHvP
         7QCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776703559; x=1777308359;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5E+UKYZ+gXk3KKDw9hC2HFOEQBrHQpFIVrnj4wNYvlY=;
        b=hyfJExRn+emc+7JEucRV6QZ7eoDDpUegDSvyF4GGv7hsB027CozwxhK5frbbP3mrLr
         3wmYqtTNWG0OsKoZInSysY11EdTao6HWxDjnU4FAmfJK4Dti/kUWiEf2qABgfWmqspJd
         F9C/qS6K++R86T2N+qcSv4rc1R1dphDgwSDeVBF7seGAZXYySsYIT63tPUbnOZWsfqmV
         PnK2slP3T82tk19BtKM2JB1db9hmllqGFTN0QE6jLwi/OuHisBI6jkTICd7+jZp9Nvyg
         6ut2PH/h5O2Hy7gRjGjIzvTTYOdxyMGqtGWlAcvLd2NR9vNKBGJvtGVCRb4NSuup7a9D
         5yPg==
X-Forwarded-Encrypted: i=1; AFNElJ+nfQ+qyQvUWQJac2ZkOUUWTLNgywQaZmkV7zufeTkI9uraJ1q3ax1Vz0IHrm/90DHz9Rx1qwk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbXiPsnJq2sNYnze1IUIKSvjlddzwwqedkdS4LeyLv/Cp7BHc+
	knnYPTxH7aUJCtQ1WWUs4lSRE2zqgsiNfrda5EDliNrK8OzO9h1DploI
X-Gm-Gg: AeBDieteptJ8bIWrVm08mWYD9Ga97CXlMy19Ett1dFG7ARL3ChRMXhnEZXyheB1B5f7
	WaVcz1XasanCIXJnVVM/NHLWwvqBrF5CV/X11isLZjQicF/CqsHeLa7Sb1E+lRGG/RQeOpfeRyP
	i23pWwSmeybuTNQPZ8l++atu0vvoDlEgzJvhA2Ob6wg3++Y5f4IvFEC0yp/htGEQ4EX2PfFcnk2
	BOPj4r0sssglGWG0BmTQyLEohSWUOqARzTj8XcD7HmjR65wbfWDDR+n98yP2Js69tW2+7NCc+kT
	empNl8U5WoXta27IvXzzG15XUZOWrCYA2HlE0YPfEs9NHXMaOhgcoaEps30K6w7JttsUaDWOZLq
	pSjRNPfx/f98I9hF88SarAX0ce4YdDXoxWEaWU9f/lGWmxTr5rUKYrpApwV45H0hrATxT30XaXx
	MSY8q7bDac4ncvP5hYJ6VMJ8TbNXcFgVohurSi02/G
X-Received: by 2002:a5d:588f:0:b0:43d:2be:e54 with SMTP id ffacd0b85a97d-43fe3dfd4aemr21673354f8f.39.1776703558306;
        Mon, 20 Apr 2026 09:45:58 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e3a79esm32560450f8f.17.2026.04.20.09.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 09:45:57 -0700 (PDT)
Date: Mon, 20 Apr 2026 19:45:54 +0300
From: Dan Carpenter <error27@gmail.com>
To: Jared Kangas <jkangas@redhat.com>
Cc: Chester Lin <chester62515@gmail.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
	NXP S32 Linux Team <s32@nxp.com>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linaro-s32@linaro.org, netdev@vger.kernel.org
Subject: Re: [PATCH v6 3/3] dts: s32g: Add GPR syscon region
Message-ID: <aeZYQp9b5aoV7Ihv@stanley.mountain>
References: <cover.1769764941.git.dan.carpenter@linaro.org>
 <0e922537c02d1c47734142090f98eb78e921ed34.1769764941.git.dan.carpenter@linaro.org>
 <aeKn2dvOOO43zdev@jkangas-thinkpadp1gen3.rmtuswa.csb>
 <aeZOcCOgMy2g9wqp@rh-jkangas-kernel>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeZOcCOgMy2g9wqp@rh-jkangas-kernel>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279872-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,suse.com,oss.nxp.com,nxp.com,pengutronix.de,kernel.org,lists.infradead.org,lists.linux.dev,vger.kernel.org,linaro.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[error27@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[400a4000:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linaro.org:email,64.7.192.0:email,4033c000:email]
X-Rspamd-Queue-Id: B5888432A1A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 20, 2026 at 09:04:00AM -0700, Jared Kangas wrote:
> Fixing Dan's address based on mailmap update, sorry for the noise.
> 
> On Fri, Apr 17, 2026 at 02:36:25PM -0700, Jared Kangas wrote:
> > Hi Dan,
> > 
> > On Fri, Jan 30, 2026 at 04:19:52PM +0300, Dan Carpenter wrote:
> > > Add the GPR syscon region for the s32 chipset.
> > > 
> > > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > > ---
> > >
> > > [snip]
> > >
> > > diff --git a/arch/arm64/boot/dts/freescale/s32g3.dtsi b/arch/arm64/boot/dts/freescale/s32g3.dtsi
> > > index e314f3c7d61d..be03db737384 100644
> > > --- a/arch/arm64/boot/dts/freescale/s32g3.dtsi
> > > +++ b/arch/arm64/boot/dts/freescale/s32g3.dtsi
> > > @@ -383,6 +383,11 @@ usdhc0-200mhz-grp4 {
> > >  			};
> > >  		};
> > >  
> > > +		gpr: syscon@4007c000 {
> > > +			compatible = "nxp,s32g3-gpr", "syscon";
> > > +			reg = <0x4007c000 0x3000>;
> > > +		};
> > > +
> > >  		ocotp: nvmem@400a4000 {
> > >  			compatible = "nxp,s32g3-ocotp", "nxp,s32g2-ocotp";
> > >  			reg = <0x400a4000 0x400>;
> > > @@ -808,6 +813,7 @@ gmac0: ethernet@4033c000 {
> > >  			compatible = "nxp,s32g2-dwmac";
> > >  			reg = <0x4033c000 0x2000>, /* gmac IP */
> > >  			      <0x4007c004 0x4>;    /* GMAC_0_CTRL_STS */
> > > +			nxp,phy-sel = <&gpr 0x4>;
> > >  			interrupt-parent = <&gic>;
> > >  			interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
> > >  			interrupt-names = "macirq";
> > 
> > I gave this a test on an S32G-VNP-RDB3 and didn't see any issues on the
> > dwmac-s32 side, but this appears to trigger a panic when reading the new
> > debugfs regmap/*/registers file for the syscon node:
> > 
> >     # grep 4007c000 /proc/vmallocinfo
> >     0xffff800083da8000-0xffff800083dac000   16384 ioremap_prot+0x74/0xe0 phys=0x000000004007c000 ioremap
> >     # cat /sys/kernel/debug/regmap/dummy-syscon@0x000000004007c000/registers
> >     Internal error: synchronous external abort: 0000000096000210 [#1]  SMP
> >     [...]
> >     CPU: 0 UID: 0 PID: 4344 Comm: cat Tainted: G   M        E  X   ------  ---  6.12.0+ #226 PREEMPT_RT
> >     Tainted: [M]=MACHINE_CHECK, [E]=UNSIGNED_MODULE, [X]=AUX
> >     [...]
> >     pc : regmap_mmio_read32le+0x44/0xa0
> >     lr : regmap_mmio_read32le+0x44/0xa0
> >     [...]
> >     x23: ffff00080c080000 x22: ffff000802ac4c00 x21: ffff800087b13c9c
> >     x20: ffff800080a46494 x19: ffff800083da810c x18: 0000000000000004
> >     [...]
> >     x5 : ffff800080a46448 x4 : ffff800083da8000 x3 : ffff800080a46494
> >     x2 : ffff800080a47230 x1 : ffff800083da810c x0 : 0000000000000020
> >     Call trace:
> >      regmap_mmio_read32le+0x44/0xa0 (P)
> >      regmap_mmio_read+0x4c/0x80
> >      [...]
> >     Code: 52800400 8b214093 aa1303e1 97f4caf0 (b9400275)
> >     ---[ end trace 0000000000000000 ]---
> >     Kernel panic - not syncing: synchronous external abort: Fatal exception
> > 
> > Running this through decodecode gives:
> > 
> >     All code
> >     ========
> >        0:   52800400        mov     w0, #0x20                       // #32
> >        4:   8b214093        add     x19, x4, w1, uxtw
> >        8:   aa1303e1        mov     x1, x19
> >        c:   97f4caf0        bl      0xffffffffffd32bcc
> >       10:*  b9400275        ldr     w21, [x19]              <-- trapping instruction
> > 
> >     Code starting with the faulting instruction
> >     ===========================================
> >        0:   b9400275        ldr     w21, [x19]
> > 
> > x19's offset from the base address in /proc/vmallocinfo is 0x10c, which
> > points to a bad read at physical address 0x4007c10c; I also confirmed
> > that the preceding memory reads back without issues:

Oh, ugh...  I didn't realize that this wasn't merged.  I don't have a
way to test this any more.  The simplest fix would be to do change the
0x3000 to 0x100.  The GPR63 register is at 0xFC.

		reg = <0x4007c000 0x100>;

That's probably the best fix as well.  The later register areas would
be their own syscons.

regards,
dan carpenter


