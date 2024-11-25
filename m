Return-Path: <netdev+bounces-147294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C99BB9D8F4D
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 00:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9251528ACA6
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 23:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8A2192D91;
	Mon, 25 Nov 2024 23:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z/lVtH8B"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCBBA35
	for <netdev@vger.kernel.org>; Mon, 25 Nov 2024 23:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732578713; cv=none; b=YymKHsXr5f8qyVl74R+rTofF5oHv2HIePxkpsGEh/y9VRqAXgvvWNwWfPkCsEsVs+h3q1GQYAJMlf6UzhuoE5jQqqSrwvEtpeotOxK+ULEI5ERb3eZB5jdIp0cWWieG4S/15iHP7tJR7aVVpjp9GzLDkwJYJka1lmrK6KPtD2f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732578713; c=relaxed/simple;
	bh=vkih/UZod11dYlMo8JC2SR5Tm5sdnhTeyfXh3OixoCo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NjK6nKTsbwd57nA3U3TXRPSiKY/GF6Jabj18Cn1s4HHso1hGK3mTEQolWTf7jIginxkl95Gf/ms4uOXNSIzUxtaxUL0cvFXBuo3UQolGnpQUoCUBJlMKHyZZ/GsbnpXiEaLTf+WtTxjxfxB6zrhYc/P1eJk+BUwsTyUlugJFp4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z/lVtH8B; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732578712; x=1764114712;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vkih/UZod11dYlMo8JC2SR5Tm5sdnhTeyfXh3OixoCo=;
  b=Z/lVtH8B82Dvp5asUBfATHPyOxebiL8YuCs/dkphA8K37LORY29sm327
   kmMkH/bjT/lqlZHO7Mxg4NnYt4m20911GqL2uQd3Y1wvIbTW6TVUJ7guL
   SxUqIDN775dIVAT9A9U6K9U5BmucENwLV5Wb61FdWqmhqrLnQ923k5iND
   vEudSPaHR1IQ+nkq97M+RD1+qfJRzaNX+psyZrHuVt12eNpJAbldAnzLK
   pAe9m2DxMtUSrg1wh67y1pbVut3XbRfy0QiQz5lFbPRffj0JWGucy8tjL
   P9xBn7SBjrIGEz5V1rcAn4+yke0XFEw3kea9sZ2qCysYQw1g7dVJuqfAa
   Q==;
X-CSE-ConnectionGUID: xlGcIVGhSiuMt8PTpme6PQ==
X-CSE-MsgGUID: 3T+6p4upSKmOiW1CpKkKsA==
X-IronPort-AV: E=McAfee;i="6700,10204,11267"; a="44108295"
X-IronPort-AV: E=Sophos;i="6.12,184,1728975600"; 
   d="scan'208";a="44108295"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 15:51:51 -0800
X-CSE-ConnectionGUID: YdIOPK/AQGW0qjCv1KVWug==
X-CSE-MsgGUID: 96wT6VuZQE+skIbvjNrXHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,184,1728975600"; 
   d="scan'208";a="92239622"
Received: from dcskidmo-m40.jf.intel.com ([10.166.241.13])
  by orviesa008.jf.intel.com with ESMTP; 25 Nov 2024 15:51:50 -0800
From: Joshua Hay <joshua.a.hay@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: przemyslaw.kitszel@intel.com,
	michal.kubiak@intel.com,
	aleksander.lobakin@intel.com,
	madhu.chittim@intel.com,
	netdev@vger.kernel.org,
	Joshua Hay <joshua.a.hay@intel.com>
Subject: [Intel-wired-lan][PATCH iwl-net  0/2] idpf: trigger SW interrupt when exiting wb_on_itr mode
Date: Mon, 25 Nov 2024 15:58:53 -0800
Message-Id: <20241125235855.64850-1-joshua.a.hay@intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series introduces SW triggered interrupt support for idpf,
then uses said interrupt to fix a race condition between completion
writebacks and re-enabling interrupts.

Joshua Hay (2):
  idpf: add support for SW triggered interrupts
  idpf: trigger SW interrupt when exiting wb_on_itr mode

 drivers/net/ethernet/intel/idpf/idpf_dev.c    |  3 ++
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 30 ++++++++++++-------
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  8 ++++-
 drivers/net/ethernet/intel/idpf/idpf_vf_dev.c |  3 ++
 4 files changed, 33 insertions(+), 11 deletions(-)

-- 
2.39.2


