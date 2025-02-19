Return-Path: <netdev+bounces-167758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17726A3C20E
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 15:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC44E3A6C7D
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 14:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17771EB1BE;
	Wed, 19 Feb 2025 14:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hO51AGUz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8501DFE32;
	Wed, 19 Feb 2025 14:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739975086; cv=none; b=XpyGQKVgzPq71lZRmYbiEiyoUju1WKkyHv35XkMZZYuEfGcm2CNdQ7vPL7nc8rIyqnuTPPEFS+JLiHy9/e3XlCuwbxhXwRcKwpQvn9wQlhlB/m5klNEOBnRfFdAfpiEvV8Gr8r1a/7wAe2UA8YYFwEQmWlqZG5TUw9ooyobFh1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739975086; c=relaxed/simple;
	bh=mb10HQrEop5yEH1vJsBuc9BfNSAg9pXQ07Kq29Cz/3I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NV2Gs6s9KD4OH8JFcTbUzzUGZhQLGECa49kPPvqmvAcMi/9TAYaX+PI4CEsZ5fVb3PhffTEMXRyhPH0XlSXsDbAqlFoSanKOwxSVlrupW6vAE0gsq6ztyODwZlkJP1GXTj3YWxvb+a2ZaOOocXPFQ6TqFE2mh2a7ZGzr/fJnkdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hO51AGUz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 308E5C4CED1;
	Wed, 19 Feb 2025 14:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739975086;
	bh=mb10HQrEop5yEH1vJsBuc9BfNSAg9pXQ07Kq29Cz/3I=;
	h=From:To:Cc:Subject:Date:From;
	b=hO51AGUzLeToDnMwzJdCR7KOFwTXKqQmNsJ7bUPBsyPWZqS0woYeWrrhCOoTnyX/N
	 GCX35wXWLAaGfmvml4ZAVzeYSjlsdGZfyND0WjU6YzHETI1xf8vgDKcMz3Wdlv80hm
	 Ax8EJVePGOpkaw8rz+X7StChQYuGLVHbdlF4+cNh1AIDfCYyGMEeZtKjjGxbfgRMyR
	 BzfX6A0zBFYHj/6nWbEPB7cuSJXwrUNt0w3rvdO9BK5Vl0MJk6D4zBo+lUjfgY8u+j
	 CBXBB56QVLvpS3dJNI68ydA/i3jtJu6ZChQn4y0ctFhKTgMrwLb65tnHfyj18KCysc
	 59sEVZqUA1Gzw==
From: Arnd Bergmann <arnd@kernel.org>
To: Sunil Goutham <sgoutham@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	hariprasad <hkelam@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Arnd Bergmann <arnd@arndb.de>,
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
Subject: [PATCH net-next] octeontx2: hide unused label
Date: Wed, 19 Feb 2025 15:24:14 +0100
Message-Id: <20250219142433.63312-1-arnd@kernel.org>
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
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c | 2 ++
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index c7c562f0f5e5..4873225f77be 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -3214,8 +3214,10 @@ static int otx2_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	return 0;
 
+#ifdef CONfiG_DCB
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


