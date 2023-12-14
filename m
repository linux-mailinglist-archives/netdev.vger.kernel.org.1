Return-Path: <netdev+bounces-57203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C346D81256A
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 03:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55361281E15
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 02:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196ED814;
	Thu, 14 Dec 2023 02:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OECR0FGD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB02CF
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 18:46:49 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-a1ef2f5ed02so836971066b.1
        for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 18:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702522008; x=1703126808; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f5WxFQyJYIQOOc6j/T5Byv6+KulToRfJMNuWiFKr6Vo=;
        b=OECR0FGDgIfkZ05Vg6xMppATY9qf3AcDDPkfbc9CfG+Sw3zzG4MI15Xx/bLS554/GW
         33f6XHG3OQENagqza1VeLJU8Oedw3wppJDDAt4SoEuJMzDGJejQ1df82QSkZ9qcGHAtV
         ZZQUxOYQ8guy5CeWnou+k5dj+YzfRkMVZSNPqB0cFsdzH6Uh3MrmzisoeybXFjRanaU5
         BaS2P/mtJYTD5dTva/rODB9jF2Imq3RHNXYjAB73tUKmAHysSPWCfQw/fjEtUmiVvEwp
         xpJK1YpvQA/Qywg+TKfdIDIPvkqQXEhQGzJ2NdZQ+UIBmAd18NsDCKaIK+jNg5npt5uw
         Eqgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702522008; x=1703126808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f5WxFQyJYIQOOc6j/T5Byv6+KulToRfJMNuWiFKr6Vo=;
        b=tLd22zZ78Uf88LEvtTHBOrol/VQXKBPBxyP4YjZXThO06r/lpETQTr1DPRIdqwBtFf
         cjudwOsj43tafo8VSVqbmwQVSeWByXLoVdoWMdsh9IkbVGxeTYcjVJA/cwS6EzEsMG91
         ZFrXy1dcZJRlGxgTYFnueOJf8ZdpQX6TcxUfiqQxEU/ZkZvHbWAQwJFrRRb00gNAYUQQ
         M93NG3EBh5V6xY0gvxKWZq1Mrr1fgGdbxI5ZhzRjvFMLki5hLt6oFswyVT7tBg55Cs/C
         tjpR63hbaLFiwvNXSDEGj8paCGciSsSCA7YtU/EBEcAzutvu5znLl+F+6ZIqITwzQzBP
         CdUQ==
X-Gm-Message-State: AOJu0YySUuetcUhZmWp5f5c9kkV9Z90nHyuwOPX8JCSP5gf7KCP0yhxJ
	UpZObCN0tOl4E6C/OJ75gH8XTswshHG6M1N6j0g=
X-Google-Smtp-Source: AGHT+IHIAK65PH+mi7xD0oWRYbmhJIe6zUXeBe6++W5k/rBnyAAe7MDhDO6AsHPq124Eo1A6JxAIU4NJwpUpsIpgpJA=
X-Received: by 2002:a17:906:c281:b0:a1c:7dce:d416 with SMTP id
 r1-20020a170906c28100b00a1c7dced416mr4469611ejz.124.1702522007623; Wed, 13
 Dec 2023 18:46:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231211035243.15774-1-liangchen.linux@gmail.com>
 <20231211035243.15774-5-liangchen.linux@gmail.com> <CAC_iWjJX3ixPevJAVpszx7nVMb99EtmEeeQcoqxd0GWocK0zkw@mail.gmail.com>
 <20231211121409.5cfaebd5@kernel.org> <CAC_iWjK=Frw_4kp-X+c4bN7e19ygqsg78aiiV2qJc59o7Gx8jA@mail.gmail.com>
 <CAKhg4tJDgaVeMp437q1BHuE3aZo2NU4JnOhaQEXepJuQhPnTZQ@mail.gmail.com> <20231213183420.78b3be68@kernel.org>
In-Reply-To: <20231213183420.78b3be68@kernel.org>
From: Liang Chen <liangchen.linux@gmail.com>
Date: Thu, 14 Dec 2023 10:46:34 +0800
Message-ID: <CAKhg4t+_zn4EieUf__Baivnox-soMGKV=g+fPeFWL9zVR6x1ww@mail.gmail.com>
Subject: Re: [PATCH net-next v8 4/4] skbuff: Optimization of SKB coalescing
 for page pool
To: Jakub Kicinski <kuba@kernel.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, hawk@kernel.org, linyunsheng@huawei.com, 
	netdev@vger.kernel.org, linux-mm@kvack.org, jasowang@redhat.com, 
	almasrymina@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 10:34=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Thu, 14 Dec 2023 10:26:47 +0800 Liang Chen wrote:
> > If there is no objection, it will be included in v10.
>
> If I manage to reach you before you post - please hold off for another
> 30min with posting, I'm going to apply patch 1.

Sure. Thank you!

