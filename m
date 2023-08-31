Return-Path: <netdev+bounces-31527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1567E78E911
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 11:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 383B71C2091B
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 09:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3A78472;
	Thu, 31 Aug 2023 09:06:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3655210A
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 09:06:15 +0000 (UTC)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07ECCCED
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 02:06:14 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-31aeee69de0so398374f8f.2
        for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 02:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693472772; x=1694077572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :message-id:date:in-reply-to:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zPF2S1FkXVpFZ6EPIcZb2N6hrcEBudDLP+bq4afuPo8=;
        b=YSQ3iT3+in4rs+ZtA9iYJDfBlAAYE21WmDvZXKzehqV9zRoFHzZdHtSCtE59glii/N
         rpuzd398EYOv3v5xriJdaatzu3HxUqGzdFFD77oGssTqF2QfOVZofU0SpCIOx64ak3L5
         Dr5LPRRPyo0udOJgin87BVxa+pP+gLjIHmj2kS428Ngi1hcOUqrWcuy5hQtPsImTJtgj
         DvVIKfdgMNkcfnMCaVjcMLfiRl9bZR6fhD8gVj5FAoyDKPNAnIFx4l8zey9yFOySbYEq
         c9Mj5uI72ptYgh69TPg1YtvtZQkNoWknomEkIPk+D9vLvoCc9H73wzRVW4kQ/+wrovPp
         arcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693472772; x=1694077572;
        h=content-transfer-encoding:mime-version:user-agent:references
         :message-id:date:in-reply-to:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zPF2S1FkXVpFZ6EPIcZb2N6hrcEBudDLP+bq4afuPo8=;
        b=EOguzZk9tIukDo0sssY/JkYx95TpIyl6+bZZeg7p6JYBAK6Lif26blUnLFbdepzimp
         /aMhdF1SFtMnzSOLuzm0QZ7ENodcdfBg2VNWqYUbsOYM1fK0o8SCeiRSkiPz6bdAMbSU
         FETpMizVxBJvZozWfbfGEpl++VgofXwRNZ4zv6EZGhn55SuWJqKqkczBP4Xaf42Gl/u4
         6YTniiV8935KLi/L6Y0mVXJwZZPx4zAbWki3u9i+LLZtgzIpKjZNWA0NgrtFtTglKrTO
         clNCGoui4BYO0MzNMYiNgCvl88JWy97RL+akwsWZAiDyKxcrHzHprSBAYmoWpGDJ7Zsq
         EZ1g==
X-Gm-Message-State: AOJu0YxcMOwcB0CGIYlFejyqhRasRz27DjiQ3ZL4XaC3f8wnyTDW579j
	e3w53soNDP5FcyLYB+/VgSb6v7PTjWE=
X-Google-Smtp-Source: AGHT+IEPccd/rGky4NnFTH7HokERBH2OEDOtn/s4HxXw5R2ZE76CFG/cnReKwvcnoWC4o/YMuUy7mw==
X-Received: by 2002:a5d:595f:0:b0:317:5b32:b2c3 with SMTP id e31-20020a5d595f000000b003175b32b2c3mr3711845wri.6.1693472772315;
        Thu, 31 Aug 2023 02:06:12 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:a8df:c6e8:f57b:aa6e])
        by smtp.gmail.com with ESMTPSA id i5-20020adfefc5000000b0031759e6b43fsm1516181wrp.39.2023.08.31.02.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 02:06:11 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Petr Machata <petrm@nvidia.com>
Cc: <francois.michel@uclouvain.be>,  <netdev@vger.kernel.org>,
  <stephen@networkplumber.org>,  <dsahern@kernel.org>
Subject: Re: [PATCH iproute2-next 1/1] tc: fix typo in netem's usage string
In-Reply-To: <87ledssftn.fsf@nvidia.com> (Petr Machata's message of "Wed, 30
	Aug 2023 17:32:01 +0200")
Date: Thu, 31 Aug 2023 10:05:31 +0100
Message-ID: <m2pm33eg4k.fsf@gmail.com>
References: <20230830150531.44641-1-francois.michel@uclouvain.be>
	<20230830150531.44641-2-francois.michel@uclouvain.be>
	<87ledssftn.fsf@nvidia.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Petr Machata <petrm@nvidia.com> writes:

> francois.michel@uclouvain.be writes:
>
>> From: Fran=C3=A7ois Michel <francois.michel@uclouvain.be>
>>
>> Signed-off-by: Fran=C3=A7ois Michel <francois.michel@uclouvain.be>
>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
>
> That said...
>
>>  		"                 [ loss state P13 [P31 [P32 [P23 P14]]]\n"
>>  		"                 [ loss gemodel PERCENT [R [1-H [1-K]]]\n"
>
> ... and sorry for piling on like this, but since we are in the domain of
> fixing netem typos, if you would also fix the missing brackets on these
> two lines, that would be awesome.

The tc-netem(8) man page suggests (and usage confirms) that P14 is also
an optional parameter so it should be bracketed as well.

https://www.man7.org/linux/man-pages/man8/tc-netem.8.html

