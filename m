Return-Path: <netdev+bounces-17802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9946753152
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 07:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4E321C214F7
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 05:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C275C6AAC;
	Fri, 14 Jul 2023 05:34:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59AC5224
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 05:34:17 +0000 (UTC)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042DB3A9A
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 22:34:13 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-3128fcd58f3so1636220f8f.1
        for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 22:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689312851; x=1691904851;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lCJcQQRjJzkT1ggDM5s4p8DYt7wLE79ib2sV+EARwLY=;
        b=Yg0n+zzIT9qKZsIaCu07rsyJZPVX3RXyzsypkYyLI5Y7FPy5KLds7h0b784wYy4ssm
         j0OMiCuqteuJaWTyv5pNNFsnP1D2n/KcqhrSQsi9xPYJ3BEH6XcGcN5RSxuXhiNNK9sV
         sZXtohccDQksVTk0FIJGygoT45UXVskHt27kuXCGWOdTNubA9rM3mVBRATkZCfA3KN/N
         2YmWdZWCvvkQhi9OZh2mmu6wtjiHVEi0g8ZYDNiZOEHA/tRdSnVhYzpAhf9Vff/NtP7i
         StFiYhyjbca4XKrcZuMvYQEPWxwGHEQGnhb/c1OTksY5zvLYt2ku2TlSw7HYgXMelD9v
         /Zag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689312851; x=1691904851;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lCJcQQRjJzkT1ggDM5s4p8DYt7wLE79ib2sV+EARwLY=;
        b=VxUY0+++iJIXGHjouEn0wnfe50DsAVpQON2Cs/pg5EbrLPrq1HbD6BYfvG41uufJwQ
         V5MOXD/j/4Kl14f68AuJHyDTIToVNsuPFvWGoTEb950cjLUlQx3IwLQgR8EJzpfer8mt
         FJ3eB850W84sDWoW5NR5xM4S81SFAqfy52lA5+tn7fNgW2Flg4w0E9SBPMcL8EhaIg2I
         mox3iXIyGcfLKm+5Lw4ukvbCXmFowYKaDwgxKBeQ353Ww8I26UoOML2jBeJvr0FHVGSH
         1rPB8LSDGAAoY45wqjtm3QEHNnkTag2fPhUgPRLUjV62PVShGj2vdFzCkyEbEX5fq7Uj
         njtQ==
X-Gm-Message-State: ABy/qLYYlgPxL/ZA1bKBPBarIkECPZaJAzU3h6ABdYAYTOgLcONf/QFh
	Lcc3AEY/xLOsN0Rtx8AFDd8=
X-Google-Smtp-Source: APBJJlGsqZ5ACxOSK/aLTKCHCudeIIZansK4LMnxtb1cffEIF4w9jCqg+lDOtEoDopbqAw6yfUAaog==
X-Received: by 2002:a5d:6792:0:b0:316:efb9:ffd with SMTP id v18-20020a5d6792000000b00316efb90ffdmr417754wru.1.1689312851242;
        Thu, 13 Jul 2023 22:34:11 -0700 (PDT)
Received: from ?IPV6:2a01:c22:72e8:a200:99ec:cf51:6f55:b3af? (dynamic-2a01-0c22-72e8-a200-99ec-cf51-6f55-b3af.c22.pool.telefonica.de. [2a01:c22:72e8:a200:99ec:cf51:6f55:b3af])
        by smtp.googlemail.com with ESMTPSA id cr13-20020a05600004ed00b003143ba62cf4sm9876224wrb.86.2023.07.13.22.34.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 22:34:10 -0700 (PDT)
Message-ID: <17c638ca-5343-75e0-7f52-abf86026f75d@gmail.com>
Date: Fri, 14 Jul 2023 07:34:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
To: Linux regressions mailing list <regressions@lists.linux.dev>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, joey.joey586@gmail.com
References: <82ea9e63-d8c8-0b86-cd88-913cc249fa9a@gmail.com>
 <d644f048-970c-71fe-a556-a2c80444dae2@leemhuis.info>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH net] r8169: fix ASPM-related problem for chip version 42
 and 43
In-Reply-To: <d644f048-970c-71fe-a556-a2c80444dae2@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 14.07.2023 05:31, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 13.07.23 21:46, Heiner Kallweit wrote:
>> Referenced commit missed that for chip versions 42 and 43 ASPM
> 
> Thanks again for taking care of this.
> 
>> [0] https://bugzilla.kernel.org/show_bug.cgi?id=217635
> 
> That line should be a proper Link: or Closes: tag, as explained by
> Documentation/process/submitting-patches.rst

OK

> (http://docs.kernel.org/process/submitting-patches.html) and
> Documentation/process/5.Posting.rst
> (https://docs.kernel.org/process/5.Posting.html) and thus be in the
> signed-off-by area, for example like this (without the space upfront):
> 
>> Fixes: 5fc3f6c90cca ("r8169: consolidate disabling ASPM before EPHY access")
>  Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217635 # [0]
> 
> A "Cc: stable@vger.kernel.org" would be nice, too, to get this fixed in
> 6.4, where this surfaced (reminder: no, a Fixes: tag is not enough to
> ensure the backport there).
> 

That's different in the net subsystem. The net (vs. net-next) annotation
ensures the backport.

>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> […]
> 
> #regzbot ^backmonitor: https://bugzilla.kernel.org/show_bug.cgi?id=217635
> 
> Ciao, Thorsten


