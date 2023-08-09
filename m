Return-Path: <netdev+bounces-25985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F06227765D3
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 18:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB38C281DDF
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 16:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA661CA0D;
	Wed,  9 Aug 2023 16:55:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FD119BA1
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 16:55:16 +0000 (UTC)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09032108
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 09:55:14 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-99bdcade7fbso10999066b.1
        for <netdev@vger.kernel.org>; Wed, 09 Aug 2023 09:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1691600113; x=1692204913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sEEzkpRk4R5ngJk0sdsY4jksrqnBMmsAjfH4cPZ0Ceo=;
        b=LXifjXMjDkY+9vzyXyHF446KTFEVUBCGm6SxFbnjl7ZrDNlY8xnmabEJVxUW+ush49
         KKTZgh4/nppv9HRYHadUjsFyw9RkxQOq/WYrOfj40CU1EJmV4qLnVT7Fpbp1G3xyg2fg
         zVqg5l9IodUOMREAVjo0vXijlwzjHBQA0wc0IWOklIJ8xy95jxtpJkoZvFOJB1AhDlEE
         8yQb/0zN3SLbB54vF7iBeSO7+HaQszGc6LK35twMKAIV0gwa+L4NPOQr+nfUGIkvZbpE
         lTIBmsDwhaoOWEVeDVVn9FsSV6LTT5lELwKU13KV5VSCwyHi9BXIY5r0CWNQscVo3R7D
         VHPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691600113; x=1692204913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sEEzkpRk4R5ngJk0sdsY4jksrqnBMmsAjfH4cPZ0Ceo=;
        b=GoodFtfC3gmYN/kyuIHIiJsN6Z+VD/SpNvzY1doMQt7Se9vNteGaSILZAIfhQFO1lo
         K+JVuZNYHn85BG4gzDCU0ajxeyKeXXrftgN/OTuD2hPflLa5bwzglOSP3I2Rd9xCSdmL
         lZt3+JNTEZKau+qgJcK0scqPIaAOR+WgLS5vIUFGgSVSmYFKkgIz+NvXqzh+HDGP3HWL
         su0Ha3g4YSKPiI8EX3JGHezzgGdENAFkyt42thlqyu5rYg7w+JX3fmziv36mfnRpUe4N
         2duyoDfL1QYP1uiU6r9maFsR/n7sSJAVzPmNwxpklCq6qMk9V8XZb1hbTslVbCR1slwo
         f2wQ==
X-Gm-Message-State: AOJu0YxsOirbZjfsLZ7vCdRrOgjfedwOTXoAdgHp4EUw3HBB/Sqz4xvQ
	i40dgnKA8yiWsGDYwSBNsF+/VC8+ZElKd8uC7+tpYw==
X-Google-Smtp-Source: AGHT+IF7dM2eXGn6dRXYNXBc36kPTeydH1cLQHZ69WdeM57HrUxewNW65BPbYowzY8vRF7JfnkGpiq0tLQV/ExDslXY=
X-Received: by 2002:a17:907:78d9:b0:974:183a:54b6 with SMTP id
 kv25-20020a17090778d900b00974183a54b6mr2328010ejc.33.1691600113512; Wed, 09
 Aug 2023 09:55:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAN+4W8hMpL3+vNOrBBRw01tD6OxQ-Yy8OWpq9nRtiyjm0GgE4g@mail.gmail.com>
 <20230809155538.67000-1-kuniyu@amazon.com>
In-Reply-To: <20230809155538.67000-1-kuniyu@amazon.com>
From: Lorenz Bauer <lmb@isovalent.com>
Date: Wed, 9 Aug 2023 17:55:02 +0100
Message-ID: <CAN+4W8h44UdLRT+QLdh2rNeiKg0AkPAuGtYuXOgtFzvT2kHsWg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] net: Fix slab-out-of-bounds in inet[6]_steal_sock
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	martin.lau@kernel.org, martin.lau@linux.dev, memxor@gmail.com, 
	netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 9, 2023 at 4:56=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.com=
> wrote:
>
> > Things we could do if necessary:
> > 1. Reset the flag in inet_csk_clone_lock like we do for SOCK_RCU_FREE
>
> I think we can't do this as sk_reuseport is inherited to twsk and used
> in inet_bind_conflict().

Ok, so what kind of state does reuseport carry in the various states then?

TCP_LISTEN: sk_reuseport && sk_reuseport_cb
TCP_ESTABLISHED: sk_reuseport && !sk_reuseport_cb
TCP_TIME_WAIT: sk_reuseport && !sk_reuseport_cb

Where is sk_reuseport_cb cleared? On clone? Or not at all?

> > 2. Duplicate the cb check into inet[6]_steal_sock
>
> or 3. Add sk_fullsock() test ?

I guess this would be in addition to the convoluted series of checks
I've removed in this patch?

