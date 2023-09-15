Return-Path: <netdev+bounces-34078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4E37A1FC6
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 15:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4036E280D46
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 13:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA33A10977;
	Fri, 15 Sep 2023 13:24:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECB4107BD
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 13:24:26 +0000 (UTC)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174172733
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 06:23:49 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9a64619d8fbso279546266b.0
        for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 06:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694784227; x=1695389027; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1U96v2df/GCS7HRvhdN4EdRezxa7IYKwHOpPeh6hRvI=;
        b=OX5/o2SfUDZzte6E2Fms4S38dZjkUlYBOY6m5IaZGBwMYwwhMXJ9JmYQ6qTTiGAHQS
         HxJIXd58R3JnsTtOF+HO6CcB5XZ2eeF/BbzD9TgS1UL5ZXYP+FtU5OkZHrsno96SBYjq
         4jhbXAfltQDyQwVDMfZoQx+PfRGO+boaGYzMlIrUMNKP6S5LbPp/xo+muxhG0R8Tte9Q
         sBBw48xHDDKkKyMr5DX/keWtZrknSdmL23SUyBnm1bs1fUo0IZgJmevyaJTiP7AX+GLO
         y5cfAKCzEQ/Zp++//J0RYC9Dx/AzJKGQJmsj1KTDOJwUh5Cs/q6yMUtLvNkFlOKeqtRS
         SMiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694784227; x=1695389027;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1U96v2df/GCS7HRvhdN4EdRezxa7IYKwHOpPeh6hRvI=;
        b=uf8tleK5jKDJw1Lhuj0DTzI6IbWyABA52o+fhPdPe5gVyIK+Qhj5C7nLdLTrP3Sq4C
         cTCkrEQKi7xRiURKUcaX0Fqq+k99SNlwsB1iRxuZSSGSmEA6CL3wCaYOh4+/IcnPuGYA
         QKj4gRLCKFT0tDbN8xX1Pwa45R7XdF0pjYsuunM7k9FK+tDOQRF2dpudalavKbpaP5KC
         w6lrkuJLqq9hL9GUu+jiPD201MF9njJdax81aZ65yDdmfUSWMyiV/foy9TnCwISNh7VQ
         305k95ZCndlWZxqeSqwtHLDzImB5rFru8oJdRwf9q8uQDMpThw+kIk8ergicTYDYhRcW
         CeeA==
X-Gm-Message-State: AOJu0YxD/FxCOVzO2ne2pzD+M1r2aPA260B75U0RqORQcP7/d/mkX+dN
	biilzHOzK1s2s4nIOQQeRA6YRg==
X-Google-Smtp-Source: AGHT+IHJb4HtPGUePL9mUs+HJqXER2fgOPpx0hOjcuuKj93Ug0wBvTft9KXdW8nwYNIXmes1SpZBiA==
X-Received: by 2002:a17:906:76d0:b0:9a5:9305:83ff with SMTP id q16-20020a17090676d000b009a5930583ffmr1500146ejn.18.1694784227395;
        Fri, 15 Sep 2023 06:23:47 -0700 (PDT)
Received: from [192.168.69.115] (6lp61-h01-176-171-209-234.dsl.sta.abo.bbox.fr. [176.171.209.234])
        by smtp.gmail.com with ESMTPSA id fi8-20020a170906da0800b00997e00e78e6sm2419215ejb.112.2023.09.15.06.23.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 06:23:47 -0700 (PDT)
Message-ID: <f69ac27a-943c-3966-385a-e12ecd71d33a@linaro.org>
Date: Fri, 15 Sep 2023 15:23:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v5 0/3] Move Loongson1 MAC arch-code to the driver dir
Content-Language: en-US
To: Serge Semin <fancer.lancer@gmail.com>,
 Keguang Zhang <keguang.zhang@gmail.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
 Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>,
 Serge Semin <Sergey.Semin@baikalelectronics.ru>
References: <20230914114435.481900-1-keguang.zhang@gmail.com>
 <ueevvju7i42wik6fevdmvbtypm4su77guyo4zizhrfreexken7@nrcovxfnyuvq>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <ueevvju7i42wik6fevdmvbtypm4su77guyo4zizhrfreexken7@nrcovxfnyuvq>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 15/9/23 11:55, Serge Semin wrote:
> Hi Keguang
> 
> On Thu, Sep 14, 2023 at 07:44:32PM +0800, Keguang Zhang wrote:
>> In order to convert Loongson1 MAC platform devices to the devicetree
>> nodes, Loongson1 MAC arch-code should be moved to the driver dir.
>> Add dt-binding document and update MAINTAINERS file accordingly.
>>      
>> In other words, this patchset is a preparation for converting
>> Loongson1 platform devices to devicetree.
> 
> No more comments from my side. Thank you for the patches and
> especially for the patience in the review process.
> 
> For the entire series:
> Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> 
> * I'll also send individual Rb tags to each patch so b4 would be able
> * to take it into account.

Maintainers using b4 should use the '-t' option, then you don't need
to do that:

  -t, --apply-cover-trailers

  By default, b4 will not apply any code review trailers sent to
  the cover letter (but will let you know when it finds those).
  This lets you automatically apply these trailers to all commits
  in the series. This will become the default in a future version
  of b4.

https://b4.docs.kernel.org/en/latest/maintainer/am-shazam.html#common-flags

