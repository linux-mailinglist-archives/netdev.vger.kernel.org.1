Return-Path: <netdev+bounces-97160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F23E8C99B3
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 10:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76C141C2042D
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 08:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB841B970;
	Mon, 20 May 2024 08:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fTTfvIhL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D38225CE;
	Mon, 20 May 2024 08:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716193032; cv=none; b=cDEO5Pm/v90JZ5OrBfdfi6xNUDXBemdHFn3sK7mRvMVrwYT3vEudOVBUT8OxsNBq15MR6/M2NMRXFhIpBnkEfkLJMa+Y3fYuC/fR+wq8AkpePGfjgz74oINqFpMTyUBoD0tZIEtCl9tudEWVTgTFuH5f7lE6BczjnRCyNKBOHf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716193032; c=relaxed/simple;
	bh=l9P1LJpRFXGmNv34bk5f33fH/TJc9InrPPq2VO+kELI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J6G5cBS9JXOD7HfzlA85R9QMQqQIEsL2i8jlWWmtNSj62s1/PZypNSZCiB42RK2ARxygZk9CRtJt/fyMzLTpY66G0S1YHmCwAZrA5wXA5t9vnHhEFfgP8XJRvz8roZuUQh8umWyx61DtubBPguN3lFv+EItrXBDvJpk3ApoJb3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fTTfvIhL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BB83C2BD10;
	Mon, 20 May 2024 08:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716193031;
	bh=l9P1LJpRFXGmNv34bk5f33fH/TJc9InrPPq2VO+kELI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fTTfvIhLPVwBqDSExH+smCvWBQH0pQ2ZlJg56HxsmlZXIFGUw5JaLYry6Lt3966le
	 tWNOBfLKmsoY570J0dlh+IyeG+n+sVfxv9/nHMDC9ucFZexXX89h7izo3fw/bFjvtw
	 iUlQgZsiB8bH7DaVXxwRRvu7lUTV/loNkwAGAya0gxj5J5tGEC0WEOzrMgEV/3/ZCM
	 Eq7bRzSk2AJHR00oia7UjqcnEiqQkJ3ZGe0sbvbGyB0XGQD3qsfw8OEk4rtPvaelCE
	 7QTzLTF1Vouq7YY41E5Hhd7YZb9WDjNBYkrpCqvmYZgl7E9al/8Pl4sVXMgjtBiVc1
	 2k612T0J+dtIw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 20 May 2024 10:16:41 +0200
Subject: [PATCH net 2/3] doc: mptcp: alphabetical order
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240520-upstream-net-20240520-mptcp-doc-v1-2-e3ad294382cb@kernel.org>
References: <20240520-upstream-net-20240520-mptcp-doc-v1-0-e3ad294382cb@kernel.org>
In-Reply-To: <20240520-upstream-net-20240520-mptcp-doc-v1-0-e3ad294382cb@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Gregory Detal <gregory.detal@gmail.com>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4118; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=l9P1LJpRFXGmNv34bk5f33fH/TJc9InrPPq2VO+kELI=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmSwb+39t4mSMK2P+yWtgxNepqakoh7IQVVPGdm
 HF2XiuK0+CJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZksG/gAKCRD2t4JPQmmg
 cxirEAClGi5n9IQf0isntmYkTaN13mXZU6bfNyWgnHjLgND25t5QMztWDoJuTQjWzFyQD+rzDfG
 LDK5acAAhFV6bL9riNbZrUGpAwOP07ybywpYEgpVvohZ6j1KsDGT159JgvsmBNi9VLoZh6tqgeY
 5+Hncx7aocVHIvxb2PQlVuJVqjqfPcG+NK3XlmgfrTl9RTRTgTWAoOgLwBD+3oraKPDkDZ2OjCH
 i8Pyx9sjMnsnQXv/TvQm2dQH7YglVbx2jKEyVlDlDz05eK2MQutTtiijpt717eqyBJDt8DkJYYK
 thyD3krOUXybWRzhVSuqSlTSShk+BPBRgjyl1MJzt+uDUmEKSQ+hYSFzaJUcwt24sDOknU/Jrq2
 IqhYhcBVtYArwqrVgGpPrhL7geOqFE3+XNq53pcKJXKPfRIPGGqbIIgaS18k6PUdvpszN9naYAU
 yBxuy/i8dxcPemxOvY05vejLcjrK2AiQSuIStFgVYp9AWV5nl4qGjJy+yK4bC0rq9mNphM+lx5H
 WIHzfOaINpeGk9ycHsGGEvDw6Z+BrQviHUOORePyD2W7VYInJ5C97sUCjRpp0ZFsbrKhoCQSmN/
 8o58GxVSNclwHNNoT/NAsWTEFPTSRjp23i69Pum3RU2QdX++UvIHRVclHU7TUUrQ1O5cAq5+HZs
 67uH4fEZPm01jlQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Similar to what is done in other 'sysctl' pages: it looks clearer from a
readability perspective.

This might cause troubles in the short/mid-term with the backports, but
by not putting new entries at the end, this can help to reduce conflicts
in case of backports in the long term. We don't change the information
here too often, so it looks OK to do that.

Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 Documentation/networking/mptcp-sysctl.rst | 78 +++++++++++++++----------------
 1 file changed, 39 insertions(+), 39 deletions(-)

diff --git a/Documentation/networking/mptcp-sysctl.rst b/Documentation/networking/mptcp-sysctl.rst
index 102a45e7bfa8..fd514bba8c43 100644
--- a/Documentation/networking/mptcp-sysctl.rst
+++ b/Documentation/networking/mptcp-sysctl.rst
@@ -7,14 +7,6 @@ MPTCP Sysfs variables
 /proc/sys/net/mptcp/* Variables
 ===============================
 
-enabled - BOOLEAN
-	Control whether MPTCP sockets can be created.
-
-	MPTCP sockets can be created if the value is 1. This is a
-	per-namespace sysctl.
-
-	Default: 1 (enabled)
-
 add_addr_timeout - INTEGER (seconds)
 	Set the timeout after which an ADD_ADDR control message will be
 	resent to an MPTCP peer that has not acknowledged a previous
@@ -25,25 +17,6 @@ add_addr_timeout - INTEGER (seconds)
 
 	Default: 120
 
-close_timeout - INTEGER (seconds)
-	Set the make-after-break timeout: in absence of any close or
-	shutdown syscall, MPTCP sockets will maintain the status
-	unchanged for such time, after the last subflow removal, before
-	moving to TCP_CLOSE.
-
-	The default value matches TCP_TIMEWAIT_LEN. This is a per-namespace
-	sysctl.
-
-	Default: 60
-
-checksum_enabled - BOOLEAN
-	Control whether DSS checksum can be enabled.
-
-	DSS checksum can be enabled if the value is nonzero. This is a
-	per-namespace sysctl.
-
-	Default: 0
-
 allow_join_initial_addr_port - BOOLEAN
 	Allow peers to send join requests to the IP address and port number used
 	by the initial subflow if the value is 1. This controls a flag that is
@@ -57,6 +30,37 @@ allow_join_initial_addr_port - BOOLEAN
 
 	Default: 1
 
+available_schedulers - STRING
+	Shows the available schedulers choices that are registered. More packet
+	schedulers may be available, but not loaded.
+
+checksum_enabled - BOOLEAN
+	Control whether DSS checksum can be enabled.
+
+	DSS checksum can be enabled if the value is nonzero. This is a
+	per-namespace sysctl.
+
+	Default: 0
+
+close_timeout - INTEGER (seconds)
+	Set the make-after-break timeout: in absence of any close or
+	shutdown syscall, MPTCP sockets will maintain the status
+	unchanged for such time, after the last subflow removal, before
+	moving to TCP_CLOSE.
+
+	The default value matches TCP_TIMEWAIT_LEN. This is a per-namespace
+	sysctl.
+
+	Default: 60
+
+enabled - BOOLEAN
+	Control whether MPTCP sockets can be created.
+
+	MPTCP sockets can be created if the value is 1. This is a
+	per-namespace sysctl.
+
+	Default: 1 (enabled)
+
 pm_type - INTEGER
 	Set the default path manager type to use for each new MPTCP
 	socket. In-kernel path management will control subflow
@@ -74,6 +78,14 @@ pm_type - INTEGER
 
 	Default: 0
 
+scheduler - STRING
+	Select the scheduler of your choice.
+
+	Support for selection of different schedulers. This is a per-namespace
+	sysctl.
+
+	Default: "default"
+
 stale_loss_cnt - INTEGER
 	The number of MPTCP-level retransmission intervals with no traffic and
 	pending outstanding data on a given subflow required to declare it stale.
@@ -85,15 +97,3 @@ stale_loss_cnt - INTEGER
 	This is a per-namespace sysctl.
 
 	Default: 4
-
-scheduler - STRING
-	Select the scheduler of your choice.
-
-	Support for selection of different schedulers. This is a per-namespace
-	sysctl.
-
-	Default: "default"
-
-available_schedulers - STRING
-	Shows the available schedulers choices that are registered. More packet
-	schedulers may be available, but not loaded.

-- 
2.43.0


