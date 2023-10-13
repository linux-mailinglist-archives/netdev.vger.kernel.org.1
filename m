Return-Path: <netdev+bounces-40571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6B17C7B17
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 03:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F2D81C20986
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 01:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A7E807;
	Fri, 13 Oct 2023 01:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="HS+h4Wa+"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D155371
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 01:13:23 +0000 (UTC)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E76ECF
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 18:13:21 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6b390036045so4502b3a.1
        for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 18:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1697159601; x=1697764401; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AMJnEzubrAnZX3cVNcFw4aHCDFoa3PCcaOxjV6VRS+0=;
        b=HS+h4Wa+IMVdFNCYi7/E0nXCEJ1TZmq/beUe+MUTtTEz9k+LNI72O23j3yAqrIGCAk
         eGlTxrVhgYNU6P3aiD++90HTaT+0JCZp4hiF4npfLZBUZ13gtjjbqS2a5gKqJ9/x/Kk4
         eRfTTZNZQfB70JGf+/YVk4v8k3kj/Vc07za/DukVP3HDPBaw39Fyb/F4EYpxJIGpgVWw
         F0E4vzTHXTUqISzY8Fk8WrmEn7Z2PCml5eqxiWBzZg2zx5M69ZIbGTnL/rDTHLbU4x0H
         vio3fLQYqttWGLtq0m9AvOgact3R7wNBIuxc7PYawZ3k0W88kCq3c7dybu118RTTBMkQ
         OFlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697159601; x=1697764401;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AMJnEzubrAnZX3cVNcFw4aHCDFoa3PCcaOxjV6VRS+0=;
        b=hTCdWBEcgXHgdwTb6W0X/Vbe0Jn95gyioqFCeYRm7rADfB7R9t4BZXP2CTKazs3nT7
         8KUAa0hdp7OJvROy1cHZZya+HiN6D3mHhxz0CvC0gzr4jSRq7fGYfhLH1v+kkoeyo1Rh
         8uAbyUbypFPc+uag7AqXDTM67Gluvy+6nOQ8LVybJ6X7GFP1SY3AW4epQl9LD9ZMUMfF
         cY85pwl0txyPG6YWjAlyfi6Cw04OzJWUAJmMcodFyq5ow0z3iSjp53q+8/S1g3f67Wyz
         xHMewQKRFY/GqVQd0sNviwEsxk13J7fgM04KdJanjxALusHiJu2rAqxmCVh2FcIHOOuF
         U4qg==
X-Gm-Message-State: AOJu0Yzt711isPIe4nWVIeS51q4FJ4o3ZOyMey0iAeA9lCpwLhq4H4c+
	OnpyhMMoRa6j4k0z+eRmhLrFKQ==
X-Google-Smtp-Source: AGHT+IGc+d2JugU+MHcVUHJCaPcCzHDdV/urgEHeZ1XguR5+TY2m8N4g6nJqszpdq75fyut+u173Ew==
X-Received: by 2002:a05:6a20:7d85:b0:163:57ba:2ad4 with SMTP id v5-20020a056a207d8500b0016357ba2ad4mr30560645pzj.2.1697159600617;
        Thu, 12 Oct 2023 18:13:20 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id jj3-20020a170903048300b001c9cc44eb60sm2610748plb.201.2023.10.12.18.13.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 18:13:19 -0700 (PDT)
Message-ID: <8b200d4c-6c28-47f6-b43d-98ed10a9b4f5@kernel.dk>
Date: Thu, 12 Oct 2023 19:13:18 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Problem with io_uring splice and KTLS
Content-Language: en-US
To: Sascha Hauer <sha@pengutronix.de>
Cc: Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@pengutronix.de,
 Boris Pismenny <borisp@nvidia.com>, John Fastabend
 <john.fastabend@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org
References: <20231010141932.GD3114228@pengutronix.de>
 <d729781a-3d12-423b-973e-c16fdbcbb60b@kernel.dk>
 <20231012133407.GA3359458@pengutronix.de>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20231012133407.GA3359458@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/12/23 7:34 AM, Sascha Hauer wrote:
> On Tue, Oct 10, 2023 at 08:28:13AM -0600, Jens Axboe wrote:
>> On 10/10/23 8:19 AM, Sascha Hauer wrote:
>>> Hi,
>>>
>>> I am working with a webserver using io_uring in conjunction with KTLS. The
>>> webserver basically splices static file data from a pipe to a socket which uses
>>> KTLS for encryption. When splice is done the socket is closed. This works fine
>>> when using software encryption in KTLS. Things go awry though when the software
>>> encryption is replaced with the CAAM driver which replaces the synchronous
>>> encryption with a asynchronous queue/interrupt/completion flow.
>>>
>>> So far I have traced it down to tls_push_sg() calling tcp_sendmsg_locked() to
>>> send the completed encrypted messages. tcp_sendmsg_locked() sometimes waits for
>>> more memory on the socket by calling sk_stream_wait_memory(). This in turn
>>> returns -ERESTARTSYS due to:
>>>
>>>         if (signal_pending(current))
>>>                 goto do_interrupted;
>>>
>>> The current task has the TIF_NOTIFY_SIGNAL set due to:
>>>
>>> io_req_normal_work_add()
>>> {
>>>         ...
>>>         /* This interrupts sk_stream_wait_memory() (notify_method == TWA_SIGNAL) */
>>>         task_work_add(req->task, &tctx->task_work, ctx->notify_method)))
>>> }
>>>
>>> The call stack when sk_stream_wait_memory() fails is as follows:
>>>
>>> [ 1385.428816]  dump_backtrace+0xa0/0x128
>>> [ 1385.432568]  show_stack+0x20/0x38
>>> [ 1385.435878]  dump_stack_lvl+0x48/0x60
>>> [ 1385.439539]  dump_stack+0x18/0x28
>>> [ 1385.442850]  tls_push_sg+0x100/0x238
>>> [ 1385.446424]  tls_tx_records+0x118/0x1d8
>>> [ 1385.450257]  tls_sw_release_resources_tx+0x74/0x1a0
>>> [ 1385.455135]  tls_sk_proto_close+0x2f8/0x3f0
>>> [ 1385.459315]  inet_release+0x58/0xb8
>>> [ 1385.462802]  inet6_release+0x3c/0x60
>>> [ 1385.466374]  __sock_release+0x48/0xc8
>>> [ 1385.470035]  sock_close+0x20/0x38
>>> [ 1385.473347]  __fput+0xbc/0x280
>>> [ 1385.476399]  ____fput+0x18/0x30
>>> [ 1385.479537]  task_work_run+0x80/0xe0
>>> [ 1385.483108]  io_run_task_work+0x40/0x108
>>> [ 1385.487029]  __arm64_sys_io_uring_enter+0x164/0xad8
>>> [ 1385.491907]  invoke_syscall+0x50/0x128
>>> [ 1385.495655]  el0_svc_common.constprop.0+0x48/0xf0
>>> [ 1385.500359]  do_el0_svc_compat+0x24/0x40
>>> [ 1385.504279]  el0_svc_compat+0x38/0x108
>>> [ 1385.508026]  el0t_32_sync_handler+0x98/0x140
>>> [ 1385.512294]  el0t_32_sync+0x194/0x198
>>>
>>> So the socket is being closed and KTLS tries to send out the remaining
>>> completed messages.  From a splice point of view everything has been sent
>>> successfully, but not everything made it through KTLS to the socket and the
>>> remaining data is sent while closing the socket.
>>>
>>> I vaguely understand what's going on here, but I haven't got the
>>> slightest idea what to do about this. Any ideas?
>>
>> Two things to try:
>>
>> 1) Depending on how you use the ring, set it up with
>> IORING_SETUP_SINGLE_ISSUER | IORING_SETUP_DEFER_TASKRUN. The latter will
>> avoid using signal based task_work notifications, which may be messing
>> you up here.
>>
>> 2) io_uring will hold a reference to the file/socket. I'm unsure if this
>> is a problem in the above case, but sometimes it'll prevent the final
>> flush.
>>
>> Do you have a reproducer that could be run to test? Sometimes easier to
>> see what's going on when you can experiment, it'll save some time.
> 
> Okay, here is a reproducer:
> 
> https://github.com/saschahauer/webserver-uring-test.git
> 
> Execute ./prepare.sh in that repository, it will compile the webserver,
> generate cert.pem/key.pem and generate some testfile to download. If the
> meson build doesn't work for you then you can compile the program by
> hand with something like:
> 
> gcc -O3 -Wall -o webserver webserver_liburing.c -lcrypto -lssl -luring
> 
> When the webserver is started you can get a file from it with:
> 
> curl -k https://<ipaddr>:8443/foo -o foo
> 
> or:
> 
> while true; do curl -k https://<ipaddr>:8443/foo -o foo; if [ $? != 0 ]; then break; fi; done
> 
> This should run without problems as by default likely the encryption
> requests are running synchronously.
> 
> In case you don't have encryption hardware you can create an
> asynchronous encryption module using cryptd. Compile a kernel with
> CONFIG_CRYPTO_USER_API_AEAD and CONFIG_CRYPTO_CRYPTD and start the
> webserver with the '-c' option. /proc/crypto should then contain an
> entry with:
> 
>  name         : gcm(aes)
>  driver       : cryptd(gcm_base(ctr(aes-generic),ghash-generic))
>  module       : kernel
>  priority     : 150
> 
> Make sure there is no other module providing gcm(aes) with a priority higher
> than 150 so that this one is actually used.
> 
> With that the while true loop above should break out with a short read
> fairly fast. Passing IORING_SETUP_SINGLE_ISSUER | IORING_SETUP_DEFER_TASKRUN
> to io_uring_queue_init() makes it harder to reproduce for me. With that
> I need multiple shells in parallel running the above loop.
> 
> The repository also contains a kernel patch which will provide you a
> stack dump when KTLS gets an error from tcp_sendmsg_locked().
> 
> Now I hope I haven't done anything silly in the webserver ;)

Perfect! Thanks a lot for preparing all of that. Not sure I'll get to it
tomorrow, but if not, then definitely on Monday.

-- 
Jens Axboe


