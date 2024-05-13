Return-Path: <netdev+bounces-96101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 904C88C4555
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 18:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3A311C2143B
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 16:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABBCE18C3D;
	Mon, 13 May 2024 16:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HP198nFL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849C21C680;
	Mon, 13 May 2024 16:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715619098; cv=none; b=YnvKHYn8Sau6pps5hubpp62KDFEb3qzJlNHDqglTgmamjMML7QrIC3lA8Vas+FAX7XPKDUKOsgmjo3ZNQYHE+HtpVvUXv+BIvbR34BtApZpqJDOy1dQi0sXrck1m+8S8dvDaqmoxTgin/o6NETok9eAo4vg+xwKhFOR1VUj3sE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715619098; c=relaxed/simple;
	bh=yJ/MMFLcNTPl27dnPO3ITE5THMb1MLtJhvhlBn1heAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U+3ymjXe2keGQZQZxBmdkgfquaQOhP1Eq0zsGxc7hkNULOZaEJttSTD8hxTW8QMwq3K/syf4d20xEG0tZwoNs9cQnXC+T+0gW7J4s3SwHZKFWhoE2tg8C4MwgbbbIi7f2h60Omx999ZDRa3eJNAmbQtfY2QZzC9IZM548rhmnQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HP198nFL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C661C113CC;
	Mon, 13 May 2024 16:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715619098;
	bh=yJ/MMFLcNTPl27dnPO3ITE5THMb1MLtJhvhlBn1heAo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HP198nFLfQVHY4E0LaCXcxEzzS1V/FwH3EGuT4g5SVzPaD47iK9/8GU1koo45z9S1
	 XWeEs4q8VAfhwQzNN1qCIRWt0rPr8qYAzWGj+c7SwLcGte1H/DI8l9pBkkJB4CP6Zt
	 rc30H2Gg7a13vfmJmah3jZGLfM1MHW7+XCnTCBw/Z0XtTJjE+YLRE5M7WxMjlm2Mp4
	 cUJv0iNmRPnDSJXqZ7ULzBHMxT16wCaqRivuSQvCKArwLFEVR9PhaQ2mZiexaOQmK6
	 09T7Fj0+HF2by/rYX5BccCeU2d3qjQn8mgYn2K+qhZ+Ht0+76MFdREYUHc0Vxn65MQ
	 iTmgpm7KDUFPg==
Date: Mon, 13 May 2024 17:51:33 +0100
From: Simon Horman <horms@kernel.org>
To: Bharat Bhushan <bbhushan2@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
	hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, jerinj@marvell.com,
	lcherian@marvell.com, richardcochran@gmail.com
Subject: Re: [net-next,v2 5/8] cn10k-ipsec: Add SA add/delete support for
 outb inline ipsec
Message-ID: <20240513165133.GS2787@kernel.org>
References: <20240513105446.297451-1-bbhushan2@marvell.com>
 <20240513105446.297451-6-bbhushan2@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513105446.297451-6-bbhushan2@marvell.com>

On Mon, May 13, 2024 at 04:24:43PM +0530, Bharat Bhushan wrote:
> This patch adds support to add and delete Security Association
> (SA) xfrm ops. Hardware maintains SA context in memory allocated
> by software. Each SA context is 128 byte aligned and size of
> each context is multiple of 128-byte. Add support for transport
> and tunnel ipsec mode, ESP protocol, aead aes-gcm-icv16, key size
> 128/192/256-bits with 32bit salt.
> 
> Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
> ---
> v1->v2:
>  - Use dma_wmb() instead of architecture specific barrier
> 
>  .../marvell/octeontx2/nic/cn10k_ipsec.c       | 433 +++++++++++++++++-
>  .../marvell/octeontx2/nic/cn10k_ipsec.h       | 114 +++++
>  2 files changed, 546 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c

...

> @@ -356,6 +362,414 @@ static int cn10k_outb_cpt_clean(struct otx2_nic *pf)
>  	return err;
>  }
>  
> +static int cn10k_outb_get_sa_index(struct otx2_nic *pf,
> +				   struct cn10k_tx_sa_s *sa_entry)
> +{
> +	u32 sa_size = pf->ipsec.sa_size;
> +	u32 sa_index;
> +
> +	if (!sa_entry || ((void *)sa_entry < pf->ipsec.outb_sa->base))
> +		return -EINVAL;
> +
> +	sa_index = ((void *)sa_entry - pf->ipsec.outb_sa->base) / sa_size;
> +	if (sa_index >= CN10K_IPSEC_OUTB_MAX_SA)
> +		return -EINVAL;
> +
> +	return sa_index;
> +}
> +
> +static dma_addr_t cn10k_outb_get_sa_iova(struct otx2_nic *pf,
> +					 struct cn10k_tx_sa_s *sa_entry)
> +{
> +	u32 sa_index = cn10k_outb_get_sa_index(pf, sa_entry);
> +
> +	if (sa_index < 0)
> +		return 0;

Should the type of sa_index be int?
That would match the return type of cn10k_outb_get_sa_index.

Otherwise, testing for < 0 will always be false.

Likewise in cn10k_outb_free_sa and cn10k_ipsec_del_state.

Flagged by Smatch.

> +	return pf->ipsec.outb_sa->iova + sa_index * pf->ipsec.sa_size;
> +}

...

> +static int cn10k_outb_write_sa(struct otx2_nic *pf, struct cn10k_tx_sa_s *sa_cptr)
> +{
> +	dma_addr_t res_iova, dptr_iova, sa_iova;
> +	struct cn10k_tx_sa_s *sa_dptr;
> +	struct cpt_inst_s inst;
> +	struct cpt_res_s *res;
> +	u32 sa_size, off;
> +	u64 reg_val;
> +	int ret;
> +
> +	sa_iova = cn10k_outb_get_sa_iova(pf, sa_cptr);
> +	if (!sa_iova)
> +		return -EINVAL;
> +
> +	res = dma_alloc_coherent(pf->dev, sizeof(struct cpt_res_s),
> +				 &res_iova, GFP_ATOMIC);
> +	if (!res)
> +		return -ENOMEM;
> +
> +	sa_size = sizeof(struct cn10k_tx_sa_s);
> +	sa_dptr = dma_alloc_coherent(pf->dev, sa_size, &dptr_iova, GFP_ATOMIC);
> +	if (!sa_dptr) {
> +		dma_free_coherent(pf->dev, sizeof(struct cpt_res_s), res,
> +				  res_iova);
> +		return -ENOMEM;
> +	}
> +
> +	for (off = 0; off < (sa_size / 8); off++)
> +		*((u64 *)sa_dptr + off) = cpu_to_be64(*((u64 *)sa_cptr + off));

Given the layout of struct cn10k_tx_sa_s, it's not clear
to me how it makes sense for it to be used to store big endian quadwords.
Which is a something that probably ought to be addressed.

But if not, Sparse complains about the endienness of the types used
above. I think it wants:

	*((__be64 *)sa_dptr + off)

> +
> +	memset(&inst, 0, sizeof(struct cpt_inst_s));
> +
> +	res->compcode = CN10K_CPT_COMP_E_NOTDONE;
> +	inst.res_addr = res_iova;
> +	inst.dptr = (u64)dptr_iova;
> +	inst.param2 = sa_size >> 3;
> +	inst.dlen = sa_size;
> +	inst.opcode_major = CN10K_IPSEC_MAJOR_OP_WRITE_SA;
> +	inst.opcode_minor = CN10K_IPSEC_MINOR_OP_WRITE_SA;
> +	inst.cptr = sa_iova;
> +	inst.ctx_val = 1;
> +	inst.egrp = CN10K_DEF_CPT_IPSEC_EGRP;
> +
> +	cn10k_cpt_inst_flush(pf, &inst, sizeof(struct cpt_inst_s));
> +	dma_wmb();
> +	ret = cn10k_wait_for_cpt_respose(pf, res);
> +	if (ret)
> +		goto out;
> +
> +	/* Trigger CTX flush to write dirty data back to DRAM */
> +	reg_val = FIELD_PREP(CPT_LF_CTX_FLUSH, sa_iova >> 7);
> +	otx2_write64(pf, CN10K_CPT_LF_CTX_FLUSH, reg_val);
> +
> +out:
> +	dma_free_coherent(pf->dev, sa_size, sa_dptr, dptr_iova);
> +	dma_free_coherent(pf->dev, sizeof(struct cpt_res_s), res, res_iova);
> +	return ret;
> +}

...

> +static void cn10k_outb_prepare_sa(struct xfrm_state *x,
> +				  struct cn10k_tx_sa_s *sa_entry)
> +{
> +	int key_len = (x->aead->alg_key_len + 7) / 8;
> +	struct net_device *netdev = x->xso.dev;
> +	u8 *key = x->aead->alg_key;
> +	struct otx2_nic *pf;
> +	u32 *tmp_salt;
> +	u64 *tmp_key;
> +	int idx;
> +
> +	memset(sa_entry, 0, sizeof(struct cn10k_tx_sa_s));
> +
> +	/* context size, 128 Byte aligned up */
> +	pf = netdev_priv(netdev);
> +	sa_entry->ctx_size = (pf->ipsec.sa_size / OTX2_ALIGN)  & 0xF;
> +	sa_entry->hw_ctx_off = cn10k_ipsec_get_hw_ctx_offset();
> +	sa_entry->ctx_push_size = cn10k_ipsec_get_ctx_push_size();
> +
> +	/* Ucode to skip two words of CPT_CTX_HW_S */
> +	sa_entry->ctx_hdr_size = 1;
> +
> +	/* Allow Atomic operation (AOP) */
> +	sa_entry->aop_valid = 1;
> +
> +	/* Outbound, ESP TRANSPORT/TUNNEL Mode, AES-GCM with AES key length
> +	 * 128bit.
> +	 */
> +	sa_entry->sa_dir = CN10K_IPSEC_SA_DIR_OUTB;
> +	sa_entry->ipsec_protocol = CN10K_IPSEC_SA_IPSEC_PROTO_ESP;
> +	sa_entry->enc_type = CN10K_IPSEC_SA_ENCAP_TYPE_AES_GCM;
> +	if (x->props.mode == XFRM_MODE_TUNNEL)
> +		sa_entry->ipsec_mode = CN10K_IPSEC_SA_IPSEC_MODE_TUNNEL;
> +	else
> +		sa_entry->ipsec_mode = CN10K_IPSEC_SA_IPSEC_MODE_TRANSPORT;
> +
> +	sa_entry->spi = cpu_to_be32(x->id.spi);

The type of spi is a 32-bit bitfield of a 64-bit unsigned host endien integer.

1. I suspect it would make more sense to declare that field as a 32bit integer.
2. It is being assigned a big endian value.  That doesn't seem right.

The second issue was flagged by Sparse.

> +
> +	/* Last 4 bytes are salt */
> +	key_len -= 4;
> +	sa_entry->aes_key_len = cn10k_ipsec_get_aes_key_len(key_len);
> +	memcpy(sa_entry->cipher_key, key, key_len);
> +	tmp_key = (u64 *)sa_entry->cipher_key;
> +
> +	for (idx = 0; idx < key_len / 8; idx++)
> +		tmp_key[idx] = be64_to_cpu(tmp_key[idx]);

More endian problems flagged by Sparse on this line.
An integer variable should typically be used to store
a big endian value, a little endian value, or a host endian value.
Not more than one of these.

This is because tooling such as Sparse can then be used to verify
the correctness of the endian used.

> +
> +	memcpy(&sa_entry->iv_gcm_salt, key + key_len, 4);
> +	tmp_salt = (u32 *)&sa_entry->iv_gcm_salt;
> +	*tmp_salt = be32_to_cpu(*tmp_salt);

Likewise here.

> +
> +	/* Write SA context data to memory before enabling */
> +	wmb();
> +
> +	/* Enable SA */
> +	sa_entry->sa_valid = 1;
> +}

...

> +static int cn10k_ipsec_add_state(struct xfrm_state *x,
> +				 struct netlink_ext_ack *extack)
> +{
> +	struct net_device *netdev = x->xso.dev;
> +	struct cn10k_tx_sa_s *sa_entry;
> +	struct cpt_ctx_info_s *sa_info;
> +	struct otx2_nic *pf;
> +	int err;
> +
> +	err = cn10k_ipsec_validate_state(x);
> +	if (err)
> +		return err;
> +
> +	if (x->xso.dir == XFRM_DEV_OFFLOAD_IN) {
> +		netdev_err(netdev, "xfrm inbound offload not supported\n");
> +		err = -ENODEV;

This path results in pf being dereferenced while uninitialised
towards the bottom of this function.

Flagged by Smatch, and Clang-18 W=1 build

> +	} else {
> +		pf = netdev_priv(netdev);
> +		if (!mutex_trylock(&pf->ipsec.lock)) {
> +			netdev_err(netdev, "IPSEC device is busy\n");
> +			return -EBUSY;
> +		}
> +
> +		if (!(pf->flags & OTX2_FLAG_INLINE_IPSEC_ENABLED)) {
> +			netdev_err(netdev, "IPSEC not enabled/supported on device\n");
> +			err = -ENODEV;
> +			goto unlock;
> +		}
> +
> +		sa_entry = cn10k_outb_alloc_sa(pf);
> +		if (!sa_entry) {
> +			netdev_err(netdev, "SA maximum limit %x reached\n",
> +				   CN10K_IPSEC_OUTB_MAX_SA);
> +			err = -EBUSY;
> +			goto unlock;
> +		}
> +
> +		cn10k_outb_prepare_sa(x, sa_entry);
> +
> +		err = cn10k_outb_write_sa(pf, sa_entry);
> +		if (err) {
> +			netdev_err(netdev, "Error writing outbound SA\n");
> +			cn10k_outb_free_sa(pf, sa_entry);
> +			goto unlock;
> +		}
> +
> +		sa_info = kmalloc(sizeof(*sa_info), GFP_KERNEL);
> +		sa_info->sa_entry = sa_entry;
> +		sa_info->sa_iova = cn10k_outb_get_sa_iova(pf, sa_entry);
> +		x->xso.offload_handle = (unsigned long)sa_info;
> +	}
> +
> +unlock:
> +	mutex_unlock(&pf->ipsec.lock);
> +	return err;
> +}

...

> +static const struct xfrmdev_ops cn10k_ipsec_xfrmdev_ops = {
> +	.xdo_dev_state_add	= cn10k_ipsec_add_state,
> +	.xdo_dev_state_delete	= cn10k_ipsec_del_state,
> +};
> +

cn10k_ipsec_xfrmdev_ops is unused.
Perhaps it, along with it's callbacks,
should be added by the function that uses it?

Flagged by W=1 builds.

>  int cn10k_ipsec_ethtool_init(struct net_device *netdev, bool enable)
>  {
>  	struct otx2_nic *pf = netdev_priv(netdev);

...

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.h b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.h

...

> +struct cn10k_tx_sa_s {
> +	u64 esn_en		: 1; /* W0 */
> +	u64 rsvd_w0_1_8		: 8;
> +	u64 hw_ctx_off		: 7;
> +	u64 ctx_id		: 16;
> +	u64 rsvd_w0_32_47	: 16;
> +	u64 ctx_push_size	: 7;
> +	u64 rsvd_w0_55		: 1;
> +	u64 ctx_hdr_size	: 2;
> +	u64 aop_valid		: 1;
> +	u64 rsvd_w0_59		: 1;
> +	u64 ctx_size		: 4;
> +	u64 w1;			/* W1 */
> +	u64 sa_valid		: 1; /* W2 */
> +	u64 sa_dir		: 1;
> +	u64 rsvd_w2_2_3		: 2;
> +	u64 ipsec_mode		: 1;
> +	u64 ipsec_protocol	: 1;
> +	u64 aes_key_len		: 2;
> +	u64 enc_type		: 3;
> +	u64 rsvd_w2_11_31	: 21;
> +	u64 spi			: 32;
> +	u64 w3;			/* W3 */
> +	u8 cipher_key[32];	/* W4 - W7 */
> +	u32 rsvd_w8_0_31;	/* W8 : IV */
> +	u32 iv_gcm_salt;
> +	u64 rsvd_w9_w30[22];	/* W9 - W30 */
> +	u64 hw_ctx[6];		/* W31 - W36 */
> +};

...

