Return-Path: <netdev+bounces-46812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5FE7E689F
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 11:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 954261C2091D
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 10:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9B6139F;
	Thu,  9 Nov 2023 10:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="brYSW4wp"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB276AB1
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 10:47:28 +0000 (UTC)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9800F1FEE;
	Thu,  9 Nov 2023 02:47:27 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40907b82ab9so10953185e9.1;
        Thu, 09 Nov 2023 02:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699526846; x=1700131646; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HU6Rk9mQBtZM0uAVQC4cwcuLTXlxJFUrIWkkQhv6s1Q=;
        b=brYSW4wpcD4Ntou9MzOQ97W7yY8/7zfqinP4YU6gwevTeCbxjPPAc7OZbYI0swXPDO
         voNj+kInfynYa53WITkG8XLDoL0fT7aYO/IOHq+f1PeVeduc112EW+9oTi7RskvHRI+f
         Vof+kZCqKWOqJH99UESAzQIoyvnkZr1u8ZUSheW+9TJeU0SUKun2lt5idFvVYx0nVV7k
         r1bvI5g1NR1H5qSACQgB9fCy8mbcwo+FZH/pv5XbSnKioey/BaGvNNgeTtOVW0f4kJWT
         0HXYsHWyb+RWvSSheM3t/DaEXZFnIyYPcBK0yrD6k5YH9Tl30Z57hhTl+UhuQIOgA2+H
         +G5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699526846; x=1700131646;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HU6Rk9mQBtZM0uAVQC4cwcuLTXlxJFUrIWkkQhv6s1Q=;
        b=o+E4nSFGFCPqAQv5gcgu2k6eu1fUj3GSf6j+mOkXeBQD5IslEdRg5MhP5VTW0ae4W0
         6CSSP+rc+AT8bkSF0a6q4I6tvG8Tg+vpTITuZX/rbI3cTzR/bpaJzzvFT+xlFqVqVe+N
         fR22e5BBQNuJx3BvIthKAfxeMUVMcUfunSN0jqL0cVZ/Eg3U59hwP7d2lk/s6QKvKLh8
         2rpUCTk5aMZy8uxs2DfPlth5lmf0BMKoOHUH485HbtrxIzNsUa4sstV20h7hux5yjxw6
         EcAzZe0K4H+IJU5b+T7HVFg0CxdfGslsSIimFfbPF0btQ1tgTzjrmU9fHqS9zU78bDUN
         bOIg==
X-Gm-Message-State: AOJu0YzCnAb3J/46TaxyVP9L3l7fIEhLFCMzo3jpbSNcAyoTbH8X2jre
	33mHeROVWaaxGKjtaXq7o5E=
X-Google-Smtp-Source: AGHT+IFzWcoUglTgvCK+nVyrYytnnaGvyoCcZb5uYxZ4lo4eu/SpjBPNzF1WetwatuAXkfRMBjqgcw==
X-Received: by 2002:a5d:658a:0:b0:32f:a254:c8b2 with SMTP id q10-20020a5d658a000000b0032fa254c8b2mr5527744wru.20.1699526845882;
        Thu, 09 Nov 2023 02:47:25 -0800 (PST)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id v5-20020adfa1c5000000b0032d81837433sm7142165wrv.30.2023.11.09.02.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 02:47:25 -0800 (PST)
Date: Thu, 9 Nov 2023 12:47:23 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	=?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
	Andrew Lunn <andrew@lunn.ch>, linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4 3/3] net: ethernet: cortina: Fix MTU max setting
Message-ID: <20231109104723.2f47d2slwkbmqctt@skbuf>
References: <20231109-gemini-largeframe-fix-v4-0-6e611528db08@linaro.org>
 <20231109-gemini-largeframe-fix-v4-0-6e611528db08@linaro.org>
 <20231109-gemini-largeframe-fix-v4-3-6e611528db08@linaro.org>
 <20231109-gemini-largeframe-fix-v4-3-6e611528db08@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109-gemini-largeframe-fix-v4-3-6e611528db08@linaro.org>
 <20231109-gemini-largeframe-fix-v4-3-6e611528db08@linaro.org>

On Thu, Nov 09, 2023 at 10:03:14AM +0100, Linus Walleij wrote:
> The RX max frame size is over 10000 for the Gemini ethernet,
> but the TX max frame size is actually just 2047 (0x7ff after
> checking the datasheet). Reflect this in what we offer to Linux,
> cap the MTU at the TX max frame minus ethernet headers.
> 
> We delete the code disabling the hardware checksum for large
> MTUs as netdev->mtu can no longer be larger than
> netdev->max_mtu meaning the if()-clause in gmac_fix_features()
> is never true.
> 
> Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

