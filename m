Return-Path: <netdev+bounces-46346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5F77E343E
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 04:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86F1C280E18
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 03:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371EC6126;
	Tue,  7 Nov 2023 03:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3eSobFRE"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6432D53A8
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 03:40:25 +0000 (UTC)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBCFAD57
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 19:40:23 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-53eeb28e8e5so4192a12.1
        for <netdev@vger.kernel.org>; Mon, 06 Nov 2023 19:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699328422; x=1699933222; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lYCIndK7nTAWFMNojgp2tg2y2sSFZQckk0xx9RL2AOM=;
        b=3eSobFRETsHq9uZVd6u88PAq0GAttSvgXUyXYT88R564pFZos4u0wA7nIoPrZDVHFg
         6354A+u9njIrNIcTTtaSrOed98C4FiP1PYva+KMVHqkogAK0g/e/RQ8GjmOf88YZkQAI
         i9WUNytpAFlBFOCmHPIH84YkPfY/G7mgWue68mkaDi3JrV2IG1BrZgH9+uXiE1kw5nPw
         JcAxL7TcQy9xIJhJfV38wtQrMfs47xy5fzA+j/MDjaNJykuxQWfxw/8Wme4nQGWhqESt
         kpuNFRhMtMe51nqmrPUI9aQUfWBr6XePmwTLHr5NxNNyVu64LVXZT8YWLrnrRt2Uf1oF
         AWYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699328422; x=1699933222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lYCIndK7nTAWFMNojgp2tg2y2sSFZQckk0xx9RL2AOM=;
        b=tx05Hw9TYn5fdbBXhJOsbnG3TA66PmK9iSoo+kpFUKAG4446AHAQEDb5d4RwBz4udx
         Y3owaX7YFeJlc/WSa4z79k5WF0OveEQXh9n8By7QoMj99AjmpcWDpQUkVo7psfzg0Q/g
         JIhEPfbGl7lHHMDbstus0QCCdkGMXp2noKwuhJVNq27JovNS7nLMmMLcCKcKyRWSuYlh
         fIgpEHwQBwiVg6RMnhqlqdXPNni/g877M+GEwkmuw0MDFviViTfpjvXySRLxDOO+o+xk
         IhraYYp6lenjOX7DfBDHGS3rgNlnfinX43O3EX1fBvskyZt0BaqOmHsm1yKamrvkvf1h
         DwlA==
X-Gm-Message-State: AOJu0Yw3neyR+8ZzG4OhLfv3J3mPMfmcfFy09HfCs7DY+FcbZJyM4nSl
	WemNVMl5M9Mtg6gvaaYaEKIY6KVT7t7FeKtdAnwc7A==
X-Google-Smtp-Source: AGHT+IH0QiR6VsLI/3UP+6avx6qTbRgvfRUAwcSMLx2Ci0aCQ9197Fet5uwI9pffHELnV68wOz0D3/HXDmK/AGmf4BM=
X-Received: by 2002:a50:9eeb:0:b0:544:4762:608 with SMTP id
 a98-20020a509eeb000000b0054447620608mr76680edf.2.1699328421980; Mon, 06 Nov
 2023 19:40:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231107023444.3141-1-duminjie@vivo.com>
In-Reply-To: <20231107023444.3141-1-duminjie@vivo.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 7 Nov 2023 04:40:08 +0100
Message-ID: <CANn89iKGqObLBOx-ZMJbYOJ3OSETDestrcf6Yj5HON0Pbda9tA@mail.gmail.com>
Subject: Re: [PATCH v1] net/tcp: use kfree_sensitive() instend of kfree() in tcp_md5_twsk_free_rcu()
To: Minjie Du <duminjie@vivo.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"open list:NETWORKING [TCP]" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 7, 2023 at 3:35=E2=80=AFAM Minjie Du <duminjie@vivo.com> wrote:
>
> key might contain private information, so better use
> kfree_sensitive to free it.
> In tcp_md5_twsk_free_rcu() use kfree_sensitive().
>
> Signed-off-by: Minjie Du <duminjie@vivo.com>
> ---
>  net/ipv4/tcp_minisocks.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
> index a9807eeb311c..a7be78096783 100644
> --- a/net/ipv4/tcp_minisocks.c
> +++ b/net/ipv4/tcp_minisocks.c
> @@ -368,7 +368,7 @@ static void tcp_md5_twsk_free_rcu(struct rcu_head *he=
ad)
>         struct tcp_md5sig_key *key;
>
>         key =3D container_of(head, struct tcp_md5sig_key, rcu);
> -       kfree(key);
> +       kfree_sensitive(key);
>         static_branch_slow_dec_deferred(&tcp_md5_needed);
>         tcp_md5_release_sigpool();
>  }
> --
> 2.39.0
>



1) net-next is currently closed.

2) such patch could send a wrong signal (false sense of security with MD5)

3) You forgot tcp_time_wait_init(), tcp_md5_do_del(), tcp_md5_key_copy(),
    tcp_md5_do_add(), tcp_clear_md5_list().

More work is needed I am afraid, please wait until next week when
6-7-rc1 is tagged and net-next opens again.

