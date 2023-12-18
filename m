Return-Path: <netdev+bounces-58534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF20816CFA
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 12:53:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33604B24057
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 11:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6BA20DD4;
	Mon, 18 Dec 2023 11:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K+feXAuH"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C887B4122B
	for <netdev@vger.kernel.org>; Mon, 18 Dec 2023 11:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702899642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zDjgbF9OjLRhltzpu3hy0SxWUcdMTSMBcWAO5Y5sfDM=;
	b=K+feXAuHbH/y/nZA4NhYNGXxRDVaUbBa0nFJC7Y13BdE027ER85cawIy0OaO7yvUK04/RY
	RZWl+TygKuZpKPKwuDvcvN7dB+/ZFwVArd7XlFBU0cvIhMfULQLqHwgeoyPa4YODnTvjy9
	yD0kfhkdLLcqWNc9Ld6xisiL+DntLAo=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-Fw0XbCttOpG0M_wq6Mwwsw-1; Mon, 18 Dec 2023 06:40:40 -0500
X-MC-Unique: Fw0XbCttOpG0M_wq6Mwwsw-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2c9fdb15388so20664911fa.2
        for <netdev@vger.kernel.org>; Mon, 18 Dec 2023 03:40:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702899639; x=1703504439;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zDjgbF9OjLRhltzpu3hy0SxWUcdMTSMBcWAO5Y5sfDM=;
        b=SXNO5CVdJEM1HdUi8c/Uc62TXd5dgZBCyDu55MO7sOJH7OrYD7emBrk17OFk7kocc5
         0cPkTv7cr5L96tMmLbwwxQsbaVplxS3EUBc5ZO/rM7T0yx7r1+er/Vu+p6RNYGlZsQyg
         iITNSE4E2kv43B/slY7bDfVRwU4iEB6mSoz3nEyH8719BTrD+USw3K7w4yzl0nVhLaiw
         kH3WNKWUwN3b3DBxWbgyAkDYTjlx6uf6RESVpx/J7O3fHQYUudQmBje6Oja26tVOZBES
         yjJp6Oo77pVWs4NrWA2unJ6WVryLRa0qeqGGC5XDlqcCesIXwZhXVn8XCCtr7xUiXI2Y
         f+xw==
X-Gm-Message-State: AOJu0Yy7SMAMCMWYJptipwPxiwk6Pv17Qa8g1EjzFhxn5yvfGM8IcuXj
	lt+pYSw5xUCMusMSFM+JBgpwobE3dwA6TaxFChCfsl19d4IbkwThTrmPwGG6YZK4+HI0kXBa77G
	PthJb1FfjgsJtFe1rLH1hpVF9G0dU1a3j
X-Received: by 2002:a2e:8611:0:b0:2cc:7104:2100 with SMTP id a17-20020a2e8611000000b002cc71042100mr629660lji.97.1702899639466;
        Mon, 18 Dec 2023 03:40:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGBGK3niuCU6Q1qTkpaY9j+eoHbVVt+OmMgZ4Gxa5TMtB6I/6w061Lu2ry0EEJrCma/bWoK7fx772HVHm82XfE=
X-Received: by 2002:a2e:8611:0:b0:2cc:7104:2100 with SMTP id
 a17-20020a2e8611000000b002cc71042100mr629651lji.97.1702899639145; Mon, 18 Dec
 2023 03:40:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215035009.498049-1-liuhangbin@gmail.com> <20231215035009.498049-4-liuhangbin@gmail.com>
In-Reply-To: <20231215035009.498049-4-liuhangbin@gmail.com>
From: Davide Caratti <dcaratti@redhat.com>
Date: Mon, 18 Dec 2023 12:40:27 +0100
Message-ID: <CAKa-r6sFAqfPbwXh1mSrTBYpicbYBMTqR-48DDSrxkTZp4Rm_A@mail.gmail.com>
Subject: Re: [PATCH net-next 3/3] netlink: specs: use exact-len for IPv6 addr
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

hello Hangbin!

for the mptcp part: I didn't convert mptcp events, here transition
from min-len to exact-len should not generate issues at all.

Acked-by: Davide Caratti <dcaratti@redhat.com>

On Fri, Dec 15, 2023 at 4:50=E2=80=AFAM Hangbin Liu <liuhangbin@gmail.com> =
wrote:
>
> We should use the exact-len instead of min-len for IPv6 address.
>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  Documentation/netlink/specs/fou.yaml   | 4 ++--
>  Documentation/netlink/specs/mptcp.yaml | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/netlink/specs/fou.yaml b/Documentation/netlink=
/specs/fou.yaml
> index 0af5ab842c04..d472fd5055bd 100644
> --- a/Documentation/netlink/specs/fou.yaml
> +++ b/Documentation/netlink/specs/fou.yaml
> @@ -52,7 +52,7 @@ attribute-sets:
>          name: local_v6
>          type: binary
>          checks:
> -          min-len: 16
> +          exact-len: 16
>        -
>          name: peer_v4
>          type: u32
> @@ -60,7 +60,7 @@ attribute-sets:
>          name: peer_v6
>          type: binary
>          checks:
> -          min-len: 16
> +          exact-len: 16
>        -
>          name: peer_port
>          type: u16
> diff --git a/Documentation/netlink/specs/mptcp.yaml b/Documentation/netli=
nk/specs/mptcp.yaml
> index 49f90cfb4698..2f694b79c3a7 100644
> --- a/Documentation/netlink/specs/mptcp.yaml
> +++ b/Documentation/netlink/specs/mptcp.yaml
> @@ -223,7 +223,7 @@ attribute-sets:
>          name: saddr6
>          type: binary
>          checks:
> -          min-len: 16
> +          exact-len: 16
>        -
>          name: daddr4
>          type: u32
> @@ -232,7 +232,7 @@ attribute-sets:
>          name: daddr6
>          type: binary
>          checks:
> -          min-len: 16
> +          exact-len: 16
>        -
>          name: sport
>          type: u16
> --
> 2.43.0
>
>


