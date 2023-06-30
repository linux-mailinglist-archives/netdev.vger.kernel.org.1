Return-Path: <netdev+bounces-14786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D41743CF0
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 15:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A7DD281100
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 13:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC1B156D2;
	Fri, 30 Jun 2023 13:41:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF986156D0
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 13:41:08 +0000 (UTC)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5271FE8
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 06:41:07 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1b8171718a1so14181995ad.2
        for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 06:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688132467; x=1690724467;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2cSj7+SKvm+HZljgLkJO28h0UXat1DVlQlcLXRYXznU=;
        b=IM5xCfohhl9OGJ/43JvqfZYAOJZj557C2PV+Tc6CNEyJsNfzm50Yx+ev3eywYeLiY3
         Zb0GcF/Vn/UNZZKBO/iwoXhx8i4VB3gHZK6rhS5KyzKuxJn8Apui5mqHSqVWeuBEVjoA
         UgxVTrFYO12KbVK3TeOg1RdAA+yGz5jFtt73BzFzyqJj/pK/c3lXmboYpouqJeb5QQRE
         BAW5oKdpo+zmxLV+OKOm2GIvSiYVC5bakQl6tPsUklcJ5ZZsJ3r0lvjMGlOprIyrdHVs
         VfETTSHovJu7CLjwd5Gi2KAGEJYcq+5s2Y2/zqmA4GT90tktw712Nlv4rdqlT+wW4EEj
         3z7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688132467; x=1690724467;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2cSj7+SKvm+HZljgLkJO28h0UXat1DVlQlcLXRYXznU=;
        b=b0kGdizTkO7BBHZ1BhajnNejLCfwv0xTbltu6yB3Z1LpAwsjePekAtxrh+7GFq2wJj
         Rc7cS42ifPGQtepMcERxP99Pn1s1N/prRZlhLCuQbffZ/2NmKMaYe08YQXjy+WASfITL
         TV9YYz6eKNY/YgnHx3X6T4iO6lcGXM3/uovafojjnc6/KURD784AFJuJcwmPpDaA9cSf
         r6/KDlTo5iWgV91MDMyHug3YRehs6nGzm904r3yUYIZ5EYj27IPDt+SlZv0zTJxBUiPx
         qd6kR0SK1cTGGyZ7T+nojM8DhgN8atgwORsTcpFQi2Yfe9fP8X2SDJjSwTX0txmafHu2
         j0tQ==
X-Gm-Message-State: ABy/qLYXWtd56IGSlfnQXRG2///wbYlt83alRHQ/82ev/IpxikO6uUWm
	2puR9ge8QiHkP4hFoLHnpOZu5G0F32tUnQ==
X-Google-Smtp-Source: APBJJlHuQbk+hl+6iWEGzWpfagLwCwm7KfSDo8plHj2dz2Dzs5nCEnf4gPOstgpbpFiPrVg+mgpLBQ==
X-Received: by 2002:a17:903:22c7:b0:1b6:6985:ff8d with SMTP id y7-20020a17090322c700b001b66985ff8dmr2526298plg.42.1688132466949;
        Fri, 30 Jun 2023 06:41:06 -0700 (PDT)
Received: from [192.168.0.103] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id f7-20020a170902ab8700b001b03f208323sm10822168plr.64.2023.06.30.06.41.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jun 2023 06:41:06 -0700 (PDT)
Message-ID: <d5e0c840-f4ea-d44f-803c-fe97c481759b@gmail.com>
Date: Fri, 30 Jun 2023 20:40:57 +0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Bug Report with kernel 6.3.5
Content-Language: en-US
To: Martin Zaharinov <micron10@gmail.com>
Cc: netdev <netdev@vger.kernel.org>, Eric Dumazet <edumazet@google.com>,
 Linux Regressions <regressions@lists.linux.dev>
References: <20F611B6-2C76-4BD3-852D-8828D27F88EC@gmail.com>
 <ZHwkQcouxweYYhTX@debian.me> <ZJ1rC8WieLkJLHFl@debian.me>
 <F8555BEF-15B3-4CFF-8156-D5B1D6C24736@gmail.com>
From: Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <F8555BEF-15B3-4CFF-8156-D5B1D6C24736@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 6/30/23 19:42, Martin Zaharinov wrote:
> Hi Bagas,
> 
> Close for now , if i collect new info will update here .
> 

I repeat from my previous email:

Can you clearly describe your regression? And your nginx setup? And most
importantly, can you please bisect between v6.2 and v6.3 to find the
culprit? Can you also check the mainline?

Sorry if I have to cut down the context because you top-posted.
I didn't know what context you were referring to in that case.

Bye!

-- 
An old man doll... just what I always wanted! - Clara


