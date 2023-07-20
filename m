Return-Path: <netdev+bounces-19677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA78175BA3B
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 00:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7442728207D
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 22:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5411DDCC;
	Thu, 20 Jul 2023 22:02:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23B41DDC2
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 22:02:30 +0000 (UTC)
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52757B3
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 15:02:29 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-55c79a5565aso653425a12.3
        for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 15:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689890549; x=1690495349;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MKkV/hvl8zsv9VEF8qSlJkJZ3nqSZuQ1lQ6/GJnu7hQ=;
        b=3AbNINHLLCKgzOX8OtpaOXEae3IR0N6cMtWa3+PYwW0ptaG+g8yQz2w9YvyusK26CO
         WMoxAwxDr45CXuT4Ld3gt18lvSvjuvMZali1nScoXOFKCA2u/sd1xTF8/akW+w5/ot6o
         BVT78J0sXyMd+oS3urUSStGbuRxmjHKOidJu54CM0Kt7F11E7iLZ7emDZgkKoVX7BvUA
         FtZixb2Ocmz/ufD+Q9McpKLDm9CQ2FMjsDda1yOw8HoN2NBDnu+bHLJ7AVyk6qXA4lqc
         Rr2c8+7PgSrcbYaxcl8hs6CfLoE/fba5ApbiGOOWL1rojtw0H/wCcPtvwSjkZ/GiT1z4
         i/Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689890549; x=1690495349;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MKkV/hvl8zsv9VEF8qSlJkJZ3nqSZuQ1lQ6/GJnu7hQ=;
        b=lTCx6tIhUu0vdzsRdMLfG9sEEQepEEkfuGnJj9iUECh27BpkQK/+MsbVYl1dVkhPMA
         k14nGe7eKLlFcKV6YXs6UlnOaGSSFlVcq6SdZWBGkyf7+9rTmvn+R/njXkE6Sq9QxNOY
         /DmE8qjX7mVAr6Fk/v1D06hoDyCVWDHow7WjI1LMa1SIePYgxUNetKXP4LCOQij/K7Ro
         BvHz+R4Rofbm1V6H+dpiYmw3KhiPaQSIdAh3tLE1AHWScx+9P12rCX9L9qcr19j1ET5B
         QatIQXuLLljquxkXPgw4x14cFdYgquesrZnZPia4SvyY36mCSYd35Fs/y58OgW31wmEH
         v0zA==
X-Gm-Message-State: ABy/qLYsCbiMl3kFuhizPHfrU1WUugkxUZXAKfTgdBQGypINoY+3TV8a
	+kae2rwgbCGDoiRAqaIm8nblweA=
X-Google-Smtp-Source: APBJJlHbKJzJBb962pqujdHLwOt8POeol8cf8FuiBme1npkxEvJgBOtXGPlBT0AIksLvSyslDoLEuL4=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a63:9507:0:b0:55c:2f9e:af2b with SMTP id
 p7-20020a639507000000b0055c2f9eaf2bmr34376pgd.12.1689890548729; Thu, 20 Jul
 2023 15:02:28 -0700 (PDT)
Date: Thu, 20 Jul 2023 15:02:27 -0700
In-Reply-To: <20230719183734.21681-18-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230719183734.21681-1-larysa.zaremba@intel.com> <20230719183734.21681-18-larysa.zaremba@intel.com>
Message-ID: <ZLmu8wdmgOWNIjgz@google.com>
Subject: Re: [PATCH bpf-next v3 17/21] veth: Implement VLAN tag and checksum
 XDP hint
From: Stanislav Fomichev <sdf@google.com>
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com, 
	jolsa@kernel.org, David Ahern <dsahern@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Jesper Dangaard Brouer <brouer@redhat.com>, 
	Anatoly Burakov <anatoly.burakov@intel.com>, Alexander Lobakin <alexandr.lobakin@intel.com>, 
	Magnus Karlsson <magnus.karlsson@gmail.com>, Maryam Tahhan <mtahhan@redhat.com>, 
	xdp-hints@xdp-project.net, netdev@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 07/19, Larysa Zaremba wrote:
> In order to test VLAN tag and checksum XDP hints in hardware-independent
> selfttests, implement newly added XDP hints in veth driver.
> 
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>

Acked-by: Stanislav Fomichev <sdf@google.com>

> ---
>  drivers/net/veth.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
> 
> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> index 614f3e3efab0..86239549120d 100644
> --- a/drivers/net/veth.c
> +++ b/drivers/net/veth.c
> @@ -1732,6 +1732,50 @@ static int veth_xdp_rx_hash(const struct xdp_md *ctx, u32 *hash,
>  	return 0;
>  }
>  
> +static int veth_xdp_rx_vlan_tag(const struct xdp_md *ctx, u16 *vlan_tci,
> +				__be16 *vlan_proto)
> +{
> +	struct veth_xdp_buff *_ctx = (void *)ctx;
> +	struct sk_buff *skb = _ctx->skb;
> +	int err;
> +
> +	if (!skb)
> +		return -ENODATA;
> +
> +	err = __vlan_hwaccel_get_tag(skb, vlan_tci);
> +	if (err)
> +		return err;
> +
> +	*vlan_proto = skb->vlan_proto;
> +	return err;
> +}
> +
> +static int veth_xdp_rx_csum(const struct xdp_md *ctx,
> +			    enum xdp_csum_status *csum_status,
> +			    union xdp_csum_info *csum_info)
> +{
> +	struct veth_xdp_buff *_ctx = (void *)ctx;
> +	struct sk_buff *skb = _ctx->skb;
> +
> +	if (!skb)
> +		return -ENODATA;
> +
> +	if (skb->ip_summed == CHECKSUM_UNNECESSARY) {
> +		*csum_status = skb->csum_level + 1;
> +	} else if (skb->ip_summed == CHECKSUM_PARTIAL) {
> +		*csum_status = XDP_CHECKSUM_PARTIAL;
> +		csum_info->csum_start = skb_checksum_start_offset(skb);
> +		csum_info->csum_offset = skb->csum_offset;
> +	} else if (skb->ip_summed == CHECKSUM_COMPLETE) {
> +		*csum_status = XDP_CHECKSUM_COMPLETE;
> +		csum_info->checksum = skb->csum;
> +	} else {
> +		return -ENODATA;
> +	}
> +
> +	return 0;
> +}
> +
>  static const struct net_device_ops veth_netdev_ops = {
>  	.ndo_init            = veth_dev_init,
>  	.ndo_open            = veth_open,
> @@ -1756,6 +1800,8 @@ static const struct net_device_ops veth_netdev_ops = {
>  static const struct xdp_metadata_ops veth_xdp_metadata_ops = {
>  	.xmo_rx_timestamp		= veth_xdp_rx_timestamp,
>  	.xmo_rx_hash			= veth_xdp_rx_hash,
> +	.xmo_rx_vlan_tag		= veth_xdp_rx_vlan_tag,
> +	.xmo_rx_csum			= veth_xdp_rx_csum,
>  };
>  
>  #define VETH_FEATURES (NETIF_F_SG | NETIF_F_FRAGLIST | NETIF_F_HW_CSUM | \
> -- 
> 2.41.0
> 

