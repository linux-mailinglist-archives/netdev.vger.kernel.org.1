Return-Path: <netdev+bounces-111354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63978930AB2
	for <lists+netdev@lfdr.de>; Sun, 14 Jul 2024 18:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A4F11C208A5
	for <lists+netdev@lfdr.de>; Sun, 14 Jul 2024 16:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8C313A88A;
	Sun, 14 Jul 2024 16:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="J9eFUlRM"
X-Original-To: netdev@vger.kernel.org
Received: from msa.smtpout.orange.fr (out-67.smtpout.orange.fr [193.252.22.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40DF26AD3;
	Sun, 14 Jul 2024 16:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720973184; cv=none; b=ttPJGzHp5uHQPsr5SpwbsIPiKOeR6/pUqNEc/K81hc6lLAYJWvRgEtwkaUpdMvOISzCBaw0SPKNzCpiAFHsfgkvQH4gEUTS5OaG8KMzlAEKTfwqkpYuD/ExBr7ubd5wjXA0B/PGoLFrm+W5IiJZDiBFJQSY6cTV7igAiurvjfxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720973184; c=relaxed/simple;
	bh=X47K9H9ajGdjebb0A7a8ymmuICaFX4e+uNthMMi5feY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FNdULtrSChBU3TX9b76hmLOffVVivlmk0rrN9KyvYHOakXtohju2X48ZA9AHuPt3zMqPjZ1cR7CjBSG3fHAtKtrdYe19QAVO33Q2tsS0+Xtho8B/Wp9jUsJGSFLKtVt+wZF76HFA4WtWEnEB+P4LWxFEbGrYdNSMjueK1FrYokQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=J9eFUlRM; arc=none smtp.client-ip=193.252.22.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id T1jksfq6pEfqMT1jlscsxd; Sun, 14 Jul 2024 18:06:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1720973170;
	bh=r+UdIaj/aT0W1EAZQ/bo0go3SPqNogmj4Rc2M96MZjY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=J9eFUlRMwBbPLQSYkLePbPlvg9SYOL5b+GmKb08/x+en7cvRvsgGK5sBU3PLVaS5g
	 dmT5Nyy8gW/6kZQY4yDVFcKHZVpnw+tic7ikLEEEacwRpIq1WvAVQcLUXt223jiuq3
	 v4DJLbOQfHU6+T8Ag39FAiSDxcRvy9KRG4xSRYIIVNL8XIlb2tjKh33YKaW1Ldlvv6
	 R9WNXusOaltLkalM53D5G9332g6iTx/+vHvAWq8ugb0BA58hii0NTwvQhFegP4FbPU
	 SZpAXsH5/m7bGT8n/ZCVvJCOEY1WSYCNdfCDOYpua0DrLrzKnnstNF/AwP6T6wJnJM
	 q82p0pNKNc8Fw==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 14 Jul 2024 18:06:10 +0200
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
Subject: [PATCH net-next] llc: Constify struct llc_conn_state_trans
Date: Sun, 14 Jul 2024 18:05:56 +0200
Message-ID: <87cda89e4c9414e71d1a54bb1eb491b0e7f70375.1720973029.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'struct llc_conn_state_trans' are not modified in this driver.

Constifying this structure moves some data to a read-only section, so
increase overall security.

On a x86_64, with allmodconfig, as an example:
Before:
======
   text	   data	    bss	    dec	    hex	filename
  13923	  10896	     32	  24851	   6113	net/llc/llc_c_st.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
  21859	   3328	      0	  25187	   6263	net/llc/llc_c_st.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested-only.
---
 include/net/llc_c_st.h |   4 +-
 net/llc/llc_c_st.c     | 500 ++++++++++++++++++++---------------------
 net/llc/llc_conn.c     |  20 +-
 3 files changed, 262 insertions(+), 262 deletions(-)

diff --git a/include/net/llc_c_st.h b/include/net/llc_c_st.h
index 53823d61d8b6..a4bea0f33188 100644
--- a/include/net/llc_c_st.h
+++ b/include/net/llc_c_st.h
@@ -44,8 +44,8 @@ struct llc_conn_state_trans {
 };
 
 struct llc_conn_state {
-	u8			    current_state;
-	struct llc_conn_state_trans **transitions;
+	u8				  current_state;
+	const struct llc_conn_state_trans **transitions;
 };
 
 extern struct llc_conn_state llc_conn_state_table[];
diff --git a/net/llc/llc_c_st.c b/net/llc/llc_c_st.c
index 2467573b5f84..1c267db304df 100644
--- a/net/llc/llc_c_st.c
+++ b/net/llc/llc_c_st.c
@@ -42,7 +42,7 @@ static const llc_conn_action_t llc_common_actions_1[] = {
 	[5] = NULL,
 };
 
-static struct llc_conn_state_trans llc_common_state_trans_1 = {
+static const struct llc_conn_state_trans llc_common_state_trans_1 = {
 	.ev	       = llc_conn_ev_disc_req,
 	.next_state    = LLC_CONN_STATE_D_CONN,
 	.ev_qualifiers = NONE,
@@ -59,7 +59,7 @@ static const llc_conn_action_t llc_common_actions_2[] = {
 	[5] = NULL,
 };
 
-static struct llc_conn_state_trans llc_common_state_trans_2 = {
+static const struct llc_conn_state_trans llc_common_state_trans_2 = {
 	.ev	       = llc_conn_ev_rst_req,
 	.next_state    = LLC_CONN_STATE_RESET,
 	.ev_qualifiers = NONE,
@@ -79,7 +79,7 @@ static const llc_conn_action_t llc_common_actions_3[] = {
 	[8] = NULL,
 };
 
-static struct llc_conn_state_trans llc_common_state_trans_3 = {
+static const struct llc_conn_state_trans llc_common_state_trans_3 = {
 	.ev	       = llc_conn_ev_rx_sabme_cmd_pbit_set_x,
 	.next_state    = LLC_CONN_STATE_NORMAL,
 	.ev_qualifiers = NONE,
@@ -95,7 +95,7 @@ static const llc_conn_action_t llc_common_actions_4[] = {
 	[4] = NULL,
 };
 
-static struct llc_conn_state_trans llc_common_state_trans_4 = {
+static const struct llc_conn_state_trans llc_common_state_trans_4 = {
 	.ev	       = llc_conn_ev_rx_disc_cmd_pbit_set_x,
 	.next_state    = LLC_CONN_STATE_ADM,
 	.ev_qualifiers = NONE,
@@ -114,7 +114,7 @@ static const llc_conn_action_t llc_common_actions_5[] = {
 	[7] = NULL,
 };
 
-static struct llc_conn_state_trans llc_common_state_trans_5 = {
+static const struct llc_conn_state_trans llc_common_state_trans_5 = {
 	.ev	       = llc_conn_ev_rx_frmr_rsp_fbit_set_x,
 	.next_state    = LLC_CONN_STATE_RESET,
 	.ev_qualifiers = NONE,
@@ -129,7 +129,7 @@ static const llc_conn_action_t llc_common_actions_6[] = {
 	[3] = NULL,
 };
 
-static struct llc_conn_state_trans llc_common_state_trans_6 = {
+static const struct llc_conn_state_trans llc_common_state_trans_6 = {
 	.ev	       = llc_conn_ev_rx_dm_rsp_fbit_set_x,
 	.next_state    = LLC_CONN_STATE_ADM,
 	.ev_qualifiers = NONE,
@@ -145,7 +145,7 @@ static const llc_conn_action_t llc_common_actions_7a[] = {
 	[4] = NULL,
 };
 
-static struct llc_conn_state_trans llc_common_state_trans_7a = {
+static const struct llc_conn_state_trans llc_common_state_trans_7a = {
 	.ev	       = llc_conn_ev_rx_zzz_cmd_pbit_set_x_inval_nr,
 	.next_state    = LLC_CONN_STATE_ERROR,
 	.ev_qualifiers = NONE,
@@ -161,7 +161,7 @@ static const llc_conn_action_t llc_common_actions_7b[] = {
 	[4] = NULL,
 };
 
-static struct llc_conn_state_trans llc_common_state_trans_7b = {
+static const struct llc_conn_state_trans llc_common_state_trans_7b = {
 	.ev	       = llc_conn_ev_rx_i_cmd_pbit_set_x_inval_ns,
 	.next_state    = LLC_CONN_STATE_ERROR,
 	.ev_qualifiers = NONE,
@@ -177,7 +177,7 @@ static const llc_conn_action_t llc_common_actions_8a[] = {
 	[4] = NULL,
 };
 
-static struct llc_conn_state_trans llc_common_state_trans_8a = {
+static const struct llc_conn_state_trans llc_common_state_trans_8a = {
 	.ev	       = llc_conn_ev_rx_zzz_rsp_fbit_set_x_inval_nr,
 	.next_state    = LLC_CONN_STATE_ERROR,
 	.ev_qualifiers = NONE,
@@ -193,7 +193,7 @@ static const llc_conn_action_t llc_common_actions_8b[] = {
 	[4] = NULL,
 };
 
-static struct llc_conn_state_trans llc_common_state_trans_8b = {
+static const struct llc_conn_state_trans llc_common_state_trans_8b = {
 	.ev	       = llc_conn_ev_rx_i_rsp_fbit_set_x_inval_ns,
 	.next_state    = LLC_CONN_STATE_ERROR,
 	.ev_qualifiers = NONE,
@@ -209,7 +209,7 @@ static const llc_conn_action_t llc_common_actions_8c[] = {
 	[4] = NULL,
 };
 
-static struct llc_conn_state_trans llc_common_state_trans_8c = {
+static const struct llc_conn_state_trans llc_common_state_trans_8c = {
 	.ev	       = llc_conn_ev_rx_bad_pdu,
 	.next_state    = LLC_CONN_STATE_ERROR,
 	.ev_qualifiers = NONE,
@@ -225,7 +225,7 @@ static const llc_conn_action_t llc_common_actions_9[] = {
 	[4] = NULL,
 };
 
-static struct llc_conn_state_trans llc_common_state_trans_9 = {
+static const struct llc_conn_state_trans llc_common_state_trans_9 = {
 	.ev	       = llc_conn_ev_rx_ua_rsp_fbit_set_x,
 	.next_state    = LLC_CONN_STATE_ERROR,
 	.ev_qualifiers = NONE,
@@ -247,7 +247,7 @@ static const llc_conn_action_t llc_common_actions_10[] = {
 	[4] = NULL,
 };
 
-static struct llc_conn_state_trans llc_common_state_trans_10 = {
+static const struct llc_conn_state_trans llc_common_state_trans_10 = {
 	.ev	       = llc_conn_ev_rx_xxx_rsp_fbit_set_1,
 	.next_state    = LLC_CONN_STATE_ERROR,
 	.ev_qualifiers = llc_common_ev_qfyrs_10,
@@ -270,7 +270,7 @@ static const llc_conn_action_t llc_common_actions_11a[] = {
 	[5] = NULL,
 };
 
-static struct llc_conn_state_trans llc_common_state_trans_11a = {
+static const struct llc_conn_state_trans llc_common_state_trans_11a = {
 	.ev	       = llc_conn_ev_p_tmr_exp,
 	.next_state    = LLC_CONN_STATE_RESET,
 	.ev_qualifiers = llc_common_ev_qfyrs_11a,
@@ -292,7 +292,7 @@ static const llc_conn_action_t llc_common_actions_11b[] = {
 	[5] = NULL,
 };
 
-static struct llc_conn_state_trans llc_common_state_trans_11b = {
+static const struct llc_conn_state_trans llc_common_state_trans_11b = {
 	.ev	       = llc_conn_ev_ack_tmr_exp,
 	.next_state    = LLC_CONN_STATE_RESET,
 	.ev_qualifiers = llc_common_ev_qfyrs_11b,
@@ -314,7 +314,7 @@ static const llc_conn_action_t llc_common_actions_11c[] = {
 	[5] = NULL,
 };
 
-static struct llc_conn_state_trans llc_common_state_trans_11c = {
+static const struct llc_conn_state_trans llc_common_state_trans_11c = {
 	.ev	       = llc_conn_ev_rej_tmr_exp,
 	.next_state    = LLC_CONN_STATE_RESET,
 	.ev_qualifiers = llc_common_ev_qfyrs_11c,
@@ -336,7 +336,7 @@ static const llc_conn_action_t llc_common_actions_11d[] = {
 	[5] = NULL,
 };
 
-static struct llc_conn_state_trans llc_common_state_trans_11d = {
+static const struct llc_conn_state_trans llc_common_state_trans_11d = {
 	.ev	       = llc_conn_ev_busy_tmr_exp,
 	.next_state    = LLC_CONN_STATE_RESET,
 	.ev_qualifiers = llc_common_ev_qfyrs_11d,
@@ -347,7 +347,7 @@ static struct llc_conn_state_trans llc_common_state_trans_11d = {
  * Common dummy state transition; must be last entry for all state
  * transition groups - it'll be on .bss, so will be zeroed.
  */
-static struct llc_conn_state_trans llc_common_state_trans_end;
+static const struct llc_conn_state_trans llc_common_state_trans_end;
 
 /* LLC_CONN_STATE_ADM transitions */
 /* State transitions for LLC_CONN_EV_CONN_REQ event */
@@ -359,7 +359,7 @@ static const llc_conn_action_t llc_adm_actions_1[] = {
 	[4] = NULL,
 };
 
-static struct llc_conn_state_trans llc_adm_state_trans_1 = {
+static const struct llc_conn_state_trans llc_adm_state_trans_1 = {
 	.ev	       = llc_conn_ev_conn_req,
 	.next_state    = LLC_CONN_STATE_SETUP,
 	.ev_qualifiers = NONE,
@@ -378,7 +378,7 @@ static const llc_conn_action_t llc_adm_actions_2[] = {
 	[7] = NULL,
 };
 
-static struct llc_conn_state_trans llc_adm_state_trans_2 = {
+static const struct llc_conn_state_trans llc_adm_state_trans_2 = {
 	.ev	       = llc_conn_ev_rx_sabme_cmd_pbit_set_x,
 	.next_state    = LLC_CONN_STATE_NORMAL,
 	.ev_qualifiers = NONE,
@@ -392,7 +392,7 @@ static const llc_conn_action_t llc_adm_actions_3[] = {
 	[2] = NULL,
 };
 
-static struct llc_conn_state_trans llc_adm_state_trans_3 = {
+static const struct llc_conn_state_trans llc_adm_state_trans_3 = {
 	.ev	       = llc_conn_ev_rx_disc_cmd_pbit_set_x,
 	.next_state    = LLC_CONN_STATE_ADM,
 	.ev_qualifiers = NONE,
@@ -406,7 +406,7 @@ static const llc_conn_action_t llc_adm_actions_4[] = {
 	[2] = NULL,
 };
 
-static struct llc_conn_state_trans llc_adm_state_trans_4 = {
+static const struct llc_conn_state_trans llc_adm_state_trans_4 = {
 	.ev	       = llc_conn_ev_rx_xxx_cmd_pbit_set_1,
 	.next_state    = LLC_CONN_STATE_ADM,
 	.ev_qualifiers = NONE,
@@ -419,7 +419,7 @@ static const llc_conn_action_t llc_adm_actions_5[] = {
 	[1] = NULL,
 };
 
-static struct llc_conn_state_trans llc_adm_state_trans_5 = {
+static const struct llc_conn_state_trans llc_adm_state_trans_5 = {
 	.ev	       = llc_conn_ev_rx_any_frame,
 	.next_state    = LLC_CONN_OUT_OF_SVC,
 	.ev_qualifiers = NONE,
@@ -430,7 +430,7 @@ static struct llc_conn_state_trans llc_adm_state_trans_5 = {
  * Array of pointers;
  * one to each transition
  */
-static struct llc_conn_state_trans *llc_adm_state_transitions[] = {
+static const struct llc_conn_state_trans *llc_adm_state_transitions[] = {
 	[0] = &llc_adm_state_trans_1,		/* Request */
 	[1] = &llc_common_state_trans_end,
 	[2] = &llc_common_state_trans_end,	/* local_busy */
@@ -453,7 +453,7 @@ static const llc_conn_action_t llc_setup_actions_1[] = {
 	[4] = NULL,
 };
 
-static struct llc_conn_state_trans llc_setup_state_trans_1 = {
+static const struct llc_conn_state_trans llc_setup_state_trans_1 = {
 	.ev	       = llc_conn_ev_rx_sabme_cmd_pbit_set_x,
 	.next_state    = LLC_CONN_STATE_SETUP,
 	.ev_qualifiers = NONE,
@@ -477,7 +477,7 @@ static const llc_conn_action_t llc_setup_actions_2[] = {
 	[6] = NULL,
 };
 
-static struct llc_conn_state_trans llc_setup_state_trans_2 = {
+static const struct llc_conn_state_trans llc_setup_state_trans_2 = {
 	.ev	       = llc_conn_ev_rx_ua_rsp_fbit_set_x,
 	.next_state    = LLC_CONN_STATE_NORMAL,
 	.ev_qualifiers = llc_setup_ev_qfyrs_2,
@@ -498,7 +498,7 @@ static const llc_conn_action_t llc_setup_actions_3[] = {
 	[3] = NULL,
 };
 
-static struct llc_conn_state_trans llc_setup_state_trans_3 = {
+static const struct llc_conn_state_trans llc_setup_state_trans_3 = {
 	.ev	       = llc_conn_ev_ack_tmr_exp,
 	.next_state    = LLC_CONN_STATE_NORMAL,
 	.ev_qualifiers = llc_setup_ev_qfyrs_3,
@@ -519,7 +519,7 @@ static const llc_conn_action_t llc_setup_actions_4[] = {
 	[4] = NULL,
 };
 
-static struct llc_conn_state_trans llc_setup_state_trans_4 = {
+static const struct llc_conn_state_trans llc_setup_state_trans_4 = {
 	.ev	       = llc_conn_ev_rx_disc_cmd_pbit_set_x,
 	.next_state    = LLC_CONN_STATE_ADM,
 	.ev_qualifiers = llc_setup_ev_qfyrs_4,
@@ -539,7 +539,7 @@ static const llc_conn_action_t llc_setup_actions_5[] = {
 	[3] = NULL,
 };
 
-static struct llc_conn_state_trans llc_setup_state_trans_5 = {
+static const struct llc_conn_state_trans llc_setup_state_trans_5 = {
 	.ev	       = llc_conn_ev_rx_dm_rsp_fbit_set_x,
 	.next_state    = LLC_CONN_STATE_ADM,
 	.ev_qualifiers = llc_setup_ev_qfyrs_5,
@@ -560,7 +560,7 @@ static const llc_conn_action_t llc_setup_actions_7[] = {
 	[3] = NULL,
 };
 
-static struct llc_conn_state_trans llc_setup_state_trans_7 = {
+static const struct llc_conn_state_trans llc_setup_state_trans_7 = {
 	.ev	       = llc_conn_ev_ack_tmr_exp,
 	.next_state    = LLC_CONN_STATE_SETUP,
 	.ev_qualifiers = llc_setup_ev_qfyrs_7,
@@ -581,7 +581,7 @@ static const llc_conn_action_t llc_setup_actions_8[] = {
 	[2] = NULL,
 };
 
-static struct llc_conn_state_trans llc_setup_state_trans_8 = {
+static const struct llc_conn_state_trans llc_setup_state_trans_8 = {
 	.ev	       = llc_conn_ev_ack_tmr_exp,
 	.next_state    = LLC_CONN_STATE_ADM,
 	.ev_qualifiers = llc_setup_ev_qfyrs_8,
@@ -592,7 +592,7 @@ static struct llc_conn_state_trans llc_setup_state_trans_8 = {
  * Array of pointers;
  * one to each transition
  */
-static struct llc_conn_state_trans *llc_setup_state_transitions[] = {
+static const struct llc_conn_state_trans *llc_setup_state_transitions[] = {
 	 [0] = &llc_common_state_trans_end,	/* Request */
 	 [1] = &llc_common_state_trans_end,	/* local busy */
 	 [2] = &llc_common_state_trans_end,	/* init_pf_cycle */
@@ -622,7 +622,7 @@ static const llc_conn_action_t llc_normal_actions_1[] = {
 	[2] = NULL,
 };
 
-static struct llc_conn_state_trans llc_normal_state_trans_1 = {
+static const struct llc_conn_state_trans llc_normal_state_trans_1 = {
 	.ev	       = llc_conn_ev_data_req,
 	.next_state    = LLC_CONN_STATE_NORMAL,
 	.ev_qualifiers = llc_normal_ev_qfyrs_1,
@@ -643,7 +643,7 @@ static const llc_conn_action_t llc_normal_actions_2[] = {
 	[2] = NULL,
 };
 
-static struct llc_conn_state_trans llc_normal_state_trans_2 = {
+static const struct llc_conn_state_trans llc_normal_state_trans_2 = {
 	.ev	       = llc_conn_ev_data_req,
 	.next_state    = LLC_CONN_STATE_NORMAL,
 	.ev_qualifiers = llc_normal_ev_qfyrs_2,
@@ -660,7 +660,7 @@ static const llc_conn_ev_qfyr_t llc_normal_ev_qfyrs_2_1[] = {
 /* just one member, NULL, .bss zeroes it */
 static const llc_conn_action_t llc_normal_actions_2_1[1];
 
-static struct llc_conn_state_trans llc_normal_state_trans_2_1 = {
+static const struct llc_conn_state_trans llc_normal_state_trans_2_1 = {
 	.ev	       = llc_conn_ev_data_req,
 	.next_state    = LLC_CONN_STATE_NORMAL,
 	.ev_qualifiers = llc_normal_ev_qfyrs_2_1,
@@ -680,7 +680,7 @@ static const llc_conn_action_t llc_normal_actions_3[] = {
 	[3] = NULL,
 };
 
-static struct llc_conn_state_trans llc_normal_state_trans_3 = {
+static const struct llc_conn_state_trans llc_normal_state_trans_3 = {
 	.ev	       = llc_conn_ev_local_busy_detected,
 	.next_state    = LLC_CONN_STATE_BUSY,
 	.ev_qualifiers = llc_normal_ev_qfyrs_3,
@@ -700,7 +700,7 @@ static const llc_conn_action_t llc_normal_actions_4[] = {
 	[3] = NULL,
 };
 
-static struct llc_conn_state_trans llc_normal_state_trans_4 = {
+static const struct llc_conn_state_trans llc_normal_state_trans_4 = {
 	.ev	       = llc_conn_ev_local_busy_detected,
 	.next_state    = LLC_CONN_STATE_BUSY,
 	.ev_qualifiers = llc_normal_ev_qfyrs_4,
@@ -723,7 +723,7 @@ static const llc_conn_action_t llc_normal_actions_5a[] = {
 	[6] = NULL,
 };
 
-static struct llc_conn_state_trans llc_normal_state_trans_5a = {
+static const struct llc_conn_state_trans llc_normal_state_trans_5a = {
 	.ev	       = llc_conn_ev_rx_i_cmd_pbit_set_0_unexpd_ns,
 	.next_state    = LLC_CONN_STATE_REJ,
 	.ev_qualifiers = llc_normal_ev_qfyrs_5a,
@@ -746,7 +746,7 @@ static const llc_conn_action_t llc_normal_actions_5b[] = {
 	[6] = NULL,
 };
 
-static struct llc_conn_state_trans llc_normal_state_trans_5b = {
+static const struct llc_conn_state_trans llc_normal_state_trans_5b = {
 	.ev	       = llc_conn_ev_rx_i_rsp_fbit_set_0_unexpd_ns,
 	.next_state    = LLC_CONN_STATE_REJ,
 	.ev_qualifiers = llc_normal_ev_qfyrs_5b,
@@ -769,7 +769,7 @@ static const llc_conn_action_t llc_normal_actions_5c[] = {
 	[6] = NULL,
 };
 
-static struct llc_conn_state_trans llc_normal_state_trans_5c = {
+static const struct llc_conn_state_trans llc_normal_state_trans_5c = {
 	.ev	       = llc_conn_ev_rx_i_rsp_fbit_set_1_unexpd_ns,
 	.next_state    = LLC_CONN_STATE_REJ,
 	.ev_qualifiers = llc_normal_ev_qfyrs_5c,
@@ -790,7 +790,7 @@ static const llc_conn_action_t llc_normal_actions_6a[] = {
 	[4] = NULL,
 };
 
-static struct llc_conn_state_trans llc_normal_state_trans_6a = {
+static const struct llc_conn_state_trans llc_normal_state_trans_6a = {
 	.ev	       = llc_conn_ev_rx_i_cmd_pbit_set_0_unexpd_ns,
 	.next_state    = LLC_CONN_STATE_REJ,
 	.ev_qualifiers = llc_normal_ev_qfyrs_6a,
@@ -811,7 +811,7 @@ static const llc_conn_action_t llc_normal_actions_6b[] = {
 	[4] = NULL,
 };
 
-static struct llc_conn_state_trans llc_normal_state_trans_6b = {
+static const struct llc_conn_state_trans llc_normal_state_trans_6b = {
 	.ev	       = llc_conn_ev_rx_i_rsp_fbit_set_0_unexpd_ns,
 	.next_state    = LLC_CONN_STATE_REJ,
 	.ev_qualifiers = llc_normal_ev_qfyrs_6b,
@@ -827,7 +827,7 @@ static const llc_conn_action_t llc_normal_actions_7[] = {
 	[4] = NULL,
 };
 
-static struct llc_conn_state_trans llc_normal_state_trans_7 = {
+static const struct llc_conn_state_trans llc_normal_state_trans_7 = {
 	.ev	       = llc_conn_ev_rx_i_cmd_pbit_set_1_unexpd_ns,
 	.next_state    = LLC_CONN_STATE_REJ,
 	.ev_qualifiers = NONE,
@@ -850,7 +850,7 @@ static const llc_conn_action_t llc_normal_actions_8[] = {
 	[6] = NULL,
 };
 
-static struct llc_conn_state_trans llc_normal_state_trans_8a = {
+static const struct llc_conn_state_trans llc_normal_state_trans_8a = {
 	.ev	       = llc_conn_ev_rx_i_rsp_fbit_set_x,
 	.next_state    = LLC_CONN_STATE_NORMAL,
 	.ev_qualifiers = llc_normal_ev_qfyrs_8a,
@@ -863,7 +863,7 @@ static const llc_conn_ev_qfyr_t llc_normal_ev_qfyrs_8b[] = {
 	[1] = NULL,
 };
 
-static struct llc_conn_state_trans llc_normal_state_trans_8b = {
+static const struct llc_conn_state_trans llc_normal_state_trans_8b = {
 	.ev	       = llc_conn_ev_rx_i_cmd_pbit_set_0,
 	.next_state    = LLC_CONN_STATE_NORMAL,
 	.ev_qualifiers = llc_normal_ev_qfyrs_8b,
@@ -884,7 +884,7 @@ static const llc_conn_action_t llc_normal_actions_9a[] = {
 	[4] = NULL,
 };
 
-static struct llc_conn_state_trans llc_normal_state_trans_9a = {
+static const struct llc_conn_state_trans llc_normal_state_trans_9a = {
 	.ev	       = llc_conn_ev_rx_i_rsp_fbit_set_0,
 	.next_state    = LLC_CONN_STATE_NORMAL,
 	.ev_qualifiers = llc_normal_ev_qfyrs_9a,
@@ -905,7 +905,7 @@ static const llc_conn_action_t llc_normal_actions_9b[] = {
 	[4] = NULL,
 };
 
-static struct llc_conn_state_trans llc_normal_state_trans_9b = {
+static const struct llc_conn_state_trans llc_normal_state_trans_9b = {
 	.ev	       = llc_conn_ev_rx_i_cmd_pbit_set_0,
 	.next_state    = LLC_CONN_STATE_NORMAL,
 	.ev_qualifiers = llc_normal_ev_qfyrs_9b,
@@ -922,7 +922,7 @@ static const llc_conn_action_t llc_normal_actions_10[] = {
 	[5] = NULL,
 };
 
-static struct llc_conn_state_trans llc_normal_state_trans_10 = {
+static const struct llc_conn_state_trans llc_normal_state_trans_10 = {
 	.ev	       = llc_conn_ev_rx_i_cmd_pbit_set_1,
 	.next_state    = LLC_CONN_STATE_NORMAL,
 	.ev_qualifiers = NONE,
@@ -937,7 +937,7 @@ static const llc_conn_action_t llc_normal_actions_11a[] = {
 	[3] = NULL,
 };
 
-static struct llc_conn_state_trans llc_normal_state_trans_11a = {
+static const struct llc_conn_state_trans llc_normal_state_trans_11a = {
 	.ev	       = llc_conn_ev_rx_rr_cmd_pbit_set_0,
 	.next_state    = LLC_CONN_STATE_NORMAL,
 	.ev_qualifiers = NONE,
@@ -952,7 +952,7 @@ static const llc_conn_action_t llc_normal_actions_11b[] = {
 	[3] = NULL,
 };
 
-static struct llc_conn_state_trans llc_normal_state_trans_11b = {
+static const struct llc_conn_state_trans llc_normal_state_trans_11b = {
 	.ev	       = llc_conn_ev_rx_rr_rsp_fbit_set_0,
 	.next_state    = LLC_CONN_STATE_NORMAL,
 	.ev_qualifiers = NONE,
@@ -973,7 +973,7 @@ static const llc_conn_action_t llc_normal_actions_11c[] = {
 	[4] = NULL,
 };
 
-static struct llc_conn_state_trans llc_normal_state_trans_11c = {
+static const struct llc_conn_state_trans llc_normal_state_trans_11c = {
 	.ev	       = llc_conn_ev_rx_rr_rsp_fbit_set_1,
 	.next_state    = LLC_CONN_STATE_NORMAL,
 	.ev_qualifiers = llc_normal_ev_qfyrs_11c,
@@ -990,7 +990,7 @@ static const llc_conn_action_t llc_normal_actions_12[] = {
 	[5] = NULL,
 };
 
-static struct llc_conn_state_trans llc_normal_state_trans_12 = {
+static const struct llc_conn_state_trans llc_normal_state_trans_12 = {
 	.ev	       = llc_conn_ev_rx_rr_cmd_pbit_set_1,
 	.next_state    = LLC_CONN_STATE_NORMAL,
 	.ev_qualifiers = NONE,
@@ -1005,7 +1005,7 @@ static const llc_conn_action_t llc_normal_actions_13a[] = {
 	[3] = NULL,
 };
 
-static struct llc_conn_state_trans llc_normal_state_trans_13a = {
+static const struct llc_conn_state_trans llc_normal_state_trans_13a = {
 	.ev	       = llc_conn_ev_rx_rnr_cmd_pbit_set_0,
 	.next_state    = LLC_CONN_STATE_NORMAL,
 	.ev_qualifiers = NONE,
@@ -1020,7 +1020,7 @@ static const llc_conn_action_t llc_normal_actions_13b[] = {
 	[3] = NULL,
 };
 
-static struct llc_conn_state_trans llc_normal_state_trans_13b = {
+static const struct llc_conn_state_trans llc_normal_state_trans_13b = {
 	.ev	       = llc_conn_ev_rx_rnr_rsp_fbit_set_0,
 	.next_state    = LLC_CONN_STATE_NORMAL,
 	.ev_qualifiers = NONE,
@@ -1040,7 +1040,7 @@ static const llc_conn_action_t llc_normal_actions_13c[] = {
 	[3] = NULL,
 };
 
-static struct llc_conn_state_trans llc_normal_state_trans_13c = {
+static const struct llc_conn_state_trans llc_normal_state_trans_13c = {
 	.ev	       = llc_conn_ev_rx_rnr_rsp_fbit_set_1,
 	.next_state    = LLC_CONN_STATE_NORMAL,
 	.ev_qualifiers = llc_normal_ev_qfyrs_13c,
@@ -1057,7 +1057,7 @@ static const llc_conn_action_t llc_normal_actions_14[] = {
 	[5] = NULL,
 };
 
-static struct llc_conn_state_trans llc_normal_state_trans_14 = {
+static const struct llc_conn_state_trans llc_normal_state_trans_14 = {
 	.ev	       = llc_conn_ev_rx_rnr_cmd_pbit_set_1,
 	.next_state    = LLC_CONN_STATE_NORMAL,
 	.ev_qualifiers = NONE,
@@ -1080,7 +1080,7 @@ static const llc_conn_action_t llc_normal_actions_15a[] = {
 	[6] = NULL,
 };
 
-static struct llc_conn_state_trans llc_normal_state_trans_15a = {
+static const struct llc_conn_state_trans llc_normal_state_trans_15a = {
 	.ev	       = llc_conn_ev_rx_rej_cmd_pbit_set_0,
 	.next_state    = LLC_CONN_STATE_NORMAL,
 	.ev_qualifiers = llc_normal_ev_qfyrs_15a,
@@ -1103,7 +1103,7 @@ static const llc_conn_action_t llc_normal_actions_15b[] = {
 	[6] = NULL,
 };
 
-static struct llc_conn_state_trans llc_normal_state_trans_15b = {
+static const struct llc_conn_state_trans llc_normal_state_trans_15b = {
 	.ev	       = llc_conn_ev_rx_rej_rsp_fbit_set_x,
 	.next_state    = LLC_CONN_STATE_NORMAL,
 	.ev_qualifiers = llc_normal_ev_qfyrs_15b,
@@ -1125,7 +1125,7 @@ static const llc_conn_action_t llc_normal_actions_16a[] = {
 	[5] = NULL,
 };
 
-static struct llc_conn_state_trans llc_normal_state_trans_16a = {
+static const struct llc_conn_state_trans llc_normal_state_trans_16a = {
 	.ev	       = llc_conn_ev_rx_rej_cmd_pbit_set_0,
 	.next_state    = LLC_CONN_STATE_NORMAL,
 	.ev_qualifiers = llc_normal_ev_qfyrs_16a,
@@ -1147,7 +1147,7 @@ static const llc_conn_action_t llc_normal_actions_16b[] = {
 	[5] = NULL,
 };
 
-static struct llc_conn_state_trans llc_normal_state_trans_16b = {
+static const struct llc_conn_state_trans llc_normal_state_trans_16b = {
 	.ev	       = llc_conn_ev_rx_rej_rsp_fbit_set_0,
 	.next_state    = LLC_CONN_STATE_NORMAL,
 	.ev_qualifiers = llc_normal_ev_qfyrs_16b,
@@ -1164,7 +1164,7 @@ static const llc_conn_action_t llc_normal_actions_17[] = {
 	[5] = NULL,
 };
 
-static struct llc_conn_state_trans llc_normal_state_trans_17 = {
+static const struct llc_conn_state_trans llc_normal_state_trans_17 = {
 	.ev	       = llc_conn_ev_rx_rej_cmd_pbit_set_1,
 	.next_state    = LLC_CONN_STATE_NORMAL,
 	.ev_qualifiers = NONE,
@@ -1183,7 +1183,7 @@ static const llc_conn_action_t llc_normal_actions_18[] = {
 	[2] = NULL,
 };
 
-static struct llc_conn_state_trans llc_normal_state_trans_18 = {
+static const struct llc_conn_state_trans llc_normal_state_trans_18 = {
 	.ev	       = llc_conn_ev_init_p_f_cycle,
 	.next_state    = LLC_CONN_STATE_NORMAL,
 	.ev_qualifiers = llc_normal_ev_qfyrs_18,
@@ -1205,7 +1205,7 @@ static const llc_conn_action_t llc_normal_actions_19[] = {
 	[5] = NULL,
 };
 
-static struct llc_conn_state_trans llc_normal_state_trans_19 = {
+static const struct llc_conn_state_trans llc_normal_state_trans_19 = {
 	.ev	       = llc_conn_ev_p_tmr_exp,
 	.next_state    = LLC_CONN_STATE_AWAIT,
 	.ev_qualifiers = llc_normal_ev_qfyrs_19,
@@ -1228,7 +1228,7 @@ static const llc_conn_action_t llc_normal_actions_20a[] = {
 	[5] = NULL,
 };
 
-static struct llc_conn_state_trans llc_normal_state_trans_20a = {
+static const struct llc_conn_state_trans llc_normal_state_trans_20a = {
 	.ev	       = llc_conn_ev_ack_tmr_exp,
 	.next_state    = LLC_CONN_STATE_AWAIT,
 	.ev_qualifiers = llc_normal_ev_qfyrs_20a,
@@ -1251,7 +1251,7 @@ static const llc_conn_action_t llc_normal_actions_20b[] = {
 	[5] = NULL,
 };
 
-static struct llc_conn_state_trans llc_normal_state_trans_20b = {
+static const struct llc_conn_state_trans llc_normal_state_trans_20b = {
 	.ev	       = llc_conn_ev_busy_tmr_exp,
 	.next_state    = LLC_CONN_STATE_AWAIT,
 	.ev_qualifiers = llc_normal_ev_qfyrs_20b,
@@ -1270,7 +1270,7 @@ static const llc_conn_action_t llc_normal_actions_21[] = {
 	[2] = NULL,
 };
 
-static struct llc_conn_state_trans llc_normal_state_trans_21 = {
+static const struct llc_conn_state_trans llc_normal_state_trans_21 = {
 	.ev	       = llc_conn_ev_tx_buffer_full,
 	.next_state    = LLC_CONN_STATE_NORMAL,
 	.ev_qualifiers = llc_normal_ev_qfyrs_21,
@@ -1281,7 +1281,7 @@ static struct llc_conn_state_trans llc_normal_state_trans_21 = {
  * Array of pointers;
  * one to each transition
  */
-static struct llc_conn_state_trans *llc_normal_state_transitions[] = {
+static const struct llc_conn_state_trans *llc_normal_state_transitions[] = {
 	 [0] = &llc_normal_state_trans_1,	/* Requests */
 	 [1] = &llc_normal_state_trans_2,
 	 [2] = &llc_normal_state_trans_2_1,
@@ -1354,7 +1354,7 @@ static const llc_conn_action_t llc_busy_actions_1[] = {
 	[2] = NULL,
 };
 
-static struct llc_conn_state_trans llc_busy_state_trans_1 = {
+static const struct llc_conn_state_trans llc_busy_state_trans_1 = {
 	.ev	       = llc_conn_ev_data_req,
 	.next_state    = LLC_CONN_STATE_BUSY,
 	.ev_qualifiers = llc_busy_ev_qfyrs_1,
@@ -1374,7 +1374,7 @@ static const llc_conn_action_t llc_busy_actions_2[] = {
 	[2] = NULL,
 };
 
-static struct llc_conn_state_trans llc_busy_state_trans_2 = {
+static const struct llc_conn_state_trans llc_busy_state_trans_2 = {
 	.ev	       = llc_conn_ev_data_req,
 	.next_state    = LLC_CONN_STATE_BUSY,
 	.ev_qualifiers = llc_busy_ev_qfyrs_2,
@@ -1391,7 +1391,7 @@ static const llc_conn_ev_qfyr_t llc_busy_ev_qfyrs_2_1[] = {
 /* just one member, NULL, .bss zeroes it */
 static const llc_conn_action_t llc_busy_actions_2_1[1];
 
-static struct llc_conn_state_trans llc_busy_state_trans_2_1 = {
+static const struct llc_conn_state_trans llc_busy_state_trans_2_1 = {
 	.ev	       = llc_conn_ev_data_req,
 	.next_state    = LLC_CONN_STATE_BUSY,
 	.ev_qualifiers = llc_busy_ev_qfyrs_2_1,
@@ -1411,7 +1411,7 @@ static const llc_conn_action_t llc_busy_actions_3[] = {
 	[2] = NULL,
 };
 
-static struct llc_conn_state_trans llc_busy_state_trans_3 = {
+static const struct llc_conn_state_trans llc_busy_state_trans_3 = {
 	.ev	       = llc_conn_ev_local_busy_cleared,
 	.next_state    = LLC_CONN_STATE_REJ,
 	.ev_qualifiers = llc_busy_ev_qfyrs_3,
@@ -1431,7 +1431,7 @@ static const llc_conn_action_t llc_busy_actions_4[] = {
 	[2] = NULL,
 };
 
-static struct llc_conn_state_trans llc_busy_state_trans_4 = {
+static const struct llc_conn_state_trans llc_busy_state_trans_4 = {
 	.ev	       = llc_conn_ev_local_busy_cleared,
 	.next_state    = LLC_CONN_STATE_REJ,
 	.ev_qualifiers = llc_busy_ev_qfyrs_4,
@@ -1450,7 +1450,7 @@ static const llc_conn_action_t llc_busy_actions_5[] = {
 	[1] = NULL,
 };
 
-static struct llc_conn_state_trans llc_busy_state_trans_5 = {
+static const struct llc_conn_state_trans llc_busy_state_trans_5 = {
 	.ev	       = llc_conn_ev_local_busy_cleared,
 	.next_state    = LLC_CONN_STATE_NORMAL,
 	.ev_qualifiers = llc_busy_ev_qfyrs_5,
@@ -1469,7 +1469,7 @@ static const llc_conn_action_t llc_busy_actions_6[] = {
 	[1] = NULL,
 };
 
-static struct llc_conn_state_trans llc_busy_state_trans_6 = {
+static const struct llc_conn_state_trans llc_busy_state_trans_6 = {
 	.ev	       = llc_conn_ev_local_busy_cleared,
 	.next_state    = LLC_CONN_STATE_NORMAL,
 	.ev_qualifiers = llc_busy_ev_qfyrs_6,
@@ -1488,7 +1488,7 @@ static const llc_conn_action_t llc_busy_actions_7[] = {
 	[1] = NULL,
 };
 
-static struct llc_conn_state_trans llc_busy_state_trans_7 = {
+static const struct llc_conn_state_trans llc_busy_state_trans_7 = {
 	.ev	       = llc_conn_ev_local_busy_cleared,
 	.next_state    = LLC_CONN_STATE_REJ,
 	.ev_qualifiers = llc_busy_ev_qfyrs_7,
@@ -1507,7 +1507,7 @@ static const llc_conn_action_t llc_busy_actions_8[] = {
 	[1] = NULL,
 };
 
-static struct llc_conn_state_trans llc_busy_state_trans_8 = {
+static const struct llc_conn_state_trans llc_busy_state_trans_8 = {
 	.ev	       = llc_conn_ev_local_busy_cleared,
 	.next_state    = LLC_CONN_STATE_REJ,
 	.ev_qualifiers = llc_busy_ev_qfyrs_8,
@@ -1529,7 +1529,7 @@ static const llc_conn_action_t llc_busy_actions_9a[] = {
 	[5] = NULL,
 };
 
-static struct llc_conn_state_trans llc_busy_state_trans_9a = {
+static const struct llc_conn_state_trans llc_busy_state_trans_9a = {
 	.ev	       = llc_conn_ev_rx_i_rsp_fbit_set_x_unexpd_ns,
 	.next_state    = LLC_CONN_STATE_BUSY,
 	.ev_qualifiers = llc_busy_ev_qfyrs_9a,
@@ -1551,7 +1551,7 @@ static const llc_conn_action_t llc_busy_actions_9b[] = {
 	[5] = NULL,
 };
 
-static struct llc_conn_state_trans llc_busy_state_trans_9b = {
+static const struct llc_conn_state_trans llc_busy_state_trans_9b = {
 	.ev	       = llc_conn_ev_rx_i_cmd_pbit_set_0_unexpd_ns,
 	.next_state    = LLC_CONN_STATE_BUSY,
 	.ev_qualifiers = llc_busy_ev_qfyrs_9b,
@@ -1571,7 +1571,7 @@ static const llc_conn_action_t llc_busy_actions_10a[] = {
 	[3] = NULL,
 };
 
-static struct llc_conn_state_trans llc_busy_state_trans_10a = {
+static const struct llc_conn_state_trans llc_busy_state_trans_10a = {
 	.ev	       = llc_conn_ev_rx_i_rsp_fbit_set_0_unexpd_ns,
 	.next_state    = LLC_CONN_STATE_BUSY,
 	.ev_qualifiers = llc_busy_ev_qfyrs_10a,
@@ -1591,7 +1591,7 @@ static const llc_conn_action_t llc_busy_actions_10b[] = {
 	[3] = NULL,
 };
 
-static struct llc_conn_state_trans llc_busy_state_trans_10b = {
+static const struct llc_conn_state_trans llc_busy_state_trans_10b = {
 	.ev	       = llc_conn_ev_rx_i_cmd_pbit_set_0_unexpd_ns,
 	.next_state    = LLC_CONN_STATE_BUSY,
 	.ev_qualifiers = llc_busy_ev_qfyrs_10b,
@@ -1606,7 +1606,7 @@ static const llc_conn_action_t llc_busy_actions_11[] = {
 	[3] = NULL,
 };
 
-static struct llc_conn_state_trans llc_busy_state_trans_11 = {
+static const struct llc_conn_state_trans llc_busy_state_trans_11 = {
 	.ev	       = llc_conn_ev_rx_i_cmd_pbit_set_1_unexpd_ns,
 	.next_state    = LLC_CONN_STATE_BUSY,
 	.ev_qualifiers = NONE,
@@ -1624,7 +1624,7 @@ static const llc_conn_action_t llc_busy_actions_12[] = {
 	[6] = NULL,
 };
 
-static struct llc_conn_state_trans llc_busy_state_trans_12 = {
+static const struct llc_conn_state_trans llc_busy_state_trans_12 = {
 	.ev	       = llc_conn_ev_rx_i_cmd_pbit_set_1,
 	.next_state    = LLC_CONN_STATE_BUSY,
 	.ev_qualifiers = NONE,
@@ -1649,7 +1649,7 @@ static const llc_conn_action_t llc_busy_actions_13a[] = {
 	[8] = NULL,
 };
 
-static struct llc_conn_state_trans llc_busy_state_trans_13a = {
+static const struct llc_conn_state_trans llc_busy_state_trans_13a = {
 	.ev	       = llc_conn_ev_rx_i_rsp_fbit_set_x,
 	.next_state    = LLC_CONN_STATE_BUSY,
 	.ev_qualifiers = llc_busy_ev_qfyrs_13a,
@@ -1674,7 +1674,7 @@ static const llc_conn_action_t llc_busy_actions_13b[] = {
 	[8] = NULL,
 };
 
-static struct llc_conn_state_trans llc_busy_state_trans_13b = {
+static const struct llc_conn_state_trans llc_busy_state_trans_13b = {
 	.ev	       = llc_conn_ev_rx_i_cmd_pbit_set_0,
 	.next_state    = LLC_CONN_STATE_BUSY,
 	.ev_qualifiers = llc_busy_ev_qfyrs_13b,
@@ -1697,7 +1697,7 @@ static const llc_conn_action_t llc_busy_actions_14a[] = {
 	[6] = NULL,
 };
 
-static struct llc_conn_state_trans llc_busy_state_trans_14a = {
+static const struct llc_conn_state_trans llc_busy_state_trans_14a = {
 	.ev	       = llc_conn_ev_rx_i_rsp_fbit_set_0,
 	.next_state    = LLC_CONN_STATE_BUSY,
 	.ev_qualifiers = llc_busy_ev_qfyrs_14a,
@@ -1720,7 +1720,7 @@ static const llc_conn_action_t llc_busy_actions_14b[] = {
 	[6] = NULL,
 };
 
-static struct llc_conn_state_trans llc_busy_state_trans_14b = {
+static const struct llc_conn_state_trans llc_busy_state_trans_14b = {
 	.ev	       = llc_conn_ev_rx_i_cmd_pbit_set_0,
 	.next_state    = LLC_CONN_STATE_BUSY,
 	.ev_qualifiers = llc_busy_ev_qfyrs_14b,
@@ -1735,7 +1735,7 @@ static const llc_conn_action_t llc_busy_actions_15a[] = {
 	[3] = NULL,
 };
 
-static struct llc_conn_state_trans llc_busy_state_trans_15a = {
+static const struct llc_conn_state_trans llc_busy_state_trans_15a = {
 	.ev	       = llc_conn_ev_rx_rr_cmd_pbit_set_0,
 	.next_state    = LLC_CONN_STATE_BUSY,
 	.ev_qualifiers = NONE,
@@ -1750,7 +1750,7 @@ static const llc_conn_action_t llc_busy_actions_15b[] = {
 	[3] = NULL,
 };
 
-static struct llc_conn_state_trans llc_busy_state_trans_15b = {
+static const struct llc_conn_state_trans llc_busy_state_trans_15b = {
 	.ev	       = llc_conn_ev_rx_rr_rsp_fbit_set_0,
 	.next_state    = LLC_CONN_STATE_BUSY,
 	.ev_qualifiers = NONE,
@@ -1770,7 +1770,7 @@ static const llc_conn_action_t llc_busy_actions_15c[] = {
 	[3] = NULL,
 };
 
-static struct llc_conn_state_trans llc_busy_state_trans_15c = {
+static const struct llc_conn_state_trans llc_busy_state_trans_15c = {
 	.ev	       = llc_conn_ev_rx_rr_rsp_fbit_set_1,
 	.next_state    = LLC_CONN_STATE_BUSY,
 	.ev_qualifiers = llc_busy_ev_qfyrs_15c,
@@ -1785,7 +1785,7 @@ static const llc_conn_action_t llc_busy_actions_16[] = {
 	[3] = NULL,
 };
 
-static struct llc_conn_state_trans llc_busy_state_trans_16 = {
+static const struct llc_conn_state_trans llc_busy_state_trans_16 = {
 	.ev	       = llc_conn_ev_rx_rr_cmd_pbit_set_1,
 	.next_state    = LLC_CONN_STATE_BUSY,
 	.ev_qualifiers = NONE,
@@ -1800,7 +1800,7 @@ static const llc_conn_action_t llc_busy_actions_17a[] = {
 	[3] = NULL,
 };
 
-static struct llc_conn_state_trans llc_busy_state_trans_17a = {
+static const struct llc_conn_state_trans llc_busy_state_trans_17a = {
 	.ev	       = llc_conn_ev_rx_rnr_cmd_pbit_set_0,
 	.next_state    = LLC_CONN_STATE_BUSY,
 	.ev_qualifiers = NONE,
@@ -1815,7 +1815,7 @@ static const llc_conn_action_t llc_busy_actions_17b[] = {
 	[3] = NULL,
 };
 
-static struct llc_conn_state_trans llc_busy_state_trans_17b = {
+static const struct llc_conn_state_trans llc_busy_state_trans_17b = {
 	.ev	       = llc_conn_ev_rx_rnr_rsp_fbit_set_0,
 	.next_state    = LLC_CONN_STATE_BUSY,
 	.ev_qualifiers = NONE,
@@ -1835,7 +1835,7 @@ static const llc_conn_action_t llc_busy_actions_17c[] = {
 	[3] = NULL,
 };
 
-static struct llc_conn_state_trans llc_busy_state_trans_17c = {
+static const struct llc_conn_state_trans llc_busy_state_trans_17c = {
 	.ev	       = llc_conn_ev_rx_rnr_rsp_fbit_set_1,
 	.next_state    = LLC_CONN_STATE_BUSY,
 	.ev_qualifiers = llc_busy_ev_qfyrs_17c,
@@ -1850,7 +1850,7 @@ static const llc_conn_action_t llc_busy_actions_18[] = {
 	[3] = NULL,
 };
 
-static struct llc_conn_state_trans llc_busy_state_trans_18 = {
+static const struct llc_conn_state_trans llc_busy_state_trans_18 = {
 	.ev	       = llc_conn_ev_rx_rnr_cmd_pbit_set_1,
 	.next_state    = LLC_CONN_STATE_BUSY,
 	.ev_qualifiers = NONE,
@@ -1872,7 +1872,7 @@ static const llc_conn_action_t llc_busy_actions_19a[] = {
 	[5] = NULL,
 };
 
-static struct llc_conn_state_trans llc_busy_state_trans_19a = {
+static const struct llc_conn_state_trans llc_busy_state_trans_19a = {
 	.ev	       = llc_conn_ev_rx_rej_cmd_pbit_set_0,
 	.next_state    = LLC_CONN_STATE_BUSY,
 	.ev_qualifiers = llc_busy_ev_qfyrs_19a,
@@ -1894,7 +1894,7 @@ static const llc_conn_action_t llc_busy_actions_19b[] = {
 	[5] = NULL,
 };
 
-static struct llc_conn_state_trans llc_busy_state_trans_19b = {
+static const struct llc_conn_state_trans llc_busy_state_trans_19b = {
 	.ev	       = llc_conn_ev_rx_rej_rsp_fbit_set_x,
 	.next_state    = LLC_CONN_STATE_BUSY,
 	.ev_qualifiers = llc_busy_ev_qfyrs_19b,
@@ -1915,7 +1915,7 @@ static const llc_conn_action_t llc_busy_actions_20a[] = {
 	[4] = NULL,
 };
 
-static struct llc_conn_state_trans llc_busy_state_trans_20a = {
+static const struct llc_conn_state_trans llc_busy_state_trans_20a = {
 	.ev	       = llc_conn_ev_rx_rej_cmd_pbit_set_0,
 	.next_state    = LLC_CONN_STATE_BUSY,
 	.ev_qualifiers = llc_busy_ev_qfyrs_20a,
@@ -1936,7 +1936,7 @@ static const llc_conn_action_t llc_busy_actions_20b[] = {
 	[4] = NULL,
 };
 
-static struct llc_conn_state_trans llc_busy_state_trans_20b = {
+static const struct llc_conn_state_trans llc_busy_state_trans_20b = {
 	.ev	       = llc_conn_ev_rx_rej_rsp_fbit_set_0,
 	.next_state    = LLC_CONN_STATE_BUSY,
 	.ev_qualifiers = llc_busy_ev_qfyrs_20b,
@@ -1953,7 +1953,7 @@ static const llc_conn_action_t llc_busy_actions_21[] = {
 	[5] = NULL,
 };
 
-static struct llc_conn_state_trans llc_busy_state_trans_21 = {
+static const struct llc_conn_state_trans llc_busy_state_trans_21 = {
 	.ev	       = llc_conn_ev_rx_rej_cmd_pbit_set_1,
 	.next_state    = LLC_CONN_STATE_BUSY,
 	.ev_qualifiers = NONE,
@@ -1972,7 +1972,7 @@ static const llc_conn_action_t llc_busy_actions_22[] = {
 	[2] = NULL,
 };
 
-static struct llc_conn_state_trans llc_busy_state_trans_22 = {
+static const struct llc_conn_state_trans llc_busy_state_trans_22 = {
 	.ev	       = llc_conn_ev_init_p_f_cycle,
 	.next_state    = LLC_CONN_STATE_BUSY,
 	.ev_qualifiers = llc_busy_ev_qfyrs_22,
@@ -1993,7 +1993,7 @@ static const llc_conn_action_t llc_busy_actions_23[] = {
 	[4] = NULL,
 };
 
-static struct llc_conn_state_trans llc_busy_state_trans_23 = {
+static const struct llc_conn_state_trans llc_busy_state_trans_23 = {
 	.ev	       = llc_conn_ev_p_tmr_exp,
 	.next_state    = LLC_CONN_STATE_AWAIT_BUSY,
 	.ev_qualifiers = llc_busy_ev_qfyrs_23,
@@ -2015,7 +2015,7 @@ static const llc_conn_action_t llc_busy_actions_24a[] = {
 	[4] = NULL,
 };
 
-static struct llc_conn_state_trans llc_busy_state_trans_24a = {
+static const struct llc_conn_state_trans llc_busy_state_trans_24a = {
 	.ev	       = llc_conn_ev_ack_tmr_exp,
 	.next_state    = LLC_CONN_STATE_AWAIT_BUSY,
 	.ev_qualifiers = llc_busy_ev_qfyrs_24a,
@@ -2037,7 +2037,7 @@ static const llc_conn_action_t llc_busy_actions_24b[] = {
 	[4] = NULL,
 };
 
-static struct llc_conn_state_trans llc_busy_state_trans_24b = {
+static const struct llc_conn_state_trans llc_busy_state_trans_24b = {
 	.ev	       = llc_conn_ev_busy_tmr_exp,
 	.next_state    = LLC_CONN_STATE_AWAIT_BUSY,
 	.ev_qualifiers = llc_busy_ev_qfyrs_24b,
@@ -2060,7 +2060,7 @@ static const llc_conn_action_t llc_busy_actions_25[] = {
 	[5] = NULL,
 };
 
-static struct llc_conn_state_trans llc_busy_state_trans_25 = {
+static const struct llc_conn_state_trans llc_busy_state_trans_25 = {
 	.ev	       = llc_conn_ev_rej_tmr_exp,
 	.next_state    = LLC_CONN_STATE_AWAIT_BUSY,
 	.ev_qualifiers = llc_busy_ev_qfyrs_25,
@@ -2079,7 +2079,7 @@ static const llc_conn_action_t llc_busy_actions_26[] = {
 	[1] = NULL,
 };
 
-static struct llc_conn_state_trans llc_busy_state_trans_26 = {
+static const struct llc_conn_state_trans llc_busy_state_trans_26 = {
 	.ev	       = llc_conn_ev_rej_tmr_exp,
 	.next_state    = LLC_CONN_STATE_BUSY,
 	.ev_qualifiers = llc_busy_ev_qfyrs_26,
@@ -2090,7 +2090,7 @@ static struct llc_conn_state_trans llc_busy_state_trans_26 = {
  * Array of pointers;
  * one to each transition
  */
-static struct llc_conn_state_trans *llc_busy_state_transitions[] = {
+static const struct llc_conn_state_trans *llc_busy_state_transitions[] = {
 	 [0] = &llc_common_state_trans_1,	/* Request */
 	 [1] = &llc_common_state_trans_2,
 	 [2] = &llc_busy_state_trans_1,
@@ -2166,7 +2166,7 @@ static const llc_conn_action_t llc_reject_actions_1[] = {
 	[1] = NULL,
 };
 
-static struct llc_conn_state_trans llc_reject_state_trans_1 = {
+static const struct llc_conn_state_trans llc_reject_state_trans_1 = {
 	.ev	       = llc_conn_ev_data_req,
 	.next_state    = LLC_CONN_STATE_REJ,
 	.ev_qualifiers = llc_reject_ev_qfyrs_1,
@@ -2185,7 +2185,7 @@ static const llc_conn_action_t llc_reject_actions_2[] = {
 	[1] = NULL,
 };
 
-static struct llc_conn_state_trans llc_reject_state_trans_2 = {
+static const struct llc_conn_state_trans llc_reject_state_trans_2 = {
 	.ev	       = llc_conn_ev_data_req,
 	.next_state    = LLC_CONN_STATE_REJ,
 	.ev_qualifiers = llc_reject_ev_qfyrs_2,
@@ -2202,7 +2202,7 @@ static const llc_conn_ev_qfyr_t llc_reject_ev_qfyrs_2_1[] = {
 /* just one member, NULL, .bss zeroes it */
 static const llc_conn_action_t llc_reject_actions_2_1[1];
 
-static struct llc_conn_state_trans llc_reject_state_trans_2_1 = {
+static const struct llc_conn_state_trans llc_reject_state_trans_2_1 = {
 	.ev	       = llc_conn_ev_data_req,
 	.next_state    = LLC_CONN_STATE_REJ,
 	.ev_qualifiers = llc_reject_ev_qfyrs_2_1,
@@ -2222,7 +2222,7 @@ static const llc_conn_action_t llc_reject_actions_3[] = {
 	[2] = NULL,
 };
 
-static struct llc_conn_state_trans llc_reject_state_trans_3 = {
+static const struct llc_conn_state_trans llc_reject_state_trans_3 = {
 	.ev	       = llc_conn_ev_local_busy_detected,
 	.next_state    = LLC_CONN_STATE_BUSY,
 	.ev_qualifiers = llc_reject_ev_qfyrs_3,
@@ -2241,7 +2241,7 @@ static const llc_conn_action_t llc_reject_actions_4[] = {
 	[2] = NULL,
 };
 
-static struct llc_conn_state_trans llc_reject_state_trans_4 = {
+static const struct llc_conn_state_trans llc_reject_state_trans_4 = {
 	.ev	       = llc_conn_ev_local_busy_detected,
 	.next_state    = LLC_CONN_STATE_BUSY,
 	.ev_qualifiers = llc_reject_ev_qfyrs_4,
@@ -2256,7 +2256,7 @@ static const llc_conn_action_t llc_reject_actions_5a[] = {
 	[3] = NULL,
 };
 
-static struct llc_conn_state_trans llc_reject_state_trans_5a = {
+static const struct llc_conn_state_trans llc_reject_state_trans_5a = {
 	.ev	       = llc_conn_ev_rx_i_cmd_pbit_set_0_unexpd_ns,
 	.next_state    = LLC_CONN_STATE_REJ,
 	.ev_qualifiers = NONE,
@@ -2271,7 +2271,7 @@ static const llc_conn_action_t llc_reject_actions_5b[] = {
 	[3] = NULL,
 };
 
-static struct llc_conn_state_trans llc_reject_state_trans_5b = {
+static const struct llc_conn_state_trans llc_reject_state_trans_5b = {
 	.ev	       = llc_conn_ev_rx_i_rsp_fbit_set_0_unexpd_ns,
 	.next_state    = LLC_CONN_STATE_REJ,
 	.ev_qualifiers = NONE,
@@ -2291,7 +2291,7 @@ static const llc_conn_action_t llc_reject_actions_5c[] = {
 	[3] = NULL,
 };
 
-static struct llc_conn_state_trans llc_reject_state_trans_5c = {
+static const struct llc_conn_state_trans llc_reject_state_trans_5c = {
 	.ev	       = llc_conn_ev_rx_i_rsp_fbit_set_1_unexpd_ns,
 	.next_state    = LLC_CONN_STATE_REJ,
 	.ev_qualifiers = llc_reject_ev_qfyrs_5c,
@@ -2305,7 +2305,7 @@ static const llc_conn_action_t llc_reject_actions_6[] = {
 	[2] = NULL,
 };
 
-static struct llc_conn_state_trans llc_reject_state_trans_6 = {
+static const struct llc_conn_state_trans llc_reject_state_trans_6 = {
 	.ev	       = llc_conn_ev_rx_i_cmd_pbit_set_1_unexpd_ns,
 	.next_state    = LLC_CONN_STATE_REJ,
 	.ev_qualifiers = NONE,
@@ -2330,7 +2330,7 @@ static const llc_conn_action_t llc_reject_actions_7a[] = {
 
 };
 
-static struct llc_conn_state_trans llc_reject_state_trans_7a = {
+static const struct llc_conn_state_trans llc_reject_state_trans_7a = {
 	.ev	       = llc_conn_ev_rx_i_rsp_fbit_set_x,
 	.next_state    = LLC_CONN_STATE_NORMAL,
 	.ev_qualifiers = llc_reject_ev_qfyrs_7a,
@@ -2354,7 +2354,7 @@ static const llc_conn_action_t llc_reject_actions_7b[] = {
 	[7] = NULL,
 };
 
-static struct llc_conn_state_trans llc_reject_state_trans_7b = {
+static const struct llc_conn_state_trans llc_reject_state_trans_7b = {
 	.ev	       = llc_conn_ev_rx_i_cmd_pbit_set_0,
 	.next_state    = LLC_CONN_STATE_NORMAL,
 	.ev_qualifiers = llc_reject_ev_qfyrs_7b,
@@ -2376,7 +2376,7 @@ static const llc_conn_action_t llc_reject_actions_8a[] = {
 	[5] = NULL,
 };
 
-static struct llc_conn_state_trans llc_reject_state_trans_8a = {
+static const struct llc_conn_state_trans llc_reject_state_trans_8a = {
 	.ev	       = llc_conn_ev_rx_i_rsp_fbit_set_0,
 	.next_state    = LLC_CONN_STATE_NORMAL,
 	.ev_qualifiers = llc_reject_ev_qfyrs_8a,
@@ -2398,7 +2398,7 @@ static const llc_conn_action_t llc_reject_actions_8b[] = {
 	[5] = NULL,
 };
 
-static struct llc_conn_state_trans llc_reject_state_trans_8b = {
+static const struct llc_conn_state_trans llc_reject_state_trans_8b = {
 	.ev	       = llc_conn_ev_rx_i_cmd_pbit_set_0,
 	.next_state    = LLC_CONN_STATE_NORMAL,
 	.ev_qualifiers = llc_reject_ev_qfyrs_8b,
@@ -2415,7 +2415,7 @@ static const llc_conn_action_t llc_reject_actions_9[] = {
 	[5] = NULL,
 };
 
-static struct llc_conn_state_trans llc_reject_state_trans_9 = {
+static const struct llc_conn_state_trans llc_reject_state_trans_9 = {
 	.ev	       = llc_conn_ev_rx_i_cmd_pbit_set_1,
 	.next_state    = LLC_CONN_STATE_NORMAL,
 	.ev_qualifiers = NONE,
@@ -2430,7 +2430,7 @@ static const llc_conn_action_t llc_reject_actions_10a[] = {
 	[3] = NULL,
 };
 
-static struct llc_conn_state_trans llc_reject_state_trans_10a = {
+static const struct llc_conn_state_trans llc_reject_state_trans_10a = {
 	.ev	       = llc_conn_ev_rx_rr_cmd_pbit_set_0,
 	.next_state    = LLC_CONN_STATE_REJ,
 	.ev_qualifiers = NONE,
@@ -2445,7 +2445,7 @@ static const llc_conn_action_t llc_reject_actions_10b[] = {
 	[3] = NULL,
 };
 
-static struct llc_conn_state_trans llc_reject_state_trans_10b = {
+static const struct llc_conn_state_trans llc_reject_state_trans_10b = {
 	.ev	       = llc_conn_ev_rx_rr_rsp_fbit_set_0,
 	.next_state    = LLC_CONN_STATE_REJ,
 	.ev_qualifiers = NONE,
@@ -2465,7 +2465,7 @@ static const llc_conn_action_t llc_reject_actions_10c[] = {
 	[3] = NULL,
 };
 
-static struct llc_conn_state_trans llc_reject_state_trans_10c = {
+static const struct llc_conn_state_trans llc_reject_state_trans_10c = {
 	.ev	       = llc_conn_ev_rx_rr_rsp_fbit_set_1,
 	.next_state    = LLC_CONN_STATE_REJ,
 	.ev_qualifiers = llc_reject_ev_qfyrs_10c,
@@ -2480,7 +2480,7 @@ static const llc_conn_action_t llc_reject_actions_11[] = {
 	[3] = NULL,
 };
 
-static struct llc_conn_state_trans llc_reject_state_trans_11 = {
+static const struct llc_conn_state_trans llc_reject_state_trans_11 = {
 	.ev	       = llc_conn_ev_rx_rr_cmd_pbit_set_1,
 	.next_state    = LLC_CONN_STATE_REJ,
 	.ev_qualifiers = NONE,
@@ -2495,7 +2495,7 @@ static const llc_conn_action_t llc_reject_actions_12a[] = {
 	[3] = NULL,
 };
 
-static struct llc_conn_state_trans llc_reject_state_trans_12a = {
+static const struct llc_conn_state_trans llc_reject_state_trans_12a = {
 	.ev	       = llc_conn_ev_rx_rnr_cmd_pbit_set_0,
 	.next_state    = LLC_CONN_STATE_REJ,
 	.ev_qualifiers = NONE,
@@ -2510,7 +2510,7 @@ static const llc_conn_action_t llc_reject_actions_12b[] = {
 	[3] = NULL,
 };
 
-static struct llc_conn_state_trans llc_reject_state_trans_12b = {
+static const struct llc_conn_state_trans llc_reject_state_trans_12b = {
 	.ev	       = llc_conn_ev_rx_rnr_rsp_fbit_set_0,
 	.next_state    = LLC_CONN_STATE_REJ,
 	.ev_qualifiers = NONE,
@@ -2530,7 +2530,7 @@ static const llc_conn_action_t llc_reject_actions_12c[] = {
 	[3] = NULL,
 };
 
-static struct llc_conn_state_trans llc_reject_state_trans_12c = {
+static const struct llc_conn_state_trans llc_reject_state_trans_12c = {
 	.ev	       = llc_conn_ev_rx_rnr_rsp_fbit_set_1,
 	.next_state    = LLC_CONN_STATE_REJ,
 	.ev_qualifiers = llc_reject_ev_qfyrs_12c,
@@ -2545,7 +2545,7 @@ static const llc_conn_action_t llc_reject_actions_13[] = {
 	[3] = NULL,
 };
 
-static struct llc_conn_state_trans llc_reject_state_trans_13 = {
+static const struct llc_conn_state_trans llc_reject_state_trans_13 = {
 	.ev	       = llc_conn_ev_rx_rnr_cmd_pbit_set_1,
 	.next_state    = LLC_CONN_STATE_REJ,
 	.ev_qualifiers = NONE,
@@ -2567,7 +2567,7 @@ static const llc_conn_action_t llc_reject_actions_14a[] = {
 	[5] = NULL,
 };
 
-static struct llc_conn_state_trans llc_reject_state_trans_14a = {
+static const struct llc_conn_state_trans llc_reject_state_trans_14a = {
 	.ev	       = llc_conn_ev_rx_rej_cmd_pbit_set_0,
 	.next_state    = LLC_CONN_STATE_REJ,
 	.ev_qualifiers = llc_reject_ev_qfyrs_14a,
@@ -2589,7 +2589,7 @@ static const llc_conn_action_t llc_reject_actions_14b[] = {
 	[5] = NULL,
 };
 
-static struct llc_conn_state_trans llc_reject_state_trans_14b = {
+static const struct llc_conn_state_trans llc_reject_state_trans_14b = {
 	.ev	       = llc_conn_ev_rx_rej_rsp_fbit_set_x,
 	.next_state    = LLC_CONN_STATE_REJ,
 	.ev_qualifiers = llc_reject_ev_qfyrs_14b,
@@ -2610,7 +2610,7 @@ static const llc_conn_action_t llc_reject_actions_15a[] = {
 	[4] = NULL,
 };
 
-static struct llc_conn_state_trans llc_reject_state_trans_15a = {
+static const struct llc_conn_state_trans llc_reject_state_trans_15a = {
 	.ev	       = llc_conn_ev_rx_rej_cmd_pbit_set_0,
 	.next_state    = LLC_CONN_STATE_REJ,
 	.ev_qualifiers = llc_reject_ev_qfyrs_15a,
@@ -2631,7 +2631,7 @@ static const llc_conn_action_t llc_reject_actions_15b[] = {
 	[4] = NULL,
 };
 
-static struct llc_conn_state_trans llc_reject_state_trans_15b = {
+static const struct llc_conn_state_trans llc_reject_state_trans_15b = {
 	.ev	       = llc_conn_ev_rx_rej_rsp_fbit_set_0,
 	.next_state    = LLC_CONN_STATE_REJ,
 	.ev_qualifiers = llc_reject_ev_qfyrs_15b,
@@ -2647,7 +2647,7 @@ static const llc_conn_action_t llc_reject_actions_16[] = {
 	[4] = NULL,
 };
 
-static struct llc_conn_state_trans llc_reject_state_trans_16 = {
+static const struct llc_conn_state_trans llc_reject_state_trans_16 = {
 	.ev	       = llc_conn_ev_rx_rej_cmd_pbit_set_1,
 	.next_state    = LLC_CONN_STATE_REJ,
 	.ev_qualifiers = NONE,
@@ -2666,7 +2666,7 @@ static const llc_conn_action_t llc_reject_actions_17[] = {
 	[2] = NULL,
 };
 
-static struct llc_conn_state_trans llc_reject_state_trans_17 = {
+static const struct llc_conn_state_trans llc_reject_state_trans_17 = {
 	.ev	       = llc_conn_ev_init_p_f_cycle,
 	.next_state    = LLC_CONN_STATE_REJ,
 	.ev_qualifiers = llc_reject_ev_qfyrs_17,
@@ -2688,7 +2688,7 @@ static const llc_conn_action_t llc_reject_actions_18[] = {
 	[4] = NULL,
 };
 
-static struct llc_conn_state_trans llc_reject_state_trans_18 = {
+static const struct llc_conn_state_trans llc_reject_state_trans_18 = {
 	.ev	       = llc_conn_ev_rej_tmr_exp,
 	.next_state    = LLC_CONN_STATE_REJ,
 	.ev_qualifiers = llc_reject_ev_qfyrs_18,
@@ -2710,7 +2710,7 @@ static const llc_conn_action_t llc_reject_actions_19[] = {
 	[5] = NULL,
 };
 
-static struct llc_conn_state_trans llc_reject_state_trans_19 = {
+static const struct llc_conn_state_trans llc_reject_state_trans_19 = {
 	.ev	       = llc_conn_ev_p_tmr_exp,
 	.next_state    = LLC_CONN_STATE_AWAIT_REJ,
 	.ev_qualifiers = llc_reject_ev_qfyrs_19,
@@ -2733,7 +2733,7 @@ static const llc_conn_action_t llc_reject_actions_20a[] = {
 	[5] = NULL,
 };
 
-static struct llc_conn_state_trans llc_reject_state_trans_20a = {
+static const struct llc_conn_state_trans llc_reject_state_trans_20a = {
 	.ev	       = llc_conn_ev_ack_tmr_exp,
 	.next_state    = LLC_CONN_STATE_AWAIT_REJ,
 	.ev_qualifiers = llc_reject_ev_qfyrs_20a,
@@ -2756,7 +2756,7 @@ static const llc_conn_action_t llc_reject_actions_20b[] = {
 	[5] = NULL,
 };
 
-static struct llc_conn_state_trans llc_reject_state_trans_20b = {
+static const struct llc_conn_state_trans llc_reject_state_trans_20b = {
 	.ev	       = llc_conn_ev_busy_tmr_exp,
 	.next_state    = LLC_CONN_STATE_AWAIT_REJ,
 	.ev_qualifiers = llc_reject_ev_qfyrs_20b,
@@ -2767,7 +2767,7 @@ static struct llc_conn_state_trans llc_reject_state_trans_20b = {
  * Array of pointers;
  * one to each transition
  */
-static struct llc_conn_state_trans *llc_reject_state_transitions[] = {
+static const struct llc_conn_state_trans *llc_reject_state_transitions[] = {
 	 [0] = &llc_common_state_trans_1,	/* Request */
 	 [1] = &llc_common_state_trans_2,
 	 [2] = &llc_common_state_trans_end,
@@ -2834,7 +2834,7 @@ static const llc_conn_ev_qfyr_t llc_await_ev_qfyrs_1_0[] = {
 /* just one member, NULL, .bss zeroes it */
 static const llc_conn_action_t llc_await_actions_1_0[1];
 
-static struct llc_conn_state_trans llc_await_state_trans_1_0 = {
+static const struct llc_conn_state_trans llc_await_state_trans_1_0 = {
 	.ev	       = llc_conn_ev_data_req,
 	.next_state    = LLC_CONN_STATE_AWAIT,
 	.ev_qualifiers = llc_await_ev_qfyrs_1_0,
@@ -2848,7 +2848,7 @@ static const llc_conn_action_t llc_await_actions_1[] = {
 	[2] = NULL,
 };
 
-static struct llc_conn_state_trans llc_await_state_trans_1 = {
+static const struct llc_conn_state_trans llc_await_state_trans_1 = {
 	.ev	       = llc_conn_ev_local_busy_detected,
 	.next_state    = LLC_CONN_STATE_AWAIT_BUSY,
 	.ev_qualifiers = NONE,
@@ -2867,7 +2867,7 @@ static const llc_conn_action_t llc_await_actions_2[] = {
 	[7] = NULL,
 };
 
-static struct llc_conn_state_trans llc_await_state_trans_2 = {
+static const struct llc_conn_state_trans llc_await_state_trans_2 = {
 	.ev	       = llc_conn_ev_rx_i_rsp_fbit_set_1_unexpd_ns,
 	.next_state    = LLC_CONN_STATE_REJ,
 	.ev_qualifiers = NONE,
@@ -2883,7 +2883,7 @@ static const llc_conn_action_t llc_await_actions_3a[] = {
 	[4] = NULL,
 };
 
-static struct llc_conn_state_trans llc_await_state_trans_3a = {
+static const struct llc_conn_state_trans llc_await_state_trans_3a = {
 	.ev	       = llc_conn_ev_rx_i_cmd_pbit_set_0_unexpd_ns,
 	.next_state    = LLC_CONN_STATE_AWAIT_REJ,
 	.ev_qualifiers = NONE,
@@ -2899,7 +2899,7 @@ static const llc_conn_action_t llc_await_actions_3b[] = {
 	[4] = NULL,
 };
 
-static struct llc_conn_state_trans llc_await_state_trans_3b = {
+static const struct llc_conn_state_trans llc_await_state_trans_3b = {
 	.ev	       = llc_conn_ev_rx_i_rsp_fbit_set_0_unexpd_ns,
 	.next_state    = LLC_CONN_STATE_AWAIT_REJ,
 	.ev_qualifiers = NONE,
@@ -2916,7 +2916,7 @@ static const llc_conn_action_t llc_await_actions_4[] = {
 	[5] = NULL,
 };
 
-static struct llc_conn_state_trans llc_await_state_trans_4 = {
+static const struct llc_conn_state_trans llc_await_state_trans_4 = {
 	.ev	       = llc_conn_ev_rx_i_cmd_pbit_set_1_unexpd_ns,
 	.next_state    = LLC_CONN_STATE_AWAIT_REJ,
 	.ev_qualifiers = NONE,
@@ -2935,7 +2935,7 @@ static const llc_conn_action_t llc_await_actions_5[] = {
 	[7] = NULL,
 };
 
-static struct llc_conn_state_trans llc_await_state_trans_5 = {
+static const struct llc_conn_state_trans llc_await_state_trans_5 = {
 	.ev	       = llc_conn_ev_rx_i_rsp_fbit_set_1,
 	.next_state    = LLC_CONN_STATE_NORMAL,
 	.ev_qualifiers = NONE,
@@ -2952,7 +2952,7 @@ static const llc_conn_action_t llc_await_actions_6a[] = {
 	[5] = NULL,
 };
 
-static struct llc_conn_state_trans llc_await_state_trans_6a = {
+static const struct llc_conn_state_trans llc_await_state_trans_6a = {
 	.ev	       = llc_conn_ev_rx_i_rsp_fbit_set_0,
 	.next_state    = LLC_CONN_STATE_AWAIT,
 	.ev_qualifiers = NONE,
@@ -2969,7 +2969,7 @@ static const llc_conn_action_t llc_await_actions_6b[] = {
 	[5] = NULL,
 };
 
-static struct llc_conn_state_trans llc_await_state_trans_6b = {
+static const struct llc_conn_state_trans llc_await_state_trans_6b = {
 	.ev	       = llc_conn_ev_rx_i_cmd_pbit_set_0,
 	.next_state    = LLC_CONN_STATE_AWAIT,
 	.ev_qualifiers = NONE,
@@ -2986,7 +2986,7 @@ static const llc_conn_action_t llc_await_actions_7[] = {
 	[5] = NULL,
 };
 
-static struct llc_conn_state_trans llc_await_state_trans_7 = {
+static const struct llc_conn_state_trans llc_await_state_trans_7 = {
 	.ev	       = llc_conn_ev_rx_i_cmd_pbit_set_1,
 	.next_state    = LLC_CONN_STATE_AWAIT,
 	.ev_qualifiers = NONE,
@@ -3003,7 +3003,7 @@ static const llc_conn_action_t llc_await_actions_8a[] = {
 	[5] = NULL,
 };
 
-static struct llc_conn_state_trans llc_await_state_trans_8a = {
+static const struct llc_conn_state_trans llc_await_state_trans_8a = {
 	.ev	       = llc_conn_ev_rx_rr_rsp_fbit_set_1,
 	.next_state    = LLC_CONN_STATE_NORMAL,
 	.ev_qualifiers = NONE,
@@ -3020,7 +3020,7 @@ static const llc_conn_action_t llc_await_actions_8b[] = {
 	[5] = NULL,
 };
 
-static struct llc_conn_state_trans llc_await_state_trans_8b = {
+static const struct llc_conn_state_trans llc_await_state_trans_8b = {
 	.ev	       = llc_conn_ev_rx_rej_rsp_fbit_set_1,
 	.next_state    = LLC_CONN_STATE_NORMAL,
 	.ev_qualifiers = NONE,
@@ -3035,7 +3035,7 @@ static const llc_conn_action_t llc_await_actions_9a[] = {
 	[3] = NULL,
 };
 
-static struct llc_conn_state_trans llc_await_state_trans_9a = {
+static const struct llc_conn_state_trans llc_await_state_trans_9a = {
 	.ev	       = llc_conn_ev_rx_rr_cmd_pbit_set_0,
 	.next_state    = LLC_CONN_STATE_AWAIT,
 	.ev_qualifiers = NONE,
@@ -3050,7 +3050,7 @@ static const llc_conn_action_t llc_await_actions_9b[] = {
 	[3] = NULL,
 };
 
-static struct llc_conn_state_trans llc_await_state_trans_9b = {
+static const struct llc_conn_state_trans llc_await_state_trans_9b = {
 	.ev	       = llc_conn_ev_rx_rr_rsp_fbit_set_0,
 	.next_state    = LLC_CONN_STATE_AWAIT,
 	.ev_qualifiers = NONE,
@@ -3065,7 +3065,7 @@ static const llc_conn_action_t llc_await_actions_9c[] = {
 	[3] = NULL,
 };
 
-static struct llc_conn_state_trans llc_await_state_trans_9c = {
+static const struct llc_conn_state_trans llc_await_state_trans_9c = {
 	.ev	       = llc_conn_ev_rx_rej_cmd_pbit_set_0,
 	.next_state    = LLC_CONN_STATE_AWAIT,
 	.ev_qualifiers = NONE,
@@ -3080,7 +3080,7 @@ static const llc_conn_action_t llc_await_actions_9d[] = {
 	[3] = NULL,
 };
 
-static struct llc_conn_state_trans llc_await_state_trans_9d = {
+static const struct llc_conn_state_trans llc_await_state_trans_9d = {
 	.ev	       = llc_conn_ev_rx_rej_rsp_fbit_set_0,
 	.next_state    = LLC_CONN_STATE_AWAIT,
 	.ev_qualifiers = NONE,
@@ -3096,7 +3096,7 @@ static const llc_conn_action_t llc_await_actions_10a[] = {
 	[4] = NULL,
 };
 
-static struct llc_conn_state_trans llc_await_state_trans_10a = {
+static const struct llc_conn_state_trans llc_await_state_trans_10a = {
 	.ev	       = llc_conn_ev_rx_rr_cmd_pbit_set_1,
 	.next_state    = LLC_CONN_STATE_AWAIT,
 	.ev_qualifiers = NONE,
@@ -3112,7 +3112,7 @@ static const llc_conn_action_t llc_await_actions_10b[] = {
 	[4] = NULL,
 };
 
-static struct llc_conn_state_trans llc_await_state_trans_10b = {
+static const struct llc_conn_state_trans llc_await_state_trans_10b = {
 	.ev	       = llc_conn_ev_rx_rej_cmd_pbit_set_1,
 	.next_state    = LLC_CONN_STATE_AWAIT,
 	.ev_qualifiers = NONE,
@@ -3128,7 +3128,7 @@ static const llc_conn_action_t llc_await_actions_11[] = {
 	[4] = NULL,
 };
 
-static struct llc_conn_state_trans llc_await_state_trans_11 = {
+static const struct llc_conn_state_trans llc_await_state_trans_11 = {
 	.ev	       = llc_conn_ev_rx_rnr_rsp_fbit_set_1,
 	.next_state    = LLC_CONN_STATE_NORMAL,
 	.ev_qualifiers = NONE,
@@ -3143,7 +3143,7 @@ static const llc_conn_action_t llc_await_actions_12a[] = {
 	[3] = NULL,
 };
 
-static struct llc_conn_state_trans llc_await_state_trans_12a = {
+static const struct llc_conn_state_trans llc_await_state_trans_12a = {
 	.ev	       = llc_conn_ev_rx_rnr_cmd_pbit_set_0,
 	.next_state    = LLC_CONN_STATE_AWAIT,
 	.ev_qualifiers = NONE,
@@ -3158,7 +3158,7 @@ static const llc_conn_action_t llc_await_actions_12b[] = {
 	[3] = NULL,
 };
 
-static struct llc_conn_state_trans llc_await_state_trans_12b = {
+static const struct llc_conn_state_trans llc_await_state_trans_12b = {
 	.ev	       = llc_conn_ev_rx_rnr_rsp_fbit_set_0,
 	.next_state    = LLC_CONN_STATE_AWAIT,
 	.ev_qualifiers = NONE,
@@ -3174,7 +3174,7 @@ static const llc_conn_action_t llc_await_actions_13[] = {
 	[4] = NULL,
 };
 
-static struct llc_conn_state_trans llc_await_state_trans_13 = {
+static const struct llc_conn_state_trans llc_await_state_trans_13 = {
 	.ev	       = llc_conn_ev_rx_rnr_cmd_pbit_set_1,
 	.next_state    = LLC_CONN_STATE_AWAIT,
 	.ev_qualifiers = NONE,
@@ -3194,7 +3194,7 @@ static const llc_conn_action_t llc_await_actions_14[] = {
 	[3] = NULL,
 };
 
-static struct llc_conn_state_trans llc_await_state_trans_14 = {
+static const struct llc_conn_state_trans llc_await_state_trans_14 = {
 	.ev	       = llc_conn_ev_p_tmr_exp,
 	.next_state    = LLC_CONN_STATE_AWAIT,
 	.ev_qualifiers = llc_await_ev_qfyrs_14,
@@ -3205,7 +3205,7 @@ static struct llc_conn_state_trans llc_await_state_trans_14 = {
  * Array of pointers;
  * one to each transition
  */
-static struct llc_conn_state_trans *llc_await_state_transitions[] = {
+static const struct llc_conn_state_trans *llc_await_state_transitions[] = {
 	 [0] = &llc_common_state_trans_1,	/* Request */
 	 [1] = &llc_common_state_trans_2,
 	 [2] = &llc_await_state_trans_1_0,
@@ -3263,7 +3263,7 @@ static const llc_conn_ev_qfyr_t llc_await_busy_ev_qfyrs_1_0[] = {
 /* just one member, NULL, .bss zeroes it */
 static const llc_conn_action_t llc_await_busy_actions_1_0[1];
 
-static struct llc_conn_state_trans llc_await_busy_state_trans_1_0 = {
+static const struct llc_conn_state_trans llc_await_busy_state_trans_1_0 = {
 	.ev	       = llc_conn_ev_data_req,
 	.next_state    = LLC_CONN_STATE_AWAIT_BUSY,
 	.ev_qualifiers = llc_await_busy_ev_qfyrs_1_0,
@@ -3282,7 +3282,7 @@ static const llc_conn_action_t llc_await_busy_actions_1[] = {
 	[2] = NULL,
 };
 
-static struct llc_conn_state_trans llc_await_busy_state_trans_1 = {
+static const struct llc_conn_state_trans llc_await_busy_state_trans_1 = {
 	.ev	       = llc_conn_ev_local_busy_cleared,
 	.next_state    = LLC_CONN_STATE_AWAIT_REJ,
 	.ev_qualifiers = llc_await_busy_ev_qfyrs_1,
@@ -3300,7 +3300,7 @@ static const llc_conn_action_t llc_await_busy_actions_2[] = {
 	[1] = NULL,
 };
 
-static struct llc_conn_state_trans llc_await_busy_state_trans_2 = {
+static const struct llc_conn_state_trans llc_await_busy_state_trans_2 = {
 	.ev	       = llc_conn_ev_local_busy_cleared,
 	.next_state    = LLC_CONN_STATE_AWAIT,
 	.ev_qualifiers = llc_await_busy_ev_qfyrs_2,
@@ -3318,7 +3318,7 @@ static const llc_conn_action_t llc_await_busy_actions_3[] = {
 	[1] = NULL,
 };
 
-static struct llc_conn_state_trans llc_await_busy_state_trans_3 = {
+static const struct llc_conn_state_trans llc_await_busy_state_trans_3 = {
 	.ev	       = llc_conn_ev_local_busy_cleared,
 	.next_state    = LLC_CONN_STATE_AWAIT_REJ,
 	.ev_qualifiers = llc_await_busy_ev_qfyrs_3,
@@ -3337,7 +3337,7 @@ static const llc_conn_action_t llc_await_busy_actions_4[] = {
 	[7] = NULL,
 };
 
-static struct llc_conn_state_trans llc_await_busy_state_trans_4 = {
+static const struct llc_conn_state_trans llc_await_busy_state_trans_4 = {
 	.ev	       = llc_conn_ev_rx_i_rsp_fbit_set_1_unexpd_ns,
 	.next_state    = LLC_CONN_STATE_BUSY,
 	.ev_qualifiers = NONE,
@@ -3353,7 +3353,7 @@ static const llc_conn_action_t llc_await_busy_actions_5a[] = {
 	[4] = NULL,
 };
 
-static struct llc_conn_state_trans llc_await_busy_state_trans_5a = {
+static const struct llc_conn_state_trans llc_await_busy_state_trans_5a = {
 	.ev	       = llc_conn_ev_rx_i_cmd_pbit_set_0_unexpd_ns,
 	.next_state    = LLC_CONN_STATE_AWAIT_BUSY,
 	.ev_qualifiers = NONE,
@@ -3369,7 +3369,7 @@ static const llc_conn_action_t llc_await_busy_actions_5b[] = {
 	[4] = NULL,
 };
 
-static struct llc_conn_state_trans llc_await_busy_state_trans_5b = {
+static const struct llc_conn_state_trans llc_await_busy_state_trans_5b = {
 	.ev	       = llc_conn_ev_rx_i_rsp_fbit_set_0_unexpd_ns,
 	.next_state    = LLC_CONN_STATE_AWAIT_BUSY,
 	.ev_qualifiers = NONE,
@@ -3385,7 +3385,7 @@ static const llc_conn_action_t llc_await_busy_actions_6[] = {
 	[4] = NULL,
 };
 
-static struct llc_conn_state_trans llc_await_busy_state_trans_6 = {
+static const struct llc_conn_state_trans llc_await_busy_state_trans_6 = {
 	.ev	       = llc_conn_ev_rx_i_cmd_pbit_set_1_unexpd_ns,
 	.next_state    = LLC_CONN_STATE_AWAIT_BUSY,
 	.ev_qualifiers = NONE,
@@ -3406,7 +3406,7 @@ static const llc_conn_action_t llc_await_busy_actions_7[] = {
 	[9] = NULL,
 };
 
-static struct llc_conn_state_trans llc_await_busy_state_trans_7 = {
+static const struct llc_conn_state_trans llc_await_busy_state_trans_7 = {
 	.ev	       = llc_conn_ev_rx_i_rsp_fbit_set_1,
 	.next_state    = LLC_CONN_STATE_BUSY,
 	.ev_qualifiers = NONE,
@@ -3424,7 +3424,7 @@ static const llc_conn_action_t llc_await_busy_actions_8a[] = {
 	[6] = NULL,
 };
 
-static struct llc_conn_state_trans llc_await_busy_state_trans_8a = {
+static const struct llc_conn_state_trans llc_await_busy_state_trans_8a = {
 	.ev	       = llc_conn_ev_rx_i_rsp_fbit_set_0,
 	.next_state    = LLC_CONN_STATE_AWAIT_BUSY,
 	.ev_qualifiers = NONE,
@@ -3442,7 +3442,7 @@ static const llc_conn_action_t llc_await_busy_actions_8b[] = {
 	[6] = NULL,
 };
 
-static struct llc_conn_state_trans llc_await_busy_state_trans_8b = {
+static const struct llc_conn_state_trans llc_await_busy_state_trans_8b = {
 	.ev	       = llc_conn_ev_rx_i_cmd_pbit_set_0,
 	.next_state    = LLC_CONN_STATE_AWAIT_BUSY,
 	.ev_qualifiers = NONE,
@@ -3460,7 +3460,7 @@ static const llc_conn_action_t llc_await_busy_actions_9[] = {
 	[6] = NULL,
 };
 
-static struct llc_conn_state_trans llc_await_busy_state_trans_9 = {
+static const struct llc_conn_state_trans llc_await_busy_state_trans_9 = {
 	.ev	       = llc_conn_ev_rx_i_cmd_pbit_set_1,
 	.next_state    = LLC_CONN_STATE_AWAIT_BUSY,
 	.ev_qualifiers = NONE,
@@ -3477,7 +3477,7 @@ static const llc_conn_action_t llc_await_busy_actions_10a[] = {
 	[5] = NULL,
 };
 
-static struct llc_conn_state_trans llc_await_busy_state_trans_10a = {
+static const struct llc_conn_state_trans llc_await_busy_state_trans_10a = {
 	.ev	       = llc_conn_ev_rx_rr_rsp_fbit_set_1,
 	.next_state    = LLC_CONN_STATE_BUSY,
 	.ev_qualifiers = NONE,
@@ -3494,7 +3494,7 @@ static const llc_conn_action_t llc_await_busy_actions_10b[] = {
 	[5] = NULL,
 };
 
-static struct llc_conn_state_trans llc_await_busy_state_trans_10b = {
+static const struct llc_conn_state_trans llc_await_busy_state_trans_10b = {
 	.ev	       = llc_conn_ev_rx_rej_rsp_fbit_set_1,
 	.next_state    = LLC_CONN_STATE_BUSY,
 	.ev_qualifiers = NONE,
@@ -3509,7 +3509,7 @@ static const llc_conn_action_t llc_await_busy_actions_11a[] = {
 	[3] = NULL,
 };
 
-static struct llc_conn_state_trans llc_await_busy_state_trans_11a = {
+static const struct llc_conn_state_trans llc_await_busy_state_trans_11a = {
 	.ev	       = llc_conn_ev_rx_rr_cmd_pbit_set_0,
 	.next_state    = LLC_CONN_STATE_AWAIT_BUSY,
 	.ev_qualifiers = NONE,
@@ -3524,7 +3524,7 @@ static const llc_conn_action_t llc_await_busy_actions_11b[] = {
 	[3] = NULL,
 };
 
-static struct llc_conn_state_trans llc_await_busy_state_trans_11b = {
+static const struct llc_conn_state_trans llc_await_busy_state_trans_11b = {
 	.ev	       = llc_conn_ev_rx_rr_rsp_fbit_set_0,
 	.next_state    = LLC_CONN_STATE_AWAIT_BUSY,
 	.ev_qualifiers = NONE,
@@ -3539,7 +3539,7 @@ static const llc_conn_action_t llc_await_busy_actions_11c[] = {
 	[3] = NULL,
 };
 
-static struct llc_conn_state_trans llc_await_busy_state_trans_11c = {
+static const struct llc_conn_state_trans llc_await_busy_state_trans_11c = {
 	.ev	       = llc_conn_ev_rx_rej_cmd_pbit_set_0,
 	.next_state    = LLC_CONN_STATE_AWAIT_BUSY,
 	.ev_qualifiers = NONE,
@@ -3554,7 +3554,7 @@ static const llc_conn_action_t llc_await_busy_actions_11d[] = {
 	[3] = NULL,
 };
 
-static struct llc_conn_state_trans llc_await_busy_state_trans_11d = {
+static const struct llc_conn_state_trans llc_await_busy_state_trans_11d = {
 	.ev	       = llc_conn_ev_rx_rej_rsp_fbit_set_0,
 	.next_state    = LLC_CONN_STATE_AWAIT_BUSY,
 	.ev_qualifiers = NONE,
@@ -3570,7 +3570,7 @@ static const llc_conn_action_t llc_await_busy_actions_12a[] = {
 	[4] = NULL,
 };
 
-static struct llc_conn_state_trans llc_await_busy_state_trans_12a = {
+static const struct llc_conn_state_trans llc_await_busy_state_trans_12a = {
 	.ev	       = llc_conn_ev_rx_rr_cmd_pbit_set_1,
 	.next_state    = LLC_CONN_STATE_AWAIT_BUSY,
 	.ev_qualifiers = NONE,
@@ -3586,7 +3586,7 @@ static const llc_conn_action_t llc_await_busy_actions_12b[] = {
 	[4] = NULL,
 };
 
-static struct llc_conn_state_trans llc_await_busy_state_trans_12b = {
+static const struct llc_conn_state_trans llc_await_busy_state_trans_12b = {
 	.ev	       = llc_conn_ev_rx_rej_cmd_pbit_set_1,
 	.next_state    = LLC_CONN_STATE_AWAIT_BUSY,
 	.ev_qualifiers = NONE,
@@ -3602,7 +3602,7 @@ static const llc_conn_action_t llc_await_busy_actions_13[] = {
 	[4] = NULL,
 };
 
-static struct llc_conn_state_trans llc_await_busy_state_trans_13 = {
+static const struct llc_conn_state_trans llc_await_busy_state_trans_13 = {
 	.ev	       = llc_conn_ev_rx_rnr_rsp_fbit_set_1,
 	.next_state    = LLC_CONN_STATE_BUSY,
 	.ev_qualifiers = NONE,
@@ -3617,7 +3617,7 @@ static const llc_conn_action_t llc_await_busy_actions_14a[] = {
 	[3] = NULL,
 };
 
-static struct llc_conn_state_trans llc_await_busy_state_trans_14a = {
+static const struct llc_conn_state_trans llc_await_busy_state_trans_14a = {
 	.ev	       = llc_conn_ev_rx_rnr_cmd_pbit_set_0,
 	.next_state    = LLC_CONN_STATE_AWAIT_BUSY,
 	.ev_qualifiers = NONE,
@@ -3632,7 +3632,7 @@ static const llc_conn_action_t llc_await_busy_actions_14b[] = {
 	[3] = NULL,
 };
 
-static struct llc_conn_state_trans llc_await_busy_state_trans_14b = {
+static const struct llc_conn_state_trans llc_await_busy_state_trans_14b = {
 	.ev	       = llc_conn_ev_rx_rnr_rsp_fbit_set_0,
 	.next_state    = LLC_CONN_STATE_AWAIT_BUSY,
 	.ev_qualifiers = NONE,
@@ -3648,7 +3648,7 @@ static const llc_conn_action_t llc_await_busy_actions_15[] = {
 	[4] = NULL,
 };
 
-static struct llc_conn_state_trans llc_await_busy_state_trans_15 = {
+static const struct llc_conn_state_trans llc_await_busy_state_trans_15 = {
 	.ev	       = llc_conn_ev_rx_rnr_cmd_pbit_set_1,
 	.next_state    = LLC_CONN_STATE_AWAIT_BUSY,
 	.ev_qualifiers = NONE,
@@ -3668,7 +3668,7 @@ static const llc_conn_action_t llc_await_busy_actions_16[] = {
 	[3] = NULL,
 };
 
-static struct llc_conn_state_trans llc_await_busy_state_trans_16 = {
+static const struct llc_conn_state_trans llc_await_busy_state_trans_16 = {
 	.ev	       = llc_conn_ev_p_tmr_exp,
 	.next_state    = LLC_CONN_STATE_AWAIT_BUSY,
 	.ev_qualifiers = llc_await_busy_ev_qfyrs_16,
@@ -3679,7 +3679,7 @@ static struct llc_conn_state_trans llc_await_busy_state_trans_16 = {
  * Array of pointers;
  * one to each transition
  */
-static struct llc_conn_state_trans *llc_await_busy_state_transitions[] = {
+static const struct llc_conn_state_trans *llc_await_busy_state_transitions[] = {
 	 [0] = &llc_common_state_trans_1,		/* Request */
 	 [1] = &llc_common_state_trans_2,
 	 [2] = &llc_await_busy_state_trans_1_0,
@@ -3739,7 +3739,7 @@ static const llc_conn_ev_qfyr_t llc_await_reject_ev_qfyrs_1_0[] = {
 /* just one member, NULL, .bss zeroes it */
 static const llc_conn_action_t llc_await_reject_actions_1_0[1];
 
-static struct llc_conn_state_trans llc_await_reject_state_trans_1_0 = {
+static const struct llc_conn_state_trans llc_await_reject_state_trans_1_0 = {
 	.ev	       = llc_conn_ev_data_req,
 	.next_state    = LLC_CONN_STATE_AWAIT_REJ,
 	.ev_qualifiers = llc_await_reject_ev_qfyrs_1_0,
@@ -3753,7 +3753,7 @@ static const llc_conn_action_t llc_await_rejct_actions_1[] = {
 	[2] = NULL
 };
 
-static struct llc_conn_state_trans llc_await_rejct_state_trans_1 = {
+static const struct llc_conn_state_trans llc_await_rejct_state_trans_1 = {
 	.ev	       = llc_conn_ev_local_busy_detected,
 	.next_state    = LLC_CONN_STATE_AWAIT_BUSY,
 	.ev_qualifiers = NONE,
@@ -3767,7 +3767,7 @@ static const llc_conn_action_t llc_await_rejct_actions_2a[] = {
 	[2] = NULL
 };
 
-static struct llc_conn_state_trans llc_await_rejct_state_trans_2a = {
+static const struct llc_conn_state_trans llc_await_rejct_state_trans_2a = {
 	.ev	       = llc_conn_ev_rx_i_cmd_pbit_set_0_unexpd_ns,
 	.next_state    = LLC_CONN_STATE_AWAIT_REJ,
 	.ev_qualifiers = NONE,
@@ -3781,7 +3781,7 @@ static const llc_conn_action_t llc_await_rejct_actions_2b[] = {
 	[2] = NULL
 };
 
-static struct llc_conn_state_trans llc_await_rejct_state_trans_2b = {
+static const struct llc_conn_state_trans llc_await_rejct_state_trans_2b = {
 	.ev	       = llc_conn_ev_rx_i_rsp_fbit_set_0_unexpd_ns,
 	.next_state    = LLC_CONN_STATE_AWAIT_REJ,
 	.ev_qualifiers = NONE,
@@ -3796,7 +3796,7 @@ static const llc_conn_action_t llc_await_rejct_actions_3[] = {
 	[3] = NULL
 };
 
-static struct llc_conn_state_trans llc_await_rejct_state_trans_3 = {
+static const struct llc_conn_state_trans llc_await_rejct_state_trans_3 = {
 	.ev	       = llc_conn_ev_rx_i_cmd_pbit_set_1_unexpd_ns,
 	.next_state    = LLC_CONN_STATE_AWAIT_REJ,
 	.ev_qualifiers = NONE,
@@ -3816,7 +3816,7 @@ static const llc_conn_action_t llc_await_rejct_actions_4[] = {
 	[8] = NULL,
 };
 
-static struct llc_conn_state_trans llc_await_rejct_state_trans_4 = {
+static const struct llc_conn_state_trans llc_await_rejct_state_trans_4 = {
 	.ev	       = llc_conn_ev_rx_i_rsp_fbit_set_1,
 	.next_state    = LLC_CONN_STATE_NORMAL,
 	.ev_qualifiers = NONE,
@@ -3834,7 +3834,7 @@ static const llc_conn_action_t llc_await_rejct_actions_5a[] = {
 	[6] = NULL,
 };
 
-static struct llc_conn_state_trans llc_await_rejct_state_trans_5a = {
+static const struct llc_conn_state_trans llc_await_rejct_state_trans_5a = {
 	.ev	       = llc_conn_ev_rx_i_rsp_fbit_set_0,
 	.next_state    = LLC_CONN_STATE_AWAIT,
 	.ev_qualifiers = NONE,
@@ -3852,7 +3852,7 @@ static const llc_conn_action_t llc_await_rejct_actions_5b[] = {
 	[6] = NULL,
 };
 
-static struct llc_conn_state_trans llc_await_rejct_state_trans_5b = {
+static const struct llc_conn_state_trans llc_await_rejct_state_trans_5b = {
 	.ev	       = llc_conn_ev_rx_i_cmd_pbit_set_0,
 	.next_state    = LLC_CONN_STATE_AWAIT,
 	.ev_qualifiers = NONE,
@@ -3870,7 +3870,7 @@ static const llc_conn_action_t llc_await_rejct_actions_6[] = {
 	[6] = NULL,
 };
 
-static struct llc_conn_state_trans llc_await_rejct_state_trans_6 = {
+static const struct llc_conn_state_trans llc_await_rejct_state_trans_6 = {
 	.ev	       = llc_conn_ev_rx_i_cmd_pbit_set_1,
 	.next_state    = LLC_CONN_STATE_AWAIT,
 	.ev_qualifiers = NONE,
@@ -3887,7 +3887,7 @@ static const llc_conn_action_t llc_await_rejct_actions_7a[] = {
 	[5] = NULL,
 };
 
-static struct llc_conn_state_trans llc_await_rejct_state_trans_7a = {
+static const struct llc_conn_state_trans llc_await_rejct_state_trans_7a = {
 	.ev	       = llc_conn_ev_rx_rr_rsp_fbit_set_1,
 	.next_state    = LLC_CONN_STATE_REJ,
 	.ev_qualifiers = NONE,
@@ -3904,7 +3904,7 @@ static const llc_conn_action_t llc_await_rejct_actions_7b[] = {
 	[5] = NULL,
 };
 
-static struct llc_conn_state_trans llc_await_rejct_state_trans_7b = {
+static const struct llc_conn_state_trans llc_await_rejct_state_trans_7b = {
 	.ev	       = llc_conn_ev_rx_rej_rsp_fbit_set_1,
 	.next_state    = LLC_CONN_STATE_REJ,
 	.ev_qualifiers = NONE,
@@ -3921,7 +3921,7 @@ static const llc_conn_action_t llc_await_rejct_actions_7c[] = {
 	[5] = NULL,
 };
 
-static struct llc_conn_state_trans llc_await_rejct_state_trans_7c = {
+static const struct llc_conn_state_trans llc_await_rejct_state_trans_7c = {
 	.ev	       = llc_conn_ev_rx_i_rsp_fbit_set_1_unexpd_ns,
 	.next_state    = LLC_CONN_STATE_REJ,
 	.ev_qualifiers = NONE,
@@ -3936,7 +3936,7 @@ static const llc_conn_action_t llc_await_rejct_actions_8a[] = {
 	[3] = NULL,
 };
 
-static struct llc_conn_state_trans llc_await_rejct_state_trans_8a = {
+static const struct llc_conn_state_trans llc_await_rejct_state_trans_8a = {
 	.ev	       = llc_conn_ev_rx_rr_cmd_pbit_set_0,
 	.next_state    = LLC_CONN_STATE_AWAIT_REJ,
 	.ev_qualifiers = NONE,
@@ -3951,7 +3951,7 @@ static const llc_conn_action_t llc_await_rejct_actions_8b[] = {
 	[3] = NULL,
 };
 
-static struct llc_conn_state_trans llc_await_rejct_state_trans_8b = {
+static const struct llc_conn_state_trans llc_await_rejct_state_trans_8b = {
 	.ev	       = llc_conn_ev_rx_rr_rsp_fbit_set_0,
 	.next_state    = LLC_CONN_STATE_AWAIT_REJ,
 	.ev_qualifiers = NONE,
@@ -3966,7 +3966,7 @@ static const llc_conn_action_t llc_await_rejct_actions_8c[] = {
 	[3] = NULL,
 };
 
-static struct llc_conn_state_trans llc_await_rejct_state_trans_8c = {
+static const struct llc_conn_state_trans llc_await_rejct_state_trans_8c = {
 	.ev	       = llc_conn_ev_rx_rej_cmd_pbit_set_0,
 	.next_state    = LLC_CONN_STATE_AWAIT_REJ,
 	.ev_qualifiers = NONE,
@@ -3981,7 +3981,7 @@ static const llc_conn_action_t llc_await_rejct_actions_8d[] = {
 	[3] = NULL,
 };
 
-static struct llc_conn_state_trans llc_await_rejct_state_trans_8d = {
+static const struct llc_conn_state_trans llc_await_rejct_state_trans_8d = {
 	.ev	       = llc_conn_ev_rx_rej_rsp_fbit_set_0,
 	.next_state    = LLC_CONN_STATE_AWAIT_REJ,
 	.ev_qualifiers = NONE,
@@ -3997,7 +3997,7 @@ static const llc_conn_action_t llc_await_rejct_actions_9a[] = {
 	[4] = NULL,
 };
 
-static struct llc_conn_state_trans llc_await_rejct_state_trans_9a = {
+static const struct llc_conn_state_trans llc_await_rejct_state_trans_9a = {
 	.ev	       = llc_conn_ev_rx_rr_cmd_pbit_set_1,
 	.next_state    = LLC_CONN_STATE_AWAIT_REJ,
 	.ev_qualifiers = NONE,
@@ -4013,7 +4013,7 @@ static const llc_conn_action_t llc_await_rejct_actions_9b[] = {
 	[4] = NULL,
 };
 
-static struct llc_conn_state_trans llc_await_rejct_state_trans_9b = {
+static const struct llc_conn_state_trans llc_await_rejct_state_trans_9b = {
 	.ev	       = llc_conn_ev_rx_rej_cmd_pbit_set_1,
 	.next_state    = LLC_CONN_STATE_AWAIT_REJ,
 	.ev_qualifiers = NONE,
@@ -4029,7 +4029,7 @@ static const llc_conn_action_t llc_await_rejct_actions_10[] = {
 	[4] = NULL,
 };
 
-static struct llc_conn_state_trans llc_await_rejct_state_trans_10 = {
+static const struct llc_conn_state_trans llc_await_rejct_state_trans_10 = {
 	.ev	       = llc_conn_ev_rx_rnr_rsp_fbit_set_1,
 	.next_state    = LLC_CONN_STATE_REJ,
 	.ev_qualifiers = NONE,
@@ -4044,7 +4044,7 @@ static const llc_conn_action_t llc_await_rejct_actions_11a[] = {
 	[3] = NULL,
 };
 
-static struct llc_conn_state_trans llc_await_rejct_state_trans_11a = {
+static const struct llc_conn_state_trans llc_await_rejct_state_trans_11a = {
 	.ev	       = llc_conn_ev_rx_rnr_cmd_pbit_set_0,
 	.next_state    = LLC_CONN_STATE_AWAIT_REJ,
 	.ev_qualifiers = NONE,
@@ -4059,7 +4059,7 @@ static const llc_conn_action_t llc_await_rejct_actions_11b[] = {
 	[3] = NULL,
 };
 
-static struct llc_conn_state_trans llc_await_rejct_state_trans_11b = {
+static const struct llc_conn_state_trans llc_await_rejct_state_trans_11b = {
 	.ev	       = llc_conn_ev_rx_rnr_rsp_fbit_set_0,
 	.next_state    = LLC_CONN_STATE_AWAIT_REJ,
 	.ev_qualifiers = NONE,
@@ -4075,7 +4075,7 @@ static const llc_conn_action_t llc_await_rejct_actions_12[] = {
 	[4] = NULL,
 };
 
-static struct llc_conn_state_trans llc_await_rejct_state_trans_12 = {
+static const struct llc_conn_state_trans llc_await_rejct_state_trans_12 = {
 	.ev	       = llc_conn_ev_rx_rnr_cmd_pbit_set_1,
 	.next_state    = LLC_CONN_STATE_AWAIT_REJ,
 	.ev_qualifiers = NONE,
@@ -4095,7 +4095,7 @@ static const llc_conn_action_t llc_await_rejct_actions_13[] = {
 	[3] = NULL,
 };
 
-static struct llc_conn_state_trans llc_await_rejct_state_trans_13 = {
+static const struct llc_conn_state_trans llc_await_rejct_state_trans_13 = {
 	.ev	       = llc_conn_ev_p_tmr_exp,
 	.next_state    = LLC_CONN_STATE_AWAIT_REJ,
 	.ev_qualifiers = llc_await_rejct_ev_qfyrs_13,
@@ -4106,7 +4106,7 @@ static struct llc_conn_state_trans llc_await_rejct_state_trans_13 = {
  * Array of pointers;
  * one to each transition
  */
-static struct llc_conn_state_trans *llc_await_rejct_state_transitions[] = {
+static const struct llc_conn_state_trans *llc_await_rejct_state_transitions[] = {
 	 [0] = &llc_await_reject_state_trans_1_0,
 	 [1] = &llc_common_state_trans_1,		/* requests */
 	 [2] = &llc_common_state_trans_2,
@@ -4171,7 +4171,7 @@ static const llc_conn_action_t llc_d_conn_actions_1[] = {
 	[4] = NULL,
 };
 
-static struct llc_conn_state_trans llc_d_conn_state_trans_1 = {
+static const struct llc_conn_state_trans llc_d_conn_state_trans_1 = {
 	.ev	       = llc_conn_ev_rx_sabme_cmd_pbit_set_x,
 	.next_state    = LLC_CONN_STATE_ADM,
 	.ev_qualifiers = llc_d_conn_ev_qfyrs_1,
@@ -4194,7 +4194,7 @@ static const llc_conn_action_t llc_d_conn_actions_1_1[] = {
 	[3] = NULL,
 };
 
-static struct llc_conn_state_trans llc_d_conn_state_trans_1_1 = {
+static const struct llc_conn_state_trans llc_d_conn_state_trans_1_1 = {
 	.ev	       = llc_conn_ev_rx_sabme_cmd_pbit_set_x,
 	.next_state    = LLC_CONN_STATE_ADM,
 	.ev_qualifiers = llc_d_conn_ev_qfyrs_1_1,
@@ -4218,7 +4218,7 @@ static const llc_conn_action_t llc_d_conn_actions_2[] = {
 	[3] = NULL,
 };
 
-static struct llc_conn_state_trans llc_d_conn_state_trans_2 = {
+static const struct llc_conn_state_trans llc_d_conn_state_trans_2 = {
 	.ev	       = llc_conn_ev_rx_ua_rsp_fbit_set_x,
 	.next_state    = LLC_CONN_STATE_ADM,
 	.ev_qualifiers = llc_d_conn_ev_qfyrs_2,
@@ -4241,7 +4241,7 @@ static const llc_conn_action_t llc_d_conn_actions_2_1[] = {
 	[2] = NULL,
 };
 
-static struct llc_conn_state_trans llc_d_conn_state_trans_2_1 = {
+static const struct llc_conn_state_trans llc_d_conn_state_trans_2_1 = {
 	.ev	       = llc_conn_ev_rx_ua_rsp_fbit_set_x,
 	.next_state    = LLC_CONN_STATE_ADM,
 	.ev_qualifiers = llc_d_conn_ev_qfyrs_2_1,
@@ -4254,7 +4254,7 @@ static const llc_conn_action_t llc_d_conn_actions_3[] = {
 	[1] = NULL,
 };
 
-static struct llc_conn_state_trans llc_d_conn_state_trans_3 = {
+static const struct llc_conn_state_trans llc_d_conn_state_trans_3 = {
 	.ev	       = llc_conn_ev_rx_disc_cmd_pbit_set_x,
 	.next_state    = LLC_CONN_STATE_D_CONN,
 	.ev_qualifiers = NONE,
@@ -4277,7 +4277,7 @@ static const llc_conn_action_t llc_d_conn_actions_4[] = {
 	[3] = NULL,
 };
 
-static struct llc_conn_state_trans llc_d_conn_state_trans_4 = {
+static const struct llc_conn_state_trans llc_d_conn_state_trans_4 = {
 	.ev	       = llc_conn_ev_rx_dm_rsp_fbit_set_x,
 	.next_state    = LLC_CONN_STATE_ADM,
 	.ev_qualifiers = llc_d_conn_ev_qfyrs_4,
@@ -4299,7 +4299,7 @@ static const llc_conn_action_t llc_d_conn_actions_4_1[] = {
 	[2] = NULL,
 };
 
-static struct llc_conn_state_trans llc_d_conn_state_trans_4_1 = {
+static const struct llc_conn_state_trans llc_d_conn_state_trans_4_1 = {
 	.ev	       = llc_conn_ev_rx_dm_rsp_fbit_set_x,
 	.next_state    = LLC_CONN_STATE_ADM,
 	.ev_qualifiers = llc_d_conn_ev_qfyrs_4_1,
@@ -4318,7 +4318,7 @@ static const llc_conn_ev_qfyr_t llc_d_conn_ev_qfyrs_5[] = {
 /* just one member, NULL, .bss zeroes it */
 static const llc_conn_action_t llc_d_conn_actions_5[1];
 
-static struct llc_conn_state_trans llc_d_conn_state_trans_5 = {
+static const struct llc_conn_state_trans llc_d_conn_state_trans_5 = {
 	.ev	       = llc_conn_ev_data_req,
 	.next_state    = LLC_CONN_STATE_D_CONN,
 	.ev_qualifiers = llc_d_conn_ev_qfyrs_5,
@@ -4338,7 +4338,7 @@ static const llc_conn_action_t llc_d_conn_actions_6[] = {
 	[3] = NULL,
 };
 
-static struct llc_conn_state_trans llc_d_conn_state_trans_6 = {
+static const struct llc_conn_state_trans llc_d_conn_state_trans_6 = {
 	.ev	       = llc_conn_ev_ack_tmr_exp,
 	.next_state    = LLC_CONN_STATE_D_CONN,
 	.ev_qualifiers = llc_d_conn_ev_qfyrs_6,
@@ -4359,7 +4359,7 @@ static const llc_conn_action_t llc_d_conn_actions_7[] = {
 	[2] = NULL,
 };
 
-static struct llc_conn_state_trans llc_d_conn_state_trans_7 = {
+static const struct llc_conn_state_trans llc_d_conn_state_trans_7 = {
 	.ev	       = llc_conn_ev_ack_tmr_exp,
 	.next_state    = LLC_CONN_STATE_ADM,
 	.ev_qualifiers = llc_d_conn_ev_qfyrs_7,
@@ -4379,7 +4379,7 @@ static const llc_conn_action_t llc_d_conn_actions_8[] = {
 	[1] = NULL,
 };
 
-static struct llc_conn_state_trans llc_d_conn_state_trans_8 = {
+static const struct llc_conn_state_trans llc_d_conn_state_trans_8 = {
 	.ev	       = llc_conn_ev_ack_tmr_exp,
 	.next_state    = LLC_CONN_STATE_ADM,
 	.ev_qualifiers = llc_d_conn_ev_qfyrs_8,
@@ -4390,7 +4390,7 @@ static struct llc_conn_state_trans llc_d_conn_state_trans_8 = {
  * Array of pointers;
  * one to each transition
  */
-static struct llc_conn_state_trans *llc_d_conn_state_transitions[] = {
+static const struct llc_conn_state_trans *llc_d_conn_state_transitions[] = {
 	 [0] = &llc_d_conn_state_trans_5,	/* Request */
 	 [1] = &llc_common_state_trans_end,
 	 [2] = &llc_common_state_trans_end,	/* Local busy */
@@ -4419,7 +4419,7 @@ static const llc_conn_action_t llc_rst_actions_1[] = {
 	[4] = NULL,
 };
 
-static struct llc_conn_state_trans llc_rst_state_trans_1 = {
+static const struct llc_conn_state_trans llc_rst_state_trans_1 = {
 	.ev	       = llc_conn_ev_rx_sabme_cmd_pbit_set_x,
 	.next_state    = LLC_CONN_STATE_RESET,
 	.ev_qualifiers = NONE,
@@ -4447,7 +4447,7 @@ static const llc_conn_action_t llc_rst_actions_2[] = {
 	[7] = NULL,
 };
 
-static struct llc_conn_state_trans llc_rst_state_trans_2 = {
+static const struct llc_conn_state_trans llc_rst_state_trans_2 = {
 	.ev	       = llc_conn_ev_rx_ua_rsp_fbit_set_x,
 	.next_state    = LLC_CONN_STATE_NORMAL,
 	.ev_qualifiers = llc_rst_ev_qfyrs_2,
@@ -4475,7 +4475,7 @@ static const llc_conn_action_t llc_rst_actions_2_1[] = {
 	[7] = NULL,
 };
 
-static struct llc_conn_state_trans llc_rst_state_trans_2_1 = {
+static const struct llc_conn_state_trans llc_rst_state_trans_2_1 = {
 	.ev	       = llc_conn_ev_rx_ua_rsp_fbit_set_x,
 	.next_state    = LLC_CONN_STATE_NORMAL,
 	.ev_qualifiers = llc_rst_ev_qfyrs_2_1,
@@ -4495,7 +4495,7 @@ static const llc_conn_action_t llc_rst_actions_3[] = {
 	[2] = NULL,
 };
 
-static struct llc_conn_state_trans llc_rst_state_trans_3 = {
+static const struct llc_conn_state_trans llc_rst_state_trans_3 = {
 	.ev	       = llc_conn_ev_ack_tmr_exp,
 	.next_state    = LLC_CONN_STATE_NORMAL,
 	.ev_qualifiers = llc_rst_ev_qfyrs_3,
@@ -4518,7 +4518,7 @@ static const llc_conn_action_t llc_rst_actions_4[] = {
 	[4] = NULL,
 };
 
-static struct llc_conn_state_trans llc_rst_state_trans_4 = {
+static const struct llc_conn_state_trans llc_rst_state_trans_4 = {
 	.ev	       = llc_conn_ev_rx_disc_cmd_pbit_set_x,
 	.next_state    = LLC_CONN_STATE_ADM,
 	.ev_qualifiers = llc_rst_ev_qfyrs_4,
@@ -4541,7 +4541,7 @@ static const llc_conn_action_t llc_rst_actions_4_1[] = {
 	[3] = NULL,
 };
 
-static struct llc_conn_state_trans llc_rst_state_trans_4_1 = {
+static const struct llc_conn_state_trans llc_rst_state_trans_4_1 = {
 	.ev	       = llc_conn_ev_rx_disc_cmd_pbit_set_x,
 	.next_state    = LLC_CONN_STATE_ADM,
 	.ev_qualifiers = llc_rst_ev_qfyrs_4_1,
@@ -4564,7 +4564,7 @@ static const llc_conn_action_t llc_rst_actions_5[] = {
 	[3] = NULL,
 };
 
-static struct llc_conn_state_trans llc_rst_state_trans_5 = {
+static const struct llc_conn_state_trans llc_rst_state_trans_5 = {
 	.ev	       = llc_conn_ev_rx_dm_rsp_fbit_set_x,
 	.next_state    = LLC_CONN_STATE_ADM,
 	.ev_qualifiers = llc_rst_ev_qfyrs_5,
@@ -4586,7 +4586,7 @@ static const llc_conn_action_t llc_rst_actions_5_1[] = {
 	[2] = NULL,
 };
 
-static struct llc_conn_state_trans llc_rst_state_trans_5_1 = {
+static const struct llc_conn_state_trans llc_rst_state_trans_5_1 = {
 	.ev	       = llc_conn_ev_rx_dm_rsp_fbit_set_x,
 	.next_state    = LLC_CONN_STATE_ADM,
 	.ev_qualifiers = llc_rst_ev_qfyrs_5_1,
@@ -4602,7 +4602,7 @@ static const llc_conn_ev_qfyr_t llc_rst_ev_qfyrs_6[] = {
 /* just one member, NULL, .bss zeroes it */
 static const llc_conn_action_t llc_rst_actions_6[1];
 
-static struct llc_conn_state_trans llc_rst_state_trans_6 = {
+static const struct llc_conn_state_trans llc_rst_state_trans_6 = {
 	.ev	       = llc_conn_ev_data_req,
 	.next_state    = LLC_CONN_STATE_RESET,
 	.ev_qualifiers = llc_rst_ev_qfyrs_6,
@@ -4623,7 +4623,7 @@ static const llc_conn_action_t llc_rst_actions_7[] = {
 	[3] = NULL,
 };
 
-static struct llc_conn_state_trans llc_rst_state_trans_7 = {
+static const struct llc_conn_state_trans llc_rst_state_trans_7 = {
 	.ev	       = llc_conn_ev_ack_tmr_exp,
 	.next_state    = LLC_CONN_STATE_RESET,
 	.ev_qualifiers = llc_rst_ev_qfyrs_7,
@@ -4644,7 +4644,7 @@ static const llc_conn_action_t llc_rst_actions_8[] = {
 	[2] = NULL,
 };
 
-static struct llc_conn_state_trans llc_rst_state_trans_8 = {
+static const struct llc_conn_state_trans llc_rst_state_trans_8 = {
 	.ev	       = llc_conn_ev_ack_tmr_exp,
 	.next_state    = LLC_CONN_STATE_ADM,
 	.ev_qualifiers = llc_rst_ev_qfyrs_8,
@@ -4665,7 +4665,7 @@ static const llc_conn_action_t llc_rst_actions_8_1[] = {
 	[2] = NULL,
 };
 
-static struct llc_conn_state_trans llc_rst_state_trans_8_1 = {
+static const struct llc_conn_state_trans llc_rst_state_trans_8_1 = {
 	.ev	       = llc_conn_ev_ack_tmr_exp,
 	.next_state    = LLC_CONN_STATE_ADM,
 	.ev_qualifiers = llc_rst_ev_qfyrs_8_1,
@@ -4676,7 +4676,7 @@ static struct llc_conn_state_trans llc_rst_state_trans_8_1 = {
  * Array of pointers;
  * one to each transition
  */
-static struct llc_conn_state_trans *llc_rst_state_transitions[] = {
+static const struct llc_conn_state_trans *llc_rst_state_transitions[] = {
 	 [0] = &llc_rst_state_trans_6,		/* Request */
 	 [1] = &llc_common_state_trans_end,
 	 [2] = &llc_common_state_trans_end,	/* Local busy */
@@ -4710,7 +4710,7 @@ static const llc_conn_action_t llc_error_actions_1[] = {
 	[8] = NULL,
 };
 
-static struct llc_conn_state_trans llc_error_state_trans_1 = {
+static const struct llc_conn_state_trans llc_error_state_trans_1 = {
 	.ev	       = llc_conn_ev_rx_sabme_cmd_pbit_set_x,
 	.next_state    = LLC_CONN_STATE_NORMAL,
 	.ev_qualifiers = NONE,
@@ -4726,7 +4726,7 @@ static const llc_conn_action_t llc_error_actions_2[] = {
 	[4] = NULL,
 };
 
-static struct llc_conn_state_trans llc_error_state_trans_2 = {
+static const struct llc_conn_state_trans llc_error_state_trans_2 = {
 	.ev	       = llc_conn_ev_rx_disc_cmd_pbit_set_x,
 	.next_state    = LLC_CONN_STATE_ADM,
 	.ev_qualifiers = NONE,
@@ -4741,7 +4741,7 @@ static const llc_conn_action_t llc_error_actions_3[] = {
 	[3] = NULL,
 };
 
-static struct llc_conn_state_trans llc_error_state_trans_3 = {
+static const struct llc_conn_state_trans llc_error_state_trans_3 = {
 	.ev	       = llc_conn_ev_rx_dm_rsp_fbit_set_x,
 	.next_state    = LLC_CONN_STATE_ADM,
 	.ev_qualifiers = NONE,
@@ -4757,7 +4757,7 @@ static const llc_conn_action_t llc_error_actions_4[] = {
 	[4] = NULL,
 };
 
-static struct llc_conn_state_trans llc_error_state_trans_4 = {
+static const struct llc_conn_state_trans llc_error_state_trans_4 = {
 	.ev	       = llc_conn_ev_rx_frmr_rsp_fbit_set_x,
 	.next_state    = LLC_CONN_STATE_RESET,
 	.ev_qualifiers = NONE,
@@ -4770,7 +4770,7 @@ static const llc_conn_action_t llc_error_actions_5[] = {
 	[1] = NULL,
 };
 
-static struct llc_conn_state_trans llc_error_state_trans_5 = {
+static const struct llc_conn_state_trans llc_error_state_trans_5 = {
 	.ev	       = llc_conn_ev_rx_xxx_cmd_pbit_set_x,
 	.next_state    = LLC_CONN_STATE_ERROR,
 	.ev_qualifiers = NONE,
@@ -4778,7 +4778,7 @@ static struct llc_conn_state_trans llc_error_state_trans_5 = {
 };
 
 /* State transitions for LLC_CONN_EV_RX_XXX_RSP_Fbit_SET_X event */
-static struct llc_conn_state_trans llc_error_state_trans_6 = {
+static const struct llc_conn_state_trans llc_error_state_trans_6 = {
 	.ev	       = llc_conn_ev_rx_xxx_rsp_fbit_set_x,
 	.next_state    = LLC_CONN_STATE_ERROR,
 	.ev_qualifiers = NONE,
@@ -4798,7 +4798,7 @@ static const llc_conn_action_t llc_error_actions_7[] = {
 	[3] = NULL,
 };
 
-static struct llc_conn_state_trans llc_error_state_trans_7 = {
+static const struct llc_conn_state_trans llc_error_state_trans_7 = {
 	.ev	       = llc_conn_ev_ack_tmr_exp,
 	.next_state    = LLC_CONN_STATE_ERROR,
 	.ev_qualifiers = llc_error_ev_qfyrs_7,
@@ -4820,7 +4820,7 @@ static const llc_conn_action_t llc_error_actions_8[] = {
 	[5] = NULL,
 };
 
-static struct llc_conn_state_trans llc_error_state_trans_8 = {
+static const struct llc_conn_state_trans llc_error_state_trans_8 = {
 	.ev	       = llc_conn_ev_ack_tmr_exp,
 	.next_state    = LLC_CONN_STATE_RESET,
 	.ev_qualifiers = llc_error_ev_qfyrs_8,
@@ -4836,7 +4836,7 @@ static const llc_conn_ev_qfyr_t llc_error_ev_qfyrs_9[] = {
 /* just one member, NULL, .bss zeroes it */
 static const llc_conn_action_t llc_error_actions_9[1];
 
-static struct llc_conn_state_trans llc_error_state_trans_9 = {
+static const struct llc_conn_state_trans llc_error_state_trans_9 = {
 	.ev	       = llc_conn_ev_data_req,
 	.next_state    = LLC_CONN_STATE_ERROR,
 	.ev_qualifiers = llc_error_ev_qfyrs_9,
@@ -4847,7 +4847,7 @@ static struct llc_conn_state_trans llc_error_state_trans_9 = {
  * Array of pointers;
  * one to each transition
  */
-static struct llc_conn_state_trans *llc_error_state_transitions[] = {
+static const struct llc_conn_state_trans *llc_error_state_transitions[] = {
 	 [0] = &llc_error_state_trans_9,	/* Request */
 	 [1] = &llc_common_state_trans_end,
 	 [2] = &llc_common_state_trans_end,	/* Local busy */
@@ -4873,7 +4873,7 @@ static const llc_conn_action_t llc_temp_actions_1[] = {
 	[3] = NULL,
 };
 
-static struct llc_conn_state_trans llc_temp_state_trans_1 = {
+static const struct llc_conn_state_trans llc_temp_state_trans_1 = {
 	.ev	       = llc_conn_ev_disc_req,
 	.next_state    = LLC_CONN_STATE_ADM,
 	.ev_qualifiers = NONE,
@@ -4884,7 +4884,7 @@ static struct llc_conn_state_trans llc_temp_state_trans_1 = {
  * Array of pointers;
  * one to each transition
  */
-static struct llc_conn_state_trans *llc_temp_state_transitions[] = {
+static const struct llc_conn_state_trans *llc_temp_state_transitions[] = {
 	[0] = &llc_temp_state_trans_1,		/* requests */
 	[1] = &llc_common_state_trans_end,
 	[2] = &llc_common_state_trans_end,	/* local busy */
diff --git a/net/llc/llc_conn.c b/net/llc/llc_conn.c
index 0a3f5e0bec00..afc6974eafda 100644
--- a/net/llc/llc_conn.c
+++ b/net/llc/llc_conn.c
@@ -34,10 +34,10 @@ static int llc_find_offset(int state, int ev_type);
 static void llc_conn_send_pdus(struct sock *sk);
 static int llc_conn_service(struct sock *sk, struct sk_buff *skb);
 static int llc_exec_conn_trans_actions(struct sock *sk,
-				       struct llc_conn_state_trans *trans,
+				       const struct llc_conn_state_trans *trans,
 				       struct sk_buff *ev);
-static struct llc_conn_state_trans *llc_qualify_conn_ev(struct sock *sk,
-							struct sk_buff *skb);
+static const struct llc_conn_state_trans *llc_qualify_conn_ev(struct sock *sk,
+							      struct sk_buff *skb);
 
 /* Offset table on connection states transition diagram */
 static int llc_offset_table[NBR_CONN_STATES][NBR_CONN_EV];
@@ -356,9 +356,9 @@ static void llc_conn_send_pdus(struct sock *sk)
  */
 static int llc_conn_service(struct sock *sk, struct sk_buff *skb)
 {
-	int rc = 1;
+	const struct llc_conn_state_trans *trans;
 	struct llc_sock *llc = llc_sk(sk);
-	struct llc_conn_state_trans *trans;
+	int rc = 1;
 
 	if (llc->state > NBR_CONN_STATES)
 		goto out;
@@ -384,10 +384,10 @@ static int llc_conn_service(struct sock *sk, struct sk_buff *skb)
  *	This function finds transition that matches with happened event.
  *	Returns pointer to found transition on success, %NULL otherwise.
  */
-static struct llc_conn_state_trans *llc_qualify_conn_ev(struct sock *sk,
-							struct sk_buff *skb)
+static const struct llc_conn_state_trans *llc_qualify_conn_ev(struct sock *sk,
+							      struct sk_buff *skb)
 {
-	struct llc_conn_state_trans **next_trans;
+	const struct llc_conn_state_trans **next_trans;
 	const llc_conn_ev_qfyr_t *next_qualifier;
 	struct llc_conn_state_ev *ev = llc_conn_ev(skb);
 	struct llc_sock *llc = llc_sk(sk);
@@ -432,7 +432,7 @@ static struct llc_conn_state_trans *llc_qualify_conn_ev(struct sock *sk,
  *	success, 1 to indicate failure of at least one action.
  */
 static int llc_exec_conn_trans_actions(struct sock *sk,
-				       struct llc_conn_state_trans *trans,
+				       const struct llc_conn_state_trans *trans,
 				       struct sk_buff *skb)
 {
 	int rc = 0;
@@ -635,8 +635,8 @@ u8 llc_data_accept_state(u8 state)
  */
 static u16 __init llc_find_next_offset(struct llc_conn_state *state, u16 offset)
 {
+	const struct llc_conn_state_trans **next_trans;
 	u16 cnt = 0;
-	struct llc_conn_state_trans **next_trans;
 
 	for (next_trans = state->transitions + offset;
 	     (*next_trans)->ev; next_trans++)
-- 
2.45.2


