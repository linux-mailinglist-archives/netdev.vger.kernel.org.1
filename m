Return-Path: <netdev+bounces-92817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A8A8B8F7F
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 20:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5474B2198B
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 18:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B201146D75;
	Wed,  1 May 2024 18:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RggH9Wn4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0694313C90C
	for <netdev@vger.kernel.org>; Wed,  1 May 2024 18:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714588034; cv=none; b=QbXV+OoToRk8enqoh6ShZtenu4XU6GfbaVMgDxxhuQhzXLJAZEbLtlD2WlzU8183jZT19oq/qAtfmfw0O1rqwgrutHWY56mh1Q86lLB3elYyAf+GTZbi3Cam4Vf9E3FRdY2yl0RmiResSjYhtoJ/YIc2TXgbQu0j1smldsHhuFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714588034; c=relaxed/simple;
	bh=oOd9JQzLEWHWWa8fk7XI19wrlsApCnvkDIU7qFceBPE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=T/f6g1ML+e9VaHSJpGOasoTOViU9+NizsImHSP5hFg5FHQXKF20DVhKOcTryaSQC1tsmSsVR73QqoELn0DqO7feS16FtXcrUD+8VNWuwuAx0OGYNmFJEKtxYdXiaZVnYoJY4HTfDTiLPwSmaDj6fUQDArQxKRugFIfMpWTGeL2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RggH9Wn4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4BBBC072AA;
	Wed,  1 May 2024 18:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714588033;
	bh=oOd9JQzLEWHWWa8fk7XI19wrlsApCnvkDIU7qFceBPE=;
	h=From:Date:Subject:To:Cc:From;
	b=RggH9Wn48EZ/MZLRbuhcPnD1DbJeP9zcRxa2Ao4aYk4ayFU9x7aXlIhZWhSpKy9Jr
	 4W85BAqvbbnE3Yn2rpuWejs6g5bMDzokJ4IRZcUgO+o9A2Qdlyqs2H0m32ew9m77GN
	 wlKKy+plDFdQ7nnTEwhHlm149FMvqnVch1JUDAMRRzdK8JS9fXCg0UVXNq3Ti176QZ
	 2/0XFZf4CYS6dSMKc+VP0giV353b97enaHV4tNnXP3KLlDDFf6UyoW4GhQj12ve0Tx
	 N8pdHLua2q3zQ6RTG9U4vr3qrP9QQTLg7Cu81MlEc9VphHsBldG/B9c5tJW8SD9OkG
	 2bIGN6/r1i5Tg==
From: Simon Horman <horms@kernel.org>
Date: Wed, 01 May 2024 19:27:09 +0100
Subject: [PATCH net-next] octeontx2-pf: Treat truncation of IRQ name as an
 error
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240501-octeon2-pf-irq_name-truncation-v1-1-5fbd7f9bb305@kernel.org>
X-B4-Tracking: v=1; b=H4sIAHyJMmYC/x2N0QrCMAxFf2Xk2UDbzRd/RURqTTUPpjPNZDD27
 ws+Hrjnng06KVOHy7CB0o87N3GIpwHKO8uLkJ/OkEKawjlEbMWoScK5Iuv3LvlDaLpIyeYqpsd
 Uc4lh9DH4yaxUef0HriBkKLQa3Pb9ABZdnwp6AAAA
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Sunil Goutham <sgoutham@marvell.com>, 
 Geethasowjanya Akula <gakula@marvell.com>, 
 Subbaraya Sundeep <sbhatta@marvell.com>, 
 Hariprasad Kelam <hkelam@marvell.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>, netdev@vger.kernel.org
X-Mailer: b4 0.12.3

According to GCC, the constriction of irq_name in otx2_open()
may, theoretically, be truncated.

This patch takes the approach of treating such a situation as an error
which it detects by making use of the return value of snprintf, which is
the total number of bytes, including the trailing '\0', that would have
been written.

Based on the approach taken to a similar problem in
commit 54b909436ede ("rtc: fix snprintf() checking in is_rtc_hctosys()")

Flagged by gcc-13 W=1 builds as:

.../otx2_pf.c:1933:58: warning: 'snprintf' output may be truncated before the last format character [-Wformat-truncation=]
 1933 |                 snprintf(irq_name, NAME_SIZE, "%s-rxtx-%d", pf->netdev->name,
      |                                                          ^
.../otx2_pf.c:1933:17: note: 'snprintf' output between 8 and 33 bytes into a destination of size 32
 1933 |                 snprintf(irq_name, NAME_SIZE, "%s-rxtx-%d", pf->netdev->name,
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1934 |                          qidx);
      |                          ~~~~~

Compile tested only.

Signed-off-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index 6a44dacff508..14bccff0ee5c 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -1886,9 +1886,17 @@ int otx2_open(struct net_device *netdev)
 	vec = pf->hw.nix_msixoff + NIX_LF_CINT_VEC_START;
 	for (qidx = 0; qidx < pf->hw.cint_cnt; qidx++) {
 		irq_name = &pf->hw.irq_name[vec * NAME_SIZE];
+		int name_len;
 
-		snprintf(irq_name, NAME_SIZE, "%s-rxtx-%d", pf->netdev->name,
-			 qidx);
+		name_len = snprintf(irq_name, NAME_SIZE, "%s-rxtx-%d",
+				    pf->netdev->name, qidx);
+		if (name_len >= NAME_SIZE) {
+			dev_err(pf->dev,
+				"RVUPF%d: IRQ registration failed for CQ%d, irq name is too long\n",
+				rvu_get_pf(pf->pcifunc), qidx);
+			err = -EINVAL;
+			goto err_free_cints;
+		}
 
 		err = request_irq(pci_irq_vector(pf->pdev, vec),
 				  otx2_cq_intr_handler, 0, irq_name,


