Return-Path: <netdev+bounces-61919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BE1825340
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 13:15:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87EF81F22F65
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 12:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071EF2CCB8;
	Fri,  5 Jan 2024 12:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="EY/VURo9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986062D029
	for <netdev@vger.kernel.org>; Fri,  5 Jan 2024 12:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40d3c4bfe45so13228085e9.1
        for <netdev@vger.kernel.org>; Fri, 05 Jan 2024 04:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1704456905; x=1705061705; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NYYAS0wnVVbOb9FzCTZJ5vTUiIz8eibbc8XAt0OM4rU=;
        b=EY/VURo9sdQXogOnLeQfiuD/oZNxGn9KHVvkoyGmWy5BP2boXEC1JMXu3Z0kRO4JUO
         kdjbh4ChHUXG6CD6f+LRMYznr2QcQJ+zNyESOJOnaI0bXsnKV24QseWiJ7LYXBaVjKIb
         npEpPheiBfD3Q9eVNA/mzP70N8GnWP67baAtsOxrr0ovfK6I5Bjcs5AX66Ka0BDwQPU4
         T+uIzClhNWbRJik15vYhPkjQ3OJJ0fj2pz5zGLL3X60IxyPIkFu0Gdub5Ln1YEeszHco
         CvnSeyntLJM8GHaD1ePinimacV/jlnG80akUcwynX32kvwakdP7MOU7S1TmqE6Hq4tws
         H8dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704456905; x=1705061705;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NYYAS0wnVVbOb9FzCTZJ5vTUiIz8eibbc8XAt0OM4rU=;
        b=W9veYulPsYshHSMbah2n3Nt3/EpoeN0jZEOFRkVeAYzGIUjHDkmPZ9ahicbJy5kX1f
         hPir4GgfENBOOhhL/duwwzVLURbmj52Q1HuxmjVeeezET11OJCcpvaO+l3uKQtyXvql9
         7isuvPuMR6A5zVIuW6cLfxwdjVGf3oROmzq/C+PhTeCZJc4s/oWD8ynTn35e+1Eu9O+Z
         hkGT8RD3yAAdj+5fSPrOOklR8aeVgP1e/PYzHgC2jDLUWAY4cFEfaqQZVwTn1UGjt3I5
         /Unpy9AkfYC0fHzsBly9U0lqtSItTPEZlnTanXmtOgLhB7v+otJDqeFzmKFnV0SSmpJG
         0elg==
X-Gm-Message-State: AOJu0YzloTT3AnGOW16QdL6cJ/HlWlx08yPKIRiUwVEIudhjJnMUOQPC
	TonFCSByqAkL+xnnLB1L6GQkB+LwmO3CaA==
X-Google-Smtp-Source: AGHT+IEGV2BJ/YzDWJ4mXqzbE8ErdV5qgxFOdAewa7WXieQhQ0C8Vgv4zOoDqqLoHRFoQj/Me1mwZg==
X-Received: by 2002:a05:600c:16ca:b0:40d:8882:685c with SMTP id l10-20020a05600c16ca00b0040d8882685cmr589127wmn.313.1704456904724;
        Fri, 05 Jan 2024 04:15:04 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id iv14-20020a05600c548e00b0040e3733a32bsm1411373wmb.41.2024.01.05.04.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 04:15:04 -0800 (PST)
Date: Fri, 5 Jan 2024 13:15:03 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [net-next 04/15] net/mlx5: SD, Implement basic query and
 instantiation
Message-ID: <ZZfyx2ZFEjELQ7ZD@nanopsycho>
References: <20231221005721.186607-1-saeed@kernel.org>
 <20231221005721.186607-5-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221005721.186607-5-saeed@kernel.org>

Thu, Dec 21, 2023 at 01:57:10AM CET, saeed@kernel.org wrote:
>From: Tariq Toukan <tariqt@nvidia.com>

[...]

>+static int sd_init(struct mlx5_core_dev *dev)

Could you maintain "mlx5_" prefix here and in the rest of the patches?


>+{

[...]

