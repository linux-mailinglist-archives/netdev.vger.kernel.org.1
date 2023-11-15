Return-Path: <netdev+bounces-48109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D6D7EC8BD
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 17:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B67571C20B18
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 16:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0311EB33;
	Wed, 15 Nov 2023 16:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="mHEuVwwm"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28883BB4A
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 16:39:41 +0000 (UTC)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0521A10D5
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 08:39:38 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5a822f96aedso82491037b3.2
        for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 08:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1700066376; x=1700671176; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sclyE0ziPJ1+RIK1lEIDO4+EmCUAYIEkRU2ZMlLkr24=;
        b=mHEuVwwmrWbL4bSsCdz6VnMnc939og9LWeXw+hNdYUAh5+2WRyi9rUkJxrlVx0S1Jn
         rNNEnu2mYTzQRneNT6aWyfPt+9DMVtUzC1GQBMfG9cF3iiHCBZfsnuq2EA5m85og5bCs
         K4ZQ9DQ8B7d6oaal20ja6xaOPBkH0W+aNUP5VJYeH6eCfR0G8f4CzY/MJgGRy/RXD/wg
         qFt1GxeQvV1caW8puvT8xOMDyBJJbzpQeBQxkDSZ6tr6KI5jLfKiRSP1z2EDSF5qmJvJ
         xiPTAwOHw8pBSQzmtdzopiXxJDVQSO6Q8xcgkksiWBL36aSaBup4fkfidrVUhDSu5EnE
         10rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700066376; x=1700671176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sclyE0ziPJ1+RIK1lEIDO4+EmCUAYIEkRU2ZMlLkr24=;
        b=RSPPp5ItuJHzcyKfLx/MLyIF5qvC2JHN8tj8gqDym96EQCPEFgfqaLjL9Ih07W0TMl
         AFKN4Ksx4MorxxAjbrZU10qt/osnuOc+w8vra8jzBNorojnZi0X8DnSq5umzH6S0BfJ+
         AEHvAVU28ZQVyy59xyAA4aIVvWeiTHf5La2QkQ8tsl/DQPFPnCtE7hajKYSKrgpypcr3
         hnB57KfT7lF10Q7yEnAiPduTxqfkqb+l1sL3rDpjNpHblNyetbMktozHyRaa5zRLF3tw
         wAEA8jJQGkwpHvnemdmh+hx6HVg3ibQlmjiBfwXLW3tT8icScVRnWOBYx5hOCFKdymMm
         mfng==
X-Gm-Message-State: AOJu0YyuIsqDJgC/nfduxHhT9seAWODRtWrUlwKaBjlBt6o6/v88+08n
	CInEhyJmRHSol6EhSHqiJxIrjCANNpwrIWUEZf/pOA==
X-Google-Smtp-Source: AGHT+IHXwXRrLUFepxYuIzYv0ES+hnj5ZzDdepBo3t5XRgmfwTaRf0rqUUnJ0WDuuenrS6DnRQ7xSNKw9sDi9Ov5be8=
X-Received: by 2002:a81:7208:0:b0:59b:2be2:3560 with SMTP id
 n8-20020a817208000000b0059b2be23560mr13410331ywc.48.1700066376062; Wed, 15
 Nov 2023 08:39:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231114160442.1023815-1-pctammela@mojatatu.com>
In-Reply-To: <20231114160442.1023815-1-pctammela@mojatatu.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 15 Nov 2023 11:39:25 -0500
Message-ID: <CAM0EoMnQm2_ytosyhRTrxG=OBEJLC4ZxFVf1j1_bsKtUsXqd3Q@mail.gmail.com>
Subject: Re: [PATCH net-next 0/4] selftests: tc-testing: updates to tdc
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, xiyou.wangcong@gmail.com, jiri@resnulli.us, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	shuah@kernel.org, victor@mojatatu.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 14, 2023 at 11:05=E2=80=AFAM Pedro Tammela <pctammela@mojatatu.=
com> wrote:
>
> - Patch 1 removes an obscure feature from tdc
> - Patch 2 reworks the namespace and devices setup giving a nice speed
> boost
> - Patch 3 preloads all tc modules when running kselftests
> - Patch 4 turns on parallel testing in kselftests
>
> Pedro Tammela (4):
>   selftests: tc-testing: drop '-N' argument from nsPlugin
>   selftests: tc-testing: rework namespaces and devices setup
>   selftests: tc-testing: preload all modules in kselftests
>   selftests: tc-testing: use parallel tdc in kselftests
>

To the series:
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal

>  .../tc-testing/plugin-lib/nsPlugin.py         | 112 +++++++++---------
>  tools/testing/selftests/tc-testing/tdc.sh     |  69 ++++++++++-
>  2 files changed, 124 insertions(+), 57 deletions(-)
>
> --
> 2.40.1
>

