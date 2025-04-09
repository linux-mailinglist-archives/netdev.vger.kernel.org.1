Return-Path: <netdev+bounces-180565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 104A8A81B09
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 04:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBBB21BA07D1
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 02:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777E213C9B3;
	Wed,  9 Apr 2025 02:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BaFX404k"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFFBEADC;
	Wed,  9 Apr 2025 02:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744165960; cv=none; b=dvKAMLEex09rL8VEoygf+hSAznhiYb0FavuCDs9dE0PSXtXCLP+X1JOo6gb/Mg2cgvTXceUdjA4eBZjBUT4md+xG884hm7nJb9pFK6M6eTrKQpWnJa2k+RE1akfZbJsc9SvPKgzzLIOgfG38QQuB6GEZXnIS4ry/0S12ixzLitQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744165960; c=relaxed/simple;
	bh=HNQzH55xdd7zva6/lSq1EPnsmjcbuOwMgbzKhT9mwwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iDAwSXd+MMIEmX2nmlsX5f78F/paUm7f+RSvXzk/PH1UyXlHw4pnA+AatsDybzLC53UqaCbgkBqIUWfwLIxXH6fLWqGZA1SeQnozi09o3Ysn9UqH2Oi5CuuRLskrooiwMJYsGYzFD+TIEQuKIBl5jVtk6IEUxncuqRj5r0M0XSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BaFX404k; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744165959; x=1775701959;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HNQzH55xdd7zva6/lSq1EPnsmjcbuOwMgbzKhT9mwwI=;
  b=BaFX404kWkmIigX8vauc5j9/oknAi7R5txGD+mzKjga1dTLsj0KzyxsX
   4pDC4n9h0hH+/QPRsQ5bWEk0JB3n+8epNghjeH+6SQo+wjXk7CcNJydUY
   +k321dvz7yPVqUbrIy9WcPETpEPbi27RJRUVnWloCYEEQ/KH/igSWGR4j
   E+rd2w6up6QiT2p4U69SkLywVudSylxuLF6+cJPqbK1q8x34MLCl5ChoB
   2QmBhjsWZjeruzKS8izVLFMwVSCxQj5Qs3lFj5HuyHcqZ3uGw5lqm5zJ5
   ObHYbtTCuVKFzfTnqWOS/fvcNwfQhlE6eDwBn+QH0gHN9InpKYcf6ghln
   w==;
X-CSE-ConnectionGUID: muwwKvRKT2qmmmGHD3Gx1w==
X-CSE-MsgGUID: UYTRkbjfQz6zLK4+kEJxxw==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="49465344"
X-IronPort-AV: E=Sophos;i="6.15,199,1739865600"; 
   d="scan'208";a="49465344"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 19:32:37 -0700
X-CSE-ConnectionGUID: HxVzNHyGRLaAliAU/QAp8g==
X-CSE-MsgGUID: Vwg69OLpTfmO4uwh4VNWDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,199,1739865600"; 
   d="scan'208";a="151634019"
Received: from lkp-server01.sh.intel.com (HELO b207828170a5) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 08 Apr 2025 19:32:33 -0700
Received: from kbuild by b207828170a5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u2LEt-0008CR-03;
	Wed, 09 Apr 2025 02:32:31 +0000
Date: Wed, 9 Apr 2025 10:32:01 +0800
From: kernel test robot <lkp@intel.com>
To: Sean Anderson <sean.anderson@linux.dev>, netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, upstream@airoha.com,
	Christian Marangi <ansuelsmth@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: Re: [net-next PATCH v2 02/14] device property: Add optional
 nargs_prop for get_reference_args
Message-ID: <202504091059.k4s8cs0e-lkp@intel.com>
References: <20250407231746.2316518-3-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407231746.2316518-3-sean.anderson@linux.dev>

Hi Sean,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Sean-Anderson/dt-bindings-net-Add-Xilinx-PCS/20250408-072650
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250407231746.2316518-3-sean.anderson%40linux.dev
patch subject: [net-next PATCH v2 02/14] device property: Add optional nargs_prop for get_reference_args
config: riscv-randconfig-001-20250409 (https://download.01.org/0day-ci/archive/20250409/202504091059.k4s8cs0e-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project 92c93f5286b9ff33f27ff694d2dc33da1c07afdd)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250409/202504091059.k4s8cs0e-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504091059.k4s8cs0e-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/acpi/property.c:1680:1: error: incompatible function pointer types initializing 'int (*)(const struct fwnode_handle *, const char *, const char *, int, unsigned int, struct fwnode_reference_args *)' with an expression of type 'int (const struct fwnode_handle *, const char *, const char *, unsigned int, unsigned int, struct fwnode_reference_args *)' [-Wincompatible-function-pointer-types]
    1680 | DECLARE_ACPI_FWNODE_OPS(acpi_device_fwnode_ops);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/acpi/property.c:1669:25: note: expanded from macro 'DECLARE_ACPI_FWNODE_OPS'
    1669 |                 .get_reference_args = acpi_fwnode_get_reference_args,   \
         |                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/acpi/property.c:1681:1: error: incompatible function pointer types initializing 'int (*)(const struct fwnode_handle *, const char *, const char *, int, unsigned int, struct fwnode_reference_args *)' with an expression of type 'int (const struct fwnode_handle *, const char *, const char *, unsigned int, unsigned int, struct fwnode_reference_args *)' [-Wincompatible-function-pointer-types]
    1681 | DECLARE_ACPI_FWNODE_OPS(acpi_data_fwnode_ops);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/acpi/property.c:1669:25: note: expanded from macro 'DECLARE_ACPI_FWNODE_OPS'
    1669 |                 .get_reference_args = acpi_fwnode_get_reference_args,   \
         |                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   2 errors generated.


vim +1680 drivers/acpi/property.c

99c63707bafd15 Sakari Ailus      2022-03-31  1650  
db3e50f3234ba1 Sakari Ailus      2017-07-21  1651  #define DECLARE_ACPI_FWNODE_OPS(ops) \
db3e50f3234ba1 Sakari Ailus      2017-07-21  1652  	const struct fwnode_operations ops = {				\
db3e50f3234ba1 Sakari Ailus      2017-07-21  1653  		.device_is_available = acpi_fwnode_device_is_available, \
146b4dbb0eef36 Sinan Kaya        2017-12-13  1654  		.device_get_match_data = acpi_fwnode_device_get_match_data, \
8c756a0a2de17f Sakari Ailus      2022-03-31  1655  		.device_dma_supported =				\
8c756a0a2de17f Sakari Ailus      2022-03-31  1656  			acpi_fwnode_device_dma_supported,		\
8c756a0a2de17f Sakari Ailus      2022-03-31  1657  		.device_get_dma_attr = acpi_fwnode_device_get_dma_attr,	\
db3e50f3234ba1 Sakari Ailus      2017-07-21  1658  		.property_present = acpi_fwnode_property_present,	\
bb3914101f704a Rob Herring (Arm  2025-01-09  1659) 		.property_read_bool = acpi_fwnode_property_present,	\
db3e50f3234ba1 Sakari Ailus      2017-07-21  1660  		.property_read_int_array =				\
db3e50f3234ba1 Sakari Ailus      2017-07-21  1661  			acpi_fwnode_property_read_int_array,		\
db3e50f3234ba1 Sakari Ailus      2017-07-21  1662  		.property_read_string_array =				\
db3e50f3234ba1 Sakari Ailus      2017-07-21  1663  			acpi_fwnode_property_read_string_array,		\
db3e50f3234ba1 Sakari Ailus      2017-07-21  1664  		.get_parent = acpi_node_get_parent,			\
db3e50f3234ba1 Sakari Ailus      2017-07-21  1665  		.get_next_child_node = acpi_get_next_subnode,		\
db3e50f3234ba1 Sakari Ailus      2017-07-21  1666  		.get_named_child_node = acpi_fwnode_get_named_child_node, \
bc0500c1e43d95 Sakari Ailus      2019-10-03  1667  		.get_name = acpi_fwnode_get_name,			\
e7e242bccb209b Sakari Ailus      2019-10-03  1668  		.get_name_prefix = acpi_fwnode_get_name_prefix,		\
3e3119d3088f41 Sakari Ailus      2017-07-21  1669  		.get_reference_args = acpi_fwnode_get_reference_args,	\
db3e50f3234ba1 Sakari Ailus      2017-07-21  1670  		.graph_get_next_endpoint =				\
0ef7478639c516 Sakari Ailus      2018-07-17  1671  			acpi_graph_get_next_endpoint,			\
db3e50f3234ba1 Sakari Ailus      2017-07-21  1672  		.graph_get_remote_endpoint =				\
0ef7478639c516 Sakari Ailus      2018-07-17  1673  			acpi_graph_get_remote_endpoint,			\
37ba983cfb47cc Sakari Ailus      2017-07-21  1674  		.graph_get_port_parent = acpi_fwnode_get_parent,	\
db3e50f3234ba1 Sakari Ailus      2017-07-21  1675  		.graph_parse_endpoint = acpi_fwnode_graph_parse_endpoint, \
99c63707bafd15 Sakari Ailus      2022-03-31  1676  		.irq_get = acpi_fwnode_irq_get,				\
db3e50f3234ba1 Sakari Ailus      2017-07-21  1677  	};								\
db3e50f3234ba1 Sakari Ailus      2017-07-21  1678  	EXPORT_SYMBOL_GPL(ops)
db3e50f3234ba1 Sakari Ailus      2017-07-21  1679  
db3e50f3234ba1 Sakari Ailus      2017-07-21 @1680  DECLARE_ACPI_FWNODE_OPS(acpi_device_fwnode_ops);
db3e50f3234ba1 Sakari Ailus      2017-07-21  1681  DECLARE_ACPI_FWNODE_OPS(acpi_data_fwnode_ops);
db3e50f3234ba1 Sakari Ailus      2017-07-21  1682  const struct fwnode_operations acpi_static_fwnode_ops;
9e987b70ada275 John Hubbard      2017-09-15  1683  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

