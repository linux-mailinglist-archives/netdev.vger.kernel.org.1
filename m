Return-Path: <netdev+bounces-34808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 849BF7A54D2
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 23:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 950301C2121D
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 21:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF4E2AB29;
	Mon, 18 Sep 2023 20:54:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FEF2AB39
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 20:54:00 +0000 (UTC)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA63B111
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 13:53:59 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-6563e4defedso16464756d6.0
        for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 13:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695070439; x=1695675239; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bK3tn5dFdIkaJdHv4A/3xeAMl/PHN2x+YLc9iStXbls=;
        b=j8y641jxwjPhhyKRTfNtZoF0pcJMia9kdXQi/aNjjVUr+Rt5E/W69eyg0w8FUhL4KU
         ntDQCstHZnq807lw06Mq9iFq6CPJIC7rMmTeN2aNbjwvxYuaDFEOT4P+U6H4bfpTwxZF
         QZhpGBboxt6sST4+cVMtfAgI4vLXR84lzRdIZ3bSdUy+ntiZTzUJnZHm6+zTChW2nWMF
         z1Hav+bhHFnwZLs/lc0iDLw6h9/sZi6Emn2elGeCGfEn7O8ANRbdicdYOs6FdVicHqvI
         D2+/ko0serIVlDE0ujpB+ZTraP76rUeERjSETn/WpbIfURjeolSXhVOAE1aaPsaxIAK0
         7SqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695070439; x=1695675239;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bK3tn5dFdIkaJdHv4A/3xeAMl/PHN2x+YLc9iStXbls=;
        b=PI0jPpI7J2pVPeWGkicPp0DhZ1HOwcr4IMvbb33NXi4tAE0rESsZjR8zQxeGDrLHZQ
         P2m6YrzXj9pvna2FowOFyJo7OAeXADhkdmXerT85GmZ+HN12Av0Y2jZw3PR6BxUU0IlN
         R4Ft0JlPuzgdrY3/4Naq12alcQiQb1pWj3a24iFeq02rmhXhEfpk8iOLGh92rkNTbxrs
         oBFmzSsYSLsA0DgH2XknTn8We88PHsxq9spLjgAkR8PCoLrfFkoZ+ItQOcvtCQvPq6yq
         zMxgGDWZ6UTVbQLWPSXYJ6Ysy8qNVQnc+rrtxIblSFCXyrPYCFti1XwaLrQEK8jr03mi
         yB7g==
X-Gm-Message-State: AOJu0Yw5r6prd+rdmX6h8L+bfKNYklWKYb47Tac2Ic7gIZXyXNxVo67x
	UoZxxrpJxrtT2YJUSITgougOD/ajESjHQw==
X-Google-Smtp-Source: AGHT+IFygmnPIP2yVrs7xjNflHgtyLnxdpzKrWJNMp30i+DGTj18aRtA66bBse7I75JazmHoS/ipJQ==
X-Received: by 2002:ad4:5a13:0:b0:64a:92e9:10e4 with SMTP id ei19-20020ad45a13000000b0064a92e910e4mr8979495qvb.63.1695070438726;
        Mon, 18 Sep 2023 13:53:58 -0700 (PDT)
Received: from [10.67.49.139] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id w5-20020a0cdf85000000b006584984f3dfsm193520qvl.26.2023.09.18.13.53.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 13:53:58 -0700 (PDT)
Message-ID: <4481c437-3d78-0ae9-d2ce-c12de09c1a98@gmail.com>
Date: Mon, 18 Sep 2023 13:53:55 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH net-next 9/9] net: dsa: vitesse-vsc73xx: Convert to
 platform remove callback returning void
Content-Language: en-US
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, kernel@pengutronix.de
References: <20230918191916.1299418-1-u.kleine-koenig@pengutronix.de>
 <20230918191916.1299418-10-u.kleine-koenig@pengutronix.de>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230918191916.1299418-10-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/18/23 12:19, Uwe Kleine-König wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new() which already returns void. Eventually after all drivers
> are converted, .remove_new() is renamed to .remove().
> 
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


