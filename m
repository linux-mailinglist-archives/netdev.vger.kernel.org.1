Return-Path: <netdev+bounces-170230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9918A47E9D
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 14:11:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B22E43B5166
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 13:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C682422F178;
	Thu, 27 Feb 2025 13:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lR1W0HlF"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D98D21ABBE;
	Thu, 27 Feb 2025 13:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740661876; cv=none; b=F4s9EpXBN4Qh77MZeO4IZVB3GHifElG48c9gNz7rH1CfVP92LyJ0zgHKNmwxn6lYNYCAAiIiMT0r2KVtSzz1LGMc7DVorpXsbtf00AbiNiyHq/CYYYAuhDDNAQCody4NlP4pgV9WQxDbfQhTesPS9KLQe5sd1DEGMexS5VySotQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740661876; c=relaxed/simple;
	bh=V/pUxgT+Vht4GXGhv/7+4ABfo2gbm6GzpoHQLy2bYws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T2TIhlUvNa/Qp9G23ce6uayIdaK6hpw9j2RK6ey7Y05JaBMRxKLnxGxZhpH2X03T96y8/VsEiZSZctsH8FfJe4PhhNAvH6/U19/QKYNNOBprAgwhOxfHNZ14oprXO3ixSgsZp8PIm+AQ4WNfs5UFI9cuVJ3n7wyx9sZIBWzWrLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lR1W0HlF; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740661875; x=1772197875;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=V/pUxgT+Vht4GXGhv/7+4ABfo2gbm6GzpoHQLy2bYws=;
  b=lR1W0HlFJqJSz62mDLAeT31grP/v/2yyqyHuMUu4p+tBh9R1cz+PpG15
   NsjEL26Cc+JW56a/WQbBqvriGpcpwBVuutHciMDzwwO7y0BAOzUcp+N/a
   tRnZW627wDiEKUeayVu7+lceakOxO1dhwOygymKbP5jGvo+gBpf0M3A3O
   OC1f9LGTfP+Ge+mOlHaZQHQEGY0EU8fbjeSK7F9Tv/9lUIedOVQWba5Oy
   P3TFgjsTRI8mvRydSg1Bv5hpBXHmT/p87v/oUqh3f1jqyRIS9S+J+P5t/
   6gVuoRj8ROByjxAc17LBadZ2PwtofGpzAoxYgC2nOT8t+vQowE07eIHbb
   w==;
X-CSE-ConnectionGUID: jOmQY6PJRm+gM+6Q0OIyuA==
X-CSE-MsgGUID: 6nqxzcezQ3+m2uggEJB5IQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="41680687"
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="41680687"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 05:11:14 -0800
X-CSE-ConnectionGUID: 4FlIhckrROSowiQsyIKYWA==
X-CSE-MsgGUID: ahgclakuSvmWi4Ul3UEvZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="117667489"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 27 Feb 2025 05:11:10 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tndfQ-000DO4-06;
	Thu, 27 Feb 2025 13:11:08 +0000
Date: Thu, 27 Feb 2025 21:10:09 +0800
From: kernel test robot <lkp@intel.com>
To: =?iso-8859-1?Q?J=2E_Neusch=E4fer?= via B4 Relay <devnull+j.ne.posteo.net@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Claudiu Manoil <claudiu.manoil@nxp.com>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	=?iso-8859-1?Q?J=2E_Neusch=E4fer?= <j.ne@posteo.net>
Subject: Re: [PATCH 3/3] dt-bindings: net: Convert fsl,gianfar to YAML
Message-ID: <202502272036.FSFdbXEm-lkp@intel.com>
References: <20250220-gianfar-yaml-v1-3-0ba97fd1ef92@posteo.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250220-gianfar-yaml-v1-3-0ba97fd1ef92@posteo.net>

Hi Neuschäfer,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 2014c95afecee3e76ca4a56956a936e23283f05b]

url:    https://github.com/intel-lab-lkp/linux/commits/J-Neusch-fer-via-B4-Relay/dt-bindings-net-Convert-fsl-gianfar-mdio-tbi-to-YAML/20250221-013202
base:   2014c95afecee3e76ca4a56956a936e23283f05b
patch link:    https://lore.kernel.org/r/20250220-gianfar-yaml-v1-3-0ba97fd1ef92%40posteo.net
patch subject: [PATCH 3/3] dt-bindings: net: Convert fsl,gianfar to YAML
config: csky-randconfig-051-20250227 (https://download.01.org/0day-ci/archive/20250227/202502272036.FSFdbXEm-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 14.2.0
dtschema version: 2025.3.dev3+gabf9328
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250227/202502272036.FSFdbXEm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502272036.FSFdbXEm-lkp@intel.com/

All warnings (new ones prefixed by >>):

   Documentation/devicetree/bindings/net/snps,dwmac.yaml: mac-mode: missing type definition
>> Warning: Duplicate compatible "gianfar" found in schemas matching "$id":
   	http://devicetree.org/schemas/net/fsl,gianfar-mdio.yaml#
   	http://devicetree.org/schemas/net/fsl,gianfar.yaml#

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

