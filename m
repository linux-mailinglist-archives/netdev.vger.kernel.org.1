Return-Path: <netdev+bounces-45257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 140D87DBBD2
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 15:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D046B20C90
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 14:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B7B1774F;
	Mon, 30 Oct 2023 14:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q66Nu931"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195DDCA68
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 14:29:43 +0000 (UTC)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC779F
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 07:29:41 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-d9ac3b4f42cso4936435276.0
        for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 07:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698676180; x=1699280980; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g7wCCUpKRrJS75YLiT/U9xTHRv00wzxQlN/INc0kfAw=;
        b=q66Nu931ktcoJb0N2QYBo9Ao0W67q7tEqUw6LQbwsHZOZz+twX1F++Ae51QCDZ2bgk
         3EEKXlpj0hJoD737EFr5AiNXfd7m7UE9Bax3+1kODV3YLLzV0/3EgaPA8wPmaQigSXdD
         mLuZd290mW9I/NG3vLUKAJKE+eAoh6PNLyToyFoBY9iRtMHXbWJ0YXRWts0vQtKrEwS/
         7AIUywYr/JMDY6mSa/AVkwZyD4srqHei4grCWk2hSlu+d9CAG7x7xmPiPG0yX6pJ4uTD
         cQz3EyQEAWO9djWz67XSJNqMj4symljq+HCrvJrUCQmNw1bbWIY9bn9GWmhdvjq1+GMz
         dTyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698676180; x=1699280980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g7wCCUpKRrJS75YLiT/U9xTHRv00wzxQlN/INc0kfAw=;
        b=IeOpaXWpD+s+us+/VRi2su6pkfN0DA1kYhVVPAUjYwMDNTpDcszZZJ1KD8QgTV7bI5
         Sv3yh//G2UAxE177cznYPfrxz6hVb7uBJevmzRpTldAKsWKrg0nA/WoQHmkRpg8b6ffB
         H4ZXYscwl6a9ueyRAb58dTVI9L0fNkz+ZmoVeqWTnW47roUAztfNnbu+KcXbG5LRh9Aj
         8VdwGMubPW6EduZpCRNrDeASnEUE7oPnbe+MiwIExYMGI19pkSSQkb8YUKKgK9ZxvO67
         1B17HfN8nvlJtPywofOv7ax50KwcbCJPQMZc9GCF0+38DQozDdRmjeHRrwNHvxbDoXJT
         MX/A==
X-Gm-Message-State: AOJu0YzugOZwEUBvklaNSZ6713Xx8ov8Bk1pSOjbDzO5Xgid4QUcQ8wD
	W83lPKKfe/aJhmldibKHF/fm6DJpxHM0CLHS50dGtg==
X-Google-Smtp-Source: AGHT+IHEuY8or3WBjzxVCMAjxo8ALWrphZ5RqsKs5y+czx7cWMwRa6pCbEzNckPHRz8dE0gKHScUmwC8orxs0sVozbU=
X-Received: by 2002:a25:dcd4:0:b0:d86:4342:290 with SMTP id
 y203-20020a25dcd4000000b00d8643420290mr11467610ybe.21.1698676180428; Mon, 30
 Oct 2023 07:29:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231027-fix-rtl8366rb-v1-1-d565d905535a@linaro.org>
 <95f324af-88de-4692-966f-588287305e09@gmail.com> <CACRpkdbyMEqjW1a9oK-GM2_XL0famH1RgSXW-fQLszn9t9UhWw@mail.gmail.com>
 <20231030125127.xccqwct3jgg6o2rl@skbuf>
In-Reply-To: <20231030125127.xccqwct3jgg6o2rl@skbuf>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 30 Oct 2023 15:29:28 +0100
Message-ID: <CACRpkdaPqg4X5HrLn_Nt3_FYNtd0bL4wAKWFfRXStvX9bWagYg@mail.gmail.com>
Subject: Re: [PATCH] dsa: tag_rtl4_a: Bump min packet size
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 30, 2023 at 1:51=E2=80=AFPM Vladimir Oltean <olteanv@gmail.com>=
 wrote:

> So, what Florian was asking is whether the conduit interface is not
> doing its expected job properly. You clarified that the problem is big
> rather than small packets, but we still need an explanation for the
> existing __skb_put_padto() call, given that it seems that it was placed
> there due to a misunderstanding rather than due to an explicit need for
> an exceptional case.

Hm Deng added that and it was because the same was needed for
some other tagger IIRC, let's see what he says.

I will do some tests to just remove it and see what happens.

Yours,
Linus Walleij

