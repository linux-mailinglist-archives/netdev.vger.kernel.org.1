Return-Path: <netdev+bounces-79064-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E091877B4E
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 08:25:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AEBB1C20BDE
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 07:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAEA5101E8;
	Mon, 11 Mar 2024 07:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lLyDxdUD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79BE63AE
	for <netdev@vger.kernel.org>; Mon, 11 Mar 2024 07:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710141950; cv=none; b=Z0tbRpL8HWxwb+9oEEkkd2Eien1iszdP4iDJToCDl0//oUpS48f0xiBEDlJPLAraeKgsV3dTSGBcyhlA1tcRbm2YfegQow3JgV++LRPt0CrtechYysbpl+exJZ48XLJYN1qHKkkabvWpOd9sc4isNnjzgMIRLTrNoNTZtCg88CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710141950; c=relaxed/simple;
	bh=NAfgclU5F8SNPwQ41IjiwkNoUcrNFui1EwN0HFRPA+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H5C/D3LtyGoLelrGVKtyb6DVonf1KlwegTbTskRyWIUYxbWonZ62pXYa/w8wAiwx7CnTmSpN7FnjoEltmmT1Pz8bAqKSt7Q8S3gmmztvRh9tbvWnyQUzsr3tcjiZEkz6U7cvKltj0EidU8x3jpkmjSco0LDQj/ZP00O14qujNbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lLyDxdUD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FAD8C433F1;
	Mon, 11 Mar 2024 07:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710141950;
	bh=NAfgclU5F8SNPwQ41IjiwkNoUcrNFui1EwN0HFRPA+s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lLyDxdUDdmcl1UCiHUq0wF5Xla1cPJm+eWSbwSSLeE2uImsexFoagHrt+VrzFpSOu
	 pLoUOeuFashlM/be9zwK9EardWV106zut+MU8MBQBqYchMPfwgacKLnFitF2C/Ut36
	 /6VbXHkhcDmt1KwfLcUbLbenJj/XEWAdGaMt0VEzBrWJ2jd8BZT37q1aY9CRPxRakW
	 Bhvqio6Do2r70CE3pkRwLJXBzzONoG3d4VF3fKiGpBmrw7lGK0onRRd5m0harsGMg4
	 09lPjQEoChUYjbBoiaMUFUMe3QLzG8uQ2/uMroHh2VGbwJZsY3pZjunlY/j2ek3/28
	 lxlhNHkZgcH6A==
Date: Mon, 11 Mar 2024 09:25:45 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Antony Antony <antony.antony@secunet.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
	devel@linux-ipsec.org
Subject: Re: [PATCH ipsec-next v2] xfrm: Add Direction to the SA in or out
Message-ID: <20240311072545.GI12921@unreal>
References: <d84a02e019ef188c4295089f6134af67ef7e7452.1709498351.git.antony.antony@secunet.com>
 <2a6015ddeb9dfff93ce6e2e25fec892a0d99acf1.1710100643.git.antony.antony@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a6015ddeb9dfff93ce6e2e25fec892a0d99acf1.1710100643.git.antony.antony@secunet.com>

On Sun, Mar 10, 2024 at 09:03:47PM +0100, Antony Antony wrote:
> This patch introduces the 'dir' attribute, 'in' or 'out', to the
> xfrm_state, SA, enhancing usability by delineating the scope of values
> based on direction. An input SA will now exclusively encompass values
> pertinent to input, effectively segregating them from output-related
> values. This change aims to streamline the configuration process and
> improve the overall clarity of SA attributes.
> 
> v1->v2:

Please try to avoid replying new patch versions as reply-to previous
versions. It breaks the threading and makes it hard to track the patches.

>  - use .strict_start_type in struct nla_policy xfrma_policy
>  - delete redundant XFRM_SA_DIR_MAX enum

Please put changelog after ---, it will allow us to make sure that
commit message will be clean once the patch is applied.

> 
> Signed-off-by: Antony Antony <antony.antony@secunet.com>
> ---
>  include/net/xfrm.h        |  1 +
>  include/uapi/linux/xfrm.h |  7 +++++++
>  net/xfrm/xfrm_compat.c    |  7 +++++--
>  net/xfrm/xfrm_device.c    |  5 +++++
>  net/xfrm/xfrm_state.c     |  1 +
>  net/xfrm/xfrm_user.c      | 44 +++++++++++++++++++++++++++++++++++----
>  6 files changed, 59 insertions(+), 6 deletions(-)
> 
> diff --git a/include/net/xfrm.h b/include/net/xfrm.h
> index 1d107241b901..91348a03469c 100644
> --- a/include/net/xfrm.h
> +++ b/include/net/xfrm.h
> @@ -289,6 +289,7 @@ struct xfrm_state {
>  	/* Private data of this transformer, format is opaque,
>  	 * interpreted by xfrm_type methods. */
>  	void			*data;
> +	enum xfrm_sa_dir	dir;
>  };
> 
>  static inline struct net *xs_net(struct xfrm_state *x)
> diff --git a/include/uapi/linux/xfrm.h b/include/uapi/linux/xfrm.h
> index 6a77328be114..46a9770c720c 100644
> --- a/include/uapi/linux/xfrm.h
> +++ b/include/uapi/linux/xfrm.h
> @@ -141,6 +141,12 @@ enum {
>  	XFRM_POLICY_MAX	= 3
>  };
> 
> +enum xfrm_sa_dir {
> +	XFRM_SA_DIR_UNSET = 0,

It doesn't belong to UAPI. Kernel and user space use netlink attribute to understand
if direction is set.

> +	XFRM_SA_DIR_IN	= 1,
> +	XFRM_SA_DIR_OUT	= 2
> +};
> +
>  enum {
>  	XFRM_SHARE_ANY,		/* No limitations */
>  	XFRM_SHARE_SESSION,	/* For this session only */
> @@ -315,6 +321,7 @@ enum xfrm_attr_type_t {
>  	XFRMA_SET_MARK_MASK,	/* __u32 */
>  	XFRMA_IF_ID,		/* __u32 */
>  	XFRMA_MTIMER_THRESH,	/* __u32 in seconds for input SA */
> +	XFRMA_SA_DIR,		/* __u8 */
>  	__XFRMA_MAX
> 
>  #define XFRMA_OUTPUT_MARK XFRMA_SET_MARK	/* Compatibility */
> diff --git a/net/xfrm/xfrm_compat.c b/net/xfrm/xfrm_compat.c
> index 655fe4ff8621..007dee03b1bc 100644
> --- a/net/xfrm/xfrm_compat.c
> +++ b/net/xfrm/xfrm_compat.c
> @@ -98,6 +98,7 @@ static const int compat_msg_min[XFRM_NR_MSGTYPES] = {
>  };
> 
>  static const struct nla_policy compat_policy[XFRMA_MAX+1] = {
> +	[XFRMA_UNSPEC]          = { .strict_start_type = XFRMA_SA_DIR },
>  	[XFRMA_SA]		= { .len = XMSGSIZE(compat_xfrm_usersa_info)},
>  	[XFRMA_POLICY]		= { .len = XMSGSIZE(compat_xfrm_userpolicy_info)},
>  	[XFRMA_LASTUSED]	= { .type = NLA_U64},
> @@ -129,6 +130,7 @@ static const struct nla_policy compat_policy[XFRMA_MAX+1] = {
>  	[XFRMA_SET_MARK_MASK]	= { .type = NLA_U32 },
>  	[XFRMA_IF_ID]		= { .type = NLA_U32 },
>  	[XFRMA_MTIMER_THRESH]	= { .type = NLA_U32 },
> +	[XFRMA_SA_DIR]          = { .type = NLA_U8}
>  };
> 
>  static struct nlmsghdr *xfrm_nlmsg_put_compat(struct sk_buff *skb,
> @@ -277,9 +279,10 @@ static int xfrm_xlate64_attr(struct sk_buff *dst, const struct nlattr *src)
>  	case XFRMA_SET_MARK_MASK:
>  	case XFRMA_IF_ID:
>  	case XFRMA_MTIMER_THRESH:
> +	case XFRMA_SA_DIR:
>  		return xfrm_nla_cpy(dst, src, nla_len(src));
>  	default:
> -		BUILD_BUG_ON(XFRMA_MAX != XFRMA_MTIMER_THRESH);
> +		BUILD_BUG_ON(XFRMA_MAX != XFRMA_SA_DIR);
>  		pr_warn_once("unsupported nla_type %d\n", src->nla_type);
>  		return -EOPNOTSUPP;
>  	}
> @@ -434,7 +437,7 @@ static int xfrm_xlate32_attr(void *dst, const struct nlattr *nla,
>  	int err;
> 
>  	if (type > XFRMA_MAX) {
> -		BUILD_BUG_ON(XFRMA_MAX != XFRMA_MTIMER_THRESH);
> +		BUILD_BUG_ON(XFRMA_MAX != XFRMA_SA_DIR);
>  		NL_SET_ERR_MSG(extack, "Bad attribute");
>  		return -EOPNOTSUPP;
>  	}
> diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
> index 3784534c9185..11339d7d7140 100644
> --- a/net/xfrm/xfrm_device.c
> +++ b/net/xfrm/xfrm_device.c
> @@ -253,6 +253,11 @@ int xfrm_dev_state_add(struct net *net, struct xfrm_state *x,
>  		return -EINVAL;
>  	}
> 
> +	if (xuo->flags & XFRM_OFFLOAD_INBOUND && x->dir != XFRM_SA_DIR_IN) {

It will break backward compatibility. In old iproute2 XFRM_OFFLOAD_INBOUND is set, but x->dir is not set yet.

> +		NL_SET_ERR_MSG(extack, "Mismatch in SA and offload direction");
> +		return -EINVAL;
> +	}
> +
>  	is_packet_offload = xuo->flags & XFRM_OFFLOAD_PACKET;

Thanks

