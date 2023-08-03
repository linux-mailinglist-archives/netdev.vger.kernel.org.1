Return-Path: <netdev+bounces-24213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA3E76F3F2
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 22:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 036631C21606
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 20:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19D1263B2;
	Thu,  3 Aug 2023 20:18:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FBF1F185
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 20:18:26 +0000 (UTC)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80FB83C31
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 13:18:21 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4fe3b86cec1so2341007e87.2
        for <netdev@vger.kernel.org>; Thu, 03 Aug 2023 13:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1691093900; x=1691698700;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TSLerfEC8x2ZkqZ+PaoDn6gSM0nuTqxqr5ipewapCfs=;
        b=MwbVI+dgU5ctise91WzaGFh5YVQLP1EGUzZthMBoMUMmRYqITRp8yuFbGPr9F9ay8f
         qPs+iGYYf2wP0UvZ+5Y9aAM8LaXgMOiIaQZRaxsw1+8rPI/LQbBb2KSAvS5pf4yIAHL9
         Nnru1c8wKwqUvELV9YBY0BlnbCyqCC75MZZdRMEJ6y+5GA/+ov5YIK5rh6AXbPHbd1Xd
         SsZH2RtWcSuQEDEO7mATUmbwm3GrOQjnrWKo9t/clz1qM45hHyeZxi18PjGh6u33ms1H
         p9HgYAy0wroAbCjQe60IBV6SWu1KOb7FycDj0lEdFUEuqL4oXjRR8Izi7CjLXJz5wf69
         Ef6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691093900; x=1691698700;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TSLerfEC8x2ZkqZ+PaoDn6gSM0nuTqxqr5ipewapCfs=;
        b=lBIlJX0AnBo0aUokO1ue9kXc4lShIefSCkcQ+3DG58WgBHvdD34wBEZc3xefylXXw6
         0PzkgqM8kjpbUWOOH9ivnmSI2izAIcrEi/O+8rCYGdkBOWuzwZGOJ6F644NUqe4xcHro
         Gb/LRiBOy0D9bRkLM49CQpZp2OVkFwiOUG5a8oXCGXMn1Ppc7SbVLTAuPQZqcd3ttXxq
         IAQgU1QbM3/d26wG4BMkvgyYR5VJrura83KMXSbbUsa0vKnTXukhMM3R8MikpsWBWgTP
         k64puRJB6ZzNO+pxFESnhMwpvZ6Bm2wgdFjqtiu90FNdMokyQGCMvZf3SpuFfygtKZYg
         jrJw==
X-Gm-Message-State: ABy/qLZi0t6ljeqNRdkgg47/aVfXyKx844brA6ByoclrkMeJeinWXIMY
	q3IYRrk+3F5dv1tz8Ya+jCNk4A==
X-Google-Smtp-Source: APBJJlH/3JOBWYhu7XpAFjh9q56ctcvvHbv5DykqLhxq1qtDXz0u6Iy8AwP9+mE69rygOVKQYeAC/A==
X-Received: by 2002:a05:6512:210d:b0:4f9:607a:6508 with SMTP id q13-20020a056512210d00b004f9607a6508mr6559144lfr.50.1691093899644;
        Thu, 03 Aug 2023 13:18:19 -0700 (PDT)
Received: from [127.0.0.1] ([146.70.190.136])
        by smtp.gmail.com with ESMTPSA id c9-20020aa7d609000000b0051bfc85afaasm231854edr.86.2023.08.03.13.18.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Aug 2023 13:18:19 -0700 (PDT)
Date: Thu, 3 Aug 2023 22:18:18 +0200 (GMT+02:00)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Xiang Yang <xiangyang3@huawei.com>, martineau@kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	netdev@vger.kernel.org, mptcp@lists.linux.dev
Message-ID: <21fad913-dd47-4d45-865a-3af877990246@tessares.net>
In-Reply-To: <20230803110424.5ca643c9@kernel.org>
References: <20230803072438.1847500-1-xiangyang3@huawei.com> <d3fa9b41-078b-4bb5-9f5c-d8768b787f4d@tessares.net> <20230803110424.5ca643c9@kernel.org>
Subject: Re: [PATCH -next] mptcp: fix the incorrect judgment for
 msk->cb_flags
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Correlation-ID: <21fad913-dd47-4d45-865a-3af877990246@tessares.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Jakub,

3 Aug 2023 20:04:26 Jakub Kicinski <kuba@kernel.org>:

> On Thu, 3 Aug 2023 18:32:15 +0200 Matthieu Baerts wrote:
>> This Coccicheck report was useful, the optimisation in place was not
>> working. But there was no impact apart from testing more conditions
>> where there were no reasons to.
>>
>> The fix is then good to me but it should land in -net, not in net-next.
>>
>> Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
>>
>> I don't know if it is needed to have a re-send just to change the subject.
>
> Looks trivial enough to apply without a repost, but are you sure
> you don't want to take it into your tree? Run the selftests and all?

Thank you for asking that! All patches sent to our mailing list are automatically tested but the report is only sent to our mailing list not to annoy too many people. This patch passed all tests we have:

https://lore.kernel.org/mptcp/20230803072438.1847500-1-xiangyang3@huawei.com/T/

I already applied it on our side. For non-trivial fixes or features, we usually prefer to keep them a bit only applied on our side for longer tests and to have syzkaller stressing them. But here, because this patch looks trivial enough, it seems fine to me to have it applied in -net directly.

Cheers,
Matt
--
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net

