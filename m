Return-Path: <netdev+bounces-173300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3EBCA58504
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 15:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 294287A5452
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 14:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0961E1E12;
	Sun,  9 Mar 2025 14:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1I5nbliO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KuwQTsH6"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A771DEFF4
	for <netdev@vger.kernel.org>; Sun,  9 Mar 2025 14:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741531634; cv=none; b=s+K8ABSIDn3nfB05D4IcBU28WGoxJYHkcy7FjfeKX2Nt8REM9ehCChGgHPITUnvpNxProebd+KgCPJSrxDf/zKtEta8waXRBgioHOhKR11WnnCmEnS39A1H1tkuY4MiNPSTzWbBP1xXVQwkmVf4hSQv+jPIVtwvbtTygh0jGCRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741531634; c=relaxed/simple;
	bh=jjfd6RHPtteNgO7yEGHvcP+qOBDxtYou9Gf0kL4bVvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mBn1Ctzw85HM5zG4B76MO4patNDs6Un8rv5oqFgWGc4EFT5Ys32vaG8wKsprqnZKlXbWnn6DD7p1WbvGemDuM46NytVmBah9TbBmECcXX6KD2ffDuYwkaKUnw61XtqH5xUuo5Vr/Ah6nwgnsaglLmSjNVDCam3U8VDBh7cXvXXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1I5nbliO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KuwQTsH6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741531630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gg5xYKPXndomQP9XQYUjdgc6FcpfYQ4sSHtUSPlPLYA=;
	b=1I5nbliOQr3ymagYdt2ohC/2zcwWAWuHXorw6cDPeRg01Z6kyZeI314Z7jlMXnd/xBU2ZN
	xSui22QNbf7Blw0bEZV1hs3spDH001SKUnG3cCdBHzbPeLHSdgfCEsG7MV23feRfpsXtN/
	QAhtS+QDbrrnWqi3XuebCkh6oWGtGxy04RFiytbLfRY47wGcQGVi5151BEtPoyktwHydsx
	4AAeg15eedCqS1c7yOhIrPO313lcFlUvAIoJPd5vARQdbTHlnAEcqCgiHhGOo9fMYLIiNg
	zLhZomDD1RTsSnth7Op3ClfAxbkmmMnHG5dkTRmWT10KBD5xIy2figuiMOx+yg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741531630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gg5xYKPXndomQP9XQYUjdgc6FcpfYQ4sSHtUSPlPLYA=;
	b=KuwQTsH6D79xKwaIVyTUfogyxorcOUraVAEzLOx1yoaeE2kDLgsDlT0hspWCxsDeGm+lk7
	SYp1UCzE6i74HRCQ==
To: netdev@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Pravin B Shelar <pshelar@ovn.org>,
	dev@openvswitch.org
Subject: [PATCH net-next 11/18] openvswitch: Use nested-BH locking for ovs_actions.
Date: Sun,  9 Mar 2025 15:46:46 +0100
Message-ID: <20250309144653.825351-12-bigeasy@linutronix.de>
In-Reply-To: <20250309144653.825351-1-bigeasy@linutronix.de>
References: <20250309144653.825351-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

ovs_actions is a per-CPU variable and relies on disabled BH for its
locking. Without per-CPU locking in local_bh_disable() on PREEMPT_RT
this data structure requires explicit locking.
The data structure can be referenced recursive and there is a recursion
counter to avoid too many recursions.

Add a local_lock_t to the data structure and use
local_lock_nested_bh() for locking. Add an owner of the struct which is
the current task and acquire the lock only if the structure is not owned
by the current task.

Cc: Pravin B Shelar <pshelar@ovn.org>
Cc: dev@openvswitch.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 net/openvswitch/actions.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index 322ca7b30c3bc..c4131e04c1284 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -82,6 +82,8 @@ struct ovs_action {
 	struct action_fifo action_fifos;
 	struct action_flow_keys flow_keys;
 	int exec_level;
+	struct task_struct *owner;
+	local_lock_t bh_lock;
 };
=20
 static DEFINE_PER_CPU(struct ovs_action, ovs_actions);
@@ -1690,8 +1692,14 @@ int ovs_execute_actions(struct datapath *dp, struct =
sk_buff *skb,
 			const struct sw_flow_actions *acts,
 			struct sw_flow_key *key)
 {
+	struct ovs_action *ovs_act =3D this_cpu_ptr(&ovs_actions);
 	int err, level;
=20
+	if (ovs_act->owner !=3D current) {
+		local_lock_nested_bh(&ovs_actions.bh_lock);
+		ovs_act->owner =3D current;
+	}
+
 	level =3D __this_cpu_inc_return(ovs_actions.exec_level);
 	if (unlikely(level > OVS_RECURSION_LIMIT)) {
 		net_crit_ratelimited("ovs: recursion limit reached on datapath %s, proba=
ble configuration error\n",
@@ -1710,5 +1718,10 @@ int ovs_execute_actions(struct datapath *dp, struct =
sk_buff *skb,
=20
 out:
 	__this_cpu_dec(ovs_actions.exec_level);
+
+	if (level =3D=3D 1) {
+		ovs_act->owner =3D NULL;
+		local_unlock_nested_bh(&ovs_actions.bh_lock);
+	}
 	return err;
 }
--=20
2.47.2


