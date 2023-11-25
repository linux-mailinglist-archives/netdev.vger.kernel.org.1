Return-Path: <netdev+bounces-51071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B415C7F8EA8
	for <lists+netdev@lfdr.de>; Sat, 25 Nov 2023 21:27:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E53531C20C8E
	for <lists+netdev@lfdr.de>; Sat, 25 Nov 2023 20:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1314430D0F;
	Sat, 25 Nov 2023 20:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siddh.me header.i=code@siddh.me header.b="aDWr574r"
X-Original-To: netdev@vger.kernel.org
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B582110;
	Sat, 25 Nov 2023 12:27:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1700943997; cv=none; 
	d=zohomail.in; s=zohoarc; 
	b=CG/6YhYXSiA5o5lvnsjgbz7aLpPRNl4YXm976la8f/2GIZvRCRzdhQb2f4dKW/TT/QNVQaG5auUOiW0MNHU3dIXOfP1xzLahWzQ1BGH6e1E9FL3uJ49uwfJXBNdeLJ3kLLZnfMgDO985BxpQQk6v95aS/gcjB0FniKVyYcaxTWU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
	t=1700943997; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=jokTckctzJGZx54kn2OoTfaUts6J5fPPiEFPTgkvFQU=; 
	b=P7LvR7B5qeEGzTC+VoxGb//U+UGwUXPt4R7tYkjO9TwhGl/uQAu87JPGOadm6DIYmqBzd8OG++Tv27oWUrCpVhihB0PbXC/s6qJ4lGOQK3y6lMMKGaMBUaOoM9qoMmWvqkqlMyeS083z02Z3eNVpVR+O1jqSK5+NzhFHoL2OLWg=
ARC-Authentication-Results: i=1; mx.zohomail.in;
	dkim=pass  header.i=siddh.me;
	spf=pass  smtp.mailfrom=code@siddh.me;
	dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1700943997;
	s=zmail; d=siddh.me; i=code@siddh.me;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=jokTckctzJGZx54kn2OoTfaUts6J5fPPiEFPTgkvFQU=;
	b=aDWr574rrke4JA3n2T/oeX65rRJaWiCazf5v/whS1uwzqo7U6qyXXk28tmoNPI9Q
	lpTlK02r6wV1f5BkhKTouF+Ae+DLCwPVn4EnNxOMh5plyBRoNAZLKFm59OPQUzOs5/E
	YacV251mdlRVJQx+A/bz0yu8+Q+5Ckxaw0nVbUK4=
Received: from kampyooter.. (110.226.61.26 [110.226.61.26]) by mx.zoho.in
	with SMTPS id 1700943996154743.8918060401706; Sun, 26 Nov 2023 01:56:36 +0530 (IST)
From: Siddh Raman Pant <code@siddh.me>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] nfc: llcp_sock_sendmsg: Reformat code to make the smaller block indented
Date: Sun, 26 Nov 2023 01:56:19 +0530
Message-ID: <f5e1fc8131923c50d08fa30eb7136f32ddafe37d.1700943019.git.code@siddh.me>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1700943019.git.code@siddh.me>
References: <cover.1700943019.git.code@siddh.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

The block for datagram sending is a significantly bigger chunk of the
function compared to the other scenario.

Thus, put the significantly smaller block inside the if-block.

Signed-off-by: Siddh Raman Pant <code@siddh.me>
---
 net/nfc/llcp_sock.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/net/nfc/llcp_sock.c b/net/nfc/llcp_sock.c
index 603f2219b62f..3f1a39e54aa1 100644
--- a/net/nfc/llcp_sock.c
+++ b/net/nfc/llcp_sock.c
@@ -795,34 +795,32 @@ static int llcp_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 		return -ENODEV;
 	}
 
-	if (sk->sk_type == SOCK_DGRAM) {
-		if (sk->sk_state != LLCP_BOUND) {
-			release_sock(sk);
-			return -ENOTCONN;
-		}
+	if (sk->sk_type != SOCK_DGRAM) {
+		release_sock(sk);
 
-		DECLARE_SOCKADDR(struct sockaddr_nfc_llcp *, addr,
-				 msg->msg_name);
+		if (sk->sk_state != LLCP_CONNECTED)
+			return -ENOTCONN;
 
-		if (msg->msg_namelen < sizeof(*addr)) {
-			release_sock(sk);
-			return -EINVAL;
-		}
+		return nfc_llcp_send_i_frame(llcp_sock, msg, len);
+	}
 
+	if (sk->sk_state != LLCP_BOUND) {
 		release_sock(sk);
-
-		return nfc_llcp_send_ui_frame(llcp_sock, addr->dsap, addr->ssap,
-					      msg, len);
+		return -ENOTCONN;
 	}
 
-	if (sk->sk_state != LLCP_CONNECTED) {
+	DECLARE_SOCKADDR(struct sockaddr_nfc_llcp *, addr, msg->msg_name);
+
+	if (msg->msg_namelen < sizeof(*addr)) {
 		release_sock(sk);
-		return -ENOTCONN;
+		return -EINVAL;
 	}
 
 	release_sock(sk);
 
-	return nfc_llcp_send_i_frame(llcp_sock, msg, len);
+	return nfc_llcp_send_ui_frame(llcp_sock, addr->dsap, addr->ssap,
+				      msg, len);
+
 }
 
 static int llcp_sock_recvmsg(struct socket *sock, struct msghdr *msg,
-- 
2.42.0


