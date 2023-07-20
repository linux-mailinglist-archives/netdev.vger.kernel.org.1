Return-Path: <netdev+bounces-19672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A39D75B9D1
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 23:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F7C6282097
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 21:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F089A1BE98;
	Thu, 20 Jul 2023 21:50:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4051BE92
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 21:50:31 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06E630DD
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 14:50:00 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-cfc77042aeaso1077224276.0
        for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 14:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689889800; x=1690494600;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fzj245p/zdp2VbtUUSkZh5iBN/rtlvOBoNOG5lsLugE=;
        b=cetlgxvA76sxVXy5H7k6a8mEmWKoY0Ka4zy++yHS+8O6VmGz/ealaoNH8sbIBZvl1+
         L0yayYvd3T7VzSoxY8y9F40+ygPVH6KT0sLpsourlkuKrAB5bm0/HfDbjwC5Dtcb2mVP
         dQusVtIHngqXuvCXXVS3VVF5VjDqAsIcYnf0/WinJ3TT3jja4wemkvFE+SFG4mBcVvPG
         GZ9lRpjChNwh9Un0BMTbwBpNgHEjnHkJwliG25TwMUJhTxdQ4X/5ZEdYqyeMa/er5wqi
         m+iUDvcPEPosrJ3lwIbpKQc66n2ESz9kVMXf3V48wVZfB1Stas5pqaS5ugoIei8IfazZ
         8WMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689889800; x=1690494600;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fzj245p/zdp2VbtUUSkZh5iBN/rtlvOBoNOG5lsLugE=;
        b=cYag+Rlqkcy2M/E6cvzVFEBcoG3s+DWESsBlUzfvTyAQ2GA7T4w4zfiLIINoWP7pxk
         VR/UlurJ/3gnPa2Y9PhXnY89o8RSrEjeN6pIPdS58HhWuVVzJM2lSsQtXwVQiwuJ0MYn
         +l4scEmVfNyQIlqOvKCbEgYckoGyyWZKj5LhUJo7dNAeurAxzWjGvDXAy+sz0lCA1wTf
         6lTY5PaWop/t1ABjcFhEUSdKs8hcxZS+DkjpCzL2BzPXewA3IoLqYM23/K5JLTH5ko+S
         w0HZrTb1lV/2u/GkHuZA61eFkxN/gPOy1GsqvTbSqc+dv2pPdbXGsU1WhLf8/TjMzKO/
         hrcA==
X-Gm-Message-State: ABy/qLZCLsF3gaYmzz7Bt5UoJIx9SKPFRnKktxHT0ALYfv+YG3eVhUCZ
	Bl9w82MSTHU+6PrG3qC9RnRt3Zk=
X-Google-Smtp-Source: APBJJlEGREZVSzGktA4CzLW93lGIVLcfthHQpGiDzuhwbeSzcbY0SLBp7Yxm4L+FUbTXJ+LoTERsFEc=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a25:704:0:b0:c67:975c:74ab with SMTP id
 4-20020a250704000000b00c67975c74abmr1551ybh.4.1689889800145; Thu, 20 Jul 2023
 14:50:00 -0700 (PDT)
Date: Thu, 20 Jul 2023 14:49:58 -0700
In-Reply-To: <20230719183734.21681-10-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230719183734.21681-1-larysa.zaremba@intel.com> <20230719183734.21681-10-larysa.zaremba@intel.com>
Message-ID: <ZLmsBglIuZoErVxi@google.com>
Subject: Re: [PATCH bpf-next v3 09/21] xdp: Add VLAN tag hint
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
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 07/19, Larysa Zaremba wrote:
> Implement functionality that enables drivers to expose VLAN tag
> to XDP code.
> 
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>

Acked-by: Stanislav Fomichev <sdf@google.com>

Thank you for a super detailed kfunc kdoc!

> ---
>  Documentation/networking/xdp-rx-metadata.rst |  8 ++++-
>  include/linux/netdevice.h                    |  2 ++
>  include/net/xdp.h                            |  2 ++
>  kernel/bpf/offload.c                         |  2 ++
>  net/core/xdp.c                               | 34 ++++++++++++++++++++
>  5 files changed, 47 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/networking/xdp-rx-metadata.rst b/Documentation/networking/xdp-rx-metadata.rst
> index 25ce72af81c2..ea6dd79a21d3 100644
> --- a/Documentation/networking/xdp-rx-metadata.rst
> +++ b/Documentation/networking/xdp-rx-metadata.rst
> @@ -18,7 +18,13 @@ Currently, the following kfuncs are supported. In the future, as more
>  metadata is supported, this set will grow:
>  
>  .. kernel-doc:: net/core/xdp.c
> -   :identifiers: bpf_xdp_metadata_rx_timestamp bpf_xdp_metadata_rx_hash
> +   :identifiers: bpf_xdp_metadata_rx_timestamp
> +
> +.. kernel-doc:: net/core/xdp.c
> +   :identifiers: bpf_xdp_metadata_rx_hash
> +
> +.. kernel-doc:: net/core/xdp.c
> +   :identifiers: bpf_xdp_metadata_rx_vlan_tag
>  
>  An XDP program can use these kfuncs to read the metadata into stack
>  variables for its own consumption. Or, to pass the metadata on to other
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index b828c7a75be2..1749f4f75c64 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -1658,6 +1658,8 @@ struct xdp_metadata_ops {
>  	int	(*xmo_rx_timestamp)(const struct xdp_md *ctx, u64 *timestamp);
>  	int	(*xmo_rx_hash)(const struct xdp_md *ctx, u32 *hash,
>  			       enum xdp_rss_hash_type *rss_type);
> +	int	(*xmo_rx_vlan_tag)(const struct xdp_md *ctx, u16 *vlan_tci,
> +				   __be16 *vlan_proto);
>  };
>  
>  /**
> diff --git a/include/net/xdp.h b/include/net/xdp.h
> index 6381560efae2..89c58f56ffc6 100644
> --- a/include/net/xdp.h
> +++ b/include/net/xdp.h
> @@ -389,6 +389,8 @@ void xdp_attachment_setup(struct xdp_attachment_info *info,
>  			   bpf_xdp_metadata_rx_timestamp) \
>  	XDP_METADATA_KFUNC(XDP_METADATA_KFUNC_RX_HASH, \
>  			   bpf_xdp_metadata_rx_hash) \
> +	XDP_METADATA_KFUNC(XDP_METADATA_KFUNC_RX_VLAN_TAG, \
> +			   bpf_xdp_metadata_rx_vlan_tag) \
>  
>  enum {
>  #define XDP_METADATA_KFUNC(name, _) name,
> diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
> index 8a26cd8814c1..986e7becfd42 100644
> --- a/kernel/bpf/offload.c
> +++ b/kernel/bpf/offload.c
> @@ -848,6 +848,8 @@ void *bpf_dev_bound_resolve_kfunc(struct bpf_prog *prog, u32 func_id)
>  		p = ops->xmo_rx_timestamp;
>  	else if (func_id == bpf_xdp_metadata_kfunc_id(XDP_METADATA_KFUNC_RX_HASH))
>  		p = ops->xmo_rx_hash;
> +	else if (func_id == bpf_xdp_metadata_kfunc_id(XDP_METADATA_KFUNC_RX_VLAN_TAG))
> +		p = ops->xmo_rx_vlan_tag;
>  out:
>  	up_read(&bpf_devs_lock);
>  
> diff --git a/net/core/xdp.c b/net/core/xdp.c
> index 8362130bf085..8b55419d332e 100644
> --- a/net/core/xdp.c
> +++ b/net/core/xdp.c
> @@ -738,6 +738,40 @@ __bpf_kfunc int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, u32 *hash,
>  	return -EOPNOTSUPP;
>  }
>  
> +/**
> + * bpf_xdp_metadata_rx_vlan_tag - Get XDP packet outermost VLAN tag
> + * @ctx: XDP context pointer.
> + * @vlan_tci: Destination pointer for VLAN TCI (VID + DEI + PCP)
> + * @vlan_proto: Destination pointer for VLAN Tag protocol identifier (TPID).
> + *
> + * In case of success, ``vlan_proto`` contains *Tag protocol identifier (TPID)*,
> + * usually ``ETH_P_8021Q`` or ``ETH_P_8021AD``, but some networks can use
> + * custom TPIDs. ``vlan_proto`` is stored in **network byte order (BE)**
> + * and should be used as follows:
> + * ``if (vlan_proto == bpf_htons(ETH_P_8021Q)) do_something();``
> + *
> + * ``vlan_tci`` contains the remaining 16 bits of a VLAN tag.
> + * Driver is expected to provide those in **host byte order (usually LE)**,
> + * so the bpf program should not perform byte conversion.
> + * According to 802.1Q standard, *VLAN TCI (Tag control information)*
> + * is a bit field that contains:
> + * *VLAN identifier (VID)* that can be read with ``vlan_tci & 0xfff``,
> + * *Drop eligible indicator (DEI)* - 1 bit,
> + * *Priority code point (PCP)* - 3 bits.
> + * For detailed meaning of DEI and PCP, please refer to other sources.
> + *
> + * Return:
> + * * Returns 0 on success or ``-errno`` on error.
> + * * ``-EOPNOTSUPP`` : device driver doesn't implement kfunc
> + * * ``-ENODATA``    : VLAN tag was not stripped or is not available
> + */
> +__bpf_kfunc int bpf_xdp_metadata_rx_vlan_tag(const struct xdp_md *ctx,
> +					     u16 *vlan_tci,
> +					     __be16 *vlan_proto)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
>  __diag_pop();
>  
>  BTF_SET8_START(xdp_metadata_kfunc_ids)
> -- 
> 2.41.0
> 

