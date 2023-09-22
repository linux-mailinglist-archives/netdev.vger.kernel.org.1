Return-Path: <netdev+bounces-35895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F0A7AB807
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 19:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id EEA6628236B
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 17:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45415436B1;
	Fri, 22 Sep 2023 17:47:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1000C436BC
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 17:47:46 +0000 (UTC)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8800AAF
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 10:47:45 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c5bbb205e3so23314065ad.0
        for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 10:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695404865; x=1696009665; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s3WBfS9k0hhwa67Mh2traYG0/caEY7Z1Kl5Zw3aenPM=;
        b=eZGn300fALXHBzTEYhiuww5jSfgZU/SkTh3yG6cGevosV7LUIcJ/r3K1yTU9TCfvaW
         jSlA1mzmTlSafx/FpZ8Pl5wQ87YROOLRPFRy7YGl7CHr8BglM62P7GFxGkzIkqPywofs
         tR3X5nt+Yj9J+lw3ocbqQH5QdUZfoOA1RPsjKJlvN30vDsNtkBxDzdi3PdwPNtHdzXMx
         q9tFX2Q0BTynvkRQEuBAN3cGsumsJXnb+M10MOvfSX4kwtyMGySxEwlHSz+MGtdNwNU/
         itE9WSbSP/pqQJ0jBZEd5mLUpdqPWR8v8uONOD6jWIVJZAxmRPPWuESQH4wrVSB22X4x
         +uCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695404865; x=1696009665;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s3WBfS9k0hhwa67Mh2traYG0/caEY7Z1Kl5Zw3aenPM=;
        b=grY5WOP45EKeGiRPYrFj+fC4Nv2+X0l++DcG4Lptc7mB8kS/f2Dn82jMTq/sWbgcfy
         aClTtMAAj0gXHBdFrWLiBglQKloBI9m/NysbqRIpy+cNfYQDlF4BP9Gmk7FSA4c2WFYg
         tSoBhCGWO0zqVyUjJUcwzqVCSLPrBh7Df0zs58VsG8PB5jnbRzJHRcpZszs09sWz7cDJ
         mAUy4MbYsnWqhUZM2DWArFgM76Oa+aWZ7KdtFy69FUxawHs5t8BttJxV6ZwK48YCewOH
         70EgTLWHw0ji1rFl98G8mS06+rIm+fMDVq65zOSiRdGll5vDvH0dqyKIc71eH/tVd0U5
         zT/w==
X-Gm-Message-State: AOJu0Yx0VhYDVyx7o36A9x4amW0s3SF+td/mpEN1GVuvpNhUbOo9sZ0g
	d9wu9cKIwhYcVNvBuakfDcY=
X-Google-Smtp-Source: AGHT+IGiTsNNGReLNA+fZ+LRTwF+fm0dIFHVS8cy6iFkqFEKBeq5UzUdIbsuDRPtleoh0YpJUagIKw==
X-Received: by 2002:a17:902:a386:b0:1c3:9544:cf51 with SMTP id x6-20020a170902a38600b001c39544cf51mr127371pla.1.1695404864884;
        Fri, 22 Sep 2023 10:47:44 -0700 (PDT)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id e3-20020a170902b78300b001befac3b3cbsm3739610pls.290.2023.09.22.10.47.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Sep 2023 10:47:44 -0700 (PDT)
Message-ID: <763a584b-ead6-46fe-a50c-147ce5846768@gmail.com>
Date: Fri, 22 Sep 2023 10:47:41 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] mlxbf_gige: Fix intermittent no ip issue
Content-Language: en-US
To: Asmaa Mnebhi <asmaa@nvidia.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, olteanv@gmail.com
Cc: netdev@vger.kernel.org, davthompson@nvidia.com
References: <20230922173626.23790-1-asmaa@nvidia.com>
 <20230922173626.23790-3-asmaa@nvidia.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <20230922173626.23790-3-asmaa@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 9/22/2023 10:36 AM, Asmaa Mnebhi wrote:
> Although the link is up, there is no ip assigned on a setup with high background
> traffic. Nothing is transmitted nor received.
> The RX error count keeps on increasing. After several minutes, the RX error count
> stagnates and the GigE interface finally gets an ip.
> 
> The issue is in the mlxbf_gige_rx_init function. As soon as the RX DMA is enabled,
> the RX CI reaches the max of 128, and it becomes equal to RX PI. RX CI doesn't decrease
> since the code hasn't ran phy_start yet.
> 
> The solution is to move the rx init after phy_start.
> 
> Fixes: f92e1869d74e ("Add Mellanox BlueField Gigabit Ethernet driver")
> Signed-off-by: Asmaa Mnebhi <asmaa@nvidia.com>
> Reviewed-by: David Thompson <davthompson@nvidia.com>

This seems fine, but your description of the problem still looks like 
there may be a more fundamental ordering issue when you enable your RX 
pipe here.

It seems to me like you should enable it from "inner" as in closest to 
the CPU/DMA subsystem towards "outer" which is the MAC and finally the PHY.

It should be fine to enable your RX DMA as long as you keep the MAC's RX 
disabled, and then you can enable your MAC's RX enable and later start 
the PHY.
-- 
Florian

