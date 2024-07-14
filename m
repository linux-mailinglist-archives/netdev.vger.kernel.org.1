Return-Path: <netdev+bounces-111357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1DA930AC3
	for <lists+netdev@lfdr.de>; Sun, 14 Jul 2024 18:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 211FB281941
	for <lists+netdev@lfdr.de>; Sun, 14 Jul 2024 16:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE87813B2AC;
	Sun, 14 Jul 2024 16:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="GWsjA/f5"
X-Original-To: netdev@vger.kernel.org
Received: from msa.smtpout.orange.fr (msa-213.smtpout.orange.fr [193.252.23.213])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C707F;
	Sun, 14 Jul 2024 16:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.23.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720974282; cv=none; b=fmXdPgYCZmhu2RSUtUYJjoHxUPCyvfo8eTaan5a7bWh234Zl4LKipj1MU17S1YYlb7pdyZMz/VsUoYFOGuW1JYgX/1pqhWeMGNENOTNbYsqz/7xrahUGS0+K2wnKfNl3oaTAtdPwESRAPB/ftyr/SStCiIIci2wJjAk0colXaAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720974282; c=relaxed/simple;
	bh=FjJUbEgbT6njuYxFEiqNqLxRsMj/drbnkC+PvKhsWUw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D0cBV7oYNiTVGnmOYqt16uf+MaBBVcifcceEsy0IviJoNanf8V3VAYiWTX8FXhVGMGWpx3UVyRam2kGn2WzXn/9rFAbNAh2j50Dt1dhiErU7/gnYCbWyOEheCt7IPt435/7jFjoTHMsA5qhPw35/fHKxRxOVomW8ChFUmSdGDcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=GWsjA/f5; arc=none smtp.client-ip=193.252.23.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id T1sisr9XfKcZaT1sisRKQy; Sun, 14 Jul 2024 18:15:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1720973726;
	bh=X3BjMkIlLlKNDRITAi0sF43nNx7bZHbsFoiwfhlAf7k=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=GWsjA/f5s8n6lHS+5b6ZngPEeC/AEXjE5/TISfvAuxgb1IA1/gluGT2mvBGToXe+k
	 Sg607eCgxufF882GoU+gYrtE7vpgFenVff1SUY4W5Dbhfzlq3QtvbohpuglgUDZRlm
	 vq/KIgYP+jXOyqiSWMM/HzAoAzDZ5qQOB6fpJ75KoGdbCSJFyrxJY8lKF47Tv2z/z5
	 D2k4Vy1uiSKwkDiF0Hvx8YV2h9IpOf747+GCpQKIg3NVg+BeL9bO5U3je9ql70WLm1
	 rUpwmS2qvRcLD37Fyf7lpPxvO0HN1LYI0tm5Qsv4ekqOcxnS/vZwswd4ZdNv9aZ55C
	 HUQ8PYO8DAQGQ==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 14 Jul 2024 18:15:26 +0200
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	netdev@vger.kernel.org
Subject: [PATCH] llc: Constify struct llc_sap_state_trans
Date: Sun, 14 Jul 2024 18:15:20 +0200
Message-ID: <9d17587639195ee94b74ff06a11ef97d1833ee52.1720973710.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'struct llc_sap_state_trans' are not modified in this driver.

Constifying this structure moves some data to a read-only section, so
increase overall security.

On a x86_64, with allmodconfig, as an example:
Before:
======
   text	   data	    bss	    dec	    hex	filename
    339	    456	     24	    819	    333	net/llc/llc_s_st.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
    683	    144	      0	    827	    33b	net/llc/llc_s_st.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested-only.
---
 include/net/llc_s_st.h |  4 ++--
 net/llc/llc_s_st.c     | 26 +++++++++++++-------------
 net/llc/llc_sap.c      | 12 ++++++------
 3 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/include/net/llc_s_st.h b/include/net/llc_s_st.h
index ed5b2fa40d32..fca49d483d20 100644
--- a/include/net/llc_s_st.h
+++ b/include/net/llc_s_st.h
@@ -29,8 +29,8 @@ struct llc_sap_state_trans {
 };
 
 struct llc_sap_state {
-	u8			   curr_state;
-	struct llc_sap_state_trans **transitions;
+	u8				 curr_state;
+	const struct llc_sap_state_trans **transitions;
 };
 
 /* only access to SAP state table */
diff --git a/net/llc/llc_s_st.c b/net/llc/llc_s_st.c
index 308c616883a4..acccc827c562 100644
--- a/net/llc/llc_s_st.c
+++ b/net/llc/llc_s_st.c
@@ -24,7 +24,7 @@
  * last entry for this state
  * all members are zeros, .bss zeroes it
  */
-static struct llc_sap_state_trans llc_sap_state_trans_end;
+static const struct llc_sap_state_trans llc_sap_state_trans_end;
 
 /* state LLC_SAP_STATE_INACTIVE transition for
  * LLC_SAP_EV_ACTIVATION_REQ event
@@ -34,14 +34,14 @@ static const llc_sap_action_t llc_sap_inactive_state_actions_1[] = {
 	[1] = NULL,
 };
 
-static struct llc_sap_state_trans llc_sap_inactive_state_trans_1 = {
+static const struct llc_sap_state_trans llc_sap_inactive_state_trans_1 = {
 	.ev =		llc_sap_ev_activation_req,
 	.next_state =	LLC_SAP_STATE_ACTIVE,
 	.ev_actions =	llc_sap_inactive_state_actions_1,
 };
 
 /* array of pointers; one to each transition */
-static struct llc_sap_state_trans *llc_sap_inactive_state_transitions[] = {
+static const struct llc_sap_state_trans *llc_sap_inactive_state_transitions[] = {
 	[0] = &llc_sap_inactive_state_trans_1,
 	[1] = &llc_sap_state_trans_end,
 };
@@ -52,7 +52,7 @@ static const llc_sap_action_t llc_sap_active_state_actions_1[] = {
 	[1] = NULL,
 };
 
-static struct llc_sap_state_trans llc_sap_active_state_trans_1 = {
+static const struct llc_sap_state_trans llc_sap_active_state_trans_1 = {
 	.ev =		llc_sap_ev_rx_ui,
 	.next_state =	LLC_SAP_STATE_ACTIVE,
 	.ev_actions =	llc_sap_active_state_actions_1,
@@ -64,7 +64,7 @@ static const llc_sap_action_t llc_sap_active_state_actions_2[] = {
 	[1] = NULL,
 };
 
-static struct llc_sap_state_trans llc_sap_active_state_trans_2 = {
+static const struct llc_sap_state_trans llc_sap_active_state_trans_2 = {
 	.ev =		llc_sap_ev_unitdata_req,
 	.next_state =	LLC_SAP_STATE_ACTIVE,
 	.ev_actions =	llc_sap_active_state_actions_2,
@@ -76,7 +76,7 @@ static const llc_sap_action_t llc_sap_active_state_actions_3[] = {
 	[1] = NULL,
 };
 
-static struct llc_sap_state_trans llc_sap_active_state_trans_3 = {
+static const struct llc_sap_state_trans llc_sap_active_state_trans_3 = {
 	.ev =		llc_sap_ev_xid_req,
 	.next_state =	LLC_SAP_STATE_ACTIVE,
 	.ev_actions =	llc_sap_active_state_actions_3,
@@ -88,7 +88,7 @@ static const llc_sap_action_t llc_sap_active_state_actions_4[] = {
 	[1] = NULL,
 };
 
-static struct llc_sap_state_trans llc_sap_active_state_trans_4 = {
+static const struct llc_sap_state_trans llc_sap_active_state_trans_4 = {
 	.ev =		llc_sap_ev_rx_xid_c,
 	.next_state =	LLC_SAP_STATE_ACTIVE,
 	.ev_actions =	llc_sap_active_state_actions_4,
@@ -100,7 +100,7 @@ static const llc_sap_action_t llc_sap_active_state_actions_5[] = {
 	[1] = NULL,
 };
 
-static struct llc_sap_state_trans llc_sap_active_state_trans_5 = {
+static const struct llc_sap_state_trans llc_sap_active_state_trans_5 = {
 	.ev =		llc_sap_ev_rx_xid_r,
 	.next_state =	LLC_SAP_STATE_ACTIVE,
 	.ev_actions =	llc_sap_active_state_actions_5,
@@ -112,7 +112,7 @@ static const llc_sap_action_t llc_sap_active_state_actions_6[] = {
 	[1] = NULL,
 };
 
-static struct llc_sap_state_trans llc_sap_active_state_trans_6 = {
+static const struct llc_sap_state_trans llc_sap_active_state_trans_6 = {
 	.ev =		llc_sap_ev_test_req,
 	.next_state =	LLC_SAP_STATE_ACTIVE,
 	.ev_actions =	llc_sap_active_state_actions_6,
@@ -124,7 +124,7 @@ static const llc_sap_action_t llc_sap_active_state_actions_7[] = {
 	[1] = NULL,
 };
 
-static struct llc_sap_state_trans llc_sap_active_state_trans_7 = {
+static const struct llc_sap_state_trans llc_sap_active_state_trans_7 = {
 	.ev =		llc_sap_ev_rx_test_c,
 	.next_state =	LLC_SAP_STATE_ACTIVE,
 	.ev_actions =	llc_sap_active_state_actions_7
@@ -136,7 +136,7 @@ static const llc_sap_action_t llc_sap_active_state_actions_8[] = {
 	[1] = NULL,
 };
 
-static struct llc_sap_state_trans llc_sap_active_state_trans_8 = {
+static const struct llc_sap_state_trans llc_sap_active_state_trans_8 = {
 	.ev =		llc_sap_ev_rx_test_r,
 	.next_state =	LLC_SAP_STATE_ACTIVE,
 	.ev_actions =	llc_sap_active_state_actions_8,
@@ -150,14 +150,14 @@ static const llc_sap_action_t llc_sap_active_state_actions_9[] = {
 	[1] = NULL,
 };
 
-static struct llc_sap_state_trans llc_sap_active_state_trans_9 = {
+static const struct llc_sap_state_trans llc_sap_active_state_trans_9 = {
 	.ev =		llc_sap_ev_deactivation_req,
 	.next_state =	LLC_SAP_STATE_INACTIVE,
 	.ev_actions =	llc_sap_active_state_actions_9
 };
 
 /* array of pointers; one to each transition */
-static struct llc_sap_state_trans *llc_sap_active_state_transitions[] = {
+static const struct llc_sap_state_trans *llc_sap_active_state_transitions[] = {
 	[0] = &llc_sap_active_state_trans_2,
 	[1] = &llc_sap_active_state_trans_1,
 	[2] = &llc_sap_active_state_trans_3,
diff --git a/net/llc/llc_sap.c b/net/llc/llc_sap.c
index 116c0e479183..6cd03c2ae7d5 100644
--- a/net/llc/llc_sap.c
+++ b/net/llc/llc_sap.c
@@ -114,12 +114,12 @@ void llc_sap_rtn_pdu(struct llc_sap *sap, struct sk_buff *skb)
  *	Returns the pointer to found transition on success or %NULL for
  *	failure.
  */
-static struct llc_sap_state_trans *llc_find_sap_trans(struct llc_sap *sap,
-						      struct sk_buff *skb)
+static const struct llc_sap_state_trans *llc_find_sap_trans(struct llc_sap *sap,
+							    struct sk_buff *skb)
 {
 	int i = 0;
-	struct llc_sap_state_trans *rc = NULL;
-	struct llc_sap_state_trans **next_trans;
+	const struct llc_sap_state_trans *rc = NULL;
+	const struct llc_sap_state_trans **next_trans;
 	struct llc_sap_state *curr_state = &llc_sap_state_table[sap->state - 1];
 	/*
 	 * Search thru events for this state until list exhausted or until
@@ -143,7 +143,7 @@ static struct llc_sap_state_trans *llc_find_sap_trans(struct llc_sap *sap,
  *	Returns 0 for success and 1 for failure of at least one action.
  */
 static int llc_exec_sap_trans_actions(struct llc_sap *sap,
-				      struct llc_sap_state_trans *trans,
+				      const struct llc_sap_state_trans *trans,
 				      struct sk_buff *skb)
 {
 	int rc = 0;
@@ -166,8 +166,8 @@ static int llc_exec_sap_trans_actions(struct llc_sap *sap,
  */
 static int llc_sap_next_state(struct llc_sap *sap, struct sk_buff *skb)
 {
+	const struct llc_sap_state_trans *trans;
 	int rc = 1;
-	struct llc_sap_state_trans *trans;
 
 	if (sap->state > LLC_NR_SAP_STATES)
 		goto out;
-- 
2.45.2


