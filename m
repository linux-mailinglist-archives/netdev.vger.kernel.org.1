Return-Path: <netdev+bounces-45513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2137DDBF2
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 05:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0500B20F4D
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 04:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F217F;
	Wed,  1 Nov 2023 04:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GFGQ5Jyx"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9961374
	for <netdev@vger.kernel.org>; Wed,  1 Nov 2023 04:50:02 +0000 (UTC)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479C9101
	for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 21:50:01 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-54357417e81so7749a12.0
        for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 21:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698814200; x=1699419000; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yhQrGrRiXOP6T/LjlMKW+7pqde7WtEKCtrVNN6uAKIY=;
        b=GFGQ5JyxZLdxHR4X1IudqTZgn0B9fhT2jThnnP88CsB5w6UHDavcl1wvaMKeTJOQ5U
         NIM9nzE1qbb52hq+c6JV3NQNUYDi5jtUphaFM0ss5S+9tnzNztjP7/B0AX6LGUr6/aic
         wjAJfm7pIIcdf/zmlX5KnuioGyFFIGTs0KC/fNwhgKPGzWz8s3KhAO+TJw8WrnVYK8KN
         G0c97pWdPJwdH/n2/+a5lKbzNuJyo7I+4EYH6YyCiqFu+E8DJYvfDBMRmbOkGodw4Cg/
         cx3ZY5sZ5WPiVV+WQ5dbUX5f9OhCWmYWR0zrIVVowD4+Z/r/hZ/66Mc/gsYrNP90m4Md
         rA0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698814200; x=1699419000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yhQrGrRiXOP6T/LjlMKW+7pqde7WtEKCtrVNN6uAKIY=;
        b=MV0HdvVpM/IGYFSVrn2RZGnEN35oikrf0HGQdGco48mem03fS5Aui8MWTXsuTPnbmt
         AW+kfBpNRD3zoIIbziZK4oCNkFOdEFkl5DoRr83+1+nxV6kbTpRWtl8LFM/N+p7+e81X
         fpuuJIoJockBKw/s5Y3hgfTSJ9NLu7CKC6nTC7qHgoDfgIBqWx5T5XHNQhOE8FWUQr69
         LlULEqAS4I7C3KlQB+AUXzCdqJXtDSoMIbKQcJLm8alzeWz2IT9DIk9rC8AKgG4lrVY0
         szNx0royjDflCftR9JmZel47k7QXHjpAiroSzmTiUM1HrGc9HPvtGdb/g1grUGbbrA5H
         lgFQ==
X-Gm-Message-State: AOJu0YyelTwu3V8qQGZlmNO7hcjFUanrleA1PEPiX7Pbfk6ORELRMZNC
	/5Scz6Ngc4K5ZBXSjIgzR8f8loKHixH99zpYo+nOsA==
X-Google-Smtp-Source: AGHT+IHxAeRmRNwusd8SDjsAoXM6juVtUd+PfRg+3YUq/OHZ9FhyQX9RugH2kSnb5B3Bir6sLB+JT2x3UIjYR1Fpsdk=
X-Received: by 2002:a50:c04f:0:b0:542:d737:dc7e with SMTP id
 u15-20020a50c04f000000b00542d737dc7emr258881edd.0.1698814199560; Tue, 31 Oct
 2023 21:49:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231031-tcp-ao-fix-label-in-compound-statement-warning-v1-1-c9731d115f17@kernel.org>
In-Reply-To: <20231031-tcp-ao-fix-label-in-compound-statement-warning-v1-1-c9731d115f17@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 1 Nov 2023 05:49:45 +0100
Message-ID: <CANn89i+YpJ+y23f=b0uByVJCqh1Rjau44vP-saRD60kFG7J4fw@mail.gmail.com>
Subject: Re: [PATCH net] tcp: Fix -Wc23-extensions in tcp_options_write()
To: Nathan Chancellor <nathan@kernel.org>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, ndesaulniers@google.com, trix@redhat.com, 
	0x7f454c46@gmail.com, fruggeri@arista.com, noureddine@arista.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 31, 2023 at 9:23=E2=80=AFPM Nathan Chancellor <nathan@kernel.or=
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


Reviewed-by: Eric Dumazet <edumazet@google.com>

