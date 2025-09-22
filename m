Return-Path: <netdev+bounces-225275-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D32D9B91969
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 16:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DCD1424DD8
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 14:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C84E1A9F99;
	Mon, 22 Sep 2025 14:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k5zXeMzS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0FE1A5B9D;
	Mon, 22 Sep 2025 14:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758550109; cv=none; b=dihjKOp1cKHF4oJp/RRihzzHHw0V8W21alUutW0Q5+F8Hh5qjD+UvhcEEZKVO3Y2xrXXrnvBQl3T41WHA42HfGP6vMIWsSYGvQwhUjwyKja/Vw8O5bSqVIaaFCFS4uUZz8myeSVEDx6N50TyXYLQ9xzF8UU9e9Kqkhr6PGGsnHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758550109; c=relaxed/simple;
	bh=g63gUXV32iglXiLeG7nvTC7diJKbKHpwkEKeH1j4s8c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=eQIfRbkNLBn/l1VgPZYbl/P0wzxcf/p+ADkj8HiGbcO0E0P+cwLa8B7hwBzdvOJfwTer8F0EL2TxbhX/EJboarG9pWRG9kzRpA8H8xXtLogw5Gh2O7QX5KGuIohIl+yblwpkBbmy1qmZm5LXASGp/ry9Zqv0257Izrhzv27t65Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k5zXeMzS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65114C4CEF0;
	Mon, 22 Sep 2025 14:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758550108;
	bh=g63gUXV32iglXiLeG7nvTC7diJKbKHpwkEKeH1j4s8c=;
	h=Date:From:To:Cc:Subject:From;
	b=k5zXeMzSlp3xP70jqm61JYaYoQ4w1GhTQ2rSacA+JSjb3OjVFd4a7mtqT1/8DFhBw
	 n5tKCxSKO+izxKAB0BOFyYNErDEC0ag8YwjTfPGw3sqNr1EAsC5dJxY4lRuNwWe8Zh
	 1cpoUokDYNEx83cus6b1t4KsU1zWZPDLg3lxicCuvD0SYu3l6lcb6PxUcUddOnBNVn
	 wcs48j1PwT5KmfQWVI2M6rCndOAkTzXSi4h8J0YVmkxOKovXr+sLsB3lzBe+lZxti4
	 6cQ6Wza8JP3JMMuaMlyxTT8+oFGQIZ4JLrdYcGZb5EgyAOVaGRONg2OVqLQaFkw6ES
	 7MYbuHPhjkNQQ==
Date: Mon, 22 Sep 2025 16:08:21 +0200
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] net: airoha: Avoid -Wflex-array-member-not-at-end
 warning
Message-ID: <aNFYVYLXQDqm4yxb@kspp>
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
structure. Notice that `struct airoha_foe_entry` is a flexible
structure, this is a structure that contains a flexible-array
member.

Fix the following warning:

drivers/net/ethernet/airoha/airoha_eth.h:474:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index 77fd13d466dc..cd13c1c1224f 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -471,7 +471,6 @@ struct airoha_flow_table_entry {
 		};
 	};
 
-	struct airoha_foe_entry data;
 	struct hlist_node l2_subflow_node; /* PPE L2 subflow entry */
 	u32 hash;
 
@@ -480,6 +479,9 @@ struct airoha_flow_table_entry {
 
 	struct rhash_head node;
 	unsigned long cookie;
+
+	/* Must be last --ends in a flexible-array member. */
+	struct airoha_foe_entry data;
 };
 
 struct airoha_wdma_info {
-- 
2.43.0


