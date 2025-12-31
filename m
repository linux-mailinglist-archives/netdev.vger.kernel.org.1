Return-Path: <netdev+bounces-246423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 88366CEBD76
	for <lists+netdev@lfdr.de>; Wed, 31 Dec 2025 12:15:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AF971300F611
	for <lists+netdev@lfdr.de>; Wed, 31 Dec 2025 11:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A401313E02;
	Wed, 31 Dec 2025 11:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="tMjHCubG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39FF2D73A3
	for <netdev@vger.kernel.org>; Wed, 31 Dec 2025 11:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767179699; cv=none; b=iDhEAiZrpnIMVIkxtYKI/UBA/4LezPhvkOMVTpVUCrwPFNQsFzir4Q5nOEHVrxZe29K6iozQyFN9BuUUMkeNjLpIazQUU1sN54dRFpuCfHeoyLeQ/CRIygYP3rwlnGFbmHZqCUFrKHjD+GQr0zNXFKRT0hZPmCQENuFwnC+3v7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767179699; c=relaxed/simple;
	bh=tkDmmKE53uMXasuWbPWPdAKXnYeMy78fXdSHQRj6umw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k8hJ/R4YbZI580O9faGVJdG19Z9ntGAaMAbSrFxwMDnlsN62VtgbCRxmi/JFjEVmk7LwCaBau3SRlAK+XQJMn8sTmR3TzHmwHi0naAVpr0kVa7fVI7gTVkvwo/55B1UawWuSoEcEo6jfH5uZqbga6eRPOUi9UvB6gHyWJHHdPD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=tMjHCubG; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47a8195e515so65565965e9.0
        for <netdev@vger.kernel.org>; Wed, 31 Dec 2025 03:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1767179694; x=1767784494; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tkDmmKE53uMXasuWbPWPdAKXnYeMy78fXdSHQRj6umw=;
        b=tMjHCubGd3V4bnxOEvtliUxD9ubk5MKKHLRivZCD3xGLd1xjXbs0eGklGCoLm0CLt1
         1TWRmyHEdUWMsMFhlOrIlxniE1v6qjbKjuJFXstdGC152UDnGEwLGGI0M5nPX8Ao8//8
         Za5bJlZSoDZTiw+a/wIwPO4CLWPfk19h5JqBRzc3m1orUKcfkrSuGPGmD6ragmiw8OBa
         SzlFi5TY4XvO1OxFr0joQOpiljcbi0dZZYEXfX0fos4lKt+IyeZy4Q4E2PbtrB9sbZ1s
         yA9IDH0a8ClV4fc/bVsPwpPwc8V+SKGqJTcwSeipXDTqJ1fGUMK5I88FWrb7kT63K+Ya
         Xf2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767179694; x=1767784494;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tkDmmKE53uMXasuWbPWPdAKXnYeMy78fXdSHQRj6umw=;
        b=hvPqppxYRsHnGRPPRUE8jqMO6/txPY84Hq7Lffx6YGDr8QgD3u5QkZU3sE7tCL5Rbv
         52Vqjt1Mbsjwg5jPPk2xWn0wj0gjFvNzjMsimisIvMyD8lO20+OHyBkKQ28YT+ekpTS9
         zWvcqSFGMUPPyFyHsLrb/3ZfMMBcTcoqhfku9/OQP2640O6OVymQhI8X1/8Nz2ASKS2t
         qn4G2U0DJ4p7MaRkaM66OuqCcVrVg2TmFyjtpmV1EOC8aKe6m+6RBfwZn47kRMlCLX2W
         8m3v2NG93Tpps9hvxQeFlWgM7W2MmWv54CZh7WfqKYcJYEotR8IBfefy3vBvzHktQLWZ
         i5yw==
X-Forwarded-Encrypted: i=1; AJvYcCUwVEr+BifOrWBBjFkylKQmpKmxBVLJEhJ76xghr0vVF2IezrSGnvalDW10Pl9l0mwgz0GbnI8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhfKd7ObQOeRsiHx1jTIii5sXRp+9Ax+2ouIhLfepYS+GdvR09
	LNRd2HUCEkX668/yjZjskQJpVOjmTs9Vp2ZDMgXpsMMEi/deGZwsbbqnAmnvQY8b4G4=
X-Gm-Gg: AY/fxX4eIWFW8zcvbL7NmBpBYhj3Dxk7PR3WVRo8QLQ4uPxDcIqb0IfPNyodWVgETpK
	exdSrNaN/NlUeR91r/+0ZvdoB32q/x2sItipHFUni7afWVxxnaigp71+rp5yfP2T8FPbkzAqNEA
	P8ModP9J5vXHUNY9JPmjtiB+T5qGpR66uU83pYZQ2Flt0m4Q7JR3MV60K9NVg1/t34j/2lfltUr
	5ZDxBPcHSWxjg8NNcpeQO6sCPt2PLOdmVzi2Eh76/toVG6YAK9tz/4jJfw7XkDLqWBzkI81zIdd
	gkulA5DgCSm/3a8I56rQZApFhpZI5CnFwEQjRwrqh6O0eAngt6YooBmS7Sjef8oS5aaRAenPTv9
	b3wD2MZSSmG3aZRTvNeINoYeTNEEY7E/IoHf3MuegNXLbY+yBLCXx3QS7+9cm3xBM2sLc2IEjJN
	T83adDyyqsHNoHNE/iAbqCUAgWyuy4
X-Google-Smtp-Source: AGHT+IGMtaJXoovbo2PQ1F27BguelXZUDbYGedpDVrbAnujnog0Z+dPhlMcUbpzXmKuMWPaYR+mcjA==
X-Received: by 2002:a05:600c:314d:b0:47d:586e:2fea with SMTP id 5b1f17b1804b1-47d586e309dmr121457085e9.15.1767179693996;
        Wed, 31 Dec 2025 03:14:53 -0800 (PST)
Received: from FV6GYCPJ69 ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d1936d220sm706164765e9.8.2025.12.31.03.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 03:14:53 -0800 (PST)
Date: Wed, 31 Dec 2025 12:14:50 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Xiao Liang <xiliang@redhat.com>
Cc: shayagr@amazon.com, akiyano@amazon.com, darinzon@amazon.com, 
	saeedb@amazon.com, netdev@vger.kernel.org
Subject: Re: [PATCH v2] net/ena: fix missing lock when update devlink params
Message-ID: <hwvwosj5ccc6ulas3rk4b3rnx3be6rr3jrow2lobg5tmg4nc47@bcrdpysve4g3>
References: <20251229145708.16603-1-xiliang@redhat.com>
 <20251231012030.6184-1-xiliang@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251231012030.6184-1-xiliang@redhat.com>

Wed, Dec 31, 2025 at 02:20:30AM +0100, xiliang@redhat.com wrote:
>From: Frank Liang <xiliang@redhat.com>
>
>Fix assert lock warning while calling devl_param_driverinit_value_set()
>in ena.
>
>WARNING: net/devlink/core.c:261 at devl_assert_locked+0x62/0x90, CPU#0: kworker/0:0/9
>CPU: 0 UID: 0 PID: 9 Comm: kworker/0:0 Not tainted 6.19.0-rc2+ #1 PREEMPT(lazy)
>Hardware name: Amazon EC2 m8i-flex.4xlarge/, BIOS 1.0 10/16/2017
>Workqueue: events work_for_cpu_fn
>RIP: 0010:devl_assert_locked+0x62/0x90
>
>Call Trace:
> <TASK>
> devl_param_driverinit_value_set+0x15/0x1c0
> ena_devlink_alloc+0x18c/0x220 [ena]
> ? __pfx_ena_devlink_alloc+0x10/0x10 [ena]
> ? trace_hardirqs_on+0x18/0x140
> ? lockdep_hardirqs_on+0x8c/0x130
> ? __raw_spin_unlock_irqrestore+0x5d/0x80
> ? __raw_spin_unlock_irqrestore+0x46/0x80
> ? devm_ioremap_wc+0x9a/0xd0
> ena_probe+0x4d2/0x1b20 [ena]
> ? __lock_acquire+0x56a/0xbd0
> ? __pfx_ena_probe+0x10/0x10 [ena]
> ? local_clock+0x15/0x30
> ? __lock_release.isra.0+0x1c9/0x340
> ? mark_held_locks+0x40/0x70
> ? lockdep_hardirqs_on_prepare.part.0+0x92/0x170
> ? trace_hardirqs_on+0x18/0x140
> ? lockdep_hardirqs_on+0x8c/0x130
> ? __raw_spin_unlock_irqrestore+0x5d/0x80
> ? __raw_spin_unlock_irqrestore+0x46/0x80
> ? __pfx_ena_probe+0x10/0x10 [ena]
> ......
> </TASK>
>
>Signed-off-by: Frank Liang <xiliang@redhat.com>
>Reviewed-by: David Arinzon <darinzon@amazon.com>

Missing "Fixes" tag?

