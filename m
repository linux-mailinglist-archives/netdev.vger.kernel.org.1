Return-Path: <netdev+bounces-30222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F15D7867AF
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 08:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FD211C20DB6
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 06:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7157B24542;
	Thu, 24 Aug 2023 06:46:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646AE2453C
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 06:46:28 +0000 (UTC)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 180DC1721
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 23:46:24 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-529fb2c6583so6127872a12.1
        for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 23:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692859582; x=1693464382;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oXR3CLIiBpyvmVut/UsFSeJ12pMtKuMLIAGEGf/cnUY=;
        b=sG93NB9Frtt3O2iyPXQ7pNypV6CrimUE/f9SueEl3Ja5LUQpFoLlab/HRnVgr0koMS
         8l+cfasEzC7LSWqNwEaVJlwlCJNEbxWGnEB1GonfR7rBa/+wE6Zzt6DvwIC7QNe+OA7m
         OGCUv6PbWjpADA05mIL7MNcrSOvmf8E4en0tShJi8yB/RYa8lks3egttsM3gdKVy1XnL
         NOolGMxkfz2V4QUbkMd4D1Wdg3e7Jsy76aNZevsAsRYNvfLnQtKuVImA3lCGa9qV457H
         PlZ7KeUfaVZvEKQYBzRG7g3r0sGcyHtS851lYoSQGYLl4+95HSlsWjn1kAMRbWoHxuH1
         GVdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692859582; x=1693464382;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oXR3CLIiBpyvmVut/UsFSeJ12pMtKuMLIAGEGf/cnUY=;
        b=R+mi/lMgqyw9AaZIsx2aY/Kff090riD/9Ukr0kiZPZKhdoXiBXLR5dvKO4fbGIRpwi
         W5hhdoC2O9OnlxyTPSz8pe5DodzBWy5r28oiJ5Chreon+lGGTYNxuC8iCQtDJL7UrEW4
         eT80nG2mZEqwq3ddAP4h+CiMi0ej2fhH1rs+ku0UbXJLIRrDXgms6SVAOKN1q5pzh0Dz
         jOrnnICzi4K665FvoAq7IBsHdBlvarrnjm9uTOJPvcUCAuNwDwhWB72xWqNliVaQi+Pa
         zCYWC6cfFcgXdNWfcLlh9EAVghi2il/PYqAb+aPFQFM2+jafM34tZ2GS9/UhdBZit4Xx
         SAGg==
X-Gm-Message-State: AOJu0YzTT7IImxk9JpnY44OYduGV/oGZGURbl5gLYinGcAIFI4OuZjY7
	Lbq7aPIPzXdWD7tiFzSmigkhGg==
X-Google-Smtp-Source: AGHT+IHJcELVd4pq2Oe8iCIJlVRhuMf1x1yH2JxW4qWladkF/S3emBT2Iv80j4TO2slzAIWzWh1eow==
X-Received: by 2002:aa7:c718:0:b0:52a:943:9abd with SMTP id i24-20020aa7c718000000b0052a09439abdmr9065547edq.30.1692859582450;
        Wed, 23 Aug 2023 23:46:22 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id r5-20020aa7cb85000000b0052348d74865sm10167643edt.61.2023.08.23.23.46.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Aug 2023 23:46:22 -0700 (PDT)
Message-ID: <ba603c1f-6f2c-6408-bc71-41aa0e7d4ee8@linaro.org>
Date: Thu, 24 Aug 2023 08:46:20 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v6 3/5] net: ti: icss-iep: Add IEP driver
Content-Language: en-US
To: MD Danish Anwar <danishanwar@ti.com>, Randy Dunlap
 <rdunlap@infradead.org>, Roger Quadros <rogerq@kernel.org>,
 Simon Horman <simon.horman@corigine.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Andrew Lunn <andrew@lunn.ch>,
 Richard Cochran <richardcochran@gmail.com>,
 Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 "David S. Miller" <davem@davemloft.net>
Cc: nm@ti.com, srk@ti.com, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, netdev@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230823113254.292603-1-danishanwar@ti.com>
 <20230823113254.292603-4-danishanwar@ti.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230823113254.292603-4-danishanwar@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 23/08/2023 13:32, MD Danish Anwar wrote:
> From: Roger Quadros <rogerq@ti.com>
> 
> Add a driver for Industrial Ethernet Peripheral (IEP) block of PRUSS to
> support timestamping of ethernet packets and thus support PTP and PPS
> for PRU ethernet ports.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> Reviewed-by: Roger Quadros <rogerq@kernel.org>
> Reviewed-by: Simon Horman <horms@kernel.org>

So more of the tags appear... And one of authors (Roger) also is
reviewer... I would be surprised if author did not approve own code.

What's happening here?

Best regards,
Krzysztof


