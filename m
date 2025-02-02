Return-Path: <netdev+bounces-161960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4536FA24C7D
	for <lists+netdev@lfdr.de>; Sun,  2 Feb 2025 03:12:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 981171885829
	for <lists+netdev@lfdr.de>; Sun,  2 Feb 2025 02:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C079A1805E;
	Sun,  2 Feb 2025 02:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gBdfMnq1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A49013AF2
	for <netdev@vger.kernel.org>; Sun,  2 Feb 2025 02:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738462319; cv=none; b=b+6iDSnBNnrWVpHW+vyqUCDfPbNaaAbMPGY/gamLo1kkemNEDBrPwzTmTFyItiaOZQpPzzH5DOuwXgCsLIu2UvImm2qkpm+AI+TTDrOlFI26t9qN08kelPAhW9B7vA13iz7S7/G33BKJKXvgWQ3RMww1gGQmZUh2woGxHqz0Dfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738462319; c=relaxed/simple;
	bh=DTSiIJ2XZjL1OjTPQKuFZ6eL9+GSCYb3zVNf86aycyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hWO7/Uwl2XDv4IvS6S4fdSuZ1kWxEn5/0VAvrffkpMlFSG1s7zi2uVfbN7N3j4jbVoQRfi+VQQWWws16fjC5rXKbWdOGg9wKUFW12h7VU6F9YCDQqmt8j21f687l4Fp/Z7BWHCTrqdR2A/gTSGv+ov3YTEs9VuVWsd/B5WtINKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gBdfMnq1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA665C4CEE3;
	Sun,  2 Feb 2025 02:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738462319;
	bh=DTSiIJ2XZjL1OjTPQKuFZ6eL9+GSCYb3zVNf86aycyo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gBdfMnq1IfxOKF+Q5Yq3ymw7uH0xXRgSPHZN4EhP9IiGIQnH/EwdgQIA3kulFiuOt
	 ZBy7Ka8VCjIGFgKGjk4rD+foQ9gE1xrA2fbVHgdEzQSZa12K4VPIaPoI+tPSkdyx9K
	 ZuamVdESOY8ZOLjIng20p1UcyE1UM94hPedxJs2Hk/sIZ/9d1D1xgVb0vIUlnp6BMQ
	 J4hADsbCY1v7eaWc1p389+KrtppvA8sGENahZpDdBH7IWLWm9tuAKG2wa+bF5/u89k
	 UnAWaheDVFjml6vG25NYYbOMxBP3hRhG8dRizLCCPOULSSmbIzGGCk6hIuhsSP/pmb
	 +boESHyaYkGBg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net 2/2] MAINTAINERS: add a sample ethtool section entry
Date: Sat,  1 Feb 2025 18:11:55 -0800
Message-ID: <20250202021155.1019222-2-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250202021155.1019222-1-kuba@kernel.org>
References: <20250202021155.1019222-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I feel like we don't do a good enough keeping authors of driver
APIs around. The ethtool code base was very nicely compartmentalized
by Michal. Establish a precedent of creating MAINTAINERS entries
for "sections" of the ethtool API. Use Andrew and cable test as
a sample entry. The entry should ideally cover 3 elements:
a core file, test(s), and keywords. The last one is important
because we intend the entries to cover core code *and* reviews
of drivers implementing given API!

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
This patch is a nop from process perspective, since Andrew already
is a maintainer and reviews all this code. Let's focus on discussing
merits of the "section entries" in abstract?
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4e701b9a57e4..9bf31ba720b6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16469,6 +16469,12 @@ F:	include/uapi/linux/ethtool*
 F:	net/ethtool/
 F:	tools/testing/selftests/drivers/net/*/ethtool*
 
+NETWORKING [ETHTOOL CABLE TEST]
+M:	Andrew Lunn <andrew@lunn.ch>
+F:	net/ethtool/cabletest.c
+F:	tools/testing/selftests/drivers/net/*/ethtool*
+K:	start_cable_test
+
 NETWORKING [GENERAL]
 M:	"David S. Miller" <davem@davemloft.net>
 M:	Eric Dumazet <edumazet@google.com>
-- 
2.48.1


