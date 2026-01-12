Return-Path: <netdev+bounces-249072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8810D13922
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 16:17:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E2C2030019F5
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 15:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE1E2E7F1D;
	Mon, 12 Jan 2026 15:16:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142EF2E62A2
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 15:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768231019; cv=none; b=bUz1QKtwvuF7Rh+QEZQvaD/JH+dEBLEGsqt/a/hjfK87b0ci9Xs/7da0QCm66Nju5VIKDb5Sb2bAlxXbo1qiTB845S6POKIgPaTrrLmYOzRRugoWRAEjs/Q9LLIUZOKchSHS0/mAPzQrlrfPwBQ+7L6whEMW7+uOd0UM0WivaqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768231019; c=relaxed/simple;
	bh=EShopnW71/xFcgQTbpFPl66ggY2BecFS9wgT1FftxTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ceWWVlFt8IfcQwSq3/+4Jb19X4a+1aP5S6hFwVXm8JN+FBbMjnmvqmYtwmu7DBEqO0tw/NXv5axY47pSIvW2/d3/f8jykCChyQdF1MPrUV8mHu3LlKdRVMpn0fZigJBxd1oSFBanfPnw9clU0+/apdc+yg5BzqFLln9E7NgFq7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-459ac2f1dc2so3777790b6e.3
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 07:16:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768231017; x=1768835817;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K2lP+KPaY9dq3lWX+X1Khpp2qI/DD2GRwQIakoNQiEk=;
        b=pRdffW1EjGPKiDgEMD4Beos2ga0Wfe5mLI/yxxGbaZaHpp9N+Fg2Dcblrg+g7DasHG
         pLBUC9nZjNehj/jjo8xR2Df1ndkk6xfTqK2Y2eNBp0G/ZerSbVIA1mtYVd/EChKH7BLn
         GkvY2w5kW2g3GhLZtJMfiH/Lfmqtuej1INSc9yzu3Mc7UPwmOOIDVKHdgKR9PNV1oLiH
         jeN+HfpcwBf28tgtEeb78FskL5+vEUI+eRdukNLquHlw293LtBjm9UyN8gBqwTmotCpk
         o8CHPu4n4XtathzPZ1adOVSZQIlDpd5fW8JjBO8KWiBWjOYzvaGnyYpygwFOmIxtaxZY
         Nypg==
X-Forwarded-Encrypted: i=1; AJvYcCUpjvn6EXDo/joyMQaqq45Zk2U40Lhjql/qpCImCZYvs3n2WmXfpzn5TBOY3hAHgdrClsPUfLE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZn3q2VEu5Ucyy5OHZXM73Z20owGgd7fNX3wqHsKs0KN88oEfF
	94Wuo3xPnuDQ4Phjy50ThZk1VwQkfTbwYhTrMmYFeOafee9KUbfSajgS
X-Gm-Gg: AY/fxX7pPVZC/Lm1913F0o+zhwqnAjDDH/akQ/Nf8UsG2go8Vh5L7aLCkqRO3yeCYXM
	dg0XJkoWpdlHiUl/wlDz7onwLforKsRRTcrQVdMtxi2y3/SFC49/aKCsuaNrgeVUS04uqBNASeY
	EU+2uDNqVKDyAk5YmGK2TZHLdWbKyu4Cs+dQ0ynHIFO5yKqvGzjNVVt2IjjdvbL2CMmt02a0QIN
	c6lrHgmWE+n4BosTMAaOztnw2gJDexBqPEf1cqAC97WwkAnJeYLprmtrKPfp8EVTeEF/hwnV11I
	q9lq9x2CzRfiJB7fzP56z6NM6h8j1F7DdBBDuQYnkI6XPHdseQMsAh7q/BERv7CVPXKnKjQGjXu
	v/MVTDkqXtTyPdvLOeKOwMrzwgN5i4qgkFTvwUSvtbiAvSWkACWVEBYVLgx+TlH35hGanRvxteA
	==
X-Google-Smtp-Source: AGHT+IHXfMnaYPQo14c++hNdyyk6Ymr6+cKtUfrFEeM1r20pAZ3gzUSjR2INaAmkNP4czHxbLR1BrQ==
X-Received: by 2002:a05:6808:11c9:b0:44f:da6f:edb1 with SMTP id 5614622812f47-45a6bd83ba4mr8571597b6e.13.1768231016956;
        Mon, 12 Jan 2026 07:16:56 -0800 (PST)
Received: from gmail.com ([2a03:2880:10ff::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45a5e288c42sm8280583b6e.11.2026.01.12.07.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 07:16:56 -0800 (PST)
Date: Mon, 12 Jan 2026 07:16:54 -0800
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andre Carvalho <asantostc@gmail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v10 7/7] selftests: netconsole: validate target
 resume
Message-ID: <uzrkzwqpy2mf5je44xz2xtody5ajfw54v7kqb2prfib3kz7gvj@wtsjtgde5thb>
References: <20260112-netcons-retrigger-v10-0-d82ebfc2503e@gmail.com>
 <20260112-netcons-retrigger-v10-7-d82ebfc2503e@gmail.com>
 <20260112061642.7092437c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260112061642.7092437c@kernel.org>

On Mon, Jan 12, 2026 at 06:16:42AM -0800, Jakub Kicinski wrote:
> On Mon, 12 Jan 2026 09:40:58 +0000 Andre Carvalho wrote:
> > Introduce a new netconsole selftest to validate that netconsole is able
> > to resume a deactivated target when the low level interface comes back.
> > 
> > The test setups the network using netdevsim, creates a netconsole target
> > and then remove/add netdevsim in order to bring the same interfaces
> > back. Afterwards, the test validates that the target works as expected.
> > 
> > Targets are created via cmdline parameters to the module to ensure that
> > we are able to resume targets that were bound by mac and interface name.
> 
> The new test seems to be failing in netdev CI:
> 
> TAP version 13
> 1..1
> # timeout set to 180
> # selftests: drivers/net: netcons_resume.sh
> # Running with bind mode: ifname
> not ok 1 selftests: drivers/net: netcons_resume.sh # exit=1

I was discussing this with Andre on private.

Also, do you know why we got:

	/srv/vmksft/testing/wt-18/tools/testing/selftests/kselftest/runner.sh: line 50: : No such file or directory

after the test failed?

Link: https://netdev-ctrl.bots.linux.dev/logs/vmksft/net-drv-dbg/results/470321/3-netcons-resume-sh/stdout

