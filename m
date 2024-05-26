Return-Path: <netdev+bounces-98098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 672A78CF50C
	for <lists+netdev@lfdr.de>; Sun, 26 May 2024 19:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E652C281002
	for <lists+netdev@lfdr.de>; Sun, 26 May 2024 17:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A823953377;
	Sun, 26 May 2024 17:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="I6HJSLrt"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317E552F8C;
	Sun, 26 May 2024 17:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716744361; cv=none; b=gMBE9znbpKO26GoKw8o9ruTOIudZXU/pFeyOq297tYor1pa0RbkGK71uByjIL6awzhF1CiPdETkenULRrL8dm2N4dfhCn1Mi2+iymSwmM8cX4XI2binBm3QEKO/kh+Gmor4yNDlteemaN/xPlKILdxzFfyoydl2LCVN1mWGNZ2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716744361; c=relaxed/simple;
	bh=378XXa0Bo17EZwBI247WORitI2varrhaPXmIosZX9/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cJjcQ+p37fe6bxdcTaPrkZq+Ar//84i+TuN2iefjahzYITtISzlXPW0+QUnscoNAjZcQzW7cSjw/cWgo3rQb6Zfv0r8rRgF2hN8LXrHZi/xHjnozuE+efOcffmNPNRvQG/eltBuedwsVM3+GP28JsJyG9Ro4o2wWGGsHOsSvqxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=I6HJSLrt; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=fJwBIr6v15ZehR1HVxgnQmaZc/OqYRDjeLZFE00kofo=; b=I6HJSLrtnC2+Cerk
	EOJeft+PhiMcnBQrE62Py10+x07kcHWG/LMvVLmzN3hixktplNJks/62wXF3aQhP6Ko99D7/GOmY9
	AAs/D1sPU51JJMLrrivU4/9CVu+My0FWqKiJHbKw+3sLtPngbQerjjnGgqUdoaj8GzItgL2fHhyVl
	D1+K6ixoms60DUh48gUICTObq2oIBG0DBAPIOCPqbqbxeE6veARpuXRCH3dr9M68H9R3L+7318NPT
	t+pYCzbtZCGuNnj1KOgXakWlRrxDZ79c3ylJU431/Q6pabFDljSKbNd+CB/ZtoRPcDuGzk94zoEKW
	dMGyXrwmHLk2Yogh+w==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1sBHcz-002aYf-0V;
	Sun, 26 May 2024 17:25:49 +0000
From: linux@treblig.org
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: ionut@badula.org,
	tariqt@nvidia.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 4/4] net: ethernet: 8390: ne2k-pci: remove unused struct 'ne2k_pci_card'
Date: Sun, 26 May 2024 18:24:28 +0100
Message-ID: <20240526172428.134726-5-linux@treblig.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240526172428.134726-1-linux@treblig.org>
References: <20240526172428.134726-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

'ne2k_pci_card' is unused since 2.3.99-pre3 in March 2000.

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/net/ethernet/8390/ne2k-pci.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/net/ethernet/8390/ne2k-pci.c b/drivers/net/ethernet/8390/ne2k-pci.c
index 65f56a98c0a0..1a34da07c0db 100644
--- a/drivers/net/ethernet/8390/ne2k-pci.c
+++ b/drivers/net/ethernet/8390/ne2k-pci.c
@@ -186,17 +186,6 @@ static void ne2k_pci_block_output(struct net_device *dev, const int count,
 static const struct ethtool_ops ne2k_pci_ethtool_ops;
 
 
-
-/* There is no room in the standard 8390 structure for extra info we need,
- * so we build a meta/outer-wrapper structure..
- */
-struct ne2k_pci_card {
-	struct net_device *dev;
-	struct pci_dev *pci_dev;
-};
-
-
-
 /* NEx000-clone boards have a Station Address (SA) PROM (SAPROM) in the packet
  * buffer memory space.  By-the-spec NE2000 clones have 0x57,0x57 in bytes
  * 0x0e,0x0f of the SAPROM, while other supposed NE2000 clones must be
-- 
2.45.1


