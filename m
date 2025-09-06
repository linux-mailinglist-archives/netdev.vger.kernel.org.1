Return-Path: <netdev+bounces-220534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4733EB467F6
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 03:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B9063A8DFD
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 01:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A46E17A2E1;
	Sat,  6 Sep 2025 01:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=templeofstupid.com header.i=@templeofstupid.com header.b="XB2QLy1l"
X-Original-To: netdev@vger.kernel.org
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9AC18E3F
	for <netdev@vger.kernel.org>; Sat,  6 Sep 2025 01:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.212.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757121742; cv=pass; b=JRpwUc3XyjU1AwuKPip3qr3BpqcuNy1SkpkXTkXFZaGy1doHH/rj9nLZLWR0xqj8m/JbQFoaeTFJyZpZgF4yjlcAdHYhtOioGtPPCSmw+tDcnW25y8dUj1tuU5dgxyW1bwmpdfJSBleWer/hxC0iL4yHNvJO7gB6GAcod5h4MqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757121742; c=relaxed/simple;
	bh=WvVgPknsoh+orVwJyLL8s+U0TpN7DdgUwGDzywQz9lI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=iVE1rQdeqGJhrN972VreKkptZ5TNEl6zLhtNKVB+jglshinuIjvjr4ZgoXF92XjjtcQmvQb8AJBj873RaHPCar6Xt/tGXoa2I72JZP6FBfM1EU27WYZhlMb0pJHU2zj8MAByHbWx+VBSVHKDsOFuZn0viH6p44v3J+zyJDHMC90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=templeofstupid.com; spf=pass smtp.mailfrom=templeofstupid.com; dkim=pass (2048-bit key) header.d=templeofstupid.com header.i=@templeofstupid.com header.b=XB2QLy1l; arc=pass smtp.client-ip=23.83.212.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=templeofstupid.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id BEA1922A2B
	for <netdev@vger.kernel.org>; Sat,  6 Sep 2025 00:43:06 +0000 (UTC)
Received: from pdx1-sub0-mail-a309.dreamhost.com (100-102-209-228.trex-nlb.outbound.svc.cluster.local [100.102.209.228])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 6B99222B12
	for <netdev@vger.kernel.org>; Sat,  6 Sep 2025 00:43:06 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1757119386; a=rsa-sha256;
	cv=none;
	b=6b1JJk4lTTfiLNVl79eEklxmbE6vOZPSVMDVoF3eo2ageveiG2SlownaeK+Y471zPjLfTD
	6GCW8UtZhOSUmMX6Qoh7VMnYUcpsFPyqGVjGFMkGVYoMm60BDU/KcY1Ehm+IJ1KDVCZa8O
	yhpBItSHp0IWjRSDkscoSXL1o5TqHJBgVGxtdh9AXvPqrIkNBuz04ceGNh/YHxb/BPASai
	MagzJIrHFEt8ps44x7hpld7PbXSlZjm5jpCTkT5HnywhA10jmDhZtKR+e5f6Gxd10LOqT+
	vf2sIamk6MTRS3x/Lm1pjnqxeAFvcNnt2ZOrxukcezjw0eoXFa+TxF74s6g2sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1757119386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 dkim-signature; bh=djnk/mvzW8JgrM/aEd1q2IUDriPKm9TV+QHUIYoTH20=;
	b=sGRJEAFQuyrwJntkdcumAev3+8TbfmxVGIl0AD4w3d9FfcLrFdD0eSxMZ/VIdGOWOz9kbj
	YVpLlmXuARlcOw0G2mBAeymfNH81am75AQo+uMgVienwAhhBJs2NippDZnjonDRCYHYYy6
	s720LoadMZbFC6FdhU904jsYsHJQcJNmwgBrdOHMGrSsYfpYzbgULXtGuuQnd4a9mkQRA/
	9FbX+O+qMfa574TBT0c7JbJPJnJI2WcU6CRLumnbUmSpQw6pwD7PdxPDlpOrQpoWQ/9Oxu
	ocF/kG3q1tsXxNGRIhKCflhOslFY/oRtg8dUYq03Hb/cC9W95QwKes7v+X6LXA==
ARC-Authentication-Results: i=1;
	rspamd-8b9589799-l9c74;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Unite-Abiding: 1e6a11da43845b20_1757119386661_3554539585
X-MC-Loop-Signature: 1757119386661:4157567128
X-MC-Ingress-Time: 1757119386661
Received: from pdx1-sub0-mail-a309.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.102.209.228 (trex/7.1.3);
	Sat, 06 Sep 2025 00:43:06 +0000
Received: from kmjvbox.templeofstupid.com (c-73-70-109-47.hsd1.ca.comcast.net [73.70.109.47])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kjlx@templeofstupid.com)
	by pdx1-sub0-mail-a309.dreamhost.com (Postfix) with ESMTPSA id 4cJZFQ1BLhzDF
	for <netdev@vger.kernel.org>; Fri,  5 Sep 2025 17:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
	s=dreamhost; t=1757119386;
	bh=djnk/mvzW8JgrM/aEd1q2IUDriPKm9TV+QHUIYoTH20=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=XB2QLy1lI69MOFqrWqLt9AYDTmRyy4IBOWUwpOy/x7TlRaI+g5Zmxj616mJW6T5xe
	 Z6doqS0rSho/av0HBz5NBXN/A3UXpUxMSX4Sxi8C0Y4wxF/9ieMsOFszG2U9pVj913
	 1r7bv4NOnzWMsmjAYJ7T1v5E0WNX+Etj4beMrnZzALWJbisphxxbzGcSCZMWrWcP2l
	 YkA12D8sgwqu6eVfWf4PNO6mDrn6Gc87drJfZ5ENwV2N/1jKFMCLmgTFOz+1dDqzfz
	 1FW8/qT18xDfYbkONV5qNXK0T6QS0MkIjW0gjVDQYkNvXkn2NbuDJfPQXAuo8++RVQ
	 L7iid3XT5Y9Rw==
Received: from johansen (uid 1000)
	(envelope-from kjlx@templeofstupid.com)
	id e0263
	by kmjvbox.templeofstupid.com (DragonFly Mail Agent v0.13);
	Fri, 05 Sep 2025 17:43:04 -0700
Date: Fri, 5 Sep 2025 17:43:04 -0700
From: Krister Johansen <kjlx@templeofstupid.com>
To: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>
Cc: Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>,
	netdev@vger.kernel.org, mptcp@lists.linux.dev,
	linux-kernel@vger.kernel.org, David Reaver <me@davidreaver.com>
Subject: [PATCH mptcp] mptcp: sockopt: make sync_socket_options propagate
 SOCK_KEEPOPEN
Message-ID: <aLuDmBsgC7wVNV1J@templeofstupid.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Users reported a scenario where MPTCP connections that were configured
with SO_KEEPALIVE prior to connect would fail to enable their keepalives
if MTPCP fell back to TCP mode.

After investigating, this affects keepalives for any connection where
sync_socket_options is called on a socket that is in the closed or
listening state.  Joins are handled properly. For connects,
sync_socket_options is called when the socket is still in the closed
state.  The tcp_set_keepalive() function does not act on sockets that
are closed or listening, hence keepalive is not immediately enabled.
Since the SO_KEEPOPEN flag is absent, it is not enabled later in the
connect sequence via tcp_finish_connect.  Setting the keepalive via
sockopt after connect does work, but would not address any subsequently
created flows.

Fortunately, the fix here is straight-forward: set SOCK_KEEPOPEN on the
subflow when calling sync_socket_options.

The fix was valdidated both by using tcpdump to observe keeplaive
packets not being sent before the fix, and being sent after the fix.  It
was also possible to observe via ss that the keepalive timer was not
enabled on these sockets before the fix, but was enabled afterwards.

Fixes: 1b3e7ede1365 ("mptcp: setsockopt: handle SO_KEEPALIVE and SO_PRIORITY")
Cc: stable@vger.kernel.org
Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
---
 net/mptcp/sockopt.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 2c267aff95be..13108e9f982b 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -1532,13 +1532,11 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 {
 	static const unsigned int tx_rx_locks = SOCK_RCVBUF_LOCK | SOCK_SNDBUF_LOCK;
 	struct sock *sk = (struct sock *)msk;
+	int kaval = !!sock_flag(sk, SOCK_KEEPOPEN);
 
-	if (ssk->sk_prot->keepalive) {
-		if (sock_flag(sk, SOCK_KEEPOPEN))
-			ssk->sk_prot->keepalive(ssk, 1);
-		else
-			ssk->sk_prot->keepalive(ssk, 0);
-	}
+	if (ssk->sk_prot->keepalive)
+		ssk->sk_prot->keepalive(ssk, kaval);
+	sock_valbool_flag(ssk, SOCK_KEEPOPEN, kaval);
 
 	ssk->sk_priority = sk->sk_priority;
 	ssk->sk_bound_dev_if = sk->sk_bound_dev_if;

base-commit: 319f7385f22c85618235ab0169b80092fa3c7696
-- 
2.43.0


