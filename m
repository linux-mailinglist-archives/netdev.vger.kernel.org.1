Return-Path: <netdev+bounces-254842-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MCOWDNuIe2mlFQIAu9opvQ
	(envelope-from <netdev+bounces-254842-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 17:20:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D86C5B213A
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 17:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DF1F4300E63D
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 16:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E819340279;
	Thu, 29 Jan 2026 16:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qk8qGl+P"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295851DC997;
	Thu, 29 Jan 2026 16:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769703634; cv=none; b=rULVbUWKB8JFAW75D8wc7Ntvy3gtv+xyWryvIRJlPPBOFMwXYSgGCevgd/FpyMgNKQSwtQD4+TcUUMDAbEq3j47XpqXj+9AO1RGKJFsixInIzoXmPzcub5k91Xmr7FJUKF1+nQ68Ek5mnPdX/4I3f+gZqENCNo5ofavtCZCnjBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769703634; c=relaxed/simple;
	bh=Fz1cXF6f+rJrvUbhHS3fdB4yadryUHMv1k4BpBRxD8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fAZiVqpHuZmD4cwXtLyh+dN4zLGD57BZ6YQg5OrNndvEhowcxmcvYH1zqmCLE4Fusl5rUaAbidyN22fxfERChUaCs8ZCHSCP153qWQBHhD799QiIUvmrhPBZSpoZmMIEX8oLXVD6VzeYkPHfjdQj1py5clctjohZSqbrk0JPnSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qk8qGl+P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BF5CC19422;
	Thu, 29 Jan 2026 16:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769703634;
	bh=Fz1cXF6f+rJrvUbhHS3fdB4yadryUHMv1k4BpBRxD8U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qk8qGl+Pkcd4d1ocyt263pGIIb71t4DaBVUNxvGVhL4GjZ+0VFhvreTqIrTOl9min
	 8TRYYRMyiAqaFRi+sYi/V4FURJnui5PEeeyiYNGGRsOCTbEHfV/k/Rd/efbn4aJw16
	 3ZuZEWelIPyL13/nkF/pOeQBDfkdqq+kS2QmkNk1F0qyHQ8KFV3zbEbrPJnYv8M87r
	 JAL/uuvmRFDGH1Ppn1vGBb4mahgzodbqTAWTygv7ryClXuV3gOk2/wm6XYyNCcl8/d
	 /ueY04E03nuGlhj+h4NdCERf0RQH104yambHI+iDX17QbO79apmkgPv0zLaACAxAZQ
	 Ur7QUYivF1ZGg==
Date: Thu, 29 Jan 2026 16:20:28 +0000
From: Simon Horman <horms@kernel.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: vkoul@kernel.org, neil.armstrong@linaro.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ciprianmarian.costea@oss.nxp.com, s32@nxp.com,
	p.zabel@pengutronix.de, linux@armlinux.org.uk,
	ghennadi.procopciuc@nxp.com, bogdan-gabriel.roman@nxp.com,
	Ionut.Vicovan@nxp.com, alexandru-catalin.ionita@nxp.com,
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org, Frank.li@nxp.com
Subject: Re: [PATCH 3/4] phy: s32g: Add serdes xpcs subsystem
Message-ID: <aXuIzJdZYEGX3XVy@horms.kernel.org>
References: <20260126092159.815968-1-vincent.guittot@linaro.org>
 <20260126092159.815968-4-vincent.guittot@linaro.org>
 <aXtLsuOkMMryrUs4@horms.kernel.org>
 <CAKfTPtB8xDB8qYUZwGnH+h94ww3+gSyOuZ+RL+zOh5tYGuu_HQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtB8xDB8qYUZwGnH+h94ww3+gSyOuZ+RL+zOh5tYGuu_HQ@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-254842-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[horms.kernel.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D86C5B213A
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 02:24:15PM +0100, Vincent Guittot wrote:
> On Thu, 29 Jan 2026 at 12:59, Simon Horman <horms@kernel.org> wrote:
> >
> > On Mon, Jan 26, 2026 at 10:21:58AM +0100, Vincent Guittot wrote:
> >
> > ...
> >
> > > diff --git a/drivers/phy/freescale/phy-nxp-s32g-serdes.c b/drivers/phy/freescale/phy-nxp-s32g-serdes.c
> >
> > ...
> >
> > > +static void s32g_serdes_prepare_pma_mode5(struct s32g_serdes *serdes)
> > > +{
> > > +     u32 val;
> > > +     /* Configure TX_VBOOST_LVL and TX_TERM_CTRL */
> > > +     val = readl(serdes->ctrl.ss_base + S32G_PCIE_PHY_EXT_MISC_CTRL_2);
> > > +     val &= ~(EXT_TX_VBOOST_LVL_MASK | EXT_TX_TERM_CTRL_MASK);
> > > +     val |= FIELD_PREP(EXT_TX_VBOOST_LVL_MASK, 0x3) |
> > > +             FIELD_PREP(EXT_TX_TERM_CTRL_MASK, 0x4);
> > > +     writel(val, serdes->ctrl.ss_base + S32G_PCIE_PHY_EXT_MISC_CTRL_2);
> >
> > This is part of an AI Generated review.
> > I have looked over it and I think it warrants investigation.
> > For information on how to reproduce locally, as I did, please see [1].
> >
> >         The entire s32g_serdes_prepare_pma_mode5() function is ~70 lines of
> >         magic numbers with zero explanation. These appear to be
> >         hardware-specific PLL/PHY tuning parameters for 2.5G mode.
> 
> Unfortunately there is no additional information in the reference
> manual other than
> *step 4:
> - Write 3h to EXT_TX_VBOOST_LVL.
> - Write 4h to EXT_TX_TERM_CTRL

Understood. Sometimes you have the play the hand you're dealt.

> 
> >
> > Please consider using #defines, to give values names.
> >
> > ...
> >
> > > +static int s32g_serdes_init_clks(struct s32g_serdes *serdes)
> > > +{
> > > +     struct s32g_serdes_ctrl *ctrl = &serdes->ctrl;
> > > +     struct s32g_xpcs_ctrl *xpcs = &serdes->xpcs;
> > > +     int ret, order[2], xpcs_id;
> > > +     size_t i;
> > > +
> > > +     switch (ctrl->ss_mode) {
> > > +     case 0:
> > > +             return 0;
> > > +     case 1:
> > > +             order[0] = 0;
> > > +             order[1] = XPCS_DISABLED;
> > > +             break;
> > > +     case 2:
> > > +     case 5:
> > > +             order[0] = 1;
> > > +             order[1] = XPCS_DISABLED;
> > > +             break;
> > > +     case 3:
> > > +             order[0] = 1;
> > > +             order[1] = 0;
> > > +             break;
> > > +     case 4:
> > > +             order[0] = 0;
> > > +             order[1] = 1;
> > > +             break;
> > > +     default:
> > > +             return -EINVAL;
> >
> > AI review also flags that s32g_serdes_get_ctrl_resources() ensures that
> > ss_mode is <= 5.  So this check is unnecessary.
> 
> okay but providing a default seems a good practice

Yeah, I was of two minds about forwarding on this part of the report.

...

> > AI review also flags that s32g_xpcs_regmap_reg_read and
> > s32g_xpcs_regmap_reg_write do not protect against concurrent access.
> 
> but regmap framework should

If it does, then I agree there is no problem here.

