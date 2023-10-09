Return-Path: <netdev+bounces-39070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 728417BDC1B
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 14:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C16728157E
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 12:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C885B9CA4B;
	Mon,  9 Oct 2023 12:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zjn5beZ5"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1225D199AA
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 12:33:26 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777D430D3
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 05:31:14 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a7b10c488cso581997b3.2
        for <netdev@vger.kernel.org>; Mon, 09 Oct 2023 05:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696854672; x=1697459472; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qWzKeUdCdTf7hwcKviMgumJsqEDX0Dpo3T2gahN3czY=;
        b=zjn5beZ5O/BtVfgAsmSiqQl379W1lLWaLLu4lZoQGUrC3v49cubatqogP/xcfGaA+p
         SAQvRxxhpnHV1deUuo/+cZMjDwI54xGzywYVC4/Opp3bvFR3cD2AXswnz08PZ8WUSZGZ
         YTA68vGwlLdJbn2t36Fvwtjr/aRK5+T0Hmd2M6hyT/pbCxUqbxvFLjXQ3E/Wlr1EvsQS
         kIZdg1eEKi1bW10XCxo5DUwSnDUBCd+GK6oVSWSNJ8ZOaOUWp5cuaW4j8UizG8xELAIO
         jXYBEB+QIlhQh3NtiAqLtnb2tuj08tmdi36PRk33FNuFuDNY0QrOGOSZyXqYdidEM80v
         i5NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696854672; x=1697459472;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qWzKeUdCdTf7hwcKviMgumJsqEDX0Dpo3T2gahN3czY=;
        b=dBKHc0KsIEbiZD1oUcbxEIBBCeY9WM0/AQg9ZL4ZUs+lJS5ywIK/tckF5AeWLNqQZJ
         QWkOQEq+qaJyhJdLzUaX8BuSiZcP0TSZ4F8WTfNcGq5hqCvpKLPv6M+/bacMyYC9vbS3
         kQ4T1VqWPn9kLc9oAqxbcIvZ4a2Ew9sFXta7ay+xtjnhwW0eBXYyZlBJRMH8GEAmoNbU
         D5hLV+xr3K5yhOJJptAZpjv56a+jZ9oEXObMgKxkr8F4KVKVdZEDIW78wNQd3YpEW7iC
         tzCGOAb8RuhCIzxTJD42Y5uDNaOjjf9S6AVyDFFzivdhbGz+osEBdaTpq9ZCo0fhuznd
         saRw==
X-Gm-Message-State: AOJu0YxOMA5EhBcqtZ5yY6hoHtCAXVbpVSGQzFzpYc0WPzxSFCGMH9sD
	9RAd61G0xQLmRCWRQr8H8HvEBxAxg4ndHA==
X-Google-Smtp-Source: AGHT+IEqGhCWQf1uL+GC8yN9hoW/23CslKPXxtX4Flsu9UQWrvDGT/jRZ2vpM/cIH1U1B273B2TMnS6bB5YO7A==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:a8c5:0:b0:59b:e1db:5633 with SMTP id
 f188-20020a81a8c5000000b0059be1db5633mr276491ywh.1.1696854672071; Mon, 09 Oct
 2023 05:31:12 -0700 (PDT)
Date: Mon,  9 Oct 2023 12:31:10 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Message-ID: <20231009123110.3735515-1-edumazet@google.com>
Subject: [PATCH net] net: nfc: fix races in nfc_llcp_sock_get() and nfc_llcp_sock_get_sn()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Sili Luo <rootlab@huawei.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Willy Tarreau <w@1wt.eu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Sili Luo reported a race in nfc_llcp_sock_get(), leading to UAF.

Getting a reference on the socket found in a lookup while
holding a lock should happen before releasing the lock.

nfc_llcp_sock_get_sn() has a similar problem.

Finally nfc_llcp_recv_snl() needs to make sure the socket
found by nfc_llcp_sock_from_sn() does not disappear.

Fixes: 8f50020ed9b8 ("NFC: LLCP late binding")
Reported-by: Sili Luo <rootlab@huawei.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Willy Tarreau <w@1wt.eu>
---
 net/nfc/llcp_core.c | 30 ++++++++++++------------------
 1 file changed, 12 insertions(+), 18 deletions(-)

diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index 6705bb895e23930fad97715214d7b6e56c8c2829..8df1d71a5c2d8cf6ef2dc8f4e2f66bde6a9f4eda 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -203,17 +203,13 @@ static struct nfc_llcp_sock *nfc_llcp_sock_get(struct nfc_llcp_local *local,
 
 		if (tmp_sock->ssap == ssap && tmp_sock->dsap == dsap) {
 			llcp_sock = tmp_sock;
+			sock_hold(&llcp_sock->sk);
 			break;
 		}
 	}
 
 	read_unlock(&local->sockets.lock);
 
-	if (llcp_sock == NULL)
-		return NULL;
-
-	sock_hold(&llcp_sock->sk);
-
 	return llcp_sock;
 }
 
@@ -346,7 +342,8 @@ static int nfc_llcp_wks_sap(const char *service_name, size_t service_name_len)
 
 static
 struct nfc_llcp_sock *nfc_llcp_sock_from_sn(struct nfc_llcp_local *local,
-					    const u8 *sn, size_t sn_len)
+					    const u8 *sn, size_t sn_len,
+					    bool needref)
 {
 	struct sock *sk;
 	struct nfc_llcp_sock *llcp_sock, *tmp_sock;
@@ -382,6 +379,8 @@ struct nfc_llcp_sock *nfc_llcp_sock_from_sn(struct nfc_llcp_local *local,
 
 		if (memcmp(sn, tmp_sock->service_name, sn_len) == 0) {
 			llcp_sock = tmp_sock;
+			if (needref)
+				sock_hold(&llcp_sock->sk);
 			break;
 		}
 	}
@@ -423,7 +422,8 @@ u8 nfc_llcp_get_sdp_ssap(struct nfc_llcp_local *local,
 		 * to this service name.
 		 */
 		if (nfc_llcp_sock_from_sn(local, sock->service_name,
-					  sock->service_name_len) != NULL) {
+					  sock->service_name_len,
+					  false) != NULL) {
 			mutex_unlock(&local->sdp_lock);
 
 			return LLCP_SAP_MAX;
@@ -824,16 +824,7 @@ static struct nfc_llcp_sock *nfc_llcp_connecting_sock_get(struct nfc_llcp_local
 static struct nfc_llcp_sock *nfc_llcp_sock_get_sn(struct nfc_llcp_local *local,
 						  const u8 *sn, size_t sn_len)
 {
-	struct nfc_llcp_sock *llcp_sock;
-
-	llcp_sock = nfc_llcp_sock_from_sn(local, sn, sn_len);
-
-	if (llcp_sock == NULL)
-		return NULL;
-
-	sock_hold(&llcp_sock->sk);
-
-	return llcp_sock;
+	return nfc_llcp_sock_from_sn(local, sn, sn_len, true);
 }
 
 static const u8 *nfc_llcp_connect_sn(const struct sk_buff *skb, size_t *sn_len)
@@ -1298,7 +1289,8 @@ static void nfc_llcp_recv_snl(struct nfc_llcp_local *local,
 			}
 
 			llcp_sock = nfc_llcp_sock_from_sn(local, service_name,
-							  service_name_len);
+							  service_name_len,
+							  true);
 			if (!llcp_sock) {
 				sap = 0;
 				goto add_snl;
@@ -1318,6 +1310,7 @@ static void nfc_llcp_recv_snl(struct nfc_llcp_local *local,
 
 				if (sap == LLCP_SAP_MAX) {
 					sap = 0;
+					nfc_llcp_sock_put(llcp_sock);
 					goto add_snl;
 				}
 
@@ -1335,6 +1328,7 @@ static void nfc_llcp_recv_snl(struct nfc_llcp_local *local,
 
 			pr_debug("%p %d\n", llcp_sock, sap);
 
+			nfc_llcp_sock_put(llcp_sock);
 add_snl:
 			sdp = nfc_llcp_build_sdres_tlv(tid, sap);
 			if (sdp == NULL)
-- 
2.42.0.609.gbb76f46606-goog


