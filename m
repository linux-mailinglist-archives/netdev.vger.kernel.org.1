Return-Path: <netdev+bounces-232707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D8D3C08218
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 22:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44C4C40384E
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 20:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9869E2FD7CA;
	Fri, 24 Oct 2025 20:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HKJ1IzDV"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCAA2FD1C5
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 20:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761338881; cv=none; b=h0h6CamT/NZMdHrVjOUutFZlNAFNj6GcwZxkt/hxJ5ARXBzjHB4tL93c90aDZhcZiNMJ9kzRH7OBQ8+ZRC3yFesa2/cYMrmo3p8wBQ5dzKqt9U6vtNMxpXZSeQL4O+0/S6qtgihBbSZRs0WKZ0glr+dlTI+ZsjVOK5AzGCdm300=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761338881; c=relaxed/simple;
	bh=jTBsvxKHOtIPFZsWzmtzQJgYGvivzUkFJ0VWbVX4rtw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K9P0kr1bkhfYihnVMYZ8QHzLgKSDkgbI0OzeFKj6MkBNKALxlmhIICnaUTWGSxgfNtBsBtWBXdXaCtxAf0+p9OBGAGbXHfIwxPq83Owg125PNKegCjdINDqzScmYvx30zkoqL1YBdkah7+cHOuGIHCKjHaqdBdkpZHd3hV7TjPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HKJ1IzDV; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761338879; x=1792874879;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jTBsvxKHOtIPFZsWzmtzQJgYGvivzUkFJ0VWbVX4rtw=;
  b=HKJ1IzDVQjtEdzOTfD0/E6IEvQ9XKgkTyLEFnN0qaVIR2Ij78q46step
   dqtkdOaEcf9vNTY4aDIowWp3ltpXHtmHAfGNInZQQBaxZ6qI8lpLLNn8P
   iIMqhsCtjHGRd0N4qYD6vPkWtcQ60OjvdDku7rq/oso9aIczP2KL8vu8e
   6AsUZRFtB4zERDNO0z8mgNgOMbfhAaTIUUrTG9oDl2dI8rAafnbKkfrNp
   hvmSH8APInXdimZmjcyCkWD6s5XtwolU6WM6jgXB0KZOgGJowlSvIgMl6
   CWGTnpfTJ4Vja+L39dVwqYptcfUeZvRssG7qypngdWcXu/aJbN0biOPst
   A==;
X-CSE-ConnectionGUID: dQYrcF0gQC+eh7zqf3m8eg==
X-CSE-MsgGUID: B1IBbp0XTdqGfIKqzRX0zA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="66139512"
X-IronPort-AV: E=Sophos;i="6.19,253,1754982000"; 
   d="scan'208";a="66139512"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 13:47:54 -0700
X-CSE-ConnectionGUID: ezSnwZC1TkyeU0GurpLpmA==
X-CSE-MsgGUID: vP7cCX9URKWtaxF1jfNM0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,253,1754982000"; 
   d="scan'208";a="188821539"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa004.jf.intel.com with ESMTP; 24 Oct 2025 13:47:54 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	anthony.l.nguyen@intel.com,
	jacob.e.keller@intel.com,
	mschmidt@redhat.com,
	poros@redhat.com,
	horms@kernel.org,
	kalesh-anakkur.purayil@broadcom.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net-next 9/9] ice: remove duplicate call to ice_deinit_hw() on error paths
Date: Fri, 24 Oct 2025 13:47:44 -0700
Message-ID: <20251024204746.3092277-10-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251024204746.3092277-1-anthony.l.nguyen@intel.com>
References: <20251024204746.3092277-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Current unwinding code on error paths of ice_devlink_reinit_up() and
ice_probe() have manual call to ice_deinit_hw() (which is good, as there
is also manual call to ice_hw_init() there), which is then duplicated
(and was prior current series) in ice_deinit_dev().

Fix the above by removing ice_deinit_hw() from ice_deinit_dev().
Add a (now missing) call in ice_remove().

Reported-by: Jacob Keller <jacob.e.keller@intel.com>
Link: https://lore.kernel.org/intel-wired-lan/20250717-jk-ddp-safe-mode-issue-v1-1-e113b2baed79@intel.com/
Fixes: 4d3f59bfa2cd ("ice: split ice_init_hw() out from ice_init_dev()")
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index a1fe2d363adb..1de3da7b3907 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -4784,7 +4784,6 @@ int ice_init_dev(struct ice_pf *pf)
 
 void ice_deinit_dev(struct ice_pf *pf)
 {
-	ice_deinit_hw(&pf->hw);
 	ice_service_task_stop(pf);
 
 	/* Service task is already stopped, so call reset directly. */
@@ -5466,6 +5465,7 @@ static void ice_remove(struct pci_dev *pdev)
 	ice_set_wake(pf);
 
 	ice_adapter_put(pdev);
+	ice_deinit_hw(&pf->hw);
 
 	ice_deinit_dev(pf);
 	ice_aq_cancel_waiting_tasks(pf);
-- 
2.47.1


