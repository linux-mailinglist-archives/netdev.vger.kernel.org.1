Return-Path: <netdev+bounces-13028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A66C739F68
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 13:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93F622818F0
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 11:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E889171BA;
	Thu, 22 Jun 2023 11:27:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB042FB2
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 11:27:27 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E618E10D2
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 04:27:23 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9889952ed18so685054266b.3
        for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 04:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1687433242; x=1690025242;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RqfVUJxh3MCa39rZNIwGIEj5jtcyEf3Eci0d2Wcadic=;
        b=Ll4W6Vj/co+B5OO6fZB9HcY+L/0fdnQjBXIOS4oIz6GaWnNS+gi8t+XXpVuRt1fIvI
         W9jDQpcfSiwbs8P1uoNo5xyBmjWfdf9gDNcPq7QSPYJOmzrcPKyGc6DDpREPdG4BO9t3
         WTz7BFOi3YgPPkmULGRpYFoQwXROURFCcObsex9X1Kpkk07id5bNa77kzZL309R1j+a4
         He2fQTEFnnyRu6AMl/alhifh9RRtef7yZEyMPOh7DqUdKLZ/UbQ8Z1kjR4mEU6VN8Kie
         VAmYR6ZcnZ2rqGsuPwN6YMIxX2vm8NJQYd52ct2aVqL3kN9mhIgfLw6En4xc73ruNNhj
         w2jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687433242; x=1690025242;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RqfVUJxh3MCa39rZNIwGIEj5jtcyEf3Eci0d2Wcadic=;
        b=VbzgSWG+Rf+R+MZqeTwdQeVgFxHujSpjmO2pLEN4P1uNpmJ47Xb1xVjJZVXhb5nnMa
         8kxSAfD0czbHH9WBCQCQ/CM7r67h6sAO2g+qPpTM28/JIZQ8z4FCRcBYtou14hjs6Ol+
         Kx9IyZiuwhEjb9b8sFGJiZKuEjNvNuA3b9jUR0G17fZOO10+tIjDXa3bOeEfXDgfVYQq
         q+eoKGrTymDeByaVtffqcGgi9rvLeYMuVZzRWHQu73KS9JRP3tgTaG0YkTV3cQ5VL4Jv
         L8PJT65Z6lXZcNMdBGwkdOS1mzQvKCrbk27ECOtGkk67c4dVmswk9Qcq3Acs6OJInMH3
         mglA==
X-Gm-Message-State: AC+VfDwEq5D6rDOc5MvSeZuepa1DUh9NeXkachFCBpuiB8dg+sM2HwU/
	kmOW1mpUrrdrbgdPodJK08bWUw==
X-Google-Smtp-Source: ACHHUZ6GDSWwoREZHYQThZ6tpjUXi6nU/LgwkNu8r8ffR4zdrafFIVJyN9Q0f40lBq8BS1CtIa3/+w==
X-Received: by 2002:a17:907:e9e:b0:988:a404:c489 with SMTP id ho30-20020a1709070e9e00b00988a404c489mr11524865ejc.41.1687433239630;
        Thu, 22 Jun 2023 04:27:19 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id j6-20020a170906410600b0098877b10de7sm4532963ejk.193.2023.06.22.04.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 04:27:18 -0700 (PDT)
Date: Thu, 22 Jun 2023 13:27:17 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	syzbot+a7d200a347f912723e5c@syzkaller.appspotmail.com,
	Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH net] netlink: fix potential deadlock in netlink_set_err()
Message-ID: <ZJQwFWwT1ahFypTq@nanopsycho>
References: <20230621154337.1668594-1-edumazet@google.com>
 <ZJQAdLSkRi2s1FUv@nanopsycho>
 <CANn89iLeU+pBrcHZyQoSRa-X_3G-Y8cjF6FJy4XwkJc7ronqMA@mail.gmail.com>
 <ZJQGTnqo6IgMGZ4j@nanopsycho>
 <CANn89iK8p7SuGE7rrOKZ6bxoZZhQXBHufj8+YnbNoE-ivKopiw@mail.gmail.com>
 <ZJQT4/SZJN7qGUHI@nanopsycho>
 <CANn89iLio4+ik5qAQwd7SKr8ihS+y7fvkYYc=ZuuGqJ4BVfgdQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iLio4+ik5qAQwd7SKr8ihS+y7fvkYYc=ZuuGqJ4BVfgdQ@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Thu, Jun 22, 2023 at 12:10:19PM CEST, edumazet@google.com wrote:
>On Thu, Jun 22, 2023 at 11:27 AM Jiri Pirko <jiri@resnulli.us> wrote:
>>
>> Thu, Jun 22, 2023 at 10:42:34AM CEST, edumazet@google.com wrote:
>> >On Thu, Jun 22, 2023 at 10:29 AM Jiri Pirko <jiri@resnulli.us> wrote:
>> >>
>> >> Thu, Jun 22, 2023 at 10:14:56AM CEST, edumazet@google.com wrote:
>> >> >On Thu, Jun 22, 2023 at 10:04 AM Jiri Pirko <jiri@resnulli.us> wrote:
>> >> >>
>> >> >> Wed, Jun 21, 2023 at 05:43:37PM CEST, edumazet@google.com wrote:
>> >> >> >syzbot reported a possible deadlock in netlink_set_err() [1]
>> >> >> >
>> >> >> >A similar issue was fixed in commit 1d482e666b8e ("netlink: disable IRQs
>> >> >> >for netlink_lock_table()") in netlink_lock_table()
>> >> >> >
>> >> >> >This patch adds IRQ safety to netlink_set_err() and __netlink_diag_dump()
>> >> >> >which were not covered by cited commit.
>> >> >> >
>> >> >> >[1]
>> >> >> >
>> >> >> >WARNING: possible irq lock inversion dependency detected
>> >> >> >6.4.0-rc6-syzkaller-00240-g4e9f0ec38852 #0 Not tainted
>> >> >> >
>> >> >> >syz-executor.2/23011 just changed the state of lock:
>> >> >> >ffffffff8e1a7a58 (nl_table_lock){.+.?}-{2:2}, at: netlink_set_err+0x2e/0x3a0 net/netlink/af_netlink.c:1612
>> >> >> >but this lock was taken by another, SOFTIRQ-safe lock in the past:
>> >> >> > (&local->queue_stop_reason_lock){..-.}-{2:2}
>> >> >> >
>> >> >> >and interrupts could create inverse lock ordering between them.
>> >> >> >
>> >> >> >other info that might help us debug this:
>> >> >> > Possible interrupt unsafe locking scenario:
>> >> >> >
>> >> >> >       CPU0                    CPU1
>> >> >> >       ----                    ----
>> >> >> >  lock(nl_table_lock);
>> >> >> >                               local_irq_disable();
>> >> >> >                               lock(&local->queue_stop_reason_lock);
>> >> >> >                               lock(nl_table_lock);
>> >> >> >  <Interrupt>
>> >> >> >    lock(&local->queue_stop_reason_lock);
>> >> >> >
>> >> >> > *** DEADLOCK ***
>> >> >> >
>> >> >> >Fixes: 1d482e666b8e ("netlink: disable IRQs for netlink_lock_table()")
>> >> >>
>> >> >> I don't think that this "fixes" tag is correct. The referenced commit
>> >> >> is a fix to the same issue on a different codepath, not the one who
>> >> >> actually introduced the issue.
>> >> >>
>> >> >> The code itself looks fine to me.
>> >> >
>> >> >Note that the 1d482e666b8e had no Fixes: tag, otherwise I would have taken it.
>> >>
>> >> I'm aware it didn't. But that does not implicate this patch should have
>> >> that commit as a "Fixes:" tag. Either have the correct one pointing out
>> >> which commit introduced the issue or omit the "Fixes:" tag entirely.
>> >> That's my point.
>> >
>> >My point is that the cited commit should have fixed all points
>> >where the nl_table_lock was read locked.
>>
>> Yeah, it was incomplete. I agree. I don't argue with that.
>>
>> >
>> >When we do locking changes, we have to look at the whole picture,
>> >not the precise point where lockdep complained.
>> >
>> >For instance, this is the reason this patch also changes  __netlink_diag_dump(),
>> >even if the report had nothing to do about it yet.
>> >
>> >So this Fixes: tag is fine, thank you.
>>
>> Then we have to agree to disagree I guess. It is not fine.
>>
>> Quoting from Documentation/process/handling-regressions.rst:
>>   Add a "Fixes:" tag to specify the commit causing the regression.
>>
>> Quoting from Documentation/process/submitting-patches.rst:
>>   A Fixes: tag indicates that the patch fixes an issue in a previous commit. It
>>   is used to make it easy to determine where a bug originated, which can help
>>   review a bug fix.
>
>The previous commit definitely had an issue, because it was not complete.

Is it the originator of the bug? No.


>
>We have many other cases of commits that complete the work started earlier.

The fact something was done wrongly in the past should not serve
as an argument to continue.


>
>I will continue doing so, and I will continue writing changelogs that
>displease you.

Awesome. Basically you say you don't care about the rules that others
are required to stick to. Making your statement personal is a bit
offending I have to say.


>
>>
>> 1d482e666b8e is not causing any regression (to be known of), definitelly
>> not the one this patch is fixing.
>
>>
>> Misusing "Fixes" tag like this only adds unnecessary confusion.
>> That is my point from the beginning. I don't understand your resistance
>> to be honest.
>
>To be honest, I do not understand you either, I suggest we move on,
>we obviously are not on the same page.

Yeah, well rules are here for very good reasons and should apply
to anyone. It's a matter of principles. Who else than one of the
maintainers should obey them and require people to obey them?

Just my 2 cents. I'm done with this thread.

