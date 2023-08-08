Return-Path: <netdev+bounces-25479-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52935774394
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 20:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83EA11C20F2A
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 18:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E0B171A1;
	Tue,  8 Aug 2023 18:02:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CC7171A0
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 18:02:43 +0000 (UTC)
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53FD47EF0
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 10:35:11 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-564fb0b4934so2639034a12.1
        for <netdev@vger.kernel.org>; Tue, 08 Aug 2023 10:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691516111; x=1692120911;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CbNixERlHqS43p9WnetIfE1bwp3ZFaI202y6cxjDISk=;
        b=BtYnibgAq7g0L/okVpcz1sm6OulXBZOLXW68YAi0kE94x5HCN7bWDWiYRWfi91svGo
         Xc79qQ233j8gXgGltAV/J8/uXgNtnFjybeQZD1f/61BdCanNXGvF03sIBuo0PLfw2n8V
         M74JpyhSFxtW15aRUBl8P3VcNB0wjFg/9n39VGQsWXzGFLdytSDGhhjl7u1Z6CtvJuZN
         /eAqJk8ulH9QCYWJViD5t8z1c0a8y4LlJj9wtw/p4CWVORUdKTqp/wxHXBJvv2h+a/vL
         8rWrgpPqCe+14Q5CE8cj3cirPO2rMueXgtfqCD0+VzHSYfmiNnwNXQhCV4TlIpQyV+Ie
         Hl0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691516111; x=1692120911;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CbNixERlHqS43p9WnetIfE1bwp3ZFaI202y6cxjDISk=;
        b=Q/3ef7H40cV7jVGW5G4+oNDGL3PQcswtLrx5L+Fv/Yc8zQzQkD94CR8bbEDtXpJYdu
         Ehhot1qvDNJ+6mFm/W0O87V/wVX7EvHjfIVMZ2riXz+dQb4qoj9baw+F2QM3DD+viqWE
         CHZo3XpqB9dOfoItLEzwopxZVQY46KY7qNPfm2pzwmNUTLGh41zA3o76vlSaqNNScSlh
         CTbYdX7jjdlVIJXEq+/6AwpmSc5FzvT3zzezrHAY1Ln5reibDLaW60QjYBq+AQJeQ63E
         y7bJVkdb7gvoTTAUwwwnb+AxALw6hCOtZWMRqX5FJ8XA1T8XavmQj36mdI6PM63pK5NW
         d43w==
X-Gm-Message-State: AOJu0YxvthO7Khnh4NejSpbPhXFQJevBmsJHR301q2aY3NJuyXvBUWWB
	jir3PFTbXV7M+nrrO1njTr3Wdrk=
X-Google-Smtp-Source: AGHT+IHneZnuNzdmec4p8IMznIadt3gvRYK8ETNwHwQuhWBeUw0E2l7zTwuivbDYUrt8/txQeEEsw9g=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a63:3443:0:b0:564:41a2:8d5a with SMTP id
 b64-20020a633443000000b0056441a28d5amr732pga.11.1691516110738; Tue, 08 Aug
 2023 10:35:10 -0700 (PDT)
Date: Tue, 8 Aug 2023 10:35:08 -0700
In-Reply-To: <20230808134049.1407498-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230808134049.1407498-1-leitao@debian.org>
Message-ID: <ZNJ8zGcYClv/VCwG@google.com>
Subject: Re: [PATCH v2 0/8] io_uring: Initial support for {s,g}etsockopt commands
From: Stanislav Fomichev <sdf@google.com>
To: Breno Leitao <leitao@debian.org>
Cc: axboe@kernel.dk, asml.silence@gmail.com, willemdebruijn.kernel@gmail.com, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	io-uring@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 08/08, Breno Leitao wrote:
> This patchset adds support for getsockopt (SOCKET_URING_OP_GETSOCKOPT)
> and setsockopt (SOCKET_URING_OP_SETSOCKOPT) in io_uring commands.
> SOCKET_URING_OP_SETSOCKOPT implements generic case, covering all levels
> nad optnames. On the other hand, SOCKET_URING_OP_GETSOCKOPT just
> implements level SOL_SOCKET case, which seems to be the
> most common level parameter for get/setsockopt(2).
> 
> struct proto_ops->setsockopt() uses sockptr instead of userspace
> pointers, which makes it easy to bind to io_uring. Unfortunately
> proto_ops->getsockopt() callback uses userspace pointers, except for
> SOL_SOCKET, which is handled by sk_getsockopt(). Thus, this patchset
> leverages sk_getsockopt() to imlpement the SOCKET_URING_OP_GETSOCKOPT
> case.
> 
> In order to support BPF hooks, I modified the hooks to use  sockptr, so,
> it is flexible enough to accept user or kernel pointers for
> optval/optlen.
> 
> PS1: For getsockopt command, the optlen field is not a userspace
> pointers, but an absolute value, so this is slightly different from
> getsockopt(2) behaviour. The new optlen value is returned in cqe->res.
> 
> PS2: The userspace pointers need to be alive until the operation is
> completed.
> 
> These changes were tested with a new test[1] in liburing. On the BPF
> side, I tested that no regression was introduced by running "test_progs"
> self test using "sockopt" test case.
> 
> [1] Link: https://github.com/leitao/liburing/blob/getsock/test/socket-getsetsock-cmd.c
> 
> RFC -> V1:
> 	* Copy user memory at io_uring subsystem, and call proto_ops
> 	  callbacks using kernel memory
> 	* Implement all the cases for SOCKET_URING_OP_SETSOCKOPT

I did a quick pass, will take a close look later today. So far everything makes
sense to me.

Should we properly test it as well?
We have tools/testing/selftests/bpf/prog_tests/sockopt.c which does
most of the sanity checks, but it uses regular socket/{g,s}etsockopt
syscalls. Seems like it should be pretty easy to extend this with
io_uring path? tools/testing/selftests/net/io_uring_zerocopy_tx.c
already implements minimal wrappers which we can most likely borrow.

