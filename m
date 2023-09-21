Return-Path: <netdev+bounces-35499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B2A7A9C90
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 21:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90984B22E41
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 19:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A000A499AF;
	Thu, 21 Sep 2023 17:50:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE10E49986
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 17:49:59 +0000 (UTC)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD624F39F;
	Thu, 21 Sep 2023 10:49:15 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-690bc3f82a7so1174768b3a.0;
        Thu, 21 Sep 2023 10:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695318554; x=1695923354; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W2wfV/E+fvJQFqOd9U3s9nuYGhY7TXlGuTmZ5ygRn+8=;
        b=a2DDzy2Hn6fyIB8+uAex48RezFQZAFdSV1hKWQz7++mBCS9m7wwx8uQz5PQgF/A3sG
         xFNd21SWNhFR8/xJUKet4qbglN1BWSZC+0tAqtnwScaAMcdQudU3uH+aLrpXxfFQ4k6g
         a3ZiroInKBQV+MdP6hs3qYYrGcoZX0mjwk2QTeUOws8/WGZufMwwVo4zf0Iu+sru94VV
         S4Ar5Ph1kX+mJUHQXSNj+TQBm205MAES6Bnj6fYk57jg91RxP3yop8oKwrTn4T1dbQJ4
         WWDQM9xNX3OwwjGgR+7sg8z2829mPyEPYiTkPUxOLWp6Qf1RDvG8tRXeWymQS4I6SJ1G
         1PNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695318554; x=1695923354;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W2wfV/E+fvJQFqOd9U3s9nuYGhY7TXlGuTmZ5ygRn+8=;
        b=A6wo9wgNfNZryBNOt+LWcdmdoPKv+EaNAD6oWHAn2I6fjeut0PoFue00vzhIWLE6ga
         vSPkJIVVsaHuL8GKCnOsyNmYqUlVv2LCsygtbHYV1YHcB7O1imAMBpdZu7UpuYRc9mGT
         tMk3Fl8kDWpFARZuk2qVSqF4rczqDBLkGHd3j56lRYMAEWjNwPq2cOw+7HxQRwuMs3lY
         Uck65v+gGMWIrS5EalcR/0lbPzpeeRp7rYLd+tFXyQsHjxjKCN/AgBoBVLVjaNBEzZ+B
         CZFZEqvtv1cmy/p1b5fvZhvEHM9G3GHZmAI26jXGMISo8JhKS+wa9+Flm8d+AThqd/Sl
         Ilog==
X-Gm-Message-State: AOJu0YzPofDCqAXHnvtqYL7xH1lwPOO9mtxvt8S1IGM4+8byDghZ9Kfd
	k6OXTUuYtm3ERlSYTtalW6U=
X-Google-Smtp-Source: AGHT+IFN5Qo3S/gdKI6RmUoa7YqqeNvU1hWE9nakU7LnRUBc6U0ZDuU9E4v7k6zRTh6J6kMRfLaI/g==
X-Received: by 2002:a05:6a00:b45:b0:68f:b72f:9aca with SMTP id p5-20020a056a000b4500b0068fb72f9acamr6785120pfo.27.1695318554312;
        Thu, 21 Sep 2023 10:49:14 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id j1-20020aa783c1000000b006675c242548sm1660426pfn.182.2023.09.21.10.49.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Sep 2023 10:49:13 -0700 (PDT)
Message-ID: <96ef7250-d382-095c-495b-836d5c61ab31@gmail.com>
Date: Thu, 21 Sep 2023 10:49:11 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v5 net-next 2/5] net: dsa: notify drivers of MAC address
 changes on user ports
Content-Language: en-US
To: Lukasz Majewski <lukma@denx.de>, Tristram.Ha@microchip.com,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew@lunn.ch>,
 davem@davemloft.net, Woojung Huh <woojung.huh@microchip.com>,
 Vladimir Oltean <olteanv@gmail.com>, Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Vladimir Oltean <vladimir.oltean@nxp.com>
References: <20230920114343.1979843-1-lukma@denx.de>
 <20230920114343.1979843-3-lukma@denx.de>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230920114343.1979843-3-lukma@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/20/23 04:43, Lukasz Majewski wrote:
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> In some cases, drivers may need to veto the changing of a MAC address on
> a user port. Such is the case with KSZ9477 when it offloads a HSR device,
> because it programs the MAC address of multiple ports to a shared
> hardware register. Those ports need to have equal MAC addresses for the
> lifetime of the HSR offload.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Signed-off-by: Lukasz Majewski <lukma@denx.de>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


