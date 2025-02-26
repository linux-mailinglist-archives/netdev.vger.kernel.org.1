Return-Path: <netdev+bounces-169803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED454A45C32
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 11:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAF181680F5
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 10:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C176B24E00E;
	Wed, 26 Feb 2025 10:53:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6DA20E70A
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 10:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740567189; cv=none; b=mNQWSgnHHgHCMCha+I2P+QJ/08qXsX1y3J1sImj/wOGB2ienfytxZiOyGkx5hem8mQj0fG6GkEgTaGVV9wFOV0WoHhkuNEd2qMzDkiGWZ9TnupokVIkg0RKPby+NpaY5fBla8yKTSzNq7QEgn+yWXNaWODo8XorfRQxsPw37+tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740567189; c=relaxed/simple;
	bh=pGNZLomuxzn0HoywA8FEDpnonq1+flYSsf96WCnhe3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pkbN3PS8oGwcCxMLZOgdjHqRY+MqdvoL9JXSeYMe4u/ixplrzQ7ShrfDM7lYMZhUGakuBNPUaWPeXalF6TMdCSD9KAF+8yawGcEm7ScUleoqLgdnoUwV4e1qDSaP8I7tBdSKZHXBTNI9NG2J0o0kNFz6OjzF6z8e00C6hZmm/VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ab78e6edb99so940089766b.2
        for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 02:53:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740567186; x=1741171986;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fVn7T1no283vEaUvMOKB9qHiB5VyQWGOPH2vDUp2JVU=;
        b=wNyqsT4hImkAcf9AFzNq5Z8N0kkriEAznZdTPzRbMuDrlCSeZQiABTQP60YX6auKE/
         5b085wh1STb2DflI9MfxQr8TmOvTolpYV6CJkHIcFnQGdeuikwwbtDi7PFjjY4wknfKQ
         RotT1X0oFYZPs66f9ZBnFNZXAbg3d3EX0LKaReecwIRfXp+0xlbcVDfETqcZ23pivfEv
         X6Kgb9fdPzdswULcnjrm29J6hYS7cJmGwVip0NuSjPtbtl8cB5Gzpr6+3a08wyecmYsG
         /Hvo8uMDljRSRNHKjIT9b+Du77dxHQdhNkmRJ8Z9A5f0nSdhKrImUhee+7EMmEA2saSY
         +aqA==
X-Forwarded-Encrypted: i=1; AJvYcCUA97e1RVVT/LLhxGBY1JuiXk8gnPI7C4Md4AbWi6eQjjJlO9YJ0mhH1CxYGmiYoFKQqHdu5jA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxboFZzls5hE/Wt00B/spi/g1WZn6R7uP1otpq41C3OV68t7zV2
	zzDDzHdWlbVnHEvTlV6QfQL5/2iDZvtVmVlxGep9nRT5Jz/QCuK6
X-Gm-Gg: ASbGncsTuHmi/JgQcMxcf71A8w32CRByd/V05Ni1wk6dacC7jWmsD3tataNKwnObjqF
	HK6AyouaxMNBM1Y1kGV/fNm0gTUeTGn782UuM60TYTNzNjPUiz7q9BZXk7QG3IY/7bSRKcLWcy2
	0WJWVgjzOZmgCLTwZPU31ZW3Xk+UK7jaTbt/QdCbzqmUYWeOXtje/0IE6jwcHmRxD2LgCK8q/eE
	ggH2CxdehaS2P68ZDUH4Kc5c0lk/oyh/7PIDbczNblLhkkcrnahKQCGsW7nE51088mu5qKjarcF
	i3Lq5zipT75T4veG
X-Google-Smtp-Source: AGHT+IFKFv3Lc86U3smgUzp4O8bsvTa5XKNhnF1DflQjFgf2ScXM/5bkkWTW+P4LrYry1sqWRtxfLQ==
X-Received: by 2002:a17:906:292a:b0:ab7:e12a:4846 with SMTP id a640c23a62f3a-abeeed616fcmr228291966b.19.1740567186055;
        Wed, 26 Feb 2025 02:53:06 -0800 (PST)
Received: from gmail.com ([2a03:2880:30ff:9::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed1d5529dsm311125866b.53.2025.02.26.02.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 02:53:05 -0800 (PST)
Date: Wed, 26 Feb 2025 02:53:03 -0800
From: Breno Leitao <leitao@debian.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v1 net] net: Use rtnl_net_dev_lock() in
 register_netdevice_notifier_dev_net().
Message-ID: <20250226-resolute-azure-crocodile-ff7102@leitao>
References: <20250225211023.96448-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225211023.96448-1-kuniyu@amazon.com>

On Tue, Feb 25, 2025 at 01:10:23PM -0800, Kuniyuki Iwashima wrote:
> Breno Leitao reported the splat below. [0]
> 
> Commit 65161fb544aa ("net: Fix dev_net(dev) race in
> unregister_netdevice_notifier_dev_net().") added the
> DEBUG_NET_WARN_ON_ONCE(), assuming that the netdev is not
> registered before register_netdevice_notifier_dev_net().
> 
> But the assumption was simply wrong.
> 
> Let's use rtnl_net_dev_lock() in register_netdevice_notifier_dev_net().
> 
> [0]:
> WARNING: CPU: 25 PID: 849 at net/core/dev.c:2150 register_netdevice_notifier_dev_net (net/core/dev.c:2150)
>  <TASK>
>  ? __warn (kernel/panic.c:242 kernel/panic.c:748)
>  ? register_netdevice_notifier_dev_net (net/core/dev.c:2150)
>  ? register_netdevice_notifier_dev_net (net/core/dev.c:2150)
>  ? report_bug (lib/bug.c:? lib/bug.c:219)
>  ? handle_bug (arch/x86/kernel/traps.c:285)
>  ? exc_invalid_op (arch/x86/kernel/traps.c:309)
>  ? asm_exc_invalid_op (./arch/x86/include/asm/idtentry.h:621)
>  ? register_netdevice_notifier_dev_net (net/core/dev.c:2150)
>  ? register_netdevice_notifier_dev_net (./include/net/net_namespace.h:406 ./include/linux/netdevice.h:2663 net/core/dev.c:2144)
>  mlx5e_mdev_notifier_event+0x9f/0xf0 mlx5_ib
>  notifier_call_chain.llvm.12241336988804114627 (kernel/notifier.c:85)
>  blocking_notifier_call_chain (kernel/notifier.c:380)
>  mlx5_core_uplink_netdev_event_replay (drivers/net/ethernet/mellanox/mlx5/core/main.c:352)
>  mlx5_ib_roce_init.llvm.12447516292400117075+0x1c6/0x550 mlx5_ib
>  mlx5r_probe+0x375/0x6a0 mlx5_ib
>  ? kernfs_put (./include/linux/instrumented.h:96 ./include/linux/atomic/atomic-arch-fallback.h:2278 ./include/linux/atomic/atomic-instrumented.h:1384 fs/kernfs/dir.c:557)
>  ? auxiliary_match_id (drivers/base/auxiliary.c:174)
>  ? mlx5r_mp_remove+0x160/0x160 mlx5_ib
>  really_probe (drivers/base/dd.c:? drivers/base/dd.c:658)
>  driver_probe_device (drivers/base/dd.c:830)
>  __driver_attach (drivers/base/dd.c:1217)
>  bus_for_each_dev (drivers/base/bus.c:369)
>  ? driver_attach (drivers/base/dd.c:1157)
>  bus_add_driver (drivers/base/bus.c:679)
>  driver_register (drivers/base/driver.c:249)
> 
> Fixes: 7fb1073300a2 ("net: Hold rtnl_net_lock() in (un)?register_netdevice_notifier_dev_net().")
> Reported-by: Breno Leitao <leitao@debian.org>
> Closes: https://lore.kernel.org/netdev/20250224-noisy-cordial-roadrunner-fad40c@leitao/
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Tested-by: Breno Leitao <leitao@debian.org>

