Return-Path: <netdev+bounces-41819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 123497CBF81
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 11:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D4EA1C20A6E
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 09:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D816C3FB2A;
	Tue, 17 Oct 2023 09:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="xoGJqICd"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973963F4DC
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 09:33:34 +0000 (UTC)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434FBD45
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 02:33:32 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9b95622c620so956553066b.0
        for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 02:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1697535211; x=1698140011; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9ZWXkFe4WleqBkpoOQ4BLbez5u6DDo1LE1NT6KN4yF8=;
        b=xoGJqICdrTfzHzRdIAiNEqT7+OVZF57U4Fpta2hos9t6iVk8G8hI7O+BQjSY5X/AdF
         mUAlop87hTllykXjcdwaKdTAGVkZmN5sjlbq+wACNev41xjvuW9aAVI++ddvYrZb7esr
         Rxv1QT6NATUbs8o2Ek80CuwSMBfaAH59AIqVfKxU9HHZpqvw3tWQ0siTtdnWJ65rqwnZ
         LN1v15rIak4csb9CIql0/G3qDxuarj6/95Ns1PIhy3zq8SgHiNOKRn0qilfTrupCcmEe
         e02FCskAHzJKYu1wFeaTfGfr6/PACQfeWnED5CNqkly6+Zvq/1ISvodWSp1fO0IH9k4r
         ab3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697535211; x=1698140011;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9ZWXkFe4WleqBkpoOQ4BLbez5u6DDo1LE1NT6KN4yF8=;
        b=Sc8oXMoJMcmIrfHlVhDAkIEvwfTqlaGkATkDOnPJQ66W/1CY2Swkp4/KlbsJaLm1sd
         5vKVYCE0wi37s/TKk3VZn7Qlfz2joQ3Ec5eLULeTYRNRllMKb+oUOU7AiHg2r3mjkBWA
         yzyr7jpODuFTO8Mi/GgcELF5LtSZx57FYdHJFQcSTRA8z8dB1CyA56fq3EqQQbnFqYLL
         MGoeGO+D/3zFW3EFfKCE/b4LHO0T19ysSamPfJ/CcoWWQNsRl4obOWjYq2YXRZA/LTEd
         NIK/LuZ6OMMDqJIliAV4bbIu5ZrZf0Q5ZYO2veuDVrNdqp3vNzjvUTOFj3aXWLF1Df4V
         LZng==
X-Gm-Message-State: AOJu0YyRoSafrUOknlv/LUujN78+AqH6zmhC7Exmi71YwhBC0E4X2f9S
	tGDvyqTtggxNJWHDer/oGDQv8g==
X-Google-Smtp-Source: AGHT+IElgJ6pCuHbfZIOuPJ52OYmszUfJ2xgStm77obEeuiheqzB25LfvpnnBm4BC3y37w1+fRfTwg==
X-Received: by 2002:a17:907:2ce3:b0:9ae:46c7:90fe with SMTP id hz3-20020a1709072ce300b009ae46c790femr1130058ejc.72.1697535211294;
        Tue, 17 Oct 2023 02:33:31 -0700 (PDT)
Received: from [192.168.0.106] (haunt.prize.volia.net. [93.72.109.136])
        by smtp.gmail.com with ESMTPSA id e9-20020a17090681c900b009b913aa7cdasm892723ejx.92.2023.10.17.02.33.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 02:33:30 -0700 (PDT)
Message-ID: <ce02cb19-5e7d-9b78-4fa1-a54e6c500fc9@blackwall.org>
Date: Tue, 17 Oct 2023 12:33:29 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH iproute2-next 1/8] bridge: fdb: rename some variables to
 contain 'brport'
Content-Language: en-US
To: Amit Cohen <amcohen@nvidia.com>, netdev@vger.kernel.org
Cc: dsahern@gmail.com, stephen@networkplumber.org, mlxsw@nvidia.com,
 roopa@nvidia.com
References: <20231017070227.3560105-1-amcohen@nvidia.com>
 <20231017070227.3560105-2-amcohen@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231017070227.3560105-2-amcohen@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/17/23 10:02, Amit Cohen wrote:
> Currently, the flush command supports the keyword 'brport'. To handle
> this argument the variables 'port_ifidx' and 'port' are used.
> 
> A following patch will add support for 'port' keyword in flush command,
> rename the existing variables to include 'brport' prefix, so then it
> will be clear that they are used to parse 'brport' argument.
> 
> Signed-off-by: Amit Cohen <amcohen@nvidia.com>
> ---
>   bridge/fdb.c | 20 ++++++++++----------
>   1 file changed, 10 insertions(+), 10 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>



