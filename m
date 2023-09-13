Return-Path: <netdev+bounces-33505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9DFF79E471
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 12:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C633A1C20B15
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 10:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812CE28ED;
	Wed, 13 Sep 2023 09:59:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F25E57B
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 09:59:34 +0000 (UTC)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D205198C
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 02:59:33 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-31dd10c2b8bso6455160f8f.3
        for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 02:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1694599171; x=1695203971; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cIHzpzCAAkRP0kTOXEnbQ6ttMXWPKI7gqW76bWfWcHg=;
        b=AwKqFNGX80GvddeTC8g1e2Wq7vCyM8Oyb04w9avNYOeA9abh/RbyG5WB3yM1VpHzZ2
         K2sYjG3FrVU/sO3zR1x/U7Fb8ad6g4huPWKWM5L+g8+p8kQQrkipBqYQn9v4tuRi986c
         IDB+C+BP25yPbefGAYXxpd3UiwtoAHBWzYzjwC+Qx0eFmZCQJ2LFPjbEgsFFq7Hjh+uq
         HhZymuBdJt/SBHf9Ztu87BDhilDg5L/QSaG4AGQJD9tqlCQahWBSHXsj8yEyhldaw/zz
         8b4BGPJEUJ3CKgu0RD6p4u6QWnAVqwd9WxbJbXKqwtEf4/SAR8DbGxU3IIDu+fgVRUbO
         WXYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694599171; x=1695203971;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cIHzpzCAAkRP0kTOXEnbQ6ttMXWPKI7gqW76bWfWcHg=;
        b=fTf5oiYHIWi/P+eUnGWdvEExGce5H5QfmJgb+TmgMCV8SxnxomUSbq5IifeZ6oycNJ
         4sJY214nYDlmhx7xdkm+kjNkSaRDTkWjcV00nPDHcSRb2uEbamWNy/3esD3DEfUf/2md
         +11iMLV/lTi+h7/uItYmY0O+c3m2Cyg8DAbj2nENttZEreBpDsf6y6g/XBVyW6pfa8FO
         7jW9bTytvmmtNwpH9ubN3CLXU3c8CTJnn6+MKIPrG03WHaddJWec/FBVbQh3rKCiirNW
         CIH3hJz53qX3OI/MKLg9tZRxZqeYex8pJgH7jgYLkIb3lXu+KvMyzI9BOquNd6EQ3tWW
         DsXw==
X-Gm-Message-State: AOJu0YzNS6EhRGanHeqW77f0h64cvvMk3PlonNdSR0Oxy8OuagC63Oj5
	cIwYaZXUuaJV7v/udGHp6qlRYg==
X-Google-Smtp-Source: AGHT+IFgalfhLvJEf/a92dB+yvpLrGeUTxM2uSyZWtaB9t966x1556+DYpdeVlAilMkGTjHbtt3orA==
X-Received: by 2002:adf:cc8a:0:b0:31f:8e09:8f0 with SMTP id p10-20020adfcc8a000000b0031f8e0908f0mr1822785wrj.35.1694599171606;
        Wed, 13 Sep 2023 02:59:31 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:2210:4d5b:b108:14b3? ([2a01:e0a:b41:c160:2210:4d5b:b108:14b3])
        by smtp.gmail.com with ESMTPSA id y13-20020adffa4d000000b0031f5f0d0be0sm14955473wrr.31.2023.09.13.02.59.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 02:59:31 -0700 (PDT)
Message-ID: <68350d56-6c10-b246-0a44-1673b91a9f1a@6wind.com>
Date: Wed, 13 Sep 2023 11:59:30 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCHv2 net-next 2/2] ipv4/fib: send notify when delete source
 address routes
Content-Language: en-US
To: Hangbin Liu <liuhangbin@gmail.com>, Ido Schimmel <idosch@idosch.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Ido Schimmel <idosch@nvidia.com>, David Ahern <dsahern@kernel.org>,
 Benjamin Poirier <bpoirier@nvidia.com>, Thomas Haller <thaller@redhat.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Eric Dumazet <edumazet@google.com>
References: <20230809140234.3879929-1-liuhangbin@gmail.com>
 <20230809140234.3879929-3-liuhangbin@gmail.com> <ZNT9bPpuCLVY7nnP@shredder>
 <ZNt1wOCjqj/k/zAW@Laptop-X1> <ZOw7VIMulJLyU0QL@Laptop-X1>
 <8e539e610a7cb4d1cf31fa5e741eb111a3d2ca5b.camel@redhat.com>
 <ZP/NM14oQXAkr107@Laptop-X1>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
In-Reply-To: <ZP/NM14oQXAkr107@Laptop-X1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 12/09/2023 à 04:30, Hangbin Liu a écrit :
> Hi Ido,
> 
> Do you think if I should modify the patch description and re-post it?
At least, this patch seems to be targeted for net, not for net-next.


Regards,
Nicolas

