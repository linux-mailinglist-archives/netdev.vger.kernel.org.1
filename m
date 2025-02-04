Return-Path: <netdev+bounces-162769-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D1FA27DEC
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 22:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AED7167384
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 21:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9F9219A9F;
	Tue,  4 Feb 2025 21:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kyUZ+/4U"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47847158558
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 21:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738706274; cv=none; b=Zu0gtuMz63szo/HXmmMDVANrwqmvFdzg/UXXw4rNHXNPeYfuMK/BAN4Dba9OHpf/mSNcmWRPdFbFYOXZZAafUyIzHeBOcNpMvL/DgoDjOLo64onoQ47aP4+CfpcXORQuxjtH+oiGo7OHND2OGDIqbO+jhMCqXFVVo/DRkgx3Qhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738706274; c=relaxed/simple;
	bh=6PLGwM/cly2xuaMksUDqFPvTDIMpF0upm2s9WnGqnNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GGQpa1K5qsXfIyK3uJ2BGm4OBec5z6nHqQJP8++Es+dvz5tNHLTkL5UXEybeso5fWiMrYleAvU1l6AzpaPSQYPvPe3dCbn56PKOxPdJXCcxF0PrhwtL+FOPaMnyDMTScojdQSxNNmGCr1tzA4CislmY5on2CjnPKsbisNwFZCDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kyUZ+/4U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E3BDC4CEDF;
	Tue,  4 Feb 2025 21:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738706273;
	bh=6PLGwM/cly2xuaMksUDqFPvTDIMpF0upm2s9WnGqnNA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kyUZ+/4UGjAQXZtrKuEXV86g/pfFmNoMvtm5e4xLbzoPU1gUgOSMFAX997Fa7Gb3c
	 dCbQTl5JPRVU4zA2lCQtN9oijv24EkwIavuzWpV6N2F4MElPn7hTga7RAGGhRfK14o
	 PelS5jmqcjQoQySZ8IjQOTPcYd7F504ma1GkIcluchMIrzjgHMbpiTOtFNOJ+6/6an
	 803o/P91VBjvKEffGjCBqF+3zOjWcFawAoeX5KIUvDH9a0T/91TcByEyRcxqUxyt3A
	 QWKh9gJXaNTwG+cwizBMTUShPDMHnbMV1/7Ll1Cvpw5kZyR5FrxYe1VpKpV50GyfuH
	 X2PFMFl6LRm5Q==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net v2 2/2] MAINTAINERS: add a sample ethtool section entry
Date: Tue,  4 Feb 2025 13:57:50 -0800
Message-ID: <20250204215750.169249-1-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250204215729.168992-1-kuba@kernel.org>
References: <20250204215729.168992-1-kuba@kernel.org>
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
v2:
 - use cable_test as the keyword, looks like it doesn't produce any
   false positives
v1: https://lore.kernel.org/20250202021155.1019222-2-kuba@kernel.org
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 20c8daf3ce62..bd705e9123a3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16465,6 +16465,12 @@ F:	include/uapi/linux/ethtool*
 F:	net/ethtool/
 F:	tools/testing/selftests/drivers/net/*/ethtool*
 
+NETWORKING [ETHTOOL CABLE TEST]
+M:	Andrew Lunn <andrew@lunn.ch>
+F:	net/ethtool/cabletest.c
+F:	tools/testing/selftests/drivers/net/*/ethtool*
+K:	cable_test
+
 NETWORKING [GENERAL]
 M:	"David S. Miller" <davem@davemloft.net>
 M:	Eric Dumazet <edumazet@google.com>
-- 
2.48.1


