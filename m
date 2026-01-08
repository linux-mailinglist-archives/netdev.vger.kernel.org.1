Return-Path: <netdev+bounces-248216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A36ED05430
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 18:58:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C1917309E9C3
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 17:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A692EC0B3;
	Thu,  8 Jan 2026 17:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S8A9KR1/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E472E8DFD;
	Thu,  8 Jan 2026 17:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767894842; cv=none; b=eRw2S/CrSR/Z+OVm6ornHa86JmveHkKTj8gkr0R3Y8hngbjZCrXz98bGvu0vlQq4sPzwtBAudMhKFyB5sm7Q+o1yEehTVdepXuQn2x9g37SCTivS6dI5LJR5mdo/lE6YSPzL/GJksNzyOnVebRfboj0xBGVx/iK4lrqaRDLAuVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767894842; c=relaxed/simple;
	bh=XhMdckBQEozroMmVJtq6WzdPWV2xeheplbnmN6AiSLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mTEKIFteEXXMcX3s+xvxYhI3muCQiqZwC72+eViscXjFUnnGZ/tbbqCtzyuE9AO3Zc8phxqipsrlIa7hbz7geEOrO0ZT13JQlOqzke2aZuF+cS/zR0KqIXlzVJ48sonNccEGB2Jf0vr7q6l8q+FFgV/X+BQLSuhpBmuJMzPtCbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S8A9KR1/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8AABC116C6;
	Thu,  8 Jan 2026 17:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767894842;
	bh=XhMdckBQEozroMmVJtq6WzdPWV2xeheplbnmN6AiSLI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S8A9KR1/mZlIqe5BDLemIsKiTwDtLHt3W494ck1q2cDHqd4eUrwBvuLv3qVW8TbsJ
	 GlazU43AR2yvdojM7nRekffxkBg2sS10TLARYogYB1MsxNyRntMBc5R++auRNTt6B4
	 mpLPJwnQgorcldDft2WDVrezeLWUT5gNZb+ECAsX43c3hE17XQK6d5JrzkCrYJppOS
	 KjgPLE88/Lu1ysoCCXh656434bz9FqLjha0CGuTA72BdPnJjxcAyvsNw2xWfYHfR7z
	 9Ua7yWhT5AEMRp+tSeW+LByMkHAIfnG3FzqF/uMsals7youdPr/voJnUHV+C8Yw6Lp
	 sz6S6mrssWdjQ==
Date: Thu, 8 Jan 2026 17:53:57 +0000
From: Simon Horman <horms@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	sgoutham@marvell.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
	sumang@marvell.com
Subject: Re: [PATCH net-next 01/13] octeontx2-af: npc: cn20k: Index management
Message-ID: <20260108175357.GJ345651@kernel.org>
References: <20260105023254.1426488-1-rkannoth@marvell.com>
 <20260105023254.1426488-2-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260105023254.1426488-2-rkannoth@marvell.com>

On Mon, Jan 05, 2026 at 08:02:42AM +0530, Ratheesh Kannoth wrote:

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.c
> index 498968bf4cf5..c7c59a98d969 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.c
> @@ -11,7 +11,189 @@
>  #include <linux/pci.h>
>  
>  #include "struct.h"
> +#include "rvu.h"
>  #include "debugfs.h"
> +#include "cn20k/npc.h"
> +
> +static void npc_subbank_srch_order_dbgfs_usage(void)
> +{
> +	pr_err("Usage: echo \"[0]=[8],[1]=7,[2]=30,...[31]=0\" > <debugfs>/subbank_srch_order\n");
> +}
> +
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
> +
> +		if (strlen(t1) < 3) {
> +			pr_err("%s:%d Bad Token %s=%s\n",
> +			       __func__, __LINE__, t1, t2);
> +			goto err;
> +		}
> +
> +		if (t1[0] != '[' || t1[strlen(t1) - 1] != ']') {
> +			pr_err("%s:%d Bad Token %s=%s\n",
> +			       __func__, __LINE__, t1, t2);

Hi Ratheesh,

FWIIW, I would advocate slightly more descriptive and thus unique
error messages and dropping __func__ and __LINE__ from logs,
here and elsewhere.

The __func__, and in particular __LINE__ information will only
tend to change as the file is up dated, and so any debugging will
need to know the source that the kernel was compiled from.

And I'd say that given the state of debugging functionality in the kernel -
e..g dynamic tracepoints - this is not as useful as it may seem at first.

...

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c

...

> +static int npc_multi_subbank_ref_alloc(struct rvu *rvu, int key_type,
> +				       int ref, int limit, int prio,
> +				       bool contig, int count,
> +				       u16 *mcam_idx)
> +{
> +	struct npc_subbank *sb;
> +	unsigned long *bmap;
> +	int sb_off, off, rc;
> +	int cnt = 0;
> +	bool bitset;
> +
> +	if (prio != NPC_MCAM_HIGHER_PRIO) {
> +		while (ref <= limit) {
> +			/* Calculate subbank and subbank index */
> +			rc =  npc_mcam_idx_2_subbank_idx(rvu, ref,
> +							 &sb, &sb_off);
> +			if (rc)
> +				goto err;
> +
> +			/* If subbank is not suitable for requested key type
> +			 * restart search from next subbank
> +			 */
> +			if (!npc_subbank_suits(sb, key_type)) {
> +				ref = SB_ALIGN_UP(ref);
> +				if (contig) {
> +					rc = npc_idx_free(rvu, mcam_idx,
> +							  cnt, false);
> +					if (rc)
> +						return rc;
> +					cnt = 0;
> +				}
> +				continue;
> +			}
> +
> +			mutex_lock(&sb->lock);
> +
> +			/* If subbank is free; mark it as used */
> +			if (sb->flags & NPC_SUBBANK_FLAG_FREE) {
> +				rc =  __npc_subbank_mark_used(rvu, sb,
> +							      key_type);
> +				if (rc) {
> +					mutex_unlock(&sb->lock);
> +					dev_err(rvu->dev,
> +						"%s:%d Error to add to use array\n",
> +						__func__, __LINE__);
> +					goto err;
> +				}
> +			}
> +
> +			/* Find correct bmap */
> +			__npc_subbank_sboff_2_off(rvu, sb, sb_off, &bmap, &off);
> +
> +			/* if bit is already set, reset 'cnt' */
> +			bitset = test_bit(off, bmap);
> +			if (bitset) {
> +				mutex_unlock(&sb->lock);
> +				if (contig) {
> +					rc = npc_idx_free(rvu, mcam_idx,
> +							  cnt, false);
> +					if (rc)
> +						return rc;
> +					cnt = 0;
> +				}
> +
> +				ref++;
> +				continue;
> +			}
> +
> +			set_bit(off, bmap);
> +			sb->free_cnt--;
> +			mcam_idx[cnt++] = ref;
> +			mutex_unlock(&sb->lock);
> +
> +			if (cnt == count)
> +				return 0;
> +			ref++;
> +		}
> +
> +		/* Could not allocate request count slots */
> +		goto err;
> +	}
> +	while (ref >= limit) {
> +		rc =  npc_mcam_idx_2_subbank_idx(rvu, ref,
> +						 &sb, &sb_off);
> +		if (rc)
> +			goto err;
> +
> +		if (!npc_subbank_suits(sb, key_type)) {
> +			ref = SB_ALIGN_DOWN(ref) - 1;
> +			if (contig) {
> +				rc = npc_idx_free(rvu, mcam_idx, cnt, false);
> +				if (rc)
> +					return rc;
> +
> +				cnt = 0;
> +			}
> +			continue;
> +		}
> +
> +		mutex_lock(&sb->lock);
> +
> +		if (sb->flags & NPC_SUBBANK_FLAG_FREE) {
> +			rc =  __npc_subbank_mark_used(rvu, sb, key_type);
> +			if (rc) {
> +				mutex_unlock(&sb->lock);
> +				dev_err(rvu->dev,
> +					"%s:%d Error to add to use array\n",
> +					__func__, __LINE__);
> +				goto err;
> +			}
> +		}
> +
> +		__npc_subbank_sboff_2_off(rvu, sb, sb_off, &bmap, &off);
> +		bitset = test_bit(off, bmap);
> +		if (bitset) {
> +			mutex_unlock(&sb->lock);
> +			if (contig) {
> +				cnt = 0;
> +				rc = npc_idx_free(rvu, mcam_idx, cnt, false);
> +				if (rc)
> +					return rc;

Claude Code with Review Prompts [1] flags that the call to npc_idx_free()
is a noop because count is reset to 0 before (rather than after) it is
called.

> +			}
> +			ref--;
> +			continue;
> +		}
> +
> +		mcam_idx[cnt++] = ref;
> +		sb->free_cnt--;
> +		set_bit(off, bmap);
> +		mutex_unlock(&sb->lock);
> +
> +		if (cnt == count)
> +			return 0;
> +		ref--;
> +	}
> +
> +err:
> +	rc = npc_idx_free(rvu, mcam_idx, cnt, false);
> +	if (rc)
> +		dev_err(rvu->dev,
> +			"%s:%d Error happened while freeing cnt=%u indexes\n",
> +			__func__, __LINE__, cnt);
> +
> +	return -ENOSPC;
> +}
> +
> +static int npc_subbank_free_cnt(struct rvu *rvu, struct npc_subbank *sb,
> +				int key_type)
> +{
> +	int cnt, spd;
> +
> +	spd = npc_priv.subbank_depth;
> +	mutex_lock(&sb->lock);
> +
> +	if (sb->flags & NPC_SUBBANK_FLAG_FREE)
> +		cnt = key_type == NPC_MCAM_KEY_X4 ? spd : 2 * spd;
> +	else
> +		cnt = sb->free_cnt;
> +
> +	mutex_unlock(&sb->lock);
> +	return cnt;
> +}
> +
> +static int npc_subbank_ref_alloc(struct rvu *rvu, int key_type,
> +				 int ref, int limit, int prio,
> +				 bool contig, int count,
> +				 u16 *mcam_idx)
> +{
> +	struct npc_subbank *sb1, *sb2;
> +	bool max_alloc, start, stop;
> +	int r, l, sb_idx1, sb_idx2;
> +	int tot = 0, rc;
> +	int alloc_cnt;
> +
> +	max_alloc = !contig;
> +
> +	start = true;
> +	stop = false;
> +
> +	/* Loop until we cross the ref/limit boundary */
> +	while (!stop) {
> +		rc = npc_subbank_iter(rvu, key_type, ref, limit, prio,
> +				      &r, &l, &start, &stop);
> +
> +		dev_dbg(rvu->dev,
> +			"%s:%d ref=%d limit=%d r=%d l=%d start=%d stop=%d tot=%d count=%d rc=%d\n",
> +			__func__, __LINE__, ref, limit, r, l,
> +			start, stop, tot, count, rc);
> +
> +		if (rc)
> +			goto err;
> +
> +		/* Find subbank and subbank index for ref */
> +		rc = npc_mcam_idx_2_subbank_idx(rvu, r, &sb1,
> +						&sb_idx1);
> +		if (rc)
> +			goto err;
> +
> +		dev_dbg(rvu->dev,
> +			"%s:%d ref subbank=%d off=%d\n",
> +			__func__, __LINE__, sb1->idx, sb_idx1);
> +
> +		/* Skip subbank if it is not available for the keytype */
> +		if (!npc_subbank_suits(sb1, key_type)) {
> +			dev_dbg(rvu->dev,
> +				"%s:%d not suitable sb=%d key_type=%d\n",
> +				__func__, __LINE__, sb1->idx, key_type);
> +			continue;
> +		}
> +
> +		/* Find subbank and subbank index for limit */
> +		rc = npc_mcam_idx_2_subbank_idx(rvu, l, &sb2,
> +						&sb_idx2);
> +		if (rc)
> +			goto err;
> +
> +		dev_dbg(rvu->dev,
> +			"%s:%d limit subbank=%d off=%d\n",
> +			__func__, __LINE__, sb_idx1, sb_idx2);
> +
> +		/* subbank of ref and limit should be same */
> +		if (sb1 != sb2) {
> +			dev_err(rvu->dev,
> +				"%s:%d l(%d) and r(%d) are not in same subbank\n",
> +				__func__, __LINE__, r, l);
> +			goto err;
> +		}
> +
> +		if (contig &&
> +		    npc_subbank_free_cnt(rvu, sb1, key_type) < count) {
> +			dev_dbg(rvu->dev, "%s:%d less count =%d\n",
> +				__func__, __LINE__,
> +				npc_subbank_free_cnt(rvu, sb1, key_type));
> +			continue;
> +		}
> +
> +		/* Try in one bank of a subbank */
> +		alloc_cnt = 0;
> +		rc =  npc_subbank_alloc(rvu, sb1, key_type,
> +					r, l, prio, contig,
> +					count - tot, mcam_idx + tot,
> +					count - tot, max_alloc,
> +					&alloc_cnt);
> +
> +		tot += alloc_cnt;
> +
> +		dev_dbg(rvu->dev, "%s:%d Allocated tot=%d alloc_cnt=%d\n",
> +			__func__, __LINE__, tot, alloc_cnt);
> +
> +		if (!rc && count == tot)
> +			return 0;
> +	}
> +err:
> +	dev_dbg(rvu->dev, "%s:%d Error to allocate\n",
> +		__func__, __LINE__);
> +
> +	/* non contiguous allocation fails. We need to do clean up */
> +	if (max_alloc) {
> +		rc = npc_idx_free(rvu, mcam_idx, tot, false);
> +		if (rc)
> +			dev_err(rvu->dev,
> +				"%s:%d failed to free %u indexes\n",
> +				__func__, __LINE__, tot);
> +	}
> +
> +	return -EFAULT;
> +}
> +
> +/* Minimize allocation from bottom and top subbanks for noref allocations.
> + * Default allocations are ref based, and will be allocated from top
> + * subbanks (least priority subbanks). Since default allocation is at very
> + * early stage of kernel netdev probes, this subbanks will be moved to
> + * used subbanks list. This will pave a way for noref allocation from these
> + * used subbanks. Skip allocation for these top and bottom, and try free
> + * bank next. If none slot is available, come back and search in these
> + * subbanks.
> + */
> +
> +static int npc_subbank_restricted_idxs[2];
> +static bool restrict_valid = true;
> +
> +static bool npc_subbank_restrict_usage(struct rvu *rvu, int index)
> +{
> +	int i;
> +
> +	if (!restrict_valid)
> +		return false;
> +
> +	for (i = 0; i < ARRAY_SIZE(npc_subbank_restricted_idxs); i++) {
> +		if (index == npc_subbank_restricted_idxs[i])
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +static int npc_subbank_noref_alloc(struct rvu *rvu, int key_type, bool contig,
> +				   int count, u16 *mcam_idx)
> +{
> +	struct npc_subbank *sb;
> +	unsigned long index;
> +	int tot = 0, rc;
> +	bool max_alloc;
> +	int alloc_cnt;
> +	int idx, i;
> +	void *val;
> +
> +	max_alloc = !contig;
> +
> +	/* Check used subbanks for free slots */
> +	xa_for_each(&npc_priv.xa_sb_used, index, val) {
> +		idx = xa_to_value(val);
> +
> +		/* Minimize allocation from restricted subbanks
> +		 * in noref allocations.
> +		 */
> +		if (npc_subbank_restrict_usage(rvu, idx))
> +			continue;
> +
> +		sb = &npc_priv.sb[idx];
> +
> +		/* Skip if not suitable subbank */
> +		if (!npc_subbank_suits(sb, key_type))
> +			continue;
> +
> +		if (contig && npc_subbank_free_cnt(rvu, sb, key_type) < count)
> +			continue;
> +
> +		/* try in bank 0. Try passing ref and limit equal to
> +		 * subbank boundaries
> +		 */
> +		alloc_cnt = 0;
> +		rc =  npc_subbank_alloc(rvu, sb, key_type,
> +					sb->b0b, sb->b0t, 0,
> +					contig, count - tot,
> +					mcam_idx + tot,
> +					count - tot,
> +					max_alloc, &alloc_cnt);
> +
> +		/* Non contiguous allocation may allocate less than
> +		 * requested 'count'.
> +		 */
> +		tot += alloc_cnt;
> +
> +		dev_dbg(rvu->dev,
> +			"%s:%d Allocated %d from subbank %d, tot=%d count=%d\n",
> +			__func__, __LINE__, alloc_cnt, sb->idx, tot, count);
> +
> +		/* Successfully allocated */
> +		if (!rc && count == tot)
> +			return 0;
> +
> +		/* x4 entries can be allocated from bank 0 only */
> +		if (key_type == NPC_MCAM_KEY_X4)
> +			continue;
> +
> +		/* try in bank 1 for x2 */
> +		alloc_cnt = 0;
> +		rc =  npc_subbank_alloc(rvu, sb, key_type,
> +					sb->b1b, sb->b1t, 0,
> +					contig, count - tot,
> +					mcam_idx + tot,
> +					count - tot, max_alloc,
> +					&alloc_cnt);
> +
> +		tot += alloc_cnt;
> +
> +		dev_dbg(rvu->dev,
> +			"%s:%d Allocated %d from subbank %d, tot=%d count=%d\n",
> +			__func__, __LINE__, alloc_cnt, sb->idx, tot, count);
> +
> +		if (!rc && count == tot)
> +			return 0;
> +	}
> +
> +	/* Allocate in free subbanks */
> +	xa_for_each(&npc_priv.xa_sb_free, index, val) {
> +		idx = xa_to_value(val);
> +		sb = &npc_priv.sb[idx];
> +
> +		/* Minimize allocation from restricted subbanks
> +		 * in noref allocations.
> +		 */
> +		if (npc_subbank_restrict_usage(rvu, idx))
> +			continue;
> +
> +		if (!npc_subbank_suits(sb, key_type))
> +			continue;
> +
> +		/* try in bank 0 */
> +		alloc_cnt = 0;
> +		rc =  npc_subbank_alloc(rvu, sb, key_type,
> +					sb->b0b, sb->b0t, 0,
> +					contig, count - tot,
> +					mcam_idx + tot,
> +					count - tot,
> +					max_alloc, &alloc_cnt);
> +
> +		tot += alloc_cnt;
> +
> +		dev_dbg(rvu->dev,
> +			"%s:%d Allocated %d from subbank %d, tot=%d count=%d\n",
> +			__func__, __LINE__, alloc_cnt, sb->idx, tot, count);
> +
> +		/* Successfully allocated */
> +		if (!rc && count == tot)
> +			return 0;
> +
> +		/* x4 entries can be allocated from bank 0 only */
> +		if (key_type == NPC_MCAM_KEY_X4)
> +			continue;
> +
> +		/* try in bank 1 for x2 */
> +		alloc_cnt = 0;
> +		rc =  npc_subbank_alloc(rvu, sb,
> +					key_type, sb->b1b, sb->b1t, 0,
> +					contig, count - tot,
> +					mcam_idx + tot, count - tot,
> +					max_alloc, &alloc_cnt);
> +
> +		tot += alloc_cnt;
> +
> +		dev_dbg(rvu->dev,
> +			"%s:%d Allocated %d from subbank %d, tot=%d count=%d\n",
> +			__func__, __LINE__, alloc_cnt, sb->idx, tot, count);
> +
> +		if (!rc && count == tot)
> +			return 0;
> +	}
> +
> +	/* Allocate from restricted subbanks */
> +	for (i = 0; restrict_valid &&
> +	     (i < ARRAY_SIZE(npc_subbank_restricted_idxs)); i++) {
> +		idx = npc_subbank_restricted_idxs[i];
> +		sb = &npc_priv.sb[idx];
> +
> +		/* Skip if not suitable subbank */
> +		if (!npc_subbank_suits(sb, key_type))
> +			continue;
> +
> +		if (contig && npc_subbank_free_cnt(rvu, sb, key_type) < count)
> +			continue;
> +
> +		/* try in bank 0. Try passing ref and limit equal to
> +		 * subbank boundaries
> +		 */
> +		alloc_cnt = 0;
> +		rc =  npc_subbank_alloc(rvu, sb, key_type,
> +					sb->b0b, sb->b0t, 0,
> +					contig, count - tot,
> +					mcam_idx + tot,
> +					count - tot,
> +					max_alloc, &alloc_cnt);
> +
> +		/* Non contiguous allocation may allocate less than
> +		 * requested 'count'.
> +		 */
> +		tot += alloc_cnt;
> +
> +		dev_dbg(rvu->dev,
> +			"%s:%d Allocated %d from subbank %d, tot=%d count=%d\n",
> +			__func__, __LINE__, alloc_cnt, sb->idx, tot, count);
> +
> +		/* Successfully allocated */
> +		if (!rc && count == tot)
> +			return 0;
> +
> +		/* x4 entries can be allocated from bank 0 only */
> +		if (key_type == NPC_MCAM_KEY_X4)
> +			continue;
> +
> +		/* try in bank 1 for x2 */
> +		alloc_cnt = 0;
> +		rc =  npc_subbank_alloc(rvu, sb, key_type,
> +					sb->b1b, sb->b1t, 0,
> +					contig, count - tot,
> +					mcam_idx + tot,
> +					count - tot, max_alloc,
> +					&alloc_cnt);
> +
> +		tot += alloc_cnt;
> +
> +		dev_dbg(rvu->dev,
> +			"%s:%d Allocated %d from subbank %d, tot=%d count=%d\n",
> +			__func__, __LINE__, alloc_cnt, sb->idx, tot, count);
> +
> +		if (!rc && count == tot)
> +			return 0;
> +	}
> +
> +	/* non contiguous allocation fails. We need to do clean up */
> +	if (max_alloc)
> +		npc_idx_free(rvu, mcam_idx, tot, false);
> +
> +	dev_dbg(rvu->dev, "%s:%d non-contig allocation fails\n",
> +		__func__, __LINE__);
> +
> +	return -EFAULT;
> +}
> +
> +int npc_cn20k_idx_free(struct rvu *rvu, u16 *mcam_idx, int count)
> +{
> +	return npc_idx_free(rvu, mcam_idx, count, true);
> +}
> +
> +int npc_cn20k_ref_idx_alloc(struct rvu *rvu, int pcifunc, int key_type,
> +			    int prio, u16 *mcam_idx, int ref, int limit,
> +			    bool contig, int count)
> +{
> +	int i, eidx, rc, bd;
> +	bool ref_valid;
> +
> +	bd = npc_priv.bank_depth;
> +
> +	/* Special case: ref == 0 && limit= 0 && prio == HIGH && count == 1
> +	 * Here user wants to allocate 0th entry
> +	 */
> +	if (!ref && !limit && prio == NPC_MCAM_HIGHER_PRIO &&
> +	    count == 1) {
> +		rc = npc_subbank_ref_alloc(rvu, key_type, ref, limit,
> +					   prio, contig, count, mcam_idx);
> +
> +		if (rc)
> +			return rc;
> +		goto add2map;
> +	}
> +
> +	ref_valid = !!(limit || ref);
> +	if (!ref_valid) {
> +		if (contig && count > npc_priv.subbank_depth)
> +			goto try_noref_multi_subbank;
> +
> +		rc = npc_subbank_noref_alloc(rvu, key_type, contig,
> +					     count, mcam_idx);
> +		if (!rc)
> +			goto add2map;
> +
> +try_noref_multi_subbank:
> +		eidx = (key_type == NPC_MCAM_KEY_X4) ? bd - 1 : 2 * bd - 1;
> +
> +		if (prio == NPC_MCAM_HIGHER_PRIO)
> +			rc = npc_multi_subbank_ref_alloc(rvu, key_type,
> +							 eidx, 0,
> +							 NPC_MCAM_HIGHER_PRIO,
> +							 contig, count,
> +							 mcam_idx);
> +		else
> +			rc = npc_multi_subbank_ref_alloc(rvu, key_type,
> +							 0, eidx,
> +							 NPC_MCAM_LOWER_PRIO,
> +							 contig, count,
> +							 mcam_idx);
> +
> +		if (!rc)
> +			goto add2map;
> +
> +		return rc;
> +	}
> +
> +	if ((prio == NPC_MCAM_LOWER_PRIO && ref > limit) ||
> +	    (prio == NPC_MCAM_HIGHER_PRIO && ref < limit)) {
> +		dev_err(rvu->dev, "%s:%d Wrong ref_enty(%d) or limit(%d)\n",
> +			__func__, __LINE__, ref, limit);
> +		return -EINVAL;
> +	}
> +
> +	if ((key_type == NPC_MCAM_KEY_X4 && (ref >= bd || limit >= bd)) ||
> +	    (key_type == NPC_MCAM_KEY_X2 &&
> +	     (ref >= 2 * bd || limit >= 2 * bd))) {
> +		dev_err(rvu->dev, "%s:%d Wrong ref_enty(%d) or limit(%d)\n",
> +			__func__, __LINE__, ref, limit);
> +		return -EINVAL;
> +	}
> +
> +	if (contig && count > npc_priv.subbank_depth)
> +		goto try_ref_multi_subbank;
> +
> +	rc = npc_subbank_ref_alloc(rvu, key_type, ref, limit,
> +				   prio, contig, count, mcam_idx);
> +	if (!rc)
> +		goto add2map;
> +
> +try_ref_multi_subbank:
> +	rc = npc_multi_subbank_ref_alloc(rvu, key_type,
> +					 ref, limit, prio,
> +					 contig, count, mcam_idx);
> +	if (!rc)
> +		goto add2map;
> +
> +	return rc;
> +
> +add2map:
> +	for (i = 0; i < count; i++) {
> +		rc = npc_add_to_pf_maps(rvu, mcam_idx[i], pcifunc);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	return 0;
> +}
> +
> +void npc_cn20k_subbank_calc_free(struct rvu *rvu, int *x2_free,
> +				 int *x4_free, int *sb_free)
> +{
> +	struct npc_subbank *sb;
> +	int i;
> +
> +	/* Reset all stats to zero */
> +	*x2_free = 0;
> +	*x4_free = 0;
> +	*sb_free = 0;
> +
> +	for (i = 0; i < npc_priv.num_subbanks; i++) {
> +		sb = &npc_priv.sb[i];
> +		mutex_lock(&sb->lock);
> +
> +		/* Count number of free subbanks */
> +		if (sb->flags & NPC_SUBBANK_FLAG_FREE) {
> +			(*sb_free)++;
> +			goto next;
> +		}
> +
> +		/* Sumup x4 free count */
> +		if (sb->key_type == NPC_MCAM_KEY_X4) {
> +			(*x4_free) += sb->free_cnt;
> +			goto next;
> +		}
> +
> +		/* Sumup x2 free counts */
> +		(*x2_free) += sb->free_cnt;
> +next:
> +		mutex_unlock(&sb->lock);
> +	}
> +}
> +
> +int
> +rvu_mbox_handler_npc_cn20k_get_free_count(struct rvu *rvu,
> +					  struct msg_req *req,
> +					  struct npc_cn20k_get_free_count_rsp *rsp)
> +{
> +	npc_cn20k_subbank_calc_free(rvu, &rsp->free_x2,
> +				    &rsp->free_x4, &rsp->free_subbanks);
> +	return 0;
> +}
> +
> +static void npc_lock_all_subbank(void)
> +{
> +	int i;
> +
> +	for (i = 0; i < npc_priv.num_subbanks; i++)
> +		mutex_lock(&npc_priv.sb[i].lock);
> +}
> +
> +static void npc_unlock_all_subbank(void)
> +{
> +	int i;
> +
> +	for (i = npc_priv.num_subbanks - 1; i >= 0; i--)
> +		mutex_unlock(&npc_priv.sb[i].lock);
> +}
> +
> +static int *subbank_srch_order;
> +

> +int npc_cn20k_search_order_set(struct rvu *rvu, int (*arr)[2], int cnt)
> +{
> +	struct npc_mcam *mcam = &rvu->hw->mcam;
> +	u8 (*fslots)[2], (*uslots)[2];
> +	int fcnt = 0, ucnt = 0;
> +	struct npc_subbank *sb;
> +	unsigned long index;
> +	int idx, val;
> +	void *v;
> +
> +	if (cnt != npc_priv.num_subbanks)
> +		return -EINVAL;
> +
> +	fslots = kcalloc(cnt, sizeof(*fslots), GFP_KERNEL);
> +	if (!fslots)
> +		return -ENOMEM;
> +
> +	uslots = kcalloc(cnt, sizeof(*uslots), GFP_KERNEL);
> +	if (!uslots)
> +		return -ENOMEM;
> +
> +	for (int i = 0; i < cnt; i++, arr++) {
> +		idx = (*arr)[0];
> +		val = (*arr)[1];

FWIIW, I think this would be slightly more clearly expressed as:

		idx = arr[i][0];
		val = arr[i][0];

Likewise for uslots and fslots below.

> +
> +		subbank_srch_order[idx] = val;
> +	}
> +
> +	/* Lock mcam */
> +	mutex_lock(&mcam->lock);
> +	npc_lock_all_subbank();
> +
> +	restrict_valid = false;
> +
> +	xa_for_each(&npc_priv.xa_sb_used, index, v) {
> +		val = xa_to_value(v);
> +		(*(uslots + ucnt))[0] = index;
> +		(*(uslots + ucnt))[1] = val;
> +		xa_erase(&npc_priv.xa_sb_used, index);
> +		ucnt++;
> +	}
> +
> +	xa_for_each(&npc_priv.xa_sb_free, index, v) {
> +		val = xa_to_value(v);
> +		(*(fslots + fcnt))[0] = index;
> +		(*(fslots + fcnt))[1] = val;
> +		xa_erase(&npc_priv.xa_sb_free, index);
> +		fcnt++;
> +	}
> +
> +	for (int i = 0; i < ucnt; i++) {
> +		idx  = (*(uslots + i))[1];
> +		sb = &npc_priv.sb[idx];
> +		sb->arr_idx = subbank_srch_order[sb->idx];
> +		xa_store(&npc_priv.xa_sb_used, sb->arr_idx,
> +			 xa_mk_value(sb->idx), GFP_KERNEL);
> +	}
> +
> +	for (int i = 0; i < fcnt; i++) {
> +		idx  = (*(fslots + i))[1];
> +		sb = &npc_priv.sb[idx];
> +		sb->arr_idx = subbank_srch_order[sb->idx];
> +		xa_store(&npc_priv.xa_sb_free, sb->arr_idx,
> +			 xa_mk_value(sb->idx), GFP_KERNEL);
> +	}
> +
> +	npc_unlock_all_subbank();
> +	mutex_unlock(&mcam->lock);
> +
> +	kfree(fslots);
> +	kfree(uslots);
> +
> +	return 0;
> +}

...

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
> new file mode 100644
> index 000000000000..e1191d3d03cb
> --- /dev/null
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
> @@ -0,0 +1,65 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Marvell RVU Admin Function driver
> + *
> + * Copyright (C) 2026 Marvell.
> + *
> + */
> +
> +#ifndef NPC_CN20K_H
> +#define NPC_CN20K_H
> +
> +#define MAX_NUM_BANKS 2
> +#define MAX_NUM_SUB_BANKS 32
> +#define MAX_SUBBANK_DEPTH 256
> +
> +enum npc_subbank_flag {
> +	NPC_SUBBANK_FLAG_UNINIT,	// npc_subbank is not initialized yet.
> +	NPC_SUBBANK_FLAG_FREE = BIT(0),	// No slot allocated
> +	NPC_SUBBANK_FLAG_USED = BIT(1), // At least one slot allocated
> +};

I would suggest using Kernel doc formatting for the documentation
the enum above and two structs below.

> +
> +struct npc_subbank {
> +	u16 b0t, b0b, b1t, b1b;		// mcam indexes of this subbank
> +	enum npc_subbank_flag flags;
> +	struct mutex lock;		// for flags & rsrc modification
> +	DECLARE_BITMAP(b0map, MAX_SUBBANK_DEPTH);	// for x4 and x2
> +	DECLARE_BITMAP(b1map, MAX_SUBBANK_DEPTH);	// for x2 only
> +	u16 idx;	// subbank index, 0 to npc_priv.subbank - 1
> +	u16 arr_idx;	// Index to the free array or used array
> +	u16 free_cnt;	// number of free slots;
> +	u8 key_type;	//NPC_MCAM_KEY_X4 or NPC_MCAM_KEY_X2
> +};
> +
> +struct npc_priv_t {
> +	int bank_depth;
> +	const int num_banks;
> +	int num_subbanks;
> +	int subbank_depth;
> +	u8 kw;				// Kex configure Keywidth.
> +	struct npc_subbank *sb;		// Array of subbanks
> +	struct xarray xa_sb_used;	// xarray of used subbanks
> +	struct xarray xa_sb_free;	// xarray of free subbanks
> +	struct xarray *xa_pf2idx_map;	// Each PF to map its mcam idxes
> +	struct xarray xa_idx2pf_map;	// Mcam idxes to pf map.
> +	struct xarray xa_pf_map;	// pcifunc to index map.
> +	int pf_cnt;
> +	bool init_done;
> +};

...

