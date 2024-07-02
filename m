Return-Path: <netdev+bounces-108573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A9719246B1
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 19:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFFDA284B6C
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 17:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816001BE874;
	Tue,  2 Jul 2024 17:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="URey39i0"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FB0155335;
	Tue,  2 Jul 2024 17:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719942826; cv=none; b=UAg4/zJd/Z4TY3pqckFvMwTGb6o+vZbPkY0kZHi0DEhA0OPjesmUdoR1jyNMeCJFXov/PyhlTBs0QN8M35FYpnZVfZUD4/XefLTKRlLyAFVLZyIl/oUSvvlSVSGlqx/q+GAXyvXO32nG2UvY4eYQ5WlG4LIo82qUu/s+Ths560g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719942826; c=relaxed/simple;
	bh=hopb8jJXYjSgJxfRiT/jTw/DJbPUKO4GWu2WfEyTerI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZUBtdjkb8d3cq766UgCBVBXCFeqO6RYfOdGl1s5q+C7Wq2GwudsXgShjzisnvpYvfxxJyXLTubJZQtkM9+BoAGt0GnYKBl5CWXjuSOX4409dEQOW5c7/OGA7/7o/dOUQuet5sUHz/VaCQ93T6kaWfkNzwlyJIGehLSV70wS40yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=URey39i0; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from localhost.localdomain (48.39-182-91.adsl-dyn.isp.belgacom.be [91.182.39.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id DDB89200BFE3;
	Tue,  2 Jul 2024 19:45:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be DDB89200BFE3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1719942324;
	bh=8KC+FJWfjQ8vb3wsEa+o1zXrrfgLfUradvGMOOm1hpw=;
	h=From:To:Cc:Subject:Date:From;
	b=URey39i0gsUKzJJUldP8A++Y9SY8+AR+fh72V3WV5LiWebU34TTB9dWMZHWThSJXj
	 tdms3HYkl7+/gPsz50ZYPFZBspFj/yhIzNCvW2Xm63TwMGGBS/EXk/4wseAtsvWX5Y
	 w8QGiJ7DaULQiTx8Zr6BQBU+vICuaGHAUU8FIBrfVG/3b/8PEP1SBS/qFeiDDLuhiH
	 LSps5jDYXX3TvpwabDu3s915y/aiDHhUujDpvH38qeaq8ZYxk/sPO6SziqY7OUTW/N
	 aw5Ch/ul1ePZyhdGmGT5E4MxCSLBSWAHDwu8QLjQboM2vpcKSnYqLKSVIp1P/Je4p7
	 Q9Ksq7UGEb3xQ==
From: Justin Iurman <justin.iurman@uliege.be>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	justin.iurman@uliege.be
Subject: [PATCH net 0/2] net: ioam6: fix bugs in ioam6_iptunnel
Date: Tue,  2 Jul 2024 19:44:49 +0200
Message-Id: <20240702174451.22735-1-justin.iurman@uliege.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When running some measurements on IOAM, we discovered a "bug" that
triggers two reallocations instead of one in some specific cases. Those
specific cases are:
- "inline" mode with pre-allocated data size 236 or 240 bytes
- "encap" mode with pre-allocated data size 196 or 200 bytes

The reason is that we (unluckily) fall on a boundary and, since we use
skb->mac_len by default in skb_cow_head(), the second call to
skb_cow_head() after the insertion may need more than available in the
headroom (because, there, we call LL_RESERVED_SPACE()). Example on a
machine that reallocates by steps of 64 bytes:
- I need to add 256 bytes (+14 skb->mac_len), so 270 bytes
- current headroom is 206 bytes
- call to skb_cow_head, the headroom is now 270 bytes (+64 bytes)
- after the insertion, we want to make sure that the dev has enough
  headroom (LL_RESERVED_SPACE() gives 16 bytes in our case: 14+2)
- current headroom is 14 bytes (yep, remember... see above)
- call to skb_cow_head... oh wait, I need 16 bytes and I only have 14
  available... let's reallocate! The headroom is now 78 bytes (+64)

And so every single time. Patch 2 solves this issue by providing a
mitigation.

Also, while fixing the above, we discovered another bug: after the
insertion, the second call to skb_cow_head() makes sure that the dev has
enough headroom for layer 2 and stuff. In that case, the "old" dst entry
is used, which is not correct. Patch 1 solves this issue.

Justin Iurman (2):
  net: ioam6: use "new" dst entry with skb_cow_head
  net: ioam6: mitigate the two reallocations problem

 net/ipv6/ioam6_iptunnel.c | 85 ++++++++++++++++++++-------------------
 1 file changed, 44 insertions(+), 41 deletions(-)

-- 
2.34.1


