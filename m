Return-Path: <netdev+bounces-250516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6D5D30CD9
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 13:02:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1A3E73007F0F
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 12:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372BF37C11C;
	Fri, 16 Jan 2026 12:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P39FDdHK"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEED41E0DCB
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 12:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768564949; cv=none; b=qVoIjrAX74M+CISG91P+TVaWEtrMccMDWRLGDPohcMx769CqGFADkKDUvdjadHTRUAhZWY8ljPxvcVi7DfLOxithzfEt48w0s0fk5DbVTC8r33Aj/XVvOpxcwIZO3p8YJaSMEYsDVbrukkEItGJaqDppAwkQtDVv8mpwXHj01gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768564949; c=relaxed/simple;
	bh=X4qf3eU27DL70bv5ck3IOiqNTfvbHsfrTGeivJyJjLw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i0szJnkVhTOrrwVWbwtE7IEMIiyDwRija84dZZes4uinvVQJOYFK+42O9pQjdibfibm6S0NEVl90lNq5HhdSi/9hlIQgeO8hSN/hhREyJO+iMaOiM7x2GGMN855Dqa7lLuFRC5nbPrUFF6rn5Ntbzn8mtBF/lfSD1KweNthCNSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P39FDdHK; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768564948; x=1800100948;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=X4qf3eU27DL70bv5ck3IOiqNTfvbHsfrTGeivJyJjLw=;
  b=P39FDdHK9uy+aYxn+QRRNp4ERhdHAzVduofIzebS7RZL8u7lubp3jA3o
   Zqxvg9Z/aYEFmT3SAw3YWK5ePtOadlJHvzaFaeAsCWxaCEP7bmR9Ncznj
   s6v7vwoKZD8WlyVi4fZiqY3W14w2Zlh/A+nF+c7I2z1ilUA+5YduS2z2T
   HW9yrJHZiNT48LRwWFk7dmklqPy4OSKxLDyFaTBSciFn2hWoh5J4hwzgj
   4H6vICUlc4nVSzfPVGjKt00/cD5E+q3mCbugxL/D5f1A1ModW8068mHaX
   2thGSu59AtbRcg9GPy83O9DHjsVQGV55VqOY7YsqDhHCX/Vj294HQFuL4
   g==;
X-CSE-ConnectionGUID: PY1SkYbiSfSZ20UZgHEkWQ==
X-CSE-MsgGUID: I3/FYX7XTfikVVWpr1lnsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11672"; a="92542189"
X-IronPort-AV: E=Sophos;i="6.21,231,1763452800"; 
   d="scan'208";a="92542189"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2026 04:02:27 -0800
X-CSE-ConnectionGUID: juPtriiURyCn/AgQmw8Oig==
X-CSE-MsgGUID: CEBJNsVkSFKoNVdzUAb8FQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,231,1763452800"; 
   d="scan'208";a="205645881"
Received: from amlin-018-252.igk.intel.com ([10.102.18.252])
  by fmviesa009.fm.intel.com with ESMTP; 16 Jan 2026 04:02:26 -0800
From: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Subject: [PATCH iwl-next 0/2] ixgbe: e610: add ACI dynamic debug
Date: Fri, 16 Jan 2026 13:23:06 +0100
Message-ID: <20260116122306.78200-1-piotr.kwapulinski@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable dynamic debug (dyndbg) of Admin Command Interface (ACI) for e610
adapter. Utilizes the standard dynamic debug interface. For example to
enable dyndbg at driver load:

insmod ixgbe.ko dyndbg='+p'

ACI debug output for e610 adapter is immediately printed into a kernel
log (dmesg). Example output:

ixgbe 0000:01:00.0 eth0: CQ CMD: opcode 0x0701, flags 0x3003, datalen 0x0060, retval 0x0000
ixgbe 0000:01:00.0 eth0:       cookie (h,l) 0x00000000 0x00000000
ixgbe 0000:01:00.0 eth0:       param (0,1)  0x8194E044 0x00600000
ixgbe 0000:01:00.0 eth0:       addr (h,l)   0x00000000 0x00000000
ixgbe 0000:01:00.0 eth0: Buffer:
ixgbe 0000:01:00.0 eth0: 00000000: 01 00 17 00 00 00 00 00 00 00 00 00 00 00 00 00
ixgbe 0000:01:00.0 eth0: 00000010: 1d 00 00 00 0b d5 1e 15 5e 4b 90 63 aa 0b 21 31
ixgbe 0000:01:00.0 eth0: 00000020: 69 eb cd ab dc f8 8a fd f4 53 e2 dc 54 e0 81 fa
ixgbe 0000:01:00.0 eth0: 00000030: 12 dc 41 82 01 00 00 00 24 20 08 26 53 08 00 00
ixgbe 0000:01:00.0 eth0: 00000040: 08 00 14 00 00 00 00 00 00 00 00 00 00 00 00 00
ixgbe 0000:01:00.0 eth0: 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ixgbe 0000:01:00.0 eth0: CQ CMD: opcode 0x0009, flags 0x2003, datalen 0x0000, retval 0x0000
ixgbe 0000:01:00.0 eth0:       cookie (h,l) 0x00000000 0x00000000
ixgbe 0000:01:00.0 eth0:       param (0,1)  0x00000001 0x00000000
ixgbe 0000:01:00.0 eth0:       addr (h,l)   0x00000000 0x00000000

Piotr Kwapulinski (2):
  ixgbe: e610: add missing endianness conversion
  ixgbe: e610: add ACI dynamic debug

 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 119 ++++++++++++++++--
 1 file changed, 109 insertions(+), 10 deletions(-)

-- 
2.47.1


