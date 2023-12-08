Return-Path: <netdev+bounces-55266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A1DF80A05F
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 11:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BFA51C20A41
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 10:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA761426B;
	Fri,  8 Dec 2023 10:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="oARunh9m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C57A1706
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 02:13:55 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-54c671acd2eso2508956a12.1
        for <netdev@vger.kernel.org>; Fri, 08 Dec 2023 02:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1702030434; x=1702635234; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Emm2+uRMKtIwNKxzicMibCHscqGZ8bqfWrJ38jE7LnQ=;
        b=oARunh9m4yGIk2RF2g3mV2F9gxAEvo1YQ4Cl/6ujNWxHwiVt7bFB0qjqNd7qXVbB+u
         lD6Xbof9WH9YB42PoiQr5L88/SCQINnGsyBT99a71vZ8SoOMCKF9fJYU7W6W7ez2psYc
         PcZT4dBZkJUQXn3gSw5M3JWq51aBHrjN6c9dvGcx0cPON4LBMHYwLeVqhFpnR4YR8v8N
         12nDj2G4yGt0LO11LfTE+KSkxD6njQYBLVCuJoVyO24/XGSwqXsq5i3ZW1ZSBVx5NWbY
         PNH/IiRifnUV+BYMxp+4gUluUCAeHpXJ0t40l2pYrnu9gTQZqwXW1s9NJVNCMUu+saZY
         Hpbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702030434; x=1702635234;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Emm2+uRMKtIwNKxzicMibCHscqGZ8bqfWrJ38jE7LnQ=;
        b=uPfB1MMBbdGLTTB2phMdj8kKCsGuiBVotp5yFjsGBsevRlPWvef+tmGTD6Q9Y8du3s
         xxP/ulMfWlTE/Z5K1dTyI5i3bMLIbzTCEYP//RCZ0fRbIjktClMEEsUaO8qbYP5tB3nG
         0A2A3Twj7jJmOYBALr6FvpLGAYVcmkmyTQNmcQX5WDbYHK3CVMvT6vR8diC9l2MR0fSB
         h+qYarOZlImLF4K8uGqkjuRQnzvHEP9cLxfIAD6Rp6xDa3vFB04fD8Tu32nViol6nyWz
         Fxwqi9hiT+nIvu12BHd1bVWNw7E4aTaUDffLTvcDuMuiBCIF4VQ+f+lfGW+tbYbJDb4o
         aq9w==
X-Gm-Message-State: AOJu0YzNEd5RiE4BbodVmY8eserboJ0WFYob6dVrB5gL1zBGh1zCIRKd
	4npMWNG+HekcY6+1Y/qQany6CQ==
X-Google-Smtp-Source: AGHT+IFdnWcE5OCkLq5I23/aMNUrUVXosxGJSO3P3npmsZQ7voNg2SgvIeJec54h0J1grzWAABNwoA==
X-Received: by 2002:a17:906:897:b0:9e4:b664:baa8 with SMTP id n23-20020a170906089700b009e4b664baa8mr2090996eje.7.1702030433745;
        Fri, 08 Dec 2023 02:13:53 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id wi6-20020a170906fd4600b00a1cd9151af6sm814044ejb.210.2023.12.08.02.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 02:13:53 -0800 (PST)
Date: Fri, 8 Dec 2023 11:13:51 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: David Wei <dw@davidwei.uk>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 0/3] netdevsim: link and forward skbs between
Message-ID: <ZXLsX0/n2r6sUorb@nanopsycho>
References: <20231207172117.3671183-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207172117.3671183-1-dw@davidwei.uk>

"netdevsim: link and forward skbs between"
I think it there something wrong with your email client, cutting
subjects like this (all of them).

Thu, Dec 07, 2023 at 06:21:14PM CET, dw@davidwei.uk wrote:
>This patchset adds the ability to link two netdevsim ports together and
>forward skbs between them, similar to veth. The goal is to use netdevsim
>for testing features e.g. zero copy Rx using io_uring.
>
>This feature was tested locally on QEMU, and a selftest is included.
>
>David Wei (3):
>  netdevsim: allow two netdevsim ports to be connected
>  netdevsim: forward skbs from one connected port to another
>  netdevsim: add selftest for forwarding skb between connected ports
>
> drivers/net/netdevsim/bus.c                   |  10 ++
> drivers/net/netdevsim/dev.c                   |  97 +++++++++++++++
> drivers/net/netdevsim/netdev.c                |  25 +++-
> drivers/net/netdevsim/netdevsim.h             |   3 +
> .../drivers/net/netdevsim/forward.sh          | 111 ++++++++++++++++++
> 5 files changed, 241 insertions(+), 5 deletions(-)
> create mode 100755 tools/testing/selftests/drivers/net/netdevsim/forward.sh
>
>-- 
>2.39.3
>
>

