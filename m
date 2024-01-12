Return-Path: <netdev+bounces-63372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A3E82C82C
	for <lists+netdev@lfdr.de>; Sat, 13 Jan 2024 00:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2ACE61F225C0
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 23:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086471A5B9;
	Fri, 12 Jan 2024 23:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="SWNjFXaW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A7F1A5B5
	for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 23:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d50d0c98c3so50483915ad.1
        for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 15:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1705103986; x=1705708786; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5TRaqxeQ1knfJ48NiTaHAP/znF2dJmrqJVcUw5XhGAU=;
        b=SWNjFXaWQIiJ0tHuefD4vTncgpA410G/ofcFDfcHvqxUMGZWLkmRsPzxJyFNWIE4lL
         NEoU9WSmqcI24PXSdIMX7rImKlB9518BUu4AiGKu0ZpViIFRcYuXA7JG4+8b6ccDqP/T
         e3Rhbh7vCQw5YhOa7HEB9xuC9X/a/4//UBjpW/O40uKfsLa6JBor725QHlaBxVULEKcS
         9CZWuagupeqws+bWeU9xNYpUAAcpwKgrW5OwcJLQR6g4mjxkNsPcJ4pu2swqyD75pEOn
         urPIW3ryPjxgiwq6Ta30U0i4AJ4rZRxdu47erCovIxi2ovZkl5+JuKRyQLlQF5CWvD5b
         F0sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705103986; x=1705708786;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5TRaqxeQ1knfJ48NiTaHAP/znF2dJmrqJVcUw5XhGAU=;
        b=e0RlZsvLC5MzLaeSh+c09WDkY5oKhUjM+i2uHiQilcvKhP3cnjP7doeGLOWOeKesKX
         sS16yY14hUgn/XolFmgi3lRZO/HbIEj0e07X+pMmeti/GpcoNyuXV9F2Wi8zohyU7ZTh
         zEzLynkYBqWc2pHHYhx/IfpjoWYfK2uF9qLjkRRCyQ5ZJn73G8lkYl7SrvEfw6FShQlo
         rxI2JSFSPRKSWlWtQ/ibmiHtusN/matdsaph+2fkwrC0jC8gm+UnpKT6dE9N1E8xtG8+
         3MYYhjrEcx6yqvbYlxrQlDvswrROinfM4+tGMIuAA0A0uRa5qwm5cS9O+87COuwsLgm5
         zq8A==
X-Gm-Message-State: AOJu0YzneJ/M4Z2viafntlmr0qvDgwaTCCWJadiKGd9xgtRgmaU1GsIY
	WT/4fK6E1kRG07BLcFwOrPjtwMRKjER0ag==
X-Google-Smtp-Source: AGHT+IHew3qS2+FJv17RtU3KpQXgd7uTCoFOR2/OUak+sLzgJnxpxkbLd28CrNOnlEwKgIxwnk+ulA==
X-Received: by 2002:a17:903:1104:b0:1d5:63c5:e107 with SMTP id n4-20020a170903110400b001d563c5e107mr2736857plh.3.1705103985882;
        Fri, 12 Jan 2024 15:59:45 -0800 (PST)
Received: from ?IPv6:2601:647:4900:1fbb:1985:323f:332f:3b61? ([2601:647:4900:1fbb:1985:323f:332f:3b61])
        by smtp.gmail.com with ESMTPSA id b14-20020a6567ce000000b005ce979b861dsm3271908pgs.84.2024.01.12.15.59.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Jan 2024 15:59:45 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.7\))
Subject: Re: [PATCH v3 bpf 1/3] bpf: iter_udp: Retry with a larger batch size
 without going back to the previous bucket
From: Aditi Ghag <aditi.ghag@isovalent.com>
In-Reply-To: <20240112190530.3751661-2-martin.lau@linux.dev>
Date: Fri, 12 Jan 2024 15:59:44 -0800
Cc: bpf@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 netdev@vger.kernel.org,
 kernel-team@meta.com,
 Yonghong Song <yonghong.song@linux.dev>
Content-Transfer-Encoding: quoted-printable
Message-Id: <48FE07AD-06AA-4D01-88D8-FAE628AF281B@isovalent.com>
References: <20240112190530.3751661-1-martin.lau@linux.dev>
 <20240112190530.3751661-2-martin.lau@linux.dev>
To: Martin KaFai Lau <martin.lau@linux.dev>
X-Mailer: Apple Mail (2.3608.120.23.2.7)



> On Jan 12, 2024, at 11:05 AM, Martin KaFai Lau <martin.lau@linux.dev> =
wrote:
>=20
> From: Martin KaFai Lau <martin.lau@kernel.org>
>=20
> The current logic is to use a default size 16 to batch the whole =
bucket.
> If it is too small, it will retry with a larger batch size.
>=20
> The current code accidentally does a state->bucket-- before retrying.
> This goes back to retry with the previous bucket which has already
> been done. This patch fixed it.
>=20
> It is hard to create a selftest. I added a WARN_ON(state->bucket < 0),
> forced a particular port to be hashed to the first bucket,
> created >16 sockets, and observed the for-loop went back
> to the "-1" bucket.
>=20
> Cc: Aditi Ghag <aditi.ghag@isovalent.com>
> Fixes: c96dac8d369f ("bpf: udp: Implement batching for sockets =
iterator")
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>

Reviewed-by: Aditi Ghag <aditi.ghag@isovalent.com>
LGTM!

> ---
> net/ipv4/udp.c | 1 -
> 1 file changed, 1 deletion(-)
>=20
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index 89e5a806b82e..978b83d3c094 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -3213,7 +3213,6 @@ static struct sock *bpf_iter_udp_batch(struct =
seq_file *seq)
> 		/* After allocating a larger batch, retry one more time =
to grab
> 		 * the whole bucket.
> 		 */
> -		state->bucket--;
> 		goto again;
> 	}
> done:
> --=20
> 2.34.1
>=20


