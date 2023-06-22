Return-Path: <netdev+bounces-13002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F8B2739A50
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 10:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B0192818F3
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 08:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4673AA85;
	Thu, 22 Jun 2023 08:43:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8357780C
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 08:43:19 +0000 (UTC)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D91E26AC
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 01:42:58 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id e9e14a558f8ab-34226590ee3so158855ab.1
        for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 01:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687423365; x=1690015365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z9jW5wUxxCJjrpva8Zutp+rRZGmm7kM1irIqdH35Cdk=;
        b=Wf5zmcCPPTpJLIYXLAy98yAfdRgE2zYn64fwtEnGBtynxEPmMX5pJSbNt5PyTOXFCd
         lLUXrpa3QcihrJlkyYyY+/pOQjFe9L7Rgiw9DikLZKvzpui5pctbYwnogJFVTw44kIPN
         somrTd3Kfit/eGYEnElMI1oVCJSRKS/fS1qfpSCiP+jDZjGhFr+t9maQKVQLvNpFnmj/
         cxQB+BPqrrxMXmeZIV4gsNzU0CcBRITebL9y3kuuJ5pCH1oHku2uzomjx4vmMxQhOaYY
         HBcpljQJ6CzPPo+GseqeRZn9vjc7fGIAdXDFUV481uoD13YG66xs/YiOhAlT/Nlkyggm
         7efQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687423365; x=1690015365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z9jW5wUxxCJjrpva8Zutp+rRZGmm7kM1irIqdH35Cdk=;
        b=knd6wjuOXMNoni9bnV85ygoIKPMo07xVFfSdKmn9oNFzPu2gNbAHGFrI/Hu38/tMHl
         2jHnrUABZhsyPWp3S4dkVvprQKSWupbhzBvj4YxVLxJZMVDV3OGPr91N1QTThXjTT/Ac
         XvnOMVF9BiBLJzKnp3svCCIIyNZ1AHsG6o91pJnEecKgbAH89US02boOVtt0+bMrkcqU
         D+HRVPiLHr+WS9160IbVysmdUOMjFW1UIIEENQAhHFTwo7dEDJuBtF2z9e8ONgehuKZd
         6emxDmR0oI4qgMlv7wGhoNfs7G1eNaUWAAnkHaK6ceZZozdGv1vokKYU656lXL9vrXoN
         w87A==
X-Gm-Message-State: AC+VfDyleAhwV02AcsURpL5QHzl8I7wrRqbsUtV2PsVymml0eR5RgWba
	TVPiu9YAtTSTt6U+bUrG5Mc4yKVRrxlkaTFDzRP90g==
X-Google-Smtp-Source: ACHHUZ6rOWD6TjZXJMArW7VyICag9DWJmz85QdsVkPjvEM0YfATuEmPjmt+Hje6ZP4kIRF3hvDtQHjM2KFAAQYtp+EE=
X-Received: by 2002:a05:6e02:1c84:b0:335:62cc:3972 with SMTP id
 w4-20020a056e021c8400b0033562cc3972mr863834ill.19.1687423365363; Thu, 22 Jun
 2023 01:42:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230621154337.1668594-1-edumazet@google.com> <ZJQAdLSkRi2s1FUv@nanopsycho>
 <CANn89iLeU+pBrcHZyQoSRa-X_3G-Y8cjF6FJy4XwkJc7ronqMA@mail.gmail.com> <ZJQGTnqo6IgMGZ4j@nanopsycho>
In-Reply-To: <ZJQGTnqo6IgMGZ4j@nanopsycho>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 22 Jun 2023 10:42:34 +0200
Message-ID: <CANn89iK8p7SuGE7rrOKZ6bxoZZhQXBHufj8+YnbNoE-ivKopiw@mail.gmail.com>
Subject: Re: [PATCH net] netlink: fix potential deadlock in netlink_set_err()
To: Jiri Pirko <jiri@resnulli.us>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	syzbot+a7d200a347f912723e5c@syzkaller.appspotmail.com, 
	Johannes Berg <johannes.berg@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 22, 2023 at 10:29=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> wrot=
e:
>
> Thu, Jun 22, 2023 at 10:14:56AM CEST, edumazet@google.com wrote:
> >On Thu, Jun 22, 2023 at 10:04=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> w=
rote:
> >>
> >> Wed, Jun 21, 2023 at 05:43:37PM CEST, edumazet@google.com wrote:
> >> >syzbot reported a possible deadlock in netlink_set_err() [1]
> >> >
> >> >A similar issue was fixed in commit 1d482e666b8e ("netlink: disable I=
RQs
> >> >for netlink_lock_table()") in netlink_lock_table()
> >> >
> >> >This patch adds IRQ safety to netlink_set_err() and __netlink_diag_du=
mp()
> >> >which were not covered by cited commit.
> >> >
> >> >[1]
> >> >
> >> >WARNING: possible irq lock inversion dependency detected
> >> >6.4.0-rc6-syzkaller-00240-g4e9f0ec38852 #0 Not tainted
> >> >
> >> >syz-executor.2/23011 just changed the state of lock:
> >> >ffffffff8e1a7a58 (nl_table_lock){.+.?}-{2:2}, at: netlink_set_err+0x2=
e/0x3a0 net/netlink/af_netlink.c:1612
> >> >but this lock was taken by another, SOFTIRQ-safe lock in the past:
> >> > (&local->queue_stop_reason_lock){..-.}-{2:2}
> >> >
> >> >and interrupts could create inverse lock ordering between them.
> >> >
> >> >other info that might help us debug this:
> >> > Possible interrupt unsafe locking scenario:
> >> >
> >> >       CPU0                    CPU1
> >> >       ----                    ----
> >> >  lock(nl_table_lock);
> >> >                               local_irq_disable();
> >> >                               lock(&local->queue_stop_reason_lock);
> >> >                               lock(nl_table_lock);
> >> >  <Interrupt>
> >> >    lock(&local->queue_stop_reason_lock);
> >> >
> >> > *** DEADLOCK ***
> >> >
> >> >Fixes: 1d482e666b8e ("netlink: disable IRQs for netlink_lock_table()"=
)
> >>
> >> I don't think that this "fixes" tag is correct. The referenced commit
> >> is a fix to the same issue on a different codepath, not the one who
> >> actually introduced the issue.
> >>
> >> The code itself looks fine to me.
> >
> >Note that the 1d482e666b8e had no Fixes: tag, otherwise I would have tak=
en it.
>
> I'm aware it didn't. But that does not implicate this patch should have
> that commit as a "Fixes:" tag. Either have the correct one pointing out
> which commit introduced the issue or omit the "Fixes:" tag entirely.
> That's my point.

My point is that the cited commit should have fixed all points
where the nl_table_lock was read locked.

When we do locking changes, we have to look at the whole picture,
not the precise point where lockdep complained.

For instance, this is the reason this patch also changes  __netlink_diag_du=
mp(),
even if the report had nothing to do about it yet.

So this Fixes: tag is fine, thank you.

