Return-Path: <netdev+bounces-44025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6407D5DE2
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 00:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBF87281A32
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 22:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A2E2D622;
	Tue, 24 Oct 2023 22:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eLbV//xw"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B85B2D61C
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 22:02:48 +0000 (UTC)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2118010DC
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 15:02:47 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-507a98517f3so6983020e87.0
        for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 15:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698184965; x=1698789765; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BTifHyTf7GOHsVUIbUHHmNcJxsOq1rADOID+J6k9PgI=;
        b=eLbV//xwHmbYkgdXdpK+oL6rRsawifzZXR3YzyRLxH/FYzXw37zeZQOdVIZAMUQz+T
         liqM5H29sKyGF92p5NEf+7pCYMcDnBJ7klzKcQxjDJqw9+WT1TL/QNih5wBr0tdkudtA
         ku56IkWjekc80ziLlmUPOyuQ16Md3/aceR8G47FHVztfToJpJ2O/zS8hYwmztIlJAQPh
         jovvSPdI7GUr96I+rSnww0/pIA3ZQc1wU+KAYVxoWOi9i8r0DcaqBsMe7+JMSukMviTj
         mx3c7RLT/aJWeZyrWU+6TuVevFj16q3X3xJ27xsPrQIAEIy8P26LFHmqpPFnRJw5kl5J
         FLvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698184965; x=1698789765;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BTifHyTf7GOHsVUIbUHHmNcJxsOq1rADOID+J6k9PgI=;
        b=QSk06RhIBbpj7rA1fcjlkNhPiqLKXcBcVCDwB1N+p2HOQKIVirjTjtxvPY2lpidfCC
         eFszFCOCqQ3MCKQyiNNg3lF0x2CvPtCHdfG26UNbtsPsx7t3QF01CUQYpbK5ZUbHuTY0
         b2Aa+E6gCEbCC1Uy68coIPLe/2YKjtkdgDhMkKBgCwnsfERsLaC4ion/N/KbgB8IdlvI
         FnGR7KPtiFNFzH0uSdJAMeigKiZUL9nawNFHZHN1nRBjjkbTNOyVHyDTogEUAzf939Nu
         Wiofj9qhYRfc4UkNGpQJTAg0afuZuCicEoLcb8/ZvBnLejRSPq3iBbSv1zwj1AwM1IuL
         ilWw==
X-Gm-Message-State: AOJu0YzfHR66GO5kBxBblCXBKoG/B4dE/fJteBKgbGweCxeWnBONd7FS
	TZgHZN4u7dncFXlfFJXPAKkWA5I5vDTt1pi5Kbc=
X-Google-Smtp-Source: AGHT+IFKGkdSjqVdKJnCGK3yBCWsmPJBZq71ZtOWQ6EqbzLPL1L4ktqF4jVEqBOACBi4UPHM3Dt22OCRiBq9soB8TWQ=
X-Received: by 2002:ac2:44cd:0:b0:507:9a63:15d7 with SMTP id
 d13-20020ac244cd000000b005079a6315d7mr8703598lfm.25.1698184965048; Tue, 24
 Oct 2023 15:02:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231024205805.19314-1-luizluca@gmail.com> <809d24bf-2c1b-469c-a906-c0b4298e56a0@gmail.com>
In-Reply-To: <809d24bf-2c1b-469c-a906-c0b4298e56a0@gmail.com>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Tue, 24 Oct 2023 19:02:33 -0300
Message-ID: <CAJq09z4=QZOZ7mvmrPrs4Ne+TCyMZ5k276Kz8Ud+ty9qAmW2WA@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] net: dsa: realtek: support reset controller
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: netdev@vger.kernel.org, linus.walleij@linaro.org, alsi@bang-olufsen.dk, 
	andrew@lunn.ch, vivien.didelot@gmail.com, olteanv@gmail.com, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org, 
	krzk+dt@kernel.org, arinc.unal@arinc9.com
Content-Type: text/plain; charset="UTF-8"

> Empty stubs are provided when CONFIG_RESET_CONTROLLER is disabled

Nice! I'll drop the "#ifdef"s.

> if you switch to using devm_reset_control_get() then you will get a NULL
> reset_control reference which will be a no-op for all of those operations.

I'm already using devm_reset_control_get(). Maybe you copied the wrong
name? Did you mean devm_reset_control_get_optional()?
It is, indeed, what I needed. Thanks.

Regards,

Luiz

