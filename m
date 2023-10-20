Return-Path: <netdev+bounces-42888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A93D7D0817
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 08:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEA3B1F22ABC
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 06:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A4EB67E;
	Fri, 20 Oct 2023 06:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P+Wmh5wB"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C923DB653
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 06:06:23 +0000 (UTC)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28695D46
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 23:06:22 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-53eeb28e8e5so5127a12.1
        for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 23:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697781980; x=1698386780; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u+KpcMmCI3VUCo8mmukDnMjRaKfX1uWu9XwF6P2O7gk=;
        b=P+Wmh5wBzqhDLj6VjehokqDW9U30UZs+ebQCvVKTTIUH3iHxu6I5EIGJ4yC/pGWYpR
         MahTzH2vvvcGYtfaE4+BmrWloHHkyp2l3ltS9zCV/nj0tyYWLnOzq1t0LRJlATVtzdkh
         CQzp6sqxg4qrUqqIqvmn283mrWtGBs8LSdi/7PH5vimW500v94mDGkG/zMeqEFifDW1B
         7e61yjxfStTch12sUJ96SO9qOX/+VRU3QfZ+GvbzKoC2BX4RmXaolOVtpiJZNoaP8zOd
         1ONNWKJOnjotfIXKx00hF8NKbwLSkriO59aETKNmjw+rgWxqv7pixeHX7F33u6d6tTdp
         E01Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697781980; x=1698386780;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u+KpcMmCI3VUCo8mmukDnMjRaKfX1uWu9XwF6P2O7gk=;
        b=Ra56RHjq1YeDPoBXinhtWDCqqWTYPK3OUKWJlMqsOpgXgpAhLHfYrNZxDyT1rQKKae
         5pRPTBpXFLAGu6LuGQRnUdbHAxIkJLhIkRtQru7n6tG0V4RPkRp+m7gr5L1TTUhbAvfh
         XxVIVYzgkg/rTa4qUnX7YFt8Ozgzo1lomiJP9+YcRbh4G4OuefNKPXmsczC4JepGZr4N
         E4Wioq2iV/ffGJsJit46M1cBA9AFwOUhyAzqA5COAzu2fiu4L5d2zN5xyD1SwzxEV5Vl
         QV3qn8Mlb1+G1HtBLkggMKyPV3VYOsqvVKR1u5pLH7PfcgmH1xUnl5x04SVuubbHK/xk
         LEQQ==
X-Gm-Message-State: AOJu0YyrBbIxS/qU4JlgyZ6Fpggi0d0c4EcpwEk/SdCMz9NsKnVEcKgf
	kHkrquMo5uGh0qkrFyVJ/EEyTCk6Bwd2ZEYKe+Slmw==
X-Google-Smtp-Source: AGHT+IFZb6yUqXDBArx7UAg+OPKTxM16DwwyHfneQxiggc0wpZ7pPj42La/dpln+7xV+yupI3oY6XHXehRMD2odEuSE=
X-Received: by 2002:a50:ccd5:0:b0:53f:3d3d:8b04 with SMTP id
 b21-20020a50ccd5000000b0053f3d3d8b04mr69176edj.2.1697781980284; Thu, 19 Oct
 2023 23:06:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1697779681.git.yan@cloudflare.com> <e721c615e22fc4d3d53bfa230d5d71462ae9c9a8.1697779681.git.yan@cloudflare.com>
In-Reply-To: <e721c615e22fc4d3d53bfa230d5d71462ae9c9a8.1697779681.git.yan@cloudflare.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 20 Oct 2023 08:06:05 +0200
Message-ID: <CANn89iKU6-htPJh3YwvDEDhnVtkXgPOE+2rvzWCbKCpU25kbDw@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 1/3] ipv6: remove dst_allfrag test on ipv6 output
To: Yan Zhai <yan@cloudflare.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Aya Levin <ayal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, linux-kernel@vger.kernel.org, 
	kernel-team@cloudflare.com, Florian Westphal <fw@strlen.de>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Alexander H Duyck <alexander.duyck@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 20, 2023 at 7:32=E2=80=AFAM Yan Zhai <yan@cloudflare.com> wrote=
:
>
> dst_allfrag was added before the first git commit:
>
> https://www.mail-archive.com/bk-commits-head@vger.kernel.org/msg03399.htm=
l
>
> The feature would send packets to the fragmentation path if a box
> receives a PMTU value with less than 1280 byte. However, since commit
> 9d289715eb5c ("ipv6: stop sending PTB packets for MTU < 1280"), such
> message would be simply discarded. The feature flag is neither supported
> in iproute2 utility. In theory one can still manipulate it with direct
> netlink message, but it is not ideal because it was based on obsoleted
> guidance of RFC-2460 (replaced by RFC-8200).
>
> The feature test would always return false at the moment, so remove it
> from the output path.

What about other callers of dst_allfrag() ?

This feature seems broken atm.

