Return-Path: <netdev+bounces-55548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F53780B3AE
	for <lists+netdev@lfdr.de>; Sat,  9 Dec 2023 11:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07A74281028
	for <lists+netdev@lfdr.de>; Sat,  9 Dec 2023 10:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206CE134A7;
	Sat,  9 Dec 2023 10:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siddh.me header.i=code@siddh.me header.b="lm9ZMG3d"
X-Original-To: netdev@vger.kernel.org
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6077171F;
	Sat,  9 Dec 2023 02:39:52 -0800 (PST)
Delivered-To: code@siddh.me
ARC-Seal: i=1; a=rsa-sha256; t=1702118382; cv=none; 
	d=zohomail.in; s=zohoarc; 
	b=AVrQ/ysMKMSAl5QtZnj9Z735CLkzpX4+J/HnIaqMQ0I6eMs1kT0XKLrfcoHq7cPcAPqOF4sz8HFkIRF3iFEfP2yZXhMPccx+iaWGxwq9HMW/BCDUJ7iCqHBv7pZYvl/zqbjLVLIUISlM8cyu5/5+RvjUNWLhMWA7jSqJxLL/AGw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
	t=1702118382; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=+bjE8y7qxzm5fd5c6hUxFUvplwzAKWfcAwdB+YAuia4=; 
	b=GZFWV36SJXa1vhgfFvL9kYArIfhLHjJaWtCPGx+90GXMcDUqgcFkgzU0ciY5Gm5TYJK7cznXmPrXP1MkAF47yR43qUWBtwpBI4ZpVphPMh+wZ9z9wez2KrLNbIzvN4NRd6FrvbRX9OIobZ1MiOBBWT9nPS/S9rJSdwbXwkfvW7w=
ARC-Authentication-Results: i=1; mx.zohomail.in;
	dkim=pass  header.i=siddh.me;
	spf=pass  smtp.mailfrom=code@siddh.me;
	dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1702118382;
	s=zmail; d=siddh.me; i=code@siddh.me;
	h=Message-ID:Date:Date:MIME-Version:To:To:Cc:Cc:References:Subject:Subject:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=+bjE8y7qxzm5fd5c6hUxFUvplwzAKWfcAwdB+YAuia4=;
	b=lm9ZMG3dVggEF83WY35kHidw0ZhPHEHsYho8f4ddADgr3ioKWYE5kApWFpty78BB
	4eYME6dBJ1DaANN4JUMTYrVkFCE1WEDn4N2lsgrl/IivupM0ubBcXK/NUxbAbrzXiaU
	b1Z/SLUXAf0vKeToU0syFTTCkpVZX4gkl0r8pl/I=
Received: from [192.168.1.12] (110.227.243.208 [110.227.243.208]) by mx.zoho.in
	with SMTPS id 1702118381370822.2200951610104; Sat, 9 Dec 2023 16:09:41 +0530 (IST)
Message-ID: <aa9e49a1-7450-4df4-8848-8b2b5a868c28@siddh.me>
Date: Sat, 9 Dec 2023 16:09:33 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: syzbot+bbe84a4010eeea00982d@syzkaller.appspotmail.com
Cc: code@siddh.me, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <0000000000003e8971060c110bcc@google.com>
Subject: Re: [syzbot] [net?] [nfc?] KASAN: slab-use-after-free Read in
 nfc_alloc_send_skb
Content-Language: en-US, en-GB, hi-IN
From: Siddh Raman Pant <code@siddh.me>
In-Reply-To: <0000000000003e8971060c110bcc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

Final test

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

---
 net/nfc/llcp_core.c | 55 ++++++++++++++++++++++++++++++++++-----------
 1 file changed, 42 insertions(+), 13 deletions(-)

diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index 1dac28136e6a..0ae89ab42aaa 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -145,6 +145,13 @@ static void nfc_llcp_socket_release(struct nfc_llcp_local *local, bool device,
 
 static struct nfc_llcp_local *nfc_llcp_local_get(struct nfc_llcp_local *local)
 {
+	/* Since using nfc_llcp_local may result in usage of nfc_dev, whenever
+	 * we hold a reference to local, we also need to hold a reference to
+	 * the device to avoid UAF.
+	 */
+	if (!nfc_get_device(local->dev->idx))
+		return NULL;
+
 	kref_get(&local->ref);
 
 	return local;
@@ -177,10 +184,18 @@ static void local_release(struct kref *ref)
 
 int nfc_llcp_local_put(struct nfc_llcp_local *local)
 {
+	struct nfc_dev *dev;
+	int ret;
+
 	if (local == NULL)
 		return 0;
 
-	return kref_put(&local->ref, local_release);
+	dev = local->dev;
+
+	ret = kref_put(&local->ref, local_release);
+	nfc_put_device(dev);
+
+	return ret;
 }
 
 static struct nfc_llcp_sock *nfc_llcp_sock_get(struct nfc_llcp_local *local,
@@ -930,9 +945,7 @@ static void nfc_llcp_recv_connect(struct nfc_llcp_local *local,
 
 	if (sk_acceptq_is_full(parent)) {
 		reason = LLCP_DM_REJ;
-		release_sock(&sock->sk);
-		sock_put(&sock->sk);
-		goto fail;
+		goto fail_put_sock;
 	}
 
 	if (sock->ssap == LLCP_SDP_UNBOUND) {
@@ -942,9 +955,7 @@ static void nfc_llcp_recv_connect(struct nfc_llcp_local *local,
 
 		if (ssap == LLCP_SAP_MAX) {
 			reason = LLCP_DM_REJ;
-			release_sock(&sock->sk);
-			sock_put(&sock->sk);
-			goto fail;
+			goto fail_put_sock;
 		}
 
 		sock->ssap = ssap;
@@ -953,14 +964,18 @@ static void nfc_llcp_recv_connect(struct nfc_llcp_local *local,
 	new_sk = nfc_llcp_sock_alloc(NULL, parent->sk_type, GFP_ATOMIC, 0);
 	if (new_sk == NULL) {
 		reason = LLCP_DM_REJ;
-		release_sock(&sock->sk);
-		sock_put(&sock->sk);
-		goto fail;
+		goto fail_put_sock;
 	}
 
 	new_sock = nfc_llcp_sock(new_sk);
-	new_sock->dev = local->dev;
+
 	new_sock->local = nfc_llcp_local_get(local);
+	if (!new_sock->local) {
+		reason = LLCP_DM_REJ;
+		goto fail_free_new_sock;
+	}
+
+	new_sock->dev = local->dev;
 	new_sock->rw = sock->rw;
 	new_sock->miux = sock->miux;
 	new_sock->nfc_protocol = sock->nfc_protocol;
@@ -1004,8 +1019,13 @@ static void nfc_llcp_recv_connect(struct nfc_llcp_local *local,
 
 	return;
 
+fail_free_new_sock:
+	sock_put(&new_sock->sk);
+	nfc_llcp_sock_free(new_sock);
+fail_put_sock:
+	release_sock(&sock->sk);
+	sock_put(&sock->sk);
 fail:
-	/* Send DM */
 	nfc_llcp_send_dm(local, dsap, ssap, reason);
 }
 
@@ -1597,7 +1617,16 @@ int nfc_llcp_register_device(struct nfc_dev *ndev)
 	if (local == NULL)
 		return -ENOMEM;
 
-	local->dev = ndev;
+	/* As we are going to initialize local's refcount, we need to get the
+	 * nfc_dev to avoid UAF, otherwise there is no point in continuing.
+	 * See nfc_llcp_local_get().
+	 */
+	local->dev = nfc_get_device(ndev->idx);
+	if (!local->dev) {
+		kfree(local);
+		return -ENODEV;
+	}
+
 	INIT_LIST_HEAD(&local->list);
 	kref_init(&local->ref);
 	mutex_init(&local->sdp_lock);
-- 
2.42.0


