Return-Path: <netdev+bounces-47337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C487E9C05
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 13:20:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B552B20987
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 12:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A8D1D555;
	Mon, 13 Nov 2023 12:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siddh.me header.i=code@siddh.me header.b="tm5d7jSd"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C9F1D524
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 12:19:50 +0000 (UTC)
X-Greylist: delayed 911 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 13 Nov 2023 04:19:44 PST
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF78170D;
	Mon, 13 Nov 2023 04:19:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1699877064; cv=none; 
	d=zohomail.in; s=zohoarc; 
	b=SQCvtP9L6Gofb2kXWWpU+Gx8CP2ODXod88MaVTkYRyAX9/CWJDgHjxg+qdOIHlJRo8I3rU3DrF0PtiE248WhDD1k6PpM566E1IFnz5DaORg9CiL53MAE67J7aU+uinI+r973gdxVaxpv8K1A2GagUVRu5r6FiWRyvWfnLG1QuAY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
	t=1699877064; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=fCPnlQ1oIbGsRjQxL/R8uS0w57mK9cMg7MlweP31T2M=; 
	b=IATuxHjHs2yI42oBpDNeKjv4niIYRSiHRZCTIamvYLr2OiK2G+l6iGj/xN+igsB7FZJ66ITMKxzmeexztn0Siz5BS+wu+d2y+ZDuvpO40so2T3qEoxvIjs0ixIM71Y0mdkI/6eQjNU3Imj6DqC7YrD9SkRuaoS7gVVL61qzFmtw=
ARC-Authentication-Results: i=1; mx.zohomail.in;
	dkim=pass  header.i=siddh.me;
	spf=pass  smtp.mailfrom=code@siddh.me;
	dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1699877064;
	s=zmail; d=siddh.me; i=code@siddh.me;
	h=Message-ID:Date:Date:MIME-Version:To:To:Cc:Cc:References:Subject:Subject:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=fCPnlQ1oIbGsRjQxL/R8uS0w57mK9cMg7MlweP31T2M=;
	b=tm5d7jSdSXW2f+JYh1W3cAn933UEQSIp6A9WtOUO8dm/S7j6sANaOS/JxipZWqCJ
	/nfiIzHs72cPAQ7VAP0jFR6Chdi4pRPmlNV43yFAxjLM2LI54LwC7sT7F2K2Z0rG9iN
	+KY8WAmrmHXxWI0jrPifNqFmXe/kUVVLf/PtQi7Y=
Received: from [192.168.1.11] (106.201.112.144 [106.201.112.144]) by mx.zoho.in
	with SMTPS id 1699877063063672.0281147764148; Mon, 13 Nov 2023 17:34:23 +0530 (IST)
Message-ID: <d9657547-fbd2-43cc-ba78-e1cf308eb954@siddh.me>
Date: Mon, 13 Nov 2023 17:34:21 +0530
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

diff --git a/net/nfc/llcp_sock.c b/net/nfc/llcp_sock.c
index 645677f84dba..bc97cd6971bd 100644
--- a/net/nfc/llcp_sock.c
+++ b/net/nfc/llcp_sock.c
@@ -795,6 +795,11 @@ static int llcp_sock_sendmsg(struct socket *sock, struct msghdr *msg,
                return -ENODEV;
        }
 
+       if (sk->sk_state != LLCP_CONNECTED) {
+               release_sock(sk);
+               return -ENOTCONN;
+       }
+
        if (sk->sk_type == SOCK_DGRAM) {
                DECLARE_SOCKADDR(struct sockaddr_nfc_llcp *, addr,
                                 msg->msg_name);
@@ -810,11 +815,6 @@ static int llcp_sock_sendmsg(struct socket *sock, struct msghdr *msg,
                                              msg, len);
        }
 
-       if (sk->sk_state != LLCP_CONNECTED) {
-               release_sock(sk);
-               return -ENOTCONN;
-       }
-
        release_sock(sk);
 
        return nfc_llcp_send_i_frame(llcp_sock, msg, len);

