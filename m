Return-Path: <netdev+bounces-143019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 700749C0EC7
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 20:19:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05649B22EEC
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 19:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5AF194AD6;
	Thu,  7 Nov 2024 19:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="gDtQIWDL"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644CC125D6;
	Thu,  7 Nov 2024 19:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731007192; cv=none; b=R88VpvXNMj4RjhvRrWkZVbq5OXOO+hLMIIqiUl2Q5MBJOf7xPISPq1H88eV83a5IySDN8EARsPPYnus8UlCibJHTZJJN6K89CZBVACoqC+PzQeMM2Hh9G/EFWLfZf3FT+c7EdYQAX6/Nal+kznjRxzzVkvmkAYoRnEezEYJDsqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731007192; c=relaxed/simple;
	bh=eN0VRTCZM2WBAT9cgFw9DTUrSpwbJpwTFubfXheWoYM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a/51DJil1lM8PMUKMDBzWHspHQzgKRBfQcVQh4VZR+c40/ernYQUawKyhakNwEjdnvYAIHxDz5Yut/mMR+zKg6naw6c7mLbn2BsQH9BfuTkSK8q74q6kBCdYoIN/KeZLtDdIcN64vkz8nE2euBVKJcYh0QdwJ+yaVW2uwofgVCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=gDtQIWDL; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1731007190; x=1762543190;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=eN0VRTCZM2WBAT9cgFw9DTUrSpwbJpwTFubfXheWoYM=;
  b=gDtQIWDLMjJ/NAXUg/qRikxvG4HqzfhgG4r4dHvHws/40uaGZuxCQ/9t
   sTSIQbUP6K/7C5E71dauPy19cjgAadtaMRF7bjAfwxWkKFilEAXdb4igA
   FJZiFQFuPb2rsq+vrJiLS6unN/q9xofBi4zTENhSS+BdVxY9dHO6p/S2X
   PypCitc64VGpdmIAjIvVelyRdmvGo1Z4uEuMuGbsc9IOphLdZ+RcVzchW
   jCGsw8ucyej7zIpSxYJf23+2ro76EaYTTvVF/d352jwol6zfHv9Azkj+f
   G2pCNbAIweBg2MKnkBs3l5Bs88oviLrGiIh3oU0Y/QIXJx9IIVGc7koz6
   w==;
X-CSE-ConnectionGUID: MDDVaqVhRqenuoSd1grXjg==
X-CSE-MsgGUID: wGoZR4F7TSiOLGn00rOoNA==
X-IronPort-AV: E=Sophos;i="6.12,135,1728975600"; 
   d="scan'208";a="34539067"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Nov 2024 12:19:43 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Nov 2024 12:19:22 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 7 Nov 2024 12:19:20 -0700
Date: Thu, 7 Nov 2024 19:19:19 +0000
From: Daniel Machon <daniel.machon@microchip.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
CC: Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
	<joabreu@synopsys.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
	<mcoquelin.stm32@gmail.com>, Richard Cochran <richardcochran@gmail.com>,
	Alexis =?utf-8?Q?Lothor=C3=A9?= <alexis.lothore@bootlin.com>, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>, <netdev@vger.kernel.org>,
	<linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v3 0/9] Support external snapshots on dwmac1000
Message-ID: <20241107191919.sngc2x664lp7jeg2@DEN-DL-M70577>
References: <20241106090331.56519-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241106090331.56519-1-maxime.chevallier@bootlin.com>

> Hi,
> 
> This V3 is just a rebase a V2 on top of net-next to address some minor
> conflicts. No changes were made.
> 
> This series is another take on the pervious work [1] done by
> Alexis Lothoré, that fixes the support for external snapshots
> timestamping in GMAC3-based devices.
> 
> Details on why this is needed are mentionned on the cover [2] from V1.
> 
> This V2 addresses multiple issues found in V1 :
> 
>  - The PTP_TCR register is configured from multiple places, as reported
>    by Alexis, so we need to make sure that the extts configuration
>    doesn't interfere with the hwtstamp configuration.
> 
>  - The interrupt management in V1 was incomplete, as the interrupt
>    wasn't correctly acked.
> 
>  - This series also makes so that we only enable the extts interrupt
>    when necessary.
> 
> [1]: https://lore.kernel.org/netdev/20230616100409.164583-1-alexis.lothore@bootlin.com/
> [2]: https://lore.kernel.org/netdev/20241029115419.1160201-1-maxime.chevallier@bootlin.com/
> 
> Thanks Alexis for laying the groundwork for this,
> 
> Best regards,
> 
> Maxime
> 
> Link to V1: https://lore.kernel.org/netdev/20241029115419.1160201-1-maxime.chevallier@bootlin.com/
> Link to V2: https://lore.kernel.org/netdev/20241104170251.2202270-1-maxime.chevallier@bootlin.com/

Hi Maxime,

Dont know much about this particular driver, but the patches looked good
to me!

For the series:

Reviewed-by: Daniel Machon <daniel.machon@microchip.com>

