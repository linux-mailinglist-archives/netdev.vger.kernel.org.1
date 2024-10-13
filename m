Return-Path: <netdev+bounces-135015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDAC799BCAB
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 00:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FDA3B20ED2
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 22:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C67314AD24;
	Sun, 13 Oct 2024 22:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KaKeSdjs"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07631231CAE
	for <netdev@vger.kernel.org>; Sun, 13 Oct 2024 22:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728860363; cv=none; b=OnO8dNcoAdEkA7kzlyQCrHFxvjbXp0llSh7UeTVzjqYgqmpJHewB6K2Td6eC+Cby5xvwfmVpSYkB9bmBTylS3bmWayPynovN6dUYyHHWpmMzc2JtIK4fvTfc1jrp00SI9aERVrBOpjm0RORv0/lECW6EVxQkXSbKs2v68vzRQyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728860363; c=relaxed/simple;
	bh=8LAUeJ4R3jubOnCceuAIhJvpehd+iDtP+KzTUvVwx48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U0mq8reZFRXxsi7jU0JkTO/S5MUHh0IxJg+OPd5zKeZtAU/XjJu4CH0K98RzkwWIKUkklGjqmE+06pmQZlLtAW8VReoCEz6yIoaTyWWbbfQw/i70Etu96waQ6mvpcCRrqC1QY/uDNc1EbZxyB7xzWo/XataLAaXPi2phoEvLmuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KaKeSdjs; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728860360; x=1760396360;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8LAUeJ4R3jubOnCceuAIhJvpehd+iDtP+KzTUvVwx48=;
  b=KaKeSdjsRUi5AmJt2Vy66DuZb4Ys5yzqcifhB38SShnjI2oa1e90jLHN
   StBcorvzvPwI9PCuT5AsxeXueG/8qq3/BlW/+ifOg+VGj5qaYI9+9fHrx
   gs2SHwNJL+Kb7cCwuSsv1pt2jsW1CV0vnrOSTXtk1adhZrXvzoDtWl6bi
   /tMBrU8QbJoVhGg6baTQvbDKQ4BWRrq04OLNCy+ZlcOv+E5POCIBNZsv9
   FlFlh7irsb/E3l1MbxKs6BQjs6+1Njwf1XKspcdy27/MepQ4frOwAWhWR
   t/WaY+Xm6UCOvosQitDTsUu3QICUQC6wsccBrEcZn2DSLmBcyKb1xkDBp
   A==;
X-CSE-ConnectionGUID: mbKG9eP/TY2SDbdjOff1Vw==
X-CSE-MsgGUID: bxqOqKILRkqzu3tDHcO2sA==
X-IronPort-AV: E=McAfee;i="6700,10204,11224"; a="15825966"
X-IronPort-AV: E=Sophos;i="6.11,201,1725346800"; 
   d="scan'208";a="15825966"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2024 15:59:19 -0700
X-CSE-ConnectionGUID: qQQqyOQ3Skq0oOodnvCNlw==
X-CSE-MsgGUID: 0jrlo2tbQH+OEi9joAcbdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,201,1725346800"; 
   d="scan'208";a="77329015"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 13 Oct 2024 15:59:12 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t07YM-000El9-04;
	Sun, 13 Oct 2024 22:59:10 +0000
Date: Mon, 14 Oct 2024 06:58:09 +0800
From: kernel test robot <lkp@intel.com>
To: Jan Petrous via B4 Relay <devnull+jan.petrous.oss.nxp.com@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vinod Koul <vkoul@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Minda Chen <minda.chen@starfivetech.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Iyappan Subramanian <iyappan@os.amperecomputing.com>,
	Keyur Chudgar <keyur@os.amperecomputing.com>,
	Quan Nguyen <quan@os.amperecomputing.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 15/16] MAINTAINERS: Add Jan Petrous as the NXP S32G/R
 DWMAC driver maintainer
Message-ID: <202410140609.ErjSS58O-lkp@intel.com>
References: <20241013-upstream_s32cc_gmac-v3-15-d84b5a67b930@oss.nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241013-upstream_s32cc_gmac-v3-15-d84b5a67b930@oss.nxp.com>

Hi Jan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 18ba6034468e7949a9e2c2cf28e2e123b4fe7a50]

url:    https://github.com/intel-lab-lkp/linux/commits/Jan-Petrous-via-B4-Relay/net-driver-stmmac-Fix-CSR-divider-comment/20241014-053027
base:   18ba6034468e7949a9e2c2cf28e2e123b4fe7a50
patch link:    https://lore.kernel.org/r/20241013-upstream_s32cc_gmac-v3-15-d84b5a67b930%40oss.nxp.com
patch subject: [PATCH v3 15/16] MAINTAINERS: Add Jan Petrous as the NXP S32G/R DWMAC driver maintainer
reproduce: (https://download.01.org/0day-ci/archive/20241014/202410140609.ErjSS58O-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410140609.ErjSS58O-lkp@intel.com/

All warnings (new ones prefixed by >>):

   Warning: Documentation/devicetree/bindings/regulator/siliconmitus,sm5703-regulator.yaml references a file that doesn't exist: Documentation/devicetree/bindings/mfd/siliconmitus,sm5703.yaml
   Warning: Documentation/hwmon/g762.rst references a file that doesn't exist: Documentation/devicetree/bindings/hwmon/g762.txt
>> Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/net/nxp,dwmac-s32.yaml
   Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/reserved-memory/qcom
   Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
   Using alabaster theme

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

