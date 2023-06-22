Return-Path: <netdev+bounces-13042-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A52773A07A
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 14:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAC6D1C2112D
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 12:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1E11EA94;
	Thu, 22 Jun 2023 12:02:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531001E509
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 12:02:29 +0000 (UTC)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B3C212F
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 05:02:10 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fa71db41b6so6262155e9.1
        for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 05:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687435329; x=1690027329;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RSYUGLJ7equSoB6ZSZMDNfWldfc/oPEVeTrLP83740o=;
        b=kK1RWocwHe/X3yonqu8ZW2MXlcxFXY71vaaEn6I2JUfQvgqSCXkVM1351+MA5qLAKb
         l29M8SAT9HlkvbuqWAKoTUkFtsOXKZ3HGiLprcMB7kdrDi98zC9OfTTYeG4Tprl3/A9g
         KNUjEoQ8/HMK+5a5CR6LZl8oIo3cRzABdGyJgFR5moFHWiho8CvSVRspkLxquPI1D07X
         oVtyv68W5I0+nI8uNsaGrdOStRhv59Nx/yt87KSfrnRM4a2ZWD8VHOzkH9hbJLJuENpT
         fh4Q1xj5FhmKnA4C/Y7GmYiOlzf+7tuU0uGAZy+JQkH1N0kqClZCb89OI0eMyLhqtn3w
         uj6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687435329; x=1690027329;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RSYUGLJ7equSoB6ZSZMDNfWldfc/oPEVeTrLP83740o=;
        b=EcgyzpyFrY/MhaIZZ0LwgKvZSIOdQejzibTqHWf7jl1xFnHHsU+ciACYe+sLFs+mC+
         M9xKLuHF+d+w2zEFnAz11tzmEpfv+RW0jgScgAnZrIpQF6WWdBtcMwq34OF61eGWMZMC
         SbpVbftQAZOJ5ruIlJqJSqOUUeEnY71B86IJA7vxItqbsUuPEyEXH/BwScu5VUL8/IrW
         Fb+CLuyGgS+yIoOevPsNIImZl7nfF0HLBG52pFx6QF1gFl0lEIiWwAwsckPeOSiIFSae
         GoW3GGEX+eNW0idIqp3gTxAO8tn4XhaLakhpo2lLdHuTf9zpD1my+QTfjo5TtUdNwqvI
         IxrQ==
X-Gm-Message-State: AC+VfDwJ7V5FkhI0kMP1K76oh8eXG/5pgEczTV1mRkjayyOgBYgl2Fp4
	xaElr7+Dd788BVH4vsnim+I=
X-Google-Smtp-Source: ACHHUZ6j2y3zi04dbGWKoEOYQSW9PUbTt+u+CfePjM8QeujJyl/zp9NATpVrcHWE05fHhnd4CFZtLg==
X-Received: by 2002:a5d:5259:0:b0:309:303b:3dc5 with SMTP id k25-20020a5d5259000000b00309303b3dc5mr12362279wrc.7.1687435328651;
        Thu, 22 Jun 2023 05:02:08 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id z17-20020a5d6551000000b00307bc4e39e5sm6833865wrv.117.2023.06.22.05.02.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jun 2023 05:02:08 -0700 (PDT)
Subject: Re: [PATCH net-next 1/3] sfc: use padding to fix alignment in
 loopback test
To: Arnd Bergmann <arnd@arndb.de>, edward.cree@amd.com,
 linux-net-drivers@amd.com, "David S . Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Netdev <netdev@vger.kernel.org>, Martin Habets <habetsm.xilinx@gmail.com>
References: <cover.1687427930.git.ecree.xilinx@gmail.com>
 <441f4c197394bdeddb47aefa0bc854ee1960df27.1687427930.git.ecree.xilinx@gmail.com>
 <c16273f9-f6e9-492d-a902-64604f3e40c2@app.fastmail.com>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <342903aa-ceb5-4412-f5b9-93413d413079@gmail.com>
Date: Thu, 22 Jun 2023 13:02:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <c16273f9-f6e9-492d-a902-64604f3e40c2@app.fastmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 22/06/2023 12:38, Arnd Bergmann wrote:
> On Thu, Jun 22, 2023, at 12:18, edward.cree@amd.com wrote:
>>  drivers/net/ethernet/sfc/selftest.c | 45 +++++++++++++++++------------
>>  1 file changed, 27 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/sfc/selftest.c 
>> b/drivers/net/ethernet/sfc/selftest.c
>> index 3c5227afd497..74b42efe7267 100644
>> --- a/drivers/net/ethernet/sfc/selftest.c
>> +++ b/drivers/net/ethernet/sfc/selftest.c
>> @@ -42,12 +42,16 @@
>>   * Falcon only performs RSS on TCP/UDP packets.
>>   */
>>  struct efx_loopback_payload {
>> +	char pad[2]; /* Ensures ip is 4-byte aligned */
>>  	struct ethhdr header;
>>  	struct iphdr ip;
>>  	struct udphdr udp;
>>  	__be16 iteration;
>>  	char msg[64];
>>  } __packed;
> 
> There should probably be an extra __aligned(4) after the __packed,
> so that the compiler knows the start of the structure is aligned,
> otherwise (depending on the architecture and compiler), any access
> to a member can still turn into multiple single-byte accesses.

Ok, will add that in v2.

> I would also expect to still see a warning without that extra
> attribute. Aside from this, the patch looks good to me.
My compiler (gcc 8.3.1) doesn't reproduce the original warning, so
 I'm flying slightly blind here :(  If you could build-test this on
 your setup with/without the __aligned(4), I'd be very grateful.

-ed

