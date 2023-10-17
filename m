Return-Path: <netdev+bounces-41671-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9553D7CB964
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 05:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF10D1C2092A
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 03:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B9B944F;
	Tue, 17 Oct 2023 03:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W4+iC3aX"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2707E8825
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 03:46:22 +0000 (UTC)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB3B83
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 20:46:21 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-7742be66bd3so375397085a.3
        for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 20:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697514381; x=1698119181; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mHJw8P34NYYZd1Uvjh9ufsG7drPwBVhxEzkmy4CiHIg=;
        b=W4+iC3aXcaOBWBRcGfig98UhE4QkCeLZmKaZFru0Bg/XNXXewwlslW1D407tcobYDR
         v+YHeKFd6/mvHKQwA9EOuV4xy4dQGrRa07XuWEXpNhyt9CU3AjYV18tqOdp6TfSli4z6
         S97Yi4SmfWzYZOWYW0OVqDLoPAmxp8+fP6eKwirHlmF56smVR5xXVGt0BHUKPdWcM7PV
         n9wWi3NIxlVtZrQGkUALW/uR1SEdV4PWDHTot7c6felwaAgVVVMmZv+hR7HWdV0FdqOp
         ZKDQ/8/EtDUm/MsdqWWeNrcYQCwJEhS+g7S9Oc9PNWUlJLpHzGDJ7eAhqLdgAFRrhsNz
         BT/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697514381; x=1698119181;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mHJw8P34NYYZd1Uvjh9ufsG7drPwBVhxEzkmy4CiHIg=;
        b=WwoXBnNVdpGIsBpYs8YXDImGIZSe1EPVPbT+AlblyIMb4BqzXxJmKBvH2wJ/olwnF9
         E1FjruRd/wvv5wFqX+1uLy2VbRgx+1e0kc80DrPWnGNWNMhvBzr6QMtkG8n1q9JpNg9A
         bhfBO+u0RVQQ0JSby7NE2GBPl7r3SmYxBvy8mvgaGBlf7WXM+eOhYucYyUKvz+AvzujZ
         kssyfVhLu77dsNXthV7NTPWWHBBM8CNVi7IAZPyiZO63JT5sl/3OuYsiovxc28BRkJGA
         83rBb17qaNs/dibHdoKteEhzaq4P4lkn/diSXbkkumMj7vTWsgqXRkhXaz4FlKkiTPyJ
         WMkg==
X-Gm-Message-State: AOJu0YxnvdxwaB9uMXATGbZODF2fEGGjfd1IpKNVlykEJEp6B+pTxWJH
	ZYLUxQTYvszPhPIolkPoOh4=
X-Google-Smtp-Source: AGHT+IH2YD9VsAA2DLjUPO9fz+Sz037vftBPuJ0D/zv1OKDflZm1ztaer+T4VtU9iNepDmUe+KkXWw==
X-Received: by 2002:ad4:5f89:0:b0:66d:1d22:42d8 with SMTP id jp9-20020ad45f89000000b0066d1d2242d8mr1807216qvb.11.1697514380852;
        Mon, 16 Oct 2023 20:46:20 -0700 (PDT)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id b12-20020a0cb3cc000000b00658266be23fsm239208qvf.41.2023.10.16.20.46.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 20:46:18 -0700 (PDT)
Message-ID: <0807165f-3805-4f45-b4f6-893cf8480508@gmail.com>
Date: Mon, 16 Oct 2023 20:46:15 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 0/5] Analyze and Reorganize core Networking
 Structs to optimize cacheline consumption
Content-Language: en-US
To: Coco Li <lixiaoyan@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>,
 Mubashir Adnan Qureshi <mubashirq@google.com>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Chao Wu <wwchao@google.com>,
 Wei Wang <weiwan@google.com>
References: <20231017014716.3944813-1-lixiaoyan@google.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <20231017014716.3944813-1-lixiaoyan@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 10/16/2023 6:47 PM, Coco Li wrote:
> Currently, variable-heavy structs in the networking stack is organized
> chronologically, logically and sometimes by cache line access.
> 
> This patch series attempts to reorganize the core networking stack
> variables to minimize cacheline consumption during the phase of data
> transfer. Specifically, we looked at the TCP/IP stack and the fast
> path definition in TCP.
> 
> For documentation purposes, we also added new files for each core data
> structure we considered, although not all ended up being modified due
> to the amount of existing cache line they span in the fast path. In
> the documentation, we recorded all variables we identified on the
> fast path and the reasons. We also hope that in the future when
> variables are added/modified, the document can be referred to and
> updated accordingly to reflect the latest variable organization.

This is great stuff, while Eric mentioned this work during Netconf'23 
one concern that came up however is how can we make sure that a future 
change which adds/removes/shuffles members in those structures is not 
going to be detrimental to the work you just did? Is there a way to 
"lock" the structure layout to avoid causing performance drops?

I suppose we could use pahole before/after for these structures and 
ensure that the layout on a cacheline basis remains preserved, but that 
means adding custom scripts to CI.
-- 
Florian

