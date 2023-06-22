Return-Path: <netdev+bounces-13013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01695739CE1
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 11:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C6C61C21078
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 09:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4016B3AAA7;
	Thu, 22 Jun 2023 09:27:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FBA80C
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 09:27:04 +0000 (UTC)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DACA01FD8
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 02:27:01 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fa23c3e618so8653635e9.0
        for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 02:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1687426020; x=1690018020;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KG/fMMTzc+xZeWv+kl/Y5qy8Oo4mXepK4wZRyDAdDnw=;
        b=aoNmkjeAtD82+QctCwA1irELgCt7M/nP9zKzxdieGmuKiKOwnr/TPrHZXWoxhoNW8m
         oKhSiSgCkYTE7L+RgSe25dK22QMfzS9BKHsMFYZ0pSqJuTWm5R8Br1pUUPO24ys0XtE5
         ce5rDy0GE0zBKlECcweYNVltSXdM/GK/pqqRdzbi71z9xeqxEQe5e5FdITEQKtUevh1a
         LrAepAXRnUsFazi+9ILhrubV0QYKRtGZHf5JJKOWIchSJ+1nccFkNq+7FQHhT1+E0jzI
         ManHcvJJGT8v+I63NFU9JIACmcrRQlzxV1G4dRMu6HfNdQokak26ke0hnty7E/5e9g8u
         nMSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687426020; x=1690018020;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KG/fMMTzc+xZeWv+kl/Y5qy8Oo4mXepK4wZRyDAdDnw=;
        b=P+yRnYf1Z5xkSzzlK74ieBb1sL7+DK7j3wb8GU8KDRe3+CufLeeJ+K+52Z7EsFHSoy
         w+jQ9jLAQ9r2yWUexgLrXs6DwM6LLRHdiIky/XRgLPLtqVOtb57ws6xJ9ax45zK//vH1
         YEUay5I15UXcIx+iQlisFzrxE//gA6/Jacp+S9EY4zhgQ2XPWugwr/FANdlG6V6VEouK
         TpIL2KMb91ywZlPazKle1tRynybpBydCs5+Py4t0bPFhQOVZZCiIKTx2Kja9NECsJowI
         TON4oyOD0ECrR4PcRPUgweix5f28Qi9vb9P5wrPM70/1XNik0MFmyYuVs0PWQ0flk4IG
         bivQ==
X-Gm-Message-State: AC+VfDxF96P+eIes6IQfq1p3o8xj1Ocgo1xDJL1lO7coc/kGgZag0vic
	0FvcpUcBGjW6kAT+vdiIB4YCHA==
X-Google-Smtp-Source: ACHHUZ59kZn3tg+zLA9Ca3ir3FMu1GDEXLs7QRrSZyND0AmVMExTTKlkDSaz47bphbepDl1LxwP6oQ==
X-Received: by 2002:a7b:cbd8:0:b0:3fa:781a:3d07 with SMTP id n24-20020a7bcbd8000000b003fa781a3d07mr119274wmi.35.1687426020373;
        Thu, 22 Jun 2023 02:27:00 -0700 (PDT)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id o8-20020a5d4a88000000b003068f5cca8csm6545537wrq.94.2023.06.22.02.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 02:26:59 -0700 (PDT)
Date: Thu, 22 Jun 2023 11:26:59 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	syzbot+a7d200a347f912723e5c@syzkaller.appspotmail.com,
	Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH net] netlink: fix potential deadlock in netlink_set_err()
Message-ID: <ZJQT4/SZJN7qGUHI@nanopsycho>
References: <20230621154337.1668594-1-edumazet@google.com>
 <ZJQAdLSkRi2s1FUv@nanopsycho>
 <CANn89iLeU+pBrcHZyQoSRa-X_3G-Y8cjF6FJy4XwkJc7ronqMA@mail.gmail.com>
 <ZJQGTnqo6IgMGZ4j@nanopsycho>
 <CANn89iK8p7SuGE7rrOKZ6bxoZZhQXBHufj8+YnbNoE-ivKopiw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iK8p7SuGE7rrOKZ6bxoZZhQXBHufj8+YnbNoE-ivKopiw@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Thu, Jun 22, 2023 at 10:42:34AM CEST, edumazet@google.com wrote:
>On Thu, Jun 22, 2023 at 10:29 AM Jiri Pirko <jiri@resnulli.us> wrote:
>>
>> Thu, Jun 22, 2023 at 10:14:56AM CEST, edumazet@google.com wrote:
>> >On Thu, Jun 22, 2023 at 10:04 AM Jiri Pirko <jiri@resnulli.us> wrote:
>> >>
>> >> Wed, Jun 21, 2023 at 05:43:37PM CEST, edumazet@google.com wrote:
>> >> >syzbot reported a possible deadlock in netlink_set_err() [1]
>> >> >
>> >> >A similar issue was fixed in commit 1d482e666b8e ("netlink: disable IRQs
>> >> >for netlink_lock_table()") in netlink_lock_table()
>> >> >
>> >> >This patch adds IRQ safety to netlink_set_err() and __netlink_diag_dump()
>> >> >which were not covered by cited commit.
>> >> >
>> >> >[1]
>> >> >
>> >> >WARNING: possible irq lock inversion dependency detected
>> >> >6.4.0-rc6-syzkaller-00240-g4e9f0ec38852 #0 Not tainted
>> >> >
>> >> >syz-executor.2/23011 just changed the state of lock:
>> >> >ffffffff8e1a7a58 (nl_table_lock){.+.?}-{2:2}, at: netlink_set_err+0x2e/0x3a0 net/netlink/af_netlink.c:1612
>> >> >but this lock was taken by another, SOFTIRQ-safe lock in the past:
>> >> > (&local->queue_stop_reason_lock){..-.}-{2:2}
>> >> >
>> >> >and interrupts could create inverse lock ordering between them.
>> >> >
>> >> >other info that might help us debug this:
>> >> > Possible interrupt unsafe locking scenario:
>> >> >
>> >> >       CPU0                    CPU1
>> >> >       ----                    ----
>> >> >  lock(nl_table_lock);
>> >> >                               local_irq_disable();
>> >> >                               lock(&local->queue_stop_reason_lock);
>> >> >                               lock(nl_table_lock);
>> >> >  <Interrupt>
>> >> >    lock(&local->queue_stop_reason_lock);
>> >> >
>> >> > *** DEADLOCK ***
>> >> >
>> >> >Fixes: 1d482e666b8e ("netlink: disable IRQs for netlink_lock_table()")
>> >>
>> >> I don't think that this "fixes" tag is correct. The referenced commit
>> >> is a fix to the same issue on a different codepath, not the one who
>> >> actually introduced the issue.
>> >>
>> >> The code itself looks fine to me.
>> >
>> >Note that the 1d482e666b8e had no Fixes: tag, otherwise I would have taken it.
>>
>> I'm aware it didn't. But that does not implicate this patch should have
>> that commit as a "Fixes:" tag. Either have the correct one pointing out
>> which commit introduced the issue or omit the "Fixes:" tag entirely.
>> That's my point.
>
>My point is that the cited commit should have fixed all points
>where the nl_table_lock was read locked.

Yeah, it was incomplete. I agree. I don't argue with that.

>
>When we do locking changes, we have to look at the whole picture,
>not the precise point where lockdep complained.
>
>For instance, this is the reason this patch also changes  __netlink_diag_dump(),
>even if the report had nothing to do about it yet.
>
>So this Fixes: tag is fine, thank you.

Then we have to agree to disagree I guess. It is not fine.

Quoting from Documentation/process/handling-regressions.rst:
  Add a "Fixes:" tag to specify the commit causing the regression.

Quoting from Documentation/process/submitting-patches.rst:
  A Fixes: tag indicates that the patch fixes an issue in a previous commit. It
  is used to make it easy to determine where a bug originated, which can help
  review a bug fix.

1d482e666b8e is not causing any regression (to be known of), definitelly
not the one this patch is fixing.

Misusing "Fixes" tag like this only adds unnecessary confusion.
That is my point from the beginning. I don't understand your resistance
to be honest.


