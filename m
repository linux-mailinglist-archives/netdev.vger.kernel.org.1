Return-Path: <netdev+bounces-33557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 961DF79E895
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 15:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFA6F1C20BC4
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 13:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652221A71C;
	Wed, 13 Sep 2023 13:06:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C2DC143
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 13:06:43 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5606B19B1
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 06:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694610401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kuwFMC5mRZ7VarEt5Ohjid2m51EIo0hZWn7sAc8+1s8=;
	b=RQtR/3KD8aAYbFw4rd/RGo3jHcH40J5yGcwN5MpGMZNVm2CZi6M5MDzGoX9D46T66eAjIr
	fDvWkbLO1zqIIQ3ko2s7PW8H3AD5eKyX+qJCnZq4WbsMXFfOVr6jisbqfmUyqTEpBzuKa2
	tJ9LxMr0M2Yq0Qp40AJglLM9tvptlzA=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-RthwXZS1M6-9L9MSc5cOHg-1; Wed, 13 Sep 2023 09:06:40 -0400
X-MC-Unique: RthwXZS1M6-9L9MSc5cOHg-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-5007f3d3255so7300774e87.3
        for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 06:06:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694610398; x=1695215198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kuwFMC5mRZ7VarEt5Ohjid2m51EIo0hZWn7sAc8+1s8=;
        b=kN0b9FcZTPbOr6511L6ytaXa739CgCy1T0P6ryEu2ELDjAWHpB3CzsT4D5C7rxxkK8
         RlPbL4HB3lpd1Y+/iRTScs0h8IT7AyjVna+C3ArVNu9R1BNMYN6AzSHAWeyJXqijWdn1
         +xEuLNSpvwtmTeq/zF/vvIBvdObn64Kl/mKOSBrQnrS8jwkGy+QA104LukWJgXSa83kg
         8C0OYJ5VB+FgYblvKuRAMlfZ2wBnbmf4QG4j+jOV7TVQubPNT+TYu5FKhxsfmluJcnhh
         5mEga91dxPi24Y1kmbRH4gzWejIW+P8Ti4KpSIz/qyBp9jA+ZO8Bt1le/G1e4IswaY4S
         4Fvw==
X-Gm-Message-State: AOJu0YzIgjyr5iTNLOoy/MWTyWzKKkoQ4yhR/Y6o040+4lwqPWCmSROC
	i0ZhANWlliyD/ZloLINZatgoehoiu7V5+skmfeR98g3tNy813kR1tXAjlu/WAkjskn0j4YU7+fb
	xvVTj8H111T0rkSQAEpWIR0vzpxOQ1Ruvf8k2SHMeKZs=
X-Received: by 2002:a05:6512:ea7:b0:502:ab7b:e480 with SMTP id bi39-20020a0565120ea700b00502ab7be480mr2491931lfb.36.1694610397891;
        Wed, 13 Sep 2023 06:06:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFm2SjU0StDjV/U1lazTzEIkGpkYpaNtvZKtwF+kZ76WDh5pUdPohUQazMFm4isRhzw2ugeggwYxV8c/VoRh9w=
X-Received: by 2002:a05:6512:ea7:b0:502:ab7b:e480 with SMTP id
 bi39-20020a0565120ea700b00502ab7be480mr2491900lfb.36.1694610397495; Wed, 13
 Sep 2023 06:06:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230824153736.629961-1-pctammela@mojatatu.com>
In-Reply-To: <20230824153736.629961-1-pctammela@mojatatu.com>
From: Davide Caratti <dcaratti@redhat.com>
Date: Wed, 13 Sep 2023 15:06:26 +0200
Message-ID: <CAKa-r6tuEyPKJbNOaBJfqS7qsCfvAByjegbtxdyx=xMBvQnuHA@mail.gmail.com>
Subject: Re: [PATCH RFC net-next v2 0/4] selftests/tc-testing: parallel tdc
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com, 
	jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, shuah@kernel.org, shaozhengchao@huawei.com, 
	victor@mojatatu.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

hello Pedro,

On Thu, Aug 24, 2023 at 5:38=E2=80=AFPM Pedro Tammela <pctammela@mojatatu.c=
om> wrote:
>
> As the number of tdc tests is growing, so is our completion wall time.
> One of the ideas to improve this is to run tests in parallel, as they
> are self contained.
>
> This series allows for tests to run in parallel, in batches of 32 tests.

<...>

looks good to me!

it would be nice to extend tdc.py in a way that all the ns mounts are
deleted before re-running a test (e.g. after a failure or after tdc.py
is interrupted). But that can be done in a separate patch.

Tested-by: Davide Caratti <dcaratti@redhat.com>


