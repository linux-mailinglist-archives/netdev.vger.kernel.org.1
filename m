Return-Path: <netdev+bounces-37386-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD057B52ED
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 14:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 6CB82283006
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 12:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B512171DC;
	Mon,  2 Oct 2023 12:23:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65552106
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 12:23:55 +0000 (UTC)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 818A7B0
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 05:23:53 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-534694a9f26so11227a12.1
        for <netdev@vger.kernel.org>; Mon, 02 Oct 2023 05:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696249432; x=1696854232; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MnvUEayU8MtsYkHhf3OuX43tRoNbOnThzR4V8uae1d0=;
        b=vGIz3vdYOHUEXtLP+egwRwIkMcFOoCZqLba24LLeZp83XSUxCPpMP2+5NN6tenR+uk
         YvAGVL18pZCwsmpNZKXuiqCNq/4LHj55gxLv803WzydkLyB2NSpDN9sjLEGdsTRq+86q
         /trttF4ObOLocsoTG6ElmuTinxmS5osXDynEVY0ff2dvtJxwAGLoi1+NgzxoQzmQx/yE
         oHfyixfXueI19i0Uc1eNFgGGTrVnusuQic3MSwI6gk4wggS9zJ/YQ97Qz8t9BVXiMXBr
         L9vhdXHGqkpMnnfe3DWAUIsJoKD25rkxOCDlP5rK980Oqmo63HTFi6EqSdTQi3zRmebj
         l0SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696249432; x=1696854232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MnvUEayU8MtsYkHhf3OuX43tRoNbOnThzR4V8uae1d0=;
        b=VzTw2WC3OStkf6sM6Iv4okFslDjy1mBQntEB42cd3F5KZLnLQNVcHbzW9fuDxduT/f
         ureGmHIIjj3AexTPOVKHsBJC2SZNlquzPe28C2QrTAW0QBTdcSdpR79GqJW6boPEz22/
         mSCdT2b4wnqASecRaCl4Toh3Eatob3LjNPXCrgjWtuV/fzusf+GSlJEM831gleoZPQjl
         W9/DGaa8hwHUXpM7pLjtgyPJPPOPQdKE9oRyw1FbtI0XqsaKGr4DIMqfYd48Z7xbFMi8
         cCDa7SJDeEXkLwqBoT4XmGLZqkElNv2qMUT9yKxeuNNf7nppGYbTY1pPvkp7GLJmSa4t
         nGQw==
X-Gm-Message-State: AOJu0Yy3nd+/X5QOvVKXzAU0/fGFdQ7kjxANDZPxiWgHqfM1MRG1Qzt8
	G2zU30cWOY7OjLpcyuaRfh+vv39IXPDp2FT4PBfWEA==
X-Google-Smtp-Source: AGHT+IGedUiWvBYjmThf74thPaw8+bV1kckupdoRH1uLIQ/j6p4JgCuaKfxVU3Dh3gURZxs/vmpLFpKucr7nQXtzYnM=
X-Received: by 2002:a50:d096:0:b0:51a:1ffd:10e with SMTP id
 v22-20020a50d096000000b0051a1ffd010emr97505edd.3.1696249431685; Mon, 02 Oct
 2023 05:23:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231001145102.733450-1-edumazet@google.com> <20231001145102.733450-4-edumazet@google.com>
 <87edidgsc1.fsf@toke.dk>
In-Reply-To: <87edidgsc1.fsf@toke.dk>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 2 Oct 2023 14:23:38 +0200
Message-ID: <CANn89iK4H5nBurGPtkaXdMX5jA-H29X6OVC7V6AAEDTW8Q3=rA@mail.gmail.com>
Subject: Re: [PATCH net-next 3/4] net_sched: sch_fq: add 3 bands and WRR scheduling
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, 
	Soheil Hassas Yeganeh <soheil@google.com>, Neal Cardwell <ncardwell@google.com>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 2, 2023 at 1:46=E2=80=AFPM Toke H=C3=B8iland-J=C3=B8rgensen <to=
ke@redhat.com> wrote:
>
> Eric Dumazet <edumazet@google.com> writes:
>
> > Before Google adopted FQ for its production servers,
> > we had to ensure AF4 packets would get a higher share
> > than BE1 ones.
> >
> > As discussed this week in Netconf 2023 in Paris, it is time
> > to upstream this for public use.
>
> IIRC, when you mentioned this at Netconf you said the new behaviour
> would probably need to be behind a flag, but I don't see that in this
> series. What was the reason you decided to drop that?


Not a flag, this would add runtime costs.
"struct fq_sched_data" is very big and I try not adding fields unless
really necessary.

I mentioned at Netconf that we had been using this WRR mode for ~5 years
and without a flag.


>
> [..]
> > +static int fq_load_priomap(struct fq_sched_data *q,
> > +                        const struct nlattr *attr,
> > +                        struct netlink_ext_ack *extack)
> > +{
> > +     const struct tc_prio_qopt *map =3D nla_data(attr);
> > +     int i;
> > +
> > +     if (map->bands !=3D FQ_BANDS) {
> > +             NL_SET_ERR_MSG_MOD(extack, "FQ only supports 3 bands");
> > +             return -EINVAL;
> > +     }
> > +     for (i =3D 0; i < TC_PRIO_MAX + 1; i++) {
> > +             if (map->priomap[i] >=3D FQ_BANDS) {
> > +                     NL_SET_ERR_MSG_MOD(extack, "Incorrect field in FQ=
 priomap");
>
> Can we be a bit more specific than just "incorrect" here? Something like
> "FQ priomap field %d maps to a too high band %d"?

Maybe, but note sch_prio does not even set extack for this case.

This is mostly something that only fuzzers like syzbot could possibly
hit, iproute2 will not feed the kernel with such invalid values.

