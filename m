Return-Path: <netdev+bounces-197643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B70AD977E
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 23:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE9861BC0C0C
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 21:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352F1255E27;
	Fri, 13 Jun 2025 21:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MAGSc2QE"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8491A3168;
	Fri, 13 Jun 2025 21:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749851252; cv=none; b=qG1Zo0rx6CFzsIv7IrKy0zoBCqUU6EBs3kicW+qT4a5MYjXUmxbkLmblDmCBst6nHWI2q+R/NzlsT4fUaAx6Dl1misH/Bysd9N5y8vWTdG30dDVLKDhb1EYbsfE5CTtBKUwjBcJGZdY36ztz9eWOf2dHRpCikEs5jAdpBAULzZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749851252; c=relaxed/simple;
	bh=UFBnmAmV5GfUyOf6hdq8Wup9xKMJWhcUGzPNLBHK/MU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YArBzj7v8WmrfkqG4816Z84GLHQQiaS11AjFU98kuIxcRKRBwwafYVe5l0iiTkmzFu7GpggmchkLERnXv2tSdYQr+3o5DJ6fVJLaYxgdRxKoeGF0dbXB9/RJnbheV9GcF9Df5BzZEyP5CuH/nLeZ5PabTzuKXqoMUQ1QoOEGSNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MAGSc2QE; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749851250; x=1781387250;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UFBnmAmV5GfUyOf6hdq8Wup9xKMJWhcUGzPNLBHK/MU=;
  b=MAGSc2QEiSfKzeAojs7l+6+Cvs4lnngrmE/56QDFN98oGLR6kEXg/p6j
   SoogtHpNv/OAABgh+SMnJ24x4BD75YDo6E2vebZs7gtpurLkBXwKnzT/I
   LieyTXEr4ugzafOm3Qk9qFR/NnpBxLibkrmOkBDlovbtHOjrRvxzO6p9F
   4kQgZbH+Qkky0w+lA7LB1OYFOAh9koaJ4MNI278B+47K2nIWTiNd9pe3s
   e5dVE0T6b0fYT7JVHYO/fWD6S7MZOxFoS+xz+bD/cUqAar8YNPlM8pBii
   QDguLhySR8EkbSebkYAdTbxkhlr153HDase8g80PAxQRNahP6Sl1OJFma
   Q==;
X-CSE-ConnectionGUID: 1rHZE+SQTjiNVoVFML2LVg==
X-CSE-MsgGUID: Ag5yegggRH+Fycfuf0/lVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11463"; a="63429300"
X-IronPort-AV: E=Sophos;i="6.16,234,1744095600"; 
   d="scan'208";a="63429300"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 14:47:27 -0700
X-CSE-ConnectionGUID: Ne47g+8qQlWTLEFFvFGPSg==
X-CSE-MsgGUID: g1lRJdUiSHaVHxPkS/C/3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,234,1744095600"; 
   d="scan'208";a="148472745"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 13 Jun 2025 14:47:21 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uQCF4-000D1W-2p;
	Fri, 13 Jun 2025 21:47:18 +0000
Date: Sat, 14 Jun 2025 05:46:48 +0800
From: kernel test robot <lkp@intel.com>
To: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, Michal Schmidt <mschmidt@redhat.com>,
	Petr Oros <poros@redhat.com>
Subject: Re: [PATCH net-next v9 06/14] dpll: zl3073x: Fetch invariants during
 probe
Message-ID: <202506140541.KcP4ErN5-lkp@intel.com>
References: <20250612200145.774195-7-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250612200145.774195-7-ivecera@redhat.com>

Hi Ivan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Ivan-Vecera/dt-bindings-dpll-Add-DPLL-device-and-pin/20250613-041005
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250612200145.774195-7-ivecera%40redhat.com
patch subject: [PATCH net-next v9 06/14] dpll: zl3073x: Fetch invariants during probe
config: alpha-randconfig-r061-20250614 (https://download.01.org/0day-ci/archive/20250614/202506140541.KcP4ErN5-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 10.5.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506140541.KcP4ErN5-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> drivers/dpll/zl3073x/core.c:552:2-16: opportunity for str_enabled_disabled(input -> enabled)
>> drivers/dpll/zl3073x/core.c:587:2-14: opportunity for str_enabled_disabled(out -> enabled)
>> drivers/dpll/zl3073x/core.c:643:2-16: opportunity for str_enabled_disabled(synth -> enabled)

vim +552 drivers/dpll/zl3073x/core.c

   506	
   507	/**
   508	 * zl3073x_ref_state_fetch - get input reference state
   509	 * @zldev: pointer to zl3073x_dev structure
   510	 * @index: input reference index to fetch state for
   511	 *
   512	 * Function fetches information for the given input reference that are
   513	 * invariant and stores them for later use.
   514	 *
   515	 * Return: 0 on success, <0 on error
   516	 */
   517	static int
   518	zl3073x_ref_state_fetch(struct zl3073x_dev *zldev, u8 index)
   519	{
   520		struct zl3073x_ref *input = &zldev->ref[index];
   521		u8 ref_config;
   522		int rc;
   523	
   524		/* If the input is differential then the configuration for N-pin
   525		 * reference is ignored and P-pin config is used for both.
   526		 */
   527		if (zl3073x_is_n_pin(index) &&
   528		    zl3073x_ref_is_diff(zldev, index - 1)) {
   529			input->enabled = zl3073x_ref_is_enabled(zldev, index - 1);
   530			input->diff = true;
   531	
   532			return 0;
   533		}
   534	
   535		guard(mutex)(&zldev->multiop_lock);
   536	
   537		/* Read reference configuration */
   538		rc = zl3073x_mb_op(zldev, ZL_REG_REF_MB_SEM, ZL_REF_MB_SEM_RD,
   539				   ZL_REG_REF_MB_MASK, BIT(index));
   540		if (rc)
   541			return rc;
   542	
   543		/* Read ref_config register */
   544		rc = zl3073x_read_u8(zldev, ZL_REG_REF_CONFIG, &ref_config);
   545		if (rc)
   546			return rc;
   547	
   548		input->enabled = FIELD_GET(ZL_REF_CONFIG_ENABLE, ref_config);
   549		input->diff = FIELD_GET(ZL_REF_CONFIG_DIFF_EN, ref_config);
   550	
   551		dev_dbg(zldev->dev, "REF%u is %s and configured as %s\n", index,
 > 552			input->enabled ? "enabled" : "disabled",
   553			input->diff ? "differential" : "single-ended");
   554	
   555		return rc;
   556	}
   557	
   558	/**
   559	 * zl3073x_out_state_fetch - get output state
   560	 * @zldev: pointer to zl3073x_dev structure
   561	 * @index: output index to fetch state for
   562	 *
   563	 * Function fetches information for the given output (not output pin)
   564	 * that are invariant and stores them for later use.
   565	 *
   566	 * Return: 0 on success, <0 on error
   567	 */
   568	static int
   569	zl3073x_out_state_fetch(struct zl3073x_dev *zldev, u8 index)
   570	{
   571		struct zl3073x_out *out = &zldev->out[index];
   572		u8 output_ctrl, output_mode;
   573		int rc;
   574	
   575		/* Read output configuration */
   576		rc = zl3073x_read_u8(zldev, ZL_REG_OUTPUT_CTRL(index), &output_ctrl);
   577		if (rc)
   578			return rc;
   579	
   580		/* Store info about output enablement and synthesizer the output
   581		 * is connected to.
   582		 */
   583		out->enabled = FIELD_GET(ZL_OUTPUT_CTRL_EN, output_ctrl);
   584		out->synth = FIELD_GET(ZL_OUTPUT_CTRL_SYNTH_SEL, output_ctrl);
   585	
   586		dev_dbg(zldev->dev, "OUT%u is %s and connected to SYNTH%u\n", index,
 > 587			out->enabled ? "enabled" : "disabled", out->synth);
   588	
   589		guard(mutex)(&zldev->multiop_lock);
   590	
   591		/* Read output configuration */
   592		rc = zl3073x_mb_op(zldev, ZL_REG_OUTPUT_MB_SEM, ZL_OUTPUT_MB_SEM_RD,
   593				   ZL_REG_OUTPUT_MB_MASK, BIT(index));
   594		if (rc)
   595			return rc;
   596	
   597		/* Read output_mode */
   598		rc = zl3073x_read_u8(zldev, ZL_REG_OUTPUT_MODE, &output_mode);
   599		if (rc)
   600			return rc;
   601	
   602		/* Extract and store output signal format */
   603		out->signal_format = FIELD_GET(ZL_OUTPUT_MODE_SIGNAL_FORMAT,
   604					       output_mode);
   605	
   606		dev_dbg(zldev->dev, "OUT%u has signal format 0x%02x\n", index,
   607			out->signal_format);
   608	
   609		return rc;
   610	}
   611	
   612	/**
   613	 * zl3073x_synth_state_fetch - get synth state
   614	 * @zldev: pointer to zl3073x_dev structure
   615	 * @index: synth index to fetch state for
   616	 *
   617	 * Function fetches information for the given synthesizer that are
   618	 * invariant and stores them for later use.
   619	 *
   620	 * Return: 0 on success, <0 on error
   621	 */
   622	static int
   623	zl3073x_synth_state_fetch(struct zl3073x_dev *zldev, u8 index)
   624	{
   625		struct zl3073x_synth *synth = &zldev->synth[index];
   626		u16 base, m, n;
   627		u8 synth_ctrl;
   628		u32 mult;
   629		int rc;
   630	
   631		/* Read synth control register */
   632		rc = zl3073x_read_u8(zldev, ZL_REG_SYNTH_CTRL(index), &synth_ctrl);
   633		if (rc)
   634			return rc;
   635	
   636		/* Store info about synth enablement and DPLL channel the synth is
   637		 * driven by.
   638		 */
   639		synth->enabled = FIELD_GET(ZL_SYNTH_CTRL_EN, synth_ctrl);
   640		synth->dpll = FIELD_GET(ZL_SYNTH_CTRL_DPLL_SEL, synth_ctrl);
   641	
   642		dev_dbg(zldev->dev, "SYNTH%u is %s and driven by DPLL%u\n", index,
 > 643			synth->enabled ? "enabled" : "disabled", synth->dpll);
   644	
   645		guard(mutex)(&zldev->multiop_lock);
   646	
   647		/* Read synth configuration */
   648		rc = zl3073x_mb_op(zldev, ZL_REG_SYNTH_MB_SEM, ZL_SYNTH_MB_SEM_RD,
   649				   ZL_REG_SYNTH_MB_MASK, BIT(index));
   650		if (rc)
   651			return rc;
   652	
   653		/* The output frequency is determined by the following formula:
   654		 * base * multiplier * numerator / denominator
   655		 *
   656		 * Read registers with these values
   657		 */
   658		rc = zl3073x_read_u16(zldev, ZL_REG_SYNTH_FREQ_BASE, &base);
   659		if (rc)
   660			return rc;
   661	
   662		rc = zl3073x_read_u32(zldev, ZL_REG_SYNTH_FREQ_MULT, &mult);
   663		if (rc)
   664			return rc;
   665	
   666		rc = zl3073x_read_u16(zldev, ZL_REG_SYNTH_FREQ_M, &m);
   667		if (rc)
   668			return rc;
   669	
   670		rc = zl3073x_read_u16(zldev, ZL_REG_SYNTH_FREQ_N, &n);
   671		if (rc)
   672			return rc;
   673	
   674		/* Check denominator for zero to avoid div by 0 */
   675		if (!n) {
   676			dev_err(zldev->dev,
   677				"Zero divisor for SYNTH%u retrieved from device\n",
   678				index);
   679			return -EINVAL;
   680		}
   681	
   682		/* Compute and store synth frequency */
   683		zldev->synth[index].freq = div_u64(mul_u32_u32(base * m, mult), n);
   684	
   685		dev_dbg(zldev->dev, "SYNTH%u frequency: %u Hz\n", index,
   686			zldev->synth[index].freq);
   687	
   688		return rc;
   689	}
   690	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

