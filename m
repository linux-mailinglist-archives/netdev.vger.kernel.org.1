Return-Path: <netdev+bounces-232528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2ACC06436
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 14:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F21233BC32F
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 12:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479F63191B1;
	Fri, 24 Oct 2025 12:31:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C643195E8
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 12:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761309070; cv=none; b=mM/kXr+AekIJVgbQFUK+iTTisCq4VOQjKA2fdFDA5Vu8YO1fAdiwRRsufH8hvu9HNzVs5KBuk2JpuyqAwZGm4Vn+NDwtX7FBEMpTBtHR9wRhTGFZGfaEIwjLSEd0pJWANkuQHehXNSh3DgoECEtLVf2mOefbuBIU3Ju9QLyinkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761309070; c=relaxed/simple;
	bh=Q1sk4AdrzZT3+Y0gKCMUvozYWgb4PmEeF5wsEbjHQa4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NtgPwNFUHWVHlhxj1F62S2yt/MjfcTiylmnvb/+eRq0ROrjjX7+vJLCiBcPqeTcyk8pApY1Y8wgZBfL5YdX2isOpqdSpwoLB0XO5NWRKa7Vy1fTlyNUXrnsk+bTN+lo4mKN58uaJZ0/osNs+U190UTqjFpk0G6aokdBYCBubVls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=ratatoskr.pengutronix.de)
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.trumtrar@pengutronix.de>)
	id 1vCGwe-0002Ya-Bf; Fri, 24 Oct 2025 14:31:00 +0200
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,  "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  Rob Herring
 <robh@kernel.org>,  Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor
 Dooley <conor+dt@kernel.org>,  Dinh Nguyen <dinguyen@kernel.org>,  Maxime
 Coquelin <mcoquelin.stm32@gmail.com>,  Alexandre Torgue
 <alexandre.torgue@foss.st.com>,  Matthew Gerlach
 <matthew.gerlach@altera.com>,  kernel@pengutronix.de,
  netdev@vger.kernel.org,  devicetree@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-stm32@st-md-mailman.stormreply.com,
  linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 01/10] net: stmmac: dwmac-socfpga: don't set has_gmac
In-Reply-To: <92e953b8-4581-4647-8173-6c7fa05a7895@bootlin.com> (Maxime
	Chevallier's message of "Fri, 24 Oct 2025 14:11:45 +0200")
References: <20251024-v6-12-topic-socfpga-agilex5-v5-0-4c4a51159eeb@pengutronix.de>
	<20251024-v6-12-topic-socfpga-agilex5-v5-1-4c4a51159eeb@pengutronix.de>
	<92e953b8-4581-4647-8173-6c7fa05a7895@bootlin.com>
User-Agent: mu4e 1.12.13; emacs 30.2
Date: Fri, 24 Oct 2025 14:30:57 +0200
Message-ID: <87tszo7a7y.fsf@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: s.trumtrar@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org


Hi Maxime,

On 2025-10-24 at 14:11 +02, Maxime Chevallier <maxime.chevallier@bootlin.com> wrote:

> Hi Steffen
> 
> On 24/10/2025 13:49, Steffen Trumtrar wrote:
> > Instead of setting the has_gmac or has_xgmac fields, let
> > stmmac_probe_config_dt()) fill these fields according to the more
> > generic compatibles.
> > 
> > Without setting the has_xgmac/has_gmac field correctly, even basic
> > functions will fail, because the register offsets are different.
> > 
> > Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> > ---
> >  drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
> > index 354f01184e6cc..7ed125dcc73ea 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
> > @@ -497,7 +497,6 @@ static int socfpga_dwmac_probe(struct platform_device *pdev)
> >  	plat_dat->pcs_init = socfpga_dwmac_pcs_init;
> >  	plat_dat->pcs_exit = socfpga_dwmac_pcs_exit;
> >  	plat_dat->select_pcs = socfpga_dwmac_select_pcs;
> > -	plat_dat->has_gmac = true;
> 
> Note that this field is now gone as per :
> 
>   26ab9830beab ("net: stmmac: replace has_xxxx with core_type")
> 
> You'll need to rebase the series :)
>

I see, bad timing, but luckily an easy patch :)


Best regards,
Steffen

-- 
Pengutronix e.K.                | Dipl.-Inform. Steffen Trumtrar |
Steuerwalder Str. 21            | https://www.pengutronix.de/    |
31137 Hildesheim, Germany       | Phone: +49-5121-206917-0       |
Amtsgericht Hildesheim, HRA 2686| Fax:   +49-5121-206917-5555    |

