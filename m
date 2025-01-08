Return-Path: <netdev+bounces-156173-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66EB9A054B0
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 08:37:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21332162987
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 07:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2126F1AB533;
	Wed,  8 Jan 2025 07:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kL1bVe2e"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489511AAA29
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 07:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736321836; cv=none; b=ueg0ziyZ1pjHqRyg8P/ymPTvWZQ+I5wZmyjP1o8FGmrIehbndWmDHV0V3ltKFzdvLjDSA8ZKJmv8eGBLLhsjdK4xXGF9bVa1f6r5MUpKAFeDXvEqwCLQ2vxIP7Bv/gmPqn8nyhLHN0XrorlIoz2r048SyKRKePnHYhOmdxkFqPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736321836; c=relaxed/simple;
	bh=3u6bfLayhG54+WPRNwaf/qn6txkoyZ4B6wiWkKksZco=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u1Zp2WHxRHGh9MYr5TkiWqwrzNI18FVQ56Yc2y07haDrBh15DHr/dm9jbPxCHDR0xdeaDhXIGjQU217chvX12u26ePEqq7qJJScR9q4I5kaMHC6dzWCvFMWA65sDa30Kvnf+j0foKpAD19GawEuN1aYzjMYYIdetD3yKvxKNLHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kL1bVe2e; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736321824; x=1767857824;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3u6bfLayhG54+WPRNwaf/qn6txkoyZ4B6wiWkKksZco=;
  b=kL1bVe2eDJO1yNK2JotyMovEtVgo7mSzWJdEa8mAvsX5nn0YM9kA+LjI
   /P0ge8DkVGYkdtyZEsEjrO/e7SuXFHd6O+1BeRH2iN+GntTdQDVzIKiBC
   Z69/MxaCkWRf+c96CCIZAbhoMXGS9PXTuj2tOIpJ1zI+WVNVRPC+RUaXf
   Yfzbnq9CPnN+EREYyQOomBdGaGLzeUt8DQamI1899+yWqN8rxr/we1/ZA
   A61CG2t20nAAvzKFrfIiW0+LZPPy99U9Z1N5QZ0dlnqGrLLVtS6N02uVT
   B18WglwCBtbWqSR1Rxmp3F8xk1cS0M7gYnpP8aMhsc5DqXfE19YdqPK5m
   g==;
X-CSE-ConnectionGUID: 9qOlcAh+QIer7z4VTB1zkw==
X-CSE-MsgGUID: FbqC9XmQRwqNtNFOoVyA7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11308"; a="54081463"
X-IronPort-AV: E=Sophos;i="6.12,297,1728975600"; 
   d="scan'208";a="54081463"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2025 23:37:03 -0800
X-CSE-ConnectionGUID: tfkFk3DfQlG2R76nsCMEHA==
X-CSE-MsgGUID: I5uzctEQSUqQrc844McEXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,297,1728975600"; 
   d="scan'208";a="103225655"
Received: from unknown (HELO [10.107.18.17]) ([10.107.18.17])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2025 23:36:59 -0800
Message-ID: <66b95153-cb12-494d-851c-093a0006547f@linux.intel.com>
Date: Wed, 8 Jan 2025 15:36:57 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 02/18] net: stmmac: move tx_lpi_timer tracking
 to phylib
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Jose Abreu <joabreu@synopsys.com>,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>
References: <Z31V9O8SATRbu2L3@shell.armlinux.org.uk>
 <E1tVCRZ-007Y35-9N@rmk-PC.armlinux.org.uk>
Content-Language: en-US
From: Choong Yong Liang <yong.liang.choong@linux.intel.com>
In-Reply-To: <E1tVCRZ-007Y35-9N@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/1/2025 12:28 am, Russell King (Oracle) wrote:
> When stmmac_ethtool_op_get_eee() is called, stmmac sets the tx_lpi_timer
> and tx_lpi_enabled members, and then calls into phylink and thus phylib.
> phylib overwrites these members.
> 
> phylib will also cause a link down/link up transition when settings
> that impact the MAC have been changed.
> 
> Convert stmmac to use the tx_lpi_timer setting in struct phy_device,
> updating priv->tx_lpi_timer each time when the link comes up, rather
> than trying to maintain this user setting itself. We initialise the
> phylib tx_lpi_timer setting by doing a get_ee-modify-set_eee sequence
> with the last known priv->tx_lpi_timer value. In order for this to work
> correctly, we also need this member to be initialised earlier.
> 
> As stmmac_eee_init() is no longer called outside of stmmac_main.c, make
> it static.
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Hi Russell,

I have completed the sanity test on the EEE changes to the stmmac driver.

It seems that most of the changes are acceptable with respect to EEE behavior.

However, I noticed that this part of the code requires a minor change to 
fix the logic:

	/* Configure phylib's copy of the LPI timer */
	if (phylink_ethtool_get_eee(priv->phylink, &eee) == 0) {
		eee.tx_lpi_timer = priv->tx_lpi_timer;
		phylink_ethtool_set_eee(priv->phylink, &eee);
	}

Otherwise, the "tx_lpi_timer" will not be set correctly during the initial 
state.

Tested-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>

