Return-Path: <netdev+bounces-153934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA7C89FA1EC
	for <lists+netdev@lfdr.de>; Sat, 21 Dec 2024 19:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDF18188DCB2
	for <lists+netdev@lfdr.de>; Sat, 21 Dec 2024 18:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A4318784A;
	Sat, 21 Dec 2024 18:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="YZIEluBG"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47AC91714A0;
	Sat, 21 Dec 2024 18:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734806586; cv=none; b=GJGrLdxk3JdXV20oOSSgTWzdtKahWT5NQwoFUi/06BXggL6JStgpxZBrfHb0jGJOXlXiK23uIxYwCIl5WBCobkMe3TuDNDjgxeiW/G30rItLTOdzQW2CWvKfSnxdYE7abR1HNuuU1o9J6Pv+RG/7ewxhu7bxgSA62o37ZvsURPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734806586; c=relaxed/simple;
	bh=64HivjMwiTCsKCwDvJXTfFGcMXunD03+i+5sLHwZCd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CycIsf6+8GQ/yhYr473/42fR6t2CBnqChJeyrO7mjxk4BWw3eXcqbVh6aq+uh5cOyKVhXwehEiJ7bGMGffhHP+YZZiueDZvpAEzye1NVnhpyWHl8NDr4JUsVV5gATHd8QTT+hkvfvFS9+6bd2ohGMhWabjX6FQ+FatDYOKVj63s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=YZIEluBG; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=9815t0aBUmhZMZg7qPMHeKGmKhqpBIRlTkKfE9H7HIQ=; b=YZIEluBGo4FbX6Qt
	3aEAi82m9DrLZc/NDPxBEX9w2zcBL/wWHvXPx2biveJ+DZV/VOn/8V8ZajFWEANg/5SRIN6wMezTj
	4CH8KrFXnjqyUi5CthpCGqufuVNtdsytB/jLXeYxG7TGxjLwrjl2hyjEZ4Vn0bqi02kArheoYpGv2
	8gf/FR7n2QqLtRmdoamvnK/Q+SfS0W0D4UBubrSHqTaDUoCS1XN769f7eEY7sz3qURmfjOvYnd5xp
	jqtKGSCpIBFj+DgCpxXhD+zTB+Z7V9XyAo4ijcu/aBBw9SlszVQAv6uBd9tDTeSS/XPAJXagMFSwe
	f1fJnjk04MB5A14gCw==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tP4R9-006hEJ-14;
	Sat, 21 Dec 2024 18:42:51 +0000
From: linux@treblig.org
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [RFC net-next 5/9] i40e: Remove unused i40e_get_cur_guaranteed_fd_count
Date: Sat, 21 Dec 2024 18:42:43 +0000
Message-ID: <20241221184247.118752-6-linux@treblig.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241221184247.118752-1-linux@treblig.org>
References: <20241221184247.118752-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

The last use of i40e_get_cur_guaranteed_fd_count() was removed in 2015 by
commit 04294e38a451 ("i40e: FD filters flush policy changes")

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/net/ethernet/intel/i40e/i40e.h      |  1 -
 drivers/net/ethernet/intel/i40e/i40e_main.c | 13 -------------
 2 files changed, 14 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index d4255c2706fa..5d9738b746f4 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -1189,7 +1189,6 @@ int i40e_add_del_fdir(struct i40e_vsi *vsi,
 		      struct i40e_fdir_filter *input, bool add);
 void i40e_fdir_check_and_reenable(struct i40e_pf *pf);
 u32 i40e_get_current_fd_count(struct i40e_pf *pf);
-u32 i40e_get_cur_guaranteed_fd_count(struct i40e_pf *pf);
 u32 i40e_get_current_atr_cnt(struct i40e_pf *pf);
 u32 i40e_get_global_fd_count(struct i40e_pf *pf);
 bool i40e_set_ntuple(struct i40e_pf *pf, netdev_features_t features);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 0e1d9e2fbf38..83ba1effe8ba 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -9628,19 +9628,6 @@ static void i40e_handle_lan_overflow_event(struct i40e_pf *pf,
 	i40e_reset_vf(vf, false);
 }
 
-/**
- * i40e_get_cur_guaranteed_fd_count - Get the consumed guaranteed FD filters
- * @pf: board private structure
- **/
-u32 i40e_get_cur_guaranteed_fd_count(struct i40e_pf *pf)
-{
-	u32 val, fcnt_prog;
-
-	val = rd32(&pf->hw, I40E_PFQF_FDSTAT);
-	fcnt_prog = (val & I40E_PFQF_FDSTAT_GUARANT_CNT_MASK);
-	return fcnt_prog;
-}
-
 /**
  * i40e_get_current_fd_count - Get total FD filters programmed for this PF
  * @pf: board private structure
-- 
2.47.1


