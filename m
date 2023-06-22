Return-Path: <netdev+bounces-12950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 627FF7398EF
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 10:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 345DE281890
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 08:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600D913ADF;
	Thu, 22 Jun 2023 08:04:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49876613A
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 08:04:09 +0000 (UTC)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81820198
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 01:04:07 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-31129591288so5058636f8f.1
        for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 01:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1687421046; x=1690013046;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=inve83C9tiK42cMs545a1ENvcwHI2ptePob2phRB2Vg=;
        b=APhb0cwd6UFaxNEHvhHAyb9tvFF9SxTwg9n5vWe/plU6Sm4jsDp2c1Rk4ACH3u+2kD
         Vr9t3wsIG8X2mGNUtRaMpnb+P4t53rZb6+nLubSet9y4yLAKOHB2Iquqw/mS4vUwapYB
         xG7S4eOShgHn+0rS/4bhIe6yfok5dFqbQ45w8shh5En3RVw7WOV6U0cEB50yk2DCHpBO
         J5gksU0v+vuFIv0f7H2N5oVh8DBQo0LGfDHptZlwikd9jvVxkM7LIpA4nNNE0CNbiy3I
         ewfdXjw3yuNcwOdE1QL/KNCE3dBkkHM2IkFa7B9+pkmRbo1dQ8TfU1ugK+OY3LS3NPKG
         CppA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687421046; x=1690013046;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=inve83C9tiK42cMs545a1ENvcwHI2ptePob2phRB2Vg=;
        b=NVverQycpSIocOsMoCExXBzzkszcEOpROvkdcFufh56+t480haUlUF7rblc/dm8zCh
         YqyGAH+tZLDi0m+ZgUaTKqnNILvVjO85RxCkBgDB4WWQfh2Hjpa8AyXlJ0OOm8yNjYu7
         peInn3kaXy5WRbWj80Hxp4Vd8A+2CtaXwHwYnK9BQ7/jz+J3Q2etmdN1Ms1kwnzhH0F9
         T8w+bhAJF3B62RG9yRclpvP7PAqEarRXOxbNMbEGoPrK/Kl7v8DKblTWoKQYwVozK7AB
         Jet+E/wvRgwk25J2DKumdWCmMRTfN3cspPJ7OHWC1ICzHUzouVABkcbvbfzZbvzggFkL
         mxEQ==
X-Gm-Message-State: AC+VfDzru82jRhHAqwiH4G0owJlL7MTnDbrVSh1sPGXQokmmkVXph3xB
	mdHxxixEDt+4byvceLC0WTpXlg==
X-Google-Smtp-Source: ACHHUZ6+iEREHCkCCg0z//Fc6TgOvL2lQIaWN+scCmV53MiCHj7sMz8+VFJiaUWUWRjREtQ7yMbMzg==
X-Received: by 2002:a5d:6307:0:b0:311:1f62:172a with SMTP id i7-20020a5d6307000000b003111f62172amr10895427wru.16.1687421045855;
        Thu, 22 Jun 2023 01:04:05 -0700 (PDT)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id f1-20020adfdb41000000b0030ae499da59sm6366955wrj.111.2023.06.22.01.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 01:04:05 -0700 (PDT)
Date: Thu, 22 Jun 2023 10:04:04 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	syzbot+a7d200a347f912723e5c@syzkaller.appspotmail.com,
	Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH net] netlink: fix potential deadlock in netlink_set_err()
Message-ID: <ZJQAdLSkRi2s1FUv@nanopsycho>
References: <20230621154337.1668594-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621154337.1668594-1-edumazet@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Wed, Jun 21, 2023 at 05:43:37PM CEST, edumazet@google.com wrote:
>syzbot reported a possible deadlock in netlink_set_err() [1]
>
>A similar issue was fixed in commit 1d482e666b8e ("netlink: disable IRQs
>for netlink_lock_table()") in netlink_lock_table()
>
>This patch adds IRQ safety to netlink_set_err() and __netlink_diag_dump()
>which were not covered by cited commit.
>
>[1]
>
>WARNING: possible irq lock inversion dependency detected
>6.4.0-rc6-syzkaller-00240-g4e9f0ec38852 #0 Not tainted
>
>syz-executor.2/23011 just changed the state of lock:
>ffffffff8e1a7a58 (nl_table_lock){.+.?}-{2:2}, at: netlink_set_err+0x2e/0x3a0 net/netlink/af_netlink.c:1612
>but this lock was taken by another, SOFTIRQ-safe lock in the past:
> (&local->queue_stop_reason_lock){..-.}-{2:2}
>
>and interrupts could create inverse lock ordering between them.
>
>other info that might help us debug this:
> Possible interrupt unsafe locking scenario:
>
>       CPU0                    CPU1
>       ----                    ----
>  lock(nl_table_lock);
>                               local_irq_disable();
>                               lock(&local->queue_stop_reason_lock);
>                               lock(nl_table_lock);
>  <Interrupt>
>    lock(&local->queue_stop_reason_lock);
>
> *** DEADLOCK ***
>
>Fixes: 1d482e666b8e ("netlink: disable IRQs for netlink_lock_table()")

I don't think that this "fixes" tag is correct. The referenced commit
is a fix to the same issue on a different codepath, not the one who
actually introduced the issue.

The code itself looks fine to me.

