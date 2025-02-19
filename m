Return-Path: <netdev+bounces-167925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3CAA3CDD5
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 00:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74F09177845
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 23:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13DD425EFB2;
	Wed, 19 Feb 2025 23:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L9uuL6pC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D5A25EF9E
	for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 23:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740009008; cv=none; b=bGSmv4Le7mIayBqWwJTtI6KVpCYcDtTdGzIVMnG39Ambrb8gMzUTPGtDPifAMMenJ8HDba24oIdMpR3G+Jg+MSq68BNIZ/3bK8EF12TuRk9P/hRvWE96wgXTZdRcVpyBVub56AeSh7mITGsryfCjJHyKboyV/FTLTYlfuTQmdj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740009008; c=relaxed/simple;
	bh=1hyPeEUQJOrUxdLW7+wOWF2R4EzxRYyTXbSZDA98AfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bGhPjLGTCpzhA3HfGBdSrcsTk8IditxTmgLd86Cc9VAkGJfPkF/z4Chjz3qPkwtubKgumOkUb8/zw29vqhgRpNveQJN0vatuhyklhZLdFPltWs2ic2KIVwZegGEj3iHQWHDmDRrBFjqZ885cdWwvy2xc/cBQ4Cju3Ev3zt7fcHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L9uuL6pC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7629DC4CEE0;
	Wed, 19 Feb 2025 23:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740009007;
	bh=1hyPeEUQJOrUxdLW7+wOWF2R4EzxRYyTXbSZDA98AfY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L9uuL6pC/pKvRZl6uqnUKrEMD+XgZncWpO4Gux34/0hMzG8lKbFSEjtkkQSpX0kkL
	 UnYRghxG1dLmrEvRYaHCF5jxsVcwTCPl52u9+mo3UAkO5a+LhZxfrEaXVBWHxGJbzl
	 hzvhIcP0iXB0uz9O9fChRFe1sHofaAMTkYjT+Qbzo9VJD0lrEgB9Xj7rmqJOo6U2IV
	 o5m1o3HiRAPj+BHJLm9WqGXEGjfd8IUnb0G3cnO9tWXA7w0a5k9E5U+S+5GLwBQtzC
	 K5jg1dm8TN3JkyzToL0EUCToFkKclhvuJatj+rHEQQ0+hLW8smC2Tmpo/MuOVaCQsn
	 Z3NSkMv2isO9Q==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	jdamato@fastly.com,
	stfomichev@gmail.com,
	petrm@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 3/7] selftests: drv-net: add missing new line in xdp_helper
Date: Wed, 19 Feb 2025 15:49:52 -0800
Message-ID: <20250219234956.520599-4-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219234956.520599-1-kuba@kernel.org>
References: <20250219234956.520599-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Kurt and Joe report missing new line at the end of Usage.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2: new
---
 tools/testing/selftests/drivers/net/xdp_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/xdp_helper.c b/tools/testing/selftests/drivers/net/xdp_helper.c
index cf06a88b830b..80f86c2fe1a5 100644
--- a/tools/testing/selftests/drivers/net/xdp_helper.c
+++ b/tools/testing/selftests/drivers/net/xdp_helper.c
@@ -35,7 +35,7 @@ int main(int argc, char **argv)
 	char byte;
 
 	if (argc != 3) {
-		fprintf(stderr, "Usage: %s ifindex queue_id", argv[0]);
+		fprintf(stderr, "Usage: %s ifindex queue_id\n", argv[0]);
 		return 1;
 	}
 
-- 
2.48.1


