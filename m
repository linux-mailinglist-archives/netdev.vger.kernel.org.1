Return-Path: <netdev+bounces-53282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FFFC801E63
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 21:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAC43B20AD3
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 20:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8702110F;
	Sat,  2 Dec 2023 20:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sOoEqoVU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2AE114
	for <netdev@vger.kernel.org>; Sat,  2 Dec 2023 12:09:01 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-5c1bfc5066aso1220270a12.2
        for <netdev@vger.kernel.org>; Sat, 02 Dec 2023 12:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701547741; x=1702152541; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MRfQFyladFhH9b+9JZrfCTvzv6SJEMhdEhwO7DetBTM=;
        b=sOoEqoVUTFFFSZ84v/ZaFkAfKWdpne9uKIosrmM+VdnKFjRkNlgmXupjPAg0wFgYEN
         bHuz5tyQp0UJT3NP8cINBkxDmB1oPx9xGqHJSP26gg/PGI5VDu+IaHoFCM5BGu1AvSNa
         FtJb156lRAfgww4cAPkX0iZ6rUI6NPXS/OJK/D80lRoD1uXBAkIX2ZNy28XpE/JRGac7
         ycbEnyHqqVMFiKtsre16SDtEGdVRicALNVWJrHuMVQ+aHh23KvranwnGBN+DVD/Oy63N
         xFBpaDyX3YUxIAfop9ejoojXGA2/l89OdZKPwRo5Uccfdzn1k2/y8S2vkNY12E6EakgM
         uAMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701547741; x=1702152541;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MRfQFyladFhH9b+9JZrfCTvzv6SJEMhdEhwO7DetBTM=;
        b=wnHxLM4xdkVLKIpu4kg/DSppInZc89PjSbWYs3o2HPi0QcdxLeXQvY9lSrL8jzheQj
         ovw3FheDDvvDL9PIEHVn10zt7YM+kgqO7kjazyQ0+E3k/JhkzQz3f4UTBoIsuuraQ3rE
         Yll5miNtCuTIGS1twTxuS2mfJCmFcEZ+/06hn1uD5YACJZdGLNo8q4HH07f0Du3+PRx3
         hj/fuQEkTe5aAYE4K2bhHBiITQrQ12Vo8JJRXHiqCheYtcESSz6qHqI58/xt/vmLP4NH
         hXLxloQHAYDGvGTkDMQ/eKoq76VvsbwclZolvRl4xZ9mQ0G4F0tSCk7uHmF4nVEYQGK0
         nBYg==
X-Gm-Message-State: AOJu0YzH6Et4MS/xRMHg9Ju8tLd0qMDXRZ+sndZsonjPDV8Sli955jR9
	A1tRpERbdoq2R7NJNtk34no8y99MdGWQWw==
X-Google-Smtp-Source: AGHT+IHxdCuXTo6ksFzGO59GH7Yld7LdBlPKqiL1wrBmWgcEP5lFWJmhm/Q7IQFhQm7UZ2jQbvTc+j61L9R7Og==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a63:235d:0:b0:5c6:5ca0:ff8e with SMTP id
 u29-20020a63235d000000b005c65ca0ff8emr116533pgm.9.1701547740972; Sat, 02 Dec
 2023 12:09:00 -0800 (PST)
Date: Sat, 2 Dec 2023 20:08:58 +0000
In-Reply-To: <20231129072756.3684495-3-lixiaoyan@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231129072756.3684495-1-lixiaoyan@google.com> <20231129072756.3684495-3-lixiaoyan@google.com>
Message-ID: <20231202200858.uamsqzusj6dnoksv@google.com>
Subject: Re: [PATCH v8 net-next 2/5] cache: enforce cache groups
From: Shakeel Butt <shakeelb@google.com>
To: Coco Li <lixiaoyan@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Mubashir Adnan Qureshi <mubashirq@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Jonathan Corbet <corbet@lwn.net>, 
	David Ahern <dsahern@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, 
	Chao Wu <wwchao@google.com>, Wei Wang <weiwan@google.com>, 
	Pradeep Nemavat <pnemavat@google.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Nov 29, 2023 at 07:27:53AM +0000, Coco Li wrote:
> Set up build time warnings to safeguard against future header changes of
> organized structs.
> 
> Warning includes:
> 
> 1) whether all variables are still in the same cache group
> 2) whether all the cache groups have the sum of the members size (in the
>    maximum condition, including all members defined in configs)
> 
> The __cache_group* variables are ignored in kernel-doc check in the
> various header files they appear in to enforce the cache groups.
> 
> Suggested-by: Daniel Borkmann <daniel@iogearbox.net>
> Acked-by: Daniel Borkmann <daniel@iogearbox.net>
> Signed-off-by: Coco Li <lixiaoyan@google.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>

