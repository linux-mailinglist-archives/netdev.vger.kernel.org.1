Return-Path: <netdev+bounces-38772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0782F7BC6B7
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 12:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A98F1C20965
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 10:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF111803B;
	Sat,  7 Oct 2023 10:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="dyUAYgK5"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862BD168BA
	for <netdev@vger.kernel.org>; Sat,  7 Oct 2023 10:20:21 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AEF3BF
	for <netdev@vger.kernel.org>; Sat,  7 Oct 2023 03:20:18 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9b96c3b4be4so509133866b.1
        for <netdev@vger.kernel.org>; Sat, 07 Oct 2023 03:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1696674016; x=1697278816; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=le6OwQ4NukPSt+wrlgYBc0MIq8+Ezc1nG+Q6jn/4jhQ=;
        b=dyUAYgK53EBw7FU5TI4KA1TbnYaFtglAONjwgEMA93yYHPqFQ7e7yugFMVY4blJi5R
         aI8S4rW449gA78shNTJHdLRHMZAZVG7U2JSMoQd1+K43MFu9QQbFvhZ24Sq61E/mE5mw
         +p013EYdyRZih5lOL6R2iBClFXtNQ4IhNRDw3X+fKdiDBXk2CC5cgVx3j2tp4Flln+1A
         kYNbMz/ctN1xW5otIUticH2Enja3KHD5XSi0mO5zGGv5H8QrjEv9p6bpRpsTfw+pJq3m
         a2O582Q/1hHoTc5vQjKSctuPHrTPyHssmJ2/tTuADvyvBfj1eiZx6nakw2R5w5mivFAk
         zuBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696674016; x=1697278816;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=le6OwQ4NukPSt+wrlgYBc0MIq8+Ezc1nG+Q6jn/4jhQ=;
        b=lIQ0uKuFpzgzozQuxSVuZPqG0BwWyzyOfbxOIPwdcj1gm73793Bz+P/KgWqerveaFG
         O/mUJkVBpF4gNi0syki5w+rHqFAffdT5oQwHs5vmqF1OUITE/ecUbKc+4ygIN0BtVBAD
         YqKI9lBuhbwXDd+nQ3S+snieG7nahGig44ubU6sJ0HV4jiF1Kb2gOO3W4fQD+baJlhlI
         Iz3/qrI5PccTVz5z7JpRuEaHSwvcEGZQBV3fdlh1seTc8nFpYeNb5CXdZcSRoQIJOsv7
         Hb2auzFJfeXtd5+4tPpDEBMecwpUbXk4ZHLkUacWsrt2Z6JyVfyLYP6ya73DUQff4+4C
         BlmQ==
X-Gm-Message-State: AOJu0Yx8PHyfh96YmvnvVJxT/Ccd5KyjPoUH8a+2RbQPTOV88PkBxloR
	NPBxCr5VeqJ6HUCMv+4ZSkB/jg==
X-Google-Smtp-Source: AGHT+IEu6FBrZD4wa0epDYYVv8cQYnjfgnkDAcG4GucqJUJQ15uLIgMu2ufZuWpkSeWmOrDym9rlqg==
X-Received: by 2002:a17:906:768e:b0:9ae:3a60:570a with SMTP id o14-20020a170906768e00b009ae3a60570amr9350258ejm.18.1696674016634;
        Sat, 07 Oct 2023 03:20:16 -0700 (PDT)
Received: from localhost ([91.218.191.82])
        by smtp.gmail.com with ESMTPSA id n2-20020a1709061d0200b009a0955a7ad0sm4047207ejh.128.2023.10.07.03.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 03:20:15 -0700 (PDT)
Date: Sat, 7 Oct 2023 12:20:15 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Victor Nogueira <victor@mojatatu.com>,
	xiyou.wangcong@gmail.com, davem@davemloft.net, pabeni@redhat.com,
	edumazet@google.com, mleitner@redhat.com, vladbu@nvidia.com,
	simon.horman@corigine.com, pctammela@mojatatu.com,
	netdev@vger.kernel.org, kernel@mojatatu.com
Subject: Re: [PATCH net-next v4 0/3] net/sched: Introduce tc block ports
 tracking and use
Message-ID: <ZSEw32MVPK/qCsyz@nanopsycho>
References: <20231005184228.467845-1-victor@mojatatu.com>
 <ZSAEp+tr1oXHOy/C@nanopsycho>
 <CAM0EoM=HDgawk5W70OxJThVsNvpyQ3npi_6Lai=nsk14SDM_xQ@mail.gmail.com>
 <ZSA60cyLDVw13cLi@nanopsycho>
 <CAM0EoMn1rNX=A3Gd81cZrnutpuch-ZDsSgXdG72uPQ=N2fGoAg@mail.gmail.com>
 <20231006152516.5ff2aeca@kernel.org>
 <CAM0EoM=LMQu5ae53WEE5Giz3z4u87rP+R4skEmUKD5dRFh5q7w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0EoM=LMQu5ae53WEE5Giz3z4u87rP+R4skEmUKD5dRFh5q7w@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Sat, Oct 07, 2023 at 01:00:00AM CEST, jhs@mojatatu.com wrote:
>On Fri, Oct 6, 2023 at 6:25 PM Jakub Kicinski <kuba@kernel.org> wrote:
>>
>> On Fri, 6 Oct 2023 15:06:45 -0400 Jamal Hadi Salim wrote:
>> > > I don't understand the need for configuration less here. You don't have
>> > > it for the rest of the actions. Why this is special?
>>
>> +1, FWIW
>
>We dont have any rule that says all actions MUST have parameters ;->
>There is nothing speacial about any action that doesnt have a
>parameter.

You are getting the configuration from the block/device the action is
attached to. Can you point me to another action doing that?



