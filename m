Return-Path: <netdev+bounces-112296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A278A9381B4
	for <lists+netdev@lfdr.de>; Sat, 20 Jul 2024 16:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9C6AB20E97
	for <lists+netdev@lfdr.de>; Sat, 20 Jul 2024 14:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DEE512F581;
	Sat, 20 Jul 2024 14:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cl3UmVyb"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F2C8564A;
	Sat, 20 Jul 2024 14:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721486049; cv=none; b=i1MuSMcvFWpCBpqNJDDcimh1Qv3BOJhZO2jNYIgEXt7BZwSo/WCdghNfHtX5oaHxW+JakGcvGUr8s63qKGEyLbY2H4p6giK01sMJ+mkwkSywbx2GjXlvxuZvcHP4pMCHxQOqdOC2TELcX20lRBeOM/61H8aYY3/UwZagdEf3p0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721486049; c=relaxed/simple;
	bh=dRWWphHhlnVSS4YQZ5YVkQpfXbV2JxEknriVX8N+8J4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LZsQhr8TzoH48JxlWNQKSeISCodJXMmryfQaiAsjDFtPteyFDuh+R9DZ3AQFdETkkeeivBpoc0cBXAxj3Gw0t+rWqhyMaN4PRGmMiCJOHJlsoOmOFL4anKLelJl40d6ZOj6yXjxEtgPLfUSFASonYbUK30FtBrNA4gfYPgDN2+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cl3UmVyb; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721486047; x=1753022047;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dRWWphHhlnVSS4YQZ5YVkQpfXbV2JxEknriVX8N+8J4=;
  b=Cl3UmVybUFujkgn7BtlYtEZRug55DqpcuSbYkdQNftO9QGgjrX6CgB4t
   ZGcwf11sYyNDhe/K9kZyiZN/OZUnrL3fJWkOBdilurZ1PNfSIBCrUyde0
   VIq8ZhTGZUOnAUdC7S1whotmlNIUDZtk9X5ZycWiSi5RDIAtVvvEO2wJ9
   2YkZcSTXYDdYrAqEzDAok5vENKEN9P4fuhw0z2pxQovCxTLvLkYLJ4h8C
   kW31dIGisJFRXvaaI0JEgrWCTjYdds0+usBYvQ13mnlmvv5WrgtkbREYP
   YIXtqi5IHeB8hKhmLvweoslNz5P1kwBf+tE5e+5HHfEk4mcibb39rFOJN
   Q==;
X-CSE-ConnectionGUID: zcLpz7fjQCKA5UJA9XLLEQ==
X-CSE-MsgGUID: 5drU0XY5TzWKOsG+221MVw==
X-IronPort-AV: E=McAfee;i="6700,10204,11139"; a="18720334"
X-IronPort-AV: E=Sophos;i="6.09,224,1716274800"; 
   d="scan'208";a="18720334"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2024 07:34:06 -0700
X-CSE-ConnectionGUID: sAVdlJcxQemXUhP7ZNA62g==
X-CSE-MsgGUID: GH6ZgubQSE2ZtJfxqVnmVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,224,1716274800"; 
   d="scan'208";a="52118364"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 20 Jul 2024 07:34:01 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sVB9q-000jHM-1b;
	Sat, 20 Jul 2024 14:33:58 +0000
Date: Sat, 20 Jul 2024 22:33:10 +0800
From: kernel test robot <lkp@intel.com>
To: Ayush Singh <ayush@beagleboard.org>, jkridner@beagleboard.org,
	robertcnelson@beagleboard.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	greybus-dev@lists.linaro.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Ayush Singh <ayush@beagleboard.org>
Subject: Re: [PATCH 3/3] greybus: gb-beagleplay: Add firmware upload API
Message-ID: <202407210006.Wvm3bOm9-lkp@intel.com>
References: <20240719-beagleplay_fw_upgrade-v1-3-8664d4513252@beagleboard.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240719-beagleplay_fw_upgrade-v1-3-8664d4513252@beagleboard.org>

Hi Ayush,

kernel test robot noticed the following build warnings:

[auto build test WARNING on f76698bd9a8ca01d3581236082d786e9a6b72bb7]

url:    https://github.com/intel-lab-lkp/linux/commits/Ayush-Singh/dt-bindings-net-ti-cc1352p7-Add-boot-gpio/20240719-180050
base:   f76698bd9a8ca01d3581236082d786e9a6b72bb7
patch link:    https://lore.kernel.org/r/20240719-beagleplay_fw_upgrade-v1-3-8664d4513252%40beagleboard.org
patch subject: [PATCH 3/3] greybus: gb-beagleplay: Add firmware upload API
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20240721/202407210006.Wvm3bOm9-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240721/202407210006.Wvm3bOm9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407210006.Wvm3bOm9-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/greybus/gb-beagleplay.c:132: warning: Enum value 'COMMAND_DOWNLOAD' not described in enum 'cc1352_bootloader_cmd'
>> drivers/greybus/gb-beagleplay.c:132: warning: Enum value 'COMMAND_GET_STATUS' not described in enum 'cc1352_bootloader_cmd'
>> drivers/greybus/gb-beagleplay.c:132: warning: Enum value 'COMMAND_SEND_DATA' not described in enum 'cc1352_bootloader_cmd'
>> drivers/greybus/gb-beagleplay.c:132: warning: Enum value 'COMMAND_RESET' not described in enum 'cc1352_bootloader_cmd'
>> drivers/greybus/gb-beagleplay.c:132: warning: Enum value 'COMMAND_CRC32' not described in enum 'cc1352_bootloader_cmd'
>> drivers/greybus/gb-beagleplay.c:132: warning: Enum value 'COMMAND_BANK_ERASE' not described in enum 'cc1352_bootloader_cmd'
>> drivers/greybus/gb-beagleplay.c:143: warning: Enum value 'COMMAND_RET_SUCCESS' not described in enum 'cc1352_bootloader_status'
>> drivers/greybus/gb-beagleplay.c:143: warning: Enum value 'COMMAND_RET_UNKNOWN_CMD' not described in enum 'cc1352_bootloader_status'
>> drivers/greybus/gb-beagleplay.c:143: warning: Enum value 'COMMAND_RET_INVALID_CMD' not described in enum 'cc1352_bootloader_status'
>> drivers/greybus/gb-beagleplay.c:143: warning: Enum value 'COMMAND_RET_INVALID_ADR' not described in enum 'cc1352_bootloader_status'
>> drivers/greybus/gb-beagleplay.c:143: warning: Enum value 'COMMAND_RET_FLASH_FAIL' not described in enum 'cc1352_bootloader_status'
>> drivers/greybus/gb-beagleplay.c:420: warning: Function parameter or struct member 'data' not described in 'csum8'
>> drivers/greybus/gb-beagleplay.c:420: warning: Function parameter or struct member 'size' not described in 'csum8'
>> drivers/greybus/gb-beagleplay.c:420: warning: Function parameter or struct member 'base' not described in 'csum8'
>> drivers/greybus/gb-beagleplay.c:712: warning: Function parameter or struct member 'data' not described in 'cc1352_bootloader_empty_pkt'
>> drivers/greybus/gb-beagleplay.c:712: warning: Function parameter or struct member 'size' not described in 'cc1352_bootloader_empty_pkt'


vim +132 drivers/greybus/gb-beagleplay.c

   121	
   122	/**
   123	 * enum cc1352_bootloader_cmd: CC1352 Bootloader Commands
   124	 */
   125	enum cc1352_bootloader_cmd {
   126		COMMAND_DOWNLOAD = 0x21,
   127		COMMAND_GET_STATUS = 0x23,
   128		COMMAND_SEND_DATA = 0x24,
   129		COMMAND_RESET = 0x25,
   130		COMMAND_CRC32 = 0x27,
   131		COMMAND_BANK_ERASE = 0x2c,
 > 132	};
   133	
   134	/**
   135	 * enum cc1352_bootloader_status: CC1352 Bootloader COMMAND_GET_STATUS response
   136	 */
   137	enum cc1352_bootloader_status {
   138		COMMAND_RET_SUCCESS = 0x40,
   139		COMMAND_RET_UNKNOWN_CMD = 0x41,
   140		COMMAND_RET_INVALID_CMD = 0x42,
   141		COMMAND_RET_INVALID_ADR = 0x43,
   142		COMMAND_RET_FLASH_FAIL = 0x44,
 > 143	};
   144	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

