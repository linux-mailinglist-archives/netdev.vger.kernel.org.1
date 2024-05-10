Return-Path: <netdev+bounces-95328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A06298C1E7D
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 08:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C1122818B0
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 06:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0BE15E80C;
	Fri, 10 May 2024 06:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g2ennY/y"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF10E15E7E2
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 06:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715323976; cv=none; b=JBAL/Ko5Vd5Kr3Ktny/AjEytiZ1dMva5+v8escmYibOQuRNZOfdtinW6jWX7Z/ji1MGIlupr/aHrE8aosCt32bpVn5NnMUxL+9rzfg1iMBWMwxu0on98pDS0KfT9Ma/eu8Bp7ookY+yq1DHwbKZ3YVd04FmivmrsX40PCdmeaD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715323976; c=relaxed/simple;
	bh=gbkVy2+trRuV9MdrGvE0T5uK0uCOcQo3hmLnECHqz3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=U2M+K1pv7qLpGoW0vZyO2wQ8zt9H8KNyezcgX9rBi7afcP/l4GxF92xh3KoI0yKUvHEGeuHLPmtuV0yjGd9V0VzewG7qfK2TkXVKr5ewCCi9xWL4U4nlwTyO3ofh1w+oVAdEAxQjBUoah2Ri0deWvwJOjv+0X5/hVaEbOuQDcNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g2ennY/y; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715323975; x=1746859975;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gbkVy2+trRuV9MdrGvE0T5uK0uCOcQo3hmLnECHqz3Y=;
  b=g2ennY/y4FIsRjhLl3skz96pwn05zhpBkqtzobzyVhxosC+Ly4W60fy0
   uVfd84hkTbS8E77efczLNvyUqBBP7dh64KRPBCaQ+BALt4E4SCR+RI+FS
   10nKidupjxUpzhvJ213GjhrW0zt9KnFKNuA/1WScdVkEL7xcNfxm9RGi9
   vXRnfU6mO3FwZvQdVKzIYo2bc4eE/ccp+2WrofmCYleM7RcHFC54+O1xZ
   MdRI0G8P+GYo0DuF/n8ni65q57mVctBVXN4vR0bKA4uNZRSnBokkx5PZR
   ZZGSRrwdJhIgnVAXwuY+3Tou0KXB0FZE7YtTzluExAdgOjLHwjes9dknm
   Q==;
X-CSE-ConnectionGUID: bT5qmHF1SuyUB5etVcFW3g==
X-CSE-MsgGUID: AUP6qqNvSASX0KSjXea4nA==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="11138272"
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; 
   d="scan'208";a="11138272"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2024 23:52:51 -0700
X-CSE-ConnectionGUID: tP77ZQuVSre6n8pBcTfEPQ==
X-CSE-MsgGUID: yIGfrnsNR/uJoX5GvLk0kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; 
   d="scan'208";a="33950256"
Received: from c3-1-server.sj.intel.com ([10.232.18.246])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2024 23:52:50 -0700
From: Anil Samal <anil.samal@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	--cc=jesse.brandeburg@intel.com,
	--cc=leszek.pepiak@intel.com,
	--cc=przemyslaw.kitszel@intel.com,
	--cc=lukasz.czapnik@intel.com,
	--cc=anthony.l.nguyen@intel.com,
	Anil Samal <anil.samal@intel.com>
Subject: [PATCH iwl-next v2 0/3] ice:Support to dump PHY config, FEC
Date: Thu,  9 May 2024 23:50:39 -0700
Message-ID: <20240510065243.906877-1-anil.samal@intel.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Implementation to dump PHY configuration and FEC statistics to
facilitate link level debugging of customer issues.  Implementation has
two parts 
  
a.     Serdes equalization
        # ethtool  -d eth0 
        Output: 
        Offset          Values
        ------          ------
        0x0000:         00 00 00 00 03 00 00 00 05 00 00 00 01 08 00 40
        0x0010:         01 00 00 40 00 00 39 3c 01 00 00 00 00 00 00 00
        0x0020:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
        ……
        …..
        0x01f0:         01 00 00 00 ef be ad de 8f 00 00 00 00 00 00 00
        0x0200:         00 00 00 00 ef be ad de 00 00 00 00 00 00 00 00
        0x0210:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
        0x0220:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
        0x0230:         00 00 00 00 00 00 00 00 00 00 00 00 fa ff 00 00
        0x0240:         06 00 00 00 03 00 00 00 00 00 00 00 00 00 00 00
        0x0250:         0f b0 0f b0 00 00 00 00 00 00 00 00 00 00 00 00
        0x0260:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
        0x0270:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
        0x0280:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
        0x0290:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
        0x02a0:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
        0x02b0:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
        0x02c0:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
        0x02d0:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
        0x02e0:         00 00 00 00 00 00 00 00 00 00 00 00
Current implementation appends 176 bytes i.e. 44 bytes * 4 serdes lane.
For port with 2 serdes lane, first 88 bytes are valid values and
remaining 88 bytes are filled with zero. Similarly for port with 1
serdes lane, first 44 bytes are valid and remaining 132 bytes are marked
zero. 

Each set of serdes equalizer parameter (i.e. set of 44 bytes) follows
below order 
    a. rx_equalization_pre2
    b. rx_equalization_pre1
    c. rx_equalization_post1
    d. rx_equalization_bflf
    e. rx_equalization_bfhf
    f. rx_equalization_drate
    g. tx_equalization_pre1
    h. tx_equalization_pre3
    i. tx_equalization_atten
    j. tx_equalization_post1
    k. tx_equalization_pre2
Where each individual equalizer parameter is of 4 bytes. As ethtool
prints values as individual bytes, for little endian machine these
values will be in reverse byte order. 

b.	FEC block counts
        # ethtool  -I --show-fec eth0
        Output:
         FEC parameters for eth0:
        Supported/Configured FEC encodings: Auto RS BaseR
        Active FEC encoding: RS
        Statistics:
        corrected_blocks: 0
         uncorrectable_blocks: 0

This series do following:
Patch 1 – Implementation to support user provided flag for side band
queue command. 
Patch 2 – Currently driver does not have a way to derive serdes lane
number, pcs quad , pcs port from port number.So we introduced a
mechanism to derive above info. 
          Ethtool interface extension to include FEC statistics counter.
Patch 3 – Ethtool interface extension to include serdes equalizer
output.

v1 -> V2, 
   Squashed 4 commit to 3 commit. 
   Removed extra null check of arguments.
   Removed initialization of local variable that are not required.

 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  51 ++
 drivers/net/ethernet/intel/ice/ice_common.c   |  99 +++-
 drivers/net/ethernet/intel/ice/ice_common.h   |  28 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c  | 449 +++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_ethtool.h  |  29 ++
 .../net/ethernet/intel/ice/ice_hw_autogen.h   |   2 +
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   |  16 +-
 drivers/net/ethernet/intel/ice/ice_type.h     |   8 +
 8 files changed, 669 insertions(+), 13 deletions(-)

-- 
2.44.0


