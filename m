Return-Path: <netdev+bounces-30561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D95178803A
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 08:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E6A728173D
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 06:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2653817F4;
	Fri, 25 Aug 2023 06:48:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1862417EA
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 06:48:23 +0000 (UTC)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28CE51FF3
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 23:48:20 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-52713d2c606so829474a12.2
        for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 23:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692946098; x=1693550898;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G8i2MFIt9PPqdiA+U5wmi4xH4F0pC3lElXMemaJZn+M=;
        b=nYrg8AojLgKfBTJR0zhZr48566By9omWhYw+Kq3sOrzLq7icKWhoJcL/6LFJZdho5P
         sTIgp1gksE0/7K8CBOD0yspGPqVaowW/RZCzLgpOe8mKEzaPf4XDHW58TXJ9mq+lAbo3
         itRxQz1VmH49t0gl+8z+5Km2lSeX4EDLdu5wLqhVVxnjleSC8k5mXrrP27RJI+wSmuzk
         AGVugAE5E4PpVyz6cV/MNJTi2T2p8UGumpZpbfcW0kl+tFlVJBr/jpZxh3xksHfQ/cLf
         YoNTbblSaYtDwJ7R7r9npyNWgJylAEeY7YnGlX7KNktnehBuPMqOMTwTD9+k3N8tVY/Y
         PaVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692946098; x=1693550898;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G8i2MFIt9PPqdiA+U5wmi4xH4F0pC3lElXMemaJZn+M=;
        b=Tf71Lvd96OW6OKZGGf4cDJCe0IAaoAzFLHzllb9lrOKFUIjlWWLb9npO62nD+9uLnA
         nJeCYUKtemg7eBcAPgTJHpyIxbchGNE6rWWT5LOnaXc0uX3AHll2sVg8tHDILpfWwJCy
         15LXpalP5vfM7SbUDC6uVXIH6Tu2lxYjYrDUjZGlBzmo6fxSf4wNrfx9kZ8EDD7eQ3R/
         Kn6BJkJ8B3wMi4PlZArlGmRjfNKgFjeC23y0y2fOyngGnikr+iKGYkvh4KT+11x3iUfz
         DuQ9NzSMXj9dXFSldSl4B9jStGjvP21jwE1Vhmcx6b9SKt5KyLa8Po/szF5v5EBcdica
         DYMQ==
X-Gm-Message-State: AOJu0YyBg5+OEl4tLb2Qsa3DQG/P47hu1uhKRJXbYRTe1BbJa6DXIFX8
	1NU5I8Rj5OKHnoM8dipTn06AkQ==
X-Google-Smtp-Source: AGHT+IG1z3CKEe9GDWj6KdXNBIZTtTn0My78Dw9qopv5OUPpIdAbGaSU1cOUD33d11NlsXOVgQFmIQ==
X-Received: by 2002:aa7:d996:0:b0:522:d6f4:c0eb with SMTP id u22-20020aa7d996000000b00522d6f4c0ebmr11753745eds.40.1692946098347;
        Thu, 24 Aug 2023 23:48:18 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id n25-20020a05640206d900b0052a1c0c859asm663682edy.59.2023.08.24.23.48.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Aug 2023 23:48:17 -0700 (PDT)
Message-ID: <f8a1391d-3716-04e5-7e36-fe670c75df4c@linaro.org>
Date: Fri, 25 Aug 2023 08:48:16 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 1/4] dt-bindings: mfd: syscon: Add compatibles for
 Loongson-1 syscon
Content-Language: en-US
To: Keguang Zhang <keguang.zhang@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>,
 Serge Semin <Sergey.Semin@baikalelectronics.ru>
References: <20230824125012.1040288-1-keguang.zhang@gmail.com>
 <20230824125012.1040288-2-keguang.zhang@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230824125012.1040288-2-keguang.zhang@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 24/08/2023 14:50, Keguang Zhang wrote:
> Add Loongson LS1B and LS1C compatibles for system controller.
> 
> Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


