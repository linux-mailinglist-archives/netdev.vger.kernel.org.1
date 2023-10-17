Return-Path: <netdev+bounces-41838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F4D7CBFE5
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 11:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 021D628195B
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 09:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D438F405FF;
	Tue, 17 Oct 2023 09:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lMotbMjU"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367B4405F6
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 09:50:19 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E5AC9F
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 02:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697536217; x=1729072217;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nyyg0L8NonbYaXsBEp+WK/UQNHC0Bw/76oVgNS6I6s0=;
  b=lMotbMjU2GNRLD3cW3noP2i9uOJy6UINDiHEkhNdkbWyq1UPKwwAo1Aa
   dw7/Dw7LDvlMKM3EfmBcjNXlKhVWWBX31Jb6JYwcNJqtUpHMr62oUnT3n
   lpBI8SD1XztQewlHUzsL1j1Yip2bpo0Xoq3FCecu98DqA2bnrCdHbPHbE
   j4kiuQBeZy/X4dFtvVa08oCZjyr+EhiksTYW0436S5IlFnNlB0T7WAWQq
   F9Ry1DIRwMriiRXWm/9bSsaIf/9/dDDOlFVvNDMMGdc1SwWCQ0KwaDf0J
   fDjy3ZzgCpAIMJ2dm2tRU5o0gxlflQLiyU+JSjUPKPMWfQf8mksQ7mmfV
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="452221555"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="452221555"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 02:50:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="872495253"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="872495253"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 17 Oct 2023 02:50:14 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qsgiJ-0009RF-33;
	Tue, 17 Oct 2023 09:50:11 +0000
Date: Tue, 17 Oct 2023 17:49:12 +0800
From: kernel test robot <lkp@intel.com>
To: Konrad Knitter <konrad.knitter@intel.com>,
	intel-wired-lan@lists.osuosl.org
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	jdelvare@suse.com, linux@roeck-us.net,
	Konrad Knitter <konrad.knitter@intel.com>,
	Marcin Domagala <marcinx.domagala@intel.com>,
	Eric Joyner <eric.joyner@intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH iwl-next v4] ice: read internal temperature sensor
Message-ID: <202310171740.MOWYti1J-lkp@intel.com>
References: <20231016102913.898932-1-konrad.knitter@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016102913.898932-1-konrad.knitter@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Konrad,

kernel test robot noticed the following build warnings:

[auto build test WARNING on ac4dec3fd63c7da703c244698fc92efb411ff0d4]

url:    https://github.com/intel-lab-lkp/linux/commits/Konrad-Knitter/ice-read-internal-temperature-sensor/20231017-142048
base:   ac4dec3fd63c7da703c244698fc92efb411ff0d4
patch link:    https://lore.kernel.org/r/20231016102913.898932-1-konrad.knitter%40intel.com
patch subject: [PATCH iwl-next v4] ice: read internal temperature sensor
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20231017/202310171740.MOWYti1J-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231017/202310171740.MOWYti1J-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310171740.MOWYti1J-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/intel/ice/ice_common.c:5329: warning: Excess function parameter 'sensor' description in 'ice_aq_get_sensor_reading'
>> drivers/net/ethernet/intel/ice/ice_common.c:5329: warning: Excess function parameter 'format' description in 'ice_aq_get_sensor_reading'


vim +5329 drivers/net/ethernet/intel/ice/ice_common.c

  5317	
  5318	/**
  5319	 * ice_aq_get_sensor_reading
  5320	 * @hw: pointer to the HW struct
  5321	 * @sensor: sensor type
  5322	 * @format: requested response format
  5323	 * @data: pointer to data to be read from the sensor
  5324	 *
  5325	 * Get sensor reading (0x0632)
  5326	 */
  5327	int ice_aq_get_sensor_reading(struct ice_hw *hw,
  5328				      struct ice_aqc_get_sensor_reading_resp *data)
> 5329	{
  5330		struct ice_aqc_get_sensor_reading *cmd;
  5331		struct ice_aq_desc desc;
  5332		int status;
  5333	
  5334		ice_fill_dflt_direct_cmd_desc(&desc, ice_aqc_opc_get_sensor_reading);
  5335		cmd = &desc.params.get_sensor_reading;
  5336	#define ICE_INTERNAL_TEMP_SENSOR_FORMAT	0
  5337	#define ICE_INTERNAL_TEMP_SENSOR	0
  5338		cmd->sensor = ICE_INTERNAL_TEMP_SENSOR;
  5339		cmd->format = ICE_INTERNAL_TEMP_SENSOR_FORMAT;
  5340	
  5341		status = ice_aq_send_cmd(hw, &desc, NULL, 0, NULL);
  5342		if (!status)
  5343			memcpy(data, &desc.params.get_sensor_reading_resp,
  5344			       sizeof(*data));
  5345	
  5346		return status;
  5347	}
  5348	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

