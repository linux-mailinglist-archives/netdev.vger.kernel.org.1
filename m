Return-Path: <netdev+bounces-19464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3FE275AC87
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 13:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88C85281DA7
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 11:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D87017729;
	Thu, 20 Jul 2023 11:04:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91584174EB
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 11:04:31 +0000 (UTC)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5D0E47
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 04:04:30 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-401d1d967beso268181cf.0
        for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 04:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689851069; x=1690455869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kaAbz+bg94X2dULJPby0h61EI3/s2cyflIACLy61V2M=;
        b=JrXHu8liyiHa5+nabqFO0UGhDu4WlqFhU92GkoAcmcOXZaE6ajO6GhjwoZfZfO5EBM
         Sfkg/qFqV4f7unsfYPca/aLwW+lm4YVC7qtyGcAyVcPzw5jeErU70ALGccBDPzK26As3
         6VpPRZGADpjmZ+zloOT591Thso+gbO3nNyYcBDIuLFNxgqoJEhqnpNg/aRLZVhQWkudd
         qQ3LamYOR58U9heID/QcUUV9ThWm0njSfM3v4j6OOvgthfRnjBM4L7G3/vA04Ga0N5nW
         /QjhzWfei0Rq4ev8ldb0/xuXh8eidAR2Sze7ZHksd21vP8xBa4OS/o+MRtHtYsrFVJpY
         7mqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689851069; x=1690455869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kaAbz+bg94X2dULJPby0h61EI3/s2cyflIACLy61V2M=;
        b=kH3MxA+ySEWzkEMmgTgTcBlWLJffmmqqU1MJmNML4V/rjvBe9kV5BwTvs8ToTs70GR
         G2Dgxm0rfjnU+wh2oT+x85PzXl21ZO4bEnTBUcfp732oiG5oSM81Y7Mc7f7F0SDCe5mQ
         KRil4EzaXGYD3Kt2vYlPcigzvZLNWieJbAF19HuDCpuJnXm5n/lJJXDgWiOl/sCLWz0F
         wvNb1eHMgNTgddfnByrcMl1U9qmFL+hbPAnkl3Be6HNh6p8CV9ZHpfy8gN+L+P0St0Wy
         TC31xJ/5jeOSngySc83DwhL0C2Ga7hsvLyHcXUjp9PWd7oRhBtwHU45g2oTQcIXb6pwS
         wdOQ==
X-Gm-Message-State: ABy/qLad/izCqIfAFFIFDQCew5wMidPf/3wr9pOf9eQjFhylR+ZREPCy
	boxmLf2vgu1qNWJ72Qx5jLuVk8kDE6TGAJtk4UT44Q==
X-Google-Smtp-Source: APBJJlGIongI2LyVBsB5n3TmUW0p+ouZF5H0ZTTH8sw831b5ebKrbTobCagtBz0Rek9ZFqj97WSgCF21OIP/bwC7+x8=
X-Received: by 2002:a05:622a:1816:b0:3f5:2006:50f1 with SMTP id
 t22-20020a05622a181600b003f5200650f1mr237783qtc.12.1689851069162; Thu, 20 Jul
 2023 04:04:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230718202437.1788505-1-edumazet@google.com> <e839c959417f813444567556177c8d3a1ef83467.camel@redhat.com>
In-Reply-To: <e839c959417f813444567556177c8d3a1ef83467.camel@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 20 Jul 2023 13:04:18 +0200
Message-ID: <CANn89iKY-s=9T_H2S9g2AWFG8YKG3DJj_WekXRRFHWqGqeKCLg@mail.gmail.com>
Subject: Re: [PATCH net-next] ipv6: remove hard coded limitation on ipv6_pinfo
To: Paolo Abeni <pabeni@redhat.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Chao Wu <wwchao@google.com>, Wei Wang <weiwan@google.com>, 
	Coco Li <lixiaoyan@google.com>, YiFei Zhu <zhuyifei@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 20, 2023 at 11:44=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> On Tue, 2023-07-18 at 20:24 +0000, Eric Dumazet wrote:
> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index 3613489eb6e3b0871da09f06561cc251fe2e0b80..b4d5cc0196c3d73f98c484b=
01a61322926da2f14 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -3988,6 +3988,7 @@ int __init mptcp_proto_v6_init(void)
> >       strcpy(mptcp_v6_prot.name, "MPTCPv6");
> >       mptcp_v6_prot.slab =3D NULL;
> >       mptcp_v6_prot.obj_size =3D sizeof(struct mptcp6_sock);
> > +     mptcp_v6_prot.ipv6_pinfo_offset =3D offsetof(struct mptcp6_sock, =
np),
>
> Checkpatch spotted that here ';'  is needed in place of ','. Yep, mptcp
> is always a little special ;)

Oops, thanks, I will fix this in V2.

