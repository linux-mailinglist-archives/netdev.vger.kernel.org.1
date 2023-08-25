Return-Path: <netdev+bounces-30548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3422A787EF7
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 06:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CC7F1C20F3D
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 04:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49470A50;
	Fri, 25 Aug 2023 04:18:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393B8A31
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 04:18:46 +0000 (UTC)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B23C1FEA
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 21:18:45 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-4005f0a6c2bso34545e9.1
        for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 21:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692937124; x=1693541924; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PGG0r2s/zKnKCX6e58SnLQEC0ecMvUzJNpn5TwLz2AI=;
        b=E+XgbNynV/Z9LeBg5FbsjwaaKrFQIAFWx26XsOw6GEO61W8SuADlYDf4KN1+o3QbGJ
         Q/qp4lhv7MXupGWtVnDzKfD9mP8LlCeS0dsIDf9IytNb5yFxNqZPN3Iv5ujArHe4xPTD
         3nvRppadts4tu2P9nRK7d83CFmgU2sLeLf9baUT/Z6l8LQXwbhePiMIGUvz4PCSGWlt2
         x0OPidRpidbXpXKxXJFqMEg3GLskq+EwZGq1t4DUlqhb4kXFGbYpTydWbGE+SZE5Y989
         nU15BA0AqwXmnAV6nULfXGEHqOwvHUOhlxxspkMf8/eStb0JuHWuLNSMnU3hLYaMKDku
         iAow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692937124; x=1693541924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PGG0r2s/zKnKCX6e58SnLQEC0ecMvUzJNpn5TwLz2AI=;
        b=RGLQ06t2JjuLmLr1QczI360k+/m0Ew2adP0FUSfBmxJJ2l1C5LtnE7gvv9wdJl6cB7
         HrwJF7HlDCwITUwuNGzCmMDRWPbYw3lPnDmPdAODIC9Jtms4YPsrh4kG3BMVio/rdFAf
         9wTBgI6bkr7RBZ5mlAZPq0y1BVh903spvpDo6cl5aA0lAGcj23bdqvWk0nc0xVWJVKyd
         dME9GctPzwlzl+nwwVKS2SYFk4Bqkxxs/vhD23mAns34Ejvzioiq+b3jvnSTBJNlwdH5
         7+n2oOm7r8SB/ZnZOB7kmTFq3joCrO2OrDfwmgmiDhd1YRNPTfe3rYN9aiywQ72Y0d7J
         qHKg==
X-Gm-Message-State: AOJu0YzG94lWKQ/73Cjx5XOOuKJALqaDaSlt9M4irpCM9rFyMM5xW4b+
	xXAAFyauT2kavmtBFfe3sTcZK2cCUKJi8r1uuRRU
X-Google-Smtp-Source: AGHT+IE2UsyQUsldYE5MXI+562lkXCqi1kpGWn1pc58IuVJzbLjK3nuhLqcGTqoS4Ye7ZrDQHBn4yggAGKJCIXL+yxM=
X-Received: by 2002:a05:600c:1d84:b0:3f4:fb7:48d4 with SMTP id
 p4-20020a05600c1d8400b003f40fb748d4mr82239wms.3.1692937123755; Thu, 24 Aug
 2023 21:18:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230818011256.211078-1-peter.hilber@opensynergy.com>
In-Reply-To: <20230818011256.211078-1-peter.hilber@opensynergy.com>
From: John Stultz <jstultz@google.com>
Date: Thu, 24 Aug 2023 21:18:32 -0700
Message-ID: <CANDhNCo_Z2_tnuCyvu-j=eqOkvDQ+_n2O-=JKpf2Ndqx1m5GqQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] treewide: Use clocksource id for get_device_system_crosststamp()
To: Peter Hilber <peter.hilber@opensynergy.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, netdev@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Richard Cochran <richardcochran@gmail.com>, 
	Stephen Boyd <sboyd@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Wanpeng Li <wanpengli@tencent.com>, x86@kernel.org, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	James Morse <james.morse@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 17, 2023 at 6:13=E2=80=AFPM Peter Hilber
<peter.hilber@opensynergy.com> wrote:
>
> This patch series changes struct system_counterval_t to identify the
> clocksource through enum clocksource_ids, rather than through struct
> clocksource *. The net effect of the patch series is that
> get_device_system_crosststamp() callers can supply clocksource ids instea=
d
> of clocksource pointers, which can be problematic to get hold of.

Hey Peter,
  Thanks for sending this out. I'm a little curious though, can you
expand a bit on how clocksource pointers can be problematic to get a
hold of? What exactly is the problem that is motivating this change?

I just worry that switching to an enumeration solution might be
eventually exposing more than we would like to userland.

thanks
-john

