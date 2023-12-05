Return-Path: <netdev+bounces-53832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F233E804C8D
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 09:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CE1F1F2149D
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 08:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B6F3C680;
	Tue,  5 Dec 2023 08:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sx4IwTV5"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E506BD4F
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 00:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701765373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JHfdVOUnOL0Qlr54vUu/fMOtlv7Ai14q0h8egmUjQtw=;
	b=Sx4IwTV5YukDZOHhKUusQrF0vdc0ApmWBYTwrx9QsfLBXe7zrvH7R1EL1C/ivtgvR5+tRj
	BDEBoUXiwOi+xp17LdC+z30Y5xBpEW/3P42Ckkd8jU425nawpCfLRYmm6udWhFK7146Krm
	jYNi3m+7R7q2/2i9Nx8BvL/jwtNHv5k=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-L05CY3QbPdywHXkS6wca7A-1; Tue, 05 Dec 2023 03:36:06 -0500
X-MC-Unique: L05CY3QbPdywHXkS6wca7A-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-50be5899082so2803584e87.2
        for <netdev@vger.kernel.org>; Tue, 05 Dec 2023 00:36:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701765364; x=1702370164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JHfdVOUnOL0Qlr54vUu/fMOtlv7Ai14q0h8egmUjQtw=;
        b=n22/iT9DkRNfA8dcx8YKHDL1RvXKJJGnfiSlR9+JlNI8Mgxehn+EKskwDQf+Vsn0m7
         n3TTfAWobeBfjs/KqyDEPFDTY7iwkYhWKkjuVBP+qd/JyCFC2P1+EfqItnilwH7iNMCJ
         7dOHkxq6u9+HKAcD3BUpFUNotyV+Nb+teoab8lawb/kxmD6IAPHKj8c8DmKL/tRzIS6s
         pajob/p9ZvfsU0mxzoaMAn7iE1imeR6ez5G5pqyozkiGMoR7FzNa9PdKyDJdYiD+N90j
         W0rpmH1AG70iyolhsQYJNRNTxUzmKv+BmCodq//FqDxxLF6ludVGeEHvjPLq3cac+a74
         3iYg==
X-Gm-Message-State: AOJu0YzDAOgLY5ltQ8Wj+XE8rTyg87BxXiTLiga/j6EhaKH46Pq1B3ab
	l8PtqWn0WDMXVm/Tltias6OTPNClmrKaJCrI/7A/fmrhLv8wH9x0n9w7rIYLUWv1kqZfGxy+LJJ
	Aux6zOEkMsyysq0fRypySTnFx286iIawWAKrddtzBrD8slcKv
X-Received: by 2002:a05:6512:5c2:b0:50b:ec63:8cf with SMTP id o2-20020a05651205c200b0050bec6308cfmr1484080lfo.21.1701765364330;
        Tue, 05 Dec 2023 00:36:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEFFzTieeIVfCJJxqgO1jKvlJv6tH/20cnndeMd22aW4CQhkD8o+6+mVywjHMgfTJ+1DDzEnSckk2WXYMA10N0=
X-Received: by 2002:a05:6512:5c2:b0:50b:ec63:8cf with SMTP id
 o2-20020a05651205c200b0050bec6308cfmr1484074lfo.21.1701765364002; Tue, 05 Dec
 2023 00:36:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1701762688.git.hengqi@linux.alibaba.com> <245ea32fe5de5eb81b1ed8ec9782023af074e137.1701762688.git.hengqi@linux.alibaba.com>
In-Reply-To: <245ea32fe5de5eb81b1ed8ec9782023af074e137.1701762688.git.hengqi@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 5 Dec 2023 16:35:52 +0800
Message-ID: <CACGkMEurTAGj+mSEtAiYtGfqy=6sU33xVskAZH47qUi+GcyvWA@mail.gmail.com>
Subject: Re: [PATCH net-next v6 4/5] virtio-net: add spin lock for ctrl cmd access
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	mst@redhat.com, pabeni@redhat.com, kuba@kernel.org, yinjun.zhang@corigine.com, 
	edumazet@google.com, davem@davemloft.net, hawk@kernel.org, 
	john.fastabend@gmail.com, ast@kernel.org, horms@kernel.org, 
	xuanzhuo@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 5, 2023 at 4:02=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.com> w=
rote:
>
> Currently access to ctrl cmd is globally protected via rtnl_lock and work=
s
> fine. But if dim work's access to ctrl cmd also holds rtnl_lock, deadlock
> may occur due to cancel_work_sync for dim work.

Can you explain why?

> Therefore, treating
> ctrl cmd as a separate protection object of the lock is the solution and
> the basis for the next patch.

Let's don't do that. Reasons are:

1) virtnet_send_command() may wait for cvq commands for an indefinite time
2) hold locks may complicate the future hardening works around cvq

Thanks


