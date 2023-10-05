Return-Path: <netdev+bounces-38221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB32A7B9CCD
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 13:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id A68F21C20912
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 11:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D59134AF;
	Thu,  5 Oct 2023 11:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="v7b6tw5o"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255EE11CA6
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 11:47:09 +0000 (UTC)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306432570F
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 04:47:07 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-d84c24a810dso926261276.2
        for <netdev@vger.kernel.org>; Thu, 05 Oct 2023 04:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1696506426; x=1697111226; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QMR2iarH1SHp4FutOR7HUhuuQeLUkDys2IX/rbsWADw=;
        b=v7b6tw5o/OBbyFdhVYARKjxRW6pNB0ZfOztxOOJCGnF18e7wtvffHOlHj7HchJelX4
         UucMq2O55lzbpvmRL/X5Yk2WRyu20zhUv2MdqGxOrBZ/JduthWIRXeBxsDLxCHOebt6W
         g6si/Yy0tMJLPhOD0PkVF2kKzqTAP8U9AJGsXzJpVleStUPput4FmO9qMNjItwt2nV8F
         IP53vNQEUoTeUXbh8ZXNtgtoOWv8U6Fth+4IjkkGkwHVqdgQX5xh0/VkXd+ssU103qfV
         ysJIp5VI+ZLA7jkOmpfVInFmRpTlHpM4AC7uwkhkLwQvAtuLUFe3X9hRQjmCl8d0eebj
         RtlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696506426; x=1697111226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QMR2iarH1SHp4FutOR7HUhuuQeLUkDys2IX/rbsWADw=;
        b=cxZWLl1OuXmlTlSqwR5GFpFJBmk1aGJQEt1bSEdl6Va5PBKaBISiB2kTSWlHQvdsSP
         52EhSNzFfTyXU6BMQmPyquDzGxRbefUcMyVj/URqz09TsLAjdcYOO8pDSRMTgWuLmcGe
         35S5acs5g8/bmDa1Dv6N9BBRXrDsdu2iuA73MxZtJqNfMnBAQsGTtXE0mkaUQw5eCL4h
         IDS4mSnFbi/M1YZPF937b0U3+P24bURQWbBIhqb99A0VDOIj9CgxbUJTv/vPyWVaPSQm
         cbQ91/xCbys9L+GuyqK5yIOoMTDjcFdhHOKkAkW92XaR+nZ54y4ENb7ym9dK6hRioc4C
         8xYA==
X-Gm-Message-State: AOJu0YwGr9cYAfYlYCpN9KtS2H0nVz+6GDFD7pQ+xzKM5gCdPVHYo7sT
	A8r/lHyaNz4xFVLmq7yMSZCPTac9poNK9u9oq7qraA==
X-Google-Smtp-Source: AGHT+IHnauWf5w8n6DaCiT3ykWeC5N/dcnkg2MMYOy+wHUee5AJ5j5YZiGsBVOLC/sFQUAuyzMU7wUjxcXH15gBd2GA=
X-Received: by 2002:a25:7412:0:b0:d80:1011:d2b with SMTP id
 p18-20020a257412000000b00d8010110d2bmr4836599ybc.2.1696506426231; Thu, 05 Oct
 2023 04:47:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230926182625.72475-1-dg573847474@gmail.com> <20231004170120.1c80b3b4@kernel.org>
 <CAAo+4rW=zh_d7AxJSP0uLuO7w+_PmbBfBr6D4=4X2Ays7ATqoA@mail.gmail.com>
In-Reply-To: <CAAo+4rW=zh_d7AxJSP0uLuO7w+_PmbBfBr6D4=4X2Ays7ATqoA@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 5 Oct 2023 07:46:55 -0400
Message-ID: <CAM0EoMkgUPF751LpEij4QjwsP_Z3qBMW_Nss67OVN1hxyN0mGQ@mail.gmail.com>
Subject: Re: [PATCH] net/sched: use spin_lock_bh() on &gact->tcf_lock
To: Chengfeng Ye <dg573847474@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, xiyou.wangcong@gmail.com, jiri@resnulli.us, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Horatiu Vultur <horatiu.vultur@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 5, 2023 at 5:01=E2=80=AFAM Chengfeng Ye <dg573847474@gmail.com>=
 wrote:
>
> Hi Jakub,
>
> Thanks for the reply,
>
> I inspected the code a bit more, it seems that the TC action is called fr=
om
> tcf_proto_ops.classify() callback, which is called from Qdisc_ops enqueue
> callback.
>
> Then Qdisc enqueue callback is from
>
> -> __dev_queue_xmit()
> -> __dev_xmit_skb()
> -> dev_qdisc_enqueue()
>
> inside the net core. It seems that this __dev_queue_xmit() callback is
> typically called from BH context (e.g.,  NET_TX_SOFTIRQ) with BH
> already disabled, but sometimes also can from a work queue under
> process context, one case is the br_mrp_test_work_expired() inside
> net/bridge/br_mrp.c. Does it indicate that this TC action could also be
> called with BH enable? I am not a developer so really not sure about it,
> as the networking code is a bit long and complicated.

net/bridge/br_mrp.c seems to need some love +Cc Horatiu Vultur
<horatiu.vultur@microchip.com>
Maybe that code needs to run in a tasklet?
In any case your patch is incorrect.

cheers,
jamal

