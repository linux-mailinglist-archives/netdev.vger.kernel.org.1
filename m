Return-Path: <netdev+bounces-41536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 046597CB36D
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 21:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51626B20E1D
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 19:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7D2347DD;
	Mon, 16 Oct 2023 19:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iu/Wz/Oc"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD19E31A93
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 19:42:25 +0000 (UTC)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9131683
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 12:42:23 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so342a12.0
        for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 12:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697485342; x=1698090142; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jTCw1J+PtbxSUK2345kRhvWOvvy1D1K1RsS0JllOSck=;
        b=iu/Wz/Oc9pmDP58DXLo4T802lCgtnVFGcV3l2djRtQgRxVbuukj9WIBfOpqwascuvj
         oU80Fata0E0TrTqzQO26x4VpHT9qhGMfEneHSo391M8+MVHksddDfrsk6VRMKw/JUFYr
         IWykGk1ykIQtBVcDBgPpgC9gOb2yEx+LcyFL0ltdB2YezzYA2AshNnw0NVgJKvfpT8CP
         KASlw+3siZsh+gMkgRKcURiHImnpCIBkYc/0qBvAk+HZIM+EbMtXGG+AfEzejyFsEoxe
         9eVt+9OVtd1NW2Yt8DrfeO+/YRW/hjAs+5+xs5AFL2Bqv0nkA5XdjRu2lKW7lV7g3qTg
         dySQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697485342; x=1698090142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jTCw1J+PtbxSUK2345kRhvWOvvy1D1K1RsS0JllOSck=;
        b=JOr3Y+UXLJ2tehnmoaBCFo/eFB0d20vzfrZDYHKugyNHn1a7DdE1SN/BoOKJNeD5gW
         CAfD/CygGrFv659lzJRry+oW6hsks76UeXA6SjimiIDh51LHIAXo2QllFfOxhE+/Kyb+
         YYdK4+IuSw1UGYbXn7GfCRcTBtKcVK/hrwboNFDY76d6B0jQe3yjygQ/CEaH8xrn/Ied
         tPbMu5JnL17EadY8ObMWE6qIfAXMDEAAM+G2pbr4gWy2PcR9KwuEJFMWLojGY2IbsXkf
         WwneABPoaJOqWs3lPije2pU/OGa6l2AkKahH9T3B7sXSn0UAd2w4T/a4cltnmaHIw3Y2
         N0Tg==
X-Gm-Message-State: AOJu0Yyu/882GBui6yiXI5ATU217bJAX9WeQ8fPT6okY/+r3KctHIW3N
	OBRDXzkiz7ZkALeo11XBWOLckRveDJpmUfjRSyMAxw==
X-Google-Smtp-Source: AGHT+IEjzLPI7BrqkIwO1SWNpMLs/sJBVtLjwAiVsy7YfNVPYWfDZVLREjAiL5cSJJVGePau0nJgIz5p82eLzcHPo0k=
X-Received: by 2002:a50:cdc3:0:b0:538:47bb:3e88 with SMTP id
 h3-20020a50cdc3000000b0053847bb3e88mr30495edj.6.1697485341772; Mon, 16 Oct
 2023 12:42:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231016180851.3560092-1-edumazet@google.com> <20231016123319.688bbd91@hermes.local>
In-Reply-To: <20231016123319.688bbd91@hermes.local>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 16 Oct 2023 21:42:10 +0200
Message-ID: <CANn89iJdhqOtvoGsquYbicThdUGFEzLFmKR5v7wXryKz6Rw3=Q@mail.gmail.com>
Subject: Re: [PATCH net] tun: prevent negative ifindex
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	syzbot <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 16, 2023 at 9:33=E2=80=AFPM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Mon, 16 Oct 2023 18:08:51 +0000
> Eric Dumazet <edumazet@google.com> wrote:
>
> > +             ret =3D -EINVAL;
> > +             if (ifindex < 0)
> > +                     goto unlock;
>
> Shouldn't this be <=3D 0 since 0 is not a valid ifindex.
> Zero ifindex is used as a sentinel in some API's
>
> For example: if_nametoindex() returns 0 if name is not found.

Setting tfile->ifindex to zero should be a NOP ?

This means dev_index_reserve() will allocate a ifindex for us.

Not sure we want to prevent something that was working properly in the past=
.

