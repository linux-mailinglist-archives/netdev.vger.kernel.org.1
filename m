Return-Path: <netdev+bounces-41812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 567987CBF37
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 11:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F353281397
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 09:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69E23FB1C;
	Tue, 17 Oct 2023 09:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="XUNj/LdO"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A015C381D8
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 09:28:29 +0000 (UTC)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC79118
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 02:28:27 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-32d569e73acso4893824f8f.1
        for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 02:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1697534906; x=1698139706; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fmR/OA6GHqXdwt3EU1KKP2U+4kY4IagR5FLSW/2Uexs=;
        b=XUNj/LdO3Xo3CQRCe2nYbViiFqoUbs3Y+UG21mMufEkjpsr3PqgSbRXUI8WjIDKbCd
         EUFSXaY45oD/vzqcUbWxmY8DHnVEksHN76MBw9gjCG0kyzu67co3PWCO4dsyyGk5ssBZ
         MRlAYcWu086ykp+Qfwv92cJ5dSoeJcW/yk3iNY+n2Ww5bUn4pD9dsPvy2dvasvQ1NQ8T
         hn30yuvM59dhavMPNJY4a/dm8/I9LccFz+2y7KJF8tdY2Zhb/JSW6Xm4ICfKG9y1eszJ
         EgC9UunG1zJzWv1o24VBg0MledJt5ttbovivEwEQW4LvS5eo8w/Hoi0sgke/HuRDv/rZ
         u2Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697534906; x=1698139706;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fmR/OA6GHqXdwt3EU1KKP2U+4kY4IagR5FLSW/2Uexs=;
        b=UTzI2npNZOcEdEeryfaJT2n/ATN8RtVx96A15KviOJ0ymPLtmVexcHGeuNirPHjtzd
         pdAMgB8XUzGqpk7NfEU+Q89fsusn7DBDo9oWHtX9gUxWF0WYS4PWj8Sf+LGeiHNX3HTz
         3xuSn63q2A0u506jLNLF5tdqcf3iqqGeR1Qa+2c0/8zdz7X2UcZU9lwa2XABrAvoFUoY
         29hhMdVtnO3O8xqCfCQUNp83UM25SEyQ3s1DxsNigk32gBkWQNtDNEPXa6ArUSTZpcnz
         i5pX8F2hEA41clA1UyDCKEnaHf1LcqhcNo7CDsEj+s/9ThBMccpnL4GMUftCbjiA/2ga
         xLbw==
X-Gm-Message-State: AOJu0YxQINI2IMrkKAzvGn4BYu5mbcfyWuTupauYZ15x0Kgl9lP54Hw8
	hqKvFbifKYwP1WSTS95tXzIbKg==
X-Google-Smtp-Source: AGHT+IF9FQ0Xmt6YdT5juEFEBBZ1FdqPulxZzSfKnYATu/qCrQwrncAlLHnu6avsdX8AHwshBGNoyw==
X-Received: by 2002:a05:6000:ca:b0:32c:af13:9084 with SMTP id q10-20020a05600000ca00b0032caf139084mr1535648wrx.22.1697534906264;
        Tue, 17 Oct 2023 02:28:26 -0700 (PDT)
Received: from [192.168.0.106] (haunt.prize.volia.net. [93.72.109.136])
        by smtp.gmail.com with ESMTPSA id f1-20020a056000036100b003196b1bb528sm1268956wrf.64.2023.10.17.02.28.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 02:28:25 -0700 (PDT)
Message-ID: <8e25bfdc-de42-1f50-8e78-edff3d69dc49@blackwall.org>
Date: Tue, 17 Oct 2023 12:28:24 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH net-next 10/13] vxlan: mdb: Add MDB get support
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
 bridge@lists.linux-foundation.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, roopa@nvidia.com, mlxsw@nvidia.com
References: <20231016131259.3302298-1-idosch@nvidia.com>
 <20231016131259.3302298-11-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231016131259.3302298-11-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/16/23 16:12, Ido Schimmel wrote:
> Implement support for MDB get operation by looking up a matching MDB
> entry, allocating the skb according to the entry's size and then filling
> in the response.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>   drivers/net/vxlan/vxlan_core.c    |   1 +
>   drivers/net/vxlan/vxlan_mdb.c     | 150 ++++++++++++++++++++++++++++++
>   drivers/net/vxlan/vxlan_private.h |   2 +
>   3 files changed, 153 insertions(+)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>



