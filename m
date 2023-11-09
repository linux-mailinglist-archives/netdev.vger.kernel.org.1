Return-Path: <netdev+bounces-46857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0167E6B15
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 14:15:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D99E4B20C5A
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 13:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EDC51C3B;
	Thu,  9 Nov 2023 13:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="oUthem5J"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5819C1BDE9
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 13:15:49 +0000 (UTC)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A1530C5
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 05:15:43 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9ae2cc4d17eso144289266b.1
        for <netdev@vger.kernel.org>; Thu, 09 Nov 2023 05:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1699535742; x=1700140542; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u4AuckdEfTJUC5R3FNXtBiIsIG6I93ec6nCCbyK9nJU=;
        b=oUthem5JGfdh9F9575pDhuNFKCrGPtbEj3OKdnTWisa9Ewhzchms2NuajQaZVE+FrJ
         uoSz5UZkv7VYrCTkoVeHOqCVtcbnvMd5J/JaMzffpkc5C+cfbK8vgV2HFqjTBVbs57wH
         O3WQsCx+1F5YvtZo+YnoABUpPQHb4PPJ+FOXtETsQHr0v10PxY/71ncOYn8KgAyjs13y
         V+hD6pQS3uXtFqVUG7xfs2B3oMyOCLCd18R6MT/Ulu8yRHbPf3TDWo41XQJhd140e7Sg
         fnZkm92cGHhuNzRuU/X2mPjT1tja3kS0UXa3V+di5BPpqGFIAfNitn+FpGHnuFzQ7j57
         1XfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699535742; x=1700140542;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u4AuckdEfTJUC5R3FNXtBiIsIG6I93ec6nCCbyK9nJU=;
        b=IB04Q8bA+jAddVmap6ywwXyDlXO79mdh5znyBvTFblLM/6SAtbjhzBg/nmdl3GfG3T
         ZFOGe/024Z/N4/nIrlEBeI5XGX66NNyw0ZjFqL3AeyM28dlJckIgyzdFGA9eJGUYjQ4S
         Eh7rPeXARkuUm5VnTp2nWfvEfgcmy3mtnOobpmoz7HOK6+PRT1EzQsoiuzLxrdGHUodv
         o1YBOCqMzW7Vzem8lqCSa6AKTh+LWlXLRSSOLQna6+gaf/BROZFRKg3pFctde2O5CYMz
         tmCRVy+kaVhq8y5OdlyeOd+CpJ1GKN/COkaoWyWYKuwxFXuWkyCgiGSqq/+vglxJeJYB
         Zn/Q==
X-Gm-Message-State: AOJu0Yy7UoRc/TeGQDOA5tf3Hbbsk/66rvPgNu6hvSkjtscufyyF46Ge
	mf3+s6gA18OVQoMp7KIc6ppOmA==
X-Google-Smtp-Source: AGHT+IH8QE8CUH1KJFMHxGnO47XpqlLf53+0VPDB2tM8pVU8EBK7L7wvTen0AECLUWxnjADPBFtr1w==
X-Received: by 2002:a17:906:4796:b0:9c8:f128:2fdb with SMTP id cw22-20020a170906479600b009c8f1282fdbmr4727138ejc.13.1699535742280;
        Thu, 09 Nov 2023 05:15:42 -0800 (PST)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id g5-20020a170906198500b009a9fbeb15f2sm2540159ejd.62.2023.11.09.05.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 05:15:41 -0800 (PST)
Date: Thu, 9 Nov 2023 14:15:40 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com,
	syzbot+d55372214aff0faa1f1f@syzkaller.appspotmail.com,
	jhs@mojatatu.com, xiyou.wangcong@gmail.com
Subject: Re: [RFC net-next] net: don't dump stack on queue timeout
Message-ID: <ZUzbfIDtiykahZ/t@nanopsycho>
References: <20231109000901.949152-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109000901.949152-1-kuba@kernel.org>

Thu, Nov 09, 2023 at 01:09:01AM CET, kuba@kernel.org wrote:
>The top syzbot report for networking (#14 for the entire kernel)
>is the queue timeout splat. We kept it around for a long time,
>because in real life it provides pretty strong signal that
>something is wrong with the driver or the device.
>
>Removing it is also likely to break monitoring for those who
>track it as a kernel warning.
>
>Nevertheless, WARN()ings are best suited for catching kernel
>programming bugs. If a Tx queue gets starved due to a pause
>storm, priority configuration, or other weirdness - that's
>obviously a problem, but not a problem we can fix at
>the kernel level.
>
>Bite the bullet and convert the WARN() to a print.
>
>Before:
>
>  NETDEV WATCHDOG: eni1np1 (netdevsim): transmit queue 0 timed out 1975 ms
>  WARNING: CPU: 0 PID: 0 at net/sched/sch_generic.c:525 dev_watchdog+0x39e/0x3b0
>  [... completely pointless stack trace of a timer follows ...]
>
>Now:
>
>  netdevsim netdevsim1 eni1np1: NETDEV WATCHDOG: CPU: 0: transmit queue 0 timed out 1769 ms
>
>Alternatively we could mark the drivers which syzbot has
>learned to abuse as "print-instead-of-WARN" selectively.
>
>Reported-by: syzbot+d55372214aff0faa1f1f@syzkaller.appspotmail.com
>Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Makes sense.

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

