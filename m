Return-Path: <netdev+bounces-61553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F142E8243FA
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 15:41:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 220991C21CE8
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 14:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87A723741;
	Thu,  4 Jan 2024 14:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ah/1Vruy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5A422F1A
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 14:41:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04A0CC433C7;
	Thu,  4 Jan 2024 14:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704379281;
	bh=pZjUh+SdQFLeKPo8iz1xLcTWYidGjW8YDvuOPrqCkPU=;
	h=From:To:Cc:Subject:Date:From;
	b=Ah/1VruylrWNINq7hHS/YLVlu+bgoGo8PWsU8axIUQUxn9ZZRO5qgbSRYELWPZBNR
	 cHeMq8O5cpZUuyaUwc29HuyJ9EeUlLOrBZ5DCZDvE9Fi6ROTu2UlYUfl0s8x97Rubn
	 SUcw39HdunBdZGGriTK2c+qxiSvtyiAlPEAlyhXbogAnkWwPn6yrk/pO5NGplJJiPz
	 /WvCOXhNr/Zauv3rUmMZxaXcjRNbiR3mAUx/03b/14Zz1mXhuFIqDQNWG/q/6hun+C
	 wZooUNCLxPjYkRt+yQHlhqwcIwc0B4xD39ofayqOTtlTxP4/xEA5VTZ7EbPvC+TZ1F
	 HKuAYuNYEB7nA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	willemdebruijn.kernel@gmail.com
Subject: [PATCH net-next] net: fill in MODULE_DESCRIPTION() for AF_PACKET
Date: Thu,  4 Jan 2024 06:41:19 -0800
Message-ID: <20240104144119.1319055-1-kuba@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
Add description to net/packet/af_packet.c

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: willemdebruijn.kernel@gmail.com
---
 net/packet/af_packet.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 5f1757a32842..c9bbc2686690 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -4781,5 +4781,6 @@ static int __init packet_init(void)
 
 module_init(packet_init);
 module_exit(packet_exit);
+MODULE_DESCRIPTION("Packet socket support (AF_PACKET)");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_NETPROTO(PF_PACKET);
-- 
2.43.0


