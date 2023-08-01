Return-Path: <netdev+bounces-23113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C2376AE51
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 11:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 078A81C20E8F
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 09:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C1F1F959;
	Tue,  1 Aug 2023 09:37:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A27200A6
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 09:37:49 +0000 (UTC)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC4A1BC1
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 02:37:41 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fe1e44fd2bso65225e9.0
        for <netdev@vger.kernel.org>; Tue, 01 Aug 2023 02:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690882659; x=1691487459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3M62lzMT5M72GxSXvEGzGefCfJz1y5FFBC42WxQiRug=;
        b=Vb8cFPoJb2P0ZwPLqiNLSgQaAng02a45/GY4JR1Pxif45PUI+o75l36LyoVfmsACr7
         Ka2pa1g2ANFFVJ1g1nbyNcVuo1VXmwhCrC5n9y7/PpD10hn/VwNgY4/Bta3E+ioc8sUD
         rb/O6ElNeClwTaU6dhtthc29U+Y+xlZbokIoeoOhNiQ16FJ/QgUuIqGmqAJEvxXfD8Go
         lW9x26DElmw/Yu1UJWK3yjYPczwlvFH0LxvpvlnYkBRtRy0/pe4Y41uDlnhU67dyPI7C
         HVZFDlduORA2AAJevm8Vb+nhwFP0kMfG8X+BfVjJzFDGJa4a3oeYvHZjOhwX385/Hasx
         Jggw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690882659; x=1691487459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3M62lzMT5M72GxSXvEGzGefCfJz1y5FFBC42WxQiRug=;
        b=gXM89PbO3KzEuLvjCeoMCHs1xmVQa9Wy4X827u7pym6l+L937G0+Wm0pltH4WSiyyz
         Ej5rssK50prxjMtRN+A+Q9RjW85xYC3TFhU2hwUnSDQPEEJpfVWsr8I5H2tH/hcjvFwb
         t7BQv5HRY7YqDu//EA9mJE7733MxEFWIQjwLFs7w6ycNhTM3xYqg4lNqyi8Jfl7pib7J
         tLg+opi/ad/Xa40nYcOihyK02AY3UiWM1jjwWQImLWtjj0Zv3yqp941MmRAm6HDtF6ZQ
         NpARHQrgO4fZuZ/dVD6a2GdlDcP2cebBwBicxw4L7uhUhQkdVzdWAX/ekWdd9q28ND4t
         xfQw==
X-Gm-Message-State: ABy/qLakrb4Sat1zyeuLsPucHOxgQSqNlIeicamfwPtGU0i2BEtmpqLx
	DS1hkkMZMgLcLQxG+ZXwMgVpA7pQsVka9VB6ujYG3g==
X-Google-Smtp-Source: APBJJlH4ZnN9CuymbZd5SjWQ7VukNUlycKzANvGo/BKrgrjAwCHW6tOHt810QbdF94ncNyVp96NaRDmZnIwYqTfw9Ng=
X-Received: by 2002:a05:600c:1c90:b0:3f1:6fe9:4a95 with SMTP id
 k16-20020a05600c1c9000b003f16fe94a95mr239758wms.4.1690882659519; Tue, 01 Aug
 2023 02:37:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230731230736.109216-1-trdgn@amazon.com>
In-Reply-To: <20230731230736.109216-1-trdgn@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 1 Aug 2023 11:37:27 +0200
Message-ID: <CANn89iLV0iEeQy19wn+Vfmhpgr6srVpf3L+oBvuDyLRQXfoMug@mail.gmail.com>
Subject: Re: [PATCH v2] tun: avoid high-order page allocation for packet header
To: Tahsin Erdogan <trdgn@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 1, 2023 at 1:07=E2=80=AFAM Tahsin Erdogan <trdgn@amazon.com> wr=
ote:
>
> When GSO is not enabled and a packet is transmitted via writev(), all
> payload is treated as header which requires a contiguous memory allocatio=
n.
> This allocation request is harder to satisfy, and may even fail if there =
is
> enough fragmentation.
>
> Note that sendmsg() code path limits the linear copy length, so this chan=
ge
> makes writev() and sendmsg() more consistent.
>
> Signed-off-by: Tahsin Erdogan <trdgn@amazon.com>
> ---

I will have to tweak one existing packetdrill test, nothing major.

Tested-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks.

