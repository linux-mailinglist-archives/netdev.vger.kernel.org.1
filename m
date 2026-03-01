Return-Path: <netdev+bounces-262311-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2DzqAH6co2k3IQUAu9opvQ
	(envelope-from <netdev+bounces-262311-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 02:55:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 553371CC3F0
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 02:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 717DC328E6B3
	for <lists+netdev@lfdr.de>; Sun,  1 Mar 2026 01:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FAE52D0C63;
	Sun,  1 Mar 2026 01:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R9rJzhiu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D9C2C0294;
	Sun,  1 Mar 2026 01:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772329097; cv=none; b=BbelUmxqXHqHnKGGlIryrj8wpvZNlKi/iPuozb735gAI5VzBy7xxoPMeFOFDYbmMquassuKIb8YvSNynT/NJO1xfjJ79nPDlLE7dgNoC8pk7oRaZKEkI94qzA54pOxdw17GoIp49G9kGqHU89TbbdG5k28rxIYL8ncCmU8SGJ0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772329097; c=relaxed/simple;
	bh=hkMpov33d1fO/031HMcWwVwnbB16Kf23Aw86dFSrrlk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WxjBXoj3uvsNF3EyGfL0+MT+2jCb+mN160HimUO6air+HPONfCf7fVI7Gk4vmoPPwoAbgyrlbctbo7wKYMBuFWS3Cbxn4eh9cEzZgJrXC7a2uzsrg2j4TTZhXwePG6U6sJLltmq8g+i2Kt/WVgWQEQdMYWyo2CgRDey2ph5OsTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R9rJzhiu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36DDBC19421;
	Sun,  1 Mar 2026 01:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772329096;
	bh=hkMpov33d1fO/031HMcWwVwnbB16Kf23Aw86dFSrrlk=;
	h=From:To:Cc:Subject:Date:From;
	b=R9rJzhiubEsfYtfsWasY1zArFZNVJ3L59YttdUIcbdOTsP3lZswXR7E6Fh9SB1yB1
	 ITdGcRzKQH5lQkkqBMNcokT1XLfkACvV7eBWHAPWOjgNpIO1tsc6DsZmU7ye1Zkp3r
	 GKIAvi7bVwaxjuQbG61RgzPi8eYypqpNoOnnVe0GpxMRSA6V9RMoXjzX1GzJy67WHC
	 wBWHeKPjU+/3G0xTbCpLfwXthqZslJAZIS4BLwFdd8pT41BggjC8A0ed12XsPgOBXj
	 JkJwVFD8431sV54VO0JnOZp8jeuF61CkaVARvoWzrKi+PzrrTbq+Y+xdgZKCSate90
	 nozBBqW4+4kNQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	bo@mboxify.com
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Jijie Shao <shaojijie@huawei.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org
Subject: FAILED: Patch "octeontx2-af: CGX: fix bitmap leaks" failed to apply to 6.6-stable tree
Date: Sat, 28 Feb 2026 20:38:14 -0500
Message-ID: <20260301013815.1698627-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262311-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:email,msgid.link:url,linux.dev:email,mboxify.com:email]
X-Rspamd-Queue-Id: 553371CC3F0
X-Rspamd-Action: no action

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 3def995c4ede842adf509c410e92d09a0cedc965 Mon Sep 17 00:00:00 2001
From: Bo Sun <bo@mboxify.com>
Date: Fri, 6 Feb 2026 21:09:24 +0800
Subject: [PATCH] octeontx2-af: CGX: fix bitmap leaks

The RX/TX flow-control bitmaps (rx_fc_pfvf_bmap and tx_fc_pfvf_bmap)
are allocated by cgx_lmac_init() but never freed in cgx_lmac_exit().
Unbinding and rebinding the driver therefore triggers kmemleak:

    unreferenced object (size 16):
        backtrace:
          rvu_alloc_bitmap
          cgx_probe

Free both bitmaps during teardown.

Fixes: e740003874ed ("octeontx2-af: Flow control resource management")
Cc: stable@vger.kernel.org
Signed-off-by: Bo Sun <bo@mboxify.com>
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Reviewed-by: Jijie Shao <shaojijie@huawei.com>
Link: https://patch.msgid.link/20260206130925.1087588-2-bo@mboxify.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
index 42044cd810b1f..fd4792e432bf0 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
@@ -1823,6 +1823,8 @@ static int cgx_lmac_exit(struct cgx *cgx)
 		cgx->mac_ops->mac_pause_frm_config(cgx, lmac->lmac_id, false);
 		cgx_configure_interrupt(cgx, lmac, lmac->lmac_id, true);
 		kfree(lmac->mac_to_index_bmap.bmap);
+		rvu_free_bitmap(&lmac->rx_fc_pfvf_bmap);
+		rvu_free_bitmap(&lmac->tx_fc_pfvf_bmap);
 		kfree(lmac->name);
 		kfree(lmac);
 	}
-- 
2.51.0





