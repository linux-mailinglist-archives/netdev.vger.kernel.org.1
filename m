Return-Path: <netdev+bounces-45578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B717DE6B7
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 21:19:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02F501C20B84
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 20:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CACBB1B27A;
	Wed,  1 Nov 2023 20:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uLkpk1S9"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19EB14AAE
	for <netdev@vger.kernel.org>; Wed,  1 Nov 2023 20:19:04 +0000 (UTC)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48CE3111
	for <netdev@vger.kernel.org>; Wed,  1 Nov 2023 13:19:00 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5a8ada42c2aso2504757b3.3
        for <netdev@vger.kernel.org>; Wed, 01 Nov 2023 13:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698869939; x=1699474739; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TitzneWvDoMzzr+coAisCqJHJdfZSk/3hIEHii6U/Bo=;
        b=uLkpk1S9HK6v9qnOElJdITKWjFE5P23BTIaJB3vQTuxJ7OtNwA0HA0T9zVM4D1Pk8J
         MJOTlZRohvM+V7Ik5XwK8dGo4Rap0yGNdoFHbQfl7ttseHQ6wtx6GzX9LlUGtK5Pv//V
         xoUibo02z/ziikkSBY0wSbVynhqJ5Le+rdHMViIyff/r56HC1XqHjceeTjXm5enXQXER
         LTwU8Dld/J1lJSVqEJ6lMuimmNB48OhMDLzVDHJ3Cwwy5/YaMzUQkAvWVaRjvYPH3g57
         QNmizt00Ba/nBUq5En+kw9FgqpX/8BNM+I0hRtZBZpQEc0cF9Y7WiKeFlyuIR2wjVPK4
         dYrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698869939; x=1699474739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TitzneWvDoMzzr+coAisCqJHJdfZSk/3hIEHii6U/Bo=;
        b=kqGN3T9f7x0vNxCgYY3wK3dPYQl5uyDfeLDvIFw3/3K3m1QJ5NcCLVXW66cHWI6QMz
         fjtY2msGWnjTSLnO00RE8p1ITYTvfgy3WBjk73MAUHXFJEZBO7EZtN9OAmvAiOwqUMRa
         HrBseajXaPS16m3XimPL6x+ih5vrG6VFoYs4sOZAoEYg1G/AqnE6OLkWBS5Nn4lwVqbm
         1dgFovM7mQCyJX7ODRfhvDumc+l0ZrGWphprH4NrpF69XSU/0qbL2peUANOuk9TGLvoo
         tW7a/+MbogytRey1vRXnAHyz6u3bU3sCUp1KSeE4h+YYnTGuF1pzd2XLy6wBrX0V1DRw
         TR7g==
X-Gm-Message-State: AOJu0YzXxbqIJ58kdTfX6vlzV3C+d+O+V0tl4kFV4GIB6maq3k6DlnwT
	p25w+wkug9afFDzReqeCjUiNPZf6CmBTiwFjK6yirA==
X-Google-Smtp-Source: AGHT+IGo6+MIYRKhTrama1zkFjt1CLUiYGYVyMjn2OnPbe5KN9hBfB3CyP4WowMIfpzZSNbhubM4hATIU/UXf+5ejxk=
X-Received: by 2002:a05:690c:39b:b0:5b3:4264:416f with SMTP id
 bh27-20020a05690c039b00b005b34264416fmr6121252ywb.27.1698869939518; Wed, 01
 Nov 2023 13:18:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231031-fix-rtl8366rb-v3-1-04dfc4e7d90e@linaro.org>
In-Reply-To: <20231031-fix-rtl8366rb-v3-1-04dfc4e7d90e@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 1 Nov 2023 21:18:47 +0100
Message-ID: <CACRpkdYiZHXMK1jmG2Ht5kU3bfi_Cor6jvKKRLKOX0KWX3AW9Q@mail.gmail.com>
Subject: Re: [PATCH net v3] net: dsa: tag_rtl4_a: Bump min packet size
To: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 31, 2023 at 11:45=E2=80=AFPM Linus Walleij <linus.walleij@linar=
o.org> wrote:

> It was reported that the "LuCI" web UI was not working properly
> with a device using the RTL8366RB switch. Disabling the egress
> port tagging code made the switch work again, but this is not
> a good solution as we want to be able to direct traffic to a
> certain port.

Luiz is not seeing this on his ethernet controller so:

pw-bot: cr

(I've seen Vladmir do this, I don't know what it means, but seems
to be how to hold back patches.)

Yours,
Linus Walleij

