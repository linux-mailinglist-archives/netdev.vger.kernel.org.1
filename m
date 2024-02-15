Return-Path: <netdev+bounces-72034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B221856416
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 14:12:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E7971F27B28
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 13:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FCFE12FF96;
	Thu, 15 Feb 2024 13:12:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from albert.telenet-ops.be (albert.telenet-ops.be [195.130.137.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFAA12FB17
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 13:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708002755; cv=none; b=L5xRdjKAepqaEgiSTDP6GM3joO++D6OjVin6E+DHLlsGSYkeWFwqblP+KJm2F1XdzswhFJ15WUX5p1JwQHqNYcxHFouxh258Vo+EzpGVbTf5V6r6bjQgGnKC0Au8qJBsaU7IFg2Q873TSxXGswCapTWy2h8IoTKXfiy8sDrcGuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708002755; c=relaxed/simple;
	bh=U/PG3zQXQ/kc1NLVZllKDbhYLsIvPRKZE8dAnhNuW/s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TmzUbcgRs8Q2xzq+ttslRTifAvZ3ivXvbicNV0v+DYMdRkpvzHIf3iiyOjT9H4R3YDyrDzF5N6U5FniA+4gXTqIsu4Rqxvr1T7V9OSNQr+1OpzMRzb8/eWkEhG/TbYmQJs/9fHKy0U45Xwid8oY7AYuRcVgfGRP3sYpjXESyrIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:ac52:3a54:2a84:d65a])
	by albert.telenet-ops.be with bizsmtp
	id nRCP2B0040LVNSS06RCPAP; Thu, 15 Feb 2024 14:12:23 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rabXD-000gyC-NR;
	Thu, 15 Feb 2024 14:12:23 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rabXL-00HZSw-2k;
	Thu, 15 Feb 2024 14:12:23 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH RESEND2 net-next] tcp: Spelling s/curcuit/circuit/
Date: Thu, 15 Feb 2024 14:12:21 +0100
Message-Id: <edf02e55949ac00329a6df72940cc2f5e8bec55e.1708002686.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a misspelling of "circuit".

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 net/ipv4/tcp_input.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 2d20edf652e6cb5e..dd2656b63c3942f9 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -1164,7 +1164,7 @@ static void tcp_count_delivered(struct tcp_sock *tp, u32 delivered,
  * L|R	1		- orig is lost, retransmit is in flight.
  * S|R  1		- orig reached receiver, retrans is still in flight.
  * (L|S|R is logically valid, it could occur when L|R is sacked,
- *  but it is equivalent to plain S and code short-curcuits it to S.
+ *  but it is equivalent to plain S and code short-circuits it to S.
  *  L|S is logically invalid, it would mean -1 packet in flight 8))
  *
  * These 6 states form finite state machine, controlled by the following events:
-- 
2.34.1


