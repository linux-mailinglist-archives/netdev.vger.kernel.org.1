Return-Path: <netdev+bounces-55183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D43809B40
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 06:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABAD3B20D13
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 05:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50329523B;
	Fri,  8 Dec 2023 05:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UYkYZaD0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396F910F1
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 21:01:15 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-50bf32c0140so1849274e87.1
        for <netdev@vger.kernel.org>; Thu, 07 Dec 2023 21:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702011673; x=1702616473; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=V/Xtnj6GEUK5AdH+Hybz5+Go8e3T2cJYiIFn0NCOTMk=;
        b=UYkYZaD0OyObTQ03VA9969N4CNB2ZW+0RT0O7x/ST1GFKsyoaZPImx9CBfMLit/DKx
         YJNJiRru61DZtdhhWJS7J9ui8vtCEIo+6Zg87clrYbnSSWZ94QEhfiTdR6kuGds296QN
         J0RlMDWCzpGMQsUuig4VpOyPY97WOj7SUpMK4rlHjz2QbVsPhOjnSRHzQ9q5wrIaYoSo
         miIv2Hi301jRAuYW2l45O2mO2ThPMYn8fD0g3kUAgzO/bQwszTgBB3S5c1gmbt2N9JJT
         BehJRw3JYJc2hbx8hEYgmsmaM1qk2dIdXBH/OAXWzwGlv1Oxr8ynbm1YfVbOcrykkVxB
         hVDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702011673; x=1702616473;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V/Xtnj6GEUK5AdH+Hybz5+Go8e3T2cJYiIFn0NCOTMk=;
        b=NdFR/KpGj8oawyd0+o2AF7ZdM2ylrA4WgbZtuQnJkYF7rCyW8O3O1k6eiBhnrV7cWu
         YlUWKczxnUSbtNikMwo/Xzo0oFtgzrGUDn3Sy8WHpr4S1L5krUF3N3NRQfUBVq0sX7ZI
         yHivFwIqflZ4W5WonXAoBZzzst+HEnayUklnG3EwkIGJo6oN3mDBBXyRZZZSd6McTpN3
         jl5bKgrxRsxlaiVPKC1OB9/PY5NARs8R/LhN9NpQziFCZ4YXe4u/w9MP1xWuJeWZl79W
         jBQ2R6YKcxrT+FUJapNyTIsq+yfi7DBCw35BwSHmERlrrkuQbLHGkaSVuVX3vbeX32Tu
         0pAA==
X-Gm-Message-State: AOJu0Yx9QpTwzyJ+jkW6z7TEqSEnp2yVI0aRduFoXXyH8o+CZtKYfdfP
	0eyEth4IuDSOj0f9ue6HoT0mj2mjuMKfOZc8Gq5vsm8LEI5uRQ==
X-Google-Smtp-Source: AGHT+IEhu3LPYg5WEPVUMxM/qSDCu/swF3eNL5AnN9U2//U7yVuDMHRqCRP1GwtLHvdUjeCo2uvfVoQtnDZ38E5DlUQ=
X-Received: by 2002:a05:6512:10cb:b0:50b:bb95:c367 with SMTP id
 k11-20020a05651210cb00b0050bbb95c367mr2727815lfg.55.1702011673170; Thu, 07
 Dec 2023 21:01:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231208045054.27966-1-luizluca@gmail.com> <20231208045054.27966-5-luizluca@gmail.com>
In-Reply-To: <20231208045054.27966-5-luizluca@gmail.com>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Fri, 8 Dec 2023 02:01:02 -0300
Message-ID: <CAJq09z7Xqxs0RFHh5TWG2EvxcAgm2Ot1X-_xkjbJ7EG4_dhf+g@mail.gmail.com>
Subject: Re: [PATCH net-next 4/7] net: dsa: realtek: create realtek-common
To: linus.walleij@linaro.org
Cc: alsi@bang-olufsen.dk, andrew@lunn.ch, f.fainelli@gmail.com, 
	olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, arinc.unal@arinc9.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Some code can be shared between both interface modules (MDIO and SMI)
> and among variants. Currently, these interface functions are shared:
>
> - realtek_common_lock
> - realtek_common_unlock
> - realtek_common_probe
> - realtek_common_remove
>
> The reset during probe was moved to the last moment before a variant
> detects the switch. This way, we avoid a reset if anything else fails.
>
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Linus, I think I should not have kept your Reviewed-by as there are
changes like moving the match table out of the common module and
splitting the probe into pre/post.

Regards,

Luiz

