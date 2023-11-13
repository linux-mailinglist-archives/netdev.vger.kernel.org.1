Return-Path: <netdev+bounces-47340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE897E9C52
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 13:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C8C81F20F10
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 12:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB421D527;
	Mon, 13 Nov 2023 12:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siddh.me header.i=code@siddh.me header.b="rswSdAN6"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170C61C6AE
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 12:43:58 +0000 (UTC)
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09762D4C;
	Mon, 13 Nov 2023 04:43:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1699879429; cv=none; 
	d=zohomail.in; s=zohoarc; 
	b=TpLi3oQ8GoTB+6ihVITYHXacVoLaOjMW0twqtUM9wcpQwvnjBXTgpog999BLmTt2NBjjinnTbDrd8PzE/WFwOvRtmATsjxI8cMVvQakAvlD7SrAh2JyRTgDr5ZP3X1wmwKT+wW2hCHdBmX5SyNPH/4VdVeuutONSNI1m6SX1yls=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
	t=1699879429; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=4k2Xe+Ff7V1rPH9Jsj0WdhLJ24+KPwWeKLtocVI3BUk=; 
	b=HdVvKYiM4BE6VcLBqULl4Rk2Yu81yOrtYHgjaBSV61StYigCbKXGP9sapxQGk9nFB844QTPH+C+zn4AbdK5ktAoqVUxp0EsMDkTdE15VSsC9eM9eyb2WHFzQZai/gbU8HTIprofduKFV++eGRcz/3sXyce1v7DUe2fOJaysU+Iw=
ARC-Authentication-Results: i=1; mx.zohomail.in;
	dkim=pass  header.i=siddh.me;
	spf=pass  smtp.mailfrom=code@siddh.me;
	dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1699879429;
	s=zmail; d=siddh.me; i=code@siddh.me;
	h=Message-ID:Date:Date:MIME-Version:To:To:Cc:Cc:References:Subject:Subject:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=4k2Xe+Ff7V1rPH9Jsj0WdhLJ24+KPwWeKLtocVI3BUk=;
	b=rswSdAN6gnFrMzOQt9vXNL/VRGbo5Jhve86IrtwUErDPoxAxkHFzEFDvAsDMFHYj
	SnpMmFVV414LvtBdxBGY4FIcJL3ThW0fZ46L5bD82i/4JwIPvn+Sr4I2v05fdFmZmzJ
	TRamIyHO3bN4E5dzSDhBDYsKxprw6APhssXo6ZIE=
Received: from [192.168.1.11] (106.201.112.144 [106.201.112.144]) by mx.zoho.in
	with SMTPS id 169987942777756.48529072906388; Mon, 13 Nov 2023 18:13:47 +0530 (IST)
Message-ID: <7d56a505-3093-4863-a7b1-9454ec6447ae@siddh.me>
Date: Mon, 13 Nov 2023 18:13:46 +0530
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
index 645677f84dba..ea0e6c85866d 100644
--- a/net/nfc/llcp_sock.c                                                                 
+++ b/net/nfc/llcp_sock.c
@@ -796,6 +796,11 @@ static int llcp_sock_sendmsg(struct socket *sock, struct msghdr *msg,
        }                               
                                                 
        if (sk->sk_type == SOCK_DGRAM) { 
+               if (sk->sk_state != LLCP_BOUND) {
+                       release_sock(sk);
+                       return -ENOLINK;
+               }                                                 
+                                               
                DECLARE_SOCKADDR(struct sockaddr_nfc_llcp *, addr,
                                 msg->msg_name);
 

