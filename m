Return-Path: <netdev+bounces-167787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD6CA3C4E4
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 17:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B848189C9D5
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 16:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629911FE474;
	Wed, 19 Feb 2025 16:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="up9c8D9n"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B49E1FDE11;
	Wed, 19 Feb 2025 16:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739982174; cv=none; b=VAE7arczpIy0rPPVmZwe2nhYNSs64RiIlKAa9ZFDhnnoWwxjeToNWfEc592+09+KGdzxkSJtKSlz9anWT83S5ZOT0OPcowG54JGPohdHfktR3e1Zn7Lz94Ke5AHHzEjppS44dpy8OG4zt+nLkMQ2v2Cm/KyI4pNTX0LG7JG/Vwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739982174; c=relaxed/simple;
	bh=QJygWqxo1Gm+lbSxhd/R3UrnFpOrkV+cHQEw/uDKvcM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JIjNGZUXbhxl3VyNhDRpYGR/cFGIdGq6wMTMuSbEgrTlxznNv4bkFlPqiVNGMp1QKj1xhmnmfxSXrLUtFTD1YFofpiNrLtGGRIc48Vc9tIwtm8vxN3n+MurFcY6tzLUqHsvU8q75+TCzWpvWIkO9Klq4VtCJP6ytn0D22O9Fr4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=up9c8D9n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 638E3C4CED1;
	Wed, 19 Feb 2025 16:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739982173;
	bh=QJygWqxo1Gm+lbSxhd/R3UrnFpOrkV+cHQEw/uDKvcM=;
	h=From:To:Cc:Subject:Date:From;
	b=up9c8D9nt5ihb0WJ/XZ9jdFRx0BnSokN8qn6CTYZ/9mY5Lo5yWr7B6YKyBQK9626M
	 cBHxIyDcyLYXUIDS9tZ//G0HvOhqi76JR4V1HiU8KVpxkysGkCqf+LK+/T3I9RXF7c
	 /++zhSfLqqT2F4xWgicl5KSPr7d0PrC4TaEHuWZLvnokvm8b9FkiCCFnIiDyVEwdrL
	 hFrR8BkFTz41/3nCZr8rhzWniPKmvuTk7zfPGOhualVnEKH8+x7mEQzRqsxOWdvkze
	 Socd3ajj394hplnfaR1kPfa4dwSt5H6UbONTNVbRvF1hD77GkAGRk7fMLntkOJCaxQ
	 2USG+dG3GOT7g==
From: Arnd Bergmann <arnd@kernel.org>
To: Sunil Goutham <sgoutham@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	hariprasad <hkelam@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Suman Ghosh <sumang@marvell.com>,
	Sai Krishna <saikrishnag@marvell.com>,
	Nithin Dabilpuram <ndabilpuram@marvell.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] [net-next v2] octeontx2: hide unused label
Date: Wed, 19 Feb 2025 17:21:14 +0100
Message-Id: <20250219162239.1376865-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

A previous patch introduces a build-time warning when CONFIG_DCB
is disabled:

drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c: In function 'otx2_probe':
drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c:3217:1: error: label 'err_free_zc_bmap' defined but not used [-Werror=unused-label]
drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c: In function 'otx2vf_probe':
drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c:740:1: error: label 'err_free_zc_bmap' defined but not used [-Werror=unused-label]

Add the same #ifdef check around it.

Fixes: efabce290151 ("octeontx2-pf: AF_XDP zero copy receive support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: fix typo s/CONfiG_DCB/CONFIG_DCB/
---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c | 2 ++
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index c7c562f0f5e5..cfed9ec5b157 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -3214,8 +3214,10 @@ static int otx2_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	return 0;
 
+#ifdef CONFIG_DCB
 err_free_zc_bmap:
 	bitmap_free(pf->af_xdp_zc_qidx);
+#endif
 err_sriov_cleannup:
 	otx2_sriov_vfcfg_cleanup(pf);
 err_pf_sriov_init:
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
index 63ddd262d122..7ef3ba477d49 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
@@ -737,8 +737,10 @@ static int otx2vf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	return 0;
 
+#ifdef CONFIG_DCB
 err_free_zc_bmap:
 	bitmap_free(vf->af_xdp_zc_qidx);
+#endif
 err_unreg_devlink:
 	otx2_unregister_dl(vf);
 err_shutdown_tc:
-- 
2.39.5


