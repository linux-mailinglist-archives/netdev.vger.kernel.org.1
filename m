Return-Path: <netdev+bounces-38464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C047BB0AD
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 06:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C69C31C2093E
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 04:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8732187D;
	Fri,  6 Oct 2023 04:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rr70CsHt"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8669C629
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 04:07:42 +0000 (UTC)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2646E8
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 21:07:38 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-4056ce55e7eso15252335e9.2
        for <netdev@vger.kernel.org>; Thu, 05 Oct 2023 21:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696565257; x=1697170057; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SfmJdBPydu0BZJi6LE/RTqA11QEqZm0bT62TNJwMfLU=;
        b=rr70CsHtSYjU0JhuGFjffW8UqdVt7tisVHvQjKqRBq0ngNi2560ND07JBb+qwjAHuZ
         FTyXL1EfPNruFYt1199hZkF3Pc42WhFfSp8pFKkrg5ZauTM2rfd/H++JJ3JQnXfwM+85
         qfwUlLdsK96KiJn86HWiKTihhbNswz6n9ecgKERdqi/5UyFq8+6VigFSl+ajV1Alm2Zb
         ndm76/3PMRJc9uosUdccTwV4XMJw4hEhnYr9TkNoR04ixKiektOVp30QIxprJN7/7ojQ
         gFyqEPNYJCe1DVexm+scSgh7JUQZaQM2FeX9IKBF12mkqO82yEX0RHTWhBJzmYWvHgzK
         nPqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696565257; x=1697170057;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SfmJdBPydu0BZJi6LE/RTqA11QEqZm0bT62TNJwMfLU=;
        b=PRWwTslxG8CN+w4oxrm13HHMIxI6QWTZQDr6sTcEZXHhsQMfqbsYGyN74Pz0GSWnqr
         33SKlMCgIk/Bk+RlrKlyzf1oBmojlt30wA75B18rWY8bFaTyzTxzOsvKw4HjzAgijxUA
         TpS2Rz1SwPx9PxNTihT6BBp+6G4wr3eq7gTSuvGb+B/lWLvMYJDp4ZoD3zbAueUc+UOi
         SCRsy5jOeFDXMVWC4cAAKrIXpinCpSJOaY/T/LE4Z6looSJb7/8Q0EG1WxUjX6NE2urK
         7nEUErehgQN31lAQ3DImgNUnZk4S5EPMCQ2ff4xRQMoil6vFQDH1KIEDbiw/U7l2sF/R
         11sQ==
X-Gm-Message-State: AOJu0YyP4+I60jLDXtdeRPAGhQsKQRp2w5MRT8dini6Pc5Hkn4ixTy8c
	e+ic3FHv8y55fFacWEwmKQLhQw==
X-Google-Smtp-Source: AGHT+IFjeXrQUs7p/saYuWWFYACMu2/fI8dWiPv6wIANSyumueY5p9GrWNrq8I5Iy/tR2cn2JV/ZzQ==
X-Received: by 2002:a05:600c:2117:b0:402:f55c:faee with SMTP id u23-20020a05600c211700b00402f55cfaeemr5918406wml.26.1696565257030;
        Thu, 05 Oct 2023 21:07:37 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id s26-20020a7bc39a000000b004064cd71aa8sm2784785wmj.34.2023.10.05.21.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 21:07:36 -0700 (PDT)
Date: Fri, 6 Oct 2023 07:07:34 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Alexander Aring <aahringo@redhat.com>
Cc: Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Angus Chen <angus.chen@jaguarmicro.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Joel Granados <joel.granados@gmail.com>, linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net] 6lowpan: fix double free in lowpan_frag_rcv()
Message-ID: <e438fc67-665a-48b6-b414-0641821e0bf3@kadam.mountain>
References: <3c91e145-5cd5-4d9d-9590-3b74b811436a@moroto.mountain>
 <CAK-6q+iG=jX0qudCcszP64HxCwYSpmx7=Fh+Kf3qVft7Z8hBfg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK-6q+iG=jX0qudCcszP64HxCwYSpmx7=Fh+Kf3qVft7Z8hBfg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 05, 2023 at 06:10:13PM -0400, Alexander Aring wrote:
> Hi,
> 
> On Wed, Oct 4, 2023 at 5:22 AM Dan Carpenter <dan.carpenter@linaro.org> wrote:
> >
> > The skb() is freed by the caller in lowpan_invoke_rx_handlers() so this
> > free is a double free.
> >
> 
> lowpan_frag_rcv() does not call lowpan_invoke_rx_handlers(), it calls
> lowpan_invoke_frag_rx_handlers(), or is there something I overlooked
> here?

Actually now that I look at it more closely this isn't a bug.

The way I was looking at it was that it was the other way around.
lowpan_invoke_rx_handlers() is the caller.  But actually this returns
-1.  lowpan_invoke_rx_handlers() will pass the freed skb to
lowpan_rx_handlers_result() but the -1 gets translated to RX_DROP in
lowpan_rx_h_frag() then it just returns NET_RX_DROP.  It's a no-op and
not a double free.

Sorry!

regards,
dan carpenter


