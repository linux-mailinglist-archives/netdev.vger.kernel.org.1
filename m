Return-Path: <netdev+bounces-214099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F3FB28447
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 18:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BBFE7B0334
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 16:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E934A25785B;
	Fri, 15 Aug 2025 16:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ORD7Lum/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EFE2E5D3D;
	Fri, 15 Aug 2025 16:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755276764; cv=none; b=hCebaeJmaeVUVD/Zq0T7rpIvDFBy5psaHotsTk8Ez5BmTr6eCCqzQAiazFtpKTJP35DpVN8MoUlJusOOPZKy7paSEf3YfAT0AhA3e8q3oNQr3s9HFcTefgtF1sL4NFiAOOSX3zwgEeiWnTMJ2qBtXLcpSlX2TuFXG8skBMg8fTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755276764; c=relaxed/simple;
	bh=px70tUu1Tgeq0g5c7/3dmPg2hkPKkukCFcKL6UVjVFo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DY76q7PjqX9XESsCzPero4GnrBgstmO89OrsMEaggA/3KFxB6B+F92cTFP51c27FeVW0qajLvvdakTSxSqmuqZuSdXu+LiV29BBrci20KuVSAQIU12nDmRmdCrj5QdC17vDHDi4pdRdrnUqpPESQAm+Gd+bnD5ryeXPIyV0l0/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ORD7Lum/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B36BC4CEF5;
	Fri, 15 Aug 2025 16:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755276764;
	bh=px70tUu1Tgeq0g5c7/3dmPg2hkPKkukCFcKL6UVjVFo=;
	h=From:To:Cc:Subject:Date:From;
	b=ORD7Lum/sDduLDefCzPSAY4OObgc5lvjpjsd996bnSirpeDGVPKXmCZAG/hXjiEt5
	 6cYvlogSt/jOmJfUbz+LeYQtxzlgR7VTdFGB3Iz9ctCu0EtE0zPDHiIOKy7roOFjln
	 Wj+VUnKVektevJT10CMrByaJst7Bo9bwqYjLuHZ/ZduTysSvw+Ts4s7nBSaQZqqoIS
	 iltmOiza6lXpjWluHI89NELHytnAQFarY7U0m+5XrQF/TKZvY/zjHTbpx5gVhsR4BN
	 URZCYmau0eIs6Gqw6FpfKxRRzNfU+bHg7ey/Zo4VyFO3F5ubt1cxpYjevnDD/NDQES
	 xqIf0OZ28hPIw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	corbet@lwn.net,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH net-next] docs: netdev: refine the clean-up patch examples
Date: Fri, 15 Aug 2025 09:52:42 -0700
Message-ID: <20250815165242.124240-1-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We discourage sending trivial patches to clean up checkpatch warnings.
There are other tools which lead to patches of similarly low value
like some coccicheck warnings. The warnings are useful for new code
but fixing them in the existing code base is a waste of review time.

Broaden the example given in the doc a little bit.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: corbet@lwn.net
CC: workflows@vger.kernel.org
CC: linux-doc@vger.kernel.org
---
 Documentation/process/maintainer-netdev.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/process/maintainer-netdev.rst b/Documentation/process/maintainer-netdev.rst
index e1755610b4bc..989192421cc9 100644
--- a/Documentation/process/maintainer-netdev.rst
+++ b/Documentation/process/maintainer-netdev.rst
@@ -407,7 +407,7 @@ Clean-up patches
 Netdev discourages patches which perform simple clean-ups, which are not in
 the context of other work. For example:
 
-* Addressing ``checkpatch.pl`` warnings
+* Addressing ``checkpatch.pl``, and other trivial coding style warnings
 * Addressing :ref:`Local variable ordering<rcs>` issues
 * Conversions to device-managed APIs (``devm_`` helpers)
 
-- 
2.50.1


