Return-Path: <netdev+bounces-159385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0DBA155E0
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 18:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34E6D188D8CC
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 17:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB90F1A072A;
	Fri, 17 Jan 2025 17:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rjsPlveI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955B620B20;
	Fri, 17 Jan 2025 17:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737135647; cv=none; b=WkJhi6DGVWGV5hK/gLAFp8dZrg12k/baXXLwCNbULkRZZHTloAmCVkAQgY9jE/8Y1S/AneJnrnLZQLRCQwnNhE0Fxd5BsNMXhfwmUnfWHmfJUvjeuNvhM8ZXu82pijQseT1bLu2eDUkzGTw3mdN7r1opTQ3zR5KUg21c0/w3T8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737135647; c=relaxed/simple;
	bh=jFuGDsElHAm0qEIO6nUF5QEJFbi0ENxEj18hPsjBiSQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=AQXUKEAE2+xCB0KDz2kLRsyjhGhyadgVcalyCrDmok4Yxe2ngchSuvt0aiYDFTDCRsinBJJUGlskcGNYIbKDTURKpQb0+IuHN/G6d5wflJThaDhJtFVriaBbrQRB+Mqz23IAC8/buTIL/MF/LRtH/IA2QVcaXclf6wlrYVPR8gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rjsPlveI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E047C4CEDD;
	Fri, 17 Jan 2025 17:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737135647;
	bh=jFuGDsElHAm0qEIO6nUF5QEJFbi0ENxEj18hPsjBiSQ=;
	h=From:Date:Subject:To:Cc:From;
	b=rjsPlveIpkor21bZPfXy8Tj1XjvOte0yF5+pK2RkTCNSkEnZgshM8FM+GJEIp4uUZ
	 6NJo92Uk74wCjLni0twuNwszDxkuiRMn7w7eCm3QwJzosoRaAuVmCPxhRkPKqmpsEW
	 sNqHqP7ln4qI5MvjS5OwponU6N/k7EdI5XubebZybAETjgGyn5EL29989h74GwbbS5
	 nRcVyofArwFwQxyIHMlxSC39VCQnU3J1Jcnqp0KPi5s+1+jJ0tzEcNB8tsiqnyH8UV
	 UJrftKn9BBrhNgZ8dAaDfUWiRr+Uu377arpyM0EZHhSdBgy+q75yer7ik97KFVJQPN
	 rxmaGfBGtBCTQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 17 Jan 2025 18:40:31 +0100
Subject: [PATCH net-next] mptcp: sysctl: add
 syn_retrans_before_tcp_fallback
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250117-net-next-mptcp-syn_retrans_before_tcp_fallback-v1-1-ab4b187099b0@kernel.org>
X-B4-Tracking: v=1; b=H4sIAA6WimcC/zWNQQrCMBBFr1Jm7UATWixeRSQkcaLBOg0zoVRK7
 24QXPzF+4v3dlCSTAqXbgehNWteuIE5dRCfnh+E+d4YbG/H3pgzMtW2reK71FhQP+yEqnhWFyg
 tQq7dLvl5Dj6+cEyDCSFOw2QJmrQIpbz9glf4u+B2HF/a6LjuigAAAA==
X-Change-ID: 20250117-net-next-mptcp-syn_retrans_before_tcp_fallback-5f41bbc8482e
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5317; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=jFuGDsElHAm0qEIO6nUF5QEJFbi0ENxEj18hPsjBiSQ=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnipYcdIvV7UlaIjx/I/1bUxaO31uZKd87UDQkW
 IkDLkWoeXCJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ4qWHAAKCRD2t4JPQmmg
 c64/D/9Y04eRrG73ab0V6M0LksxmXeBlo3DMHBWvOs+ar29VF1BTOwgxPvnmTGg4xcd3ZrnyFyJ
 f02ArLHyE8OYOuZwqnsB79bKHB3dmcxfcO4FbTAP7GcZVYn8V9sxrxcTSekIMzeMILZFDVwup6v
 cfEGA5DQJ85VmkOC23d9gkDvEXQbwEH87LisWQ+mF3Zp1lEmYDShC+y/bAnZtnIcFcXbzBri8IH
 3/OhmIsCsc+B6LXaafwcEpuBCu5809z3c3ckkrExrD5PREoQOR7O42WjXKS1JOzgQOSBvgTSC0M
 AerjjV3MhRKmHWmFHKUgqGEOwlfHB1d84RhrAepJy0HRei3xTCZ8ZAti1nzcpU0fBQsUR9mCkHj
 LJzCWx+wJ+hcU6D9X4UGdvnqAxCnafp/z47Hix+wYtNWiOTNTVT1KeMGSBghkaKQnPDi177mu/L
 1KRJo8BflSg1I5dK77DXjqNIDATN5rf3NNPbr6qTb9+Hgql9p+FBg1sgKquZ5K1tz8ECxGc67u9
 EDW1lCVrE+A/0bwSsLYF1j2mMVV1F0/fckTAcxW+Nol5PomljHTXzvpl+T7DVqr+xp0PfISGV6j
 e9cnJ/7S4Le+xlAGiVqJERSpGxFr2qmuXYDIuPh4UtDmt621VDDrTNMzI/qhX+QWSHdcV8vpTJ5
 J19V+cFN/s7Hi8g==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The number of SYN + MPC retransmissions before falling back to TCP was
fixed to 2. This is certainly a good default value, but having a fixed
number can be a problem in some environments.

The current behaviour means that if all packets are dropped, there will
be:

- The initial SYN + MPC

- 2 retransmissions with MPC

- The next ones will be without MPTCP.

So typically ~3 seconds before falling back to TCP. In some networks
where some temporally blackholes are unfortunately frequent, or when a
client tries to initiate connections while the network is not ready yet,
this can cause new connections not to have MPTCP connections.

In such environments, it is now possible to increase the number of SYN
retransmissions with MPTCP options to make sure MPTCP is used.

Interesting values are:

- 0: the first retransmission will be done without MPTCP options: quite
     aggressive, but also a higher risk of detecting false-positive
     MPTCP blackholes.

- >= 128: all SYN retransmissions will keep the MPTCP options: back to
          the < 6.12 behaviour.

The default behaviour is not changed here.

Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 Documentation/networking/mptcp-sysctl.rst | 16 ++++++++++++++++
 net/mptcp/ctrl.c                          | 21 +++++++++++++++++----
 2 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/Documentation/networking/mptcp-sysctl.rst b/Documentation/networking/mptcp-sysctl.rst
index 95598c21fc8e8782533bbc6a36de63bb465c297c..dc45c02113537b98dff76a6ed431c0449b5217f8 100644
--- a/Documentation/networking/mptcp-sysctl.rst
+++ b/Documentation/networking/mptcp-sysctl.rst
@@ -108,3 +108,19 @@ stale_loss_cnt - INTEGER
 	This is a per-namespace sysctl.
 
 	Default: 4
+
+syn_retrans_before_tcp_fallback - INTEGER
+	The number of SYN + MP_CAPABLE retransmissions before falling back to
+	TCP, i.e. dropping the MPTCP options. In other words, if all the packets
+	are dropped on the way, there will be:
+
+	* The initial SYN with MPTCP support
+	* This number of SYN retransmitted with MPTCP support
+	* The next SYN retransmissions will be without MPTCP support
+
+	0 means the first retransmission will be done without MPTCP options.
+	>= 128 means that all SYN retransmissions will keep the MPTCP options. A
+	lower number might increase false-positive MPTCP blackholes detections.
+	This is a per-namespace sysctl.
+
+	Default: 2
diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index b0dd008e2114bce65ee3906bbdc19a5a4316cefa..3999e0ba2c35b50c36ce32277e0b8bfb24197946 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -32,6 +32,7 @@ struct mptcp_pernet {
 	unsigned int close_timeout;
 	unsigned int stale_loss_cnt;
 	atomic_t active_disable_times;
+	u8 syn_retrans_before_tcp_fallback;
 	unsigned long active_disable_stamp;
 	u8 mptcp_enabled;
 	u8 checksum_enabled;
@@ -92,6 +93,7 @@ static void mptcp_pernet_set_defaults(struct mptcp_pernet *pernet)
 	pernet->mptcp_enabled = 1;
 	pernet->add_addr_timeout = TCP_RTO_MAX;
 	pernet->blackhole_timeout = 3600;
+	pernet->syn_retrans_before_tcp_fallback = 2;
 	atomic_set(&pernet->active_disable_times, 0);
 	pernet->close_timeout = TCP_TIMEWAIT_LEN;
 	pernet->checksum_enabled = 0;
@@ -245,6 +247,12 @@ static struct ctl_table mptcp_sysctl_table[] = {
 		.proc_handler = proc_blackhole_detect_timeout,
 		.extra1 = SYSCTL_ZERO,
 	},
+	{
+		.procname = "syn_retrans_before_tcp_fallback",
+		.maxlen = sizeof(u8),
+		.mode = 0644,
+		.proc_handler = proc_dou8vec_minmax,
+	},
 };
 
 static int mptcp_pernet_new_table(struct net *net, struct mptcp_pernet *pernet)
@@ -269,6 +277,7 @@ static int mptcp_pernet_new_table(struct net *net, struct mptcp_pernet *pernet)
 	/* table[7] is for available_schedulers which is read-only info */
 	table[8].data = &pernet->close_timeout;
 	table[9].data = &pernet->blackhole_timeout;
+	table[10].data = &pernet->syn_retrans_before_tcp_fallback;
 
 	hdr = register_net_sysctl_sz(net, MPTCP_SYSCTL_PATH, table,
 				     ARRAY_SIZE(mptcp_sysctl_table));
@@ -392,17 +401,21 @@ void mptcp_active_enable(struct sock *sk)
 void mptcp_active_detect_blackhole(struct sock *ssk, bool expired)
 {
 	struct mptcp_subflow_context *subflow;
-	u32 timeouts;
 
 	if (!sk_is_mptcp(ssk))
 		return;
 
-	timeouts = inet_csk(ssk)->icsk_retransmits;
 	subflow = mptcp_subflow_ctx(ssk);
 
 	if (subflow->request_mptcp && ssk->sk_state == TCP_SYN_SENT) {
-		if (timeouts == 2 || (timeouts < 2 && expired)) {
-			MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_MPCAPABLEACTIVEDROP);
+		struct net *net = sock_net(ssk);
+		u8 timeouts, to_max;
+
+		timeouts = inet_csk(ssk)->icsk_retransmits;
+		to_max = mptcp_get_pernet(net)->syn_retrans_before_tcp_fallback;
+
+		if (timeouts == to_max || (timeouts < to_max && expired)) {
+			MPTCP_INC_STATS(net, MPTCP_MIB_MPCAPABLEACTIVEDROP);
 			subflow->mpc_drop = 1;
 			mptcp_subflow_early_fallback(mptcp_sk(subflow->conn), subflow);
 		} else {

---
base-commit: 7d2eba0f83a59d360ed1e77ed2778101a6e3c4a1
change-id: 20250117-net-next-mptcp-syn_retrans_before_tcp_fallback-5f41bbc8482e

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


