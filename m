Return-Path: <netdev+bounces-134989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E396199BBBE
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 22:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38C8DB20F15
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 20:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E980155A25;
	Sun, 13 Oct 2024 20:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="s3g6eN04"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F3B1514CB;
	Sun, 13 Oct 2024 20:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728851929; cv=none; b=IRaEyDhE9jhRWMuvvlRm95/PFlfXrvlcxD0fDR3UdySyxl7GgVr46T7TO6SZb9hZKB61OdF6CRfWr09I7pePsTN6sOFNTowvUmw4daEyamifmZiaqEf0GWWHknjyf99uqHaxHhgVzWEbkaQSlJfU89ULoMwtVsag0y1GgvMZJdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728851929; c=relaxed/simple;
	bh=7/r3ahWmKb5y3GrgXA4FtVlNFSHbjzDmV4Rb2+s+4Io=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FEGuvPnDWEeegIfvMN6iPXaUBkhIeEgLZfXscichDe5gHE2O55RpbRobvzqjqbIoUrS0q5bAUf3puxEmrIB4FY2CRJBR6XT1ViVYfVyRMVXoPzCrbgTh5jlR3Redw4MXj07kiZ6wP0MV0qMNdWzvayjqtB4j/M4hHRtv50S/jH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=s3g6eN04; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=T7awRtjFbenc+GOlGd9rhHppedzLJGsTCN5jnGB4TbE=; b=s3g6eN04lgIN9tdA
	zZ3lMblJ9cH9uduJ+X5f86CvcFw/O7d+cgctdMTfQLVVwuIoi12ccPuhd+8WhpBqJpvYtJawtB9kY
	ujzX71fiZPD4xUf+M+rRHDAaNSkFAJplCv/6JjFwkljByT08up9wa0vJ/8sGY7CEqw3k6PZaQiIbE
	ApiBgNfqvzOyr69m6bQIjrKw4D5zSQZ/bxG/Ig/YPjB8m9HI4A2uXALJ6Mzx3lJHlF9v20wQUAY0H
	PfUE6bmuIxs7PaJIhEar7uuJwfKQdmU6yEF9+4ttGiuf8HWFz8Vrkh1TpDcGFpPcc1Lj+iEMKLzkK
	iCprPF0EeZD/RPtBOw==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1t05MO-00AnUX-1G;
	Sun, 13 Oct 2024 20:38:40 +0000
From: linux@treblig.org
To: bharat@chelsio.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH net-next 5/6] cxgb4: Remove unused cxgb4_l2t_alloc_switching
Date: Sun, 13 Oct 2024 21:38:30 +0100
Message-ID: <20241013203831.88051-6-linux@treblig.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241013203831.88051-1-linux@treblig.org>
References: <20241013203831.88051-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

cxgb4_l2t_alloc_switching() has been unused since it was added in
commit f7502659cec8 ("cxgb4: Add API to alloc l2t entry; also update
existing ones")

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/net/ethernet/chelsio/cxgb4/l2t.c | 19 -------------------
 drivers/net/ethernet/chelsio/cxgb4/l2t.h |  2 --
 2 files changed, 21 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/l2t.c b/drivers/net/ethernet/chelsio/cxgb4/l2t.c
index 1e5f5b1a22a6..c02b4e9c06b2 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/l2t.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/l2t.c
@@ -608,25 +608,6 @@ struct l2t_entry *t4_l2t_alloc_switching(struct adapter *adap, u16 vlan,
 	return e;
 }
 
-/**
- * cxgb4_l2t_alloc_switching - Allocates an L2T entry for switch filters
- * @dev: net_device pointer
- * @vlan: VLAN Id
- * @port: Associated port
- * @dmac: Destination MAC address to add to L2T
- * Returns pointer to the allocated l2t entry
- *
- * Allocates an L2T entry for use by switching rule of a filter
- */
-struct l2t_entry *cxgb4_l2t_alloc_switching(struct net_device *dev, u16 vlan,
-					    u8 port, u8 *dmac)
-{
-	struct adapter *adap = netdev2adap(dev);
-
-	return t4_l2t_alloc_switching(adap, vlan, port, dmac);
-}
-EXPORT_SYMBOL(cxgb4_l2t_alloc_switching);
-
 struct l2t_data *t4_init_l2t(unsigned int l2t_start, unsigned int l2t_end)
 {
 	unsigned int l2t_size;
diff --git a/drivers/net/ethernet/chelsio/cxgb4/l2t.h b/drivers/net/ethernet/chelsio/cxgb4/l2t.h
index 340fecb28a13..8aad7e9dee6d 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/l2t.h
+++ b/drivers/net/ethernet/chelsio/cxgb4/l2t.h
@@ -115,8 +115,6 @@ struct l2t_entry *cxgb4_l2t_get(struct l2t_data *d, struct neighbour *neigh,
 				unsigned int priority);
 u64 cxgb4_select_ntuple(struct net_device *dev,
 			const struct l2t_entry *l2t);
-struct l2t_entry *cxgb4_l2t_alloc_switching(struct net_device *dev, u16 vlan,
-					    u8 port, u8 *dmac);
 void t4_l2t_update(struct adapter *adap, struct neighbour *neigh);
 struct l2t_entry *t4_l2t_alloc_switching(struct adapter *adap, u16 vlan,
 					 u8 port, u8 *dmac);
-- 
2.47.0


