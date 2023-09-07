Return-Path: <netdev+bounces-32426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85DAA7977D3
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 18:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8A1A28149B
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 16:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D64812B6A;
	Thu,  7 Sep 2023 16:34:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496AE2C80
	for <netdev@vger.kernel.org>; Thu,  7 Sep 2023 16:34:56 +0000 (UTC)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D910F4231
	for <netdev@vger.kernel.org>; Thu,  7 Sep 2023 09:34:27 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c1e3a4a06fso8832595ad.3
        for <netdev@vger.kernel.org>; Thu, 07 Sep 2023 09:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694104406; x=1694709206; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HFTyNpM7yAvE7umrFRNXGK4VqMg2wT15/J42PJIZjWk=;
        b=zkt2piY8UmQDa7NtD0or5fEZZ3mE2v5P+ZnfefKft3zlXQyKT578RfyxAuai2ZktFU
         Ih5YnXFbii3JntQwXY7FvTxFsBKGYUPl499Ys+cW5QoXMCEsO569Xvk5TpVmgyk4M4G1
         ESUWSRVXLEt4ajWFxKn6rElI8+5AFnHDQ5cN7xw7e4SknsrvPKwHc3NcTd0gqzNdGBtd
         4Miq1RMrw9wckHrJy8SDoUwb6ax2VnYv6wX9V5G1EPunNcIZN/kga4ZgRGfTPOREXkJx
         GNL65VsmBNcX+JwXHseYeKncsaI+U9bkx0J5OaRsg+R4G9Wj2jV1khHKDzqtemgLWFYK
         Kaxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694104406; x=1694709206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HFTyNpM7yAvE7umrFRNXGK4VqMg2wT15/J42PJIZjWk=;
        b=SDf6xFWsyzHJqrbwE3kJj01urKEBU4ddpPPUpyxYYAQKuMilRiOvrktYluciRs6Kxi
         YURy61YKFSnS0OZJtXcMgFJkfOqttco7ZLMJBTiIrmVuMR4CRwBYWYeSp3aM/6Q8wE/S
         nEIBaPWuTy0XKSWbAhASd6rd5gRELsPL8jjKB60A3blp2zyrOOkeuYtjv4LLq1zeFCpM
         n3LNup53g7fK8EYLbpkIwSH/3E1CAkl+I/pdXvPkcW4dIqVkgn6UcQKX9tjygejWlliZ
         buYf+ynDo4L+m5uZqL+BwFDPhntPC224QFz3nNaLtNgTJwC9Orm15R1U6fpz8wnhFxFz
         HfXg==
X-Gm-Message-State: AOJu0YywEFl7oQSXRbsLHshyO/p06CHCjxCNJv777t86hracZm2kUxX8
	dDFHE26cNlCJ1fPasl+X2PIKFh+tfuzctmJXfHHjxA==
X-Google-Smtp-Source: AGHT+IFVXK1irbxzXO8CRqUEV4PhxNxRhGrZ3jC0Oo8gFa/nAhDym68ODzwQwY9xK229KAYNL+iNYAgidGBtiQ/rr0U=
X-Received: by 2002:a17:90a:b013:b0:26f:5d72:8de3 with SMTP id
 x19-20020a17090ab01300b0026f5d728de3mr119822pjq.20.1694104405601; Thu, 07 Sep
 2023 09:33:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230824192703.712881-1-larysa.zaremba@intel.com>
 <20230824192703.712881-6-larysa.zaremba@intel.com> <ZPX4ftTJiJ+Ibbdd@boxer>
 <ZPYdve6E467wewgP@lincoln> <ZPdq/7oDhwKu8KFF@boxer> <ZPncfkACKhPFU0PU@lincoln>
In-Reply-To: <ZPncfkACKhPFU0PU@lincoln>
From: Stanislav Fomichev <sdf@google.com>
Date: Thu, 7 Sep 2023 09:33:14 -0700
Message-ID: <CAKH8qBuzgtJj=OKMdsxEkyML36VsAuZpcrsXcyqjdKXSJCBq=Q@mail.gmail.com>
Subject: Re: [xdp-hints] [RFC bpf-next 05/23] ice: Introduce ice_xdp_buff
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org, 
	haoluo@google.com, jolsa@kernel.org, David Ahern <dsahern@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, Willem de Bruijn <willemb@google.com>, 
	Jesper Dangaard Brouer <brouer@redhat.com>, Anatoly Burakov <anatoly.burakov@intel.com>, 
	Alexander Lobakin <alexandr.lobakin@intel.com>, Magnus Karlsson <magnus.karlsson@gmail.com>, 
	Maryam Tahhan <mtahhan@redhat.com>, xdp-hints@xdp-project.net, netdev@vger.kernel.org, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Simon Horman <simon.horman@corigine.com>, 
	Tariq Toukan <tariqt@mellanox.com>, Saeed Mahameed <saeedm@mellanox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 7, 2023 at 7:27=E2=80=AFAM Larysa Zaremba <larysa.zaremba@intel=
.com> wrote:
>
> On Tue, Sep 05, 2023 at 07:53:03PM +0200, Maciej Fijalkowski wrote:
> > On Mon, Sep 04, 2023 at 08:11:09PM +0200, Larysa Zaremba wrote:
> > > On Mon, Sep 04, 2023 at 05:32:14PM +0200, Maciej Fijalkowski wrote:
> > > > On Thu, Aug 24, 2023 at 09:26:44PM +0200, Larysa Zaremba wrote:
> > > > > In order to use XDP hints via kfuncs we need to put
> > > > > RX descriptor and ring pointers just next to xdp_buff.
> > > > > Same as in hints implementations in other drivers, we achieve
> > > > > this through putting xdp_buff into a child structure.
> > > >
> > > > Don't you mean a parent struct? xdp_buff will be 'child' of ice_xdp=
_buff
> > > > if i'm reading this right.
> > > >
> > >
> > > ice_xdp_buff is a child in terms of inheritance (pointer to ice_xdp_b=
uff could
> > > replace pointer to xdp_buff, but not in reverse).
> > >
> > > > >
> > > > > Currently, xdp_buff is stored in the ring structure,
> > > > > so replace it with union that includes child structure.
> > > > > This way enough memory is available while existing XDP code
> > > > > remains isolated from hints.
> > > > >
> > > > > Minimum size of the new child structure (ice_xdp_buff) is exactly
> > > > > 64 bytes (single cache line). To place it at the start of a cache=
 line,
> > > > > move 'next' field from CL1 to CL3, as it isn't used often. This s=
till
> > > > > leaves 128 bits available in CL3 for packet context extensions.
> > > >
> > > > I believe ice_xdp_buff will be beefed up in later patches, so what =
is the
> > > > point of moving 'next' ? We won't be able to keep ice_xdp_buff in a=
 single
> > > > CL anyway.
> > > >
> > >
> > > It is to at least keep xdp_buff and descriptor pointer (used for ever=
y hint) in
> > > a single CL, other fields are situational.
> >
> > Right, something must be moved...still, would be good to see perf
> > before/after :)
> >
> > >
> > > > >
> > > > > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > > > > ---
> > > > >  drivers/net/ethernet/intel/ice/ice_txrx.c     |  7 +++--
> > > > >  drivers/net/ethernet/intel/ice/ice_txrx.h     | 26 +++++++++++++=
+++---
> > > > >  drivers/net/ethernet/intel/ice/ice_txrx_lib.h | 10 +++++++
> > > > >  3 files changed, 38 insertions(+), 5 deletions(-)
> > > > >
> > > > > diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/=
net/ethernet/intel/ice/ice_txrx.c
> > > > > index 40f2f6dabb81..4e6546d9cf85 100644
> > > > > --- a/drivers/net/ethernet/intel/ice/ice_txrx.c
> > > > > +++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
> > > > > @@ -557,13 +557,14 @@ ice_rx_frame_truesize(struct ice_rx_ring *r=
x_ring, const unsigned int size)
> > > > >   * @xdp_prog: XDP program to run
> > > > >   * @xdp_ring: ring to be used for XDP_TX action
> > > > >   * @rx_buf: Rx buffer to store the XDP action
> > > > > + * @eop_desc: Last descriptor in packet to read metadata from
> > > > >   *
> > > > >   * Returns any of ICE_XDP_{PASS, CONSUMED, TX, REDIR}
> > > > >   */
> > > > >  static void
> > > > >  ice_run_xdp(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp,
> > > > >             struct bpf_prog *xdp_prog, struct ice_tx_ring *xdp_ri=
ng,
> > > > > -           struct ice_rx_buf *rx_buf)
> > > > > +           struct ice_rx_buf *rx_buf, union ice_32b_rx_flex_desc=
 *eop_desc)
> > > > >  {
> > > > >         unsigned int ret =3D ICE_XDP_PASS;
> > > > >         u32 act;
> > > > > @@ -571,6 +572,8 @@ ice_run_xdp(struct ice_rx_ring *rx_ring, stru=
ct xdp_buff *xdp,
> > > > >         if (!xdp_prog)
> > > > >                 goto exit;
> > > > >
> > > > > +       ice_xdp_meta_set_desc(xdp, eop_desc);
> > > >
> > > > I am currently not sure if for multi-buffer case HW repeats all the
> > > > necessary info within each descriptor for every frag? IOW shouldn't=
 you be
> > > > using the ice_rx_ring::first_desc?
> > > >
> > > > Would be good to test hints for mbuf case for sure.
> > > >
> > >
> > > In the skb path, we take metadata from the last descriptor only, so t=
his should
> > > be fine. Really worth testing with mbuf though.
>
> I retract my promise to test this with mbuf, as for now hints and mbuf ar=
e not
> supposed to go together [0].

Hm, I don't think it's intentional. I don't see why mbuf and hints
can't coexist.
Anything pops into your mind? Otherwise, can change that mask to be
~(BPF_F_XDP_DEV_BOUND_ONLY|BPF_F_XDP_HAS_FRAGS) as part of the series
(or separately, up to you).

> Making sure they can co-exist peacefully can be a topic for another serie=
s.
> For now I just can just say with high confidence that in case of multi-bu=
ffer
> frames, we do have all the supported metadata in the EoP descriptor.
>
> [0] https://elixir.bootlin.com/linux/v6.5.2/source/kernel/bpf/offload.c#L=
234
>
> >
> > Ok, thanks!
> >

