Return-Path: <netdev+bounces-221308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 765B2B501AF
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 17:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23692165ADA
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 15:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80DB32641F9;
	Tue,  9 Sep 2025 15:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S6oF+5hL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7E325B31C;
	Tue,  9 Sep 2025 15:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757432566; cv=none; b=iu6RGaGWU6z1vDWeYkZeYuQRsV0XtvFwyduuhsr0ZFz661BnIn4KCiOiv7hy3RrL+OUlcfjPn0C+bR+eZ3A7NoNliZSU200GoeiQIoP7gxkbpD72YdvAZjvTinwfdmASf8QdJc0RtJa7wViir44S0jl9Izmt0r5eKChBqwCdWXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757432566; c=relaxed/simple;
	bh=iq/pvz8Ld8+XdgGpue9AiLpnbu11vXcJXE2lOLzf1b8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=o7MF9Tic9ReQZ73VWXoNnhg3vTHgGlbtvB5oV64X6Afi4byFoxWz4wd8pSFEB7ylhfy2AQtfR4fbYyPbye3qg1PYnOwHaALOTQj/1/vw7/YkiOfU0BjXYu8XjnMPydpcvrFPBEcdZEcc17tLtt1wHIUdQhYnHrCVOpMYHOrRNXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S6oF+5hL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7294CC4CEF4;
	Tue,  9 Sep 2025 15:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757432565;
	bh=iq/pvz8Ld8+XdgGpue9AiLpnbu11vXcJXE2lOLzf1b8=;
	h=Date:From:To:Cc:Subject:From;
	b=S6oF+5hLP47hMCnJrxBSvt7EoWRkoF8h6dya+vKpws0OSoJvDp7u9GFdWtiDfq4B6
	 8q48hkLEIh5GxPOQmeEffv8GE8gpAQBDeHhdd7t4aVjaEq9QXwQ9C7zO4cnmvD4HHn
	 2MxuoJjflM+rNns4md5UkHvCRRxg4gDuz1ZKKukt4wLC+XSeXgw6tJwKVkaug1rwu/
	 ZPzBl5w8be7m+VAI81beBppwHx4/jSKBTIMQqGvae3ZMui6JIOhZUPrf4Y2NZuZFqC
	 4yyeEm37RhmMdxLPeeAWyFbNnmBC4aqzHYkCMhto9HpCYYu8tBLBv/ZX7QURI6GM86
	 AGQID4MxgivHA==
Date: Tue, 9 Sep 2025 17:42:39 +0200
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] geneve: Avoid -Wflex-array-member-not-at-end warning
Message-ID: <aMBK78xT2fUnpwE5@kspp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

-Wflex-array-member-not-at-end was introduced in GCC-14, and we are
getting ready to enable it, globally.

Move the conflicting declaration to the end of the corresponding
structure. Notice that `struct ip_tunnel_info` is a flexible
structure, this is a structure that contains a flexible-array
member.

Fix the following warning:

drivers/net/geneve.c:56:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/net/geneve.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 54384f9b3872..77b0c3d52041 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -53,7 +53,6 @@ struct geneve_dev_node {
 };
 
 struct geneve_config {
-	struct ip_tunnel_info	info;
 	bool			collect_md;
 	bool			use_udp6_rx_checksums;
 	bool			ttl_inherit;
@@ -61,6 +60,9 @@ struct geneve_config {
 	bool			inner_proto_inherit;
 	u16			port_min;
 	u16			port_max;
+
+	/* Must be last --ends in a flexible-array member. */
+	struct ip_tunnel_info	info;
 };
 
 /* Pseudo network device */
-- 
2.43.0


