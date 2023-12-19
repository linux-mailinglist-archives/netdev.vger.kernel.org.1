Return-Path: <netdev+bounces-58743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED895817F2E
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 02:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C5F11F230BB
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 01:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9319410EF;
	Tue, 19 Dec 2023 01:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OSyXQljj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3814410E4
	for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 01:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-5e248b40c97so32322967b3.2
        for <netdev@vger.kernel.org>; Mon, 18 Dec 2023 17:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702948466; x=1703553266; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xtAVnekgmhwpqTIome4g6Wn7kowfqPy/ZN5t6l1+xV8=;
        b=OSyXQljj+AN6MnNjCerL1o6y9VANyuCtRQy8JVY2UqH1elVXK8zZC4fOnKyo9ADxwf
         GtCFEIOJMlnuLvrURLvJN0BGgXG8F/fuGVtt6FQE2wUwGCJbroDItEStsVO3ySmOzpQT
         KlD7AzXfcWQfnZIBJqdrAYlTnjlpMK68azZzrF9AW1QnqSSEXizGZKb+iYnB6i8u5i95
         l6+TOpylFkdJ7I1Pw+Fx0GSnu8iyGDXmRY5jA9DBZRJO3N5jddQbPabYJqlk0T4zRDma
         piBLxw7Qgfv3nfar2zyMHW4EWH8dsigIpz1LEnKn6yQrjdmmhe2Z4I4/+62H6UZrtCuF
         4/sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702948466; x=1703553266;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xtAVnekgmhwpqTIome4g6Wn7kowfqPy/ZN5t6l1+xV8=;
        b=kulE28YUM4FdeVaf+yXgrPJIJAYOXhFfxDh80Hq/3bwMzguwfvtCSYKEokrWF81C6u
         sB3sCojr0KfG5QizOYPFuRMYz7NAY1iFhzQ6niq600gCd30055ib+wINio8v+yHjJOhL
         gHj9J/dIsdOBI4GPzgP4MJX65/aK8Oegef0ilw5Ba3n6beEXg+UaoGSn74lQeTw7C78u
         p+cMbT91t+YHbHPYvJeD4pmdkljWUL5Xiel6duBpyBXJta5wDZPE/T79tiUmA8P3b7xf
         K/BUo5e9q5eJRaTD0WNvtgAgGoIW8y3IJjjOOOG8yN9txor0lEe/V01wpXQ3k6iXVEmW
         VHpw==
X-Gm-Message-State: AOJu0YyUf3P7exKOqdZmmEEjh46lVa8exPOGpWqKMAaN884EbY65sfp4
	L/k9MEhTvKvy8QAm9w+M4eb5Am0kIJE=
X-Google-Smtp-Source: AGHT+IG7/kEDmBbiTLZocLu0aOm5yVzAsXRtrUg0rzKcOjSNVE629CETeHDGc6IYABXRWaxnO8Zonw==
X-Received: by 2002:a0d:dc81:0:b0:5d7:1940:f3d6 with SMTP id f123-20020a0ddc81000000b005d71940f3d6mr13482928ywe.62.1702948466044;
        Mon, 18 Dec 2023 17:14:26 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:e84:899c:4b9b:a70e? ([2600:1700:6cf8:1240:e84:899c:4b9b:a70e])
        by smtp.gmail.com with ESMTPSA id eq17-20020a05690c2d1100b005e181bc7d2esm6316631ywb.54.2023.12.18.17.14.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 17:14:25 -0800 (PST)
Message-ID: <a289e845-f244-48a4-ba75-34ce027c0de4@gmail.com>
Date: Mon, 18 Dec 2023 17:14:24 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/ipv6: Revert remove expired routes with a
 separated list of routes
Content-Language: en-US
To: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org
Cc: edumazet@google.com, Kui-Feng Lee <thinker.li@gmail.com>
References: <20231217185505.22867-1-dsahern@kernel.org>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <20231217185505.22867-1-dsahern@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/17/23 10:55, David Ahern wrote:
> Revert the remainder of 5a08d0065a915 which added a warn on if a fib
> entry is still on the gc_link list, and then revert  all of the commit
> in the Fixes tag. The commit has some race conditions given how expires
> is managed on a fib6_info in relation to timer start, adding the entry
> to the gc list and setting the timer value leading to UAF. Revert
> the commit and try again in a later release.

May I know what your concerns are about the patch I provided?
Even I try it again later, I still need to know what I miss and should
address.

