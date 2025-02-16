Return-Path: <netdev+bounces-166798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 270E6A3757E
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 17:12:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1CA016F16C
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 16:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61B919993B;
	Sun, 16 Feb 2025 16:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F3joIj4z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E138194A6C;
	Sun, 16 Feb 2025 16:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739722324; cv=none; b=pylojss1HoWKi5sGk6PJOQDJh2dTqMN+5xxI7+P6qwPBgJYVZxgLLxCHbrh5+8Pge0PECRg6qG49JA3t19cYBYSTgfqThaHbD/vXWztahQt029+Whexx8uU9dWAP4arJQToIaQxnvFeVN/nby7j7g53P6IqUJgVplfpvdN5CykA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739722324; c=relaxed/simple;
	bh=vhzqR3wBf1c57XXipqo0apwTE664UU5tqcgb4s9Eg1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h/Qm7KgATkQD+jAPW5BnAcYSV8yZvtirD2IeGeg1VPV80odcD38kgkNPPy/RldQFn9qP3YFjjVT2zURrvpV92yA1U/jbqStB0Hw5tcqnuneigcMEP9edJ+5L/zKrLogEphA36UM+S3IZebfHUpDwXIw4gBzfCTeXkq0OWaKFyQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F3joIj4z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F739C4CEDD;
	Sun, 16 Feb 2025 16:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739722324;
	bh=vhzqR3wBf1c57XXipqo0apwTE664UU5tqcgb4s9Eg1g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F3joIj4zFNHizlHbVPob2/AHjpRkbvFIcNE/o3uBJg4FRZztHwNKkpQqRI2NfCSnh
	 BRz0QcTjzXsQrVDUSsx7wfD5R30i7C3Y+OXFa8/nX74NhFOu/9PjY4b6AyQNAF0Mzm
	 fh0Mx9KgTpt9J3oViV2B4cPfnDCOt7EMjz5q+F/OR9Z7ie7HAcsonH6gsEeS9PFPwu
	 15mvy8rCfS5sFJtJTfByTGMOmDPDuw2Y1VgUexEHaerxqbZ1tWm3sUdEWs4Mr8L9qW
	 Dse7ugMS8h7vTc86vpMYu02Py3SXKCfLOAQVMlCdX+N8o6OMIaez0277mXI0uFUJie
	 jK8GSlpBKc6yA==
Date: Sun, 16 Feb 2025 16:11:58 +0000
From: Simon Horman <horms@kernel.org>
To: "Malladi, Meghana" <m-malladi@ti.com>
Cc: Paolo Abeni <pabeni@redhat.com>, javier.carrasco.cruz@gmail.com,
	diogo.ivo@siemens.com, kuba@kernel.org, edumazet@google.com,
	davem@davemloft.net, andrew+netdev@lunn.ch,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, srk@ti.com,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Roger Quadros <rogerq@kernel.org>, danishanwar@ti.com
Subject: Re: [EXTERNAL] Re: [PATCH net 1/2] net: ti: icss-iep: Fix pwidth
 configuration for perout signal
Message-ID: <20250216161158.GH1615191@kernel.org>
References: <20250211103527.923849-1-m-malladi@ti.com>
 <20250211103527.923849-2-m-malladi@ti.com>
 <3a979b56-e9d6-41c9-910b-63b5371b9631@redhat.com>
 <66f30c0f-dec8-4ad5-9578-a9dcc422355a@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <66f30c0f-dec8-4ad5-9578-a9dcc422355a@ti.com>

On Fri, Feb 14, 2025 at 11:35:07AM +0530, Malladi, Meghana wrote:
> 
> 
> On 2/13/2025 4:53 PM, Paolo Abeni wrote:
> > On 2/11/25 11: 35 AM, Meghana Malladi wrote: > @@ -419,8 +426,9 @@
> > static int icss_iep_perout_enable_hw(struct icss_iep *iep, >
> > regmap_write(iep->map, ICSS_IEP_CMP1_REG0, lower_32_bits(cmp)); > if
> > (iep->plat_data->flags &
> > ZjQcmQRYFpfptBannerStart
> > This message was sent from outside of Texas Instruments.
> > Do not click links or open attachments unless you recognize the source
> > of this email and know the content is safe.
> > Report Suspicious
> > <https://us-phishalarm-ewt.proofpoint.com/EWT/v1/G3vK! updqdzavl0dbisXOnfkDHxHqGlQUHEro3tgnljLa7x4DRPBIRKu8Nqm3bW1LeMtXFyqz6yM7_tLlrvUmslKj9m_IL0hUlNU$>
> > ZjQcmQRYFpfptBannerEnd
> > 
> > On 2/11/25 11:35 AM, Meghana Malladi wrote:
> > > @@ -419,8 +426,9 @@ static int icss_iep_perout_enable_hw(struct icss_iep *iep,
> > >  			regmap_write(iep->map, ICSS_IEP_CMP1_REG0, lower_32_bits(cmp));
> > >  			if (iep->plat_data->flags & ICSS_IEP_64BIT_COUNTER_SUPPORT)
> > >  				regmap_write(iep->map, ICSS_IEP_CMP1_REG1, upper_32_bits(cmp));
> > > -			/* Configure SYNC, 1ms pulse width */
> > > -			regmap_write(iep->map, ICSS_IEP_SYNC_PWIDTH_REG, 1000000);
> > > +			/* Configure SYNC, based on req on width */
> > > +			regmap_write(iep->map, ICSS_IEP_SYNC_PWIDTH_REG,
> > > +				     (u32)(ns_width / iep->def_inc));
> > 
> > This causes build errors on 32bits:
> > 
> > ERROR: modpost: "__udivdi3" [drivers/net/ethernet/ti/icssg/icss_iep.ko]
> > undefined!
> > make[3]: *** [../scripts/Makefile.modpost:147: Module.symvers] Error 1
> > make[2]: *** [/home/nipa/net/wt-0/Makefile:1944: modpost] Error 2
> > make[1]: *** [/home/nipa/net/wt-0/Makefile:251: __sub-make] Error 2
> > make: *** [Makefile:251: __sub-make] Error 2
> > ERROR: modpost: "__udivdi3" [drivers/net/ethernet/ti/icssg/icss_iep.ko]
> > 
> > You should use div_u64()
> > 
> 
> I see, thanks.
> Can you tell me how can I reproduce this on my end for 32 bits.
> Will fix this in v2.

Hi Meghana,

FWIIW, I was able to reproduce this problem running the following
on an x86_64 system:

ARCH=i386 make tinyconfig

echo CONFIG_COMPILE_TEST=y >> .config
echo CONFIG_PCI=y >> .config
echo CONFIG_SOC_TI=y >> .config
echo CONFIG_TI_PRUSS=y >> .config
echo CONFIG_NET=y >> .config
echo CONFIG_NETDEVICES=y >> .config

yes "" | ARCH=i386 make oldconfig

ARCH=i386 make -j$(nproc)

