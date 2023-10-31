Return-Path: <netdev+bounces-45373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B687DC57F
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 05:42:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D75BA1C20B13
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 04:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1AC6AB5;
	Tue, 31 Oct 2023 04:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="u+ZV+oLS"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51E753A9
	for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 04:42:00 +0000 (UTC)
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0565121
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 21:41:58 -0700 (PDT)
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com [209.85.160.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id EFFCD3F213
	for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 04:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1698727315;
	bh=uv/lM9witRa5tHyiuyBCkKsQR6Hn/YYuwsXCZMESZLo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=u+ZV+oLSGJfulZo5rqIQNu1X43MqdNZgDLFivGItYEA/sp1/xwOmMTUuLfCIno1U3
	 7loG0YazLLp4/5WhOf+JGYHNMMrmNnAs5lhtFH4OuKxT/00/ftIVhjnwR+xbNjZF7T
	 O03vowO8gCAmEiz65T+Dm1RyzCT/qvaGdKgoO1sUT+ylgjvfV3a0MDa21E5l4dtMbw
	 UdcPadp4nQju9M7KKloX1y9LIGziPu6V0EWQs7MuH5v4MIFBeJRR64TamuwCFrtOp4
	 KAvnPEo1xYQaRTHTb2VBfs+ynPpW+c6oiUIyzOHmLpriweBwaq6tcz6pl+2+u6z+w/
	 tLLyV9+RkQG/w==
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-1e990f0629cso8230414fac.2
        for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 21:41:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698727313; x=1699332113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uv/lM9witRa5tHyiuyBCkKsQR6Hn/YYuwsXCZMESZLo=;
        b=mUj/TL/ft7p680fKCfWujDXeieCRLvA5fSEcS4U8kN3nSCWsZzw8zBxo8z5v4SfPkn
         gRamt5UvlQW2I+thy1tmPzcGwkqGcbyPuA3T6mK7ktvgcGflTWAhhMKUyIvQLxTLTfD4
         rUyAoEhR9MEguNvD0TrNJLQKR3x1KgZ7NFJsKnG3elugm5a6zTAH2g/c7kCJaYnTXWjo
         oxy19bgYfEyLRw90bklzvOSWo3XxY5aa7darkh/iezv/hUip8/LXmCZrr25FYHc6FYQ4
         WVXA+rqA2avZKZcI0NYUMmhTyUYg075kT6rNAhD4ut9Wo3t8UQC0L5K/swQPdkasd9T7
         nukQ==
X-Gm-Message-State: AOJu0YxM+mJHro3JwaEv0KNgbqRh/e4+SGb1qusAQj+Sqkd+t3XxNr46
	NcBWgrzXM26rTwYzb7nnnL0sbBpxrh/8h4zAe1lSuKbKElBDv9n4zdnCZYU7fYTzJxHZxhpdnN5
	xjKo3Fyhroh/Y9pIi2kO8kIi+UTOGTYQzujqwR0Et+mG6uWAv
X-Received: by 2002:a05:6871:4309:b0:1e9:9537:c1a9 with SMTP id lu9-20020a056871430900b001e99537c1a9mr16749918oab.12.1698727313737;
        Mon, 30 Oct 2023 21:41:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbJSmYuKlbce0BSqZJOFxdZgSWDwei5lHL5IXFbYRxVoZerDOoqfteskWEqOA52Yc62D7dONA8v+uHeqbbqMs=
X-Received: by 2002:a05:6871:4309:b0:1e9:9537:c1a9 with SMTP id
 lu9-20020a056871430900b001e99537c1a9mr16749907oab.12.1698727313457; Mon, 30
 Oct 2023 21:41:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231031034732.3531008-1-liuhangbin@gmail.com>
In-Reply-To: <20231031034732.3531008-1-liuhangbin@gmail.com>
From: Po-Hsu Lin <po-hsu.lin@canonical.com>
Date: Tue, 31 Oct 2023 12:41:42 +0800
Message-ID: <CAMy_GT-kMCE1pbkSxg+O2Ev8h49KWneX6xDy4KHn30njHxK=OQ@mail.gmail.com>
Subject: Re: [PATCHv2 net] selftests: pmtu.sh: fix result checking
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, David Ahern <dsahern@kernel.org>, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 31, 2023 at 11:47=E2=80=AFAM Hangbin Liu <liuhangbin@gmail.com>=
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
> v2: use "-eq" instead of "=3D" to make less error-prone
> ---
>  tools/testing/selftests/net/pmtu.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/net/pmtu.sh b/tools/testing/selftest=
s/net/pmtu.sh
> index f838dd370f6a..b3b2dc5a630c 100755
> --- a/tools/testing/selftests/net/pmtu.sh
> +++ b/tools/testing/selftests/net/pmtu.sh
> @@ -2048,7 +2048,7 @@ run_test() {
>         case $ret in
>                 0)
>                         all_skipped=3Dfalse
> -                       [ $exitcode=3D$ksft_skip ] && exitcode=3D0
> +                       [ $exitcode -eq $ksft_skip ] && exitcode=3D0
>                 ;;
>                 $ksft_skip)
>                         [ $all_skipped =3D true ] && exitcode=3D$ksft_ski=
p
> --
> 2.41.0
>
Acked-by: Po-Hsu Lin <po-hsu.lin@canonical.com>

Looking good to me, thanks!

