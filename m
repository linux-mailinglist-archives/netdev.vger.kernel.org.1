Return-Path: <netdev+bounces-34557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E76527A4A1B
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 14:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 089D71C20C4D
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 12:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108981CF85;
	Mon, 18 Sep 2023 12:51:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7750938F8A
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 12:51:22 +0000 (UTC)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C8E116
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 05:50:58 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-402d0eda361so48758805e9.0
        for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 05:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1695041457; x=1695646257; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8/CKZf76FvH829n/FlHaZ0jzVCXaM8HcdsTT1GXRSfU=;
        b=lB26gYYbJTTbmC0HK6yy072Owydu2ZQyJ9065rj979nYXXYorv6lX6sgrcG1awyixo
         yVTBlTQ4C4UyLto7k1xxgzUsYphW/z6NwYYSQ5dElUmfS08UseD/U7V8i43DJLSJJUEx
         mjBvYjaUZxEmNAA3tCNh+V0CWJ1JTP/H8sF5oMKzaMLCM2KxIeJD0yoyTzGNGI0qRTCT
         0DQHZtK3qQxAXTLJDDY8VpLco00cfZC/ZVfs39LldWKUAogp9uBgCNJZADvxcHn3Z9xw
         enBOZ+5KYhsUMeelK1bQTto9LWVa3CWMxE97y7qWmTryDLmlLwGBIlN4lEIW1S2MN1XN
         Dp/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695041457; x=1695646257;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8/CKZf76FvH829n/FlHaZ0jzVCXaM8HcdsTT1GXRSfU=;
        b=FD3X6Q0vFK6F6qZygHCqCmJiJ6UGcKWbzc8ky7r4AvnZTc8I2xSLQqQt49tu6AXOMl
         AT/VgtoX9tsC6F29YC1OZgMiPDntnyAYkiVir62/6nw/uM4/gB0Xbo0d7l/CKSSuH8HQ
         asmb6a2fesh5VTkd93bEbkikKUzHqIVC61rEFQM6guWmNSdcx2p//EoypLOV12b687ea
         OredYXRhRocOx64ePLlB6lLod8setVtxciTufI1Z05amjuMYrcCntNTAqs25YRvxnGs/
         d07j70+kx3iwYqPoMDjkwsB5Q2W1DK1Aixl76pez+U2dMemBbE5Gs2mvR/ICfNIkNKzx
         mVEw==
X-Gm-Message-State: AOJu0YwT8lCL0kbFXjdv/+gqd69onR2ARc04SSi9fEIw7XWenxiN857c
	jIvovHGh4jq2T2iKMy+99I8xMQ==
X-Google-Smtp-Source: AGHT+IHKmxMEIBdwcPEbPoqrnSEn90OoWEnu1rsJ5gIbxWsnk/KrNhuOU/ha5PqsXpwwYj5Lf5LJBw==
X-Received: by 2002:a05:600c:221a:b0:3fa:97ad:2ba5 with SMTP id z26-20020a05600c221a00b003fa97ad2ba5mr8253161wml.31.1695041456573;
        Mon, 18 Sep 2023 05:50:56 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id j21-20020adfd215000000b003179d7ed4f3sm9252026wrh.12.2023.09.18.05.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 05:50:55 -0700 (PDT)
Date: Mon, 18 Sep 2023 14:50:54 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Ziyang Xuan <william.xuanziyang@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org, liuhangbin@gmail.com
Subject: Re: [PATCH net v5] team: fix null-ptr-deref when team device type is
 changed
Message-ID: <ZQhHrqr1IKSQiomB@nanopsycho>
References: <20230918123011.1884401-1-william.xuanziyang@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230918123011.1884401-1-william.xuanziyang@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Mon, Sep 18, 2023 at 02:30:11PM CEST, william.xuanziyang@huawei.com wrote:
>Get a null-ptr-deref bug as follows with reproducer [1].
>
>BUG: kernel NULL pointer dereference, address: 0000000000000228
>...
>RIP: 0010:vlan_dev_hard_header+0x35/0x140 [8021q]
>...
>Call Trace:
> <TASK>
> ? __die+0x24/0x70
> ? page_fault_oops+0x82/0x150
> ? exc_page_fault+0x69/0x150
> ? asm_exc_page_fault+0x26/0x30
> ? vlan_dev_hard_header+0x35/0x140 [8021q]
> ? vlan_dev_hard_header+0x8e/0x140 [8021q]
> neigh_connected_output+0xb2/0x100
> ip6_finish_output2+0x1cb/0x520
> ? nf_hook_slow+0x43/0xc0
> ? ip6_mtu+0x46/0x80
> ip6_finish_output+0x2a/0xb0
> mld_sendpack+0x18f/0x250
> mld_ifc_work+0x39/0x160
> process_one_work+0x1e6/0x3f0
> worker_thread+0x4d/0x2f0
> ? __pfx_worker_thread+0x10/0x10
> kthread+0xe5/0x120
> ? __pfx_kthread+0x10/0x10
> ret_from_fork+0x34/0x50
> ? __pfx_kthread+0x10/0x10
> ret_from_fork_asm+0x1b/0x30
>
>[1]
>$ teamd -t team0 -d -c '{"runner": {"name": "loadbalance"}}'
>$ ip link add name t-dummy type dummy
>$ ip link add link t-dummy name t-dummy.100 type vlan id 100
>$ ip link add name t-nlmon type nlmon
>$ ip link set t-nlmon master team0
>$ ip link set t-nlmon nomaster
>$ ip link set t-dummy up
>$ ip link set team0 up
>$ ip link set t-dummy.100 down
>$ ip link set t-dummy.100 master team0
>
>When enslave a vlan device to team device and team device type is changed
>from non-ether to ether, header_ops of team device is changed to
>vlan_header_ops. That is incorrect and will trigger null-ptr-deref
>for vlan->real_dev in vlan_dev_hard_header() because team device is not
>a vlan device.
>
>Cache eth_header_ops in team_setup(), then assign cached header_ops to
>header_ops of team net device when its type is changed from non-ether
>to ether to fix the bug.
>
>Fixes: 1d76efe1577b ("team: add support for non-ethernet devices")
>Suggested-by: Hangbin Liu <liuhangbin@gmail.com>
>Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>
>Signed-off-by: Ziyang Xuan <william.xuanziyang@huawei.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

