Return-Path: <netdev+bounces-98154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7782C8CFCFC
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 11:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 149831F221A6
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 09:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473AF13A3FD;
	Mon, 27 May 2024 09:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eaJPtXQR"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D067755769;
	Mon, 27 May 2024 09:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716802450; cv=none; b=svNlasoze3xTVIWWS/ibeCd0005I5kx4hfkSIVdjemR3e3JynOMi1GmZaV3UVTY+dILkteYnUHkTXvsd04qnXhbSpY6edo+NhUJYBhKefxewncCl29vvUgXSkkNwG4Xa634FRfBzztwfDe986LzrzR2/cuOHVd2T/TifCnUOKcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716802450; c=relaxed/simple;
	bh=wAljxYnR6kHVj4d404qDnwEVTRLVT6TjGBJ45tg0riI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Vw6Ij7CGwAR6xGcDovKtNrmW7VMUqjcoXFDFd0Mctc3lakpshtOGFZiiWiPwQ3lqC9+0wqRfl+ELQG2oI7d/007ZHWAr2dY4dpDpke4jOBykpPqVKFS98ITdXZCDY2q4bZVAUC8L2fkionH7MzASEcyRF8idZiynWREzRyx2jJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=none smtp.mailfrom=ecsmtp.png.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eaJPtXQR; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ecsmtp.png.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716802449; x=1748338449;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wAljxYnR6kHVj4d404qDnwEVTRLVT6TjGBJ45tg0riI=;
  b=eaJPtXQRoHG1IIEa5loMlL6he5iZQnwsjO0mND67SHQBXzBCIek79vYI
   ytnVjTmjQLBnggbOesZDlg5v1g9fZilYiCZ5JPohZ4bVgVQ+xV6JTZkUK
   7bgx0E0OvM3f7bxpo1mNiliF4plNj2qccYcvnZTyIEHUTFP31j+9Xw4vN
   DDphJuAnTAiJB+18JRMz6+ytlvTnxo3eMRS/vdJYcAkxzXnOpFprN2aMj
   2EVweVZ2laAkI6ZppQ/x6CrJfn6uVhgHV/1uymSMclTqjiPq8ja1HGo50
   BBVxY9H6YQ8VLCPceIG2yAb7UoUiU4dK/ysCc2k6j7cLrXqqbc0jeYuzT
   w==;
X-CSE-ConnectionGUID: 0DEBnu5BSj2O4OppMAy9Kg==
X-CSE-MsgGUID: vrBhK1NURQifnotAJBj/uQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11084"; a="12933278"
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="12933278"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 02:34:08 -0700
X-CSE-ConnectionGUID: sjeSJxlQT0a4GZ9DIF7Y6w==
X-CSE-MsgGUID: 6aV1CZTWTHuJfqky91LCpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="35193439"
Received: from pglmail07.png.intel.com ([10.126.73.9])
  by orviesa006.jf.intel.com with ESMTP; 27 May 2024 02:34:04 -0700
Received: from pglc00465.png.intel.com (pglc00465.png.intel.com [10.221.239.148])
	by pglmail07.png.intel.com (Postfix) with ESMTP id 3231716423;
	Mon, 27 May 2024 17:34:03 +0800 (+08)
Received: by pglc00465.png.intel.com (Postfix, from userid 11742525)
	id 2D37560568E; Mon, 27 May 2024 17:34:03 +0800 (+08)
From: Boon Khai Ng <boon.khai.ng@intel.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Tien Sung Ang <tien.sung.ang@intel.com>,
	G Thomas Rohan <rohan.g.thomas@intel.com>,
	Looi Hong Aun <hong.aun.looi@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>
Cc: Boon Khai Ng <boon.khai.ng@intel.com>
Subject: [Enable Designware XGMAC VLAN Stripping Feature v2 0/1]
Date: Mon, 27 May 2024 17:33:38 +0800
Message-Id: <20240527093339.30883-1-boon.khai.ng@intel.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,
The Designware 10G MAC(dwxgmac) driver has lack of vlan support
in term of hardware, such as the hardware accelerated VLAN stripping.
The driver was not draft from scratch, however it was ported from the
Ethernet Quality-of-Service (dwmac4) driver, it was tested working on
ourside.

Refer to: 
https://github.com/torvalds/linux/commit/750011e239a50873251c16207b0fe78eabf8577e

Boon Khai Ng (1):
  net: stmmac: dwxgmac2: Add support for HW-accelerated VLAN Stripping

 .../net/ethernet/stmicro/stmmac/dwxgmac2.h    | 28 +++++++++++++++
 .../ethernet/stmicro/stmmac/dwxgmac2_core.c   | 34 +++++++++++++++++++
 .../ethernet/stmicro/stmmac/dwxgmac2_descs.c  | 18 ++++++++++
 3 files changed, 80 insertions(+)

-- 
2.35.3


