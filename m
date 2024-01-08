Return-Path: <netdev+bounces-62454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C762C827651
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 18:27:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F322B2195F
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 17:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01E154665;
	Mon,  8 Jan 2024 17:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="dxcbOxKf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2014054BC7
	for <netdev@vger.kernel.org>; Mon,  8 Jan 2024 17:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5ce6b5e3c4eso549542a12.2
        for <netdev@vger.kernel.org>; Mon, 08 Jan 2024 09:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1704734855; x=1705339655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ns7VME7gqRmNPy2SUavN6RuAGr3SVvvFBUAf7dtFdRw=;
        b=dxcbOxKfGkViVPZkog84Mix1/dhu7u4j0Zw/e7PzTBMM+qWBO4cWFWv8Efv3cRw6sc
         q4JPLhohwVOL/dSRIbvfJbiv0VyWXCaRAn3njx9wRlZDKCE0sSvgBNieiqjhuScKvLkF
         tQR+iHjgckHctt4s60V3iBKQIT+qajZiy1+P/cC48NasZ5k/fdFd/975P5EFYbNjIPQ6
         sKr65A1KtqHnuHCJb3UPaAi8hW+Wjb8PiztrYlrpxOCBq42Ge2EyDMYbENd0IL5jkKsB
         dX5dVGhB3AggSD/Cayxd7YwAsYDPsa2Km/P4NmR9UKmqmfZgYWkIR+mYPgqkDEbeMisz
         6UWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704734855; x=1705339655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ns7VME7gqRmNPy2SUavN6RuAGr3SVvvFBUAf7dtFdRw=;
        b=PLQy64npheaz6xWTH0oDP9TWuWXU8VDFcuxmkI2XYVGymyzb0rBeJZYvlwgFnafLDP
         9cD9i/z9W6MUgR1Uz9ta0MeXPsB37lzoqZZAFOD5fQ4B2oiAmBUqFq+y6kV99jZDTUQd
         Qsha94bURXPs4bI8DuWfiPlzJBXbnFbeSHbFryJtIuRbEL+wavuEx9d5StoJesCO0w+v
         9ZA90PM2bVpUJyfUhBO/mDVQphWGt7UXanaXjWZsi/EYLmohUzgyAKg1GIlhP9pyZn2B
         nWc/lWkltiqV5Qr7xjRwnEL0vUz2xHDRVhaBjQz1CV0afLYq35yV+bv1WehtzTFF2Hz1
         Unfg==
X-Gm-Message-State: AOJu0Ywj4w3Dc8Vd6mo94OQFKwKwdzAqBXSFsmITGTcjYRczXHa4Hwqk
	nFEgoCH1MutdNafCRXH0w8lUmdiuA1eAQbqQeDKnT1gg+zo=
X-Google-Smtp-Source: AGHT+IH52g4wbMJAc50l61lS0mTLcvvjiuSJ9S5mC/W6PXo7nAIO6HMVomSdeMP6kBbf3/R5mI7/Mg==
X-Received: by 2002:a05:6a20:3d17:b0:199:e7bc:7961 with SMTP id y23-20020a056a203d1700b00199e7bc7961mr107290pzi.47.1704734855342;
        Mon, 08 Jan 2024 09:27:35 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id i1-20020aa78b41000000b006d9af8c25easm128776pfd.84.2024.01.08.09.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 09:27:35 -0800 (PST)
Date: Mon, 8 Jan 2024 09:27:33 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Maks Mishin <maks.mishinfz@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH] maketable: Add check for ZERO for variable sigma2
Message-ID: <20240108092733.5bc8d980@hermes.local>
In-Reply-To: <20240106211422.33967-1-maks.mishinFZ@gmail.com>
References: <20240106211422.33967-1-maks.mishinFZ@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  7 Jan 2024 00:14:22 +0300
Maks Mishin <maks.mishinfz@gmail.com> wrote:

> If variable `limit` == 1, then `n` == 1 and then second for-loop will
> not do because of variable `sigma2` maybe ZERO.
> Added check for ZERO for `sigma2` before it is used as denominator.
> 
> Signed-off-by: Maks Mishin <maks.mishinFZ@gmail.com>
> ---
>  netem/maketable.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/netem/maketable.c b/netem/maketable.c
> index ad8620a4..56b1d0bb 100644
> --- a/netem/maketable.c
> +++ b/netem/maketable.c
> @@ -68,6 +68,10 @@ arraystats(double *x, int limit, double *mu, double *sigma, double *rho)
>  		sigma2 += ((double)x[i-1] - *mu)*((double)x[i-1] - *mu);
>  
>  	}
> +	if (sigma2 == 0) {
> +		perror("Division by zero in top/sigma2");
> +		exit(3);
> +	}
>  	*rho = top/sigma2;
>  }
>  

This looks like a purely theoretical not practical problem.
Just tried the tool with input files likely to create the problem (no data, one sample, etc)
and could not reproduce any problem.

What input could make this happen?


