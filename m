Return-Path: <netdev+bounces-139950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 514269B4C67
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 15:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB1021F23B45
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 14:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4AD1CD2B;
	Tue, 29 Oct 2024 14:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="iDH/SeYm"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B56FC0A;
	Tue, 29 Oct 2024 14:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730213113; cv=none; b=KtwpL19FLyXq/3Sby1fizMEQshK97tMocETDjhTYn0rLdrMuAzbjRYsTkyfIeFewwZoeiqBIiQgqUGUoSSDaobBcqBfOeO5D/O8aQzZ105S7ixu3oA14pmfzjgDRLPu2/Cah3T9BGFAPldkqKohp1X7UcB9geEfPQn/wXQjG1Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730213113; c=relaxed/simple;
	bh=rTi2fvoIaaRco43xYOvShTtd6JnclSPU7WX7sK1G82I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BVn67HkIa6Ua2pb6/Dd+1P4+9gdgMypXUNVNkij3j5Y1BHsurRiRkcSKS7f2HzFtgQQCUKsPexen8aqQc4+dUGH80MdxYaDqov5mE5Nwqp9t1uC16Ubl0I9m9kd79Klpli0SZNPgQGdpqa93OolPy3ZYPphMVJLJsCfBVsKkxqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=iDH/SeYm; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9C8B31C0003;
	Tue, 29 Oct 2024 14:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730213109;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fJ+dC1+4ZiHEQDgeU3fYeNHYmT0utELbJCQ8uYRI6pg=;
	b=iDH/SeYmV60b+LV3bzsR3t53id4bQ/Vw04kE/AfHvXUuPZY02OK6qS18rcqRh1aw7V7b8q
	LPkhLTlg0Toz050MWeyG6jGFg0x246Bj7eadjEf01JrkXzkQlmCmXPhWx7P/z/TzJOlF2R
	BZ/iFu7PoNC62kEp3xJWauHlhmj/cZX8C3MwoT8G0fJxHiGvQgra78MRZ9hBSLgouHSv3o
	NqVNkGnbHtVO5DHSOynyOKClVNLSzaZSvoXYy31oXv+PuNNglNZ0K/C49Gtd2qqCrMnOrm
	jbG5IR/0ZRCbSUbnxkpXzCfh8sjkZjOZ0fNEey+O2qgq/MEO9gy+ucGeJwVjCQ==
Message-ID: <a905c45d-344b-49e9-a0c9-fb7b6445edad@bootlin.com>
Date: Tue, 29 Oct 2024 15:45:07 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/7] Support external snapshots on dwmac1000
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 davem@davemloft.net, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241029115419.1160201-1-maxime.chevallier@bootlin.com>
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Content-Language: en-US
In-Reply-To: <20241029115419.1160201-1-maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

Hello Maxime,

On 10/29/24 12:54, Maxime Chevallier wrote:
> Hi,
> 
> This series is another take on the pervious work [1] done by
> Alexis Lothoré, that fixes the support for external snapshots
> timestamping in GMAC3-based devices.
> 

[...]

> [1]: https://lore.kernel.org/netdev/20230616100409.164583-1-alexis.lothore@bootlin.com/
> 
> Thanks Alexis for laying the groundwork for this,
> 
> Best regards,
> 
> Maxime

Thanks for making this topic move forward. I suspect the series to be missing
some bits: in the initial series you mention in [1], I also reworked
stmmac_hwtstamp_set in stmmac_main.c, which is also currently assuming a GMAC4
layout ([2]). I suspect that in your series current state, any new call to
stmmac_hwtstamp_set will overwrite any previously configured hardware timestamping.

[2]
https://lore.kernel.org/netdev/20230616100409.164583-8-alexis.lothore@bootlin.com/
> 
> Maxime Chevallier (7):
>   net: stmmac: Don't modify the global ptp ops directly
>   net: stmmac: Use per-hw ptp clock ops
>   net: stmmac: Only update the auto-discovered PTP clock features
>   net: stmmac: Introduce dwmac1000 ptp_clock_info and operations
>   net: stmmac: Introduce dwmac1000 timestamping operations
>   net: stmmac: Enable timestamping interrupt on dwmac1000
>   net: stmmac: Don't include dwmac4 definitions in stmmac_ptp
> 
>  drivers/net/ethernet/stmicro/stmmac/common.h  |  4 +
>  .../net/ethernet/stmicro/stmmac/dwmac1000.h   | 15 +++-
>  .../ethernet/stmicro/stmmac/dwmac1000_core.c  | 85 +++++++++++++++++++
>  drivers/net/ethernet/stmicro/stmmac/hwif.c    | 14 ++-
>  .../ethernet/stmicro/stmmac/stmmac_hwtstamp.c | 11 +++
>  .../net/ethernet/stmicro/stmmac/stmmac_ptp.c  | 38 +++++++--
>  .../net/ethernet/stmicro/stmmac/stmmac_ptp.h  | 10 +++
>  7 files changed, 165 insertions(+), 12 deletions(-)
> 


-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

