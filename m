Return-Path: <netdev+bounces-35106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC837A70BA
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 04:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D8EB1C20EC9
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 02:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29CBA17F3;
	Wed, 20 Sep 2023 02:51:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9415EA49
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 02:51:49 +0000 (UTC)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC8DCA
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 19:51:48 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1c43b4b02c1so33362775ad.3
        for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 19:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695178307; x=1695783107; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iUe7FjLqbcmTwbdjwmCJH1rvybS1tSaidCabwaGsxP0=;
        b=caCgRDGbH1O+m1MUSjdM/NXaD2pRUiqm7aDNyLgNoIeNoSp9pDRzTJcScV8L6R65G3
         9UMC5uAuon0O1ahrVikLvupkqiikqIREuKfsjFkeIXm/xdMDoHR6N9akDsTw+iXHLHBk
         r1LJbO1JM8b8jxjH6fhTJsG8Zh6z2ns3jox04rJFWb/f/vnPNQelgAlHbJijxKhcurpr
         VC35A3zsKufeKJDaeTv5ypbHAV9X7If82N/mdtFUPsD7NJhsDGvwsd2YnKsb7vdGz8dV
         426ABpOT1Jb59kq5omZcQiNTSpnIno01L2XyXQVxs5dzUPQoxWjDmQEXrsPG2jkw8sK3
         RlWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695178307; x=1695783107;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iUe7FjLqbcmTwbdjwmCJH1rvybS1tSaidCabwaGsxP0=;
        b=YTJZs6CbXPqjLkj2pjtk3GYrZLq20ObZ1+5/XYeo0APUZCf6DM7EKUBGwK1aZyLWJn
         1SmgENZB6bGyVZe+NIwBoWvSzDonGcZnb99onGwJ/iyfM8lfzLiw/3BLU2EB3g1wgPez
         8mvVMzIMag2fs+jSGnerTbVlAYYrGwH33B5tVJSPQ6xkyNZ3KjrOsGuW3JDt/3QYLm9t
         ChtXHk2ti2s812nPtaL8pWUAnFJvZITKetDfPWWI4ufotO73hP071SpokioRGf2B0Ovr
         ofnLPCKULSVw1TFinFKL7aaE24BxvrWXKJWyplAjbKfQcBAfRBM9kOyh8GIammcnBY90
         4GAA==
X-Gm-Message-State: AOJu0YxGZg8s8f471v2mOXWIMIaL1uBMdf+jRTzmjP2IgbqQidcwnfgq
	DwWfvGmBpWHatOkOTF9FR3s=
X-Google-Smtp-Source: AGHT+IGoikq9WtnOgZVyvAcdXBQeSYA81/BeZcv88rbT1C+5RnxYx2jzT6fAz3fs3/oC469dcq0vMQ==
X-Received: by 2002:a17:902:82c4:b0:1c1:f5a6:bdfa with SMTP id u4-20020a17090282c400b001c1f5a6bdfamr1159157plz.7.1695178307371;
        Tue, 19 Sep 2023 19:51:47 -0700 (PDT)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id jj1-20020a170903048100b001bc6e6069a6sm6058934plb.122.2023.09.19.19.51.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Sep 2023 19:51:46 -0700 (PDT)
Message-ID: <a9e845b7-fa47-4121-8d02-312b0a9ddf19@gmail.com>
Date: Tue, 19 Sep 2023 19:51:44 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] mlxbf_gige: Fix kernel panic at shutdown
Content-Language: en-US
To: Asmaa Mnebhi <asmaa@nvidia.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, olteanv@gmail.com
Cc: netdev@vger.kernel.org, davthompson@nvidia.com
References: <20230919221308.30735-1-asmaa@nvidia.com>
 <20230919221308.30735-2-asmaa@nvidia.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <20230919221308.30735-2-asmaa@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 9/19/2023 3:13 PM, Asmaa Mnebhi wrote:
> There is a race condition happening during shutdown due to pending napi transactions.
> Since mlxbf_gige_poll is still running, it tries to access a NULL pointer and as a
> result causes a kernel panic:
> 
> [  284.074822] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000070
> ...
> [  284.322326] Call trace:
> [  284.324757]  mlxbf_gige_handle_tx_complete+0xc8/0x170 [mlxbf_gige]
> [  284.330924]  mlxbf_gige_poll+0x54/0x160 [mlxbf_gige]
> [  284.335876]  __napi_poll+0x40/0x1c8
> [  284.339353]  net_rx_action+0x314/0x3a0
> [  284.343086]  __do_softirq+0x128/0x334
> [  284.346734]  run_ksoftirqd+0x54/0x6c
> [  284.350294]  smpboot_thread_fn+0x14c/0x190
> [  284.354375]  kthread+0x10c/0x110
> [  284.357588]  ret_from_fork+0x10/0x20
> [  284.361150] Code: 8b070000 f9000ea0 f95056c0 f86178a1 (b9407002)
> [  284.367227] ---[ end trace a18340bbb9ea2fa7 ]---
> 
> To fix this, return in the case where "priv" is NULL.
> 
> Fixes: f92e1869d74e ("Add Mellanox BlueField Gigabit Ethernet driver")
> Signed-off-by: Asmaa Mnebhi <asmaa@nvidia.com>
> Reviewed-by: David Thompson <davthompson@nvidia.com>

This adds a test in a hot-path when the solution would be to simply make 
sure that the interface does not schedule any new NAPI calls, as well as 
stops being visible to the system. In its current form your shutdown 
function is trying to be as efficient as possible, I would just make 
your shutdown function the same as the remove function which would 
ensure the network device is torn down using a well traveled path.
-- 
Florian

