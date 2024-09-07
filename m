Return-Path: <netdev+bounces-126240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 652D7970383
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 20:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E05DE1F21D21
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 18:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E780A16131C;
	Sat,  7 Sep 2024 18:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EOOxnc8Y"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E566F149C4F;
	Sat,  7 Sep 2024 18:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725732558; cv=none; b=AHH2dCe+OvirooOLOv4WYaCTX3fNU3ZwkZwtmcfT8ePMfTpD34VT//2BELm6XDgpC3kBsA86icjGJ4hNEiMW+brwM1HbR3ALWBmJylYHvI0gaYQSuktoiLmrZtMU/eyMjIDizS22PVmbk5Fupj8Dz79ZS4aC1tl4rI5YGyqSuKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725732558; c=relaxed/simple;
	bh=03RZKeDjnVqe0G7FXwwDaNspHTqiVI51ZvrGTvgSqLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qg/dEZQtu46duI6kpm4oZ8ko8BPd/Vbx+KH6dSld/BTg0ma7w5RMabhMI8/rv+9yPwxIpguzidU32UDi2Hh+LmqeX4qkVds3Jb3tygrFMlLrK3rvKxMOiMqSRzrT9ZoXoOMpS7Z6H+7U+IZ7GsLVGKSwflrvlKwkmAlxo492bPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EOOxnc8Y; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725732557; x=1757268557;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=03RZKeDjnVqe0G7FXwwDaNspHTqiVI51ZvrGTvgSqLw=;
  b=EOOxnc8Yoqc58ruM79De6njoaFa02sDLlTJmmijmGUTq/jATDSCVGP7l
   CUGy+VNfFUC3uBNUenBdRgTWEuP9oZBshFTm3nrfegP1jEo613lF2SxSI
   oOFyZWn0RtXPgsG2Pdc1PXNUMMPTcNcqTaCcu0+39FJ5b7Rhx3wzeNVGE
   NzgqV1cpcg2+ihs6GUGOmX4R6CQDYELiwvdvD8dpUNAfRuxC5i+eWYswD
   fUX+XmEer41r7P0zh67qoNsewyiXmkY680pN/Gl/Sy2ZAWo+kCfTg6SWo
   2dZVO+2ojYXSr2qo/vYAnU7e5eYJdAAOXUVg9PWVyMbFGK2B7vBuwZzwm
   w==;
X-CSE-ConnectionGUID: bgBGza9dTfOdfZgxGtKp2A==
X-CSE-MsgGUID: cHOKEWgOSN+R6fYV9jw88Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11188"; a="24664690"
X-IronPort-AV: E=Sophos;i="6.10,210,1719903600"; 
   d="scan'208";a="24664690"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2024 11:09:16 -0700
X-CSE-ConnectionGUID: SLjUjvqNRHSEzeDyMXpsFQ==
X-CSE-MsgGUID: b8jsPESTTNK1LaOafwcWog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,210,1719903600"; 
   d="scan'208";a="66234384"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 07 Sep 2024 11:09:13 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1smzry-000CpP-1j;
	Sat, 07 Sep 2024 18:09:10 +0000
Date: Sun, 8 Sep 2024 02:08:37 +0800
From: kernel test robot <lkp@intel.com>
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
	netdev@vger.kernel.org, dan.j.williams@intel.com,
	martin.habets@xilinx.com, edward.cree@amd.com, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
Cc: oe-kbuild-all@lists.linux.dev, Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v3 02/20] cxl: add capabilities field to cxl_dev_state
 and cxl_port
Message-ID: <202409080140.BHrsmdob-lkp@intel.com>
References: <20240907081836.5801-3-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240907081836.5801-3-alejandro.lucero-palau@amd.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on cxl/next]
[also build test WARNING on linus/master v6.11-rc6 next-20240906]
[cannot apply to cxl/pending horms-ipvs/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/alejandro-lucero-palau-amd-com/cxl-add-type2-device-basic-support/20240907-162231
base:   https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
patch link:    https://lore.kernel.org/r/20240907081836.5801-3-alejandro.lucero-palau%40amd.com
patch subject: [PATCH v3 02/20] cxl: add capabilities field to cxl_dev_state and cxl_port
config: xtensa-randconfig-r073-20240908 (https://download.01.org/0day-ci/archive/20240908/202409080140.BHrsmdob-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240908/202409080140.BHrsmdob-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409080140.BHrsmdob-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/cxl/core/regs.c:41: warning: Function parameter or struct member 'caps' not described in 'cxl_probe_component_regs'
>> drivers/cxl/core/regs.c:124: warning: Function parameter or struct member 'caps' not described in 'cxl_probe_device_regs'


vim +41 drivers/cxl/core/regs.c

fa89248e669d58 Robert Richter   2022-10-18   13  
2b922a9d064f8e Dan Williams     2021-09-03   14  /**
2b922a9d064f8e Dan Williams     2021-09-03   15   * DOC: cxl registers
2b922a9d064f8e Dan Williams     2021-09-03   16   *
2b922a9d064f8e Dan Williams     2021-09-03   17   * CXL device capabilities are enumerated by PCI DVSEC (Designated
2b922a9d064f8e Dan Williams     2021-09-03   18   * Vendor-specific) and / or descriptors provided by platform firmware.
2b922a9d064f8e Dan Williams     2021-09-03   19   * They can be defined as a set like the device and component registers
2b922a9d064f8e Dan Williams     2021-09-03   20   * mandated by CXL Section 8.1.12.2 Memory Device PCIe Capabilities and
2b922a9d064f8e Dan Williams     2021-09-03   21   * Extended Capabilities, or they can be individual capabilities
2b922a9d064f8e Dan Williams     2021-09-03   22   * appended to bridged and endpoint devices.
2b922a9d064f8e Dan Williams     2021-09-03   23   *
2b922a9d064f8e Dan Williams     2021-09-03   24   * Provide common infrastructure for enumerating and mapping these
2b922a9d064f8e Dan Williams     2021-09-03   25   * discrete capabilities.
2b922a9d064f8e Dan Williams     2021-09-03   26   */
2b922a9d064f8e Dan Williams     2021-09-03   27  
0f06157e0135f5 Dan Williams     2021-08-03   28  /**
0f06157e0135f5 Dan Williams     2021-08-03   29   * cxl_probe_component_regs() - Detect CXL Component register blocks
0f06157e0135f5 Dan Williams     2021-08-03   30   * @dev: Host device of the @base mapping
0f06157e0135f5 Dan Williams     2021-08-03   31   * @base: Mapping containing the HDM Decoder Capability Header
0f06157e0135f5 Dan Williams     2021-08-03   32   * @map: Map object describing the register block information found
0f06157e0135f5 Dan Williams     2021-08-03   33   *
0f06157e0135f5 Dan Williams     2021-08-03   34   * See CXL 2.0 8.2.4 Component Register Layout and Definition
0f06157e0135f5 Dan Williams     2021-08-03   35   * See CXL 2.0 8.2.5.5 CXL Device Register Interface
0f06157e0135f5 Dan Williams     2021-08-03   36   *
0f06157e0135f5 Dan Williams     2021-08-03   37   * Probe for component register information and return it in map object.
0f06157e0135f5 Dan Williams     2021-08-03   38   */
0f06157e0135f5 Dan Williams     2021-08-03   39  void cxl_probe_component_regs(struct device *dev, void __iomem *base,
98279f48d53f4f Alejandro Lucero 2024-09-07   40  			      struct cxl_component_reg_map *map, u32 *caps)
0f06157e0135f5 Dan Williams     2021-08-03  @41  {
0f06157e0135f5 Dan Williams     2021-08-03   42  	int cap, cap_count;
74b0fe80409733 Jonathan Cameron 2022-02-01   43  	u32 cap_array;
0f06157e0135f5 Dan Williams     2021-08-03   44  
0f06157e0135f5 Dan Williams     2021-08-03   45  	*map = (struct cxl_component_reg_map) { 0 };
0f06157e0135f5 Dan Williams     2021-08-03   46  
0f06157e0135f5 Dan Williams     2021-08-03   47  	/*
0f06157e0135f5 Dan Williams     2021-08-03   48  	 * CXL.cache and CXL.mem registers are at offset 0x1000 as defined in
0f06157e0135f5 Dan Williams     2021-08-03   49  	 * CXL 2.0 8.2.4 Table 141.
0f06157e0135f5 Dan Williams     2021-08-03   50  	 */
0f06157e0135f5 Dan Williams     2021-08-03   51  	base += CXL_CM_OFFSET;
0f06157e0135f5 Dan Williams     2021-08-03   52  
74b0fe80409733 Jonathan Cameron 2022-02-01   53  	cap_array = readl(base + CXL_CM_CAP_HDR_OFFSET);
0f06157e0135f5 Dan Williams     2021-08-03   54  
0f06157e0135f5 Dan Williams     2021-08-03   55  	if (FIELD_GET(CXL_CM_CAP_HDR_ID_MASK, cap_array) != CM_CAP_HDR_CAP_ID) {
0f06157e0135f5 Dan Williams     2021-08-03   56  		dev_err(dev,
d621bc2e7282f9 Dan Williams     2022-01-23   57  			"Couldn't locate the CXL.cache and CXL.mem capability array header.\n");
0f06157e0135f5 Dan Williams     2021-08-03   58  		return;
0f06157e0135f5 Dan Williams     2021-08-03   59  	}
0f06157e0135f5 Dan Williams     2021-08-03   60  
0f06157e0135f5 Dan Williams     2021-08-03   61  	/* It's assumed that future versions will be backward compatible */
0f06157e0135f5 Dan Williams     2021-08-03   62  	cap_count = FIELD_GET(CXL_CM_CAP_HDR_ARRAY_SIZE_MASK, cap_array);
0f06157e0135f5 Dan Williams     2021-08-03   63  
0f06157e0135f5 Dan Williams     2021-08-03   64  	for (cap = 1; cap <= cap_count; cap++) {
0f06157e0135f5 Dan Williams     2021-08-03   65  		void __iomem *register_block;
af2dfef854aa6a Dan Williams     2022-11-29   66  		struct cxl_reg_map *rmap;
0f06157e0135f5 Dan Williams     2021-08-03   67  		u16 cap_id, offset;
af2dfef854aa6a Dan Williams     2022-11-29   68  		u32 length, hdr;
0f06157e0135f5 Dan Williams     2021-08-03   69  
0f06157e0135f5 Dan Williams     2021-08-03   70  		hdr = readl(base + cap * 0x4);
0f06157e0135f5 Dan Williams     2021-08-03   71  
0f06157e0135f5 Dan Williams     2021-08-03   72  		cap_id = FIELD_GET(CXL_CM_CAP_HDR_ID_MASK, hdr);
0f06157e0135f5 Dan Williams     2021-08-03   73  		offset = FIELD_GET(CXL_CM_CAP_PTR_MASK, hdr);
0f06157e0135f5 Dan Williams     2021-08-03   74  		register_block = base + offset;
af2dfef854aa6a Dan Williams     2022-11-29   75  		hdr = readl(register_block);
0f06157e0135f5 Dan Williams     2021-08-03   76  
af2dfef854aa6a Dan Williams     2022-11-29   77  		rmap = NULL;
0f06157e0135f5 Dan Williams     2021-08-03   78  		switch (cap_id) {
af2dfef854aa6a Dan Williams     2022-11-29   79  		case CXL_CM_CAP_CAP_ID_HDM: {
af2dfef854aa6a Dan Williams     2022-11-29   80  			int decoder_cnt;
af2dfef854aa6a Dan Williams     2022-11-29   81  
0f06157e0135f5 Dan Williams     2021-08-03   82  			dev_dbg(dev, "found HDM decoder capability (0x%x)\n",
0f06157e0135f5 Dan Williams     2021-08-03   83  				offset);
0f06157e0135f5 Dan Williams     2021-08-03   84  
0f06157e0135f5 Dan Williams     2021-08-03   85  			decoder_cnt = cxl_hdm_decoder_count(hdr);
0f06157e0135f5 Dan Williams     2021-08-03   86  			length = 0x20 * decoder_cnt + 0x10;
af2dfef854aa6a Dan Williams     2022-11-29   87  			rmap = &map->hdm_decoder;
98279f48d53f4f Alejandro Lucero 2024-09-07   88  			*caps |= BIT(CXL_DEV_CAP_HDM);
0f06157e0135f5 Dan Williams     2021-08-03   89  			break;
af2dfef854aa6a Dan Williams     2022-11-29   90  		}
bd09626b39dff9 Dan Williams     2022-11-29   91  		case CXL_CM_CAP_CAP_ID_RAS:
bd09626b39dff9 Dan Williams     2022-11-29   92  			dev_dbg(dev, "found RAS capability (0x%x)\n",
bd09626b39dff9 Dan Williams     2022-11-29   93  				offset);
bd09626b39dff9 Dan Williams     2022-11-29   94  			length = CXL_RAS_CAPABILITY_LENGTH;
bd09626b39dff9 Dan Williams     2022-11-29   95  			rmap = &map->ras;
98279f48d53f4f Alejandro Lucero 2024-09-07   96  			*caps |= BIT(CXL_DEV_CAP_RAS);
0f06157e0135f5 Dan Williams     2021-08-03   97  			break;
0f06157e0135f5 Dan Williams     2021-08-03   98  		default:
0f06157e0135f5 Dan Williams     2021-08-03   99  			dev_dbg(dev, "Unknown CM cap ID: %d (0x%x)\n", cap_id,
0f06157e0135f5 Dan Williams     2021-08-03  100  				offset);
0f06157e0135f5 Dan Williams     2021-08-03  101  			break;
0f06157e0135f5 Dan Williams     2021-08-03  102  		}
af2dfef854aa6a Dan Williams     2022-11-29  103  
af2dfef854aa6a Dan Williams     2022-11-29  104  		if (!rmap)
af2dfef854aa6a Dan Williams     2022-11-29  105  			continue;
af2dfef854aa6a Dan Williams     2022-11-29  106  		rmap->valid = true;
a1554e9cac5ea0 Dan Williams     2022-11-29  107  		rmap->id = cap_id;
af2dfef854aa6a Dan Williams     2022-11-29  108  		rmap->offset = CXL_CM_OFFSET + offset;
af2dfef854aa6a Dan Williams     2022-11-29  109  		rmap->size = length;
0f06157e0135f5 Dan Williams     2021-08-03  110  	}
0f06157e0135f5 Dan Williams     2021-08-03  111  }
affec782742e08 Dan Williams     2021-11-12  112  EXPORT_SYMBOL_NS_GPL(cxl_probe_component_regs, CXL);
0f06157e0135f5 Dan Williams     2021-08-03  113  
0f06157e0135f5 Dan Williams     2021-08-03  114  /**
0f06157e0135f5 Dan Williams     2021-08-03  115   * cxl_probe_device_regs() - Detect CXL Device register blocks
0f06157e0135f5 Dan Williams     2021-08-03  116   * @dev: Host device of the @base mapping
0f06157e0135f5 Dan Williams     2021-08-03  117   * @base: Mapping of CXL 2.0 8.2.8 CXL Device Register Interface
0f06157e0135f5 Dan Williams     2021-08-03  118   * @map: Map object describing the register block information found
0f06157e0135f5 Dan Williams     2021-08-03  119   *
0f06157e0135f5 Dan Williams     2021-08-03  120   * Probe for device register information and return it in map object.
0f06157e0135f5 Dan Williams     2021-08-03  121   */
0f06157e0135f5 Dan Williams     2021-08-03  122  void cxl_probe_device_regs(struct device *dev, void __iomem *base,
98279f48d53f4f Alejandro Lucero 2024-09-07  123  			   struct cxl_device_reg_map *map, u32 *caps)
0f06157e0135f5 Dan Williams     2021-08-03 @124  {
0f06157e0135f5 Dan Williams     2021-08-03  125  	int cap, cap_count;
0f06157e0135f5 Dan Williams     2021-08-03  126  	u64 cap_array;
0f06157e0135f5 Dan Williams     2021-08-03  127  
0f06157e0135f5 Dan Williams     2021-08-03  128  	*map = (struct cxl_device_reg_map){ 0 };
0f06157e0135f5 Dan Williams     2021-08-03  129  
0f06157e0135f5 Dan Williams     2021-08-03  130  	cap_array = readq(base + CXLDEV_CAP_ARRAY_OFFSET);
0f06157e0135f5 Dan Williams     2021-08-03  131  	if (FIELD_GET(CXLDEV_CAP_ARRAY_ID_MASK, cap_array) !=
0f06157e0135f5 Dan Williams     2021-08-03  132  	    CXLDEV_CAP_ARRAY_CAP_ID)
0f06157e0135f5 Dan Williams     2021-08-03  133  		return;
0f06157e0135f5 Dan Williams     2021-08-03  134  
0f06157e0135f5 Dan Williams     2021-08-03  135  	cap_count = FIELD_GET(CXLDEV_CAP_ARRAY_COUNT_MASK, cap_array);
0f06157e0135f5 Dan Williams     2021-08-03  136  
0f06157e0135f5 Dan Williams     2021-08-03  137  	for (cap = 1; cap <= cap_count; cap++) {
af2dfef854aa6a Dan Williams     2022-11-29  138  		struct cxl_reg_map *rmap;
0f06157e0135f5 Dan Williams     2021-08-03  139  		u32 offset, length;
0f06157e0135f5 Dan Williams     2021-08-03  140  		u16 cap_id;
0f06157e0135f5 Dan Williams     2021-08-03  141  
0f06157e0135f5 Dan Williams     2021-08-03  142  		cap_id = FIELD_GET(CXLDEV_CAP_HDR_CAP_ID_MASK,
0f06157e0135f5 Dan Williams     2021-08-03  143  				   readl(base + cap * 0x10));
0f06157e0135f5 Dan Williams     2021-08-03  144  		offset = readl(base + cap * 0x10 + 0x4);
0f06157e0135f5 Dan Williams     2021-08-03  145  		length = readl(base + cap * 0x10 + 0x8);
0f06157e0135f5 Dan Williams     2021-08-03  146  
af2dfef854aa6a Dan Williams     2022-11-29  147  		rmap = NULL;
0f06157e0135f5 Dan Williams     2021-08-03  148  		switch (cap_id) {
0f06157e0135f5 Dan Williams     2021-08-03  149  		case CXLDEV_CAP_CAP_ID_DEVICE_STATUS:
0f06157e0135f5 Dan Williams     2021-08-03  150  			dev_dbg(dev, "found Status capability (0x%x)\n", offset);
af2dfef854aa6a Dan Williams     2022-11-29  151  			rmap = &map->status;
98279f48d53f4f Alejandro Lucero 2024-09-07  152  			*caps |= BIT(CXL_DEV_CAP_DEV_STATUS);
0f06157e0135f5 Dan Williams     2021-08-03  153  			break;
0f06157e0135f5 Dan Williams     2021-08-03  154  		case CXLDEV_CAP_CAP_ID_PRIMARY_MAILBOX:
0f06157e0135f5 Dan Williams     2021-08-03  155  			dev_dbg(dev, "found Mailbox capability (0x%x)\n", offset);
af2dfef854aa6a Dan Williams     2022-11-29  156  			rmap = &map->mbox;
98279f48d53f4f Alejandro Lucero 2024-09-07  157  			*caps |= BIT(CXL_DEV_CAP_MAILBOX_PRIMARY);
0f06157e0135f5 Dan Williams     2021-08-03  158  			break;
0f06157e0135f5 Dan Williams     2021-08-03  159  		case CXLDEV_CAP_CAP_ID_SECONDARY_MAILBOX:
0f06157e0135f5 Dan Williams     2021-08-03  160  			dev_dbg(dev, "found Secondary Mailbox capability (0x%x)\n", offset);
0f06157e0135f5 Dan Williams     2021-08-03  161  			break;
0f06157e0135f5 Dan Williams     2021-08-03  162  		case CXLDEV_CAP_CAP_ID_MEMDEV:
0f06157e0135f5 Dan Williams     2021-08-03  163  			dev_dbg(dev, "found Memory Device capability (0x%x)\n", offset);
af2dfef854aa6a Dan Williams     2022-11-29  164  			rmap = &map->memdev;
98279f48d53f4f Alejandro Lucero 2024-09-07  165  			*caps |= BIT(CXL_DEV_CAP_MEMDEV);
0f06157e0135f5 Dan Williams     2021-08-03  166  			break;
0f06157e0135f5 Dan Williams     2021-08-03  167  		default:
0f06157e0135f5 Dan Williams     2021-08-03  168  			if (cap_id >= 0x8000)
0f06157e0135f5 Dan Williams     2021-08-03  169  				dev_dbg(dev, "Vendor cap ID: %#x offset: %#x\n", cap_id, offset);
0f06157e0135f5 Dan Williams     2021-08-03  170  			else
0f06157e0135f5 Dan Williams     2021-08-03  171  				dev_dbg(dev, "Unknown cap ID: %#x offset: %#x\n", cap_id, offset);
0f06157e0135f5 Dan Williams     2021-08-03  172  			break;
0f06157e0135f5 Dan Williams     2021-08-03  173  		}
af2dfef854aa6a Dan Williams     2022-11-29  174  
af2dfef854aa6a Dan Williams     2022-11-29  175  		if (!rmap)
af2dfef854aa6a Dan Williams     2022-11-29  176  			continue;
af2dfef854aa6a Dan Williams     2022-11-29  177  		rmap->valid = true;
a1554e9cac5ea0 Dan Williams     2022-11-29  178  		rmap->id = cap_id;
af2dfef854aa6a Dan Williams     2022-11-29  179  		rmap->offset = offset;
af2dfef854aa6a Dan Williams     2022-11-29  180  		rmap->size = length;
0f06157e0135f5 Dan Williams     2021-08-03  181  	}
0f06157e0135f5 Dan Williams     2021-08-03  182  }
affec782742e08 Dan Williams     2021-11-12  183  EXPORT_SYMBOL_NS_GPL(cxl_probe_device_regs, CXL);
0f06157e0135f5 Dan Williams     2021-08-03  184  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

