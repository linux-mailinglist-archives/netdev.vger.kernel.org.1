Return-Path: <netdev+bounces-32433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3675F7978D0
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 18:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 515BE28197C
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 16:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4734B134CE;
	Thu,  7 Sep 2023 16:55:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFC34C7C
	for <netdev@vger.kernel.org>; Thu,  7 Sep 2023 16:55:37 +0000 (UTC)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC7401700
	for <netdev@vger.kernel.org>; Thu,  7 Sep 2023 09:55:14 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-414dff0a8ecso9691cf.0
        for <netdev@vger.kernel.org>; Thu, 07 Sep 2023 09:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694105653; x=1694710453; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RgZJbPEqgAz1aHRlOIydr0AYU4FXrCo7iXQy/qE6vFg=;
        b=zAwrJiH4Usv0qoLjLcYDxpsdPKFVgLLXRpBygK+Od9R8E6Dd5jDS4rVPK1DPt+i6y+
         UBLeqXY/kRH9v0oZ0/R2xUQCLEfeX/A1pB8yM0jSe64U1KaYEHAwQr7pvUFFFVg6aS4F
         r1Bs8H8aumLAwYuV0FQ2D+pB0V886pCnyU3iBH9HNaL4UeiLtob7XAtj2vxW/tuYJQSm
         hejSfzrlQi7jE/OLcQydMLNcKHXrUq06lmIV14jnmGX8Ye4mHwPpOPi5vpbDN5zR6qYj
         VoskKMhJjElDwPFSR429wqE5Vft4+MAolaI0WoSbvmFCprTCuT8LLAsUxWh4G1uA9XXw
         6I4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694105653; x=1694710453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RgZJbPEqgAz1aHRlOIydr0AYU4FXrCo7iXQy/qE6vFg=;
        b=GjQxlKFeW6fzZxOz/LJEM3k8w6bbkUQ3CESl0B5bmH+rqWi47JnQE3SsEIufKEdny/
         FsxTB57Kip8A3umqh08Kb4mANbT3WFCaZc6KQLVWdq7PCtF6kpF+C93Rjv9u4uZkgcSI
         c+zzTZfq9nPxBgIYwyrVQj1mf43Mfmaidl1fYu1wUBd/9DUKXzRHzO4ohIeMhP7hRA+v
         n/q8Qdw3aWT4p7C+2zytqLpiavPX65fkAsiMLlPG9f5aP4NAOOkcyOBAi1qKIjKpQapG
         vCdtm0MH6EDgnT07etD7AU3mmdYOwqvYbRdow7SeUMa9+KxlTPEkFp6gSMrViQ2BSFik
         JlMA==
X-Gm-Message-State: AOJu0YwsDzohRMg/2ZpVu/3SAG6amzFoV0Y+JspkYRUL5ecOgHyvKV0j
	rJDS7qbT8iTq3atSzGwY3fhVFlr/XUBVJ4ZPkW2+Tg==
X-Google-Smtp-Source: AGHT+IGPxru9qr9gVhn9FENPhMmRA9dagHheTPKHXR55uNSYIr+oDKV9XcH6AxAUvHTb3ghloYwbsPwuOtqsL8Tp7OY=
X-Received: by 2002:a05:622a:1816:b0:403:b6ff:c0b with SMTP id
 t22-20020a05622a181600b00403b6ff0c0bmr372qtc.6.1694105653133; Thu, 07 Sep
 2023 09:54:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230906201046.463236-1-edumazet@google.com> <20230906201046.463236-5-edumazet@google.com>
 <CAA93jw7Fuov-vmxiZdW7My-AVWCOFQo4XVm9bNwAg4Td2CUNCA@mail.gmail.com>
In-Reply-To: <CAA93jw7Fuov-vmxiZdW7My-AVWCOFQo4XVm9bNwAg4Td2CUNCA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 7 Sep 2023 18:54:01 +0200
Message-ID: <CANn89iLZF5Me4isAqXe+cptAOwiunMyHVeOy7Xfz_FdhFoiaqw@mail.gmail.com>
Subject: Re: [RFC net-next 4/4] tcp: defer regular ACK while processing socket backlog
To: Dave Taht <dave.taht@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Soheil Hassas Yeganeh <soheil@google.com>, Neal Cardwell <ncardwell@google.com>, 
	Yuchung Cheng <ycheng@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 7, 2023 at 6:50=E2=80=AFPM Dave Taht <dave.taht@gmail.com> wrot=
e:

> When you once said you were going to find a way to reduce the number of a=
cks, I did not expect this.
> Has this been tested on arm or at lower rates, such as a gigabit? Or agai=
nst WiFi?
>

Not yet, but my guess is that it could benefit wifi drivers that are
not using GRO,
particularly if the TCP payload is in skb->head instead of a page fragment,
defeating tcp_try_coalesce() ability to 'pretend GRO was there in the
first place'.

I sent an RFC so that others could perform tests ;)

> Regardless:
>
> Acked-by: Dave Taht <dave.taht@gmail.com>
>
> --
> Oct 30: https://netdevconf.info/0x17/news/the-maestro-and-the-music-bof.h=
tml
> Dave T=C3=A4ht CSO, LibreQos

