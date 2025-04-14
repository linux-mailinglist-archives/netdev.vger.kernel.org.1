Return-Path: <netdev+bounces-182481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98DF7A88DAA
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 23:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 009651898D72
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 21:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11DAC1F3FEC;
	Mon, 14 Apr 2025 21:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W7Z2qR7X"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AF81F3FC0
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 21:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744665603; cv=none; b=GhIQe7IZVQ5LLsnXtd5bxfOaBU6/BunPEyXZdcEp7nhXecjb2LCHATYS/XxliJx4HGrlBsgNpfg58DExFtoyI9+UfPKZR0nhXps1Y4tgHXaztGyAx7jUZ+UZpyH2Abj5k2kNGJ5hHK0E7S/Ez1isFWTnumVCDdk9rxDGyBHcKkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744665603; c=relaxed/simple;
	bh=5i+ERuGuMAIuYvf3O2iyOdPFU2DUz1XEX7hlDog/eb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WbEJlFxHJ/U36B9OoO6UhGraTrkZGk3enXUPTHneFlvysha37nREpFt0oStHQjp5sDaJZNhJIJ4uRg6nGuznPjfvGNItluZPKvzq6zV8Ad11+jPkzsFI/MBg8SdwJc2o6a99FmdiNC8MCOx0Np9eSpR9q/A0Uf3+KojZjD6L64Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W7Z2qR7X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F18B5C4CEEF;
	Mon, 14 Apr 2025 21:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744665602;
	bh=5i+ERuGuMAIuYvf3O2iyOdPFU2DUz1XEX7hlDog/eb8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W7Z2qR7XEEtGA8m2oj5DzGI6iKeu3azU/xsuUxHfB8HJ+BBDfs5nzmovaoMvxWAjP
	 IZ8VOkWlOEK/K3jhjlSpMDT4GNWExISz45zzN/E3FNFKPGEaJKS5HazilhYgpKPXT7
	 UibPt1KiafffUtEy/6nrbHk5FHOs12cIEDjnYVNM+HDXChPiauDlytr19s8euPt5AS
	 4+rxTzHXPZflcoLPVibThSfM4vTA7kxW8LtwCuAn/qb8I2pfEjPhrvRrEOf0ylOknC
	 JxzpsMOyVrWjk1ynBqhfaJz1GqUmPzkuQO4N8nBYsb7OMN7AXioye0/T09LjNGpBI8
	 whWopM84kBnLA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: donald.hunter@gmail.com,
	netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	daniel@iogearbox.net,
	sdf@fomichev.me,
	jacob.e.keller@intel.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net 6/8] netlink: specs: rtnetlink: attribute naming corrections
Date: Mon, 14 Apr 2025 14:18:49 -0700
Message-ID: <20250414211851.602096-7-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250414211851.602096-1-kuba@kernel.org>
References: <20250414211851.602096-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some attribute names diverge in very minor ways from the C names.
These are most likely typos, and they prevent the C codegen from
working.

Fixes: bc515ed06652 ("netlink: specs: Add a spec for neighbor tables in rtnetlink")
Fixes: b2f63d904e72 ("doc/netlink: Add spec for rt link messages")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/specs/rt_link.yaml  | 6 +++---
 Documentation/netlink/specs/rt_neigh.yaml | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/netlink/specs/rt_link.yaml b/Documentation/netlink/specs/rt_link.yaml
index 200e9a7e5b11..03323d7f58dc 100644
--- a/Documentation/netlink/specs/rt_link.yaml
+++ b/Documentation/netlink/specs/rt_link.yaml
@@ -1591,7 +1591,7 @@ protonum: 0
         name: nf-call-iptables
         type: u8
       -
-        name: nf-call-ip6-tables
+        name: nf-call-ip6tables
         type: u8
       -
         name: nf-call-arptables
@@ -2083,7 +2083,7 @@ protonum: 0
         name: id
         type: u16
       -
-        name: flag
+        name: flags
         type: binary
         struct: ifla-vlan-flags
       -
@@ -2171,7 +2171,7 @@ protonum: 0
         type: binary
         struct: ifla-cacheinfo
       -
-        name: icmp6-stats
+        name: icmp6stats
         type: binary
         struct: ifla-icmp6-stats
       -
diff --git a/Documentation/netlink/specs/rt_neigh.yaml b/Documentation/netlink/specs/rt_neigh.yaml
index e670b6dc07be..a1e137a16abd 100644
--- a/Documentation/netlink/specs/rt_neigh.yaml
+++ b/Documentation/netlink/specs/rt_neigh.yaml
@@ -189,7 +189,7 @@ protonum: 0
         type: binary
         display-hint: ipv4
       -
-        name: lladr
+        name: lladdr
         type: binary
         display-hint: mac
       -
-- 
2.49.0


