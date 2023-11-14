Return-Path: <netdev+bounces-47688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2976B7EAF9F
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 13:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1A2D1F2389F
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 12:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE7B3D984;
	Tue, 14 Nov 2023 12:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siddh.me header.i=code@siddh.me header.b="QiTqiAeT"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA483A28E
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 12:06:47 +0000 (UTC)
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C7FF1;
	Tue, 14 Nov 2023 04:06:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1699963593; cv=none; 
	d=zohomail.in; s=zohoarc; 
	b=QRiZ0ovh7eNv3NVE9cFBIjepjH+y2iEhgs2VFfsJI+y+GvfkMvDH3FV3/kEPkzr1dcofnhyXlD2grZpxVRRY2NBMzH0NoxjYZDUbOpiVAtR1TExxWtSpK8DhOMRoyCGxNtVqTTigfAujkLASEzH/3p1oEH99jULySt8M1IIVGac=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
	t=1699963593; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=T4rNGeLByRlCebNC4mv6V/yHuowhMU4zziKayPFdTiE=; 
	b=H3RHCjwewdZnogcWkC2fpLbJfxQrcdM+Wsq2VToczthSAfUCzQk6VqxakucJbff3092QYWpv1cgSqI3rJoaJonK5imRqHvdoM1x0KEROzii2gbiHHZXb8LBxabDyC3lLRd6yhfyPUCiZyWwg8nM3yFgN3o51YrEyHqQY4KL4xvA=
ARC-Authentication-Results: i=1; mx.zohomail.in;
	dkim=pass  header.i=siddh.me;
	spf=pass  smtp.mailfrom=code@siddh.me;
	dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1699963593;
	s=zmail; d=siddh.me; i=code@siddh.me;
	h=Message-ID:Date:Date:MIME-Version:To:To:Cc:Cc:References:Subject:Subject:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=T4rNGeLByRlCebNC4mv6V/yHuowhMU4zziKayPFdTiE=;
	b=QiTqiAeTWzfy+kAbVtuZQgouw+bKgwAUKoDOysuvp7WEVI7OWEDeUfV/p7DEQrgk
	3Qf2ynFkgu7wOEfVOlKF2TnOi6KmIIXt9JN0W9tWa76JR2mOkDqf5grWtiPVvrR9S5e
	ElNBdIlheRUBHoHSGP8Z7ty7eNmuGq7B7p1Kv+Rk=
Received: from [192.168.1.11] (106.201.112.144 [106.201.112.144]) by mx.zoho.in
	with SMTPS id 1699963591183647.2368112754372; Tue, 14 Nov 2023 17:36:31 +0530 (IST)
Message-ID: <3df56245-d104-4ce2-ab88-0fb1d29cd629@siddh.me>
Date: Tue, 14 Nov 2023 17:36:27 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: syzbot+bbe84a4010eeea00982d@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <000000000000cb112e0609b419d3@google.com>
Subject: Re: [syzbot] [net?] [nfc?] KASAN: slab-use-after-free Read in
 nfc_alloc_send_skb
Content-Language: en-US, en-GB, hi-IN
From: Siddh Raman Pant <code@siddh.me>
In-Reply-To: <000000000000cb112e0609b419d3@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

---
 net/nfc/llcp_sock.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/net/nfc/llcp_sock.c b/net/nfc/llcp_sock.c
index 645677f84dba..699f7f6cc0b8 100644
--- a/net/nfc/llcp_sock.c
+++ b/net/nfc/llcp_sock.c
@@ -791,33 +791,39 @@ static int llcp_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 	lock_sock(sk);
 
 	if (!llcp_sock->local) {
-		release_sock(sk);
-		return -ENODEV;
+		ret = -ENODEV;
+		goto out;
 	}
 
 	if (sk->sk_type == SOCK_DGRAM) {
+		if (sk->sk_state != LLCP_BOUND) {
+			ret = -ENOLINK;
+			goto out;
+		}
+
 		DECLARE_SOCKADDR(struct sockaddr_nfc_llcp *, addr,
 				 msg->msg_name);
 
 		if (msg->msg_namelen < sizeof(*addr)) {
-			release_sock(sk);
-			return -EINVAL;
+			ret = -EINVAL;
+			goto out;
 		}
 
-		release_sock(sk);
-
-		return nfc_llcp_send_ui_frame(llcp_sock, addr->dsap, addr->ssap,
-					      msg, len);
+		ret = nfc_llcp_send_ui_frame(llcp_sock, addr->dsap, addr->ssap,
+					     msg, len);
+		goto out;
 	}
 
 	if (sk->sk_state != LLCP_CONNECTED) {
-		release_sock(sk);
-		return -ENOTCONN;
+		ret = -ENOTCONN;
+		goto out;
 	}
 
-	release_sock(sk);
+	ret = nfc_llcp_send_i_frame(llcp_sock, msg, len);
 
-	return nfc_llcp_send_i_frame(llcp_sock, msg, len);
+out:
+	release_sock(sk);
+	return ret;
 }
 
 static int llcp_sock_recvmsg(struct socket *sock, struct msghdr *msg,
-- 
2.42.0

