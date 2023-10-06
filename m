Return-Path: <netdev+bounces-38654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFAFE7BBF03
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 20:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36ABC282138
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 18:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C044638F90;
	Fri,  6 Oct 2023 18:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="FFk1/nxT"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86E926E04
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 18:51:22 +0000 (UTC)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 539B7BF
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 11:51:19 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c874b43123so20667455ad.2
        for <netdev@vger.kernel.org>; Fri, 06 Oct 2023 11:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1696618279; x=1697223079; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xCV04zCvYMSRZ8PLVrYCErwlWKz0o53q1/ujh2vCW2I=;
        b=FFk1/nxTCSIyAwRQiKs1Ezb+gJEOmBaNx39KtBO3YvDg+GW25uJD5Tzv124epVi2Jw
         +9oqqTTomuxoYVyJLGjAiSeA9untb2CGDeUv1LsI3sRuzD9pVftFZi4gR35Ya+MDJrKJ
         fbObCNCaHE97KRKoj7xXMXC5KQY6U7D3/r4+Z3ZqPEsd7kg0rmJ/C3tLcHgyeq9qOKWJ
         QwGUzvOpB1L6tayyZVu/bG2xnPrCqNn+DFzyndMzmuo+Z/w3FsGhjwuEq0IWpQWk8IOS
         yZ7fC3xLkNtHfvIrJe72dktcNOLB3qsfrKf/fhBuumJ0SRpFpnLnYMh3tWIhkwIlrQLq
         /kDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696618279; x=1697223079;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xCV04zCvYMSRZ8PLVrYCErwlWKz0o53q1/ujh2vCW2I=;
        b=pczZTV4ubPvPj0FgHtyZ/RhrLDoMc+tSnEcexuFnOouuKrdp+op+75V1dKmClPwWCB
         Wb3mSo960y3lPMjeuHWq/IuY5a/c7jCzVr9zbr5vsXndToXKE2XQN1bPt6labzG8umEb
         Ng2eY+BrfPSrWSjpf1vdeuZPleZRptBoo6Mk56WI/QCdNce9DB8G8VNg5eyyuEcr4lA5
         W5a4ekco/eX1ps6SQZgQiPFWP7hl5qN63dW8NT+FOXTyVuKsOJW7sKKXr8wavFsOPvQb
         fpJwqBXrHPHXOxteopXJhDpAy7FORR3W2lYNcGwRe7F7f0IXT7brNsYEPJR6I5fp5BPq
         bTGA==
X-Gm-Message-State: AOJu0YwlnY4XOQgY2aBbAtYtmpKqb8RKFAxh5jI0DBwLqh2YFsEP1cB/
	ocUN7BCCal3DTHw4JTzb/i3lNg==
X-Google-Smtp-Source: AGHT+IEFrO5y5ULP5CWa6iaqkAW2+FU1lSXIQ3Vc6+v8Jz0uz9VPVoCU5MsvSwDlydQL8BKJvZTrlQ==
X-Received: by 2002:a17:902:e5c7:b0:1c5:b855:38f with SMTP id u7-20020a170902e5c700b001c5b855038fmr10107695plf.24.1696618278642;
        Fri, 06 Oct 2023 11:51:18 -0700 (PDT)
Received: from ?IPV6:2804:14d:5c5e:44fb:c07e:d4ae:2d8a:ba4? ([2804:14d:5c5e:44fb:c07e:d4ae:2d8a:ba4])
        by smtp.gmail.com with ESMTPSA id o1-20020a170902d4c100b001b9f7bc3e77sm4251840plg.189.2023.10.06.11.51.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Oct 2023 11:51:18 -0700 (PDT)
Message-ID: <c7d4fe7e-5229-71c7-b93d-f6203e163f02@mojatatu.com>
Date: Fri, 6 Oct 2023 15:51:14 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [REGRESSION] Userland interface breaks due to hard HFSC_FSC
 requirement
Content-Language: en-US
To: Christian Theune <ct@flyingcircus.io>, stable@vger.kernel.org,
 netdev@vger.kernel.org
Cc: regressions@lists.linux.dev, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, Jamal Hadi Salim <jhs@mojatatu.com>
References: <297D84E3-736E-4AB4-B825-264279E2043C@flyingcircus.io>
From: Pedro Tammela <pctammela@mojatatu.com>
In-Reply-To: <297D84E3-736E-4AB4-B825-264279E2043C@flyingcircus.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 06/10/2023 05:37, Christian Theune wrote:
> Hi,
> 
> (prefix, I was not aware of the regression reporting process and incorrectly reported this informally with the developers mentioned in the change)
> 
> I upgraded from 6.1.38 to 6.1.55 this morning and it broke my traffic shaping script, leaving me with a non-functional uplink on a remote router.
> 
> The script errors out like this:
> 
> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + ext=ispA
> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + ext_ingress=ifb0
> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + modprobe ifb
> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + modprobe act_mirred
> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + tc qdisc del dev ispA root
> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2061]: Error: Cannot delete qdisc with handle of zero.
> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + true
> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + tc qdisc del dev ispA ingress
> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2064]: Error: Cannot find specified qdisc on specified device.
> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + true
> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + tc qdisc del dev ifb0 root
> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2066]: Error: Cannot delete qdisc with handle of zero.
> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + true
> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + tc qdisc del dev ifb0 ingress
> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2067]: Error: Cannot find specified qdisc on specified device.
> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + true
> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + tc qdisc add dev ispA handle ffff: ingress
> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + ifconfig ifb0 up
> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + tc filter add dev ispA parent ffff: protocol all u32 match u32 0 0 action mirred egress redirect dev ifb0
> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + tc qdisc add dev ifb0 root handle 1: hfsc default 1
> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + tc class add dev ifb0 parent 1: classid 1:999 hfsc rt m2 2.5gbit
> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + tc class add dev ifb0 parent 1:999 classid 1:1 hfsc sc rate 50mbit
> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2077]: Error: Invalid parent - parent class must have FSC.
> 
> The error message is also a bit weird (but that’s likely due to iproute2 being weird) as the CLI interface for `tc` and the error message do not map well. (I think I would have to choose `hfsc sc` on the parent to enable the FSC option which isn’t mentioned anywhere in the hfsc manpage).
> 
> The breaking change was introduced in 6.1.53[1] and a multitude of other currently supported kernels:
> 
> ----
> commit a1e820fc7808e42b990d224f40e9b4895503ac40
> Author: Budimir Markovic <markovicbudimir@gmail.com>
> Date: Thu Aug 24 01:49:05 2023 -0700
> 
> net/sched: sch_hfsc: Ensure inner classes have fsc curve
> 
> [ Upstream commit b3d26c5702c7d6c45456326e56d2ccf3f103e60f ]
> 
> HFSC assumes that inner classes have an fsc curve, but it is currently
> possible for classes without an fsc curve to become parents. This leads
> to bugs including a use-after-free.
> 
> Don't allow non-root classes without HFSC_FSC to become parents.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: Budimir Markovic <markovicbudimir@gmail.com>
> Signed-off-by: Budimir Markovic <markovicbudimir@gmail.com>
> Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Link: https://lore.kernel.org/r/20230824084905.422-1-markovicbudimir@gmail.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ----
> 
> Regards,
> Christian
> 
> [1] https://cdn.kernel.org/pub/linux/kernel/v6.x/ChangeLog-6.1.53
> 
> #regzbot introduced: a1e820fc7808e42b990d224f40e9b4895503ac40
> 
> 

I will take a look,
Thanks!

