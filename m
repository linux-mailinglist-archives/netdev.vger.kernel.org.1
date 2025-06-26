Return-Path: <netdev+bounces-201666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91626AEA53F
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 20:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58E667AA7B8
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 18:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5C82248A0;
	Thu, 26 Jun 2025 18:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tl5wLpnr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AB1219303;
	Thu, 26 Jun 2025 18:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750962071; cv=none; b=hQe6ISZUQjfIeSKisBahC1eRRQtTuJ5hCg7i8rwyUzuHmkkIQ17WW6Pwc0GI0sXhVjVmy/gk1Uw3o75D38cl21Q7Gx6ZI0gMg33FKp6exSwA6fUWJHO2S1tDbVBPjoHrTs1T/IjehR+NSKvMDweRUlfTo+gdOr6yNupiWYEfaUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750962071; c=relaxed/simple;
	bh=Uis5VaMGXGcfGNkwwbsvB9JFelGu2N6VH0/KBsVtlks=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JYjH++9XdK/2ZlYNNg+Um7e0wTCLCGiJOcbf8QiL6wTkHGTpmCmqVzmuBNbAiD8IJFeKGHatjZXuFlTrkMu8Q7566uKGbpyJ57cdtNNUz6DI0G6Lv2mEuay0t80zLpTBMrn4zGgIcRQ+GprT3lfSgAgoJUgVzsbyrM9c3cbzOj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tl5wLpnr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC24AC4CEEB;
	Thu, 26 Jun 2025 18:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750962071;
	bh=Uis5VaMGXGcfGNkwwbsvB9JFelGu2N6VH0/KBsVtlks=;
	h=From:To:Cc:Subject:Date:From;
	b=Tl5wLpnrZ2YSi4lvtH2EQizW3G2PQORthSDVfjvrUa4Yl/V49GUofPYmTN3d/b5J2
	 kxAK0jODSprNgA+IwxXduUwgCqzkwcDxMu4cIEfa2fmPixqO8xTbtLD2w2tNDr4Jbf
	 He9n9QWuJvYNoAJN1fBI7XyfVWvW1ujagnzt0LaqclWgX4gndpW0UOlt80qM+W46iE
	 Z4/fNYQ25n/XNSlGVoUqOn/CNAqQgLPVHTq3qT4RZ9c8ou+m4kbXaHv8sMKv8RPpwn
	 S2gf9bvRV7ZR4mqkl9KOlbBpB4q1Yj5WJnJ16zzg24SY1uzEdiySk2YRN4ce+P8Ao4
	 IL4UgOTn2aaEw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	corbet@lwn.net,
	linux-doc@vger.kernel.org
Subject: [PATCH net] docs: netdev: correct the heading level for co-posting selftests
Date: Thu, 26 Jun 2025 11:20:55 -0700
Message-ID: <20250626182055.4161905-1-kuba@kernel.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"Co-posting selftests" belongs in the "netdev patch review" section,
same as "co-posting changes to user space components". It was
erroneously added as its own section.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: corbet@lwn.net
CC: linux-doc@vger.kernel.org
---
 Documentation/process/maintainer-netdev.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/process/maintainer-netdev.rst b/Documentation/process/maintainer-netdev.rst
index 1ac62dc3a66f..e1755610b4bc 100644
--- a/Documentation/process/maintainer-netdev.rst
+++ b/Documentation/process/maintainer-netdev.rst
@@ -312,7 +312,7 @@ Posting as one thread is discouraged because it confuses patchwork
 (as of patchwork 2.2.2).
 
 Co-posting selftests
---------------------
+~~~~~~~~~~~~~~~~~~~~
 
 Selftests should be part of the same series as the code changes.
 Specifically for fixes both code change and related test should go into
-- 
2.50.0


