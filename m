Return-Path: <netdev+bounces-45387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD57A7DC944
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 10:18:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4629BB20C87
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 09:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B6313AD6;
	Tue, 31 Oct 2023 09:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VtXOzRYj"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5ED812B99
	for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 09:18:39 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE0AC1
	for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 02:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698743913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bx3whZQGfbNRV1288q3CSKQ568eW0DOq5hrYpiuzhzo=;
	b=VtXOzRYj4y+Np4wokbPt565MpW3KA0Ix7KXL3axNbO/DWua5fOTK7uRovOi9s//djEow1l
	aZ1bbr407KUmaJoZ76N+dGdbomEhXeaMtHo34Fa+rcW+lc3wrRD/HhZ8CZXHL/BjBqKXf0
	RWRLntdQU6fwLZ3DXY+ahtjQuOpw9RA=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-RXJT0KTINUmkyd9cS4DydA-1; Tue, 31 Oct 2023 05:18:31 -0400
X-MC-Unique: RXJT0KTINUmkyd9cS4DydA-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-50798dd775dso1378307e87.1
        for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 02:18:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698743910; x=1699348710;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bx3whZQGfbNRV1288q3CSKQ568eW0DOq5hrYpiuzhzo=;
        b=MMq91BaQSNpLulCjeGVcg6yG9VHS0L9WgiQRVMdgBlVVi6dhRQx3C1S0Hj2V5LNF80
         CGWRRe8Gm1tffW9svF14TAdNxB+xjUjrTmg13f4cjXKT7StbkLDgNVosGGneS9YiRgTL
         sACJ8nL7k0JMP8CB5nlut6uK5pOM39lq3xcZkXLe9yGQeAgCUlUbDFF36hG600+cZaJL
         3nvEFEAKeOy8PkceUAFR/peGkMFFnwmQ08g6SdAnyODrSYjLuNl5jAkMvFWuYPssOYjl
         XsImesUcDoLSzUI9QL738Ie0DO4/xYp04Uv857UYDx3D5CfmORhn/ETByzMrP7aVSSXy
         O+gw==
X-Gm-Message-State: AOJu0YwmD9vFPOoY+nV8RG45ZkBawB49C5qdaQI03KbvgElXrQFZe94m
	4S69qezQKAquiwPA1Uay791l1M1prWdnodDflkQY6RP2s3DJhgjpHGF0u6F40RAss+Kckw9h7SZ
	Nczm8WdFrf66OllK6
X-Received: by 2002:a05:6512:2348:b0:507:b1b8:cf0a with SMTP id p8-20020a056512234800b00507b1b8cf0amr9918142lfu.3.1698743910432;
        Tue, 31 Oct 2023 02:18:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHO5YLpjsXMB2fxpnL44Wu1EYPRjkWRAyiAWVaBJOAR4pKlok5TbBpG/GFH/KhWPx8rjL/B3w==
X-Received: by 2002:a05:6512:2348:b0:507:b1b8:cf0a with SMTP id p8-20020a056512234800b00507b1b8cf0amr9918124lfu.3.1698743910073;
        Tue, 31 Oct 2023 02:18:30 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-227-179.dyn.eolo.it. [146.241.227.179])
        by smtp.gmail.com with ESMTPSA id q2-20020a05600c2e4200b004064e3b94afsm1160179wmf.4.2023.10.31.02.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 02:18:29 -0700 (PDT)
Message-ID: <e8a55d0518da5c1f9aba739359150cad58c03b2b.camel@redhat.com>
Subject: Re: [PATCH v2] selftests/net: synchronize udpgso_bench rx and tx
From: Paolo Abeni <pabeni@redhat.com>
To: Lucas Karpinski <lkarpins@redhat.com>, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, shuah@kernel.org
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Tue, 31 Oct 2023 10:18:28 +0100
In-Reply-To: <6ceki76bcv7qz6de5rxc26ot6aezdmeoz2g4ubtve7qwozmyyw@zibbg64wsdjp>
References: 
	<6ceki76bcv7qz6de5rxc26ot6aezdmeoz2g4ubtve7qwozmyyw@zibbg64wsdjp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2023-10-30 at 13:40 -0400, Lucas Karpinski wrote:
> The sockets used by udpgso_bench_tx aren't always ready when
> udpgso_bench_tx transmits packets. This issue is more prevalent in -rt
> kernels, but can occur in both. Replace the hacky sleep calls with a
> function that checks whether the ports in the namespace are ready for
> use.
>=20
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Lucas Karpinski <lkarpins@redhat.com>
> ---
> https://lore.kernel.org/all/t7v6mmuobrbucyfpwqbcujtvpa3wxnsrc36cz5rr6kzzr=
zkwtj@toz6mr4ggnyp/
>=20
> Changelog v2:=20
> - applied synchronization method suggested by Pablo
> - changed commit message to code=20
>=20
>  tools/testing/selftests/net/udpgro.sh         | 27 ++++++++++++++-----
>  tools/testing/selftests/net/udpgro_bench.sh   | 19 +++++++++++--
>  tools/testing/selftests/net/udpgro_frglist.sh | 19 +++++++++++--
>  3 files changed, 54 insertions(+), 11 deletions(-)
>=20
> diff --git a/tools/testing/selftests/net/udpgro.sh b/tools/testing/selfte=
sts/net/udpgro.sh
> index 0c743752669a..04792a315729 100755
> --- a/tools/testing/selftests/net/udpgro.sh
> +++ b/tools/testing/selftests/net/udpgro.sh
> @@ -24,6 +24,22 @@ cleanup() {
>  }
>  trap cleanup EXIT
> =20
> +wait_local_port_listen()
> +{
> +	local port=3D"${1}"
> +
> +	local port_hex
> +	port_hex=3D"$(printf "%04X" "${port}")"
> +
> +	local i

Minor nit: I think the code would be more readable, if you will group
the variable together:

	local port=3D"${1}"
	local port_hex
	local i

	port_hex=3D"$(printf "%04X" "${port}")"
	# ...

> +	for i in $(seq 10); do
> +		ip netns exec "${PEER_NS}" cat /proc/net/udp* | \
> +			awk "BEGIN {rc=3D1} {if (\$2 ~ /:${port_hex}\$/) {rc=3D0; exit}} END =
{exit rc}" &&
> +			break
> +		sleep 0.1
> +	done
> +}

Since you wrote the same function verbatim in 3 different files, I
think it would be better place it in separate, new, net_helper.sh file
and include such file from the various callers. Possibly additionally
rename the function as wait_local_udp_port_listen.

Thanks!

Paolo


