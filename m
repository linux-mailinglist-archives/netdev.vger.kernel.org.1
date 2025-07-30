Return-Path: <netdev+bounces-211084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43865B1685B
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 23:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36FB63AFB8E
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 21:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256522236EE;
	Wed, 30 Jul 2025 21:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DHLb0qNE"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C0722068F;
	Wed, 30 Jul 2025 21:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753911623; cv=none; b=FP+eY6zvZz515skprdkgY4bQNhYhfB1/SVxg1yJ6fQ6jA+TOHTQ75L013ESbt4PVlzG/xH5/NcMl/CiQ/XGQ2FlrwT1hM9uS5Uda/tFjW+jshmlxux8YtAd7YE1W/ohpTWvo+DDq5Gmx+LF33kyOL9DE00SLAAJLZAjwGqOFXSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753911623; c=relaxed/simple;
	bh=Bwf0g/5AzUEYlPHG3eNTNg9IPQ/fpGX+/5lZMyGu0FQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MScZsGfOJpNZ6HC/mVUA7dMlie7TLOOEZkEZa4T/LR4EUokU/0mh2dF727IUFzVo0DVsK6d32cJaIvyfgIp4tBly7dcc0C4yxOkHzWkTxWgAYwtGCNGEwRFkPtZpSo8ovFU+yX6R9WrcCsvA9x1yl/x5vsUwGPMcXwRfL8B7qvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DHLb0qNE; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753911622; x=1785447622;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Bwf0g/5AzUEYlPHG3eNTNg9IPQ/fpGX+/5lZMyGu0FQ=;
  b=DHLb0qNExl9LbKM5MIZCFPsH2ipw9VLuhd7AalSFvlQFVwXV/huDsdjW
   sh0uD59YRN9Pq+3+esNintnMeMM6mnmXLPozRY+dbFHD9ADP7q2kWwt7p
   9BHSdno8Tfa0YBR/PRfehsn6/Z6j0mtQ0Oh4yPNcvIi8qhs5ErSlAxkU0
   ASMDsKxlRO1Woj0c7s+4mqdav+vA7QMyOAu4zVA+bNRKjKghnKym0inaY
   a6LttOoko/o9AvHwhbkVC0Z+sVwaFNKjgVakEMPxd/CIGVvX67QdDue27
   k/uMEjYcH0Y6NEoh1MvLIsJDdUQOh+vLlEjG9ugNwP70G1v0/OdKJP5AN
   w==;
X-CSE-ConnectionGUID: eOD07FddQ1eW6PYSL9Zlsg==
X-CSE-MsgGUID: 6zBp6L/ES7uZ+xayvD9rKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11507"; a="73684208"
X-IronPort-AV: E=Sophos;i="6.16,353,1744095600"; 
   d="scan'208";a="73684208"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 14:40:21 -0700
X-CSE-ConnectionGUID: //39XzHJTVaxuw3IekjVqA==
X-CSE-MsgGUID: 9l9nEmG7TCGapoRWhEIOBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,353,1744095600"; 
   d="scan'208";a="163433695"
Received: from lkp-server01.sh.intel.com (HELO 160750d4a34c) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 30 Jul 2025 14:40:16 -0700
Received: from kbuild by 160750d4a34c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uhEX0-0003AC-1q;
	Wed, 30 Jul 2025 21:40:14 +0000
Date: Thu, 31 Jul 2025 05:39:37 +0800
From: kernel test robot <lkp@intel.com>
To: Gatien Chevallier <gatien.chevallier@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Gatien Chevallier <gatien.chevallier@foss.st.com>
Subject: Re: [PATCH net-next v2 1/2] drivers: net: stmmac: handle start time
 set in the past for flexible PPS
Message-ID: <202507310541.o0TF0jd1-lkp@intel.com>
References: <20250729-relative_flex_pps-v2-1-3e5f03525c45@foss.st.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729-relative_flex_pps-v2-1-3e5f03525c45@foss.st.com>

Hi Gatien,

kernel test robot noticed the following build errors:

[auto build test ERROR on fa582ca7e187a15e772e6a72fe035f649b387a60]

url:    https://github.com/intel-lab-lkp/linux/commits/Gatien-Chevallier/drivers-net-stmmac-handle-start-time-set-in-the-past-for-flexible-PPS/20250729-225635
base:   fa582ca7e187a15e772e6a72fe035f649b387a60
patch link:    https://lore.kernel.org/r/20250729-relative_flex_pps-v2-1-3e5f03525c45%40foss.st.com
patch subject: [PATCH net-next v2 1/2] drivers: net: stmmac: handle start time set in the past for flexible PPS
config: riscv-allyesconfig (https://download.01.org/0day-ci/archive/20250731/202507310541.o0TF0jd1-lkp@intel.com/config)
compiler: clang version 16.0.6 (https://github.com/llvm/llvm-project 7cbf1a2591520c2491aa35339f227775f4d3adf6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250731/202507310541.o0TF0jd1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507310541.o0TF0jd1-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c:177:3: error: expected expression
                   struct timespec64 curr_time;
                   ^
>> drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c:207:3: error: use of undeclared identifier 'curr_time'
                   curr_time = ns_to_timespec64(ns);
                   ^
   drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c:209:49: error: use of undeclared identifier 'curr_time'
                           cfg->start = timespec64_add_safe(cfg->start, curr_time);
                                                                        ^
   3 errors generated.


vim +177 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c

   163	
   164	static int stmmac_enable(struct ptp_clock_info *ptp,
   165				 struct ptp_clock_request *rq, int on)
   166	{
   167		struct stmmac_priv *priv =
   168		    container_of(ptp, struct stmmac_priv, ptp_clock_ops);
   169		void __iomem *ptpaddr = priv->ptpaddr;
   170		struct stmmac_pps_cfg *cfg;
   171		int ret = -EOPNOTSUPP;
   172		unsigned long flags;
   173		u32 acr_value;
   174	
   175		switch (rq->type) {
   176		case PTP_CLK_REQ_PEROUT:
 > 177			struct timespec64 curr_time;
   178			u64 target_ns = 0;
   179			u64 ns = 0;
   180	
   181			/* Reject requests with unsupported flags */
   182			if (rq->perout.flags)
   183				return -EOPNOTSUPP;
   184	
   185			cfg = &priv->pps[rq->perout.index];
   186	
   187			cfg->start.tv_sec = rq->perout.start.sec;
   188			cfg->start.tv_nsec = rq->perout.start.nsec;
   189	
   190			/* A time set in the past won't trigger the start of the flexible PPS generation for
   191			 * the GMAC5. For some reason it does for the GMAC4 but setting a time in the past
   192			 * should be addressed anyway. Therefore, any value set it the past is considered as
   193			 * an offset compared to the current MAC system time.
   194			 * Be aware that an offset too low may not trigger flexible PPS generation
   195			 * if time spent in this configuration makes the targeted time already outdated.
   196			 * To address this, add a safe time offset.
   197			 */
   198			if (!cfg->start.tv_sec && cfg->start.tv_nsec < PTP_SAFE_TIME_OFFSET_NS)
   199				cfg->start.tv_nsec += PTP_SAFE_TIME_OFFSET_NS;
   200	
   201			target_ns = cfg->start.tv_nsec + ((u64)cfg->start.tv_sec * NSEC_PER_SEC);
   202	
   203			stmmac_get_systime(priv, priv->ptpaddr, &ns);
   204			if (ns > TIME64_MAX - PTP_SAFE_TIME_OFFSET_NS)
   205				return -EINVAL;
   206	
 > 207			curr_time = ns_to_timespec64(ns);
   208			if (target_ns < ns + PTP_SAFE_TIME_OFFSET_NS) {
   209				cfg->start = timespec64_add_safe(cfg->start, curr_time);
   210				if (cfg->start.tv_sec == TIME64_MAX)
   211					return -EINVAL;
   212			}
   213	
   214			cfg->period.tv_sec = rq->perout.period.sec;
   215			cfg->period.tv_nsec = rq->perout.period.nsec;
   216	
   217			write_lock_irqsave(&priv->ptp_lock, flags);
   218			ret = stmmac_flex_pps_config(priv, priv->ioaddr,
   219						     rq->perout.index, cfg, on,
   220						     priv->sub_second_inc,
   221						     priv->systime_flags);
   222			write_unlock_irqrestore(&priv->ptp_lock, flags);
   223			break;
   224		case PTP_CLK_REQ_EXTTS: {
   225			u8 channel;
   226	
   227			mutex_lock(&priv->aux_ts_lock);
   228			acr_value = readl(ptpaddr + PTP_ACR);
   229			channel = ilog2(FIELD_GET(PTP_ACR_MASK, acr_value));
   230			acr_value &= ~PTP_ACR_MASK;
   231	
   232			if (on) {
   233				if (FIELD_GET(PTP_ACR_MASK, acr_value)) {
   234					netdev_err(priv->dev,
   235						   "Cannot enable auxiliary snapshot %d as auxiliary snapshot %d is already enabled",
   236						rq->extts.index, channel);
   237					mutex_unlock(&priv->aux_ts_lock);
   238					return -EBUSY;
   239				}
   240	
   241				priv->plat->flags |= STMMAC_FLAG_EXT_SNAPSHOT_EN;
   242	
   243				/* Enable External snapshot trigger */
   244				acr_value |= PTP_ACR_ATSEN(rq->extts.index);
   245				acr_value |= PTP_ACR_ATSFC;
   246			} else {
   247				priv->plat->flags &= ~STMMAC_FLAG_EXT_SNAPSHOT_EN;
   248			}
   249			netdev_dbg(priv->dev, "Auxiliary Snapshot %d %s.\n",
   250				   rq->extts.index, on ? "enabled" : "disabled");
   251			writel(acr_value, ptpaddr + PTP_ACR);
   252			mutex_unlock(&priv->aux_ts_lock);
   253			/* wait for auxts fifo clear to finish */
   254			ret = readl_poll_timeout(ptpaddr + PTP_ACR, acr_value,
   255						 !(acr_value & PTP_ACR_ATSFC),
   256						 10, 10000);
   257			break;
   258		}
   259	
   260		default:
   261			break;
   262		}
   263	
   264		return ret;
   265	}
   266	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

