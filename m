Return-Path: <netdev+bounces-143110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB2E9C1345
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 01:47:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5D762843D5
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 00:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE76EBE;
	Fri,  8 Nov 2024 00:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ncdm0F6f"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971D53FE4
	for <netdev@vger.kernel.org>; Fri,  8 Nov 2024 00:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731026858; cv=none; b=iGmq2Cw4iXOD9GDAM6RuA+BGWjgtZ2HDfAboMunZOCE2sdyMLnMj3sJSVSps14pSBjH8NKAG+dX5oLHrUA5nIcXtt+S2ruAvgIlvCh2TIBzVHmuIX9p0nVyvBabWc8+aMfMdBWaqS9q76zHvNkjnj55gGlxs2ZrsjhZcW8wUjC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731026858; c=relaxed/simple;
	bh=8MVTuqnruMeiu2mvgaWR0MEA5WRDGvSxFpZ02oGpEow=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q53ePiuLO9RhvTDWwRikDmjES5GLRe9BNkCpq+vIcFcRl9xhw7EqR20ckz0OOpuHd5qnNpKLxIpjaxxavNMHX/xE8Y3KMZ6nLs11rT0b12KKjpdPeOqT1ChFipsdyHZhnSbj0YxG7tKC4QV+HYo8QLOXDL1Cfy06NAJrhRI56Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ncdm0F6f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B99EFC4CECE;
	Fri,  8 Nov 2024 00:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731026858;
	bh=8MVTuqnruMeiu2mvgaWR0MEA5WRDGvSxFpZ02oGpEow=;
	h=From:To:Cc:Subject:Date:From;
	b=ncdm0F6fINLTVdfwC32EwOI8gH5t1BxN2D0KAUiJ9TiSd6du+4AAo1V33sx8gRoli
	 6+hZ36l9z26031rWLy1rxAqojJV1xtvI4Bq4Hu69uiBMcgbNHn5TLiwnKYJntQPp9q
	 SLT1qtXpw1D6ilA1ei2ZkmRRYswkA2ER2G0mr1WXL5aWElcwUktzMg0GwIYcYvhWL4
	 jq+t+qm+x9zWTeqNcojWnsygrIrUu25c7nhMPtpYQWI7KZCsIs7J/2drjgkekLOWR8
	 R/dEKVNTu10DRdhcsUYB9NJnywItle6C862zMT+3aFLE14xL8lVoHNp4XIZhJQ/ar+
	 6TEgs8kOfhXBQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net] selftests: net: add netlink-dumps to .gitignore
Date: Thu,  7 Nov 2024 16:47:31 -0800
Message-ID: <20241108004731.2979878-1-kuba@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 55d42a0c3f9c ("selftests: net: add a test for closing
a netlink socket ith dump in progress") added a new test
but did not add it to gitignore.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/net/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/.gitignore b/tools/testing/selftests/net/.gitignore
index 217d8b7a7365..59fe07ee2df9 100644
--- a/tools/testing/selftests/net/.gitignore
+++ b/tools/testing/selftests/net/.gitignore
@@ -19,6 +19,7 @@ log.txt
 msg_oob
 msg_zerocopy
 ncdevmem
+netlink-dumps
 nettest
 psock_fanout
 psock_snd
-- 
2.47.0


