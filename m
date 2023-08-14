Return-Path: <netdev+bounces-27429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3970D77BF85
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 20:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 521C91C20B5A
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 18:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F99CCA5F;
	Mon, 14 Aug 2023 18:05:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D056C2FC
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 18:05:18 +0000 (UTC)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15ED910F9
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 11:05:15 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-2680eee423aso2479038a91.2
        for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 11:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692036314; x=1692641114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m7g1R/21wNzU5e8eJcC+fpUif2cqg4RQzc6j7+Cbixw=;
        b=NLwR0hZljonn0iprYdGZXFuRHxpcnqiLK6RdF9URm4R08zhVSUDOU6W16EGdjcb9Mt
         9UXnZw2t+dTJGr/SRdhWwvx1y5rPIA69ELhZioh6ZvapvK0ndw8iGp6dc3UAmeru0d6j
         49VyCdJMo3hdJ8jfraJA5LdUJ++oRCMub8/8U+5NwR/h6aevFAGUmGqPOI4tQE8WgCoV
         LGD5nRla5EEgJ43wjIgLB96iF0z1IS1YPwV0It3CCtoDZG0SPhm0Myx3YVfEGSF29KOD
         dQje/8cBvp839QYpX1ldmktWvVB1YNoZxegQvVITKAg7+YjVBftYSAS4ZJMTjquHDoy3
         a7Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692036314; x=1692641114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m7g1R/21wNzU5e8eJcC+fpUif2cqg4RQzc6j7+Cbixw=;
        b=XBCY6jbjsx2m+f/w3IipaNUddtRfyLVdzpG1zJwLU1876JXxlkh2XeeWc77aIQPnoK
         xDTK5nfZ1JfEcR4KQGHpzq4MQWyURZ0eamJG3oMCRL1z6dsDOHHQhfc/V2AE+lVbSbYE
         bqri9vbetCDNDWL8hiYvj0G9k4KxxF2a+LGGEkEbfkUbEbDyoP24iJZLw/iQbmfbMow0
         kk2Zj1L21WLmEkxjSP+ni0/lZK8v9JFbl/Z9HHtBeYMOyUBroGoxUDpVuS/vZCLE23Nd
         nFtYWmewR5onPeVPKyth4GxKK6kCOLtPQ8pfhAdUNGEuiku/a9S69tJbvflUBQrs5Em7
         UZ5A==
X-Gm-Message-State: AOJu0Yxmwm98ifKOeAosncYOBJYTOBsuy+ZMtEc43YEh5qmmhTMCd9Nw
	0suqZWSH2rFwLxcyZgi/ArOawnXMX+YZDPkrn5BRgQ==
X-Google-Smtp-Source: AGHT+IFmklskcpj993E1zbKMUrIDed1HAft3WDszMju3MwSdz1XnQqYUQhQEXysogzFrKlxLKlXEwy2bfBXlhMeSr8U=
X-Received: by 2002:a17:90a:6046:b0:268:b682:23da with SMTP id
 h6-20020a17090a604600b00268b68223damr7465920pjm.34.1692036314332; Mon, 14 Aug
 2023 11:05:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230809165418.2831456-1-sdf@google.com> <20230809165418.2831456-5-sdf@google.com>
 <ZNoJxCgGrftwt+4x@boxer>
In-Reply-To: <ZNoJxCgGrftwt+4x@boxer>
From: Stanislav Fomichev <sdf@google.com>
Date: Mon, 14 Aug 2023 11:05:02 -0700
Message-ID: <CAKH8qBsoi1PbDMwDEQ+-=r_D+=JCesV4JbZwbH7+rkjxZ3pWtg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/9] net/mlx5e: Implement AF_XDP TX timestamp and
 checksum offload
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com, 
	jolsa@kernel.org, kuba@kernel.org, toke@kernel.org, willemb@google.com, 
	dsahern@kernel.org, magnus.karlsson@intel.com, bjorn@kernel.org, 
	hawk@kernel.org, netdev@vger.kernel.org, xdp-hints@xdp-project.net, 
	Saeed Mahameed <saeedm@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Aug 14, 2023 at 4:02=E2=80=AFAM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Wed, Aug 09, 2023 at 09:54:13AM -0700, Stanislav Fomichev wrote:
> > TX timestamp:
> > - requires passing clock, not sure I'm passing the correct one (from
> >   cq->mdev), but the timestamp value looks convincing
> >
> > TX checksum:
> > - looks like device does packet parsing (and doesn't accept custom
> >   start/offset), so I'm ignoring user offsets
> >
> > Cc: Saeed Mahameed <saeedm@nvidia.com>
> > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > ---
> >  drivers/net/ethernet/mellanox/mlx5/core/en.h  |  4 +-
> >  .../net/ethernet/mellanox/mlx5/core/en/xdp.c  | 72 ++++++++++++++++---
> >  .../net/ethernet/mellanox/mlx5/core/en/xdp.h  | 10 ++-
> >  .../ethernet/mellanox/mlx5/core/en/xsk/tx.c   | 11 ++-
> >  .../net/ethernet/mellanox/mlx5/core/en_main.c |  1 +
> >  5 files changed, 82 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net=
/ethernet/mellanox/mlx5/core/en.h
> > index 0f8f70b91485..6f38627ae7f8 100644
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
> > @@ -476,10 +476,12 @@ struct mlx5e_xdp_info_fifo {
> >
> >  struct mlx5e_xdpsq;
> >  struct mlx5e_xmit_data;
> > +struct xsk_tx_metadata;
> >  typedef int (*mlx5e_fp_xmit_xdp_frame_check)(struct mlx5e_xdpsq *);
> >  typedef bool (*mlx5e_fp_xmit_xdp_frame)(struct mlx5e_xdpsq *,
> >                                       struct mlx5e_xmit_data *,
> > -                                     int);
> > +                                     int,
> > +                                     struct xsk_tx_metadata *);
> >
> >  struct mlx5e_xdpsq {
> >       /* data path */
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c b/drivers=
/net/ethernet/mellanox/mlx5/core/en/xdp.c
> > index 40589cebb773..197d372048ec 100644
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
> > @@ -102,7 +102,7 @@ mlx5e_xmit_xdp_buff(struct mlx5e_xdpsq *sq, struct =
mlx5e_rq *rq,
> >               xdptxd->dma_addr =3D dma_addr;
> >
> >               if (unlikely(!INDIRECT_CALL_2(sq->xmit_xdp_frame, mlx5e_x=
mit_xdp_frame_mpwqe,
> > -                                           mlx5e_xmit_xdp_frame, sq, x=
dptxd, 0)))
> > +                                           mlx5e_xmit_xdp_frame, sq, x=
dptxd, 0, NULL)))
> >                       return false;
> >
> >               /* xmit_mode =3D=3D MLX5E_XDP_XMIT_MODE_FRAME */
> > @@ -144,7 +144,7 @@ mlx5e_xmit_xdp_buff(struct mlx5e_xdpsq *sq, struct =
mlx5e_rq *rq,
> >       xdptxd->dma_addr =3D dma_addr;
> >
> >       if (unlikely(!INDIRECT_CALL_2(sq->xmit_xdp_frame, mlx5e_xmit_xdp_=
frame_mpwqe,
> > -                                   mlx5e_xmit_xdp_frame, sq, xdptxd, 0=
)))
> > +                                   mlx5e_xmit_xdp_frame, sq, xdptxd, 0=
, NULL)))
> >               return false;
> >
> >       /* xmit_mode =3D=3D MLX5E_XDP_XMIT_MODE_PAGE */
> > @@ -260,6 +260,37 @@ const struct xdp_metadata_ops mlx5e_xdp_metadata_o=
ps =3D {
> >       .xmo_rx_hash                    =3D mlx5e_xdp_rx_hash,
> >  };
> >
> > +struct mlx5e_xsk_tx_complete {
> > +     struct mlx5_cqe64 *cqe;
> > +     struct mlx5e_cq *cq;
> > +};
> > +
> > +static u64 mlx5e_xsk_fill_timestamp(void *_priv)
> > +{
> > +     struct mlx5e_xsk_tx_complete *priv =3D _priv;
> > +     u64 ts;
> > +
> > +     ts =3D get_cqe_ts(priv->cqe);
> > +
> > +     if (mlx5_is_real_time_rq(priv->cq->mdev) || mlx5_is_real_time_sq(=
priv->cq->mdev))
> > +             return mlx5_real_time_cyc2time(&priv->cq->mdev->clock, ts=
);
> > +
> > +     return  mlx5_timecounter_cyc2time(&priv->cq->mdev->clock, ts);
> > +}
> > +
> > +static void mlx5e_xsk_request_checksum(u16 csum_start, u16 csum_offset=
, void *priv)
> > +{
> > +     struct mlx5_wqe_eth_seg *eseg =3D priv;
> > +
> > +     /* HW/FW is doing parsing, so offsets are largely ignored. */
> > +     eseg->cs_flags |=3D MLX5_ETH_WQE_L3_CSUM | MLX5_ETH_WQE_L4_CSUM;
> > +}
> > +
> > +const struct xsk_tx_metadata_ops mlx5e_xsk_tx_metadata_ops =3D {
> > +     .tmo_fill_timestamp             =3D mlx5e_xsk_fill_timestamp,
> > +     .tmo_request_checksum           =3D mlx5e_xsk_request_checksum,
>
> Can you explain to us why mlx5 doesn't need to implement the request
> timestamp op?

There is always a timestamp in the tx completion descriptor, so no
need to explicitly request it.

