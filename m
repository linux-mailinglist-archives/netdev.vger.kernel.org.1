Return-Path: <netdev+bounces-24719-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1622577168F
	for <lists+netdev@lfdr.de>; Sun,  6 Aug 2023 21:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7446028116C
	for <lists+netdev@lfdr.de>; Sun,  6 Aug 2023 19:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51FE28F50;
	Sun,  6 Aug 2023 19:35:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4217B7F0
	for <netdev@vger.kernel.org>; Sun,  6 Aug 2023 19:35:11 +0000 (UTC)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B7D171A
	for <netdev@vger.kernel.org>; Sun,  6 Aug 2023 12:35:08 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-52307552b03so5372382a12.0
        for <netdev@vger.kernel.org>; Sun, 06 Aug 2023 12:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691350507; x=1691955307;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3bqbe2tDZsZm0END83UpLyo6EdqTZMUT086jdCCRrYw=;
        b=g0jyzXc60snOi9Q61ciF87VgVXpMoKnvYizbfZgb2HjPkUaMyTBZig89TnI7J6YQ1s
         K/EowG8j8K+l6ZuxtPoNMk568mXiq3LsDY1LWJevmEh+kA17IkB/ExBG5CbCNwYveV85
         KiP8DOjX6xCwsW0l0W4CGt2RceYmAOFGEPC4d25smdzCgQUd+Bu5LPSJH7pdcQoQ/7Y0
         uny9KeKT67FTZ4fflMOOI4Q8B29TKmVZzoAsx6Jb3p0GRyaY+V8q6dznj70w8fGRtRuM
         aa4eJ24jFHCxakE+2duVWIx9By8XJKslLsOb4zYfHySZmq8AnxARrRSGbZUbKyV+c4+Q
         bMTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691350507; x=1691955307;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3bqbe2tDZsZm0END83UpLyo6EdqTZMUT086jdCCRrYw=;
        b=SVlWka9RDa/zV9pEt+A99XQOM5dZlrJdva6Vi86XvhpXLlcC/6LmpsSNnEYmtwSnSR
         s/YodNBmOKMMz5cRVuv+1aBM+xhfq5bsDigJ/ftSms2cMFMg8npd9P2mpbmaYIQmdI82
         O7eHOIKp58JxEQjSii/GWli0JcWGhmRKj3v3ogcX6/SLxvC5xZ9ALodUMc65pwOh0T83
         rOIGRcCvOo2jBwRM43dOVbe6ixEUDsl0hhKteyU9D5N+rWAZoeFq9qNs5PRctrdTMOJM
         3DETvUV0A5J17QzjYYXB75dkB622Pn9iAzVM3K9wcFqnwXyISRimTQ6iNieO5cLiv6ZG
         Z3yA==
X-Gm-Message-State: AOJu0Yw2Jd8L0OGHKo+WsaYFVXFccpkRlbM9SPo5DMc2VY4wCHZeeSp0
	2nmqA1gNqoBXc/JqcSjrzHs3fw==
X-Google-Smtp-Source: AGHT+IG/79s2xg9v9Za0JIriROoPvnlkRv0Jug22nma7i4hEv1WIE4RafrrohEpmmoAaMt55gaOUXA==
X-Received: by 2002:aa7:d148:0:b0:523:2873:8323 with SMTP id r8-20020aa7d148000000b0052328738323mr4168789edo.35.1691350506747;
        Sun, 06 Aug 2023 12:35:06 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id o4-20020aa7c504000000b00522828d438csm4212648edq.7.2023.08.06.12.35.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Aug 2023 12:35:06 -0700 (PDT)
Message-ID: <6fcd8e51-7e97-1261-7cd5-5e18840aaf8e@linaro.org>
Date: Sun, 6 Aug 2023 21:35:03 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 3/5] dt-bindings: clock: add Intel Agilex5 clock
 manager
Content-Language: en-US
To: niravkumar.l.rabara@intel.com
Cc: adrian.ho.yin.ng@intel.com, andrew@lunn.ch, conor+dt@kernel.org,
 devicetree@vger.kernel.org, dinguyen@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, mturquette@baylibre.com,
 netdev@vger.kernel.org, p.zabel@pengutronix.de, richardcochran@gmail.com,
 robh+dt@kernel.org, sboyd@kernel.org, wen.ping.teh@intel.com
References: <20230618132235.728641-1-niravkumar.l.rabara@intel.com>
 <20230801010234.792557-1-niravkumar.l.rabara@intel.com>
 <20230801010234.792557-4-niravkumar.l.rabara@intel.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230801010234.792557-4-niravkumar.l.rabara@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 01/08/2023 03:02, niravkumar.l.rabara@intel.com wrote:
> From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
> 
> Add clock ID definitions for Intel Agilex5 SoCFPGA.
> The registers in Agilex5 handling the clock is named as clock manager.
> 
> Signed-off-by: Teh Wen Ping <wen.ping.teh@intel.com>
> Reviewed-by: Dinh Nguyen <dinguyen@kernel.org>
> Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
> ---

Do not attach (thread) your patchsets to some other threads (unrelated
or older versions). This buries them deep in the mailbox and might
interfere with applying entire sets.

Best regards,
Krzysztof


