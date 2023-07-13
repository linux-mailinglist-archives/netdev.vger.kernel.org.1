Return-Path: <netdev+bounces-17511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1DFA751D55
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 11:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E80D1C212E9
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 09:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD91100CF;
	Thu, 13 Jul 2023 09:34:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD35FBE1
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 09:34:06 +0000 (UTC)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28CF71FD7
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 02:34:05 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b741cf99f8so6749281fa.0
        for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 02:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20221208.gappssmtp.com; s=20221208; t=1689240843; x=1691832843;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lMHT6UoXyT7yXa5NMQkYocKiTnpdFIDZ2yGmogMbjUw=;
        b=wAk1AWpzrbDeO7yqVK9IzXCcRdWswZfk3XyO72KiL17HaSy2JkRQThpYEX0JUpRVhO
         X+dnIvcbPWNUzOa9+/a7ou+f5x6K/r5mtKp58UORIA4U4kJST7lE2mnrhZP+r6R67vLN
         N2sq26vGqiJHLSZdrdGTENOwn2PN80WiryBg7UKOPpHuaVuxaY8v0fj+7NKOAyN95lMh
         7rjJyAmQUfdbHEL8bkG/1KlGEGuycuobPQDGJdwmWoeot6cG4Ok9LW2Fpw/hLUNe4RSS
         TNh8+P/+H6XyZFQF03/hElOLSrlH8XUPCvSRgui7u66rraMU08A/TGYA3b3M9MzNkEA8
         XddQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689240843; x=1691832843;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lMHT6UoXyT7yXa5NMQkYocKiTnpdFIDZ2yGmogMbjUw=;
        b=WMvuD25tLj2mtCu8CnlyZGeyiH3H2nkco5cYCcoOFdIAp9ICjlbtHevltzPp5nKmfH
         uhn0jgtuokKbTRxAUVTLUgKulJyTN1YfiJijYRYqihU23/Jy2xtGGDB5I8rrukOSD5o5
         awZ3E7AlVQrwMmcJMuJXXSysiz4pgY3a27ccs4KoK89H8OHtDnvVouugnSOi9MfCgWtR
         md+9Pifg4m42aw0e9Kv7eZ6GC0wsm5GdyyTEf+gzGzjEQ/xJ/T/6t2iAv/UrcZqdTlQM
         Tm8LPZto7jLiSEhTSrKX07lsTfFFLlENd+RDEwWUKC2EQsvjhrnqXcdrEeW915DbIhD3
         OSjQ==
X-Gm-Message-State: ABy/qLZ5bHTxjHNwYF84CwuxjrfsNjCXT/HQNwP+GZrkEuTp3NzLo+RM
	q/rt081PXkXv2o71nEmGrX7ybg==
X-Google-Smtp-Source: APBJJlHBOcJIRV3pPGjEDMRgsH9BXtIXzG76wRVu+Y+oswYkkhSvMhF45Al5NXaKjKNarpYinxyXmA==
X-Received: by 2002:a05:651c:8b:b0:2b6:e96c:5414 with SMTP id 11-20020a05651c008b00b002b6e96c5414mr799760ljq.52.1689240843435;
        Thu, 13 Jul 2023 02:34:03 -0700 (PDT)
Received: from [192.168.51.243] ([78.128.78.220])
        by smtp.gmail.com with ESMTPSA id a18-20020a2e88d2000000b002b6d7bcf665sm1429422ljk.71.2023.07.13.02.34.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 02:34:03 -0700 (PDT)
Message-ID: <c50ea6d9-2741-8dd3-a176-bee35388d229@blackwall.org>
Date: Thu, 13 Jul 2023 12:34:01 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC PATCH net-next 4/4] selftests: net: Add bridge backup port
 and backup nexthop ID test
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
 bridge@lists.linux-foundation.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, roopa@nvidia.com, dsahern@gmail.com, petrm@nvidia.com,
 taspelund@nvidia.com
References: <20230713070925.3955850-1-idosch@nvidia.com>
 <20230713070925.3955850-5-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20230713070925.3955850-5-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 13/07/2023 10:09, Ido Schimmel wrote:
> Add test cases for bridge backup port and backup nexthop ID, testing
> both good and bad flows.
> 
> Example truncated output:
> 
>   # ./test_bridge_backup_port.sh
>   [...]
>   Tests passed:  83
>   Tests failed:   0
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>   tools/testing/selftests/net/Makefile          |   1 +
>   .../selftests/net/test_bridge_backup_port.sh  | 759 ++++++++++++++++++
>   2 files changed, 760 insertions(+)
>   create mode 100755 tools/testing/selftests/net/test_bridge_backup_port.sh
> 

Well explained
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


