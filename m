Return-Path: <netdev+bounces-45271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A837DBCA1
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 16:34:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E30C2813D1
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 15:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19A5179AF;
	Mon, 30 Oct 2023 15:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="rKGnRkg1"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E58818AED
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 15:34:27 +0000 (UTC)
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34569D9
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 08:34:25 -0700 (PDT)
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id EE3FE3F19A
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 15:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1698680061;
	bh=U+HzRWWfe445TTBhBAgXB/2ejF+ftXkNxDYm8dN+cP8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=rKGnRkg1j8hQGzJ4I6NxLg9c3DUXq6/zVaHnd1UALhaxBhxLnEi7CCbf7qUmMHCO6
	 e9WpfnpYk1pUe0VxG+v5BvTFhh7pw8VFlDMxWZHFelk021DVKOPt+YnFjolxBo/hcP
	 TEgfoAufMySHW6mOF386tKntxG2NamSBur0Ua8Vfh5o1Ol3vzZKqOeroBZAoy4e7+L
	 QD3Uv3uZhTsIrYYF39Ud1y/0brgYGDccOzqlk4GMo1/Uzd8AbLa5QgCmwXWhKyHnzA
	 3Kj2ABcYqP5AE7wwi6wbu59nph8klXAXCy7kCUF71/3OYZ0DrIRUc4VhRjcVrBZS1p
	 +QaiQcddRqkCA==
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3b3ebbbdbf9so5995159b6e.0
        for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 08:34:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698680061; x=1699284861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U+HzRWWfe445TTBhBAgXB/2ejF+ftXkNxDYm8dN+cP8=;
        b=Sl/NXTi2UL/0aWc8jk6jGE3Wsd0z9KoZAv4NKB8GiExkG8qGUJPYIhYdrPQQJ+28MM
         o1Gr7EQ4QQlzY+SOsgmMiknfKkDyMDoPa+ypyGnc1quAJJwLwId0avSrlUaevGACxn9z
         3OlOebo5iv85ngCjWktfdq3S5nMXydoi/o9SXxQxdegnk+TJVxQ8ZHpecba6X5KeRrYp
         BfAsamf3oJv/lys8A/Y8Lzkx7esi8efyAyjfRrEDux4NhRAoZQpCKJLDbzXEIu5c23ij
         bw/lhblyTQX4i1iMTrC/pEn8aHHLM4vlqZsfRyG1fXm1spSQOpUbOZjO0z/T5htJ8bTy
         rPng==
X-Gm-Message-State: AOJu0YzTB+fqcACKAJOi3+s8DYqc0OkQzKy6zp07ddKig1/6sRgp+AF+
	g7mblYBxsTLYeJha2O2kYiYqO8RBtOAq2bROgg9ynaoAyKKI9hwn168Q9e9LSW5YPEYJ7MjFWc5
	VsBbe/BivL+vpNVRIfiCUUZPnd1RuT1fesX7XCGCKKTC118dx
X-Received: by 2002:a05:6870:d914:b0:1ef:bae0:4bb8 with SMTP id gq20-20020a056870d91400b001efbae04bb8mr4656730oab.29.1698680060903;
        Mon, 30 Oct 2023 08:34:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLmaoGBFAeuxipughz1BuzObURNyX+TjwBCwyAeiZQHdITLI4GtggdgVl6tKynDeG2pL6pFJ40Rp0BudyOPSQ=
X-Received: by 2002:a05:6870:d914:b0:1ef:bae0:4bb8 with SMTP id
 gq20-20020a056870d91400b001efbae04bb8mr4656716oab.29.1698680060568; Mon, 30
 Oct 2023 08:34:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231030094555.3333551-1-liuhangbin@gmail.com>
In-Reply-To: <20231030094555.3333551-1-liuhangbin@gmail.com>
From: Po-Hsu Lin <po-hsu.lin@canonical.com>
Date: Mon, 30 Oct 2023 23:34:09 +0800
Message-ID: <CAMy_GT-8fKJ1+y9Dgi5R2kuPiRJfC4gg-K0GW5NWL_vDbuTALA@mail.gmail.com>
Subject: Re: [PATCH net] selftests: pmtu.sh: fix result checking
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, David Ahern <dsahern@kernel.org>, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 30, 2023 at 5:46=E2=80=AFPM Hangbin Liu <liuhangbin@gmail.com> =
wrote:
>
> In the PMTU test, when all previous tests are skipped and the new test
> passes, the exit code is set to 0. However, the current check mistakenly
> treats this as an assignment, causing the check to pass every time.
>
> Consequently, regardless of how many tests have failed, if the latest tes=
t
> passes, the PMTU test will report a pass.
>
> Fixes: 2a9d3716b810 ("selftests: pmtu.sh: improve the test result process=
ing")
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  tools/testing/selftests/net/pmtu.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/net/pmtu.sh b/tools/testing/selftest=
s/net/pmtu.sh
> index f838dd370f6a..b9648da4c371 100755
> --- a/tools/testing/selftests/net/pmtu.sh
> +++ b/tools/testing/selftests/net/pmtu.sh
> @@ -2048,7 +2048,7 @@ run_test() {
>         case $ret in
>                 0)
>                         all_skipped=3Dfalse
> -                       [ $exitcode=3D$ksft_skip ] && exitcode=3D0
> +                       [ $exitcode =3D $ksft_skip ] && exitcode=3D0
Perhaps replacing "=3D" with -eq here will be less error-prone?
Thanks for catching this!

>                 ;;
>                 $ksft_skip)
>                         [ $all_skipped =3D true ] && exitcode=3D$ksft_ski=
p
> --
> 2.41.0
>

