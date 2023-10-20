Return-Path: <netdev+bounces-43085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF40E7D1570
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 20:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75A72282651
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 18:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE65B2230F;
	Fri, 20 Oct 2023 18:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ycjniwuV"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D4721A1F
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 18:06:11 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74731C0
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 11:06:10 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d9a528c2c8bso1385046276.1
        for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 11:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697825169; x=1698429969; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KjKRhB2ZGmjdY+V3m2wDwglDBkT5iWSc3BrmrIM618A=;
        b=ycjniwuVeSpgdfeugajcQNeScrR2+Us4p9Gs1Vo+UITIZW87KjntuhiVY/OjPMcBkF
         1NAjWs80Jx14JEnTJy0pwb+83q7LxVK4h+l8MmExfP88sCVqLL+UkdlNSXmnjNvnG40y
         QOT60t6qK8u/DFTFz+E+ODqZzMCrXCDh9cuzOHx+HpcJkAwnPosRsU3XkPVgn7H4jnx0
         HbaKqFEUdh+A3/qi3VmdHP1IAZ1Get76y6os7tzpoiC+rSPhBrQu7U+HPvMOgGVDGDyl
         04owHNdrdSL1qNCsNrXX6O7IxHwg+OEFSA2kGlZZc/fq4T3jx4dHBoVW3CxfA3E3+sAj
         QooA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697825169; x=1698429969;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KjKRhB2ZGmjdY+V3m2wDwglDBkT5iWSc3BrmrIM618A=;
        b=ZvjEaY+ao+9xuH3MOY+C4aUXjfKBun/ViuU2oxOMsCXbJjQ/kQIxt8OjswblLzg7LZ
         yxoSZBv38bBTSufDREhuQ1z/Dfx4QeuzPGvgmwbzjRTVf5Xk04xxOI3BCuFYzttPGy10
         tbVq1B1CB/OkFf/ETDfMN6pWaBw5AWLFXrX4WGo+S0huz++1+ndERVdpAEPpKl6PGnvo
         qumigpmNfI5Bg0lrzqIgJ+pdzO3PsnUo3IZu1Zx+KDM8mwVHepWuxHEBYMIu4DXhm1jy
         Kdlnk/Kc1o05kWGzya3FLQFcCAH3LS3ngmENCRuPWVLWjzRl0eGsmbEXssuxcIhlj+mC
         4MMw==
X-Gm-Message-State: AOJu0YyLjneXpvkPFHH/y3oL8SW5RDXp8MLDg1Afi7D4eEXA8uceST12
	IjUzzQAgFblvQZfM6+BF4wKUlRg=
X-Google-Smtp-Source: AGHT+IFZSNaTZQdlBfpXvahW6QtUTkP5/JLdYWQRsMYTIf7kO/MHQaXtfOceBtkfAcpN9Lzos6/xzT8=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a25:8e05:0:b0:d74:93a1:70a2 with SMTP id
 p5-20020a258e05000000b00d7493a170a2mr58369ybl.5.1697825169671; Fri, 20 Oct
 2023 11:06:09 -0700 (PDT)
Date: Fri, 20 Oct 2023 11:06:07 -0700
In-Reply-To: <20231020174940.gjubehkouns2hmgz@MacBook-Pro-49.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231019174944.3376335-1-sdf@google.com> <20231019174944.3376335-3-sdf@google.com>
 <20231020174940.gjubehkouns2hmgz@MacBook-Pro-49.local>
Message-ID: <ZTLBj2AffYWKD-HP@google.com>
Subject: Re: [PATCH bpf-next v4 02/11] xsk: Add TX timestamp and TX checksum
 offload support
From: Stanislav Fomichev <sdf@google.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com, 
	jolsa@kernel.org, kuba@kernel.org, toke@kernel.org, willemb@google.com, 
	dsahern@kernel.org, magnus.karlsson@intel.com, bjorn@kernel.org, 
	maciej.fijalkowski@intel.com, hawk@kernel.org, yoong.siang.song@intel.com, 
	netdev@vger.kernel.org, xdp-hints@xdp-project.net, saeedm@nvidia.com
Content-Type: text/plain; charset="utf-8"

On 10/20, Alexei Starovoitov wrote:
> On Thu, Oct 19, 2023 at 10:49:35AM -0700, Stanislav Fomichev wrote:
> > diff --git a/include/uapi/linux/if_xdp.h b/include/uapi/linux/if_xdp.h
> > index 2ecf79282c26..ecfd67988283 100644
> > --- a/include/uapi/linux/if_xdp.h
> > +++ b/include/uapi/linux/if_xdp.h
> > @@ -106,6 +106,43 @@ struct xdp_options {
> >  #define XSK_UNALIGNED_BUF_ADDR_MASK \
> >  	((1ULL << XSK_UNALIGNED_BUF_OFFSET_SHIFT) - 1)
> >  
> > +/* Request transmit timestamp. Upon completion, put it into tx_timestamp
> > + * field of struct xsk_tx_metadata.
> > + */
> > +#define XDP_TX_METADATA_TIMESTAMP		(1 << 0)
> > +
> > +/* Request transmit checksum offload. Checksum start position and offset
> > + * are communicated via csum_start and csum_offset fields of struct
> > + * xsk_tx_metadata.
> > + */
> > +#define XDP_TX_METADATA_CHECKSUM		(1 << 1)
> > +
> > +/* Force checksum calculation in software. Can be used for testing or
> > + * working around potential HW issues. This option causes performance
> > + * degradation and only works in XDP_COPY mode.
> > + */
> > +#define XDP_TX_METADATA_CHECKSUM_SW		(1 << 2)
> > +
> > +struct xsk_tx_metadata {
> > +	union {
> > +		struct {
> > +			__u32 flags;
> > +
> > +			/* XDP_TX_METADATA_CHECKSUM */
> > +
> > +			/* Offset from desc->addr where checksumming should start. */
> > +			__u16 csum_start;
> > +			/* Offset from csum_start where checksum should be stored. */
> > +			__u16 csum_offset;
> > +		};
> > +
> > +		struct {
> > +			/* XDP_TX_METADATA_TIMESTAMP */
> > +			__u64 tx_timestamp;
> > +		} completion;
> > +	};
> > +};
> 
> Could you add a comment to above union that csum fields are consumed by the driver
> before it xmits the packet while timestamp is filled during xmit, so union
> doesn't prevent using both features simultaneously.
> It's clear from the example, but not obvious from uapi and the doc in patch 11
> doesn't clarify it either.
> 
> Also please add a name to csum part of the union like you did for completion.
> We've learned it the hard way with bpf_attr. All anon structs better have field name
> within a union. Helps extensibility (avoid conflicts) in the long term.

Sure, will do, thanks!

> Other than this the patch set looks great to me.
> With Saeed and Magnus acks we can take it in.

Magnus is on CC, so I hope see sees the request.

Added Saeed here as well. Saeed, can you please take a look at the mlx part?
You've been on CC for a particular patch, but just in case:
https://lore.kernel.org/bpf/20231019174944.3376335-5-sdf@google.com/T/#u

