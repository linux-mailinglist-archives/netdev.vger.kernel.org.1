Return-Path: <netdev+bounces-257681-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WIprNJOShmm6OwQAu9opvQ
	(envelope-from <netdev+bounces-257681-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 02:17:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A541046E5
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 02:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2994D30293CE
	for <lists+netdev@lfdr.de>; Sat,  7 Feb 2026 01:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08DC22517AC;
	Sat,  7 Feb 2026 01:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QNykMfig"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D94B1E7C34;
	Sat,  7 Feb 2026 01:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770426990; cv=none; b=BiwR17NnIDYXmL9bBtWS4kw7DLhtZlnwU/OjMxGq6/A4Q0WX3k7Kw+6MWZb287P84maBdsu9pnE+byc+C6xBwsagiBUFBFA2wzMVKUlr/S2J57UU3S4JRRiqbC7Bzgo41zW4OpZsDyxphcBVM/WVRVB49aZB65wCshF+fAX82XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770426990; c=relaxed/simple;
	bh=hh7SpEz8MKjpCWA1yMRyH7FgdwVcmZWj/58wW3MHj2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E/sjxUoEfXePQLQJITpThzm5Q2blkhyjkhyoRNkgyJNpj+nyzn6+fdS7PSC+tMhuQPIucY7sW/IWjHnM52MKk5SvDt8Gb+4mJeOX3R9lcRd+zz5WV46hsGCNoV/pvbNq5DvzbH7jpE10hSW4uQIJH6CfsJoIYFmTL/psldJpYuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QNykMfig; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770426991; x=1801962991;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hh7SpEz8MKjpCWA1yMRyH7FgdwVcmZWj/58wW3MHj2w=;
  b=QNykMfignSUMgJhZ8NoYW0Ov+fXz6Copi9MbC3pc+osTSdv4Rqhbq8tW
   +W3ZixM6Fw+iDIahngoBczLFxOZUfuf9ntxjY1w7kFETIgS3NVzI9uZPh
   8NOfoS+DztU3/Ct6eRWJAc1T6q9o5173V7ZEQJEgFhSICADmueBHgR2P+
   dnhrYGsEMkGlJquBTa8m6PlxC23DDk4djGssPQnmu3uEx/C1hquCHHY0M
   THLGL3f8JaIb3GW39NPQ1qpW/E14njCf4yI8KKFX5b6BZbQ/FQKCMCrAx
   r+91n45mtD4PvkJ3HnNQNj6HI4hkt+ura3buMiKM6BwY/GYfYGXrCCGcg
   A==;
X-CSE-ConnectionGUID: PJe6gqhnSru0tFrK3TyEiA==
X-CSE-MsgGUID: /92bTYZnQEq1oFYfE8znSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11693"; a="83081181"
X-IronPort-AV: E=Sophos;i="6.21,277,1763452800"; 
   d="scan'208";a="83081181"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2026 17:16:30 -0800
X-CSE-ConnectionGUID: XjJi+sJWSxeHoT3mP8rEqw==
X-CSE-MsgGUID: iuJ4Za1KR4mB7oed6O6Y5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,277,1763452800"; 
   d="scan'208";a="248643780"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 06 Feb 2026 17:16:25 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1voWvu-00000000lJG-21FH;
	Sat, 07 Feb 2026 01:16:22 +0000
Date: Sat, 7 Feb 2026 09:15:50 +0800
From: kernel test robot <lkp@intel.com>
To: Jie Zhang <jzhang918@gmail.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, jzhang918@gmail.com,
	jie.zhang@analog.com, horms@kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: stmmac: fix oops when split header is enabled
Message-ID: <202602070917.7RxMgQNe-lkp@intel.com>
References: <20260206195643.11333-1-jie.zhang@analog.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260206195643.11333-1-jie.zhang@analog.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,gmail.com,analog.com,kernel.org,intel.com,lunn.ch,google.com,redhat.com,foss.st.com,armlinux.org.uk,bootlin.com,nxp.com,synopsys.com,st-md-mailman.stormreply.com,lists.infradead.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_FROM(0.00)[bounces-257681-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,kernel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,01.org:url,intel.com:email,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: 43A541046E5
X-Rspamd-Action: no action

Hi Jie,

kernel test robot noticed the following build errors:

[auto build test ERROR on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Jie-Zhang/net-stmmac-fix-oops-when-split-header-is-enabled/20260207-035916
base:   net/main
patch link:    https://lore.kernel.org/r/20260206195643.11333-1-jie.zhang%40analog.com
patch subject: [PATCH net v2] net: stmmac: fix oops when split header is enabled
config: arc-hsdk_defconfig (https://download.01.org/0day-ci/archive/20260207/202602070917.7RxMgQNe-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260207/202602070917.7RxMgQNe-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602070917.7RxMgQNe-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/net/ethernet/stmicro/stmmac/stmmac_main.c: In function 'stmmac_rx_buf2_len':
>> drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:5041:24: error: 'struct plat_stmmacenet_data' has no member named 'has_gmac4'
    5041 |         if (!priv->plat->has_gmac4 && (status & rx_not_ls))
         |                        ^~


vim +5041 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c

  5014	
  5015	static unsigned int stmmac_rx_buf2_len(struct stmmac_priv *priv,
  5016					       struct dma_desc *p,
  5017					       int status, unsigned int len)
  5018	{
  5019		int coe = priv->hw->rx_csum;
  5020		unsigned int plen = 0;
  5021	
  5022		/* Not split header, buffer is not available */
  5023		if (!priv->sph_active)
  5024			return 0;
  5025	
  5026		/* For GMAC4, when split header is enabled, in some rare cases, the
  5027		 * hardware does not fill buf2 of the first descriptor with payload.
  5028		 * Thus we cannot assume buf2 is always fully filled if it is not
  5029		 * the last descriptor. Otherwise, the length of buf2 of the second
  5030		 * descriptor will be calculated wrong and cause an oops.
  5031		 *
  5032		 * If this is the last descriptor, 'plen' is the length of the
  5033		 * received packet that was transferred to system memory.
  5034		 * Otherwise, it is the accumulated number of bytes that have been
  5035		 * transferred for the current packet.
  5036		 *
  5037		 * Thus 'plen - len' always gives the correct length of buf2.
  5038		 */
  5039	
  5040		/* Not GMAC4 and not last descriptor */
> 5041		if (!priv->plat->has_gmac4 && (status & rx_not_ls))
  5042			return priv->dma_conf.dma_buf_sz;
  5043	
  5044		/* GMAC4 or last descriptor */
  5045		plen = stmmac_get_rx_frame_len(priv, p, coe);
  5046	
  5047		return plen - len;
  5048	}
  5049	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

