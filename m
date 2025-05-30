Return-Path: <netdev+bounces-194420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD8BAC95FB
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 21:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B3CF504F6F
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 19:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A354278768;
	Fri, 30 May 2025 19:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DIGW7bet"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD0C23E35B;
	Fri, 30 May 2025 19:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748632494; cv=none; b=TiwJPyQHFKJZTsKMA5b6ThE/1uUDZYUDVBdUslUPt0FNMBlV4SJ9mtrciabKoxtI+lZQuQkpEx2PYJqMJo32ixTCoNK2Pxj2pv4dbUx2Mo6T1RxO9yMhIlvdSZXfg7WcvjAUz8pTmiaZUUV9A7Vy7PKeYVtXkqrgq7eumrR4PN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748632494; c=relaxed/simple;
	bh=o94uNCWV71Npa/D7DFRsizf1ZwcH4B1mlc/EOztA0Kw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h6LpffOtx/qZ8FWjRQyY+b5trOY51FPuTf0eyDuuxGbyx+hu5vhFJxqNWHjuwh5aL/Pv4bUkmNDgjSUCP1dAiaplwklv/XTDdJUdoVfgOlPZ9iIJn6XmqNXYun0M/viUClDw9ApbaPCbPVfBaI0EYPZ76hIvekcTrReibH1Syd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DIGW7bet; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748632493; x=1780168493;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=o94uNCWV71Npa/D7DFRsizf1ZwcH4B1mlc/EOztA0Kw=;
  b=DIGW7betdw4A7LfDhL/nZ09cFVNkcL3zzyxQv6c0eaho2zAMwdbjvV41
   jpWx87BBaIXP4ON9hnj3FPhlNc3jxYDjXCWPLbQyDsrvxe9hL4Ia8eCVn
   Ao8NKm8zC4ZIv4qwgVUe7f77kKO+VZ2CnUhV+73IrfROMM6o9mzcGutG/
   nEHndllsdpCIscCl2duuPtU9EdQaEmkFnf7DQUDToYQlLdUsQBwGxq3RM
   DeF6YI/94uWGLFKmjaIdiOpSjHKFo89H5TB6ZHnSjcU9lPckqWA6YYXIA
   a7zOVOINoyBCd65xKAZHr52ke4McGizgkTZQaqJhWCbwFrpg+p3hzsVUZ
   g==;
X-CSE-ConnectionGUID: i/ug7soHTxmnwREaFCyxcA==
X-CSE-MsgGUID: du7oQRH6RJym+M7YAgcjPg==
X-IronPort-AV: E=McAfee;i="6700,10204,11449"; a="60991991"
X-IronPort-AV: E=Sophos;i="6.16,196,1744095600"; 
   d="scan'208";a="60991991"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2025 12:14:53 -0700
X-CSE-ConnectionGUID: eS2mBj5fQZS6qe3p2T0onQ==
X-CSE-MsgGUID: y9qpQ4EUTiiGK7G8smW0bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,196,1744095600"; 
   d="scan'208";a="147843228"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 30 May 2025 12:14:50 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uL5Bm-000Xtw-2y;
	Fri, 30 May 2025 19:14:46 +0000
Date: Sat, 31 May 2025 03:14:27 +0800
From: kernel test robot <lkp@intel.com>
To: =?iso-8859-1?Q?=C1lvaro_Fern=E1ndez?= Rojas <noltari@gmail.com>,
	jonas.gorski@gmail.com, florian.fainelli@broadcom.com,
	andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, dgcbueu@gmail.com
Cc: oe-kbuild-all@lists.linux.dev,
	=?iso-8859-1?Q?=C1lvaro_Fern=E1ndez?= Rojas <noltari@gmail.com>
Subject: Re: [PATCH] net: dsa: b53: support legacy FCS tags
Message-ID: <202505310308.8veTfz2G-lkp@intel.com>
References: <20250530155618.273567-4-noltari@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250530155618.273567-4-noltari@gmail.com>

Hi Álvaro,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]
[also build test ERROR on net/main linus/master v6.15 next-20250530]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/lvaro-Fern-ndez-Rojas/net-dsa-b53-support-legacy-FCS-tags/20250530-235844
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250530155618.273567-4-noltari%40gmail.com
patch subject: [PATCH] net: dsa: b53: support legacy FCS tags
config: sparc-randconfig-001-20250531 (https://download.01.org/0day-ci/archive/20250531/202505310308.8veTfz2G-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250531/202505310308.8veTfz2G-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505310308.8veTfz2G-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/net/dsa/b53/b53_common.c: In function 'b53_get_tag_protocol':
>> drivers/net/dsa/b53/b53_common.c:2267:23: error: 'DSA_TAG_PROTO_BRCM_LEGACY_FCS' undeclared (first use in this function); did you mean 'DSA_TAG_PROTO_BRCM_LEGACY'?
      dev->tag_protocol = DSA_TAG_PROTO_BRCM_LEGACY_FCS;
                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                          DSA_TAG_PROTO_BRCM_LEGACY
   drivers/net/dsa/b53/b53_common.c:2267:23: note: each undeclared identifier is reported only once for each function it appears in


vim +2267 drivers/net/dsa/b53/b53_common.c

  2254	
  2255	enum dsa_tag_protocol b53_get_tag_protocol(struct dsa_switch *ds, int port,
  2256						   enum dsa_tag_protocol mprot)
  2257	{
  2258		struct b53_device *dev = ds->priv;
  2259	
  2260		if (!b53_can_enable_brcm_tags(ds, port, mprot)) {
  2261			dev->tag_protocol = DSA_TAG_PROTO_NONE;
  2262			goto out;
  2263		}
  2264	
  2265		/* Older models require different 6 byte tags */
  2266		if (is5325(dev) || is5365(dev)) {
> 2267			dev->tag_protocol = DSA_TAG_PROTO_BRCM_LEGACY_FCS;
  2268			goto out;
  2269		} else if (is63xx(dev)) {
  2270			dev->tag_protocol = DSA_TAG_PROTO_BRCM_LEGACY;
  2271			goto out;
  2272		}
  2273	
  2274		/* Broadcom BCM58xx chips have a flow accelerator on Port 8
  2275		 * which requires us to use the prepended Broadcom tag type
  2276		 */
  2277		if (dev->chip_id == BCM58XX_DEVICE_ID && port == B53_CPU_PORT) {
  2278			dev->tag_protocol = DSA_TAG_PROTO_BRCM_PREPEND;
  2279			goto out;
  2280		}
  2281	
  2282		dev->tag_protocol = DSA_TAG_PROTO_BRCM;
  2283	out:
  2284		return dev->tag_protocol;
  2285	}
  2286	EXPORT_SYMBOL(b53_get_tag_protocol);
  2287	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

