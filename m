Return-Path: <netdev+bounces-219189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 221AAB40641
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 16:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DD80171E93
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 14:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38A52DC35C;
	Tue,  2 Sep 2025 14:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="USbtrNuq"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3C727EC80
	for <netdev@vger.kernel.org>; Tue,  2 Sep 2025 14:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756821987; cv=none; b=B+6/siS0VrSPuq5jK0ESNatTwCR9QFOnN0iVUlDADvvOOwHn0p/WAMwXGK3qQTnKH/ssGBkle633ZXI9gr40kJX0oyzef523FRhXy9eTSl2kRHoJutSqgYyUBK118k1i+sEv38jWS6ylA8P7mvNThoUFWOU7QL8mAYEayoDDC78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756821987; c=relaxed/simple;
	bh=uwmqyW4iguh3yd9Z0HFBXF3emGZrOuKjxQU095FIrNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=upL8I+27xJI4xPKExvimpBG7BsjhlVOSWTKB2S0/qVF+biMFRtFA5U36Iz7eOIwwCL6Fmf3wDS3qT8hSs73ejbYx2Pu1Dh43C8REhWfNcTczlIqhZJWXdQD0ouQ+QghB8nNCxYOYLDXVCjXGiG9aR/kTMhS0O6dM6Jdy+M867bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=USbtrNuq; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756821986; x=1788357986;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uwmqyW4iguh3yd9Z0HFBXF3emGZrOuKjxQU095FIrNM=;
  b=USbtrNuq9NjhloYlYBePt/fIIEn5i0XFmkanW3/m3XWYsrSmWE+qvRqr
   qW4b8udDEDfrhTHdZkKkyNlSqhzIomWFoJohITc+KjwnA4WLSYz2I1vSz
   Za30OFhbbdZMg/hRxZXbXTrxES/4Lob8y1Ber1weXCCkXLkE0gcr1Fz/h
   LJ7O15URoqc8MB4Y/Ti2zU4qvSigXTV4EPvKIiSYEXC6JQHcJlXF3KLwL
   hEyLNtOK87Fh1p/2VYjOAHfJ812EvkmcEm2UgLjF0+8Uta5bCbIPGVzhV
   7ibS55xyxtCYAjTP4UFXWDAmbZtakrQt2RAQjY22ulVWufO38blApptW9
   A==;
X-CSE-ConnectionGUID: o827TKDMTt2qQKoab44NoQ==
X-CSE-MsgGUID: dANTNVacQrSS4PIO4B5xTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="69709884"
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="69709884"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 07:06:25 -0700
X-CSE-ConnectionGUID: LV02f38gTGSkQzu7FDitTQ==
X-CSE-MsgGUID: yfdIjjIhTgGrWpgYE94IdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="194932705"
Received: from lkp-server02.sh.intel.com (HELO 06ba48ef64e9) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 02 Sep 2025 07:06:23 -0700
Received: from kbuild by 06ba48ef64e9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1utReO-0002aB-2v;
	Tue, 02 Sep 2025 14:06:20 +0000
Date: Tue, 2 Sep 2025 22:06:14 +0800
From: kernel test robot <lkp@intel.com>
To: Anton Nadezhdin <anton.nadezhdin@intel.com>,
	intel-wired-lan@lists.osuosl.org
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, richardcochran@gmail.com,
	Milena Olech <milena.olech@intel.com>,
	Anton Nadezhdin <anton.nadezhdin@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next 2/2] idpf: add direct method
 for disciplining Tx timestamping
Message-ID: <202509022155.uBpemgov-lkp@intel.com>
References: <20250902105321.5750-3-anton.nadezhdin@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902105321.5750-3-anton.nadezhdin@intel.com>

Hi Anton,

kernel test robot noticed the following build errors:

[auto build test ERROR on 1235d14de922bc4367c24553bc6b278d56dc3433]

url:    https://github.com/intel-lab-lkp/linux/commits/Anton-Nadezhdin/idpf-add-direct-access-to-discipline-the-main-timer/20250902-170325
base:   1235d14de922bc4367c24553bc6b278d56dc3433
patch link:    https://lore.kernel.org/r/20250902105321.5750-3-anton.nadezhdin%40intel.com
patch subject: [Intel-wired-lan] [PATCH iwl-next 2/2] idpf: add direct method for disciplining Tx timestamping
config: powerpc-randconfig-002-20250902 (https://download.01.org/0day-ci/archive/20250902/202509022155.uBpemgov-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250902/202509022155.uBpemgov-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509022155.uBpemgov-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/net/ethernet/intel/idpf/idpf_txrx.c:5:
>> drivers/net/ethernet/intel/idpf/idpf_ptp.h:399:11: error: expected ';', ',' or ')' before 'struct'
              struct idpf_tx_splitq_params *params)
              ^~~~~~
   drivers/net/ethernet/intel/idpf/idpf_txrx.c: In function 'idpf_tx_read_tstamp':
>> drivers/net/ethernet/intel/idpf/idpf_txrx.c:1673:10: error: too many arguments to function 'idpf_ptp_get_tx_tstamp'
       err = idpf_ptp_get_tx_tstamp(tx_tstamp_caps->vport, tx_tstamp);
             ^~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/net/ethernet/intel/idpf/idpf_txrx.c:5:
   drivers/net/ethernet/intel/idpf/idpf_ptp.h:374:19: note: declared here
    static inline int idpf_ptp_get_tx_tstamp(struct idpf_vport *vport)
                      ^~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/idpf/idpf_txrx.c: In function 'idpf_tx_splitq_frame':
>> drivers/net/ethernet/intel/idpf/idpf_txrx.c:2763:34: error: passing argument 3 of 'idpf_tx_tstamp' from incompatible pointer type [-Werror=incompatible-pointer-types]
     idx = idpf_tx_tstamp(tx_q, skb, &tx_params);
                                     ^~~~~~~~~~
   drivers/net/ethernet/intel/idpf/idpf_txrx.c:2635:37: note: expected 'struct idpf_tx_offload_params *' but argument is of type 'struct idpf_tx_splitq_params *'
         struct idpf_tx_offload_params *params)
         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~
   cc1: some warnings being treated as errors
--
   In file included from drivers/net/ethernet/intel/idpf/idpf_lib.c:6:
>> drivers/net/ethernet/intel/idpf/idpf_ptp.h:399:11: error: expected ';', ',' or ')' before 'struct'
              struct idpf_tx_splitq_params *params)
              ^~~~~~


vim +399 drivers/net/ethernet/intel/idpf/idpf_ptp.h

   396	
   397	static inline int idpf_ptp_request_ts(struct idpf_tx_queue *tx_q,
   398					      struct sk_buff *skb, u32 *idx
 > 399					      struct idpf_tx_splitq_params *params)
   400	{
   401		return -EOPNOTSUPP;
   402	}
   403	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

