Return-Path: <netdev+bounces-247456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A5789CFADC7
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 21:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B2767304D489
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 20:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1AE084039;
	Tue,  6 Jan 2026 20:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BqQlo9Sp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B120F18FDDE
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 20:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767730032; cv=none; b=GyE6WHAsxURBZ1JTPlS64yXVMp2H0aauS5XCzDmoG+qEwEEIf19LxaEAF2I2IcWb3Gxzz1m0IUHXV1CWff3VLNCiuKzTSIxumk0G63x+dFdFQq7nIqZObQZg9MkWPmoBDB5s35KM0wN+PCrutu9QvLa7ki4UVMoHMtFRYaEaKrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767730032; c=relaxed/simple;
	bh=RerS10tdGvxmr5wE9qZhyY43jpR79dFvZM8tPStvoEE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dzj4JUtJsfWsh9pWQjuGEoe1SUa4PzHn7ZKaReIGAD0hhcJ4pc/FoKbzhGVkvD3Ai6DKRWCjmG3pWv5y9EI3ghmRrGkK+E/tsRTq2k/rEBxrLZtCcAJmuKgh5HmTH2YyZd5Ip2u+NGlKksne+uraAWNLJL+A2NSVsPkfLaOL9ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BqQlo9Sp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD248C116C6;
	Tue,  6 Jan 2026 20:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767730032;
	bh=RerS10tdGvxmr5wE9qZhyY43jpR79dFvZM8tPStvoEE=;
	h=From:To:Cc:Subject:Date:From;
	b=BqQlo9SpI9QKrr6bFJdA57oZAypHt12nvOP+lNtXqrsMzxW1+N0295HwBaZY2Pr6t
	 PoCwJw8xK5thHcq2pS3bdfaGA4dkT2eXhVoGiL9HxW+pu+OKBgmyjWKaR1sG6jRINR
	 Jo1FkZWni83fT9l65/xq55EehgPkmpjT9JvKato327WgQwJFWOjLbNfDofG4JUL/VG
	 MdD/GTcIcGc4mUfZ2YE0c64Xi2vcMbIgML4ZpJ/sVuRjT665oQCWha3Tddn9fe+qXO
	 HRviuk5tm9VVUC/q0djisj6HUMnq71N4LehLb2k54GZPDK8vxgztlaP7udnS1O6e5E
	 Vg4vnATNIKSXA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	john.fastabend@gmail.com,
	sd@queasysnail.net
Subject: [PATCH net] MAINTAINERS: add docs and selftest to the TLS file list
Date: Tue,  6 Jan 2026 12:07:06 -0800
Message-ID: <20260106200706.1596250-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The TLS MAINTAINERS entry does not seem to cover the selftest
or docs. Add those. While at it remove the unnecessary wildcard
from net/tls/, there are no subdirectories anyway so this change
has no impact today.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: john.fastabend@gmail.com
CC: sd@queasysnail.net
---
 MAINTAINERS | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 765ad2daa218..2079356a75fc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18418,9 +18418,11 @@ M:	Jakub Kicinski <kuba@kernel.org>
 M:	Sabrina Dubroca <sd@queasysnail.net>
 L:	netdev@vger.kernel.org
 S:	Maintained
+F:	Documentation/networking/tls*
 F:	include/net/tls.h
 F:	include/uapi/linux/tls.h
-F:	net/tls/*
+F:	net/tls/
+F:	tools/testing/selftests/net/tls.c
 
 NETWORKING [SOCKETS]
 M:	Eric Dumazet <edumazet@google.com>
-- 
2.52.0


