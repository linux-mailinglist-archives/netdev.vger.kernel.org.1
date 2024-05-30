Return-Path: <netdev+bounces-99427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD0F8D4D82
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 16:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40FD51F224B2
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 14:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A69017D882;
	Thu, 30 May 2024 14:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aHgyqgK8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB0D186E4C;
	Thu, 30 May 2024 14:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717078089; cv=none; b=mzUXjYxXjecmviFIgiAeX7pRFvZmYpic7zV+7QSu6dTmLdq7W7cWXUAOgNDp8Q5GFGew/tAqL/vzRpcPq/kI/A04tvMx1URoxxEpHiwQ/7zK8JN4XDvqwhi9Y8GyUQOGBFQqDwUl0F5MXc0JKnuBZca2aijd6JbcL1JWwcAKGK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717078089; c=relaxed/simple;
	bh=l9P1LJpRFXGmNv34bk5f33fH/TJc9InrPPq2VO+kELI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VSASWMK+Zj9V2tgOqq/Qgd2L/AYh3/tOuiJiwKU1Duw1YI1pkRn+JnrSmDOvmBQ9RJYesL4jj3Co1jKGZoob3cr5msNu0XbvOBcB10J4rCX8poFf3GyTcf8CiBLtvUj0NW5HggcCTsU6ArTYyWm7oVk7DhzcDCgcMosCkPZQ21Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aHgyqgK8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 183B7C4AF09;
	Thu, 30 May 2024 14:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717078088;
	bh=l9P1LJpRFXGmNv34bk5f33fH/TJc9InrPPq2VO+kELI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=aHgyqgK85Xg4CwOYFPfqRfFua9sudpwdSPUcUFSCpI6CSLc7W+eVgvjeEE96thkff
	 41M21OQ0XdcoxBEhD6MjJcW6+VhHM5iWusyJlGwq2j8cp7+GqdwCpW3zHtsCOzzBWh
	 j1En8rzG/MmmsC4TmoXIMA5qQ8w+a8nnRmn9JX30yoc87RPfQtyrs4LonDhvgPdW+t
	 dETnbIdBHvlhc6ZfHc2av1LhEuA0yILiLeATXV9Ot/w6PfvBajykNLhYlRQklpXF2i
	 Zbcp2FvPagYk1wY8egTEMiKwLhD9S5X+TEmvCIg3tHylunFrZ706VjMWNEueLUMZET
	 VeZ88sFEEG8Fg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 30 May 2024 16:07:31 +0200
Subject: [PATCH net-next v3 2/3] doc: mptcp: alphabetical order
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240530-upstream-net-20240520-mptcp-doc-v3-2-e94cdd9f2673@kernel.org>
References: <20240530-upstream-net-20240520-mptcp-doc-v3-0-e94cdd9f2673@kernel.org>
In-Reply-To: <20240530-upstream-net-20240520-mptcp-doc-v3-0-e94cdd9f2673@kernel.org>
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
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmWIg+3wlsAsKEFJ4Fz9ygwrvq++X5yPH6lRVuM
 yvPRmhP+ZyJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZliIPgAKCRD2t4JPQmmg
 c4UTEADtovfIxHE0jdcnAeX1YD8rvupBqR/GJFxPJmbfWjOChPk+G8eTYKT/WzF3cLvBFaol3I6
 aRD9FI+TwYZUxd4k57TxZjehthe7rauWHLvpskspN6x0QgH1L9i/0CGd9ful5zOjv23llNzKjZt
 hR43tFHgtljOzQ5M9afDnOfHqKxyp9c6w1MWHScIddJ/caMdYkJTI7J1Sn3kiUz/DHWfKkUyUau
 rzLn5rezvEd4qEBSEmBtUTvYY46xs5leeA/0GgyUkdGyQD2OZdGcYIXi2lpSJHTTNZKlscPWThy
 WzA3BRFtGXhWS7se96NW8jyVaemMA+m83f77A57fMebuk9TQl3gtEo0yYDZ7ehu6ObXv/xhpgpF
 qx3433dtfFvOvETEHz2mzOKbCxO1wrmPJvr3XbNZ0icWPy4h057o2E2aDN+VorhRDsC42sOyeVP
 JnRnWTfFZggJbKH+e7dC7Jky0wWxESddvZXSw7GzS88hUyBhdw30N/+nVzzxgTfeftwl8Y2kVzB
 j8togOKRNhrmDyQs8lIdbwuX2d6f33AL2mVbDLMjtcz3YNQWDAFBh8HA7h9Hl8fYA5vIBML7Jf7
 zndCMfUfG2UVKo9REaPcEqI/77Kt4/YKp89A/dtjX2Wl2VGNNWmc9r+vhFMl1g7tOcVry0LVHjJ
 tud/CqMB508sIJQ==
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


