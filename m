Return-Path: <netdev+bounces-34116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC04A7A2243
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 17:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA3321C209D0
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 15:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506FE1097E;
	Fri, 15 Sep 2023 15:23:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A53130D05
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 15:23:14 +0000 (UTC)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A43A10C3
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 08:23:13 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-414ba610766so358701cf.0
        for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 08:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694791392; x=1695396192; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8AmkuEt8ysd+GqFrDHSbOmOWfm8Q6bwfOc58izBol+I=;
        b=t564hkMbSYA6dE1iUFsEi9t+wGaTMdgILE3LIkL7+3N8oReovrPTqXhYhFkn7QO5uF
         6g+7m5mTzFOcYwW9JImb2QWpKjuq0CEo40duDrnWdD898ENJc/5DvR4R5gv9M0qLtQ4G
         bm8umek2rlfVY3aTsTb3HEwq8kB2aiEcm1TMGEvA8RBWWLEOmJJlJGOGK4hcDZj7LpEp
         krFhAvQl4Fm0BzIl698n7aCOP83j6MfxkXm4FMQVTwT0JH7fF+B6wquPJ/lwbGrigIMB
         ewtDmf1XH1juRkPcU27ssvklCfWRFMMAaAbPgYgxRzWtaDMDBb2mwXuWnMOkL7VFm4t/
         f1VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694791392; x=1695396192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8AmkuEt8ysd+GqFrDHSbOmOWfm8Q6bwfOc58izBol+I=;
        b=EtvTVMlxmjIb6/ED0Smp6fraSYUs00zJiheXSxcQ37BFy6BvT8PCQd4TPdEUKvv33Y
         SqguynFnFy8IzfUDQ2d7UqAD7xhfYemV+wRG0cM3zWWDQnyU464kZGK0LuCIileNG0if
         8bbUwWBXfByBaAZF/m20M8VVXBJkYE+dHHO4RT8atgqo7sol3zJoCTcddOwnxFaStnS9
         JmihTARRSLW7zrlbVcg7dfZhC9anzNRJ0VISx6jPuIMrhyMeLSVXZOBWxu5VxEmP/Y0M
         yajL4BRRvFvznkpzODlZlGysfHfVUbnKTYYtzLe6WHzkrArFCahC7vubGGRXrXONNteL
         iaKA==
X-Gm-Message-State: AOJu0Yy+Zy+tuJO8VuCX8XK9e5wu1XHCbxz5uPO+2vwCrh0HLq2sproU
	9WDoyzjM/aFgMJXQ/10d+l2oTOnYOjDhPEJh5k01wA==
X-Google-Smtp-Source: AGHT+IFtT9O2eIzv6D+iD4VJqVLnZdqS3gHyVcOTdD1mZXbgtCKppvtMtLQiu6eMzvjs4VzWpFZqC1AtEuux33g0YDE=
X-Received: by 2002:a05:622a:2c3:b0:412:7cc4:a0f4 with SMTP id
 a3-20020a05622a02c300b004127cc4a0f4mr266958qtx.8.1694791392202; Fri, 15 Sep
 2023 08:23:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230915151512.3803083-1-edumazet@google.com> <CAG48ez3P_jniG+qwL62Qf3FZvau2LnrgENo-C49u95PbzW5r7A@mail.gmail.com>
In-Reply-To: <CAG48ez3P_jniG+qwL62Qf3FZvau2LnrgENo-C49u95PbzW5r7A@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 15 Sep 2023 17:23:00 +0200
Message-ID: <CANn89iJDG3uRQTpAwgRN4zSf2AVPAuxBhmtgTq0WUC+jVebr6Q@mail.gmail.com>
Subject: Re: [PATCH net] dccp: fix dccp_v4_err()/dccp_v6_err() again
To: Jann Horn <jannh@google.com>
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

On Fri, Sep 15, 2023 at 5:20=E2=80=AFPM Jann Horn <jannh@google.com> wrote:
>
> On Fri, Sep 15, 2023 at 5:15=E2=80=AFPM Eric Dumazet <edumazet@google.com=
> wrote:
> > dh->dccph_x is the 9th byte (offset 8) in "struct dccp_hdr",
> > not in the "byte 7" as John claimed.

Oops, I made a typo on your first name, I will send a V2, sorry about that.

>
> Ugh, darnit, right you are. I guess I must have missed dccph_dport
> when I was counting...

