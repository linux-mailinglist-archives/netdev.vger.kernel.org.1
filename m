Return-Path: <netdev+bounces-17422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F1775186C
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 07:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BA871C2127F
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 05:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFEEB5677;
	Thu, 13 Jul 2023 05:59:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D460F566E
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 05:59:42 +0000 (UTC)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477E11FDE
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 22:59:41 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fbc5d5742bso2131065e9.2
        for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 22:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689227979; x=1691819979;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TonyGlZrPLTfaA/nGE3oSsXI8nFtOJ8w/o5RAeOZAAw=;
        b=nwW1SQbH3bX5iVluDTu625cIH6qOiTFEpMh7/NHoHeubKCR6ldajfreHD3crgVtaKl
         gJNN1v01M56knNU8LgXG5Fe0aTj+LWDjD3o5jaEjUa1vnI1SzqKxWjwsic6/9UU49uZY
         LFU8C11eO+9M4zdGW/Ywawx4sO/wg6I33/1tGPwUM54z4exaM9oJvdivq8Vv5akeP32A
         WJvJ0PVujUpFKJcN78qCP+e6tsbEDj2IcOdbOjy31ah9eLCP2y4Y+UakHL17pCNvf8Ju
         PUulnwIMjFPcIZP5XHrUL8LMpLQtvY65WjGPUEeSNYASQVzlS5kUJ/ItFHa3h8Sd7vM5
         oP5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689227979; x=1691819979;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TonyGlZrPLTfaA/nGE3oSsXI8nFtOJ8w/o5RAeOZAAw=;
        b=jqLIsVgEtczKOB+76lTZ2dl6MURJclCdh9grSPh6Y8MyirEeh1LMSABPCMy+UT9o+c
         sfGQCWk+eldaHgxJiNRYOSb0tfhzq58acycqe3sv4wK5GY5VUMuHuR4HSB7c/j/i5L/J
         6+CudbTpXX3TGpQkxUNoBp433mp+IpTNNMSd9tArBKE/UsfQRiOPxV2YphegJ84wVjtE
         WVA7dXIrGiru3TV8VagcANH9DNRYlTfWA3iZd5xcpQia6nPBUG4OrmiXCvZwIPor/+3U
         6lrUM3h0uUgyStpFU27nyxB3yJInE8vi6Gtg4N/qVUgpwdNr29W882Ek7WiUgbAajFVH
         WN7w==
X-Gm-Message-State: ABy/qLZj+o9NahYXqJdibXRe4KesAbWLMKuadxrbQseGqyj5J42X9Y6J
	T3v7k01UudxtmTaA9v0FmpU=
X-Google-Smtp-Source: APBJJlED7Vq9rOXUbdrXtYCHP/Df/58CDfglI/owsskIfYVf6B78MwAKnJXfStqtPQ3ISqkXR2boqQ==
X-Received: by 2002:a1c:4b18:0:b0:3fa:9e61:19ed with SMTP id y24-20020a1c4b18000000b003fa9e6119edmr479684wma.23.1689227979254;
        Wed, 12 Jul 2023 22:59:39 -0700 (PDT)
Received: from ?IPV6:2a01:c23:b8ac:4400:515d:f19b:9d70:d3fc? (dynamic-2a01-0c23-b8ac-4400-515d-f19b-9d70-d3fc.c23.pool.telefonica.de. [2a01:c23:b8ac:4400:515d:f19b:9d70:d3fc])
        by smtp.googlemail.com with ESMTPSA id f11-20020a7bc8cb000000b003fa98908014sm17441619wml.8.2023.07.12.22.59.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 22:59:38 -0700 (PDT)
Message-ID: <16fa03d5-c110-75d6-9181-d239578db0a2@gmail.com>
Date: Thu, 13 Jul 2023 07:59:32 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
To: Anuj Gupta <anuj20.g@samsung.com>, davem@davemloft.net
Cc: holger@applied-asynchrony.com, kai.heng.feng@canonical.com,
 simon.horman@corigine.com, nic_swsd@realtek.com, netdev@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <CGME20230712155834epcas5p1140d90c8a0a181930956622728c4dd89@epcas5p1.samsung.com>
 <20230712155052.GA946@green245>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: Performance Regression due to ASPM disable patch
In-Reply-To: <20230712155052.GA946@green245>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 12.07.2023 17:55, Anuj Gupta wrote:
> Hi,
> 
> I see a performance regression for read/write workloads on our NVMe over
> fabrics using TCP as transport setup.
> IOPS drop by 23% for 4k-randread [1] and by 18% for 4k-randwrite [2].
> 
> I bisected and found that the commit
> e1ed3e4d91112027b90c7ee61479141b3f948e6a ("r8169: disable ASPM during
> NAPI poll") is the trigger.
> When I revert this commit, the performance drop goes away.
> 
> The target machine uses a realtek ethernet controller - 
> root@testpc:/home/test# lspci | grep -i eth
> 29:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. Device 2600
> (rev 21)
> 2a:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. Killer
> E3000 2.5GbE Controller (rev 03)
> 
> I tried to disable aspm by passing "pcie_aspm=off" as boot parameter and
> by setting pcie aspm policy to performance. But it didn't improve the
> performance.
> I wonder if this is already known, and something different should be
> done to handle the original issue? 
> 
> [1] fio randread
> fio -direct=1 -iodepth=1 -rw=randread -ioengine=psync -bs=4k -numjobs=1
> -runtime=30 -group_reporting -filename=/dev/nvme1n1 -name=psync_read
> -output=psync_read
> [2] fio randwrite
> fio -direct=1 -iodepth=1 -rw=randwrite -ioengine=psync -bs=4k -numjobs=1
> -runtime=30 -group_reporting -filename=/dev/nvme1n1 -name=psync_read
> -output=psync_write
> 
> 
I can imagine a certain performance impact of this commit if there are
lots of small packets handled by individual NAPI polls.
Maybe it's also chip version specific.
You have two NIC's, do you see the issue with both of them?
Related: What's your line speed, 1Gbps or 2.5Gbps?
Can you reproduce the performance impact with iperf?
Do you use any network optimization settings for latency vs. performance?
Interrupt coalescing, is TSO(6) enabled?
An ethtool -k output may provide further insight.


