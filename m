Return-Path: <netdev+bounces-38764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4CBD7BC63B
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 10:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED0011C20959
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 08:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B350714F84;
	Sat,  7 Oct 2023 08:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BHb3IkdN"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F54B749B
	for <netdev@vger.kernel.org>; Sat,  7 Oct 2023 08:54:06 +0000 (UTC)
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D0C9C
	for <netdev@vger.kernel.org>; Sat,  7 Oct 2023 01:54:04 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id a1e0cc1a2514c-7ab9488f2f0so1225439241.3
        for <netdev@vger.kernel.org>; Sat, 07 Oct 2023 01:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696668844; x=1697273644; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=57HJbY/GJGaFoncL17kTqIgclxOlEG22wnrHIVTe6nc=;
        b=BHb3IkdNumN6HjvYiXW5d14Kx/hdsmkppSdpL3rDOyFOLXO1nznqTZYPj01X1FCmx5
         tY0lX51xqx55CRSOEg1Tw8GeDdKVrIEsd3juLwXLixbZO7ZICMJXryPS6dmnMsNYrzFI
         6AuPbqaNJqvZN7MAJ6BIe03SsqOWV4Yxa62qJHvLAttdfjlxE7gWYm3exG3NREPTAEN5
         hFCgamF6E+oocpZvvJ/30ZxGAl+0TwoOh9k1+yTOlEql8rMPfA7TU1o7XMU5pQOuhuWv
         bXx85yoNHQdvJtofkWdMShKSlMbLYFJE4qxo5KE7v1ogfN8NY8hbIZWF1u1PMPcm7euP
         u8iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696668844; x=1697273644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=57HJbY/GJGaFoncL17kTqIgclxOlEG22wnrHIVTe6nc=;
        b=ae3ik//UiA7BQthRY2swBPPw5fiYTQ4Xm4/cDPqC63mBWNwusZfH32jeOQ4ppW8oiR
         P4dkGQZsKojZQ5Y/ZI2mqCvu3XMdMFzEegEbAMS/4yUn/aLxDX4TilmHnHThBBQzwxxt
         rg2DlTDISTbkqm9cqhY1IQThR6JiwskNAuXhrjM89zFGnnyhNDJ2xJyBxLinhVNPxzW3
         XcBYL84J+amnAF6hdsCOb05uzNmHJuUnBGlx34vVYhlYPmWpiBaWyVixy1+XfnHMeKZd
         un2Oa/lypv0HMhyCZ+6y4eRZ1pgqOOrdjGZ67f3SPn2ouqryig9aVMeZojJ73JVVotnh
         H/Sw==
X-Gm-Message-State: AOJu0YxxZSTBSJxWJ5FdMrsGsjQNxvMZ6YVTMjyRT9qop3EL07R/vF0C
	LppPybaYXSfV2+YfJ2CbcFGvcbXOXyfe8xU2wO4=
X-Google-Smtp-Source: AGHT+IFO/sm0fbnGjGv2++eUMf1n7I9nN6YU1BXeVY20zRoakKOE0xjUqzfFHHoB7inrEB65KjLe/0e857w4Go1Jwhw=
X-Received: by 2002:a05:6102:2757:b0:44e:9614:39bf with SMTP id
 p23-20020a056102275700b0044e961439bfmr8162411vsu.6.1696668843908; Sat, 07 Oct
 2023 01:54:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231006173355.2254983-1-edumazet@google.com>
In-Reply-To: <20231006173355.2254983-1-edumazet@google.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Sat, 7 Oct 2023 03:53:26 -0500
Message-ID: <CAF=yD-J6=X_O5WuvwqnKR=vEsvFdEFwkyP4Obq23hAaoA=Kb-A@mail.gmail.com>
Subject: Re: [PATCH net] net: refine debug info in skb_checksum_help()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Oct 6, 2023 at 12:34=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> syzbot uses panic_on_warn.
>
> This means that the skb_dump() I added in the blamed commit are
> not even called.
>
> Rewrite this so that we get the needed skb dump before syzbot crashes.
>
> Fixes: eeee4b77dc52 ("net: add more debug info in skb_checksum_help()")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Reported-by: Willem de Bruijn <willemb@google.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

