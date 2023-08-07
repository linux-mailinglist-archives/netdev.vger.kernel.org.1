Return-Path: <netdev+bounces-24812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2660771C17
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 10:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C655281092
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 08:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C480C2FA;
	Mon,  7 Aug 2023 08:13:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5125251
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 08:13:07 +0000 (UTC)
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65B91BB
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 01:13:02 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 32B165C0076;
	Mon,  7 Aug 2023 04:12:58 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 07 Aug 2023 04:12:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=readahead.eu; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:sender:subject
	:subject:to:to; s=fm3; t=1691395978; x=1691482378; bh=hyZourhgIX
	irIeiQ0wnQVMZLY3cFIzDpFgvXj8si7Ls=; b=hEkU1ODZmJeeZ/9YL5p1W4zotA
	5wZIY1iBYuXNYQPFcBQXO+3riqsAvioRTsDvJ0W2svHa0gfpTzj9c5PLnExUQvc0
	K8x3NHfjCrysdETkry05vdwXjDTxBWKPclpgZbsJDKkpuVAY+qwwiAeWN7AOzw5+
	f6slrWH/eS0TVeeQSapdEyxy7ozBnG+iia7aO6HE2bPJR/XuItzPDSR6qlWIDFPV
	Do1Hani/mEH5acNNYx/wv8oVc7+nblWVQeMb2l33fwsQAOVzduLL9gE+JqRMIj00
	uATN/LVdfYl7kPVChMlPOdjR3PYg4GWbh1EJgJa6oFZErBaoqcFSkveXj31A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1691395978; x=1691482378; bh=hyZourhgIXirI
	eiQ0wnQVMZLY3cFIzDpFgvXj8si7Ls=; b=CvFyWWBNDs5caS66vra+j/H9IPvwa
	yDJ4CjkXoIU3XYbVR9kuUn/yg0I1wfPtsCPm4sWEdFQAP70oBPpH55g5o8oug7Hy
	WFholdLfOtm5xiYexPMil10Y4xrlOwjeNtf4dn1xm70oQRKDyCAgQywJReAnGVTx
	M1qSABRx+DOZrnAX9yUFmN9h+osEBR378UGzVuL/LEc+8EtMnfo47T68g1tN8eSM
	K0nWMFMXDhT+120LmaeQowZyZ9z/jyPVS6aw//XWVCcawIv/TWf9IRXLReJlPGEr
	qtZ5D9KHfZEYFJiI9FrewGKB6LjxK6AY6obW170i43Gs3jTfPDi9H3/Bg==
X-ME-Sender: <xms:iafQZErQffJVg92Iesxn_RXQuA2DdMe7uh7wTJjRX70lYXaY7Nm1ow>
    <xme:iafQZKpH4sD_A1omba3sZGBpjOefbazzCY6OcvO-qY-wNYBvWNAiatfrZ7wt6OO4a
    HCHJ9XIEWq8jEHaPyA>
X-ME-Received: <xmr:iafQZJOX0-AQ1iBG4NA2Y19n7Ap-hLKgCYgTxJhrU4LcJMVcOuhbPszo3Etn8cIEEJvk7aUK6A9G8eNxbjPj4hlzwfsf1fIZGzOctCxA4X5qUUntxvOwqUU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrledtucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepffgrvhhiugcutfhhvghi
    nhhssggvrhhguceouggrvhhiugesrhgvrggurghhvggrugdrvghuqeenucggtffrrghtth
    gvrhhnpeekiedvgeegheelleetudejjeehvdefvdeiieeivdetvedvjeehgfektefggfeg
    veenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegurg
    hvihgusehrvggruggrhhgvrggurdgvuh
X-ME-Proxy: <xmx:iafQZL4HrU68z7hnfkimDDI-EcFBb59MhEE147WZSZDeclY-xAjEaQ>
    <xmx:iafQZD7EDBhHy50w16dSF-NmAO3XCeTJKKwdcNLEqVwN1fJlnXaV7Q>
    <xmx:iafQZLjezeML6tnZ0AC_XQZC7yU2p3NDqzr-h0GPdu4Yc7UC7DZnfg>
    <xmx:iqfQZAvch1pCpmdMCYEcrY6X5957jsHQfFqO8kNAYO8WfTbG23hzWA>
Feedback-ID: id2994666:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Aug 2023 04:12:56 -0400 (EDT)
From: David Rheinsberg <david@readahead.eu>
To: netdev@vger.kernel.org
Cc: Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	Christian Brauner <brauner@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Stanislav Fomichev <sdf@google.com>,
	Luca Boccassi <bluca@debian.org>,
	Eric Dumazet <edumazet@google.com>,
	David Rheinsberg <david@readahead.eu>
Subject: [PATCH] net/unix: use consistent error code in SO_PEERPIDFD
Date: Mon,  7 Aug 2023 10:12:25 +0200
Message-ID: <20230807081225.816199-1-david@readahead.eu>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Change the new (unreleased) SO_PEERPIDFD sockopt to return ENODATA
rather than ESRCH if a socket type does not support remote peer-PID
queries.

Currently, SO_PEERPIDFD returns ESRCH when the socket in question is
not an AF_UNIX socket. This is quite unexpected, given that one would
assume ESRCH means the peer process already exited and thus cannot be
found. However, in that case the sockopt actually returns EINVAL (via
pidfd_prepare()). This is rather inconsistent with other syscalls, which
usually return ESRCH if a given PID refers to a non-existant process.

This changes SO_PEERPIDFD to return ENODATA instead. This is also what
SO_PEERGROUPS returns, and thus keeps a consistent behavior across
sockopts.

Note that this code is returned in 2 cases: First, if the socket type is
not AF_UNIX, and secondly if the socket was not yet connected. In both
cases ENODATA seems suitable.

Signed-off-by: David Rheinsberg <david@readahead.eu>
---
Hi!

The SO_PEERPIDFD sockopt has been queued for 6.5, so hopefully we can
get that in before the release?

Thanks
David

 net/core/sock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 6d4f28efe29a..732fc37a4771 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1778,7 +1778,7 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
 		spin_unlock(&sk->sk_peer_lock);
 
 		if (!peer_pid)
-			return -ESRCH;
+			return -ENODATA;
 
 		pidfd = pidfd_prepare(peer_pid, 0, &pidfd_file);
 		put_pid(peer_pid);
-- 
2.41.0


