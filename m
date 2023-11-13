Return-Path: <netdev+bounces-47310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D737E9945
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 10:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89F921C20749
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 09:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34EDE1A584;
	Mon, 13 Nov 2023 09:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="c3X7QEao"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20051A587
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 09:43:59 +0000 (UTC)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F90F10D0
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 01:43:58 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-3b2df2fb611so2936363b6e.0
        for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 01:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1699868638; x=1700473438; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TFG36dpLQW1X0p8H6l/PAL+BQonLtLV01da6RIp3rJw=;
        b=c3X7QEao2ErqsCTtcyCNdBhsQPWRJ/IKDocw7/frbjiy8BEfNxS56dODc2iHBC+dFV
         xGH4+moKAsi7p0SBfzYiZghX5cj3ynvIbaTcsWYD6kRNI7FNweYKi4OePnPPxbbDX3/K
         9mg5sdfUx1aXXNP/FGOMgDFyZ3VXJLtD6iFBPEfL35TrboFU2AIEiIiRfJdh/AgKf33y
         G+QqdkyzufFKTTQFnQ/vtzizELwmzcTENWHOKyvPDUsQSv8+FYl1G4693ia2l6AlIOxd
         FvmzP7qsBKFg4KMnVpQoGVuqlEFC76o0I03pJO6uVW2UyYs84sQMYAUnZhaxz1m98WJj
         9CEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699868638; x=1700473438;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TFG36dpLQW1X0p8H6l/PAL+BQonLtLV01da6RIp3rJw=;
        b=Ic9UtMfTWwB/IyRcHNd0EOmet8v7uzubQ6CWyB7NhLJpHMeq6y0uHUd8o1Ex/KPxuE
         BLMzbob6GgHg5B4YQFpk3yZiSp03iRXHgrW7F4ZsTFBXv0IP+4127fqsO0fuIyT6yZBU
         08noChSVVJw23E6TutzWKOqchqILKkBXjdpvRA1xJOP7KxcKY8kFgohpg1n+9c4XUFCw
         atl0jQFdomHX4dcPJCww/yBOsZPWAOJQ3h2soKf6TWYhF8GVWDxmQ0igpaKfGdcL7lXa
         knwHvi9+EotJPpxNfmcOR9RuAlcAJiKTMmNuH93nolet44gY+TE/Ip+sndByGLOGD1c7
         D3Iw==
X-Gm-Message-State: AOJu0YxKSNkC4tTg64w+y9SZOxJPwaTjYezJF7N9yT+3ksjYjWwLwB8Q
	+Mvi2wEXhf6yhGRADGYW9iWIyA==
X-Google-Smtp-Source: AGHT+IF+8WOPWkXwOVzLtzfnkGAbwTGwCsi7Bqz9H/urAABMK58DWn0QEjmzsW58gSGW953RGwjknw==
X-Received: by 2002:a05:6871:783:b0:1ea:2d58:46e3 with SMTP id o3-20020a056871078300b001ea2d5846e3mr9596617oap.33.1699868637986;
        Mon, 13 Nov 2023 01:43:57 -0800 (PST)
Received: from [192.168.0.106] (starletless.turnabout.volia.net. [93.73.214.90])
        by smtp.gmail.com with ESMTPSA id k20-20020a0568301bf400b006ce1f9c62a1sm755599otb.39.2023.11.13.01.43.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Nov 2023 01:43:57 -0800 (PST)
Message-ID: <84ed6b26-3b08-de4c-48f9-9517b49b23f5@blackwall.org>
Date: Mon, 13 Nov 2023 11:43:51 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [RFC PATCHv3 net-next 00/10] Doc: update bridge doc
Content-Language: en-US
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Ido Schimmel <idosch@idosch.org>, Roopa Prabhu <roopa@nvidia.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Florian Westphal <fw@strlen.de>, Andrew Lunn <andrew@lunn.ch>,
 Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
 <olteanv@gmail.com>, Jiri Pirko <jiri@resnulli.us>
References: <20231110101548.1900519-1-liuhangbin@gmail.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231110101548.1900519-1-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/10/23 12:15, Hangbin Liu wrote:
> The current bridge kernel doc is too old. It only pointed to the
> linuxfoundation wiki page which lacks of the new features.
> 
> Here let's start the new bridge document and put all the bridge info
> so new developers and users could catch up the last bridge status soon.
> 
> Something I'd like to do in the future:
>    - add iproute2 cmd examples for each feature
> 
> v3:
> - Update netfilter part (Florian Westphal)
> - Break the one large patch in to multiparts for easy reviewing. Please tell
>    me if I break it too much.. (Nikolay Aleksandro)
> - Update the description of each enum and doc (Nikolay Aleksandro)

Aleksandrov :)

