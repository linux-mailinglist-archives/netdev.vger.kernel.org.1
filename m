Return-Path: <netdev+bounces-161959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA8B2A24C7C
	for <lists+netdev@lfdr.de>; Sun,  2 Feb 2025 03:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BB581885752
	for <lists+netdev@lfdr.de>; Sun,  2 Feb 2025 02:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC9F23A0;
	Sun,  2 Feb 2025 02:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n/HVkuG0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A26935942
	for <netdev@vger.kernel.org>; Sun,  2 Feb 2025 02:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738462319; cv=none; b=QIkFrACFH2u0lH0MsW+FvfS7Ck2U9Oad6rgvOd47tzgT8O2E2mQpUegMvSWm6BNmhIKzwXAdSPmT4rg+mTJ3WqCegsGs8420OPEmQ04pXQ+/ddkdPWl/uUPoy5Wqm1LSR2BQMCEYfV9u5X3rNokKk39zB8HFvysJDT04LM0xg3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738462319; c=relaxed/simple;
	bh=sqpizqivSNnNKmL7hLRDe0WOca36ulcM0XxJmt0Q+bQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N83jaH1uDPce6LrZaW1h/mFnaG1wT/h0eyM5qE4nK97ZB5iGjynd7iutQZZ0d7+BHs6KRaqgywZ01L2IGQ7cFMhab3FfeeY/C/SoER42FIl/JfNg0Lqx+Kq/DXsFROjxDPrDiNmW520WnYHsXy+2Y+UU6FDEwfjOV88LlHiecls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n/HVkuG0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46EFAC4CED3;
	Sun,  2 Feb 2025 02:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738462318;
	bh=sqpizqivSNnNKmL7hLRDe0WOca36ulcM0XxJmt0Q+bQ=;
	h=From:To:Cc:Subject:Date:From;
	b=n/HVkuG0az7q9OYVTbNbbQgjpz9zArOBFRbA2uyqU6D5DX5JDdZmWJy8PjEFbszCC
	 VeyvuSLbgGopnXRIY8WyVWKLeSdi58R98bERJJQG+lQJmqxjnBO4l7BZSPbVXTsyCL
	 QJygXwopSVmnL4DZax4omPTS9NffEnyYDiRMT1fCCJIKTcEvhe0VJssLpwBoXQXA7o
	 2hvtO45DbqNuJHXuBlX+iND2sHZ3T4TC7u/O2ZiLn9OvI5nFKMYYfEo/opnWfIn9mi
	 5PSFuorgufkHcFURXdBpYpXmsC/gyUBtyyVS7C6balDLptCrlk6VsyMf+dCpokXjDp
	 rV0n2nmvr8Jqw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Michal Kubecek <mkubecek@suse.cz>
Subject: [PATCH net 1/2] MAINTAINERS: add entry for ethtool
Date: Sat,  1 Feb 2025 18:11:54 -0800
Message-ID: <20250202021155.1019222-1-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Michal did an amazing job converting ethtool to Netlink, but never
added an entry to MAINTAINERS for himself. Create a formal entry
so that we can delegate (portions) of this code to folks.

Over the last 3 years majority of the reviews have been done by
Andrew and I. I suppose Michal didn't want to be on the receiving
end of the flood of patches.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: Michal Kubecek <mkubecek@suse.cz>

I emailed Michal a few days ago and didn't hear back.
Michal, please LMK if you'd like to be added as well!
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ce92c8a3e3ce..4e701b9a57e4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16459,6 +16459,16 @@ F:	include/net/dsa.h
 F:	net/dsa/
 F:	tools/testing/selftests/drivers/net/dsa/
 
+NETWORKING [ETHTOOL]
+M:	Andrew Lunn <andrew@lunn.ch>
+M:	Jakub Kicinski <kuba@kernel.org>
+F:	Documentation/netlink/specs/ethtool.yaml
+F:	Documentation/networking/ethtool-netlink.rst
+F:	include/linux/ethtool*
+F:	include/uapi/linux/ethtool*
+F:	net/ethtool/
+F:	tools/testing/selftests/drivers/net/*/ethtool*
+
 NETWORKING [GENERAL]
 M:	"David S. Miller" <davem@davemloft.net>
 M:	Eric Dumazet <edumazet@google.com>
-- 
2.48.1


