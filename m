Return-Path: <netdev+bounces-116333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7318594A121
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 08:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2770A28C301
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 06:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853351B8E86;
	Wed,  7 Aug 2024 06:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="OAtTZLMS"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C6D1AE053;
	Wed,  7 Aug 2024 06:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723013696; cv=none; b=jD965OXrLRsAMPnm/i4FHyeVG19rxQ8poOAQFzDoH3tzyoNqLmgZMKi7cqcEzW5nmEPQiHKGC7ERVBLs2fVlDiBfsoy9LcwFCgcKlrWL3drMICIEPkD8hWXiO1lntdPiF5Kk4xTkyrhSUp5AibZ71q3lP5nFZtNYzPUkozwFQnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723013696; c=relaxed/simple;
	bh=rJihW7s0aR3nFcHimb6+9buZbnbwryWRRMNLHo29uT8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gBVJ7hBxEiwmyzOALUlXLtUYnWnk6gGuDCft1e9mtGgpx8Q+H/1753oQ6/ZAHnRix1/HG3I4RJBCoZpyWXwnVkIqiE6XZhFmIMajZxfbWiZgT9kGXlT6jpCU+dL7hO9rja8fSuE5VGwPP80AJJo8Z5pu3jUpv22ohi3DamwzPTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=OAtTZLMS; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from katalix.com (unknown [IPv6:2a02:8010:6359:1:9ea4:d72e:1b25:b4bf])
	(Authenticated sender: james)
	by mail.katalix.com (Postfix) with ESMTPSA id 98C397DCC2;
	Wed,  7 Aug 2024 07:54:53 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1723013693; bh=rJihW7s0aR3nFcHimb6+9buZbnbwryWRRMNLHo29uT8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:From;
	z=From:=20James=20Chapman=20<jchapman@katalix.com>|To:=20netdev@vge
	 r.kernel.org|Cc:=20davem@davemloft.net,=0D=0A=09edumazet@google.co
	 m,=0D=0A=09kuba@kernel.org,=0D=0A=09pabeni@redhat.com,=0D=0A=09dsa
	 hern@kernel.org,=0D=0A=09tparkin@katalix.com,=0D=0A=09horms@kernel
	 .org,=0D=0A=09linux-doc@vger.kernel.org,=0D=0A=09corbet@lwn.net|Su
	 bject:=20[PATCH=20v2=20net-next=201/9]=20documentation/networking:
	 =20update=20l2tp=20docs|Date:=20Wed,=20=207=20Aug=202024=2007:54:4
	 4=20+0100|Message-Id:=20<a577532abc2c9eb85e4934fd2b85c50251f5e5bf.
	 1723011569.git.jchapman@katalix.com>|In-Reply-To:=20<cover.1723011
	 569.git.jchapman@katalix.com>|References:=20<cover.1723011569.git.
	 jchapman@katalix.com>|MIME-Version:=201.0;
	b=OAtTZLMS9+A4BOWeW+x+O88hbAlvfyNqb8Ga+2rMzXdsro/ojCnNPA5Op+Vo0y8l/
	 svcynA/jT936XAhm8B7A0Pvdh8KTkfAIIL/aopQ1St0XoZ4QNinhReAzYW4cpayMyM
	 VOEqJWPdv4olO+OIQ3YgJRQXnjE2mHn25Ir/30P0J/f1S++0An8tI23eDc779k0o8j
	 txzIVFksu3j1V+E0bCIPqlbW/jIegkrxmbOsgezeqp3dfDN5w4LsUNr2NVGoaR7Lci
	 9PTGskPX1XlBCpHVWmPhiFn4aTS4OeSs4iOW7NlouH4mgXK5P0uksPme+u6Cho7n+0
	 ivqx8lGrUjS2g==
From: James Chapman <jchapman@katalix.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	tparkin@katalix.com,
	horms@kernel.org,
	linux-doc@vger.kernel.org,
	corbet@lwn.net
Subject: [PATCH v2 net-next 1/9] documentation/networking: update l2tp docs
Date: Wed,  7 Aug 2024 07:54:44 +0100
Message-Id: <a577532abc2c9eb85e4934fd2b85c50251f5e5bf.1723011569.git.jchapman@katalix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1723011569.git.jchapman@katalix.com>
References: <cover.1723011569.git.jchapman@katalix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

l2tp no longer uses sk_user_data in tunnel sockets and now manages
tunnel/session lifetimes slightly differently. Update docs to cover
this.

CC: linux-doc@vger.kernel.org
CC: corbet@lwn.net
Signed-off-by: James Chapman <jchapman@katalix.com>
Signed-off-by: Tom Parkin <tparkin@katalix.com>
---
 Documentation/networking/l2tp.rst | 54 ++++++++++++-------------------
 1 file changed, 20 insertions(+), 34 deletions(-)

diff --git a/Documentation/networking/l2tp.rst b/Documentation/networking/l2tp.rst
index 8496b467dea4..e8cf8b3e60ac 100644
--- a/Documentation/networking/l2tp.rst
+++ b/Documentation/networking/l2tp.rst
@@ -638,9 +638,8 @@ Tunnels are identified by a unique tunnel id. The id is 16-bit for
 L2TPv2 and 32-bit for L2TPv3. Internally, the id is stored as a 32-bit
 value.
 
-Tunnels are kept in a per-net list, indexed by tunnel id. The tunnel
-id namespace is shared by L2TPv2 and L2TPv3. The tunnel context can be
-derived from the socket's sk_user_data.
+Tunnels are kept in a per-net list, indexed by tunnel id. The
+tunnel id namespace is shared by L2TPv2 and L2TPv3.
 
 Handling tunnel socket close is perhaps the most tricky part of the
 L2TP implementation. If userspace closes a tunnel socket, the L2TP
@@ -652,9 +651,7 @@ socket's encap_destroy handler is invoked, which L2TP uses to initiate
 its tunnel close actions. For L2TPIP sockets, the socket's close
 handler initiates the same tunnel close actions. All sessions are
 first closed. Each session drops its tunnel ref. When the tunnel ref
-reaches zero, the tunnel puts its socket ref. When the socket is
-eventually destroyed, its sk_destruct finally frees the L2TP tunnel
-context.
+reaches zero, the tunnel drops its socket ref.
 
 Sessions
 --------
@@ -667,10 +664,7 @@ pseudowire) or other data types such as PPP, ATM, HDLC or Frame
 Relay. Linux currently implements only Ethernet and PPP session types.
 
 Some L2TP session types also have a socket (PPP pseudowires) while
-others do not (Ethernet pseudowires). We can't therefore use the
-socket reference count as the reference count for session
-contexts. The L2TP implementation therefore has its own internal
-reference counts on the session contexts.
+others do not (Ethernet pseudowires).
 
 Like tunnels, L2TP sessions are identified by a unique
 session id. Just as with tunnel ids, the session id is 16-bit for
@@ -680,21 +674,19 @@ value.
 Sessions hold a ref on their parent tunnel to ensure that the tunnel
 stays extant while one or more sessions references it.
 
-Sessions are kept in a per-tunnel list, indexed by session id. L2TPv3
-sessions are also kept in a per-net list indexed by session id,
-because L2TPv3 session ids are unique across all tunnels and L2TPv3
-data packets do not contain a tunnel id in the header. This list is
-therefore needed to find the session context associated with a
-received data packet when the tunnel context cannot be derived from
-the tunnel socket.
+Sessions are kept in a per-net list. L2TPv2 sessions and L2TPv3
+sessions are stored in separate lists. L2TPv2 sessions are keyed
+by a 32-bit key made up of the 16-bit tunnel ID and 16-bit
+session ID. L2TPv3 sessions are keyed by the 32-bit session ID, since
+L2TPv3 session ids are unique across all tunnels.
 
 Although the L2TPv3 RFC specifies that L2TPv3 session ids are not
-scoped by the tunnel, the kernel does not police this for L2TPv3 UDP
-tunnels and does not add sessions of L2TPv3 UDP tunnels into the
-per-net session list. In the UDP receive code, we must trust that the
-tunnel can be identified using the tunnel socket's sk_user_data and
-lookup the session in the tunnel's session list instead of the per-net
-session list.
+scoped by the tunnel, the Linux implementation has historically
+allowed this. Such session id collisions are supported using a per-net
+hash table keyed by sk and session ID. When looking up L2TPv3
+sessions, the list entry may link to multiple sessions with that
+session ID, in which case the session matching the given sk (tunnel)
+is used.
 
 PPP
 ---
@@ -714,10 +706,9 @@ The L2TP PPP implementation handles the closing of a PPPoL2TP socket
 by closing its corresponding L2TP session. This is complicated because
 it must consider racing with netlink session create/destroy requests
 and pppol2tp_connect trying to reconnect with a session that is in the
-process of being closed. Unlike tunnels, PPP sessions do not hold a
-ref on their associated socket, so code must be careful to sock_hold
-the socket where necessary. For all the details, see commit
-3d609342cc04129ff7568e19316ce3d7451a27e8.
+process of being closed. PPP sessions hold a ref on their associated
+socket in order that the socket remains extants while the session
+references it.
 
 Ethernet
 --------
@@ -761,15 +752,10 @@ Limitations
 
 The current implementation has a number of limitations:
 
-  1) Multiple UDP sockets with the same 5-tuple address cannot be
-     used. The kernel's tunnel context is identified using private
-     data associated with the socket so it is important that each
-     socket is uniquely identified by its address.
-
-  2) Interfacing with openvswitch is not yet implemented. It may be
+  1) Interfacing with openvswitch is not yet implemented. It may be
      useful to map OVS Ethernet and VLAN ports into L2TPv3 tunnels.
 
-  3) VLAN pseudowires are implemented using an ``l2tpethN`` interface
+  2) VLAN pseudowires are implemented using an ``l2tpethN`` interface
      configured with a VLAN sub-interface. Since L2TPv3 VLAN
      pseudowires carry one and only one VLAN, it may be better to use
      a single netdevice rather than an ``l2tpethN`` and ``l2tpethN``:M
-- 
2.34.1


