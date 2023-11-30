Return-Path: <netdev+bounces-52469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A487FED53
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 11:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4BF91C20C32
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 10:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6DF03B188;
	Thu, 30 Nov 2023 10:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pxRFR8D5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2000ED40
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 02:52:50 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40b35199f94so59835e9.0
        for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 02:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701341568; x=1701946368; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lFRvQID9Nakr5h2sIUXDbvuzfHavELxBnEfDTNVKgao=;
        b=pxRFR8D53zOc+aqMXu6SnOzOUWV7tWFwIzG13wCWmO3vcroTSh+sXRH6SHkkTRzElV
         8vPruutU5a79/RgpWAOoEPs502kdZt4RECFKMdBja0lcp2cgtXQ4zoIuKwjEA2zcibrk
         nAVimauO6QmZqFTIBk2AsacTdWw8cpAO3hewIxECqZ5UmXTBd4yn1ZO9pF2yBLqf4DP1
         ll9zuegsbBxHlUNrRke6a5W9rO5XxUoPjKsR0FmHS7XlSCJpw54vYuqZeL9niWHOlgzw
         f4vJlKgjX8tuPxARV5Fg5HwpDCvpvA05iF/Sx2UmEIFqi2DzaloG6PZDBqGyAR68QBTk
         OoLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701341568; x=1701946368;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lFRvQID9Nakr5h2sIUXDbvuzfHavELxBnEfDTNVKgao=;
        b=M68y7g8R9eD+MWJZvJeBXozUAwuKnicn/TfIIr0KmRG601C2QJDKjuhC413zQXZv6q
         ThspNs2Zdoa44Da/RD7jeWrus18Ul5Mc89ENprcp6uOTmNZOv5U1xdKpqqSWYTg75j61
         tSYRYS8kB9msT9Dwiugs95pQBt40SmNONg2w4cK3DNrycWBa9713YT+xfVHM5ISpahhX
         O/+G3pVc5RdJkgphKN8PeITTMQo8P5NP8a0ZBudVQ4O8BphkQkgwkr4OcduJW0NB+msT
         R2j0MSgx0PsmqR45m8MjIA5l5xzhlqUiN1A2C8BXNXsoTXQXmtxaCziUeT2/HZ/NvnkM
         gdkA==
X-Gm-Message-State: AOJu0YyCdye+/E9CW7OtsEYKLRgQsoesf21+6PFMs7IK8grejO2ylnFj
	I2jNF0zlTY+d27YxGPLcMEbsx0AwK/MAst2I5l9Msw==
X-Google-Smtp-Source: AGHT+IEfC1MkN5QvngjEF4tXN+4LeEL7obuubki2rRVhuEMlKZRj8Mu8GgRWrTI9qkpZl9IgUo24XeQAradxytb4g5U=
X-Received: by 2002:a05:600c:1c04:b0:40b:43f4:df9e with SMTP id
 j4-20020a05600c1c0400b0040b43f4df9emr132650wms.2.1701341568282; Thu, 30 Nov
 2023 02:52:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231129072756.3684495-1-lixiaoyan@google.com> <20231129072756.3684495-6-lixiaoyan@google.com>
In-Reply-To: <20231129072756.3684495-6-lixiaoyan@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 30 Nov 2023 11:52:37 +0100
Message-ID: <CANn89i+7pwcbcwgagMfXYJn0isO1S8c=quddAbGHodio_z_xGw@mail.gmail.com>
Subject: Re: [PATCH v8 net-next 5/5] tcp: reorganize tcp_sock fast path variables
To: Coco Li <lixiaoyan@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Mubashir Adnan Qureshi <mubashirq@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, 
	Jonathan Corbet <corbet@lwn.net>, David Ahern <dsahern@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, Chao Wu <wwchao@google.com>, 
	Wei Wang <weiwan@google.com>, Pradeep Nemavat <pnemavat@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 8:28=E2=80=AFAM Coco Li <lixiaoyan@google.com> wrot=
e:
>
> The variables are organized according in the following way:
>
> - TX read-mostly hotpath cache lines
> - TXRX read-mostly hotpath cache lines
> - RX read-mostly hotpath cache lines
> - TX read-write hotpath cache line
> - TXRX read-write hotpath cache line
> - RX read-write hotpath cache line
>
> Fastpath cachelines end after rcvq_space.
>
> Cache line boundaries are enforced only between read-mostly and
> read-write. That is, if read-mostly tx cachelines bleed into
> read-mostly txrx cachelines, we do not care. We care about the
> boundaries between read and write cachelines because we want
> to prevent false sharing.
>
> Fast path variables span cache lines before change: 12
> Fast path variables span cache lines after change: 8
>
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Reviewed-by: Wei Wang <weiwan@google.com>
> Reviewed-by: David Ahern <dsahern@kernel.org>
> Signed-off-by: Coco Li <lixiaoyan@google.com>


Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks !

