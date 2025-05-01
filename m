Return-Path: <netdev+bounces-187188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E61AA5914
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 02:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A7921BA6236
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 00:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1393B19DF5F;
	Thu,  1 May 2025 00:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="gFqDjBOQ"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DD935893;
	Thu,  1 May 2025 00:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746059517; cv=none; b=beioNcYDMxydkDcR6ALbLsjGrAzjTSssrf1Sq4IN4JR2e7xGz4J8FbrEOaSL8ZLewK1Y6GdU5buRaEzCVGw5UpCmXG4keFM+zVKX0RCDJ/x1dRjN7aZ3eyLiNNcpxWBqvWJBCIJiMKiYZ19dhwjtGBYjhmQz6KhL+3xZy7lRM24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746059517; c=relaxed/simple;
	bh=2lveSxjfFkBq6zfkWnzSsFQ1wGsQtjRTg3Iba7lZMhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r+JswkUOW912YBj3r4cXOALkYV8gj/9Mkk1UQDlviUy/v/QykDl+F/IRjJgt/e48I85h38zuRZu7kjBsHgggrllpakftR9d6nq6C48NK4DXk+MUqQrh8kFKtcdJxtBH2OHAQlGABJIYtVbN6AcGqWYcwcuHglBcUIJM1qppF8AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=gFqDjBOQ; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=8UPzLciHp4xNWmOLyriQyNsSYRyqmykzSDKFvr9TTJ8=; b=gFqDjBOQvaE1VdoK
	2OmPz8yIXenxtzHX6LQ3JLtpqcvMKITw7W6NGBG6UKmRZ0QgPpsSBZUECgJQLOywHexJKRonobXUi
	x3UALqe6bAVfebU/HD9u+bW+WCIXhAnoaQwoKGMEhfDpoNs0l7DA+Y/MDDA17b5tMC+GshYB9Pdhb
	HiqRXaba9D1xXU7WmMXA/pVYhfLgSFrVrt62OnLtwzwcBCb20tnmcQ56vGI1YIeXpRBXT/s5JK75o
	3OztjZ6ZklnY/lwcvv7UIpqdjy9s4498AM9R7KAOP9zSkQytmtquv4BMKEtambv++2Gt/Mmq74NGo
	ApoZQTnxv1ByQ36S7A==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1uAHqC-000od7-2E;
	Thu, 01 May 2025 00:31:52 +0000
From: linux@treblig.org
To: kuba@kernel.org,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [RFC net-next] strparser: Remove unused strp_process
Date: Thu,  1 May 2025 01:31:50 +0100
Message-ID: <20250501003150.309583-1-linux@treblig.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

strp_process() was addded in 2017 in
commit bbb03029a899 ("strparser: Generalize strparser")

but never used.

Remove it.

....but, hmm I'm not sure how much other cleanup needs doing,
there's still a comment in strp_init() referencing strp_process
and it makes me think there might be other code handling the
'general mode' which strp_process seems to have been added for.

Suggestions?

Dave

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 Documentation/networking/strparser.rst | 12 ------------
 include/net/strparser.h                |  3 ---
 net/strparser/strparser.c              | 13 -------------
 3 files changed, 28 deletions(-)

diff --git a/Documentation/networking/strparser.rst b/Documentation/networking/strparser.rst
index 8dc6bb04c710..e7729915d7a1 100644
--- a/Documentation/networking/strparser.rst
+++ b/Documentation/networking/strparser.rst
@@ -81,18 +81,6 @@ Functions
 
      ::
 
-	int strp_process(struct strparser *strp, struct sk_buff *orig_skb,
-			 unsigned int orig_offset, size_t orig_len,
-			 size_t max_msg_size, long timeo)
-
-    strp_process is called in general mode for a stream parser to
-    parse an sk_buff. The number of bytes processed or a negative
-    error number is returned. Note that strp_process does not
-    consume the sk_buff. max_msg_size is maximum size the stream
-    parser will parse. timeo is timeout for completing a message.
-
-    ::
-
 	void strp_data_ready(struct strparser *strp);
 
     The upper layer calls strp_tcp_data_ready when data is ready on
diff --git a/include/net/strparser.h b/include/net/strparser.h
index 0ed73e364faa..cc64e9d8c9e9 100644
--- a/include/net/strparser.h
+++ b/include/net/strparser.h
@@ -163,8 +163,5 @@ void strp_check_rcv(struct strparser *strp);
 int strp_init(struct strparser *strp, struct sock *sk,
 	      const struct strp_callbacks *cb);
 void strp_data_ready(struct strparser *strp);
-int strp_process(struct strparser *strp, struct sk_buff *orig_skb,
-		 unsigned int orig_offset, size_t orig_len,
-		 size_t max_msg_size, long timeo);
 
 #endif /* __NET_STRPARSER_H_ */
diff --git a/net/strparser/strparser.c b/net/strparser/strparser.c
index d946bfb424c7..2cd9c39910a5 100644
--- a/net/strparser/strparser.c
+++ b/net/strparser/strparser.c
@@ -314,19 +314,6 @@ static int __strp_recv(read_descriptor_t *desc, struct sk_buff *orig_skb,
 	return eaten;
 }
 
-int strp_process(struct strparser *strp, struct sk_buff *orig_skb,
-		 unsigned int orig_offset, size_t orig_len,
-		 size_t max_msg_size, long timeo)
-{
-	read_descriptor_t desc; /* Dummy arg to strp_recv */
-
-	desc.arg.data = strp;
-
-	return __strp_recv(&desc, orig_skb, orig_offset, orig_len,
-			   max_msg_size, timeo);
-}
-EXPORT_SYMBOL_GPL(strp_process);
-
 static int strp_recv(read_descriptor_t *desc, struct sk_buff *orig_skb,
 		     unsigned int orig_offset, size_t orig_len)
 {
-- 
2.49.0


