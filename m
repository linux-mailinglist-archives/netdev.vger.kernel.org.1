Return-Path: <netdev+bounces-208466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DEB3B0B9E2
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 04:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D49B188CB08
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 02:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A315419309C;
	Mon, 21 Jul 2025 02:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ylx8jjCY"
X-Original-To: netdev@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB7E18BC0C
	for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 02:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753063464; cv=none; b=jFrfp/c0U5C0BSq6z29K9xHyZZPBKcWlQb2oWrWEUG+ZsycNOKZZftEUaDqEblCWy/fwP510u1/tXaKx1UA9IzQkZ/F4LXcbtdbA77YuQIc3JrtqoGcVWF+FMSLdUuZnF5D5ToFUyUQUxAnhGQCbtF3BWCstEaZs8RmIUgcUYXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753063464; c=relaxed/simple;
	bh=MWSi+DfB6Hr+H4MaN7LPfe6qSIF9gatMxQrg7/1Z4q0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YBCVtDRqgHvvalMrRsfiuoCp+gktaL1AregX5BVWYbYIA29H7TAx2SVLGVaQQZ68q99DQtbq02cUTJwpHvTN+LczBUEZIKr3WEVWhRxs/AuJhSDu+VudUthpuye1wlkCInaW0aVqGnwXabQ/RcMRe1vQejUKZGBcY2yDbsCBQY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ylx8jjCY; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=Gl1gXJV2m4NhvXRcvVw4zWyEJXBxAsY0jHsnTViHbvo=; b=Ylx8jjCYPelekIUtwNw2nd0eAY
	5Bg/pXEczWbwDSCiY7BIj248A9CM/gAFhxCuNBQu0wx7iGTFkf17Q+EU3bUf9vgeqpaO+BYHBSq9D
	O+f2830//gtnAWTxKjBXNdFwOWPmBBSs5GJYt01ron+IxsFgvx3+YPUOcbOBNPGdkeX/TsGlufrDN
	efosQjq8THM44G6C8ilc4FOKruRC0A67XMfPlTt/gvZiGHT/k4LzYxF9E2tu5U0icWHCoTjgqXv44
	eD27nIytrCHUmv/+SiWjdVQ+Cw/5oslGuBr72fXXycuDEmCcA3t7lZkwnkQoa3zHcDS4mteFv5s9y
	GeYxN9Ag==;
Received: from [50.53.25.54] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1udft7-0000000Fwr3-1mIh;
	Mon, 21 Jul 2025 02:04:21 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: netdev@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH] net: Kconfig: add endif/endmenu comments
Date: Sun, 20 Jul 2025 19:04:20 -0700
Message-ID: <20250721020420.3555128-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add comments on endif & endmenu blocks. This can save time
when searching & trying to understand kconfig menu dependencies.

The other endif & endmenu statements are already commented like this.

This makes it similar to drivers/net/Kconfig, which is already
commented like this.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>

 net/Kconfig |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- linux-next.orig/net/Kconfig
+++ linux-next/net/Kconfig
@@ -247,7 +247,7 @@ source "net/ipv4/netfilter/Kconfig"
 source "net/ipv6/netfilter/Kconfig"
 source "net/bridge/netfilter/Kconfig"
 
-endif
+endif # if NETFILTER
 
 source "net/sctp/Kconfig"
 source "net/rds/Kconfig"
@@ -408,9 +408,9 @@ config NET_DROP_MONITOR
 	  just checking the various proc files and other utilities for
 	  drop statistics, say N here.
 
-endmenu
+endmenu # Network testing
 
-endmenu
+endmenu # Networking options
 
 source "net/ax25/Kconfig"
 source "net/can/Kconfig"

