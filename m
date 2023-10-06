Return-Path: <netdev+bounces-38682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 962FD7BC214
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 00:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B4CC282020
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 22:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8722E450EC;
	Fri,  6 Oct 2023 22:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="D2RfmYGl"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1C4450C9
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 22:12:52 +0000 (UTC)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6729BE
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 15:12:50 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1c77449a6daso22372405ad.0
        for <netdev@vger.kernel.org>; Fri, 06 Oct 2023 15:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1696630370; x=1697235170; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iHQtvCOqet4K+ZxgJSgWcab3IirKmkpaYjS7FQ4Cvcc=;
        b=D2RfmYGl8b8qjw74OumE1KeEPBqg/v3XzlcSTvg2OBueTmFN0aHBeAlem543lpoUai
         zKgLTR4VJGyqnID4JASC4+YoW8+0bM2or+5vxQCEO8JAu4T3bCjyaHmcEAhtCkZW80e3
         T4QCOR0erfHIMaJm2ynMWar4e6SVQJ/NANLqw6Xp9kcw0B/bfGglNHZ7HbHSuijIKZiF
         HU3mjr65wXatbgzjAmdGugvnhfnmI4cxX1LbILlq2aEUKcHcwuswjheCuGck+gyuzNWI
         4m6BgnmR9ownByprzb+tAZ6EGH5cTCyW43qIcB4ghq8TYkzkSO8E0+/KLTrpYBcGGJ+n
         Wcpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696630370; x=1697235170;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iHQtvCOqet4K+ZxgJSgWcab3IirKmkpaYjS7FQ4Cvcc=;
        b=A3i4paHWzF6a1CbOIAj/x1Q2MRszFT6lvwCVSBv7k9ayZPhhBvAEQirwBP9Vj/3d68
         TQAUJnHLMITAegWtyAgAaOxkLeaBuhBEZQZOq5bMsQa/jrH8d2/CEUhNiGi83pngwC+E
         EHqf65yW9bjjWqt27vjvsQ3d46usRec/M4Sg4FK11ZdE3hxyChmMyolLXvxoEuikeSl0
         hsK76pORmgaa9Uu7vqV/u6mrfkJEwYQFIjuGFyNqI7DmYduBfWeO91iBadZWm3BgSeJq
         9vZXcJBQiHmg5Pl8rdMGAV6XJ43mXqSMEFabkO2vwB/uspw/lcsmq+qbT4I2/QKNI48R
         w2dQ==
X-Gm-Message-State: AOJu0YzoKjVhbbCsZBcoul6KrjLTZ1/uRqv9R3uXjCrVfC2DWinr/i0e
	mOAfO8iT0EbnFiYFEozEyj95cw==
X-Google-Smtp-Source: AGHT+IFch0L2eBB11k+yQ7Pp4uZMeyMYYxH4y9b95LG8JPljPZHp5HnbtE3E2Lg41WF/o5h824lBjA==
X-Received: by 2002:a17:902:8f8b:b0:1c5:f0fd:51be with SMTP id z11-20020a1709028f8b00b001c5f0fd51bemr8305666plo.69.1696630370236;
        Fri, 06 Oct 2023 15:12:50 -0700 (PDT)
Received: from ?IPV6:2804:14d:5c5e:44fb:4bb6:b4ed:3ecb:e6a6? ([2804:14d:5c5e:44fb:4bb6:b4ed:3ecb:e6a6])
        by smtp.gmail.com with ESMTPSA id n3-20020a170902e54300b001c20c608373sm4411655plf.296.2023.10.06.15.12.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Oct 2023 15:12:49 -0700 (PDT)
Message-ID: <065a0dac-499f-7375-ddb4-1800e8ef61d1@mojatatu.com>
Date: Fri, 6 Oct 2023 19:12:46 -0300
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
 kuba@kernel.org, pabeni@redhat.com
References: <297D84E3-736E-4AB4-B825-264279E2043C@flyingcircus.io>
From: Pedro Tammela <pctammela@mojatatu.com>
In-Reply-To: <297D84E3-736E-4AB4-B825-264279E2043C@flyingcircus.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
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

Hi,

Your script is actually incorrect.
`man 7 tc-hfsc` goes in depth into why, but I just wanna highlight this 
section:
SEPARATE LS / RT SCs
        Another difference from the original HFSC paper is that RT and 
LS SCs can be specified separately. Moreover, leaf classes are
        allowed to have only either RT SC or LS SC. For interior 
classes, only LS SCs make sense: any RT SC will be ignored.

The last part ("For interior classes...") was what the referenced patch 
fixed. We were mistakenly allowing RTs into "interior classes" which the 
implementation never accounted for and this was a source of crashes. I'm 
surprised you were lucky enough to never crash the kernel ;)
-=
I believe the script could be updated to the following and still achieve 
the same results:
tc class add dev ifb0 parent 1: classid 1:999 hfsc ls m2 2.5gbit
tc class add dev ifb0 parent 1:999 classid 1:1 hfsc rt rate 50mbit



