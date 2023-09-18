Return-Path: <netdev+bounces-34578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F57C7A4C95
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 17:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34B35281D55
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 15:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075131D6BA;
	Mon, 18 Sep 2023 15:36:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EA915494
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 15:36:22 +0000 (UTC)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 191B81718
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 08:34:19 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-34fc9b461b6so288875ab.1
        for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 08:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695051060; x=1695655860; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mbEG8R9Q06h7B+764hTxvj2PiYwwKknHP6xA5X1amj0=;
        b=gDP0gdBRLsLGRQQFArcVF0zBw565nl8PN8uYx8RNqygJI/xs+6n3s7XKaoMzC6TYEU
         oKqSrv+sOZxxHh7Cl5bNqBi3qsk0WCnvQAhLih705MaNo8SV0CeWgfR4e1BoJtOfC0Fc
         bY5lxRoHbFjJCwCQkGb5v+BID8P798t2cG2up2dQVV95HR4EwUqfPCao8uPoqs6gqKLm
         hKCLOpFE5tR27QlC/pnjHppXg66xPpGluINnNaednlqW2HOjmalmC1B9c6qraR7MsSE5
         1qQ6fUtf0QyqJauy338nahBAoSsp1jCIREtPdjrQo/3BJ92acI7YEzkofg8XyjagDZKu
         9fvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695051060; x=1695655860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mbEG8R9Q06h7B+764hTxvj2PiYwwKknHP6xA5X1amj0=;
        b=SB4Mna7KXRmpFk8Bna2SkCLf+Zvspa8dd1nol4dnU2IWcqA0/61uAH1QgiCbaAwKR8
         IpXC8dp/4T+aE279nY0i4+ZJUEbOoqa2iNLim5L2QiyivofRrB1S8tRLDSLL6N56dzvZ
         q1CDckFuFwsyHDat6+n3FSjiAsL6DkpdRPYj42vcYoRqGWyx6cwiaLcg7eL2GIumsvQT
         i5vhHj8lE7+8Q9irWt/IkHDZh5mdlsPNb+tjG9W0niAtXdCy8TKZ2lziiGVDVWodjiP2
         vgmsd7WDaorxfw1s5tZ/AApnEoOOAB/sUYLUhE1c2pPXfvYUU4pDJeY8zjbyZ7iJ/kFU
         YZTA==
X-Gm-Message-State: AOJu0YzOKrEBdAuHoujWSlE7rfcxIQtlQ0YALBD9eYoeXW25kLcSl6x0
	h8CgcXxjZzHd46qabxfeeHeIktXEeqBf7CODLR6qIWWOJd6vh+ADgL0=
X-Google-Smtp-Source: AGHT+IFQMr7V1NVsv+iG3ZZWJSGc/i50+Pl8qAgoFNL1wVPkHjspuwQhA7fyZTqmzfNbJRat87G2s1vCA00ndWHxRVw=
X-Received: by 2002:a05:622a:18a9:b0:410:8114:107b with SMTP id
 v41-20020a05622a18a900b004108114107bmr290576qtc.12.1695042255315; Mon, 18 Sep
 2023 06:04:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230918123011.1884401-1-william.xuanziyang@huawei.com>
In-Reply-To: <20230918123011.1884401-1-william.xuanziyang@huawei.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 18 Sep 2023 15:04:04 +0200
Message-ID: <CANn89i+QbPvtjUjHzhG9XY5MyoVh37RSb-+KVgz1MEA7SEL0oQ@mail.gmail.com>
Subject: Re: [PATCH net v5] team: fix null-ptr-deref when team device type is changed
To: Ziyang Xuan <william.xuanziyang@huawei.com>
Cc: jiri@resnulli.us, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, liuhangbin@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Sep 18, 2023 at 2:30=E2=80=AFPM Ziyang Xuan
<william.xuanziyang@huawei.com> wrote:
>
> Get a null-ptr-deref bug as follows with reproducer [1].
>
> BUG: kernel NULL pointer dereference, address: 0000000000000228
> ...
> RIP: 0010:vlan_dev_hard_header+0x35/0x140 [8021q]
> ...
> Call Trace:
>  <TASK>
>  ? __die+0x24/0x70
>  ? page_fault_oops+0x82/0x150
>  ? exc_page_fault+0x69/0x150
>  ? asm_exc_page_fault+0x26/0x30
>  ? vlan_dev_hard_header+0x35/0x140 [8021q]
>  ? vlan_dev_hard_header+0x8e/0x140 [8021q]
>  neigh_connected_output+0xb2/0x100
>  ip6_finish_output2+0x1cb/0x520
>  ? nf_hook_slow+0x43/0xc0
>  ? ip6_mtu+0x46/0x80
>  ip6_finish_output+0x2a/0xb0
>  mld_sendpack+0x18f/0x250
>  mld_ifc_work+0x39/0x160
>  process_one_work+0x1e6/0x3f0
>  worker_thread+0x4d/0x2f0
>  ? __pfx_worker_thread+0x10/0x10
>  kthread+0xe5/0x120
>  ? __pfx_kthread+0x10/0x10
>  ret_from_fork+0x34/0x50
>  ? __pfx_kthread+0x10/0x10
>  ret_from_fork_asm+0x1b/0x30
>
>

I am quite sure this will solve some syzbot reports as well, thanks.

Reviewed-by: Eric Dumazet <edumazet@google.com>

