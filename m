Return-Path: <netdev+bounces-210279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7103B12A1D
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 12:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6C6E561CF6
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 10:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8819923F429;
	Sat, 26 Jul 2025 10:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="feMXlgtm"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC13823BF91;
	Sat, 26 Jul 2025 10:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753526252; cv=none; b=XOJAFJz6QmUErH2SrqCex+FaFV2aa6L1zD9dzq3JAi4ctw85AD1xMQTLlPozMsseiLpvSWjFkzETq9ZpHTFCJVhpZ1tWuh5UC0YFZDpRublUJHDp+DsA129dqF40MgcrQfJoku5ohV3TNicM/pf+BuQL7mDGttKxTX8Ofa9hSR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753526252; c=relaxed/simple;
	bh=8vHHoYjenljuKgZ9Ep34XRZPCFDanp20WFBiPhZRta0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QafuwSArjsR8XZwfm8ZTC6y2f0juZnoEAT2B0QEccyqIHZdlw5uKq8dkRzQVJfN93cAbwkjjCcilJt+F7TRMMiIEaMdwY8w01e5FENaT3EXdB8IzJ59MCiM/6jhmUzWz+pdMjQnvpJBpzx91HjHa+1lI+/gQjWeTE27RQ4EaMBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=feMXlgtm; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753526251; x=1785062251;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8vHHoYjenljuKgZ9Ep34XRZPCFDanp20WFBiPhZRta0=;
  b=feMXlgtmu6rVaT2PFo0k3Tf6mIRGczGuJqY5SA2TTZao5T8pFV6zugLo
   MBNVWfrOx3iHI2sx6E47FWhZ71jw6jigtq3OpVEqI2CizZQjICx/OrkSw
   9YRr6tFc0CO9Zs9poInZr30BAWGR04fclJvMASGj709sURgdk9c65iv/m
   FyAodd+dQ9tHODrLootvqYc+ijWIiFohirAmv55NGSf9tJ88HNG2y41jV
   qEcESHGyGWUUJDkCZwzcXd55/gHZvjwcm6Ep/iAPwmZZzTNrRt6HH1dA8
   M2KkxaCZK9bE7InOofU6kRS5zmsd4iC581ym285Fui5YeO3uRGcIIjbdo
   g==;
X-CSE-ConnectionGUID: VO5ow9ZVRNeFDxTjV3LnUw==
X-CSE-MsgGUID: K2jbAs4iQ8epmCESPP7Mog==
X-IronPort-AV: E=McAfee;i="6800,10657,11503"; a="55704395"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="55704395"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2025 03:37:31 -0700
X-CSE-ConnectionGUID: NeZvv0EXRCGV8sFgGsxMDg==
X-CSE-MsgGUID: h1CAuaWRTG2GdosNyvmAPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="161413942"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 26 Jul 2025 03:37:27 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ufcHM-000Lsp-2o;
	Sat, 26 Jul 2025 10:37:24 +0000
Date: Sat, 26 Jul 2025 18:36:56 +0800
From: kernel test robot <lkp@intel.com>
To: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Jiri Pirko <jiri@resnulli.us>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Michal Schmidt <mschmidt@redhat.com>, Petr Oros <poros@redhat.com>
Subject: Re: [PATCH net-next 2/5] dpll: zl3073x: Add low-level flash functions
Message-ID: <202507261837.ofrYjyeT-lkp@intel.com>
References: <20250725154136.1008132-3-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725154136.1008132-3-ivecera@redhat.com>

Hi Ivan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Ivan-Vecera/dpll-zl3073x-Add-functions-to-access-hardware-registers/20250725-234600
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250725154136.1008132-3-ivecera%40redhat.com
patch subject: [PATCH net-next 2/5] dpll: zl3073x: Add low-level flash functions
config: x86_64-buildonly-randconfig-003-20250726 (https://download.01.org/0day-ci/archive/20250726/202507261837.ofrYjyeT-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250726/202507261837.ofrYjyeT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507261837.ofrYjyeT-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/dpll/zl3073x/flash.c: In function 'zl3073x_flash_sectors':
>> drivers/dpll/zl3073x/flash.c:294:70: warning: '%zu' directive output may be truncated writing between 1 and 15 bytes into a region of size 11 [-Wformat-truncation=]
     294 |                         snprintf(comp_str, sizeof(comp_str), "%s-part%zu",
         |                                                                      ^~~
   drivers/dpll/zl3073x/flash.c:294:62: note: directive argument in the range [1, 281474976710656]
     294 |                         snprintf(comp_str, sizeof(comp_str), "%s-part%zu",
         |                                                              ^~~~~~~~~~~~
   drivers/dpll/zl3073x/flash.c:294:25: note: 'snprintf' output 7 or more bytes (assuming 21) into a destination of size 16
     294 |                         snprintf(comp_str, sizeof(comp_str), "%s-part%zu",
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     295 |                                  component, (ptr - data) / max_block_size + 1);
         |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +294 drivers/dpll/zl3073x/flash.c

   245	
   246	/**
   247	 * zl3073x_flash_sectors - Flash sectors
   248	 * @zldev: zl3073x device structure
   249	 * @component: component name
   250	 * @page: destination flash page
   251	 * @addr: device memory address to load data
   252	 * @data: pointer to data to be flashed
   253	 * @size: size of data
   254	 * @extack: netlink extack pointer to report errors
   255	 *
   256	 * The function flashes given @data with size of @size to the internal flash
   257	 * memory block starting from page @page. The function uses sector flash
   258	 * method and has to take into account the flash sector size reported by
   259	 * flashing utility. Input data are spliced into blocks according this
   260	 * sector size and each block is flashed separately.
   261	 *
   262	 * Return: 0 on success, <0 on error
   263	 */
   264	int zl3073x_flash_sectors(struct zl3073x_dev *zldev, const char *component,
   265				  u32 page, u32 addr, const void *data, size_t size,
   266				  struct netlink_ext_ack *extack)
   267	{
   268	#define ZL_FLASH_MAX_BLOCK_SIZE	0x0001E000
   269	#define ZL_FLASH_PAGE_SIZE	256
   270		size_t max_block_size, block_size, sector_size;
   271		const void *ptr, *end;
   272		int rc;
   273	
   274		/* Get flash sector size */
   275		rc = zl3073x_flash_get_sector_size(zldev, &sector_size);
   276		if (rc) {
   277			ZL_FLASH_ERR_MSG(zldev, extack,
   278					 "Failed to get flash sector size");
   279			return rc;
   280		}
   281	
   282		/* Determine max block size depending on sector size */
   283		max_block_size = ALIGN_DOWN(ZL_FLASH_MAX_BLOCK_SIZE, sector_size);
   284	
   285		for (ptr = data, end = data + size; ptr < end; ptr += block_size) {
   286			char comp_str[16];
   287	
   288			block_size = min_t(size_t, max_block_size, end - ptr);
   289	
   290			/* Add suffix '-partN' if the requested component size is
   291			 * greater than max_block_size.
   292			 */
   293			if (max_block_size < size)
 > 294				snprintf(comp_str, sizeof(comp_str), "%s-part%zu",
   295					 component, (ptr - data) / max_block_size + 1);
   296			else
   297				strscpy(comp_str, component);
   298	
   299			/* Download block to device memory */
   300			rc = zl3073x_flash_download(zldev, comp_str, addr, ptr,
   301						    block_size, extack);
   302			if (rc)
   303				goto finish;
   304	
   305			/* Set address to flash from */
   306			rc = zl3073x_write_u32(zldev, ZL_REG_IMAGE_START_ADDR, addr);
   307			if (rc)
   308				goto finish;
   309	
   310			/* Set size of block to flash */
   311			rc = zl3073x_write_u32(zldev, ZL_REG_IMAGE_SIZE, block_size);
   312			if (rc)
   313				goto finish;
   314	
   315			/* Set destination page to flash */
   316			rc = zl3073x_write_u32(zldev, ZL_REG_FLASH_INDEX_WRITE, page);
   317			if (rc)
   318				goto finish;
   319	
   320			/* Set filling pattern */
   321			rc = zl3073x_write_u32(zldev, ZL_REG_FILL_PATTERN, U32_MAX);
   322			if (rc)
   323				goto finish;
   324	
   325			zl3073x_devlink_flash_notify(zldev, "Flashing image", comp_str,
   326						     0, 0);
   327	
   328			dev_dbg(zldev->dev, "Flashing %zu bytes to page %u\n",
   329				block_size, page);
   330	
   331			/* Execute sectors flash operation */
   332			rc = zl3073x_flash_cmd_wait(zldev, ZL_WRITE_FLASH_OP_SECTORS,
   333						    extack);
   334			if (rc)
   335				goto finish;
   336	
   337			/* Move to next page */
   338			page += block_size / ZL_FLASH_PAGE_SIZE;
   339		}
   340	
   341	finish:
   342		zl3073x_devlink_flash_notify(zldev,
   343					     rc ?  "Flashing failed" : "Flashing done",
   344					     component, 0, 0);
   345	
   346		return rc;
   347	}
   348	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

