Return-Path: <netdev+bounces-26317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C6E77783B
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 14:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92B581C213B6
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 12:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35B61FB35;
	Thu, 10 Aug 2023 12:25:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B21A442C
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 12:25:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40B8FC433C7;
	Thu, 10 Aug 2023 12:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691670342;
	bh=OloAD6QmGKnXstqvq00Y+1wIzRiY4JGxfjab4MiA+Yo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UCUG+UaKbFVMZ9rgnD2AroLE1C9PsQ8Q1mvArgMkR/ncOGxxpBmvZ2n55P2acCo+v
	 rBlTdyWGsxBjjTwfPMv7TdJpnM9bqYSBI6I19btGwMDjXaNy6gzwdC3HMhPb2hB3Uh
	 3TRtdzVVIwWLO+6cz8EJRN95g8zzhn5A4ckz1abhvlZjSS6N725Xo9dch1PNvke7v2
	 rJwNyEPg/+fdgzCVxyNi9f7xkqaNvDo3Cz8Xrgr0GGCXssSaIjdnDm0fVm215fSvy4
	 3864eGhUBbvDZ4I9ivPs0llLT5X1c5KREGx3hi1kD/C6vTyMlnja8v6a1EiGz2DNwN
	 AJlljoPSntnHA==
From: Arnd Bergmann <arnd@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Haoyue Xu <xuhaoyue1@hisilicon.com>,
	Guofeng Yue <yueguofeng@hisilicon.com>,
	Yang Yingliang <yangyingliang@huawei.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ethernet: atarilance: mark init function static
Date: Thu, 10 Aug 2023 14:25:16 +0200
Message-Id: <20230810122528.1220434-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230810122528.1220434-1-arnd@kernel.org>
References: <20230810122528.1220434-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The init function is only referenced locally, so it should be static to
avoid this warning:

drivers/net/ethernet/amd/atarilance.c:370:28: error: no previous prototype for 'atarilance_probe' [-Werror=missing-prototypes]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/amd/atarilance.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/amd/atarilance.c b/drivers/net/ethernet/amd/atarilance.c
index ec704222925d8..751454d305c64 100644
--- a/drivers/net/ethernet/amd/atarilance.c
+++ b/drivers/net/ethernet/amd/atarilance.c
@@ -367,7 +367,7 @@ static void *slow_memcpy( void *dst, const void *src, size_t len )
 }
 
 
-struct net_device * __init atarilance_probe(void)
+static struct net_device * __init atarilance_probe(void)
 {
 	int i;
 	static int found;
-- 
2.39.2


