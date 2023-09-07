Return-Path: <netdev+bounces-32386-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 730F0797381
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 17:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A360281615
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 15:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F2C11CB5;
	Thu,  7 Sep 2023 15:26:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8D023C3
	for <netdev@vger.kernel.org>; Thu,  7 Sep 2023 15:26:15 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E612B1BF5
	for <netdev@vger.kernel.org>; Thu,  7 Sep 2023 08:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694100302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EzgzM51wuqt8C8617Fq4H1cU6E4M87rAYnNP9DVNC3k=;
	b=RdI5fUMR5xg8tPmFt26ZxXYPg3EaVpXUTJSqkU8YHeXi7oIe/ConCGakfCfiwKdO50smaF
	A36WvFKCdglTPRg8oOOi/IPY75VeL/pdztdrvO2IJ6wYHI/3an6DXSvDGf9B58G5bi3NFP
	xc3/A/vlQDefDcqDiUxfBFV1z88pzzc=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-Skf5DIidP7y5YdrmG9G_ng-1; Thu, 07 Sep 2023 11:14:36 -0400
X-MC-Unique: Skf5DIidP7y5YdrmG9G_ng-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-565ece76be4so1358732a12.2
        for <netdev@vger.kernel.org>; Thu, 07 Sep 2023 08:14:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694099675; x=1694704475;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EzgzM51wuqt8C8617Fq4H1cU6E4M87rAYnNP9DVNC3k=;
        b=dnEPHS9ITxKQR5HqJcrpL8RqFsLoGpnD/O3IrV4nLTPJlHF1bvIfZb+dUgEFTgDf5L
         nyYeOco6nH9HiJk/HrToh3q0W7dceCUPV3AAb4JyFVecOV/oDVKqbgwlFyyqOQtk7lRN
         5Zv4kC6WaTjJ+jjbwQYHiCjnqHHzGoL4oeAC2BsBlmscnZ77A8YTIJREeHto//CJmTO7
         KFfCjz5wAI6eOOj2N4B0PxW+9F612ezTPEbG9qSBDEJ2ldxWQtq1ZWoC+DfecMyjjoys
         Opy8S0jQKmQTkFlPvGJDIc5f1/EPUhzSaq1CddU7Q5ku53qgLcn4N50ZkFBMC5JfpMsa
         g9FQ==
X-Gm-Message-State: AOJu0Yy7AJs487owe19YCSl1Fv1YBG9xPejinD8lEdA66O3a7ukSi27b
	J0jeBgOeJGDXBEj8vr3tPCxqCCBa/PgSPD8wqZxL9O9hL/9bKcb9pFO8h5MmTGg7VB9c2vaz9t1
	NkXdJ1bt7HVwEYVoU
X-Received: by 2002:a05:6a20:8f28:b0:135:7975:f55 with SMTP id b40-20020a056a208f2800b0013579750f55mr25001694pzk.47.1694099674972;
        Thu, 07 Sep 2023 08:14:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVQZ0PpMYduIqy2XCFAwLIRK7WRSduaYQejMCEpIsM/XsBZDGQZr9Qa3gcn9gYsI7BGuyCng==
X-Received: by 2002:a05:6a20:8f28:b0:135:7975:f55 with SMTP id b40-20020a056a208f2800b0013579750f55mr25001674pzk.47.1694099674694;
        Thu, 07 Sep 2023 08:14:34 -0700 (PDT)
Received: from ?IPV6:240d:1a:c0d:9f00:da32:73f2:fb54:908a? ([240d:1a:c0d:9f00:da32:73f2:fb54:908a])
        by smtp.gmail.com with ESMTPSA id e14-20020a62aa0e000000b0065980654baasm12600581pff.130.2023.09.07.08.14.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Sep 2023 08:14:34 -0700 (PDT)
Message-ID: <c325598f-2324-0891-a3a1-ab0305d05df7@redhat.com>
Date: Fri, 8 Sep 2023 00:14:30 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net] kcm: Fix memory leak in error path of kcm_sendmsg()
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+6f98de741f7dbbfc4ccb@syzkaller.appspotmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org
References: <20230902165216.1721082-1-syoshida@redhat.com>
 <279a856aa6710becf9ebb13ab74e7afb6add0045.camel@redhat.com>
Content-Language: en-US
From: Shigeru Yoshida <syoshida@redhat.com>
In-Reply-To: <279a856aa6710becf9ebb13ab74e7afb6add0045.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Paolo,

On 9/5/23 17:09, Paolo Abeni wrote:
> Hello,
> 
> On Sun, 2023-09-03 at 01:52 +0900, Shigeru Yoshida wrote:
>> syzbot reported a memory leak like below [1]:
>>
>> BUG: memory leak
>> unreferenced object 0xffff88810b088c00 (size 240):
>>   comm "syz-executor186", pid 5012, jiffies 4294943306 (age 13.680s)
>>   hex dump (first 32 bytes):
>>     00 89 08 0b 81 88 ff ff 00 00 00 00 00 00 00 00  ................
>>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>   backtrace:
>>     [<ffffffff83e5d5ff>] __alloc_skb+0x1ef/0x230 net/core/skbuff.c:634
>>     [<ffffffff84606e59>] alloc_skb include/linux/skbuff.h:1289 [inline]
>>     [<ffffffff84606e59>] kcm_sendmsg+0x269/0x1050 net/kcm/kcmsock.c:815
>>     [<ffffffff83e479c6>] sock_sendmsg_nosec net/socket.c:725 [inline]
>>     [<ffffffff83e479c6>] sock_sendmsg+0x56/0xb0 net/socket.c:748
>>     [<ffffffff83e47f55>] ____sys_sendmsg+0x365/0x470 net/socket.c:2494
>>     [<ffffffff83e4c389>] ___sys_sendmsg+0xc9/0x130 net/socket.c:2548
>>     [<ffffffff83e4c536>] __sys_sendmsg+0xa6/0x120 net/socket.c:2577
>>     [<ffffffff84ad7bb8>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>>     [<ffffffff84ad7bb8>] do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
>>     [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
>>
>> In kcm_sendmsg(), newly allocated socket buffers can be added to skb->next. If
>> an error occurred and jumped to out_error label, those newly allocated socket
>> buffers can be leaked. This patch fixes this issue by remembering the last
>> allocated socket buffer in kcm_tx_msg(head)->last_skb.
> 
> I think the root cause should be clarified a little more. When the
> 'head' skb will be freed, all the frag_list skbs will be released, too.
> 
> AFAICS the issue is that in case of error after copying some bytes,
> kcm_tx_msg(head)->last_skb is left unmodified and such reference is
> used as the cursor to append newly allocated skbs to 'head'.
> 
> A later kcm_sendmsg will use an obsoleted 'last_skb' reference,
> corrupting the 'head' frag_list and causing the leak.
> 
> The fix looks correct, but could you please send a v2 with an
> updated/more extensive commit message?

Thank you so much for your feedback. Yes, I'll send a v2 patch
with the detailed root cause.

> 
>> Link: https://syzkaller.appspot.com/bug?extid=6f98de741f7dbbfc4ccb [1]
>> Reported-by: syzbot+6f98de741f7dbbfc4ccb@syzkaller.appspotmail.com
>> Fixes: ab7ac4eb9832 ("kcm: Kernel Connection Multiplexor module")
>> Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
> 
> Additionally please feed the patch to syzbot, so it can verify the fix,
> and add the relevant tag.

I got it. I'll try syzbot for the v2 patch.

Thanks,
Shigeru

> 
> Thanks,
> 
> Paolo
> 


