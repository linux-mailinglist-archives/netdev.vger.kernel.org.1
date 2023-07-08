Return-Path: <netdev+bounces-16202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A5874BCC1
	for <lists+netdev@lfdr.de>; Sat,  8 Jul 2023 10:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA2212819B3
	for <lists+netdev@lfdr.de>; Sat,  8 Jul 2023 08:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C291FC2;
	Sat,  8 Jul 2023 08:06:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6596A1FA1
	for <netdev@vger.kernel.org>; Sat,  8 Jul 2023 08:06:08 +0000 (UTC)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F371BF5
	for <netdev@vger.kernel.org>; Sat,  8 Jul 2023 01:06:06 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-401d1d967beso84821cf.0
        for <netdev@vger.kernel.org>; Sat, 08 Jul 2023 01:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688803565; x=1691395565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GCvrCfTHFWQyBiNcg3TnVsyc4HnJArv8bvF2IwaspK8=;
        b=CAvxqTrWmDGlW+tSAM7xQlpsGk9SRuxr/H3WTXV/C5N0VcS52CZlIs8ZbDcj7rneEf
         4XmVkKmNJC6QljPVWfedNPAUI4Q6AOQHS6d41TDI23W96/RcUoaluAtm74l5EirRAuAy
         i8LFVLCp297UD02bZ1IpT8AeQpTPAGD/RsBekeosKSZnC1+QSIePnxshKEPd1bfcrYjs
         RUuvOE4GGKFDBltBjKYgSZ1UYq/ZJEYlJZH8dtP4ZU/OkgOnhtnIWQwEkXjU8Ipv9J5E
         4exha9HI9dM1gmjbKskgo8nyjOyvUSZVSDIXyDNXqv8bHpULvvVtsYR6DWouHwUI3iW5
         UFoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688803565; x=1691395565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GCvrCfTHFWQyBiNcg3TnVsyc4HnJArv8bvF2IwaspK8=;
        b=E8OqdUgAmG0fyRqKGP4LQ6DwTWZdIcDPw21sQiMAWX+gE1DpNmM5kxskNweR+p/2Ae
         0DZj9U64sejVTlolmFzwD9UY2H479W7WDhs/gJ1KKqImsBfwrcbTgq5rtPoMDTqjbAIb
         z8VTVcy5eUC55Wd3XebiYH/aOtNIwOXvpHiwoXY0wsX2c7KRIx4RKaw3osl0jGwS4/du
         AuzKFXvmyTzFXfvh+Km+ehJKCGkGE4b+C4+CO1twdJknbkuaMSrtGSNkumAZmBM1Gs+e
         jJUlV7EIojXYRE+iBJSvVQ3gVAS9i7UBTs+WeZw4PpmgvULrMAJEtdVRi1MEcHmG8RPD
         h/MQ==
X-Gm-Message-State: ABy/qLZkUMolV0hhdX0zoQSQtSyXI4+iSvnZy8J9g864lQqw1YqjeS48
	uIXqtIC0uBFrc8VsYJN0p8ccBEkXh3Edo7HIA07WWg==
X-Google-Smtp-Source: APBJJlE121xxbiXfUjf3NHaJqeM01UfhkNm06itQ5JjyyWx8xk6lZwOtpqCq4Sq8ee6G5VpnQcTfV3PnanzPbyCMvAI=
X-Received: by 2002:a05:622a:cd:b0:3f8:5b2:aef2 with SMTP id
 p13-20020a05622a00cd00b003f805b2aef2mr111544qtw.26.1688803565078; Sat, 08 Jul
 2023 01:06:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230708065910.3565820-1-william.xuanziyang@huawei.com>
In-Reply-To: <20230708065910.3565820-1-william.xuanziyang@huawei.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 8 Jul 2023 10:05:53 +0200
Message-ID: <CANn89iJ1fA4JbRwL4p7+puKrwO-wvj=TZbE_eC5NAVUZjG+xwA@mail.gmail.com>
Subject: Re: [PATCH net v2] ipv6/addrconf: fix a potential refcount underflow
 for idev
To: Ziyang Xuan <william.xuanziyang@huawei.com>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, hannes@stressinduktion.org, 
	fbl@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Jul 8, 2023 at 8:59=E2=80=AFAM Ziyang Xuan
<william.xuanziyang@huawei.com> wrote:
>
> Now in addrconf_mod_rs_timer(), reference idev depends on whether
> rs_timer is not pending. Then modify rs_timer timeout.
>
> There is a time gap in [1], during which if the pending rs_timer
> becomes not pending. It will miss to hold idev, but the rs_timer
> is activated. Thus rs_timer callback function addrconf_rs_timer()
> will be executed and put idev later without holding idev. A refcount
> underflow issue for idev can be caused by this.
>
>         if (!timer_pending(&idev->rs_timer))
>                 in6_dev_hold(idev);
>                   <--------------[1]
>         mod_timer(&idev->rs_timer, jiffies + when);
>
> To fix the issue, hold idev if mod_timer() return 0.
>
> Fixes: b7b1bfce0bb6 ("ipv6: split duplicate address detection and router =
solicitation timer")
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Ziyang Xuan <william.xuanziyang@huawei.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks !

