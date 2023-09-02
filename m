Return-Path: <netdev+bounces-31814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B197905A6
	for <lists+netdev@lfdr.de>; Sat,  2 Sep 2023 08:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64E751C208E4
	for <lists+netdev@lfdr.de>; Sat,  2 Sep 2023 06:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC591FDF;
	Sat,  2 Sep 2023 06:45:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5191FC5
	for <netdev@vger.kernel.org>; Sat,  2 Sep 2023 06:45:27 +0000 (UTC)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF201702
	for <netdev@vger.kernel.org>; Fri,  1 Sep 2023 23:45:24 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-414b35e686cso98581cf.0
        for <netdev@vger.kernel.org>; Fri, 01 Sep 2023 23:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693637124; x=1694241924; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9p2LJ26GXa+r/Lp18Z1APmd9XtUMzqS3yzmCaRlAsEQ=;
        b=Ag8cYKirismDMkHQVQkJwd1Y9YPfzodrhNgB+R0gDKLvM8sjQr4KdNQx0uhAhQHd3i
         MYHlz6uGhUeySY6hpbAJf/ysBdMH1QOAYBA9qi/r7Rig0o9ZBQOTvmoQNuXVgkRPgdVV
         u/TXLdGGvA18hA8eWIIOHe1FD4RVfBbF9JFFlPAQGolAlMqKc3on0UFF9x7Uems0GnVj
         oWrojMXurBlLREHUxPLHeJtg5YR5sbXd6k6azv12MaC46xVNZa3ODOegFutQsCmHf+aa
         53laAg/dkqjH36ag0/V+ldJXnbOrGp7MjDS/tU2KoRQP5Zi3KLkxKBRnU+aSvCF6s5db
         QKhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693637124; x=1694241924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9p2LJ26GXa+r/Lp18Z1APmd9XtUMzqS3yzmCaRlAsEQ=;
        b=gFKxhqnxXuNlGTIl0QJ6bBCraeAb/Nq3wITSDp0WYlJFneecwUjcw/gFzzq0LsBaRr
         /bJLJtaxZR31NCw+Y7AAlXUs/caFQ4ZmCEwXnW8WbyV3iuFs/xnh3J1P2EAXu1gtZFYZ
         v1S8ESF+AH/JqQwQyti6zcEKMnyg5seK1AW473wcn9CPtHnqlXwQbAdemucpqpA8sMvk
         8VrTDZaYcrbYVnocrDHYnBJPsMlppymiXKaEEzaldNmPyD3RTcpLP4dU8EMHxmB8/vsu
         /aD2k1qQlj48GdLTN+dccSzpBioeAroMtHoaparJN/3MAQ3OUBiubPnTcOvHttGB0MZb
         1zHw==
X-Gm-Message-State: AOJu0YxhPX4uq4/uU83CnQO3S7jOA9sk8lKd/hXRv7IUE3bWLS7P6zCL
	HqvCaI0xuBMgfu6BF/3ChFtJZDKGIveGtsXjTPFeHQ==
X-Google-Smtp-Source: AGHT+IHfFgSXdjtXZpAuEeLzA+APgfV5tUoplr8A1JYFOm6bDZaeTvwhGgp4ELEJRtKY47GUztCmiTWip0k83A//JjA=
X-Received: by 2002:a05:622a:1aa0:b0:403:f5b8:2bd2 with SMTP id
 s32-20020a05622a1aa000b00403f5b82bd2mr75014qtc.9.1693637123695; Fri, 01 Sep
 2023 23:45:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230902002708.91816-1-kuniyu@amazon.com> <20230902002708.91816-5-kuniyu@amazon.com>
In-Reply-To: <20230902002708.91816-5-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 2 Sep 2023 08:45:12 +0200
Message-ID: <CANn89iJnbUT4SxkU2Mm9SrxaUSGHojXUqaBwSxr=fUG9wbacNw@mail.gmail.com>
Subject: Re: [PATCH v1 net 4/4] af_unix: Fix data race around sk->sk_err.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Sep 2, 2023 at 2:29=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.com=
> wrote:
>
> As with sk->sk_shutdown shown in the previous patch, sk->sk_err can be
> read locklessly by unix_dgram_sendmsg().
>
> Let's use READ_ONCE() for sk_err as well.
>
> Note that the writer side is marked by commit cc04410af7de ("af_unix:
> annotate lockless accesses to sk->sk_err").
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---

Title is slightly off, since this is a generic net: change, but this
is fine really ;)

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks.

