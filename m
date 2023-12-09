Return-Path: <netdev+bounces-55541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 824DF80B380
	for <lists+netdev@lfdr.de>; Sat,  9 Dec 2023 10:56:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20CEF1F21084
	for <lists+netdev@lfdr.de>; Sat,  9 Dec 2023 09:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F09711706;
	Sat,  9 Dec 2023 09:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siddh.me header.i=code@siddh.me header.b="FSqRrD+7"
X-Original-To: netdev@vger.kernel.org
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC1510C9;
	Sat,  9 Dec 2023 01:56:02 -0800 (PST)
Delivered-To: code@siddh.me
ARC-Seal: i=1; a=rsa-sha256; t=1702115753; cv=none; 
	d=zohomail.in; s=zohoarc; 
	b=XY/yaV5lb+3OXJD4pU8Rm7f+kaN0Lh9toMM6J5lAE0SA08LJ+cUMsTyfkgJSLIAKLJHGE/EeTrhDsA/rtpn9Qf3PDjXR5I9mxSYjEFwI5S93peKJeCNtIWz3APBEbJCxuN5HIuCXGC+tv+2kJzzY0XUdjntGzp+pkdaZroN9kyg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
	t=1702115753; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=2IXo6alLjcnIx1dYx/b8GP8NE9n+wd4wzqxMIrPefCc=; 
	b=Nu6z4GehLgsvSFF5MDuQcfWm/WNQ2qKhO6Z+AbofA5HExS8SQoGPrksq0tfDNfuVGiLXeIUYiOhqCc/E03dGn1dO0ej4O2P3bfizsR8bWTT1Yz3kMuUHd+lBEyWMqkkmWq8zmjpLLEv2jQAG6QMTbAYwtErHkIdpQVjwuVInCOs=
ARC-Authentication-Results: i=1; mx.zohomail.in;
	dkim=pass  header.i=siddh.me;
	spf=pass  smtp.mailfrom=code@siddh.me;
	dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1702115753;
	s=zmail; d=siddh.me; i=code@siddh.me;
	h=Message-ID:Date:Date:MIME-Version:To:To:Cc:Cc:References:Subject:Subject:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=2IXo6alLjcnIx1dYx/b8GP8NE9n+wd4wzqxMIrPefCc=;
	b=FSqRrD+7hjkVkd/M9ln8lEaJ8u6CB0LoXAS520pCsxx+7Y1kue7ayITGs3iNnR6L
	mDz80QM0GKto9pdlZzt0v8+0ohz0fDyOPQubPFRes6vL+iujtMkV7Jk9qP360yAEuk7
	X+fbCwQBto+tTcSf5nK0wFZ+T3fOjg8Fmtvm73zc=
Received: from [192.168.1.12] (110.227.243.208 [110.227.243.208]) by mx.zoho.in
	with SMTPS id 1702115750522569.3699110264844; Sat, 9 Dec 2023 15:25:50 +0530 (IST)
Message-ID: <f8bda66b-bb17-4bf8-b97a-4f7f0788d28f@siddh.me>
Date: Sat, 9 Dec 2023 15:25:44 +0530
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
References: <000000000000899a64060c108a26@google.com>
Subject: Re: [syzbot] [net?] [nfc?] KASAN: slab-use-after-free Read in
 nfc_alloc_send_skb
Content-Language: en-US, en-GB, hi-IN
From: Siddh Raman Pant <code@siddh.me>
In-Reply-To: <000000000000899a64060c108a26@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

Build failing on net-next. Test on mainline.

It's okay because the nfc commits are the same.

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

---
 net/nfc/llcp_core.c | 40 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index 1dac28136e6a..fadc8a9ec4df 100644
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
@@ -959,8 +974,18 @@ static void nfc_llcp_recv_connect(struct nfc_llcp_local *local,
 	}
 
 	new_sock = nfc_llcp_sock(new_sk);
-	new_sock->dev = local->dev;
+
 	new_sock->local = nfc_llcp_local_get(local);
+	if (!new_sock->local) {
+		reason = LLCP_DM_REJ;
+		release_sock(&sock->sk);
+		sock_put(&sock->sk);
+		sock_put(&new_sock->sk);
+		nfc_llcp_sock_free(new_sock);
+		goto fail;
+	}
+
+	new_sock->dev = local->dev;
 	new_sock->rw = sock->rw;
 	new_sock->miux = sock->miux;
 	new_sock->nfc_protocol = sock->nfc_protocol;
@@ -1597,7 +1622,16 @@ int nfc_llcp_register_device(struct nfc_dev *ndev)
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

