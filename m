Return-Path: <netdev+bounces-24195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C7676F351
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 21:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 213FE1C21681
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 19:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B462B2591C;
	Thu,  3 Aug 2023 19:18:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAB11F934
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 19:18:40 +0000 (UTC)
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29DC3BA
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 12:18:37 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id ada2fe7eead31-447be69ae43so490041137.0
        for <netdev@vger.kernel.org>; Thu, 03 Aug 2023 12:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691090316; x=1691695116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zs8bZOSE+m2BYzMiuNpcvoG8tmCnF87SZjJXGCP9qc0=;
        b=6TlwIIhF5Opbz4od0LrnHMsK63j/4XfrW1Nirr/8D0P2tMxdLc5PzScCjENwdkhN5i
         G5Yc2BJUCeG8LE987F93s14DZOWkJpqB5skSQyuqDcpdpsCqnyWj8BhALsxgO6VnrdaG
         4eYNSl1B+nvbCZwgxKsqrVx5RoKULopFLbXuoggxSBqadHn9JLJlZI/BlN2/2zYVeUT2
         eZ9Ke8v7oybH/gpk+39c3uVho1RRg1sFyg8hqrpt7qQ38/coa3/xR+HmsyNt75ihHoGo
         JtpAJYSAZT1MNLNGSp3qH5UDNhVxuWw2mVcY9TIDNBQwb/qBExwWEP9V0bCRx2cOa3ig
         zYhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691090316; x=1691695116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zs8bZOSE+m2BYzMiuNpcvoG8tmCnF87SZjJXGCP9qc0=;
        b=aQUojPLc/LlGNvr64KFMlUG/Fch82bIknrjXPjkfosyg8r+chTu4V6CAuAB5JZDN61
         PdL22qrchrH3PPnNqbMRYK5Jm0zWdtkzlXHwSGLbM3nBdXcVPVmwRKVO5RFIujhpCIt+
         4vDy/229kb2dqP4f0pLLEK/1T80ADt0UkJxnDXngWQNOyH9XnJknn+YZB/BwWNYb44D0
         zF4bABATuucrLa/n/OVb2Q9v/LgQFp9matn22NRXaMAeMpIyek/Zzndlbi0k6c8ns+wK
         m7Ym52aYczUivG1/jlHMgjqZM58+vtD6eQoWQXlXv0HDg5ONKnCsR7rl+td0140P5QNS
         2D8Q==
X-Gm-Message-State: ABy/qLaZAerWd7waiiI29jeKVTADU95kGZoKB3Z+HxAt4Q/lFRWsvR+o
	7pzG9d3iCltlovPS5GUpg12UrG9Ofh36oOmKvH9usw==
X-Google-Smtp-Source: APBJJlFkDd6Y2hEL3jT//M2+EPxo43RHiNimr7wgll8xV9gEp3drcE1O1KIGIdRpRrcQ1+97vpqRqo7Pc8wwLBti3GE=
X-Received: by 2002:a67:f756:0:b0:443:7eba:e22c with SMTP id
 w22-20020a67f756000000b004437ebae22cmr5460556vso.8.1691090315965; Thu, 03 Aug
 2023 12:18:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230802213338.2391025-1-rushilg@google.com> <20230802213338.2391025-2-rushilg@google.com>
 <55d763ec-fbaa-79dc-192e-c4c696a8a7de@intel.com>
In-Reply-To: <55d763ec-fbaa-79dc-192e-c4c696a8a7de@intel.com>
From: Rushil Gupta <rushilg@google.com>
Date: Thu, 3 Aug 2023 12:18:24 -0700
Message-ID: <CANzqiF4ZnyeGh=9-dGE0NpPYc8ES5XAe2aafutxmX6dAL_vWmA@mail.gmail.com>
Subject: Re: [PATCH net-next 1/4] gve: Control path for DQO-QPL
To: Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	willemb@google.com, edumazet@google.com, pabeni@redhat.com, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Bailey Forrest <bcf@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 2, 2023 at 6:56=E2=80=AFPM Jesse Brandeburg
<jesse.brandeburg@intel.com> wrote:
>
> On 8/2/2023 2:33 PM, Rushil Gupta wrote:
> > Add checks, abi-changes and device options to support
> > QPL mode for DQO in addition to GQI. Also, use
> > pages-per-qpl supplied by device-option to control the
> > size of the "queue-page-list".
>
> That is some serious acronym soup there, maybe expand your acronyms upon
> first use in the commit message? how are we to know what you mean?

I have provided the acronym explanations in the cover letter and .rst files=
.
However, I agree I should add them to the commit message as well. Will
fix it in v2.
>
>
> >
> > Signed-off-by: Rushil Gupta <rushilg@google.com>
> > Reviewed-by: Willem de Bruijn <willemb@google.com>
> > Signed-off-by: Praveen Kaligineedi <pkaligineedi@google.com>
> > Signed-off-by: Bailey Forrest <bcf@google.com>
> > ---
> >  drivers/net/ethernet/google/gve/gve.h        | 20 ++++-
> >  drivers/net/ethernet/google/gve/gve_adminq.c | 93 +++++++++++++++++---
> >  drivers/net/ethernet/google/gve/gve_adminq.h | 10 +++
> >  drivers/net/ethernet/google/gve/gve_main.c   | 20 +++--
> >  4 files changed, 123 insertions(+), 20 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethern=
et/google/gve/gve.h
> > index 4b425bf71ede..517a63b60cb9 100644
> > --- a/drivers/net/ethernet/google/gve/gve.h
> > +++ b/drivers/net/ethernet/google/gve/gve.h
> > @@ -51,6 +51,12 @@
> >
> >  #define GVE_GQ_TX_MIN_PKT_DESC_BYTES 182
> >
> > +#define DQO_QPL_DEFAULT_TX_PAGES 512
> > +#define DQO_QPL_DEFAULT_RX_PAGES 2048
> > +
> > +/* Maximum TSO size supported on DQO */
> > +#define GVE_DQO_TX_MAX       0x3FFFF
> > +
> >  /* Each slot in the desc ring has a 1:1 mapping to a slot in the data =
ring */
> >  struct gve_rx_desc_queue {
> >       struct gve_rx_desc *desc_ring; /* the descriptor ring */
> > @@ -531,6 +537,7 @@ enum gve_queue_format {
> >       GVE_GQI_RDA_FORMAT              =3D 0x1,
> >       GVE_GQI_QPL_FORMAT              =3D 0x2,
> >       GVE_DQO_RDA_FORMAT              =3D 0x3,
> > +     GVE_DQO_QPL_FORMAT              =3D 0x4,
> >  };
> >
> >  struct gve_priv {
> > @@ -550,7 +557,8 @@ struct gve_priv {
> >       u16 num_event_counters;
> >       u16 tx_desc_cnt; /* num desc per ring */
> >       u16 rx_desc_cnt; /* num desc per ring */
> > -     u16 tx_pages_per_qpl; /* tx buffer length */
> > +     u16 tx_pages_per_qpl; /* Suggested number of pages per qpl for TX=
 queues by NIC */
> > +     u16 rx_pages_per_qpl; /* Suggested number of pages per qpl for RX=
 queues by NIC */
> >       u16 rx_data_slot_cnt; /* rx buffer length */
> >       u64 max_registered_pages;
> >       u64 num_registered_pages; /* num pages registered with NIC */
> > @@ -808,11 +816,17 @@ static inline u32 gve_rx_idx_to_ntfy(struct gve_p=
riv *priv, u32 queue_idx)
> >       return (priv->num_ntfy_blks / 2) + queue_idx;
> >  }
> >
> > +static inline bool gve_is_qpl(struct gve_priv *priv)
> > +{
> > +     return priv->queue_format =3D=3D GVE_GQI_QPL_FORMAT ||
> > +             priv->queue_format =3D=3D GVE_DQO_QPL_FORMAT;
> > +}
> > +
> >  /* Returns the number of tx queue page lists
> >   */
> >  static inline u32 gve_num_tx_qpls(struct gve_priv *priv)
> >  {
> > -     if (priv->queue_format !=3D GVE_GQI_QPL_FORMAT)
> > +     if (!gve_is_qpl(priv))
> >               return 0;
> >
> >       return priv->tx_cfg.num_queues + priv->num_xdp_queues;
> > @@ -832,7 +846,7 @@ static inline u32 gve_num_xdp_qpls(struct gve_priv =
*priv)
> >   */
> >  static inline u32 gve_num_rx_qpls(struct gve_priv *priv)
> >  {
> > -     if (priv->queue_format !=3D GVE_GQI_QPL_FORMAT)
> > +     if (!gve_is_qpl(priv))
> >               return 0;
> >
> >       return priv->rx_cfg.num_queues;
> > diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net=
/ethernet/google/gve/gve_adminq.c
> > index 252974202a3f..a16e7cf21911 100644
> > --- a/drivers/net/ethernet/google/gve/gve_adminq.c
> > +++ b/drivers/net/ethernet/google/gve/gve_adminq.c
> > @@ -39,7 +39,8 @@ void gve_parse_device_option(struct gve_priv *priv,
> >                            struct gve_device_option_gqi_rda **dev_op_gq=
i_rda,
> >                            struct gve_device_option_gqi_qpl **dev_op_gq=
i_qpl,
> >                            struct gve_device_option_dqo_rda **dev_op_dq=
o_rda,
> > -                          struct gve_device_option_jumbo_frames **dev_=
op_jumbo_frames)
> > +                          struct gve_device_option_jumbo_frames **dev_=
op_jumbo_frames,
> > +                          struct gve_device_option_dqo_qpl **dev_op_dq=
o_qpl)
> >  {
> >       u32 req_feat_mask =3D be32_to_cpu(option->required_features_mask)=
;
> >       u16 option_length =3D be16_to_cpu(option->option_length);
> > @@ -112,6 +113,22 @@ void gve_parse_device_option(struct gve_priv *priv=
,
> >               }
> >               *dev_op_dqo_rda =3D (void *)(option + 1);
> >               break;
> > +     case GVE_DEV_OPT_ID_DQO_QPL:
> > +             if (option_length < sizeof(**dev_op_dqo_qpl) ||
> > +                 req_feat_mask !=3D GVE_DEV_OPT_REQ_FEAT_MASK_DQO_QPL)=
 {
> > +                     dev_warn(&priv->pdev->dev, GVE_DEVICE_OPTION_ERRO=
R_FMT,
> > +                              "DQO QPL", (int)sizeof(**dev_op_dqo_qpl)=
,
> > +                              GVE_DEV_OPT_REQ_FEAT_MASK_DQO_QPL,
> > +                              option_length, req_feat_mask);
> > +                     break;
> > +             }
> > +
> > +             if (option_length > sizeof(**dev_op_dqo_qpl)) {
> > +                     dev_warn(&priv->pdev->dev,
> > +                              GVE_DEVICE_OPTION_TOO_BIG_FMT, "DQO QPL"=
);
> > +             }
> > +             *dev_op_dqo_qpl =3D (void *)(option + 1);
> > +             break;
> >       case GVE_DEV_OPT_ID_JUMBO_FRAMES:
> >               if (option_length < sizeof(**dev_op_jumbo_frames) ||
> >                   req_feat_mask !=3D GVE_DEV_OPT_REQ_FEAT_MASK_JUMBO_FR=
AMES) {
> > @@ -146,7 +163,8 @@ gve_process_device_options(struct gve_priv *priv,
> >                          struct gve_device_option_gqi_rda **dev_op_gqi_=
rda,
> >                          struct gve_device_option_gqi_qpl **dev_op_gqi_=
qpl,
> >                          struct gve_device_option_dqo_rda **dev_op_dqo_=
rda,
> > -                        struct gve_device_option_jumbo_frames **dev_op=
_jumbo_frames)
> > +                        struct gve_device_option_jumbo_frames **dev_op=
_jumbo_frames,
> > +                        struct gve_device_option_dqo_qpl **dev_op_dqo_=
qpl)
> >  {
> >       const int num_options =3D be16_to_cpu(descriptor->num_device_opti=
ons);
> >       struct gve_device_option *dev_opt;
> > @@ -166,7 +184,8 @@ gve_process_device_options(struct gve_priv *priv,
> >
> >               gve_parse_device_option(priv, descriptor, dev_opt,
> >                                       dev_op_gqi_rda, dev_op_gqi_qpl,
> > -                                     dev_op_dqo_rda, dev_op_jumbo_fram=
es);
> > +                                     dev_op_dqo_rda, dev_op_jumbo_fram=
es,
> > +                                     dev_op_dqo_qpl);
> >               dev_opt =3D next_opt;
> >       }
> >
> > @@ -505,12 +524,24 @@ static int gve_adminq_create_tx_queue(struct gve_=
priv *priv, u32 queue_index)
> >
> >               cmd.create_tx_queue.queue_page_list_id =3D cpu_to_be32(qp=
l_id);
> >       } else {
> > +             u16 comp_ring_size =3D 0;
> > +             u32 qpl_id =3D 0;
>
> these stack initializers are useless, you unconditionally overwrite both
> values below.
Will fix.
>
> > +
> > +             if (priv->queue_format =3D=3D GVE_DQO_RDA_FORMAT) {
> > +                     qpl_id =3D GVE_RAW_ADDRESSING_QPL_ID;
> > +                     comp_ring_size =3D
> > +                             priv->options_dqo_rda.tx_comp_ring_entrie=
s;
> > +             } else {
> > +                     qpl_id =3D tx->dqo.qpl->id;
> > +                     comp_ring_size =3D priv->tx_desc_cnt;
> > +             }
> > +             cmd.create_tx_queue.queue_page_list_id =3D cpu_to_be32(qp=
l_id);
> >               cmd.create_tx_queue.tx_ring_size =3D
> >                       cpu_to_be16(priv->tx_desc_cnt);
> >               cmd.create_tx_queue.tx_comp_ring_addr =3D
> >                       cpu_to_be64(tx->complq_bus_dqo);
> >               cmd.create_tx_queue.tx_comp_ring_size =3D
> > -                     cpu_to_be16(priv->options_dqo_rda.tx_comp_ring_en=
tries);
> > +                     cpu_to_be16(comp_ring_size);
> >       }
> >
> >       return gve_adminq_issue_cmd(priv, &cmd);
> > @@ -555,6 +586,18 @@ static int gve_adminq_create_rx_queue(struct gve_p=
riv *priv, u32 queue_index)
> >               cmd.create_rx_queue.queue_page_list_id =3D cpu_to_be32(qp=
l_id);
> >               cmd.create_rx_queue.packet_buffer_size =3D cpu_to_be16(rx=
->packet_buffer_size);
> >       } else {
> > +             u16 rx_buff_ring_entries =3D 0;
> > +             u32 qpl_id =3D 0;
>
> same here
Will fix.
>
> > +
> > +             if (priv->queue_format =3D=3D GVE_DQO_RDA_FORMAT) {
> > +                     qpl_id =3D GVE_RAW_ADDRESSING_QPL_ID;
> > +                     rx_buff_ring_entries =3D
> > +                             priv->options_dqo_rda.rx_buff_ring_entrie=
s;
> > +             } else {
> > +                     qpl_id =3D rx->dqo.qpl->id;
> > +                     rx_buff_ring_entries =3D priv->rx_desc_cnt;
> > +             }
> > +             cmd.create_rx_queue.queue_page_list_id =3D cpu_to_be32(qp=
l_id);
> >               cmd.create_rx_queue.rx_ring_size =3D
> >                       cpu_to_be16(priv->rx_desc_cnt);
> >               cmd.create_rx_queue.rx_desc_ring_addr =3D
> > @@ -564,7 +607,7 @@ static int gve_adminq_create_rx_queue(struct gve_pr=
iv *priv, u32 queue_index)
> >               cmd.create_rx_queue.packet_buffer_size =3D
> >                       cpu_to_be16(priv->data_buffer_size_dqo);
> >               cmd.create_rx_queue.rx_buff_ring_size =3D
> > -                     cpu_to_be16(priv->options_dqo_rda.rx_buff_ring_en=
tries);
> > +                     cpu_to_be16(rx_buff_ring_entries);
> >               cmd.create_rx_queue.enable_rsc =3D
> >                       !!(priv->dev->features & NETIF_F_LRO);
> >       }
> > @@ -675,9 +718,13 @@ gve_set_desc_cnt_dqo(struct gve_priv *priv,
> >                    const struct gve_device_option_dqo_rda *dev_op_dqo_r=
da)
> >  {
> >       priv->tx_desc_cnt =3D be16_to_cpu(descriptor->tx_queue_entries);
> > +     priv->rx_desc_cnt =3D be16_to_cpu(descriptor->rx_queue_entries);
> > +
> > +     if (priv->queue_format =3D=3D GVE_DQO_QPL_FORMAT)
> > +             return 0;
> > +
> >       priv->options_dqo_rda.tx_comp_ring_entries =3D
> >               be16_to_cpu(dev_op_dqo_rda->tx_comp_ring_entries);
> > -     priv->rx_desc_cnt =3D be16_to_cpu(descriptor->rx_queue_entries);
> >       priv->options_dqo_rda.rx_buff_ring_entries =3D
> >               be16_to_cpu(dev_op_dqo_rda->rx_buff_ring_entries);
> >
> > @@ -687,7 +734,9 @@ gve_set_desc_cnt_dqo(struct gve_priv *priv,
> >  static void gve_enable_supported_features(struct gve_priv *priv,
> >                                         u32 supported_features_mask,
> >                                         const struct gve_device_option_=
jumbo_frames
> > -                                               *dev_op_jumbo_frames)
> > +                                       *dev_op_jumbo_frames,
> > +                                       const struct gve_device_option_=
dqo_qpl
> > +                                       *dev_op_dqo_qpl)
> >  {
> >       /* Before control reaches this point, the page-size-capped max MT=
U from
> >        * the gve_device_descriptor field has already been stored in
> > @@ -699,6 +748,20 @@ static void gve_enable_supported_features(struct g=
ve_priv *priv,
> >                        "JUMBO FRAMES device option enabled.\n");
> >               priv->dev->max_mtu =3D be16_to_cpu(dev_op_jumbo_frames->m=
ax_mtu);
> >       }
> > +
> > +     /* Override pages for qpl for DQO-QPL */
> > +     if (dev_op_dqo_qpl) {
> > +             dev_info(&priv->pdev->dev,
> > +                      "DQO QPL device option enabled.\n");
>
> How does this message benefit the user?
>
> > +             priv->tx_pages_per_qpl =3D
> > +                     be16_to_cpu(dev_op_dqo_qpl->tx_pages_per_qpl);
> > +             priv->rx_pages_per_qpl =3D
> > +                     be16_to_cpu(dev_op_dqo_qpl->rx_pages_per_qpl);
> > +             if (priv->tx_pages_per_qpl =3D=3D 0)
> > +                     priv->tx_pages_per_qpl =3D DQO_QPL_DEFAULT_TX_PAG=
ES;
> > +             if (priv->rx_pages_per_qpl =3D=3D 0)
> > +                     priv->rx_pages_per_qpl =3D DQO_QPL_DEFAULT_RX_PAG=
ES;
> > +     }
> >  }
> >
> >  int gve_adminq_describe_device(struct gve_priv *priv)
> > @@ -707,6 +770,7 @@ int gve_adminq_describe_device(struct gve_priv *pri=
v)
> >       struct gve_device_option_gqi_rda *dev_op_gqi_rda =3D NULL;
> >       struct gve_device_option_gqi_qpl *dev_op_gqi_qpl =3D NULL;
> >       struct gve_device_option_dqo_rda *dev_op_dqo_rda =3D NULL;
> > +     struct gve_device_option_dqo_qpl *dev_op_dqo_qpl =3D NULL;
> >       struct gve_device_descriptor *descriptor;
> >       u32 supported_features_mask =3D 0;
> >       union gve_adminq_command cmd;
> > @@ -733,13 +797,14 @@ int gve_adminq_describe_device(struct gve_priv *p=
riv)
> >
> >       err =3D gve_process_device_options(priv, descriptor, &dev_op_gqi_=
rda,
> >                                        &dev_op_gqi_qpl, &dev_op_dqo_rda=
,
> > -                                      &dev_op_jumbo_frames);
> > +                                      &dev_op_jumbo_frames,
> > +                                      &dev_op_dqo_qpl);
> >       if (err)
> >               goto free_device_descriptor;
> >
> >       /* If the GQI_RAW_ADDRESSING option is not enabled and the queue =
format
> >        * is not set to GqiRda, choose the queue format in a priority or=
der:
> > -      * DqoRda, GqiRda, GqiQpl. Use GqiQpl as default.
> > +      * DqoRda, DqoQpl, GqiRda, GqiQpl. Use GqiQpl as default.
> >        */
> >       if (dev_op_dqo_rda) {
> >               priv->queue_format =3D GVE_DQO_RDA_FORMAT;
> > @@ -747,7 +812,13 @@ int gve_adminq_describe_device(struct gve_priv *pr=
iv)
> >                        "Driver is running with DQO RDA queue format.\n"=
);
> >               supported_features_mask =3D
> >                       be32_to_cpu(dev_op_dqo_rda->supported_features_ma=
sk);
> > -     } else if (dev_op_gqi_rda) {
> > +     } else if (dev_op_dqo_qpl) {
> > +             priv->queue_format =3D GVE_DQO_QPL_FORMAT;
> > +             dev_info(&priv->pdev->dev,
> > +                      "Driver is running with DQO QPL queue format.\n"=
);
>
> I feel like at best these should have been dev_dbg, or at worst just
> removed. Messages should always add value for the user if they're printed=
.
This message (and one you pointed above) seems to be convention for
the driver code whenever a new format or device-option is added.
But I agree with you in principle that logging messages are not adding
any value here. Will remove.
>
> > +             supported_features_mask =3D
> > +                     be32_to_cpu(dev_op_dqo_qpl->supported_features_ma=
sk);
> > +     }  else if (dev_op_gqi_rda) {
> >               priv->queue_format =3D GVE_GQI_RDA_FORMAT;
> >               dev_info(&priv->pdev->dev,
> >                        "Driver is running with GQI RDA queue format.\n"=
);
> > @@ -798,7 +869,7 @@ int gve_adminq_describe_device(struct gve_priv *pri=
v)
> >       priv->default_num_queues =3D be16_to_cpu(descriptor->default_num_=
queues);
> >
> >       gve_enable_supported_features(priv, supported_features_mask,
> > -                                   dev_op_jumbo_frames);
> > +                                   dev_op_jumbo_frames, dev_op_dqo_qpl=
);
> >
> >  free_device_descriptor:
> >       dma_free_coherent(&priv->pdev->dev, PAGE_SIZE, descriptor,
> > diff --git a/drivers/net/ethernet/google/gve/gve_adminq.h b/drivers/net=
/ethernet/google/gve/gve_adminq.h
> > index f894beb3deaf..38a22279e863 100644
> > --- a/drivers/net/ethernet/google/gve/gve_adminq.h
> > +++ b/drivers/net/ethernet/google/gve/gve_adminq.h
> > @@ -109,6 +109,14 @@ struct gve_device_option_dqo_rda {
> >
> >  static_assert(sizeof(struct gve_device_option_dqo_rda) =3D=3D 8);
> >
> > +struct gve_device_option_dqo_qpl {
> > +     __be32 supported_features_mask;
> > +     __be16 tx_pages_per_qpl;
> > +     __be16 rx_pages_per_qpl;
> > +};
> > +
> > +static_assert(sizeof(struct gve_device_option_dqo_qpl) =3D=3D 8);
> > +
> >  struct gve_device_option_jumbo_frames {
> >       __be32 supported_features_mask;
> >       __be16 max_mtu;
> > @@ -130,6 +138,7 @@ enum gve_dev_opt_id {
> >       GVE_DEV_OPT_ID_GQI_RDA =3D 0x2,
> >       GVE_DEV_OPT_ID_GQI_QPL =3D 0x3,
> >       GVE_DEV_OPT_ID_DQO_RDA =3D 0x4,
> > +     GVE_DEV_OPT_ID_DQO_QPL =3D 0x7,
> >       GVE_DEV_OPT_ID_JUMBO_FRAMES =3D 0x8,
> >  };
> >
> > @@ -139,6 +148,7 @@ enum gve_dev_opt_req_feat_mask {
> >       GVE_DEV_OPT_REQ_FEAT_MASK_GQI_QPL =3D 0x0,
> >       GVE_DEV_OPT_REQ_FEAT_MASK_DQO_RDA =3D 0x0,
> >       GVE_DEV_OPT_REQ_FEAT_MASK_JUMBO_FRAMES =3D 0x0,
> > +     GVE_DEV_OPT_REQ_FEAT_MASK_DQO_QPL =3D 0x0,
>
>
> Maybe this makes sense to others, but an enum full of defines where all
> values are zero? Why are we even writing code?

If there=E2=80=99s a bug that breaks the DQO-QPL feature, we need to set a =
bug
bit in this mask GVE_DEV_OPT_REQ_FEAT_MASK_DQO_QPL.
That is why it is 0 to begin with. Although, I can see why it can be
considered useless.
>
> >  };
> >
> >  enum gve_sup_feature_mask {
> > diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/e=
thernet/google/gve/gve_main.c
> > index e6f1711d9be0..b40fafe1460a 100644
> > --- a/drivers/net/ethernet/google/gve/gve_main.c
> > +++ b/drivers/net/ethernet/google/gve/gve_main.c
> > @@ -31,7 +31,6 @@
> >
> >  // Minimum amount of time between queue kicks in msec (10 seconds)
> >  #define MIN_TX_TIMEOUT_GAP (1000 * 10)
> > -#define DQO_TX_MAX   0x3FFFF
> >
> >  char gve_driver_name[] =3D "gve";
> >  const char gve_version_str[] =3D GVE_VERSION;
> > @@ -494,7 +493,7 @@ static int gve_setup_device_resources(struct gve_pr=
iv *priv)
> >               goto abort_with_stats_report;
> >       }
> >
> > -     if (priv->queue_format =3D=3D GVE_DQO_RDA_FORMAT) {
> > +     if (!gve_is_gqi(priv)) {
> >               priv->ptype_lut_dqo =3D kvzalloc(sizeof(*priv->ptype_lut_=
dqo),
> >                                              GFP_KERNEL);
> >               if (!priv->ptype_lut_dqo) {
> > @@ -1085,9 +1084,10 @@ static int gve_alloc_qpls(struct gve_priv *priv)
> >       int max_queues =3D priv->tx_cfg.max_queues + priv->rx_cfg.max_que=
ues;
> >       int start_id;
> >       int i, j;
> > +     int page_count;
>
> RCT please
>
> >       int err;
> >
> > -     if (priv->queue_format !=3D GVE_GQI_QPL_FORMAT)
> > +     if (!gve_is_qpl(priv))
> >               return 0;
> >
> >       priv->qpls =3D kvcalloc(max_queues, sizeof(*priv->qpls), GFP_KERN=
EL);
> > @@ -1095,17 +1095,25 @@ static int gve_alloc_qpls(struct gve_priv *priv=
)
> >               return -ENOMEM;
> >
> >       start_id =3D gve_tx_start_qpl_id(priv);
> > +     page_count =3D priv->tx_pages_per_qpl;
> >       for (i =3D start_id; i < start_id + gve_num_tx_qpls(priv); i++) {
> >               err =3D gve_alloc_queue_page_list(priv, i,
> > -                                             priv->tx_pages_per_qpl);
> > +                                             page_count);
> >               if (err)
> >                       goto free_qpls;
> >       }
> >
> >       start_id =3D gve_rx_start_qpl_id(priv);
> > +
> > +     /* For GQI_QPL number of pages allocated have 1:1 relationship wi=
th
> > +      * number of descriptors. For DQO, number of pages required are
> > +      * more than descriptors (because of out of order completions).
> > +      */
> > +     page_count =3D priv->queue_format =3D=3D GVE_GQI_QPL_FORMAT ?
> > +             priv->rx_data_slot_cnt : priv->rx_pages_per_qpl;
> >       for (i =3D start_id; i < start_id + gve_num_rx_qpls(priv); i++) {
> >               err =3D gve_alloc_queue_page_list(priv, i,
> > -                                             priv->rx_data_slot_cnt);
> > +                                             page_count);
> >               if (err)
> >                       goto free_qpls;
> >       }
> > @@ -2051,7 +2059,7 @@ static int gve_init_priv(struct gve_priv *priv, b=
ool skip_describe_device)
> >
> >       /* Big TCP is only supported on DQ*/
> >       if (!gve_is_gqi(priv))
> > -             netif_set_tso_max_size(priv->dev, DQO_TX_MAX);
> > +             netif_set_tso_max_size(priv->dev, GVE_DQO_TX_MAX);
> >
> >       priv->num_registered_pages =3D 0;
> >       priv->rx_copybreak =3D GVE_DEFAULT_RX_COPYBREAK;
>

