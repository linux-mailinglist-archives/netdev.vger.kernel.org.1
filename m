Return-Path: <netdev+bounces-31335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E01BB78D37B
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 09:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F4D1281389
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 07:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798BA1859;
	Wed, 30 Aug 2023 07:13:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B5C1847
	for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 07:13:05 +0000 (UTC)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10ED1BE
	for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 00:13:04 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-52bd9ddb741so1227327a12.0
        for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 00:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693379582; x=1693984382; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TlmWx7J988jUTBD1yCbXKnxEBFJ9/SEsR6ggJelJEyE=;
        b=FBSIcBylaE2+RQM+2MUow7pQDZNwO9c3p0BK5jqFSKbOEk8aQwAhwipORClRgDYxsf
         dJPzx60Ot3pH4aXTcflc7mxnXeeOccacGrdXQzqtp6HHr6FmNGmR0lYJaeqa7djnoGMs
         OpFdHHlF+FyEXmwFEc4AP2iMN3NDL+C6mr4M6pDOzaYdzE+clQjPrpgY35gmDrmcU2nG
         AYAKOXCpUknMNpDm0ti+8jFngeTNdIhVxszdpqT2KMdlfYiP+VGVwMk0zefZmcEBRE2Y
         IHW8qo5VVl+OTkpN5OL9ED9FamEuQUftDLUxi/Ln2/J+SJpZucRsmi1RRYiWC1Q9QuwV
         z+6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693379582; x=1693984382;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TlmWx7J988jUTBD1yCbXKnxEBFJ9/SEsR6ggJelJEyE=;
        b=TzquEMoCVor540D6DCodtAwE+riOPj6UpZSoXAayySK4XiBiKV1ICwew3JnOv1eOfp
         9qBvP0MPFDQTYppIwqxEkqY4B8j7KyrrgEbGoYXwCfbxEQu8YDMgCsVmOkLZw+xkHWP9
         WdivC24kQON/SSz2OlIcCb7Zh33RvCjcC1k5fkLHktZ6Ed0K9UkfzbTkG6PIRPasJKdk
         dYs7vKdpP3mzbHetcCQW3Xpzzjy7PLBMYCJK+zsiknkeJ1VDCFh2OXjmlAvQdC51FEeV
         bh6xLlsNNSVOJYYvefJhY3QZRDl4fXf7KznB45n0XNruT73M8tNwv17TsIW2QgUOVrFK
         WGQw==
X-Gm-Message-State: AOJu0YyKKy5HZgJjCNIzzZjMDjF3uBu5dOq2wDpg3FiFtj77jiO/33R8
	/n/p98EJOi0MpLEjyPwWBJMzHEoioDFH35tVjNw=
X-Google-Smtp-Source: AGHT+IF+5DxuHdSG3Q5k7h2CRZvFk49w0bjYx5Ci81wfLZgXylbaTnbHLSxNB0HUo2OaSXh2Mz9HLQ==
X-Received: by 2002:a17:906:5dc1:b0:9a2:86a:f9b7 with SMTP id p1-20020a1709065dc100b009a2086af9b7mr896445ejv.59.1693379582599;
        Wed, 30 Aug 2023 00:13:02 -0700 (PDT)
Received: from [192.168.0.22] (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id hv13-20020a17090760cd00b009a5f1d1564dsm72007ejc.126.2023.08.30.00.13.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Aug 2023 00:13:02 -0700 (PDT)
Message-ID: <12a0f531-851f-cd09-3d56-828e2aeccae3@linaro.org>
Date: Wed, 30 Aug 2023 09:13:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 1/3] dt-bindings: can: xilinx_can: Add ECC property
 'xlnx,has-ecc'
Content-Language: en-US
To: "Goud, Srinivas" <srinivas.goud@amd.com>, Rob Herring <robh@kernel.org>
Cc: "wg@grandegger.com" <wg@grandegger.com>,
 "mkl@pengutronix.de" <mkl@pengutronix.de>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>,
 "krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 "git (AMD-Xilinx)" <git@amd.com>, "Simek, Michal" <michal.simek@amd.com>,
 "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "appana.durga.rao@xilinx.com" <appana.durga.rao@xilinx.com>,
 "naga.sureshkumar.relli@xilinx.com" <naga.sureshkumar.relli@xilinx.com>
References: <1693234725-3615719-1-git-send-email-srinivas.goud@amd.com>
 <1693234725-3615719-2-git-send-email-srinivas.goud@amd.com>
 <20230828154309.GA604444-robh@kernel.org>
 <PH8PR12MB6675C31C6D1DCD3281FE8A10E1E6A@PH8PR12MB6675.namprd12.prod.outlook.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <PH8PR12MB6675C31C6D1DCD3281FE8A10E1E6A@PH8PR12MB6675.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 30/08/2023 08:06, Goud, Srinivas wrote:
>>> +
>>>  required:
>>>    - compatible
>>>    - reg
>>> @@ -137,6 +141,7 @@ examples:
>>>          interrupts = <GIC_SPI 59 IRQ_TYPE_EDGE_RISING>;
>>>          tx-fifo-depth = <0x40>;
>>>          rx-fifo-depth = <0x40>;
>>> +        xlnx,has-ecc
>>
>> Obviously not tested.
> Will fix it.
> 

Fix it by fixing error or by testing? Can you do both?

Best regards,
Krzysztof


