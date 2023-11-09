Return-Path: <netdev+bounces-46784-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B00C27E6657
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 10:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68DB6280F5E
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 09:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474AA10A33;
	Thu,  9 Nov 2023 09:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QF6wrRgT"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D5110A30
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 09:11:42 +0000 (UTC)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE99210A
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 01:11:41 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-50930f126b1so708624e87.3
        for <netdev@vger.kernel.org>; Thu, 09 Nov 2023 01:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699521100; x=1700125900; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JSs6d51QA0IJk05O82he+EKBbdgGwh+/jCpQIQ5SQnA=;
        b=QF6wrRgTEA9zkTc00HyywplKGt/i+FyKyLzraHSrS6AlZM0paIudJZCVjzzOxWRXSD
         HpGMLjyxevbDsEH9m3Ku+KhOC31rlUVKDgRX63uWBCTJPHBvgWQ/Wz0ErPAm5WBV1UFc
         jn/yCDEH4YGKNxhKlubYXUv/ci+7UgB210DHtHDkX9FDibhi8dQ4yTgsL4xTItbn+OVE
         2Ox2j5LXd4GO42pF2Sm3qYnXNVOCy/Mmv/Jcv0aR7/ChCW+J6zYetzRhCwh18HJE+ebN
         xxyeNxdTPBGp6XmkK8rg7uiK8hEVK8mayW0J1Jpht7qaBVrYCVtKZdmeHoZWuS0cTFoE
         EjXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699521100; x=1700125900;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JSs6d51QA0IJk05O82he+EKBbdgGwh+/jCpQIQ5SQnA=;
        b=AN7j8QqG2LVKwKsL3ofmpNgbDJacWAzJnC6UttVeeatC4XmSng98BUrAkSxSpflFpz
         z8tP69NKtdMGYUv8dxccok3dXvN1LMYvl+BO2K5WSu9qZymcAi6+9vbfb8MJNA39+pVb
         09j28fdJe9JdF1eAxSbLmLAS0X4o4pw8GhzmcdKG7cVECiQFC3nZ3VPhHiVElXoaumpV
         Mp5+b1Wp0FCOjkrxGGCT63xf/OnMD97y3w29B/x0RfuB0MKmj6jBH25s2XRw5yptdoM2
         m6qTo8NQML5uyuvrDhTCnYjJ/Dvwk2iLL6/amUnsvYWsEP+VkTRQ5TfU2AkhvB51Jwju
         +5DA==
X-Gm-Message-State: AOJu0Yz6eA2SsqGi69xJNcd5jFEfDiBKVDDMfhmJXCLV4VQSYf91l4Dm
	Pb5juvSmKFvUw4jIjUnjD+EA+CeEqQ0S0slF1sbfHA==
X-Google-Smtp-Source: AGHT+IEp8JbjoWlF37daBpzGxFW51lBjn3AYCrDsg862Dj39A9HR38b6NaKRjEptfviZ8iwF7KdzUSU9u7/fCqq1xxA=
X-Received: by 2002:a19:3817:0:b0:507:9a49:2d3d with SMTP id
 f23-20020a193817000000b005079a492d3dmr763487lfa.31.1699521100096; Thu, 09 Nov
 2023 01:11:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231024160220.3973311-1-kuba@kernel.org> <20231024160220.3973311-8-kuba@kernel.org>
In-Reply-To: <20231024160220.3973311-8-kuba@kernel.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 9 Nov 2023 11:11:04 +0200
Message-ID: <CAC_iWjJzJp+QWCY8ES=yOr4WrKXqF_AWGJjzNdCQmGpa=5dbyQ@mail.gmail.com>
Subject: Re: [PATCH net-next 07/15] eth: link netdev to page_pools in drivers
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, almasrymina@google.com, hawk@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Jakub,

On Tue, 24 Oct 2023 at 19:02, Jakub Kicinski <kuba@kernel.org> wrote:
>
> Link page pool instances to netdev for the drivers which
> already link to NAPI. Unless the driver is doing something
> very weird per-NAPI should imply per-netdev.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c         | 1 +
>  drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 1 +
>  drivers/net/ethernet/microsoft/mana/mana_en.c     | 1 +
>  3 files changed, 3 insertions(+)

Mind add a line for netsec.c (probably in netsec_setup_rx_dring),
since that's the only NIC I currently have around with pp support?

[...]

Thanks
/Ilias

