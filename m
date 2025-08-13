Return-Path: <netdev+bounces-213297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F85B2479A
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 12:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8259685600
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 10:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2137B280308;
	Wed, 13 Aug 2025 10:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CynXljvm"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16F619D880
	for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 10:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755081959; cv=none; b=PMixTXmT6Fr2CPYN+3uU11MRVpf44V1nsb9JkS9YDX0GrkDutXROJEr2oxrBaaTDyhVtk8oZP4Zs6mvdYtiIHT0j9s40OEja/VAbpdtSxmQelA9cOxusZjdD5DOlP6yrP94PgXgnfpZhk57+0bSVzIbEmYaPibdvBPFbSfSpVug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755081959; c=relaxed/simple;
	bh=yLT7BDKccKmh7IL+6jcK22ShpJb0eR0hxsC+U/6WvuM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pmYve4+DH+eZjQ++c3C2ZrEvuOkoSaT9cImG4dcv4QT1yBaJzdPO8p7V3wOENEWDStfm4mJW1MhoxJYcU/xetInf0d76AjUZgjtVkL2rdFIrTxHiBpq/gLymN6dMORcRbniPaT9ax76+NB2Oo9D4OpACFMaD7MeBn8ao1wARD84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CynXljvm; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755081957; x=1786617957;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yLT7BDKccKmh7IL+6jcK22ShpJb0eR0hxsC+U/6WvuM=;
  b=CynXljvmAgrvNyzNPyiwwzkc9IZ7fkOWt63vEh2pXAKcLAE62ZPEr/Rm
   88XJnDbW5E+WIDPi20qVuPA3A43grFhdPA26ePEDQCAs4xJ90IhEIPG2J
   DTcPgShnvisMRIqbHbrpPvo4qPiI5pvDRxdp/9ZL+4vRPR4rsD/QK3PBD
   Lbi0fGohRewaYuN7nbpy77U+yKZvq0SlS2LQt5kX5buzHtxCXfXx3KvaO
   +JxQtESY6bMY1EyLKdUtHOyjhjKpkt1UNarHT5Nw40muYaGVtH6+mZ24W
   V6pvniHyc8ujAn6TKvaf88bh5Fzu8p8/Zf+N5t9NNcTrKMG86yuR60Kzg
   g==;
X-CSE-ConnectionGUID: qFVe01twSJmtdlJevX4Gdw==
X-CSE-MsgGUID: xR1rG1+7QEeBIsWwEVp3aA==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="44949612"
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="44949612"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 03:45:57 -0700
X-CSE-ConnectionGUID: 3aXtKSgsT0WGWVuzmmfQyw==
X-CSE-MsgGUID: Yyh+KhR7Ruq3j0zfOyONpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="166066902"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa009.jf.intel.com with ESMTP; 13 Aug 2025 03:45:55 -0700
Received: from pkitszel-desk.tendawifi.com (unknown [10.245.245.219])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 9472F28781;
	Wed, 13 Aug 2025 11:45:53 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: netdev@vger.kernel.org,
	Greg KH <gregkh@linuxfoundation.org>,
	jeremiah.kyle@intel.com,
	leszek.pepiak@intel.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-net 0/8] i40e: virtchnl improvements
Date: Wed, 13 Aug 2025 12:45:10 +0200
Message-ID: <20250813104552.61027-1-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Improvements hardening PF-VF communication for i40e driver.
This patchset targets several issues that can cause undefined behavior
or be exploited in some other way.

Lukasz Czapnik (8):
  i40e: add validation for ring_len param
  i40e: fix idx validation in i40e_validate_queue_map
  i40e: fix idx validation in config queues msg
  i40e: fix input validation logic for action_meta
  i40e: fix validation of VF state in get resources
  i40e: add max boundary check for VF filters
  i40e: add mask to apply valid bits for itr_idx
  i40e: improve VF MAC filters accounting

 drivers/net/ethernet/intel/i40e/i40e.h        |   3 +-
 .../ethernet/intel/i40e/i40e_virtchnl_pf.h    |   3 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c   |  26 ++++-
 .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 110 ++++++++++--------
 4 files changed, 90 insertions(+), 52 deletions(-)

-- 
2.50.0


