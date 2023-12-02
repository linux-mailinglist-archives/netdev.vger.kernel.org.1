Return-Path: <netdev+bounces-53256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2B7801D30
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 15:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FC631F210FC
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 14:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0B218AF6;
	Sat,  2 Dec 2023 14:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siddh.me header.i=code@siddh.me header.b="HNDDikJn"
X-Original-To: netdev@vger.kernel.org
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E65539E;
	Sat,  2 Dec 2023 06:14:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1701526467; cv=none; 
	d=zohomail.in; s=zohoarc; 
	b=fDZSOFHCvt5IYr7cKeZ6LcJX7w/yNCwfjgWT8L9PPEPh2epj6UyTSCMszwYnDZJ0pMQv2YtVGdJS0HnBgzd5AasXHH2lvfEiGKZZBlg1xct0Yn5HuOAGfd6Ki5nU7nRAQKWmUnN5/x3Gqy7IKINmRrs45BjEgcSaSm7jD0/uJLY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
	t=1701526467; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=mfrxv6rAENfS2pZcQgiFWIIxox6pUjw/HvOmlXEpPU0=; 
	b=P62B31AmP/F47X8guQ+Q1Qm17pnGzaNUA08Gn/21h4gPAHynyxNQ/fgoCq6ySxq7bFUXZs8xbsDeNQQco9AHcaSMZNMM1Zi8IZKO41eP+VfG8mirL6sc6ipn4KvP33x2DJrBTW49Ks2xhFIVtspxfzU4MZowDDXiDe7A8AUzE8c=
ARC-Authentication-Results: i=1; mx.zohomail.in;
	dkim=pass  header.i=siddh.me;
	spf=pass  smtp.mailfrom=code@siddh.me;
	dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1701526467;
	s=zmail; d=siddh.me; i=code@siddh.me;
	h=Message-ID:Date:Date:MIME-Version:To:To:Cc:Cc:References:Subject:Subject:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=mfrxv6rAENfS2pZcQgiFWIIxox6pUjw/HvOmlXEpPU0=;
	b=HNDDikJnX7LmQ7DRAjQFN8AIM8sbcLBgluSXhheEHUyGnZZ5NLTZkqYOsLMjfhM8
	Mf3cIDqCBZI+sxQsCVUuoymhveYEs0o+PbmZc7x3xjxaj+7sA3RRzi4t2IijMq1rZgd
	fkZ49DpjKpJMJqH75RDoO6lWX9p1EDXV8ZzcIp9g=
Received: from [192.168.1.12] (122.170.35.155 [122.170.35.155]) by mx.zoho.in
	with SMTPS id 170152646527862.459403783952666; Sat, 2 Dec 2023 19:44:25 +0530 (IST)
Message-ID: <0642446f-ebd9-429a-a293-94840c765038@siddh.me>
Date: Sat, 2 Dec 2023 19:44:24 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: syzbot+bbe84a4010eeea00982d@syzkaller.appspotmail.com
Cc: davem@davemloft.net, edumazet@google.com, krzysztof.kozlowski@linaro.org,
 kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 pabeni@redhat.com, syzkaller-bugs@googlegroups.com
References: <000000000000cb112e0609b419d3@google.com>
Subject: Re: [syzbot] [net?] [nfc?] KASAN: slab-use-after-free Read in
 nfc_alloc_send_skb
Content-Language: en-US, en-GB, hi-IN
From: Siddh Raman Pant <code@siddh.me>
In-Reply-To: <000000000000cb112e0609b419d3@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git main

diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index 1dac28136e6a..e071cb15bce2 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -145,6 +145,12 @@ static void nfc_llcp_socket_release(struct nfc_llcp_local *local, bool device,
 
 static struct nfc_llcp_local *nfc_llcp_local_get(struct nfc_llcp_local *local)
 {
+	struct nfc_dev *d;
+
+	d = nfc_get_device(local->dev->idx);
+	if (!d)
+		return NULL;
+
 	kref_get(&local->ref);
 
 	return local;
@@ -180,6 +186,7 @@ int nfc_llcp_local_put(struct nfc_llcp_local *local)
 	if (local == NULL)
 		return 0;
 
+	nfc_put_device(local->dev);
 	return kref_put(&local->ref, local_release);
 }
 
@@ -959,8 +966,17 @@ static void nfc_llcp_recv_connect(struct nfc_llcp_local *local,
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
+		goto fail;
+	}
+
+	new_sock->dev = local->dev;
 	new_sock->rw = sock->rw;
 	new_sock->miux = sock->miux;
 	new_sock->nfc_protocol = sock->nfc_protocol;
@@ -1597,7 +1613,11 @@ int nfc_llcp_register_device(struct nfc_dev *ndev)
 	if (local == NULL)
 		return -ENOMEM;
 
-	local->dev = ndev;
+	/* Hold a reference to the device. */
+	local->dev = nfc_get_device(ndev->idx);
+	if (!local->dev)
+		return -ENODEV;
+
 	INIT_LIST_HEAD(&local->list);
 	kref_init(&local->ref);
 	mutex_init(&local->sdp_lock);

