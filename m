Return-Path: <netdev+bounces-49945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A207F405F
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 09:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CDA4B20E86
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 08:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080AD1A281;
	Wed, 22 Nov 2023 08:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rFDbNr/L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8A72191
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 00:40:50 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40837124e1cso56215e9.0
        for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 00:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700642449; x=1701247249; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HvAKCzYbJd8zEfzo2liGumVkGF3mJ1Z53uQtfe5NFTQ=;
        b=rFDbNr/LkwSnmhNsREAaiIL1HXvPew4nAYeZPlGbJ0FZ8lRzxbHeJZL5fs60tfZ+AC
         OGtWeaM0RuHctoKuASTheFEEirmAnUQigvrSBnB930ZK9E4ir2oG0vjupAyrxM0oPzUL
         ox/p1qwysdjlYetrImveATdMnKkEnebnBnFyGJ252B0dKsiAMp3o36f0nSPhEL5O5+un
         lLTnaFiqyfgNf7yT1txYNiQQLLTBSjmfuRZwaw9Ryiy4iCvI3w3oRKQns64MYHmEDPG2
         Pg5DqT4DJ/obKcd8sY86+MGeyv1UstidZbpeP8b+ty9r+hPtzBJpXwHA8c0N+yJZ3WPU
         DvbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700642449; x=1701247249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HvAKCzYbJd8zEfzo2liGumVkGF3mJ1Z53uQtfe5NFTQ=;
        b=oS4WojpoVXNcUQFzLxrnNIs9cE0qLlPSxZFthNmWoYldbmnS5vJXZN9OPbQERKJl8H
         LppB0tivR7eG5n0zCShMxTsU3xy3/8jGfy60D3OwoXf00M3rPkK63jwhMSCn5gDVbYaZ
         5webhFqzAwcFnR472qE3mkqWZTbRFLFnpY00EJzZYsSuu6HGzVGvvrhbhlS8gi9fBTVG
         2tCKkZea7ddIPMtwLQiaIC0MCHxP7NLvGa/IOzRFOj7pRGezyVrkEygh5kl6Sypy1YCz
         mVN2QHlJCw8qYHa6sGOHy6WIk6sSUixCFtg9LGFQ5gNcW7LJ1isz4jeahw865Q7GUWm7
         V+Ww==
X-Gm-Message-State: AOJu0YylJRlZKHc21z6cXXrN1L9NS7chVzP75DXaRd7nBN75H4QndDwW
	aCOUWNwsePzA7rjDky3gXsUrNywV2TVLtzRHhjTeHA==
X-Google-Smtp-Source: AGHT+IFylC7PH+0XjDnDWSsRqOQpoYYF4tSyxE8m/gaTAROR27Ow34de/Kx32ylXQvErAVd44trdl2XlnkTtb+TFHLg=
X-Received: by 2002:a05:600c:5112:b0:40b:2979:9cc2 with SMTP id
 o18-20020a05600c511200b0040b29799cc2mr63523wms.1.1700642449082; Wed, 22 Nov
 2023 00:40:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231122034420.1158898-1-kuba@kernel.org> <20231122034420.1158898-3-kuba@kernel.org>
In-Reply-To: <20231122034420.1158898-3-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 22 Nov 2023 09:40:38 +0100
Message-ID: <CANn89i+WPnBji73ADxMVc_7=ugBSTg_TnbuO8RwbEMjBTnO-Xg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 02/13] net: page_pool: id the page pools
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, 
	almasrymina@google.com, hawk@kernel.org, ilias.apalodimas@linaro.org, 
	dsahern@gmail.com, dtatulea@nvidia.com, willemb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 4:44=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> To give ourselves the flexibility of creating netlink commands
> and ability to refer to page pool instances in uAPIs create
> IDs for page pools.
>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

