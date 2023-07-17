Return-Path: <netdev+bounces-18273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6AC75631F
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 14:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13F131C204DA
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 12:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D67D3AD28;
	Mon, 17 Jul 2023 12:50:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8148F7D
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 12:50:20 +0000 (UTC)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C497B1
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 05:50:19 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-98e011f45ffso557874666b.3
        for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 05:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689598218; x=1692190218;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VXY8LWzOXkO15LAkf3ukrJX/gFcbS9p0/sb0+g/HqwI=;
        b=ag13iQtd3EGXjUrpckF/gdtHJLquqV1QUaLCIp8eZDrI/GdmN9eAoMhqGCmb8AMWla
         +YO3yfIwvem++OPFhWOg3l3IqQa+rl1e2IO9AtIqfZBCLCKW9YAWZCNiqx1GlI3sOoP/
         CcDxQjn+Of9ZXbcX3wDDxzXVMOAZ0tSZ8gKbkcG4YI7STbUGUDzZfRAzrasVO7jfRCS5
         fGhYy+HHiwuK5mgiyfhYd4CmJvkzvpofNFDm07/hHQp51qxE2eJGm0fzcjjFOeWhGcGZ
         riWb4dExe5X4LcD4r5ZqvSxH3+xuxENwELVmgGDTMsgNzpjjO5wEFbcWG8mb/z4X5A5A
         gl0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689598218; x=1692190218;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VXY8LWzOXkO15LAkf3ukrJX/gFcbS9p0/sb0+g/HqwI=;
        b=gxiCz5kbNerBEKxzUDjH//FLVHG/RwHT29v0EilEPmEXp2zpUk9uxj2P2qgNGaA0bb
         wJ0lwp7M7dyDDFAkmG3EuZUziHReI/esl627aBkIydjFK7Fz+tU0kZkrkTfOUqmA4zdH
         PFV+gV1ZK37TIRgNWc6lLPjBzyU9bJylPrmFUGn3cTUTcQadC+dQ/RCaRcqYX+Mxy4k/
         vvLqZsv/jsedlH+Tww5o020CUQOXvUxDyNoKU7oz5v0yApGd6zYxq+DsldZkjxKBC0Ub
         G1EreGp2XZok5+Su6CoRkW8z1Q58htrQHhGMjS4+lmz9BQt2xYQ8aJ1kimXdPWyB8iE6
         g89Q==
X-Gm-Message-State: ABy/qLYF6NEE6AHF9UnjLnyOQMDnEvEk3Ln7uWQO5bgWeRb3zR+X0zI8
	1ZZMMqDUAvOrpM4tDEhy+YO5zjTWSOA=
X-Google-Smtp-Source: APBJJlH2vveA0UHszgoW9UvTKrkhYkfr2Y5V8I4xbVG1m56CJaujdBs+qAGA72k4qGGJSM6iYgt4Iw==
X-Received: by 2002:a17:906:4f99:b0:95e:d3f5:3d47 with SMTP id o25-20020a1709064f9900b0095ed3f53d47mr8814983eju.48.1689598217602;
        Mon, 17 Jul 2023 05:50:17 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:310::206f? ([2620:10d:c092:600::2:5c67])
        by smtp.gmail.com with ESMTPSA id hh10-20020a170906a94a00b0098866a94f14sm9148271ejb.125.2023.07.17.05.50.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 05:50:17 -0700 (PDT)
Message-ID: <2bf18f5b-9539-e706-b887-3de330950061@gmail.com>
Date: Mon, 17 Jul 2023 13:34:04 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: selftest io_uring_zerocopy_tx.sh failed on VM
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org
References: <ZLS/iWz+gF0/PGyR@Laptop-X1>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <ZLS/iWz+gF0/PGyR@Laptop-X1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/17/23 05:11, Hangbin Liu wrote:
> Hi Pavel,
> 
> I tried to run test selftest io_uring_zerocopy_tx.sh on VM, but it failed
> with error like
> 
> + ip netns exec ns-45iLeE2 ./msg_zerocopy -4 -t 2 -C 2 -S 192.168.1.1 -D 192.168.1.2 -r udp
> cpu: unable to pin, may increase variance.
> + ip netns exec ns-45iLeE1 ./io_uring_zerocopy_tx -4 -t 1 -D 192.168.1.2 -m 1 -t 1 -n 32 udp
> ./io_uring_zerocopy_tx: io_uring: queue init: Unknown error -13
> 
> Do you know what's the reason? Should we update the test script to return
> SKIP if io_uring init failed?

I don't recall anything that can fail ring init with EACCES, probably
sth in your system disables io_uring with some syscall filters or so.
I think skipping the trace on EACCES is the right approach. Do you want
to send a patch?
Apart from that, if you're curious you can try to trace what's going on,
ftrace should give an idea.

-- 
Pavel Begunkov

