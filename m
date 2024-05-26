Return-Path: <netdev+bounces-98095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9F38CF505
	for <lists+netdev@lfdr.de>; Sun, 26 May 2024 19:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D70E01F21124
	for <lists+netdev@lfdr.de>; Sun, 26 May 2024 17:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E5F51C4B;
	Sun, 26 May 2024 17:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="Wk3SCEZv"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADA050A7E;
	Sun, 26 May 2024 17:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716744341; cv=none; b=Iz0RE1daUmjMC7Dp8knUjvENBiaUnKyT06PvULHkhOjg367oCyAyeYhXQaXBGw+jqDKjfhHaaBgMuMjyy1NNs+aASLPq+9/NkzU+d7WTUu9xyJEyzXQz+j6z4r3rTituZpDVjdicbfavqOLKyPBHaagoJjQ2JDNzupMj/8zELwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716744341; c=relaxed/simple;
	bh=k7gJoCfRl8RPEKpIGPEV4121Uy8RfEYOc1Yk/42GW1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GQPI/BTAq4+wijnfGzihpvf6ZhW/luSZW3cv8qG5ozieLClUng921C7XEjEHdbzv20uBgukXXfIVkxZPA9snG4SB3N7k9wqE50qeFyDJ5ji8D0OqSUsbgVPXpc7ohvWw6jQ7fNv4KdLrL/vXCwKpBTMrpd8icVJAGFFsSgLSlPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=Wk3SCEZv; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=gsit2KxzLDyWo3HLztIyKkYctUypUcPbrdY0zyz5kOM=; b=Wk3SCEZvOIWaGKsO
	0EFC9frQ7+W4nL7FpLwKCYum8qwxXZ2P2s1LFFf5Kwdob7Ztjkkwc096KZt1/PJqL1E5nnMEZJfQm
	os93yJPsZgLakaL7/xSmmPEIi9i+C35M8FAVJ3ZMBOQkm/xN+/GHUERv41OlDvkrpaUIWy3rVmrwq
	FrmIetQI//JadcZTyyt1SIVXzQ9ZyeKvp+XW5uUOpTPoN6sScvvNBQx5+eL+cubK7WVD73EkybcZT
	TrEPPh9C7l7g0PRAB+ciXKZwtfNw3bB52DIdQECpP8NoirIWxoJvvFaFScCm5xZGNF2l00i5t0zvY
	k9TnyZCgqttZjiQe/w==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1sBHcX-002aYf-25;
	Sun, 26 May 2024 17:25:22 +0000
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
Subject: [PATCH 1/4] net: ethernet: starfire: remove unused structs
Date: Sun, 26 May 2024 18:24:25 +0100
Message-ID: <20240526172428.134726-2-linux@treblig.org>
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

'short_rx_done_desc' and 'basic_rx_done_desc' are unused since
commit fdecea66687d ("  [netdrvr starfire] Add GPL'd firmware, remove
compat code").

Remove them.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/net/ethernet/adaptec/starfire.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/net/ethernet/adaptec/starfire.c b/drivers/net/ethernet/adaptec/starfire.c
index 857361c74f5d..e1b8794b14c9 100644
--- a/drivers/net/ethernet/adaptec/starfire.c
+++ b/drivers/net/ethernet/adaptec/starfire.c
@@ -441,14 +441,6 @@ enum rx_desc_bits {
 };
 
 /* Completion queue entry. */
-struct short_rx_done_desc {
-	__le32 status;			/* Low 16 bits is length. */
-};
-struct basic_rx_done_desc {
-	__le32 status;			/* Low 16 bits is length. */
-	__le16 vlanid;
-	__le16 status2;
-};
 struct csum_rx_done_desc {
 	__le32 status;			/* Low 16 bits is length. */
 	__le16 csum;			/* Partial checksum */
-- 
2.45.1


