Return-Path: <netdev+bounces-55467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C7180AF8A
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 23:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B4CC1F21249
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 22:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051D459B5D;
	Fri,  8 Dec 2023 22:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AUapgmZT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C5E1718
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 14:15:22 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5d8a772157fso22864807b3.3
        for <netdev@vger.kernel.org>; Fri, 08 Dec 2023 14:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702073721; x=1702678521; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t5TOPzBrk8pcPFy5hdVS0vsSgzf5Ob8OmxNA6ZcMZ3g=;
        b=AUapgmZTV+sBOrCsdzKBLa1FraMRPB2GHxdX2WfI65LMRtNetEHGsJ4RgqqXqei01j
         iFM5vjuduiUUpZqSKwa0BnALjjmmqDGQKgNJ7YjkV2z+7Fq9Zb6JPEKr1TW+iYeMaYkY
         AjbHeK7gdv7a78VaQvVErFLuPsmP75pa7oKiC5Kow1TD7O/Qk4lSBu+C7Ybqxl8WD0EQ
         mXOJl30F+aP3LbuRBScfvj0lkW4nUM3shChgHxZEfUNrV3s/Jtsa+2a+eMI1tNIUQCQ/
         g4E77t+p4wqKyKjU6/UjF5Xj7sGskI4mJ2KpqcY4nWtF1UtFSclXh+M5VkoWZxzOlT3I
         2TdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702073721; x=1702678521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t5TOPzBrk8pcPFy5hdVS0vsSgzf5Ob8OmxNA6ZcMZ3g=;
        b=CCRi60zmKFPW2RmhYqH51KbJw1mdvSSeDYfkpxD9UywMhEELMH1qaVSbtjymmFec0t
         MMaIa9iPhRLTKBQk763b7sN3rKKhkkeWZdJmpBbcPT3Fd4xjYskf3LxgJF5uU3xWq9x9
         k78JbGHLIZcYnoiLrtbSKVtuZDRNicskxsPCyK8aetr/e8qf1x25g8idaNiLVQZQE5s6
         KZyzkOJwbeCQA4Uacqom61sYXGnIHodvjXXSO312Kg6VHGksLo08cIWBubKnTeXmf45a
         Kn4Sa5YkRoiOxDyh5JUGEgZBgSIr3+GZXwieNCEqbsPeMqXHf+uJ16qaxw+gzYrqcZOx
         aAxQ==
X-Gm-Message-State: AOJu0YxJSPxRqb58CYa+z6XUUW8BJHLTXzD77p+0IK0ZDoWRUbBP7OZ9
	+8oiYFoIL0Zrio6pfAkLal5a7Hu2i1DEuRNmv4qJew==
X-Google-Smtp-Source: AGHT+IG7xpIzs6e0lH65Ses4X3yzxW8Is1cv2knoNXnZpac7gy2ZqVCN3DS0ENRNhHQ6DrgiwlgA3aYkaJ9eGjU6cEs=
X-Received: by 2002:a81:df0b:0:b0:5cb:9b93:a76b with SMTP id
 c11-20020a81df0b000000b005cb9b93a76bmr663628ywn.50.1702073721561; Fri, 08 Dec
 2023 14:15:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231208193518.2018114-1-vladimir.oltean@nxp.com> <20231208193518.2018114-2-vladimir.oltean@nxp.com>
In-Reply-To: <20231208193518.2018114-2-vladimir.oltean@nxp.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 8 Dec 2023 23:15:09 +0100
Message-ID: <CACRpkdZxbGPVg1OLh=DMfQv8FcDD6RvGjJf5kTzekKEJ5211Uw@mail.gmail.com>
Subject: Re: [PATCH net 1/4] docs: net: dsa: document the tagger-owned storage mechanism
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
	Luiz Angelo Daros de Luca <luizluca@gmail.com>, =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Madhuri Sripada <madhuri.sripada@microchip.com>, Marcin Wojtas <mw@semihalf.com>, 
	Tobias Waldekranz <tobias@waldekranz.com>, Arun Ramadoss <arun.ramadoss@microchip.com>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 8, 2023 at 8:36=E2=80=AFPM Vladimir Oltean <vladimir.oltean@nxp=
.com> wrote:

> Introduced 2 years ago in commit dc452a471dba ("net: dsa: introduce
> tagger-owned storage for private and shared data"), the tagger-owned
> storage mechanism has recently sparked some discussions which denote a
> general lack of developer understanding / awareness of it. There was
> also a bug in the ksz switch driver which indicates the same thing.
>
> Admittedly, it is also not obvious to see the design constraints that
> led to the creation of such a complicated mechanism.
>
> Here are some paragraphs that explain what it's about.
>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Clear and to the point.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

