Return-Path: <netdev+bounces-103734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0A0909403
	for <lists+netdev@lfdr.de>; Sat, 15 Jun 2024 00:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9118B22926
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 22:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99DE185097;
	Fri, 14 Jun 2024 22:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xk7r51tr"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C284A1487ED;
	Fri, 14 Jun 2024 22:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718402672; cv=none; b=uU6jlfKoQqKVCRvMKO3b5DesP52dOIxUkD1ppsh27y3CLinl3bEQg/LNAyob7uCVNFuKlIPTu1egumCZDxrgqwFvIob2RauFr/RPM/BFHdGIBE04bGwwjDuX5+wSJ62H8tZTo/KPXeswJPLcoOU01cIL9gclZJqnAkCsJmi47Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718402672; c=relaxed/simple;
	bh=HdKSiteX1Un1YtoVxmJvySJHtIPF5Vxdx6iJwgU2Z2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ys9v6ziiVF4fbOBxrATNEEdUtKAP9Wl8wsUtO8d0nFkSckKbRfjwXDAEJtyTVheJxwQuqxP6RoU6I3fJnaFS14WhDbbZ0LYwMRkf/O7BUMvBo3LNoWMhia5WDvIFnOuFiLcykZjsT/6C0OZQfgEtYSXOfH8O+iKhu5YmPXXWQDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xk7r51tr; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718402671; x=1749938671;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HdKSiteX1Un1YtoVxmJvySJHtIPF5Vxdx6iJwgU2Z2o=;
  b=Xk7r51tr6pJYGwBi+l7Q+1dlAUpJfjj9NqnMPIDWsBjGGAL5o1PJPKz1
   6UDwTnt+IizVNJSwDKfZYpw1iFvbBDygqHhprOKD22qg/WmnuVhUA40pl
   jXKT540Mc6MFZPopR9xctlysON8DbFpho8q2oJeEIfhKqaZ8nH7GLcQ2R
   MIvuGofp9RQ/9ap2Sq4QTKVibgNV3Fy5yCPhv2rTivWN2aF7TGSeAz1m7
   yBeRpxQ4xiImxuhwe9NgUXyiSVyLkrV+9wklvE2Whagl9VYmj0iEtK/L/
   SC9liV7qW+WKu5QLWoKIuyEuk8V7TNdAbbcv5eelgBgXRgIAa8Oao5XLB
   Q==;
X-CSE-ConnectionGUID: 6A5FgMDySOmL4Lk71o27kA==
X-CSE-MsgGUID: y12ncJbETP2X4uRixApS/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11103"; a="32855185"
X-IronPort-AV: E=Sophos;i="6.08,238,1712646000"; 
   d="scan'208";a="32855185"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 15:04:29 -0700
X-CSE-ConnectionGUID: BIt/LgMwRnKc6/X1k7Mq1w==
X-CSE-MsgGUID: vDcFpkdNRe+MGRRxoBMNtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,238,1712646000"; 
   d="scan'208";a="41127062"
Received: from lkp-server01.sh.intel.com (HELO 9e3ee4e9e062) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 14 Jun 2024 15:04:24 -0700
Received: from kbuild by 9e3ee4e9e062 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sIF1y-0001q1-0r;
	Fri, 14 Jun 2024 22:04:22 +0000
Date: Sat, 15 Jun 2024 06:03:46 +0800
From: kernel test robot <lkp@intel.com>
To: Frank Li <Frank.Li@nxp.com>, Yangbo Lu <yangbo.lu@nxp.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Madalin Bucur <madalin.bucur@nxp.com>,
	Sean Anderson <sean.anderson@seco.com>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH 1/2] dt-bindings: ptp: Convert ptp-qoirq to yaml format
Message-ID: <202406150525.S8VdHLlY-lkp@intel.com>
References: <20240614-ls_fman-v1-1-cb33c96dc799@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240614-ls_fman-v1-1-cb33c96dc799@nxp.com>

Hi Frank,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 03d44168cbd7fc57d5de56a3730427db758fc7f6]

url:    https://github.com/intel-lab-lkp/linux/commits/Frank-Li/dt-bindings-ptp-Convert-ptp-qoirq-to-yaml-format/20240615-043704
base:   03d44168cbd7fc57d5de56a3730427db758fc7f6
patch link:    https://lore.kernel.org/r/20240614-ls_fman-v1-1-cb33c96dc799%40nxp.com
patch subject: [PATCH 1/2] dt-bindings: ptp: Convert ptp-qoirq to yaml format
reproduce: (https://download.01.org/0day-ci/archive/20240615/202406150525.S8VdHLlY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406150525.S8VdHLlY-lkp@intel.com/

All warnings (new ones prefixed by >>):

   Warning: Documentation/devicetree/bindings/net/fsl-fman.txt references a file that doesn't exist: Documentation/devicetree/bindings/ptp/ptp-qoriq.txt
>> Warning: Documentation/devicetree/bindings/net/fsl-tsec-phy.txt references a file that doesn't exist: Documentation/devicetree/bindings/ptp/ptp-qoriq.txt
   Warning: Documentation/devicetree/bindings/power/wakeup-source.txt references a file that doesn't exist: Documentation/devicetree/bindings/input/qcom,pm8xxx-keypad.txt
   Warning: Documentation/devicetree/bindings/regulator/siliconmitus,sm5703-regulator.yaml references a file that doesn't exist: Documentation/devicetree/bindings/mfd/siliconmitus,sm5703.yaml
   Warning: Documentation/hwmon/g762.rst references a file that doesn't exist: Documentation/devicetree/bindings/hwmon/g762.txt
   Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/reserved-memory/qcom
   Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/display/exynos/
>> Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/ptp/ptp-qoriq.txt
   Can't open Documentation/output/net.h.rst at ./Documentation/sphinx/parse-headers.pl line 328, <IN> line 13.
   make[3]: *** [Documentation/userspace-api/media/Makefile:34: Documentation/output/net.h.rst] Error 2
   Can't open Documentation/output/ca.h.rst at ./Documentation/sphinx/parse-headers.pl line 328, <IN> line 25.
   make[3]: *** [Documentation/userspace-api/media/Makefile:25: Documentation/output/ca.h.rst] Error 2
   Can't open Documentation/output/dmx.h.rst at ./Documentation/sphinx/parse-headers.pl line 328, <IN> line 66.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

