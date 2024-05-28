Return-Path: <netdev+bounces-98420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D238D15E5
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 10:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24E8A1F214CB
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 08:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E2713CAA2;
	Tue, 28 May 2024 08:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o+UUJ2X+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941D013CA8C;
	Tue, 28 May 2024 08:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716883795; cv=none; b=Z4xOEnDGhd6ipbjAYiiCDN0j6vF2SjvOSNepsJeXMf55BbAzEaZRrhlUKDBqUP7DXEy0tzjg0q9aIQxlBJkdaXQoept2uejvVoGfpT0WxdheTFVSMNEKgz1HzxofedvYXeLlKczQX9PlAjuBH7NR0VIVmqbZJ5t9ZoBXpSzb5Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716883795; c=relaxed/simple;
	bh=l9P1LJpRFXGmNv34bk5f33fH/TJc9InrPPq2VO+kELI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L67Id9yoH5EufZsfrKbD4HE5EDECIxeSFVhGemSWgF6NbkPpzFgIsHVZgdzNeAM3jKgZvCVT4PgM5t2psWrLWluNOnrEjPT1qfG6ng06/5vJ1AJxaxaAWCXAzJKBEb8bj8Z54k7nJzx1a8NrBB45pZw+XoA/STcYeEPI0qfZu1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o+UUJ2X+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72787C3277B;
	Tue, 28 May 2024 08:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716883795;
	bh=l9P1LJpRFXGmNv34bk5f33fH/TJc9InrPPq2VO+kELI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=o+UUJ2X+Ddd3/u+BWP2bEp6SHDUfX+A41UkF36j5ZF2ekhbhqxeBu1qmuM6K1IO1x
	 U9si2FzuP/RQOtXC18l/prJJptWAZZPD0LgYG9YSdJawDoT0XjbnAQ5ZoXYWB4g+vm
	 FLyABw9zpPowBpAo3d2LjT5NRzi5J5VWNO7D3kNuSqU+eyLwVT9wujn2Yb6CK4HtDn
	 r3XvcywQ9/WZMjN5f85ghUtOgSj4oBpf7Ufz/qwwrKda/ub3xMVavBjU+1iv3Qij8N
	 HWKb+11+S9La2FbVOh0dfzIn189gGwBg+m7yVN4FUM3h5LSW5cjblR2wiktcKTDBfP
	 e2WAZLvguVgSA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 28 May 2024 10:09:17 +0200
Subject: [PATCH net-next v2 2/3] doc: mptcp: alphabetical order
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240528-upstream-net-20240520-mptcp-doc-v2-2-47f2d5bc2ef3@kernel.org>
References: <20240528-upstream-net-20240520-mptcp-doc-v2-0-47f2d5bc2ef3@kernel.org>
In-Reply-To: <20240528-upstream-net-20240520-mptcp-doc-v2-0-47f2d5bc2ef3@kernel.org>
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
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmVZFJvpQlEo8NIvqve/JQBzMNRft8dpovN9fQR
 6+A/4u2byKJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZlWRSQAKCRD2t4JPQmmg
 c5BqEACwSgEs+yF0VqbkRWNSIfkNY6OPwkp2DP1W6uHUpRM3FFTE0WFVuGTj5OtzOf2W9A8YsWl
 xwCXU/sCMo1B8so/+J6tzPiRVMyJ0mXWZIq28GpxpwDHCsSe1RjD/zq3sghMpVLA7f+jD9j+70n
 P2yUVcIGrROTXcO5scCgSQyaGIUFHqhPFxnULCsYhaJz/LGrdPeX6yH1fZ+WxA+cDgc/fj1XWGC
 qFDQ+bOaFUYxxVLeiWYGYoKLLdK0qbJ1yLe1Jh3v5HycQevLFVlhR6CSv8Q5U2YgWvJ+KYCMcyh
 nww0jBVGS3ciqOGzXM5wol0iGVQXEXzgMbdlNNvlUELSfKmrLnjgiXtWnbctvppMq9jUpqRpU+m
 4TUGCVHhJak/p9tW+HU3GbOHmOpkbW0nTqy8VPf7fIWhKb3GAEKnXcoi5VC7xE4zT7ii7oV/atz
 b6mYSdPgSFXzkOQ860zSHVpTc1ouxdNC/1dgTFG44R2NVHsxvj2aFYnQGJLUjdNsKyWWQzfefn+
 RHndvLn1/oXHhS6i3HvvwD3uqiMB49s7BHzEanXNNO7kcZ0fCYDHflEeUQE4BAjiGOskFCJmfCq
 IKW7VK+XYYjx7muQxK6EDUuapZsoDr2GZxq6h73VEmlktzcZd+JlSAsAdVd0Tzny8VbfhkZl//f
 APYzihGRTjTR13A==
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


