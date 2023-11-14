Return-Path: <netdev+bounces-47749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8197EB2C3
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 15:50:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D960A281066
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 14:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5CF3FE5D;
	Tue, 14 Nov 2023 14:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="Hva0kdLW"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F6C3FB21
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 14:50:20 +0000 (UTC)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A6ACA
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 06:50:19 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5a8ee23f043so65364467b3.3
        for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 06:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1699973418; x=1700578218; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AvphbM2BQSrpRvDq9dVB/qmVdMcCGcLFZdpxiyrwrq4=;
        b=Hva0kdLW2O7/Cw3/QOV+K4PIQN8IeWJndcfCL+nPcjZwO+P+HZY50a0x0ejalluFqH
         4J8qgsvrprnLhC6Vn6o80xLF9c7ZcWBtEp5hSSlr/wtJUs/W171DZEopTIF4V9V+8mZx
         177t7ldHHDg8ZmHykqbwLx7wMacnPTtqSYULOjqkoXLm2ezpmncQ1yckgj9U45O7aVX2
         91Owd0PXn+CUC7ef2bLbZEfJZpRTPGXda4Dphrk7lVuXuk4k7AGEC3AY5/OcGp7YCokm
         7ccCvKsPV+HN2CDDO1X68UXKyi1LrBZXEP1S/mdXitDQsOH1e1gN0NCzE3ov0WaD6Rsx
         sJ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699973418; x=1700578218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AvphbM2BQSrpRvDq9dVB/qmVdMcCGcLFZdpxiyrwrq4=;
        b=MHE6gEf76k+XLfzpOnWXQoO4BHytJpieJz5TgnHi7lKfu0SZhOiecCQ7eU8zwvfZDi
         z/RZYrhu/LfYcm6wc9jjaUWducrIhSb28Yx/lCCqSI0s4+X2Qv6EzjjuswYVqVrJkshp
         tM4+EXBAUlgFiQDc130R+gEBhkfBQF2ve8f0wLi13cuOqXzzytfBXT7Wqq+WfsXaQ3QA
         +sDRBUQOIYpaKnlsryxwwkanu8NrK3CrT0Qkc/0NuCYC7lnSKKBJZCB9kIg9rJZSkGJS
         B0SnV9Rf7QMqLB2E+oc3NKvo4/jiMRpbdOmMmpXUJ2A5CXHhZmHgdTBgUWGI8yTD0KCL
         PrcQ==
X-Gm-Message-State: AOJu0YywphpiowE7t8ZJEbcgociTm5sV7sn1917hiACnwHRZqA35O+cY
	QUdUROL5LxxJr38BqiY0Wj7dOkZ/wuRokFfRwPlkaw==
X-Google-Smtp-Source: AGHT+IHA+PmUlcWOFQBeW7LQpfc8v4MM2eksY0nRuMlNz3Zff0PnX72qkTMgJ47MZjTCOu2KGIr4QR8WMITE4QSQpM8=
X-Received: by 2002:a0d:d94e:0:b0:5bf:f907:e07c with SMTP id
 b75-20020a0dd94e000000b005bff907e07cmr9783645ywe.33.1699973418631; Tue, 14
 Nov 2023 06:50:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231114141856.974326-1-pctammela@mojatatu.com>
In-Reply-To: <20231114141856.974326-1-pctammela@mojatatu.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 14 Nov 2023 09:50:07 -0500
Message-ID: <CAM0EoMn0SNYJC9zAWMrFpbtoE+8ZusGi8beLyL9SwTACkwBNLQ@mail.gmail.com>
Subject: Re: [PATCH net-next 0/2] net/sched: cls_u32: use proper refcounts
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, xiyou.wangcong@gmail.com, jiri@resnulli.us, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	shuah@kernel.org, victor@mojatatu.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 14, 2023 at 9:20=E2=80=AFAM Pedro Tammela <pctammela@mojatatu.c=
om> wrote:
>
> In u32 we are open coding refcounts of hashtables with integers which is
> far from ideal. Update those with proper refcount and add a couple of
> tests to tdc that exercise the refcounts explicitly.
>

To the series...
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal

> Pedro Tammela (2):
>   net/sched: cls_u32: replace int refcounts with proper refcounts
>   selftests/tc-testing: add hashtable tests for u32
>
>  net/sched/cls_u32.c                           | 36 ++++++------
>  .../tc-testing/tc-tests/filters/u32.json      | 57 +++++++++++++++++++
>  2 files changed, 75 insertions(+), 18 deletions(-)
>
> --
> 2.40.1
>

