Return-Path: <netdev+bounces-154792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B48E89FFCDE
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 18:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56C3A162952
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 17:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12BFE1B4237;
	Thu,  2 Jan 2025 17:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="OXJrWKwm"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFD317E019;
	Thu,  2 Jan 2025 17:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735839465; cv=none; b=hYbwo3Az302MS8IiyrKZy+Kro4ekIbmTUZJuJBBzmJ95QroE5ew5rbDoaTg0Ef1WsO0QRp1ffNIVZmJLB2QBR98KxvcJAETKkx+pE1o8cU3d4uao+TRfKttfwdslriKPNsVa9/r3dvd+sh+sbMtCmqg2E4NrGK0G+RboI20Tjmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735839465; c=relaxed/simple;
	bh=Ij77/tPcwMXNw6KoIpA7xY63WXP2TtZPNdTXenNWmJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nS1RfcZ62rjMmVwQjv572XZ5sKOzcH7AuXZN74ixLHeiV8LxgfqTNzE52e62CThdJFalvjMvTa+213JAYu8bVl8bwOOaJS17oVM8YTLtcFKZ8pBbCjr40CuopX80sTIKvPAN3nu0YckIpmjLv/QRL5kzeyzTsTifS4DvbuxZevI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=OXJrWKwm; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=M8kz3itQ/pGYcYkrFNStdI+yMsB12zXehoIKKmsZ498=; b=OXJrWKwmGnIN+xG9
	Dr/IAGXt1mVLdyOJo1s5bHRgm5o3xeZ2W8fsVIiEtGt+azB5yunUj/ReNzhbz6nfrTrqIDJ90FFoI
	c2/3PrzMgEuq4dUTPqiFsUEYG1nv8s00PKHVJzix2UB+EJAk8aJm7ZgfwfCt5rSY8fo0/h04w1/j8
	PsK5kXYtAEk2r3Fr0CFEHHeYzCNs5bwOjgq/our+CXOGdvPnJm8Snd6+ZtTQU4aCCjiKwkVJds9Zf
	FrrZc8ZCLzltxlOseI20VVt2SP8Kwa1UCzRBh3UFK2mWpMi0exbphLy8bj4KZX1hIE5txiKO+B1k8
	GbOfAYrAZ7vHNCGeTg==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tTP8N-007tod-0z;
	Thu, 02 Jan 2025 17:37:23 +0000
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
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH net-next 5/9] i40e: Remove unused i40e_get_cur_guaranteed_fd_count
Date: Thu,  2 Jan 2025 17:37:13 +0000
Message-ID: <20250102173717.200359-6-linux@treblig.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250102173717.200359-1-linux@treblig.org>
References: <20250102173717.200359-1-linux@treblig.org>
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
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
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


