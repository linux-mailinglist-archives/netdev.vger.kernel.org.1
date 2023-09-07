Return-Path: <netdev+bounces-32460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C014F797B00
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 19:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74D212817EF
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 17:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23DA513AFE;
	Thu,  7 Sep 2023 17:58:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E96F13AC3
	for <netdev@vger.kernel.org>; Thu,  7 Sep 2023 17:58:57 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E53E10F9
	for <netdev@vger.kernel.org>; Thu,  7 Sep 2023 10:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694109495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SMcpFOLp6Xfsjbv0O0mv63VovkeJUK+IyPtZQ2Pg9Y0=;
	b=aaRn83Tkf0OdiI36mRiHazpasxFfFHt2c86+3HQN0bb8YhsRpQbXWhwRM/PponTP0nAH8j
	YTAmSBWYii5OB9amn0Go8qqADSAFPGlMRKa1UdCHZnL/7JqAxIDBSK/p7R0JGtuAT5nmDf
	504X8ScpOwGQmvJHSqVsMfha0WrURLo=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-obIxiFZYOwyywmvamYrVDw-1; Thu, 07 Sep 2023 05:23:20 -0400
X-MC-Unique: obIxiFZYOwyywmvamYrVDw-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-501c6156bd4so135356e87.0
        for <netdev@vger.kernel.org>; Thu, 07 Sep 2023 02:23:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694078599; x=1694683399;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SMcpFOLp6Xfsjbv0O0mv63VovkeJUK+IyPtZQ2Pg9Y0=;
        b=SSsNCVy6sPYm/N0NYscWyPZwWe+d8nSttmxtLX7EFLs357lafPbwQP9LDToS+T7lqm
         Y6sEfjCRrajka9K5jb8BSqMhKbKBAY5776ruwR9lPJuwk8ARc+wOjfV6HauuISCu6fS/
         hpdaxFMgJFvm2sxhkeZU8vtuL/dxzP9ZulfZdR+bwVYjl/d4MlqKAiqpsS4OaMNYkVKR
         it7I9KR6lKYfUv9WuOgblpIOaIMxn0v7K3od2JeYKemx7+y53i0xJeFnchMiKMh3nt93
         +IInm/TIH8eIHyfiKwqq0o54FLQ69vluNaaJ1bdjKHRg1eTkWgb8j3bzNUniB8+Y0n+h
         qvcA==
X-Gm-Message-State: AOJu0YyDMRW4wkmfAQtrSQGPNePJ/0Hg90LhGMbw4LMyJFTkVrwptVnB
	x0A5Dwphr8HrY/DVkW74RF3NfewjypImmKjzOXrlxiw4XZIl9kWDDRIVMDE86XjdAWNQE4rcAv9
	5LfA5IVIKSCCxt7kE
X-Received: by 2002:a05:6512:6cd:b0:501:b010:e69e with SMTP id u13-20020a05651206cd00b00501b010e69emr9688316lff.1.1694078598863;
        Thu, 07 Sep 2023 02:23:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGySjtcDBgK5QfDiRiacyam5Lh1YNwKS/Kf70afMbngXdGiB5n1UmVhiCYRgIn8S8I5u/i9qA==
X-Received: by 2002:a05:6512:6cd:b0:501:b010:e69e with SMTP id u13-20020a05651206cd00b00501b010e69emr9688291lff.1.1694078598477;
        Thu, 07 Sep 2023 02:23:18 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-251-112.dyn.eolo.it. [146.241.251.112])
        by smtp.gmail.com with ESMTPSA id f5-20020a50ee85000000b0052595b17fd4sm9377590edr.26.2023.09.07.02.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 02:23:18 -0700 (PDT)
Message-ID: <626de62327fa25706ab1aaab32d7ba3a93ab26e4.camel@redhat.com>
Subject: Re: [PATCH net v2] net: stmmac: remove unneeded
 stmmac_poll_controller
From: Paolo Abeni <pabeni@redhat.com>
To: Remi Pommarel <repk@triplefau.lt>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,  Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Date: Thu, 07 Sep 2023 11:23:16 +0200
In-Reply-To: <20230906091330.6817-1-repk@triplefau.lt>
References: <20230906091330.6817-1-repk@triplefau.lt>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 2023-09-06 at 11:13 +0200, Remi Pommarel wrote:
> Using netconsole netpoll_poll_dev could be called from interrupt
> context, thus using disable_irq() would cause the following kernel
> warning with CONFIG_DEBUG_ATOMIC_SLEEP enabled:
>=20
>   BUG: sleeping function called from invalid context at kernel/irq/manage=
.c:137
>   in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 10, name: ksof=
tirqd/0
>   CPU: 0 PID: 10 Comm: ksoftirqd/0 Tainted: G        W         5.15.42-00=
075-g816b502b2298-dirty #117
>   Hardware name: aml (r1) (DT)
>   Call trace:
>    dump_backtrace+0x0/0x270
>    show_stack+0x14/0x20
>    dump_stack_lvl+0x8c/0xac
>    dump_stack+0x18/0x30
>    ___might_sleep+0x150/0x194
>    __might_sleep+0x64/0xbc
>    synchronize_irq+0x8c/0x150
>    disable_irq+0x2c/0x40
>    stmmac_poll_controller+0x140/0x1a0
>    netpoll_poll_dev+0x6c/0x220
>    netpoll_send_skb+0x308/0x390
>    netpoll_send_udp+0x418/0x760
>    write_msg+0x118/0x140 [netconsole]
>    console_unlock+0x404/0x500
>    vprintk_emit+0x118/0x250
>    dev_vprintk_emit+0x19c/0x1cc
>    dev_printk_emit+0x90/0xa8
>    __dev_printk+0x78/0x9c
>    _dev_warn+0xa4/0xbc
>    ath10k_warn+0xe8/0xf0 [ath10k_core]
>    ath10k_htt_txrx_compl_task+0x790/0x7fc [ath10k_core]
>    ath10k_pci_napi_poll+0x98/0x1f4 [ath10k_pci]
>    __napi_poll+0x58/0x1f4
>    net_rx_action+0x504/0x590
>    _stext+0x1b8/0x418
>    run_ksoftirqd+0x74/0xa4
>    smpboot_thread_fn+0x210/0x3c0
>    kthread+0x1fc/0x210
>    ret_from_fork+0x10/0x20
>=20
> Since [0] .ndo_poll_controller is only needed if driver doesn't or
> partially use NAPI. Because stmmac does so, stmmac_poll_controller
> can be removed fixing the above warning.
>=20
> [0] commit ac3d9dd034e5 ("netpoll: make ndo_poll_controller() optional")
>=20
> Cc: <stable@vger.kernel.org> # 5.15.x
> Signed-off-by: Remi Pommarel <repk@triplefau.lt>

I'm sorry for the incremental feedback, but we also need a suitable
Fixes tag, thanks!

Paolo


