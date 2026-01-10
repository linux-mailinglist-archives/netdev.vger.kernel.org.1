Return-Path: <netdev+bounces-248759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DB6D0DED7
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 23:59:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4CE373014BC6
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 22:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B9222A1E1;
	Sat, 10 Jan 2026 22:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bteg4YCt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512AD221DAE;
	Sat, 10 Jan 2026 22:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768085972; cv=none; b=epK3onDK7hsD6xf1lmC6esek7EMQYpqpOKSdbyfiuSQN35PYj9bhr3SWaeQzE6Q+wLHvmGcsJV6x/sdfu1Vu2pIsRid52K4R9RVva6DXbKLgrJPiAczEcnjLfNxBpSGRNlczIkvrWiJ76hkldvioyd1XS0Z8Np0veemmfI6wX+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768085972; c=relaxed/simple;
	bh=jzl4uDBBMfWma4AtEvHbwMhLgOOaOcQ0tHsjx9VXFJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BeiuRqHMFypaSlNKwlw2N9dzrx9Dp3h5d0T1lFsHlCxEXGdpZiIF+ZAKuBAXEpBnfkZUv8k/gj0ClTSNLlU8DyYkXx/SIp1yAhU2JnooZLPeVICFc4sbT2M9gxCp7foGtVC9TWVWSKKoU4KvAItmEoaa4e/0G9sgxOqUNCx3q84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bteg4YCt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC91DC4CEF1;
	Sat, 10 Jan 2026 22:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768085971;
	bh=jzl4uDBBMfWma4AtEvHbwMhLgOOaOcQ0tHsjx9VXFJ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bteg4YCtqBQ0kpQ0q+p62bOimnWpoi56gjE7mj2vx4WjBQpRCf6nLWM3dOnaLg3e9
	 Bb9x36+FI4Az8HB4kBBdhmjPvNUUbRj0TyKndnrnIkhkQFiFar73eEXXXXLjVMp7jl
	 dxlghU082ICU07amKxcLl+RwvUTwaGwX3VzXJZ8aZfN9n4FmO0ahM/alF7vHzid5X1
	 U6NowKykPwxoqvA42DK2wZ9nwjCBds4/q8GI6Pcq5aliAxBtXKCFvg/iY5TEhz/3/p
	 54wCIS58jKwRWpFKB/Yg3fO6ORBrR3Xy5DQCJh7xXW9rMf3qSBPdEe0sv1Z4JZ5nIx
	 FNg79kZZCzxQA==
From: Jakub Kicinski <kuba@kernel.org>
To: rkannoth@marvell.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next,v3,01/13] octeontx2-af: npc: cn20k: Index management
Date: Sat, 10 Jan 2026 14:59:27 -0800
Message-ID: <20260110225927.3900742-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109054828.1822307-2-rkannoth@marvell.com>
References: <20260109054828.1822307-2-rkannoth@marvell.com>
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
octeontx2-af: npc: cn20k: Index management

This patch adds MCAM index management for CN20K silicon, implementing
allocation schemes for contiguous and non-contiguous MCAM entry
allocation across 32 subbanks.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.c
> index 498968bf4cf5..9360886c88e2 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.c

[ ... ]

> +static int
> +npc_subbank_srch_order_parse_n_fill(struct rvu *rvu, char *options,
> +				    int num_subbanks)
> +{
> +	unsigned long w1 = 0, w2 = 0;
> +	char *p, *t1, *t2;
> +	int (*arr)[2];
> +	int idx, val;
> +	int cnt, ret;
> +
> +	cnt = 0;
> +
> +	options[strcspn(options, "\r\n")] = 0;
> +
> +	arr = kcalloc(num_subbanks, sizeof(*arr), GFP_KERNEL);
> +	if (!arr)
> +		return -ENOMEM;
> +
> +	while ((p = strsep(&options, " ,")) != NULL) {
> +		if (!*p)
> +			continue;
> +
> +		t1 = strsep(&p, "=");
> +		t2 = strsep(&p, "");

If the user input does not contain an '=' character, strsep() will return
NULL for t2 here.  The subsequent kstrtoint(t2, ...) call would then
dereference a NULL pointer.  Should there be a check for t2 being NULL
before using it?

> +
> +		if (strlen(t1) < 3) {
> +			dev_err(rvu->dev,
> +				"Token length is less than 3 (%s, %s)\n",
> +				t1, t2);
> +			goto err;
> +		}

[ ... ]

> +		ret = kstrtoint(t2, 10, &val);
> +		if (ret) {
> +			dev_err(rvu->dev,
> +				"Could not convert token to integer (%s)\n",
> +				t2);
> +			goto err;
> +		}
> +
> +		arr[cnt][0] = idx;
> +		arr[cnt][1] = val;
> +
> +		cnt++;

The loop writes to arr[cnt] before checking whether cnt exceeds
num_subbanks.  If a user provides more tokens than expected, this could
overflow the arr[] buffer.  The bounds check occurs after the loop
completes, but by then the overflow may have already happened.  Would
it make sense to check cnt < num_subbanks before writing to arr[cnt]?

> +	}
> +
> +	if (cnt != num_subbanks) {
> +		dev_err(rvu->dev,
> +			"Could find %u tokens, but exact %u tokens needed\n",
> +			cnt, num_subbanks);
> +		goto err;
> +	}

[ ... ]

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
> new file mode 100644
> index 000000000000..c05c0feec41d
> --- /dev/null
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c

[ ... ]

> +static int __maybe_unused
> +npc_add_to_pf_maps(struct rvu *rvu, u16 mcam_idx, int pcifunc)
> +{
> +	int rc, idx;
> +	void *map;
> +
> +	dev_dbg(rvu->dev,
> +		"%s:%d add2maps mcam_idx(%u) to xa_idx2pf map pcifunc=%#x\n",
> +		__func__, __LINE__, mcam_idx, pcifunc);
> +
> +	rc = xa_insert(&npc_priv.xa_idx2pf_map, mcam_idx,
> +		       xa_mk_value(pcifunc), GFP_KERNEL);
> +
> +	if (rc) {
> +		map = xa_load(&npc_priv.xa_idx2pf_map, mcam_idx);
> +		dev_err(rvu->dev,
> +			"%s:%d failed to insert mcam_idx(%u) to xa_idx2pf map, existing value=%lu\n",
> +			__func__, __LINE__, mcam_idx, xa_to_value(map));
> +		return -EFAULT;
> +	}
> +
> +	map = xa_load(&npc_priv.xa_pf_map, pcifunc);
> +	idx = xa_to_value(map);
> +
> +	rc = xa_insert(&npc_priv.xa_pf2idx_map[idx], mcam_idx,
> +		       xa_mk_value(pcifunc), GFP_KERNEL);
> +
> +	if (rc) {
> +		map = xa_load(&npc_priv.xa_pf2idx_map[idx], mcam_idx);
> +		dev_err(rvu->dev,
> +			"%s:%d failed to insert mcam_idx(%u) to xa_pf2idx_map map, earlier value=%lu idx=%u\n",
> +			__func__, __LINE__, mcam_idx, xa_to_value(map), idx);
> +		return -EFAULT;
> +	}

If the second xa_insert() fails, the entry inserted by the first
xa_insert() into xa_idx2pf_map is not cleaned up.  This leaves the two
maps in an inconsistent state.  Should the first entry be erased when
the second insert fails?

[ ... ]

> +static int npc_priv_init(struct rvu *rvu)
> +{
> +	struct npc_mcam *mcam = &rvu->hw->mcam;
> +	int blkaddr, num_banks, bank_depth;
> +	int num_subbanks, subbank_depth;
> +	u64 npc_const1, npc_const2 = 0;
> +	struct npc_subbank *sb;
> +	u64 cfg;
> +	int i;
> +
> +	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
> +	if (blkaddr < 0) {
> +		dev_err(rvu->dev, "%s:%d NPC block not implemented\n",
> +			__func__, __LINE__);
> +		return -ENODEV;
> +	}
> +
> +	npc_const1 = rvu_read64(rvu, blkaddr, NPC_AF_CONST1);
> +	if (npc_const1 & BIT_ULL(63))
> +		npc_const2 = rvu_read64(rvu, blkaddr, NPC_AF_CONST2);
> +
> +	num_banks = mcam->banks;
> +	bank_depth = mcam->banksize;
> +
> +	num_subbanks = FIELD_GET(GENMASK_ULL(39, 32), npc_const2);
> +	npc_priv.num_subbanks = num_subbanks;
> +
> +	subbank_depth =	bank_depth / num_subbanks;

If npc_const1 does not have bit 63 set, npc_const2 remains 0, and
num_subbanks will be 0.  This would cause a division by zero here.
Should there be a check that num_subbanks is non-zero before this
division?

