Return-Path: <netdev+bounces-31445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E221178DE2E
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 21:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AE181C20858
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 19:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9265A7493;
	Wed, 30 Aug 2023 19:03:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D4E7483
	for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 19:03:00 +0000 (UTC)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE84F4213
	for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 12:02:41 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-34de98e01d4so322355ab.0
        for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 12:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693422055; x=1694026855; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JP3/gU+8RO7PhBsVlkm1URVYbdV0vXX7tPUIQ26ZyL8=;
        b=Bx3sw0c5nILlmQL+k6B26+DSPMwy3zDQ9eC4Ij8wNSDTVlynoQLg5fFp9HZU6FArX1
         iQSh36+gxDwP+f9T9ttLmLqKX3qeHt2iRau22e7ZgfHqQenxOIdoStqyJInKF8+8dqNo
         39w1eyaC6W2MbnSFiJcfcR4Br1B3SotgTIMd8ROeaEFAy+dBdnUqpmbcxPF0Yeq8Al5m
         bXRJp3i5+5vbYVg9m0GbadVkUbIomjFrtBha/p6+D7Q4KtnIAb0w/0XOPPxV8ds7MdfO
         sd6H2InjnjvWDh1d6u4iu+OYu6XVjg0MiGt0cZHS81DfAUastikTgXoCZhDMQv0Ym4Ev
         Qv8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693422055; x=1694026855;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JP3/gU+8RO7PhBsVlkm1URVYbdV0vXX7tPUIQ26ZyL8=;
        b=StdWj/MV3GtCPxvTsnUiRwgykZTYw9q9L9WDSWiZkAVnjuP/1nnXt0Of0wx+vQyPCU
         DdJdWcl6F6GyF5ZzNkNds8jLNiOufxAlR6RrtvRwkKmLBzO0t5iS1Q3x8YYfcBk/WXLW
         BBA7Aedkni1Iym6aIOMP5j+Z3XVwrn+3sFY2pTvpWdQ2CqS2/QgmevEV6oU2p5PqAXMh
         n6ux+1Om1/jsWVgJZIbOhJ9/nZyF+4w7BJAlyeXswFmW1grgnyrPXR8WaDSJV2RIEBHH
         rj1iabQZ5h/qIduZnFjbj+IALHzLXtwgnzevrVVAQwGF/Rj8+sV9YIHODEwHSJzBZfWk
         /YnQ==
X-Gm-Message-State: AOJu0Yyuq1/MubdwulbR1rTOLADdSO4GlMkBnZCsELPAraKQiFJWcmnz
	Ik8t7tYq9ZoniOTokitxVRjRI4+gyuhU0g==
X-Google-Smtp-Source: AGHT+IESK8B+hCB89zwACcSf2WQGawUheKvKaMoNppGqXKulgOemVFrYqfcnBecEcVtdTE63ITTb4Q==
X-Received: by 2002:a92:d28d:0:b0:348:8b42:47d with SMTP id p13-20020a92d28d000000b003488b42047dmr3232349ilp.28.1693422054881;
        Wed, 30 Aug 2023 12:00:54 -0700 (PDT)
Received: from ?IPV6:2601:282:1e81:bee0:d63:fe5d:7113:65a3? ([2601:282:1e81:bee0:d63:fe5d:7113:65a3])
        by smtp.googlemail.com with ESMTPSA id y9-20020a920909000000b003426356a35asm4010092ilg.0.2023.08.30.12.00.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Aug 2023 12:00:54 -0700 (PDT)
Message-ID: <4db5dd3b-3099-4459-085e-7945b05eefb9@gmail.com>
Date: Wed, 30 Aug 2023 13:00:53 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH iproute2-next 0/1] tc: fix typo in netem's usage string
Content-Language: en-US
To: francois.michel@uclouvain.be
Cc: netdev@vger.kernel.org, stephen@networkplumber.org, petrm@nvidia.com,
 dsahern@kernel.org
References: <20230830150531.44641-1-francois.michel@uclouvain.be>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <20230830150531.44641-1-francois.michel@uclouvain.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/30/23 9:05 AM, francois.michel@uclouvain.be wrote:
> From: François Michel <francois.michel@uclouvain.be>
> 
> Fixes a misplaced newline in netem's usage string.
> 
> François Michel (1):
>   tc: fix typo in netem's usage string
> 
>  tc/q_netem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> 
> base-commit: a79e2b2e546584b2879cb9fedd42b7fec5cc8c61

single patch PRs do not need a cover letter. I have fixed up this one;
in the future just send the 1 patch with a proper description.

