Return-Path: <netdev+bounces-23382-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0841876BBFD
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 20:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF1791C20F8B
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 18:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A811A235AA;
	Tue,  1 Aug 2023 18:10:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B93A23589
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 18:10:57 +0000 (UTC)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18EA52102
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 11:10:55 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-40a47e8e38dso30311cf.1
        for <netdev@vger.kernel.org>; Tue, 01 Aug 2023 11:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690913454; x=1691518254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QFUhmyQJbR54rCEQFZff4URGPyo2Zir0kBSkhSAzaCU=;
        b=txOxNXYS9VFufaCqibaiHJeeug3hcjEu2dzCrq7KQsr36KJAUPfO1IKYOXMrK23Msk
         +KQLzTo4Dy27q3igyezo0GM7IrCyoWOBvErXXBd0FV58hctTdy0GdbDcd6pg9h48tas2
         fqXe9k1J+5Yqym38YW3WcHHt3LT//zuRa7vwXExDPzukraoWcwUMy2LvoUS9rp8LqsSL
         y+mmK3Q6kTuorit27sCdFSMPTbWQnu1HQcWW/efCXPsfln1ASrAjpJVorvt753CbPE03
         DZyztXM9g9zNtnIXHr5NAXvUbIXsTGHDtA8njJiSH1wVRxN7OzyY4mL/+dBKiC8fSxEE
         pkwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690913454; x=1691518254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QFUhmyQJbR54rCEQFZff4URGPyo2Zir0kBSkhSAzaCU=;
        b=SrGq5I8HPsatwwHIKXemrOtdBjHOkMmTeQzgJay5jsJUdkQNfEYtXKSWJy9vPJ7X4F
         jI4aB4BEs6yJHKDao6IVZk1X7sCVs6skff96xWPcvk+0UbEb5zSACxnQaU/EgQcMOs7Z
         JwGwRqergQJ6AXDieQyXdigt1tOu9SDzphRCnOMmHmdSJlRvAP7V7WhIOtyJNJk+1mLh
         O0fneVusyIr9uNLNZwzZ1FqICIqw5vg9jM4HO5s2pRvRbRzPVVyV+VoG/PtK2pNnybke
         injfi0wkbtLYK5QkJQmPTkUDhxMMDbOp4YfhEi/kK8iPN8TuafKQdzwxpPsELDGIGQzQ
         X0/Q==
X-Gm-Message-State: ABy/qLZvsHM1Tb80mPl7Y1A+QYsLJFNmAkQLqbB6NxrP3OYnNwiHzFIt
	nMR62XdWNnPFGP+q6POg9/sRlqz7JQbZS+Idma6plg==
X-Google-Smtp-Source: APBJJlFa5U2gD4fpJzrMpf8ws3diIdW4rIqnuL0+7ORfZW+XtTO+9tQCLmV9UTO2Zv1jJAEayJ599Ergn+y0PyL/SPo=
X-Received: by 2002:a05:622a:104d:b0:403:9572:e37f with SMTP id
 f13-20020a05622a104d00b004039572e37fmr737493qte.22.1690913453910; Tue, 01 Aug
 2023 11:10:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230801135455.268935-1-edumazet@google.com> <20230801135455.268935-2-edumazet@google.com>
 <64c9285b927f8_1c2791294e4@willemb.c.googlers.com.notmuch>
 <CANn89iJwP_Ar57Te0EG2fAjM=JNL+N0mYwnEZDrJME4nhe4WTg@mail.gmail.com> <64c947578a8c7_1c9eb8294e6@willemb.c.googlers.com.notmuch>
In-Reply-To: <64c947578a8c7_1c9eb8294e6@willemb.c.googlers.com.notmuch>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 1 Aug 2023 20:10:42 +0200
Message-ID: <CANn89iK80Oi6Hg90DXbXk=cyJxbzGD3zaFGGTSuWVvC5mNnR_Q@mail.gmail.com>
Subject: Re: [PATCH net-next 1/4] net: allow alloc_skb_with_frags() to
 allocate bigger packets
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, 
	Tahsin Erdogan <trdgn@amazon.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 1, 2023 at 7:56=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>

> Thanks for the explanation. For @data_len =3D=3D 5000, you would want to
> allocate an order-1?

Presumably we could try a bit harder, I will send a V2.

