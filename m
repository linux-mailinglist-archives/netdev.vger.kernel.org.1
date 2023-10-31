Return-Path: <netdev+bounces-45484-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9627DD7EC
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 22:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D2511C20C69
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 21:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D105249FA;
	Tue, 31 Oct 2023 21:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jL8rQp6H"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE19827442
	for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 21:50:05 +0000 (UTC)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E8AF4
	for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 14:50:04 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-32dc9ff4a8fso3828486f8f.1
        for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 14:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698789002; x=1699393802; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GKyb1hV1vtUSZDqLnTgdX5n0+OXLN+juvNSKnK7I5Q0=;
        b=jL8rQp6Hvy65dLFqx+xznsHESedyRmcvA2n1x0ncCVQdD7MSGLoIfrdq6fHf1KDpmi
         IuRjwikhb21FUxfCHgo4Lj37v7cGTTNwJ+SEKFIqubZvIOZlIqoctl8l26oeKOJj07G5
         EiUqdCVHil2ZiwXiNEtJl3nIxUSS23wpoEA95gnGSSfhp430RDXVT3oY6Zmq28FUZYQM
         1m4EwfA9Xs+tCgVqTlVpstM+VBBHpZXondUMBGs6ZWDmm8m2j1GKXJ4vxOCzx5v/X20u
         qTRghWjifGdpMQtCsETf+nGTKErxBuyNFfEpjsk2/nWS7gt5NMwjis+7ckw41DOrF3LB
         T6MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698789002; x=1699393802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GKyb1hV1vtUSZDqLnTgdX5n0+OXLN+juvNSKnK7I5Q0=;
        b=mvi9YOFoVrN25PKuAi7HkjXAb3JLnbbHkrk07a3BkOPLRRboHXza9jCdbNbSMtzT0c
         EvfIWc3F4EMsUhLanp2dgR6avpEKcPSIlc2hZYKxc/QsNAy+KWTZj1FLfP3Nrlcl+c9b
         ZJumX5rnrB9eEJgqlvijvjXP2hcoDQbl2jNUW0dbhWdrNijJ2je4kc6+VpYAVV6+kh3O
         CFfpsWuxn9sF49bVcp32WBJ2DRy8sUyKkTAtfwZXysV5hwex33oYnZiVqVhZjUrK2vra
         F9kcWG44l0vzKm0JssZiK29BGS5xKtTs71kQMWmSyP9XMmCKjZd0I+t6JKustwinliI3
         5UVg==
X-Gm-Message-State: AOJu0Ywp7b6GogldZHcczWrR8ODfMInRuHOzbDZDJap2xbdofxTlcHQL
	pSEfKGvI0EnVljAkJmqU7pWDFBfrMo2CT1QEcpcN6g==
X-Google-Smtp-Source: AGHT+IFryCasodoGUQr+d/4GX14lqOug/C63+v0x+SVaHw1GimgEBCDcf3pc/kFUY3kFJsdoKLmo/dqwwMQDTEbCNHk=
X-Received: by 2002:a5d:4fc9:0:b0:31f:9b4f:1910 with SMTP id
 h9-20020a5d4fc9000000b0031f9b4f1910mr9964196wrw.63.1698789002364; Tue, 31 Oct
 2023 14:50:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231031-tcp-ao-fix-label-in-compound-statement-warning-v1-1-c9731d115f17@kernel.org>
In-Reply-To: <20231031-tcp-ao-fix-label-in-compound-statement-warning-v1-1-c9731d115f17@kernel.org>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Tue, 31 Oct 2023 14:49:51 -0700
Message-ID: <CAKwvOd=CsF8B2i6f6d95J=n3zAZ7P2+bddBGBt0st=Q-f-OniA@mail.gmail.com>
Subject: Re: [PATCH net] tcp: Fix -Wc23-extensions in tcp_options_write()
To: Nathan Chancellor <nathan@kernel.org>
Cc: edumazet@google.com, davem@davemloft.net, dsahern@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, trix@redhat.com, 0x7f454c46@gmail.com, 
	fruggeri@arista.com, noureddine@arista.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 31, 2023 at 1:23=E2=80=AFPM Nathan Chancellor <nathan@kernel.or=
g> wrote:
>
> Clang warns (or errors with CONFIG_WERROR=3Dy) when CONFIG_TCP_AO is set:
>
>   net/ipv4/tcp_output.c:663:2: error: label at end of compound statement =
is a C23 extension [-Werror,-Wc23-extensions]
>     663 |         }
>         |         ^
>   1 error generated.
>
> On earlier releases (such as clang-11, the current minimum supported
> version for building the kernel) that do not support C23, this was a
> hard error unconditionally:
>
>   net/ipv4/tcp_output.c:663:2: error: expected statement
>           }
>           ^
>   1 error generated.
>
> Add a semicolon after the label to create an empty statement, which
> resolves the warning or error for all compilers.
>
> Closes: https://github.com/ClangBuiltLinux/linux/issues/1953
> Fixes: 1e03d32bea8e ("net/tcp: Add TCP-AO sign to outgoing packets")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Well, at least ISO fixed that in C23...I found it annoying. One day we
might have nice things.  Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  net/ipv4/tcp_output.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index f558c054cf6e..6064895daece 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -658,7 +658,7 @@ static void tcp_options_write(struct tcphdr *th, stru=
ct tcp_sock *tp,
>                         memset(ptr, TCPOPT_NOP, sizeof(*ptr));
>                         ptr++;
>                 }
> -out_ao:
> +out_ao:;
>  #endif
>         }
>         if (unlikely(opts->mss)) {
>
> ---
> base-commit: 55c900477f5b3897d9038446f72a281cae0efd86
> change-id: 20231031-tcp-ao-fix-label-in-compound-statement-warning-ebd6c9=
978498
>
> Best regards,
> --
> Nathan Chancellor <nathan@kernel.org>
>


--=20
Thanks,
~Nick Desaulniers

