Return-Path: <netdev+bounces-151989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 075529F24A5
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 16:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 594EB1885F23
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 15:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B4417C220;
	Sun, 15 Dec 2024 15:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n2/GPeX+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D973CDDC5;
	Sun, 15 Dec 2024 15:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734276834; cv=none; b=j6GyKaRG5b64Ike9OFkcEidD/XVQTbZ5GDG/2+BxzMlelFAZUoj8vNVxWd8LDUoExwyozJ8R/y1GpE13i5XBZ2m10FEsMKqE4eYVPROA64m3FAYxvQwgFBaFf1iYkOGsEoHjI6vjZns1WfCfVOfHofv9nuyx1fCFdo/R5M75CRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734276834; c=relaxed/simple;
	bh=ThleubWW5RiOKFLPPiGNY+AK2frAESrbkXe3fkxfAf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uk8U/L2Vtwvg97OPLiS5/GGqxxXTgwBzB8lVZBob3pgSQ06lAXBwDwF0iPi1OdmOcnt/5L+MAkaKx+sKn2TzgoM0w+t3Ie4othzwfK/jRXn+v1qbEvovlbjQJOjc0UMFW5MXzu1kVvZ+i3N8qSWmyyZmNygvXKogeK+33Gx+knQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n2/GPeX+; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734276833; x=1765812833;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ThleubWW5RiOKFLPPiGNY+AK2frAESrbkXe3fkxfAf8=;
  b=n2/GPeX+Cmbza8YxoTbEl55wacl+CJnfEFKCMdghJdpTMVZ685rSNSpY
   GdNK/cKetc4WOxKVO/o3C30M8IHbMC9PRwm4xxjoQivHxcKtBIk4qGuH1
   fk0JwIVNP80CsFtw2C8knxeqtGI/F25uHvjB9IVCmjLFAg+GLyw0VNCpy
   E27LU6xZt+MFZFtTONScNIgfJ+6fwhs1BjSPOSPtMZimi+3PKXcSc9Mm0
   E63ziDiPJACzK37CldBgfe4w/8jeTUStJ4tGTEijNyC4fD6kLINBX90Jg
   RJnecmepQO+PMyCyz8ItWpUUBrNj+NcoSX0uT5QcZY3K9MWYuyp+neGBn
   w==;
X-CSE-ConnectionGUID: Bi6GPxe4RcWVNcSFGirdpg==
X-CSE-MsgGUID: Qfr4N39lSImGugEJMDgIww==
X-IronPort-AV: E=McAfee;i="6700,10204,11278"; a="46065661"
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; 
   d="scan'208";a="46065661"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2024 07:33:53 -0800
X-CSE-ConnectionGUID: qjxLxqDsSC+uxUqgu1OATQ==
X-CSE-MsgGUID: Sme2GdH2Rh+oae9rNHqPIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="127966776"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 15 Dec 2024 07:33:50 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tMqct-000Dgo-1o;
	Sun, 15 Dec 2024 15:33:47 +0000
Date: Sun, 15 Dec 2024 23:33:44 +0800
From: kernel test robot <lkp@intel.com>
To: Matthieu Buffet <matthieu@buffet.re>, Mickael Salaun <mic@digikod.net>
Cc: oe-kbuild-all@lists.linux.dev, Gunther Noack <gnoack@google.com>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
	Matthieu Buffet <matthieu@buffet.re>
Subject: Re: [PATCH v2 3/6] landlock: Add UDP sendmsg access control
Message-ID: <202412152346.CRX05ecl-lkp@intel.com>
References: <20241214184540.3835222-4-matthieu@buffet.re>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241214184540.3835222-4-matthieu@buffet.re>

Hi Matthieu,

kernel test robot noticed the following build errors:

[auto build test ERROR on adc218676eef25575469234709c2d87185ca223a]

url:    https://github.com/intel-lab-lkp/linux/commits/Matthieu-Buffet/landlock-Add-UDP-bind-connect-access-control/20241215-025450
base:   adc218676eef25575469234709c2d87185ca223a
patch link:    https://lore.kernel.org/r/20241214184540.3835222-4-matthieu%40buffet.re
patch subject: [PATCH v2 3/6] landlock: Add UDP sendmsg access control
config: nios2-randconfig-001-20241215 (https://download.01.org/0day-ci/archive/20241215/202412152346.CRX05ecl-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241215/202412152346.CRX05ecl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412152346.CRX05ecl-lkp@intel.com/

All errors (new ones prefixed by >>):

   nios2-linux-ld: security/landlock/net.o: in function `hook_socket_sendmsg':
>> net.c:(.text+0x448): undefined reference to `udpv6_prot'
>> nios2-linux-ld: net.c:(.text+0x44c): undefined reference to `udpv6_prot'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

