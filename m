Return-Path: <netdev+bounces-42835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C29EE7D05B9
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 02:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 633F6B20BF2
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 00:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B248319D;
	Fri, 20 Oct 2023 00:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Z8c2oT9A"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0E4191
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 00:15:59 +0000 (UTC)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40446131
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 17:15:57 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6ce2cf67be2so187064a34.2
        for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 17:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697760956; x=1698365756; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KCVrvRoy4SGPWE20sLca2ThSQwQI5qn6X68QgvLEZPo=;
        b=Z8c2oT9ABdXS4JFpoFEZXMc5FLveIg5FD1kmw/RtiibToeWIBu5R53AjQYfm7xMfap
         uDQPfXMeufg3Z7xV1ZfPji8+K3NFQsuMz6tFzL8Nhey0UkkLOd9iMnBVeiTCcEpyu/IX
         AQS2Bo628GnAj+2mDbiL0d8lDG/zDwg41Ca+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697760956; x=1698365756;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KCVrvRoy4SGPWE20sLca2ThSQwQI5qn6X68QgvLEZPo=;
        b=eDP0KrCsRt8D894xTBDTrB8JbkU4ToIMr7/y5yX44vsqZq80d7sy32jjDoePhWwcaR
         Bj/fxqc2pGu/d6H24moG/ufX7IeojKpTCm6TkzJNwMU60jnn9M5k3CmoCiCQa+t6Hp/A
         sv4Tz491bJtLENc5aJQtkeUsjVTE7t/E6KVkuST+UWV9VqD55GlkKJ87XFuMand/zR/P
         uI/abHnoeWhl2mxL1uUeqvKeBLTlPoXwCuUECl+fXy0cW8ZDPa3+H398FFOLfDjqmwbu
         KGDw7pyqN5QVsK31satyf2ZbpI3mQtWlOAWaSbUg/8m9XDPib2qQvZCvcBEF/WhibhEt
         PFdw==
X-Gm-Message-State: AOJu0Yyce1D6JXOHInYxgb9vE8/6VQ9Fd8auaUnV92OCs3UcMUVBeL45
	qdVbP7L6eFKUMXvfAwOuJiymCw==
X-Google-Smtp-Source: AGHT+IEHLvazYVGD5+oh4u6xlbwXIAQEvzEsnULcGkmSyGkZHb+qUhJKu+91HBvjlkfySxvWpaKNQw==
X-Received: by 2002:a05:6830:2b23:b0:6be:fe1e:c13 with SMTP id l35-20020a0568302b2300b006befe1e0c13mr503343otv.0.1697760956577;
        Thu, 19 Oct 2023 17:15:56 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x11-20020aa78f0b000000b00690fe1c928csm351482pfr.147.2023.10.19.17.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 17:15:55 -0700 (PDT)
Date: Thu, 19 Oct 2023 17:15:55 -0700
From: Kees Cook <keescook@chromium.org>
To: Stephan Gerhold <stephan@gerhold.net>
Cc: Justin Stitt <justinstitt@google.com>,
	Loic Poulain <loic.poulain@linaro.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] net: wwan: replace deprecated strncpy with strscpy_pad
Message-ID: <202310191715.5436893DD0@keescook>
References: <20231018-strncpy-drivers-net-wwan-rpmsg_wwan_ctrl-c-v1-1-4e343270373a@google.com>
 <202310182232.A569D262@keescook>
 <ZTExfv2aHPD2B1ze@gerhold.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTExfv2aHPD2B1ze@gerhold.net>

On Thu, Oct 19, 2023 at 03:39:10PM +0200, Stephan Gerhold wrote:
> Hm, strscpy_pad() is neither a typical compiler builtin nor an inline
> function, so my naive assumption would be that this could only be
> optimized away with LTO?

Oops, yes, my mistake. I'm too used to the other fortified helpers that
are inlined...

-- 
Kees Cook

