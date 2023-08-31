Return-Path: <netdev+bounces-31573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E81878ED7F
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 14:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CDE228151E
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 12:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA09111BB;
	Thu, 31 Aug 2023 12:43:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DECC7481
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 12:43:34 +0000 (UTC)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0193B1A4
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 05:43:33 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-31c8321c48fso1265912f8f.1
        for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 05:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1693485811; x=1694090611; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4K0TRbH7mKwqqmCAnv3nE2x+L9tIpzKBjNM6cCs2Tlk=;
        b=TiP3zHXhF4VGpjLnPpD9cPuI4kL+IIPVAH5S5jatAI4LUdDZnoGbv71b06KQESXgdX
         43mtzrkR5eYSbTng2SNKa/ZN5+5syVpqsvs2prGnccCH45pRu3TEgcastOu9ykLI9Wqg
         Ol0D/T/F/juUrMxBzurEk2u/x4+oMVK4RstiCD63CTh0SoJt6Rzosb28g4oEpXUEEJmN
         tdv0K0u9xyiigilozbftDJMeVLwjR/fpRvG7hS10hc5TrsYZPH0FdZrrmIcoRQEcAo+x
         Xlx47FA77QBRUZB/XQUTSAZV8c0jRxEJjVs0AR3E8VyB9YoMsw2LbZofIFti1jqtKqX+
         01/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693485811; x=1694090611;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4K0TRbH7mKwqqmCAnv3nE2x+L9tIpzKBjNM6cCs2Tlk=;
        b=CceRYxG8EcdYo/LmVr/47W9gHVl7a1VjSvT9m5zVAIEx4ehrZQtlJWst+od3F87YsL
         RGl30hjEyTCqB4BmJ0NnwfBo8OKj9TMm/CrmQChm7VYAozG0zgDAV/3qHCkDDQqaCJWY
         7DnhCeCoMVzoKOpr8RBcf/p2yIegZSONdKarR5z+X/l4Q1YxFI7r2Gy3sU+AY+5gmav/
         4oJ9scekKcF0rJFgAEcA0CKBJ8yrNEpeD4Z8YUank6DBS19Jq3unWQXST8qyRhCIzuG0
         DkCGNy8fOaBjwJ4kcmJKdTXk8ClmU+TLUYcXM2vkZocX+OtEi+JEA9nmL5fnWqeODl//
         temw==
X-Gm-Message-State: AOJu0YyJImcAXP8SAElqxZ+5nURBFMu7BCSgh+ygwKwDUQonhV1oZXzX
	+KxXiExMVZoYxOSp/Bqx2pDhEA==
X-Google-Smtp-Source: AGHT+IHpZxF+1+/lL+xvf0lECdPrFbL8XhmaTCrkVMZvlQhMpC4+gu/OO18GdSnSQBf85KNGINnaQA==
X-Received: by 2002:a5d:544c:0:b0:319:70c8:6e90 with SMTP id w12-20020a5d544c000000b0031970c86e90mr1855187wrv.24.1693485811425;
        Thu, 31 Aug 2023 05:43:31 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:8ad8:2775:884a:f43f? ([2a01:e0a:b41:c160:8ad8:2775:884a:f43f])
        by smtp.gmail.com with ESMTPSA id o9-20020adfe809000000b003176c6e87b1sm2130694wrm.81.2023.08.31.05.43.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Aug 2023 05:43:30 -0700 (PDT)
Message-ID: <9a3317b3-c519-750e-710f-2567e1a5c508@6wind.com>
Date: Thu, 31 Aug 2023 14:43:30 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next v2] veth: Fixing transmit return status for
 dropped packets
Content-Language: en-US
To: Liang Chen <liangchen.linux@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org
References: <20230831121152.7264-1-liangchen.linux@gmail.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
In-Reply-To: <20230831121152.7264-1-liangchen.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Le 31/08/2023 à 14:11, Liang Chen a écrit :
> The veth_xmit function returns NETDEV_TX_OK even when packets are dropped.
> This behavior leads to incorrect calculations of statistics counts, as
> well as things like txq->trans_start updates.
> 
> Fixes: e314dbdc1c0d ("[NET]: Virtual ethernet device driver.")
> Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
> Reviewed-by: Eric Dumazet <edumazet@google.com>

This is a fix, the patch should target the 'net' tree, not the 'net-next' tree
(which is closed btw: https://patchwork.hopto.org/net-next.html).


Regards,
Nicolas

