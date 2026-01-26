Return-Path: <netdev+bounces-253500-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SE+fHpx3d2n7ggEAu9opvQ
	(envelope-from <netdev+bounces-253500-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 15:18:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D4DF189607
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 15:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CC9C430156D2
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 14:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D5B33D516;
	Mon, 26 Jan 2026 14:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="can6yX0p"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252EA33C514;
	Mon, 26 Jan 2026 14:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769437080; cv=none; b=tUq2z0yu0MSdMMH5z1msPEOpblA04fa7MGJv0jyK43HxxZIeWEt42htbE3J6TMdQ+KgOhyH++su2+vNt8EDAdLu42NHvMwa6nU9rRT5FR1toOot5tUEbL9GqLSTOWwQ0coxmDxARH4Y6EDMp+Ttj/w2hZeypuKezHFV+qJ1BF3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769437080; c=relaxed/simple;
	bh=xeDWngqya0qhU4z6lV5Uzc9Xyw1MTwc5ZzZeotSP5pI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O+EZEgIRX4OCMfDyLOwVubPjhpt6K7RHCr8DuqAvRbhXhyFIankmNHCC+Sastpz+wLoSoi9uavnB20323U4YYSPS1o+krpEpJ8ClFXpCckCaqytZ3vCTesE1k32bBuAadV1Gqk8Aoxr99wASA9aCj73r5iPlWiaLKSs+jcDcXys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=can6yX0p; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769437079; x=1800973079;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xeDWngqya0qhU4z6lV5Uzc9Xyw1MTwc5ZzZeotSP5pI=;
  b=can6yX0p4UzEsO88ULloCX9oHxJE36+/npuW+zkTDZIs3n9gRK+NNGbw
   CAzXumqxhIzjdNYtvop+lXWOhra/Kzy4Rfzb90351e+ASwrOf2suQI9qx
   IMwJFr5Rsgli34dIHv455ysAIwGTX78xm249Wms97KCdooexLm70vuXdF
   txG1JnjLKRVLSbRjK1oHq3M0poUMQd8NQtiSSmV+/YM5qhv4D5pXkUrgu
   OdmPguBXniE4dpd4MAUpoX7oSn3nZV/K1Y93eH0UvX+P9rwIgZxSxxfoi
   W+IODpFstqyMGs+OpwLg+WsiW+PYtaGCe/8epsbWpXzRsUVhm7Jg7DlaF
   g==;
X-CSE-ConnectionGUID: JWZYjU8xSdi5XquwIVMWfA==
X-CSE-MsgGUID: xZMGou7eSSK0lK1Hp0pzzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11683"; a="88026603"
X-IronPort-AV: E=Sophos;i="6.21,255,1763452800"; 
   d="scan'208";a="88026603"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 06:17:59 -0800
X-CSE-ConnectionGUID: bMMd/1CpSf2kDNFYCKZeGw==
X-CSE-MsgGUID: xWHtBDO8RCaVp4uh22hrsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,255,1763452800"; 
   d="scan'208";a="206811273"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 26 Jan 2026 06:17:54 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vkNPb-00000000XO2-3LKq;
	Mon, 26 Jan 2026 14:17:51 +0000
Date: Mon, 26 Jan 2026 22:17:49 +0800
From: kernel test robot <lkp@intel.com>
To: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Simon Horman <horms@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Pascal Eberhard <pascal.eberhard@se.com>,
	=?iso-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-kernel@vger.kernel.org,
	"Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Subject: Re: [PATCH net-next v3 4/8] net: dsa: microchip: Add support for
 KSZ8463's PTP interrupts
Message-ID: <202601262210.Ncec5HWm-lkp@intel.com>
References: <20260126-ksz8463-ptp-v3-4-9f092aeb8492@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126-ksz8463-ptp-v3-4-9f092aeb8492@bootlin.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253500-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[bootlin.com,microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[01.org:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: D4DF189607
X-Rspamd-Action: no action

Hi Bastien,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 3adff276e751051e77be4df8d29eab1cf0856fbf]

url:    https://github.com/intel-lab-lkp/linux/commits/Bastien-Curutchet-Schneider-Electric/net-dsa-microchip-Add-support-for-KSZ8463-global-irq/20260126-163430
base:   3adff276e751051e77be4df8d29eab1cf0856fbf
patch link:    https://lore.kernel.org/r/20260126-ksz8463-ptp-v3-4-9f092aeb8492%40bootlin.com
patch subject: [PATCH net-next v3 4/8] net: dsa: microchip: Add support for KSZ8463's PTP interrupts
config: sh-allyesconfig (https://download.01.org/0day-ci/archive/20260126/202601262210.Ncec5HWm-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260126/202601262210.Ncec5HWm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601262210.Ncec5HWm-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/dsa/microchip/ksz_ptp.c: In function 'ksz8463_ptp_irq_setup':
>> drivers/net/dsa/microchip/ksz_ptp.c:1171:35: warning: unused variable 'ops' [-Wunused-variable]
    1171 |         const struct ksz_dev_ops *ops = dev->dev_ops;
         |                                   ^~~


vim +/ops +1171 drivers/net/dsa/microchip/ksz_ptp.c

  1167	
  1168	int ksz8463_ptp_irq_setup(struct dsa_switch *ds)
  1169	{
  1170		struct ksz_device *dev = ds->priv;
> 1171		const struct ksz_dev_ops *ops = dev->dev_ops;
  1172		struct ksz_port *port1, *port2;
  1173		struct ksz_irq *ptpirq;
  1174		int ret;
  1175	
  1176		port1 = &dev->ports[0];
  1177		port2 = &dev->ports[1];
  1178		ptpirq = &port1->ptpirq;
  1179	
  1180		ptpirq->irq_num = irq_find_mapping(dev->girq.domain, KSZ8463_SRC_PTP_INT);
  1181		if (!ptpirq->irq_num)
  1182			return -EINVAL;
  1183	
  1184		ptpirq->dev = dev;
  1185		ptpirq->nirqs = 4;
  1186		ptpirq->reg_mask = KSZ8463_PTP_TS_IER;
  1187		ptpirq->reg_status = KSZ8463_PTP_TS_ISR;
  1188		ptpirq->irq0_offset = KSZ8463_PTP_INT_START;
  1189		snprintf(ptpirq->name, sizeof(ptpirq->name), "ptp-irq");
  1190	
  1191		ptpirq->domain = irq_domain_create_linear(dev_fwnode(dev->dev), ptpirq->nirqs,
  1192							  &ksz_ptp_irq_domain_ops, ptpirq);
  1193		if (!ptpirq->domain)
  1194			return -ENOMEM;
  1195	
  1196		ret = request_threaded_irq(ptpirq->irq_num, NULL, ksz_ptp_irq_thread_fn,
  1197					   IRQF_ONESHOT, ptpirq->name, ptpirq);
  1198		if (ret)
  1199			goto release_domain;
  1200	
  1201		ret = ksz8463_ptp_port_irq_setup(ptpirq, port1,
  1202						 KSZ8463_PTP_PORT1_INT_START - KSZ8463_PTP_INT_START);
  1203		if (ret)
  1204			goto release_irq;
  1205	
  1206		ret = ksz8463_ptp_port_irq_setup(ptpirq, port2,
  1207						 KSZ8463_PTP_PORT2_INT_START - KSZ8463_PTP_INT_START);
  1208		if (ret)
  1209			goto free_port1;
  1210	
  1211		return 0;
  1212	
  1213	free_port1:
  1214		ksz8463_ptp_port_irq_teardown(port1);
  1215	release_irq:
  1216		free_irq(ptpirq->irq_num, ptpirq);
  1217	release_domain:
  1218		irq_domain_remove(ptpirq->domain);
  1219	
  1220		return ret;
  1221	}
  1222	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

