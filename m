Return-Path: <netdev+bounces-282065-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Ke5KecZ8Wm3dQEAu9opvQ
	(envelope-from <netdev+bounces-282065-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 22:34:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B2C48BCBA
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 22:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13B08306B397
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 20:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0972BDC3F;
	Tue, 28 Apr 2026 20:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N24ebsC8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E601862A;
	Tue, 28 Apr 2026 20:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777408439; cv=none; b=X1RSDWHSHd2cU0VSdPymb0nRrXo6tZXCq+PxzwjAkveBTqZxjUxESC3rK7WO8tNDk9efcYo/GESbGP1ndkej9daKNejOb3/CV2jmMePmMYS1C9k0kQrrwTUNbHqmn5qs5ahfQcf1ymvM+NlQNzyhsmW0DpdjyOg4j+edAw1x5+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777408439; c=relaxed/simple;
	bh=lgh6LKKQCN0cKnoDV+vRpqfEdtB1HLtF78R2A8Xos3s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=igc6Eo8SYZ74r90NjA69YKIpLGx5TEoP/pmPrZy1qo508dKD+0GCfSpGBTZJ904zZUZFs1VsQ17VdcnJEp2D7kCjWHj/wk0tqn+xlGkZZArAgD72ilQcilnLSDuCqtWFVM8pZJBizaB+6GiJ7V0ns+Reuik9NB9ESuDDHdni9+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N24ebsC8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B2F0C2BCAF;
	Tue, 28 Apr 2026 20:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777408438;
	bh=lgh6LKKQCN0cKnoDV+vRpqfEdtB1HLtF78R2A8Xos3s=;
	h=From:To:Cc:Subject:Date:From;
	b=N24ebsC8hC4F/i4KxAaOTG1TkCRA7HI1fiYC8zZB4OLVtf5gTnqq37NE33FkYSvHw
	 MCrvpzCs6hbEj+V2dLc+0NGRpnj/k3ER4nK7MDgNvbY9+LLbKaWt8b0MiYelj9UwOX
	 Qoq4X6+tjnCuIRdsCeHLddYi8n0OMnZlIt8sSbAtBJqjApzusO2wrA7RRkeP4kb8NX
	 KMXNIEbntfJQtEIxa31z+FJQ8Ul/WvmoMoWP8fLkJLGTMI06q9ZRtxZMdiSfMRIstX
	 M4N7aV0JbZ2jSCDafyVLVI4FTtgDo4i6TGiu5pmZ/eyN6Uo9cN/5w7eA6lse6Absyr
	 KatpqO8Jc0+xQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next] selftests: drv-net: clarify linters and frameworks in README
Date: Tue, 28 Apr 2026 13:33:57 -0700
Message-ID: <20260428203357.1222611-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 54B2C48BCBA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282065-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Minor clarifications in the README:
 - call out what linters we expect to be clean
 - make it clear that by "frameworks" we mean code under lib/
   not just factoring code out in the same file

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: shuah@kernel.org
CC: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/drivers/net/README.rst | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/README.rst b/tools/testing/selftests/drivers/net/README.rst
index c8588436c224..c6bed9a985bc 100644
--- a/tools/testing/selftests/drivers/net/README.rst
+++ b/tools/testing/selftests/drivers/net/README.rst
@@ -211,8 +211,8 @@ Avoid libraries and frameworks
 
 Test files should be relatively self contained. The libraries should
 only include very core or non-trivial code.
-It may be tempting to "factor out" the common code, but fight that urge.
-Library code increases the barrier of entry, and complexity in general.
+It may be tempting to "factor out" the common code to lib/py/, but fight that
+urge. Library code increases the barrier of entry, and complexity in general.
 
 Avoid mixing test code and boilerplate
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -290,6 +290,12 @@ decorator can be a list or a generator.
   def test(cfg, mode, protocol):
       pass
 
+Linters
+~~~~~~~
+
+We expect clean ``ruff check`` and ``pylint --disable=R``.
+The code should be clean, avoid disabling pylint warnings explicitly!
+
 Running tests CI-style
 ======================
 
-- 
2.54.0


