Return-Path: <netdev+bounces-44027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB607D5DEB
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 00:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32C951C20B41
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 22:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874A52D63E;
	Tue, 24 Oct 2023 22:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TEgdeAFv"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A552D622
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 22:07:33 +0000 (UTC)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 179B910C9
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 15:07:30 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-507c8316abcso6706275e87.1
        for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 15:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698185248; x=1698790048; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+uNhMhD/FFtFpJf0eGJiotAUIVmJNcmVSqaUmCmaqKE=;
        b=TEgdeAFvv43jrpH3tSKaTqFYuC3hznE59seVxDvcMHk7wfBGWgShd8jp/ZctsYebSG
         A5lXbSxXqKvXUIaegGU4MyJ/A24CThfm5SN9oX8/0IoOo7nT/lFYhfJMZUj8FwT26ZfA
         IB0qseX+FiFwE9rapnjtUchA4GdUZtuyS6lk6ttuQhrcCyxt2OlXbH2v4DQQYluDqoNA
         Qyt2r0Ufdr2gLyAiM94hahVhyFqTlitvKJOu919+hSh8AwzEO3VNoYy88lLWa8j6tzgd
         jYSfLEUkrbnDc0J5+OTu89cZzso7sdaN4d+DLrRWd3Gjp3rY13iGH48P6XGwOMw0tgWo
         xcHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698185248; x=1698790048;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+uNhMhD/FFtFpJf0eGJiotAUIVmJNcmVSqaUmCmaqKE=;
        b=ocMJpUsh6NHUIeUeUoGp9iuwp/yvWDpXJVrzVKS6Ys2WRaZ06AGLswNEklhFXHS1Fu
         q22oP4actOYdkVUVcO1cZBp/bfulzcD0LFS9asAz0g9He5WvUMVEbga6DWpROQngjPoc
         vOnBGTsKNGtzhFPl/NBjghJqYFh6f/GNFYgLlfb3YXDgoikeKCva7POGGCvaLe9fTLGI
         JEpW9cPxA7tyLduZXCH+v781orCc2iET+8sPUpwpqvkahhsvMtAnCgVPdnDk8BGiYDuh
         zEggw+H8LQeTjuMi9FyQcCBQkhn/W82O9KPfG2gQ+vf511xkQ1ZK7c9nDf29TsWKSfvh
         1BZg==
X-Gm-Message-State: AOJu0Ywak3bqtDP0WZ8gCWh//n4jYIC6JGkbxhtR2AhQ9BGZQ7bkQerx
	bF2+86FN4zFKFWlxBo1dVts=
X-Google-Smtp-Source: AGHT+IHtfiirnNnFi4I1ykqUrrXGwo/RRViwIW38/BVfGc5pIl/4eG0BA/HQHhDtZaxMC+b7dHwhiQ==
X-Received: by 2002:a19:7411:0:b0:502:a4f4:ced9 with SMTP id v17-20020a197411000000b00502a4f4ced9mr9364687lfe.62.1698185248055;
        Tue, 24 Oct 2023 15:07:28 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id m9-20020aa7d349000000b0053dff5568acsm8453944edr.58.2023.10.24.15.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 15:07:27 -0700 (PDT)
Date: Wed, 25 Oct 2023 01:07:25 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
	linus.walleij@linaro.org, alsi@bang-olufsen.dk, andrew@lunn.ch,
	vivien.didelot@gmail.com, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, robh+dt@kernel.org, krzk+dt@kernel.org,
	arinc.unal@arinc9.com
Subject: Re: [PATCH net-next 1/2] net: dsa: realtek: support reset controller
Message-ID: <20231024220725.4rlaq7ma3vc2l5qf@skbuf>
References: <20231024205805.19314-1-luizluca@gmail.com>
 <809d24bf-2c1b-469c-a906-c0b4298e56a0@gmail.com>
 <CAJq09z4=QZOZ7mvmrPrs4Ne+TCyMZ5k276Kz8Ud+ty9qAmW2WA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJq09z4=QZOZ7mvmrPrs4Ne+TCyMZ5k276Kz8Ud+ty9qAmW2WA@mail.gmail.com>

On Tue, Oct 24, 2023 at 07:02:33PM -0300, Luiz Angelo Daros de Luca wrote:
> > Empty stubs are provided when CONFIG_RESET_CONTROLLER is disabled
> 
> Nice! I'll drop the "#ifdef"s.
> 
> > if you switch to using devm_reset_control_get() then you will get a NULL
> > reset_control reference which will be a no-op for all of those operations.
> 
> I'm already using devm_reset_control_get(). Maybe you copied the wrong
> name? Did you mean devm_reset_control_get_optional()?
> It is, indeed, what I needed. Thanks.

Please also wait for a review on the device tree binding change before
posting a v2.

