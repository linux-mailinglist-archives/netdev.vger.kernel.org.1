Return-Path: <netdev+bounces-12719-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4A9738A4E
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 17:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39BBF28156C
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 15:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD8B1953A;
	Wed, 21 Jun 2023 15:59:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7001418C2E
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 15:59:13 +0000 (UTC)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C305919BF
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 08:58:59 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-666eef03ebdso2530010b3a.1
        for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 08:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687363139; x=1689955139;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9TaobqcU8ahSNbB1UdL4ZYD/MnfL6oSGDr8QmVPJJG0=;
        b=DQiXIX3l+RMMPc8y+BcTZrZX3yE5ifvMQG9rEfgkM8/KmFYZX7lge/udz2/PLAmY/n
         /awb4yG4Hedr5/NPDDX5hru2f2JScTDXRLlSuMyUngkG7LKbimDdMT6U/avU2zUoHmD1
         7/onv8QfHRpvgwU8Lo5VZtkXqgmrPdwTO/5Fbd+ClVG7hn/9g8GK4d+X36OQz4HP0D3r
         ET4GlTEck5BaTXcnqLp2GaxI9kAs/Q7kQD1x+T+sHJ6U2gJZ61AbOZyDM/OHwPoKU8QH
         s8RFsXdnyyfF3uW/4zs8s7hZHfRvGAyJrOWs03IALGvY7orLi39HdOHLCnxJsifsbqkk
         avag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687363139; x=1689955139;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9TaobqcU8ahSNbB1UdL4ZYD/MnfL6oSGDr8QmVPJJG0=;
        b=LWNEkPzgcfdr8EjAkEJ0FI9lLYlB0eKbAdR2cL1szFXeYDo3dD7n4CNYUsBmi8gOf7
         Da2yTptSwnIBe4W2keWCPOsNtiC7+2PHPm8V5DrHak/ec3ZkF4P6NuNluWwuRETYQhkC
         39ntCh9vQk23mcm26vk4nyp5IRBHlAeOYhAK835Us9QhCaI7saN2Cck9NRrcVGS4aOqr
         43k/laPa5DIWcgGQeixRD2y4KI4QpHn5zC6PQBseQTMBOOlfQ5L0TUlmxWr4LzZdVZ67
         HJEergiOyNTkapENT+IMIoF3mdKpdepkhWe7OTzEVxmXCxl0TbMUIJp4GNlvtX5jQUe4
         HssQ==
X-Gm-Message-State: AC+VfDzBi69184D3bHFKgpXzH34hE8ayz/fWQSV7pCIJzKw/kaeu/e67
	b2avJygzkD4I67/0MTIOs3Gl+Rw1XKc=
X-Google-Smtp-Source: ACHHUZ6bSiMO+AwT+klKvgA8iXOcraHLOpFgc2sm7uHtoArM2eAuWVoQM8T3ZMYjoNr388FxCzNVbQ==
X-Received: by 2002:a17:90b:1d01:b0:25b:8664:c28 with SMTP id on1-20020a17090b1d0100b0025b86640c28mr5562064pjb.29.1687363139123;
        Wed, 21 Jun 2023 08:58:59 -0700 (PDT)
Received: from [10.20.85.164] ([72.164.175.30])
        by smtp.googlemail.com with ESMTPSA id z16-20020a17090ab11000b00256799877ffsm3324945pjq.47.2023.06.21.08.58.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jun 2023 08:58:58 -0700 (PDT)
Message-ID: <8ae6f84a-fa31-e89c-dfde-10f484d27071@gmail.com>
Date: Wed, 21 Jun 2023 08:58:56 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH iproute2-next v2] f_flower: add cfm support
Content-Language: en-US
To: Ido Schimmel <idosch@idosch.org>,
 Zahari Doychev <zahari.doychev@linux.com>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org,
 hmehrtens@maxlinear.com, aleksander.lobakin@intel.com,
 simon.horman@corigine.com, Zahari Doychev <zdoychev@maxlinear.com>
References: <20230620201036.539994-1-zahari.doychev@linux.com>
 <ZJKSDdC+YNlvCXVv@shredder>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <ZJKSDdC+YNlvCXVv@shredder>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 6/20/23 11:00 PM, Ido Schimmel wrote:
> iproute2 maintainers sync UAPI files using a script and I believe the
> preference is for submitters to not touch these files or update them in
> a separate patch that the maintainers can easily discard.

exactly.

