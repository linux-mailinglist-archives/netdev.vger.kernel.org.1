Return-Path: <netdev+bounces-248761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 357C9D0DEE2
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 00:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BAC8330351C2
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 22:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287D72609E3;
	Sat, 10 Jan 2026 22:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i0gVpZ4u"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C16229B38;
	Sat, 10 Jan 2026 22:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768085977; cv=none; b=j5kfsyBTGE1BbMyjvdw3VdlhfaFaiokmjnJs9aX6NwgyvHYtYzHjHJOvnlc3bEbqDsxMKHbpCL89VgdzYqa0ToWOdJYGFuXu4WiRa8HpfFsp1/K2bz8EYOXgz2n2N+VmxTephFXNz7cUeQTgmQ5jN8Q/9VUO3kMZU3+0su5fr0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768085977; c=relaxed/simple;
	bh=8nJIJf4VR9k4k83MdY9jNcYfgph5NN8HRYtc95S7wOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZB7/CRDLHsI0hbtWHBKhLZhoZFCRLykFsu2aXOCZnPe0kAKJ04eGOvc0yamew4rrjXXJ44tywjCdATQ7Bme/BSUkrtOUUC6WLAG62EMqGD5oPuYdwA/OqrTjmGgYOjzhaCrnbO6ZP2iCoK6w0WYq1JiWtjdBV+7QEu+bjy+8NJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i0gVpZ4u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 943CAC4CEF1;
	Sat, 10 Jan 2026 22:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768085974;
	bh=8nJIJf4VR9k4k83MdY9jNcYfgph5NN8HRYtc95S7wOM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i0gVpZ4u8jyvGgkRI2gdFOCV6FWgCjfbJ2YZvIacvhh5ITf3o+Qo5K0TY41oVE4cq
	 lnNk0lbRNUj74e+QHe4s8BJrpnOAeh6PZkCuWOfqfNlV0QqD8arr1DRDZ56dcqCna4
	 AFi2qmuzTYEGgiicvDA2Hz6t+WJ7kh/0IT2v9pn+DkcuFUW/sGbUoZfpktj/sXx8DN
	 g0/HjpBqQtfZdNomXcpbGYAWZVroY4V/exBANmzRRtUyFb2jLVCvlW2yjFuF1veSZp
	 hGuVbe3XdeYNX0ozG5yA5ElsLwqTAJMsn8EsO/bGnUVZ7B0A/zuFtXl5iyJ2VIiqVL
	 HPx6IguBnz2uQ==
From: Jakub Kicinski <kuba@kernel.org>
To: rkannoth@marvell.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next,v3,04/13] ocetontx2-af: npc: cn20k: MKEX profile support
Date: Sat, 10 Jan 2026 14:59:32 -0800
Message-ID: <20260110225932.3900827-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109054828.1822307-5-rkannoth@marvell.com>
References: <20260109054828.1822307-5-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least pausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
ocetontx2-af: npc: cn20k: MKEX profile support

This patch adds MKEX profile support for the cn20k silicon variant,
introducing a new key extractor concept with up to 24 extractors per
packet parsing profile.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
> index 316e6cd1436a..88d7f65d246c 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c

[ ... ]

> +void npc_cn20k_load_mkex_profile(struct rvu *rvu, int blkaddr,
> +				 const char *mkex_profile)
> +{
> +	struct npc_mcam_kex_extr *mcam_kex_extr;
> +	struct device *dev = &rvu->pdev->dev;
> +	void __iomem *mkex_prfl_addr = NULL;
> +	u64 prfl_sz;
> +	int ret;
> +
> +	/* If user not selected mkex profile */
> +	if (rvu->kpu_fwdata_sz ||
> +	    !strncmp(mkex_profile, cn20k_def_pfl_name, MKEX_NAME_LEN))
> +		goto program_mkex_extr;
> +
> +	/* Setting up the mapping for mkex profile image */
> +	ret = npc_fwdb_prfl_img_map(rvu, &mkex_prfl_addr, &prfl_sz);
> +	if (ret < 0)
> +		goto program_mkex_extr;
> +
> +	mcam_kex_extr = (struct npc_mcam_kex_extr __force *)mkex_prfl_addr;
> +
> +	while (((s64)prfl_sz > 0) && (mcam_kex_extr->mkex_sign != MKEX_END_SIGN)) {
> +		/* Compare with mkex mod_param name string */
> +		if (mcam_kex_extr->mkex_sign == MKEX_CN20K_SIGN &&
> +		    !strncmp(mcam_kex_extr->name, mkex_profile, MKEX_NAME_LEN)) {
> +			rvu->kpu.mcam_kex_prfl.mkex_extr = mcam_kex_extr;
> +			goto program_mkex_extr;
> +		}
> +
> +		mcam_kex_extr++;
> +		prfl_sz -= sizeof(struct npc_mcam_kex);
                                 ^^^^^^^^^^^^^^^^^^^^^

The loop iterates over struct npc_mcam_kex_extr entries (the pointer
mcam_kex_extr is advanced by sizeof(struct npc_mcam_kex_extr) via
mcam_kex_extr++), but the size decrement uses sizeof(struct npc_mcam_kex).

These structures have different sizes:
- struct npc_mcam_kex_extr contains intf_extr_lid[2][24] and
  intf_extr_lt[2][24][16] arrays
- struct npc_mcam_kex contains intf_lid_lt_ld[2][8][16][2] and
  intf_ld_flags[2][2][16] arrays

Should this be sizeof(struct npc_mcam_kex_extr) to match the pointer
increment? Otherwise the loop termination condition will be incorrect
and could read beyond the profile buffer boundaries.

> +	}
> +	dev_warn(dev, "Failed to load requested profile: %s\n", mkex_profile);

[ ... ]

