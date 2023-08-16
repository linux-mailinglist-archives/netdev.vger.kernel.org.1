Return-Path: <netdev+bounces-28055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D561277E139
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 14:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1239D1C20FEB
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 12:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB52B107A5;
	Wed, 16 Aug 2023 12:13:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6871079D
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 12:13:59 +0000 (UTC)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA342136;
	Wed, 16 Aug 2023 05:13:58 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1bc63ef9959so54020925ad.2;
        Wed, 16 Aug 2023 05:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692188037; x=1692792837;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3qmXn2ewlnvZ6CiUg5F1hGWulWuQ6Cj0sIq/1TLnfZ4=;
        b=nshUr+43amUm18xBi+a6Xyq5RDGpXvUTh+z2ta3KjeXa2R0DEU8SK68GnbRihpoui3
         c5dqSO/ir2Yb0NViOhWN82buZvLvfqASbT3QKTWrwitizM5p14YunABpblQpcsSJSgZF
         vbm3lj/AgGzPItttE5IWRT9tYENsGCrPHcEiP4F4Xf/3ic6cn/hQpHizQBr1m0K/6oDe
         TsEUw4AwOEQHKvmAgv1lEOsBNv6wcIpf2sRckNLnCYTDZO/82TKk3hWcevb4g+3bY32Y
         KpffUBt0wUfiSRAylfFyw1pLYdZeIL3+/xSMjojjxla9RdUwdugQgc/pSBNGlQ67yBa7
         c5Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692188037; x=1692792837;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3qmXn2ewlnvZ6CiUg5F1hGWulWuQ6Cj0sIq/1TLnfZ4=;
        b=GOI4/DBlpPK2ybM9Pxe0lFa2QXmVX82pVy5H9wkbtwD5i9kE5m5NVLVA55nu1lejlA
         +B1KmexeCnLD9r4BjEDqmAwYKiUpu4w2sOSOys1PWb08sX03wE5+M7ogATYhor/MEw9X
         VtRT+/qlUnfoJagQZ6smxMr2+dna7loHIQzk31ILPahf9qAfexdv24BzqEJMD0SPUA9b
         emWq2sAqEvIOPMZUTin42IzQPCHQU6M4ET3pcr5yMLFsSJ+EeKTa9Fp1DlqH4Kkr3pEK
         BKxVLaZGUrXyDAoJJr7s8DUza5uj9wHik5gXjE7+Q49QLvXbH1Dfv0AmBzdfuIAMtAJW
         FmWg==
X-Gm-Message-State: AOJu0YxQfMAzvLuk5T95CK35jZr7IGJjz+obEBv3OumzVvdl6r6ko8kT
	HAOxToIi1DP1EEVLBPuxP74=
X-Google-Smtp-Source: AGHT+IHY8C5UlhqoOQAHNfwLvADr+O5asQd9I8l4yWkocJeEVZd0V9lFFdt12ifwqtJwQABfUmpGww==
X-Received: by 2002:a17:903:1208:b0:1be:eef7:98e0 with SMTP id l8-20020a170903120800b001beeef798e0mr1984099plh.35.1692188037272;
        Wed, 16 Aug 2023 05:13:57 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u9-20020a170902a60900b001b8b2b95068sm12937375plq.204.2023.08.16.05.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 05:13:56 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 16 Aug 2023 05:13:55 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Cc: Michael Chan <michael.chan@broadcom.com>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, gospo@broadcom.com,
	Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH net-next 11/12] bnxt_en: Expose threshold temperatures
 through hwmon
Message-ID: <3d70325b-6b6a-482f-8745-36aceb6b2818@roeck-us.net>
References: <20230815045658.80494-1-michael.chan@broadcom.com>
 <20230815045658.80494-12-michael.chan@broadcom.com>
 <c6f3a05e-f75c-4051-8892-1c2dee2804b0@roeck-us.net>
 <CAH-L+nM4MvWODLcApzFB1Xjr4dauii+pBErOZ=frT+eiP8PgVg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH-L+nM4MvWODLcApzFB1Xjr4dauii+pBErOZ=frT+eiP8PgVg@mail.gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 16, 2023 at 03:58:34PM +0530, Kalesh Anakkur Purayil wrote:
> Thank you Guenter for the review and the suggestions.
> 
> Please see my response inline.
> 
> On Tue, Aug 15, 2023 at 8:35 PM Guenter Roeck <linux@roeck-us.net> wrote:
> 
[ ... ]

> >
> > Hmm, that isn't really the purpose of alarm attributes. The expectation
> > would be that the chip sets alarm flags and the driver reports it.
> > I guess there is some value in having it, so I won't object.
> >
> > Anyway, the ordering is wrong. max_alarm should be the lowest
> > alarm level, followed by crit and emergency. So
> >                 max_alarm -> temp >= bp->warn_thresh_temp
> >                 crit_alarm -> temp >= bp->crit_thresh_temp
> >                 emergency_alarm -> temp >= bp->fatal_thresh_temp
> >                                 or temp >= bp->shutdown_thresh_temp
> >
> > There are only three levels of upper temperature alarms.
> > Abusing lcrit as 4th upper alarm is most definitely wrong.
> >
> [Kalesh]: Thank you for the clarification.
> bnxt_en driver wants to expose 4 threshold temperatures to the user through
> hwmon sysfs.
> 1. warning threshold temperature
> 2. critical threshold temperature
> 3. fatal threshold temperature
> 4. shutdown threshold temperature
> 
> I will use the following mapping:
> 
> hwmon_temp_max : warning threshold temperature
> hwmon_temp_crit : critical threshold temperature
> hwmon_temp_emergency : fatal threshold temperature
> 
> hwmon_temp_max_alarm : temp >= bp->warn_thresh_temp
> hwmon_temp_crit_alarm : temp >= bp->crit_thresh_temp
> hwmon_temp_emergency_alarm : temp >= bp->fatal_thresh_temp
> 
> Is it OK to map the shutdown threshold temperature to "hwmon_temp_fault"?

That is a flag, not a temperature, and it is intended to signal
a problem ith the sensor.

> If not, can you please suggest an alternative?
> 

The only one I can think of is to add non-standard attributes
such as temp1_shutdown and temp1_shutdown_alarm.

Guenter

