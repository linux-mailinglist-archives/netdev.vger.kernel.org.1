Return-Path: <netdev+bounces-31818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B4D7905CD
	for <lists+netdev@lfdr.de>; Sat,  2 Sep 2023 09:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D912281976
	for <lists+netdev@lfdr.de>; Sat,  2 Sep 2023 07:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9244B23B7;
	Sat,  2 Sep 2023 07:37:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802CC23AA
	for <netdev@vger.kernel.org>; Sat,  2 Sep 2023 07:37:28 +0000 (UTC)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE9BB4
	for <netdev@vger.kernel.org>; Sat,  2 Sep 2023 00:37:25 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-407db3e9669so107651cf.1
        for <netdev@vger.kernel.org>; Sat, 02 Sep 2023 00:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693640245; x=1694245045; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tGzJAOBv39wC+eBwHXRCdW6LDCDBMBeVwYp5p5ZAHp4=;
        b=cHiAt8u0yxeVemDZcNHcIo1a1hbPymDF7Rklnp5uO0z0Ck7zAdHHX4Sl3QuQs9lo/a
         C9zVBBth3J4oWj0i0xTkZGdxbSymV/q4ageQHqesI4wRWRsG9vaJPCZOp9sjz/5lWazP
         hkQn9R6QG74xPyWXxXBROSG4qHbIxIYVWOqCgzAx919VHRKRHl+hJXgqzvQgr/+j2bqi
         E25dsc9B3mEX+zWxjQ1IAj7Lnd1tpkUPrFpR0nKQBYE8lVZGXOmjow3SOUXhlvGnhQs2
         0rEflR1vQzkckskdyJSGytDhroKM3Z1R0VvSKPft4AwCMxoQkjt4iMzBcQS9hD8GMVyT
         t26A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693640245; x=1694245045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tGzJAOBv39wC+eBwHXRCdW6LDCDBMBeVwYp5p5ZAHp4=;
        b=QWBKzmUkxxWorEUlFpJopqGhZLFbJqhkzSz+U73mQbG74VZk1lEdYwNv/ErxNQ62sR
         MOb8DoChZVvXt+KSUnir4txKyHIyKqCR9m1580TR1V85JGHwHNeW2QvrhyRbXPKlXC/V
         M/AhM7Zphygjh72R6HYJSA4vNXPC+PjZzbRVJKRuDYd+87DvpVKtwu8t2gGHs4ejV8eW
         mqownr+SBJvU10n4Dv5Niz1Zdnh9fG8c9wag8G6wUsEzPgUIFSQ7RyBQZq0gTk3V62H6
         cgXRWlWB1xmZyWPbg8Im15QzfhqVqQn+IQCZOl/pjiUaOoprPn87D3PwoOT0OCHn7ZQ4
         kgQQ==
X-Gm-Message-State: AOJu0YyuI7YC+FTPkxbFgoagaHxyrl9kC94bXNJ7otaYQwZDLXWupNTG
	fTtmsro9oLoJ21ZFfuuIyKR5Zb+yAh7IRFrpzBPOjg==
X-Google-Smtp-Source: AGHT+IElCtXsEuqc1xIgnbAqRpIeaZJHksxJD/VhGd3OpQEYv8Tb+4JLhJvWWlP8G9VUHoqJzbp8NIqn7VYR3Qykng4=
X-Received: by 2002:a05:622a:c6:b0:403:b1d0:2f0a with SMTP id
 p6-20020a05622a00c600b00403b1d02f0amr142084qtw.28.1693640244542; Sat, 02 Sep
 2023 00:37:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230902071631.204529-1-renmingshuai@huawei.com>
In-Reply-To: <20230902071631.204529-1-renmingshuai@huawei.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 2 Sep 2023 09:37:13 +0200
Message-ID: <CANn89iJ2aFYjQp639O6mDj7vhiNV5w_EVsMxM2jQGBHfHbOtOQ@mail.gmail.com>
Subject: Re: net/sched: Discuss about adding a new kernel parameter to set the
 default value of flow_limit
To: r30009329 <renmingshuai@huawei.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, jhs@mojatatu.com, 
	xiyou.wangcong@gmail.com, davem@davemloft.net, jiri@resnulli.us, 
	yanan@huawei.com, liaichun@huawei.com, chenzhen126@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Sep 2, 2023 at 9:16=E2=80=AFAM r30009329 <renmingshuai@huawei.com> =
wrote:
>
> How about adding a new kernel parameter to set the default value of flow_=
limit
>  when the default qidsc is set to fq? Although We can use the tc to modif=
y the
>  default value of flow_limit, it is more convenient to use a kernel param=
eter to
>  set the default value, especially in scenarios where the tc command is
>  inconvenient or cannot be used.

Hmm, can you define 'inconvenient' ?
It seems to be an issue with the tool or the toolchain ?
The 'cannot be used' argument seems strange to me.
If I understand correctly, you want a generic mechanism for all qdisc
default parameters,
in case the 'default qdisc' is XXX instead of pfifo_fast.

kernel parameters should be reserved to specific cases when
programmers have no other way.

rtnetlink is the way to go really, sorry !

