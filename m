Return-Path: <netdev+bounces-47467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA807EA589
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 22:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFE8B280F2A
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 21:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93862D620;
	Mon, 13 Nov 2023 21:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="hheqxdV4"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077FD2510C
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 21:37:55 +0000 (UTC)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB8AB10E0
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 13:37:52 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5afabb23900so58348847b3.2
        for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 13:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1699911472; x=1700516272; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0LV0ITokBPcXbAa2Z8QDIqjjz9JHHk6U13CgWTeVF9E=;
        b=hheqxdV4CpJzoN2QwmhNQ2ov6iUgsEefoOO69GTncUKu/lwPJj8ZdNFKLwnFYWcOIi
         Z0mSg4Kn0/7o7KaPAZgM/E6iQfUzXhcB/iQBOOjyUmuI8etCZFuwXKUMy/OVNO8882Is
         2U0FrS++uLZLKKIeuXSVN3pBSejnt1ov9hYA1FWD2B4p+kxi27ad48sGnV+Bsck6wo/N
         JPJw67J39ByqBQPNCs4afdK10cPdCQnfp93+igMpF6mlj9pGxpNI076TaGsmKTHc/qbF
         ZF3K7/sqhTMK/D8KSpldR7P6zDSfovqiWFreuQE80RiiizeUfiuNTGtwRefcnTkhctgj
         PpHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699911472; x=1700516272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0LV0ITokBPcXbAa2Z8QDIqjjz9JHHk6U13CgWTeVF9E=;
        b=VGPc8210nvKA1Iz6YhXc1F2Fu7fP/exgj/68DT2U/ic763R7mnUDoXGa0acmQgXBJx
         O1p777IgwxDevli4KIFvl2o3ke4V5tszTFuXM+l4SfwTY+Tm8Xc44dxMHdUYJyHXDsWl
         8rljBRoObpxrOGBda8OSW5VrkD0ASG7425o/4yDJ9kzPtuqZLaV3e8bUVjXhaGqucyM6
         DenLbX7pdeMSZE1DybHdCATPoQ8OZGf6SQU4dSyDj29tkhnIylRK+GLHAbJ+wcXrTkVj
         CEpzAgU2suc10tlQjttW2ZeR89E9KjewJNFkjXsr0E74XcL6v+xRu2UUZ93OgXIXhhhx
         hdOA==
X-Gm-Message-State: AOJu0YwzvWqH9AzmR34W++pTJ1nk1SU0QiOJJctXzGouqoH+lnvsvOv6
	UGDltSxfcNFcKhrUX6wVbx/ijw3iRUD4pz5hbGADcQ==
X-Google-Smtp-Source: AGHT+IHCSCOAUmrAIL9hd0EjRkCiqGB6Ldd01trnssnK4XAVGcdaUTAafiirYqU2uAlU2oqUA+xLDZiWDam1V55/5Qs=
X-Received: by 2002:a05:690c:306:b0:569:e7cb:cd4e with SMTP id
 bg6-20020a05690c030600b00569e7cbcd4emr5724235ywb.48.1699911472071; Mon, 13
 Nov 2023 13:37:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f8685ec7702c4a448a1371a8b34b43217b583b9d.1699898008.git.lucien.xin@gmail.com>
In-Reply-To: <f8685ec7702c4a448a1371a8b34b43217b583b9d.1699898008.git.lucien.xin@gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 13 Nov 2023 16:37:40 -0500
Message-ID: <CAM0EoMmnzonWhGY7Di2wgrt--hJf5TrcCObPnkOuehLuiziKdw@mail.gmail.com>
Subject: Re: [PATCH net] net: sched: do not offload flows with a helper in act_ct
To: Xin Long <lucien.xin@gmail.com>
Cc: network dev <netdev@vger.kernel.org>, davem@davemloft.net, kuba@kernel.org, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Vladyslav Tarasiuk <vladyslavt@nvidia.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 13, 2023 at 12:53=E2=80=AFPM Xin Long <lucien.xin@gmail.com> wr=
ote:
>
> There is no hardware supporting ct helper offload. However, prior to this
> patch, a flower filter with a helper in the ct action can be successfully
> set into the HW, for example (eth1 is a bnxt NIC):
>
>   # tc qdisc add dev eth1 ingress_block 22 ingress
>   # tc filter add block 22 proto ip flower skip_sw ip_proto tcp \
>     dst_port 21 ct_state -trk action ct helper ipv4-tcp-ftp
>   # tc filter show dev eth1 ingress
>
>     filter block 22 protocol ip pref 49152 flower chain 0 handle 0x1
>       eth_type ipv4
>       ip_proto tcp
>       dst_port 21
>       ct_state -trk
>       skip_sw
>       in_hw in_hw_count 1   <----
>         action order 1: ct zone 0 helper ipv4-tcp-ftp pipe
>          index 2 ref 1 bind 1
>         used_hw_stats delayed
>
> This might cause the flower filter not to work as expected in the HW.
>
> This patch avoids this problem by simply returning -EOPNOTSUPP in
> tcf_ct_offload_act_setup() to not allow to offload flows with a helper
> in act_ct.
>
> Fixes: a21b06e73191 ("net: sched: add helper support in act_ct")
> Signed-off-by: Xin Long <lucien.xin@gmail.com>

I didnt quite follow:
The driver accepted the config, but the driver "kind of '' supports
it. (enough to not complain and then display it when queried).
Should the driver have rejected something it doesnt fully support?

cheers,
jamal

> ---
>  include/net/tc_act/tc_ct.h | 9 +++++++++
>  net/sched/act_ct.c         | 3 +++
>  2 files changed, 12 insertions(+)
>
> diff --git a/include/net/tc_act/tc_ct.h b/include/net/tc_act/tc_ct.h
> index 8a6dbfb23336..77f87c622a2e 100644
> --- a/include/net/tc_act/tc_ct.h
> +++ b/include/net/tc_act/tc_ct.h
> @@ -58,6 +58,11 @@ static inline struct nf_flowtable *tcf_ct_ft(const str=
uct tc_action *a)
>         return to_ct_params(a)->nf_ft;
>  }
>
> +static inline struct nf_conntrack_helper *tcf_ct_helper(const struct tc_=
action *a)
> +{
> +       return to_ct_params(a)->helper;
> +}
> +
>  #else
>  static inline uint16_t tcf_ct_zone(const struct tc_action *a) { return 0=
; }
>  static inline int tcf_ct_action(const struct tc_action *a) { return 0; }
> @@ -65,6 +70,10 @@ static inline struct nf_flowtable *tcf_ct_ft(const str=
uct tc_action *a)
>  {
>         return NULL;
>  }
> +static inline struct nf_conntrack_helper *tcf_ct_helper(const struct tc_=
action *a)
> +{
> +       return NULL;
> +}
>  #endif /* CONFIG_NF_CONNTRACK */
>
>  #if IS_ENABLED(CONFIG_NET_ACT_CT)
> diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
> index 0db0ecf1d110..b3f4a503ee2b 100644
> --- a/net/sched/act_ct.c
> +++ b/net/sched/act_ct.c
> @@ -1549,6 +1549,9 @@ static int tcf_ct_offload_act_setup(struct tc_actio=
n *act, void *entry_data,
>         if (bind) {
>                 struct flow_action_entry *entry =3D entry_data;
>
> +               if (tcf_ct_helper(act))
> +                       return -EOPNOTSUPP;
> +
>                 entry->id =3D FLOW_ACTION_CT;
>                 entry->ct.action =3D tcf_ct_action(act);
>                 entry->ct.zone =3D tcf_ct_zone(act);
> --
> 2.39.1
>

