Return-Path: <netdev+bounces-166176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF7CA34D4D
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 19:16:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 989111883766
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 18:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7786824167C;
	Thu, 13 Feb 2025 18:14:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6CE24167D;
	Thu, 13 Feb 2025 18:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739470450; cv=none; b=dNPYwkrJvTwGErz3PnpXcQPY5EVBpF/73OLNXX9afWAY3jHE1pX6eMCYgNrGh01oRuLc/zyWYnpTRt6HTejooan3AE6kKc6c1baCOrslcZ4BtH61LDuJBYvgwCaNJSXAfXkR2SwXn9r3SOqDOTrw9k3Dx6ZhRHyN6Ef7v6hEzzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739470450; c=relaxed/simple;
	bh=Jt7S6MGjAZ7Za+Gaqb6iJTq7tHpUSIgR+BeyvqBL0Jk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N98msQuoBDlS9IwWqZBhTzTGvR6diqHUjVnytTKZY9hRBu9Czq5kPrz7OLXRg1/zI1wbNFJTZE+aryBsrKHgsO8v0WUyVECiqJnwkgTk+eReZBMkpw2deltTee8AFFLZuocyqS192l3TkwKVqtnD9ME1eLGR/4U1yPRUL9gNs1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ab7c14b880dso258421966b.1;
        Thu, 13 Feb 2025 10:14:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739470447; x=1740075247;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V1vsGOWJdttwhEgzm+cLPJc4SNcZ4v2S44Lb53K2njg=;
        b=ezfBSE1o59qk4NBHkjMfvCmOjknhF05NNCGagmfZH07KvGQB4wZX8e92Z1MkIDTth+
         nZj78M2yPFGMEEmZ7GhpkhywMf6coxcXpieTOhBeIkN6C5uuiv/llhZ7jC2NYYqkHbQe
         Jx8TytiSrDkUzinIWfjpt1zYP41F4Hiw/fx+a5OV3ZWAPFtmKPyWgqtdyCNXwdiTLIal
         o2Lrtowo/0NA/mVKFoSy2wNK9ecJyO5rBWhu2DiViIxBKzlp2HSFsBBgxnYZrQICfnED
         VG9LYRp8L9cPg7h9Eo8jiOAx2dw5i0cNDQVy/03+oFT8/Sm33Y2HSo9+6/oGnYhAY5/Y
         HHBA==
X-Forwarded-Encrypted: i=1; AJvYcCVSui9WthKEkOgJrPDqy1PM1RDs1KwLEyQt5Yd1+PBSkacAKawdimxbZfyRqlCy7ySFdSScvRXO@vger.kernel.org, AJvYcCVWA0wAqB3RxOtFBw7pJFUBb0GxCxDhMmXagNRNEDU6JLWrPReCNmlCaa8KxA7PhKAi8EiCmb9cliwW@vger.kernel.org, AJvYcCWjhcv/PgpyuiSde73+DTj9ybMSeBU/ThNGUi5xaIkikfzzSLvYpiXSVHNb5TnyWpU43BHQQBUBAfIibSY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSaNAQ/mifFHjEDz3Ii3MblL6iQyMD9I9THhDuF1n0fAfl3HAX
	ukIlNOFLUKPPIJl9CD5UXu2Yp2paagY4kFqtzVrcxwh5+1xhaN4r
X-Gm-Gg: ASbGncsbcK9lMGkbXLrA0SgFopueGZLMNXr0347msQtopK6PbgZQAAbPOYXWO41dEa/
	Q11aNWE4ZbWf1A+osDvLdYohmTzcpjL0M1Ueo0TINmM4uYl4VfvtUuxGGcyW2sn5ilpTCA+vjOG
	GrKeG7Agyh5Tzrkf1mXuGOq7mV2ky3nBZSeDdc1R+wNDaRM3MSCsfsKdy+Wn+4gau6My9A0tQx+
	YgLaP+iLQdG1X3PNXNCmERaYPuzvAOe1DVPN9Ob9BH/LgF9wtVGGGS7ZPJQy98fzFtTyVEsBVJa
	oL/ZCw==
X-Google-Smtp-Source: AGHT+IHRMfC8d2zMDpBDVeM9qS3ZR89TcB/t7rDOFosvDV+9y0bC55JTHxfVgnIsHG4ZY2r0xZnlcw==
X-Received: by 2002:a17:907:35c4:b0:ab7:fbb2:b47c with SMTP id a640c23a62f3a-ab7fbb2b6c7mr529013866b.35.1739470446371;
        Thu, 13 Feb 2025 10:14:06 -0800 (PST)
Received: from gmail.com ([2a03:2880:30ff:1::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece271223sm1582535a12.59.2025.02.13.10.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 10:14:05 -0800 (PST)
Date: Thu, 13 Feb 2025 10:14:02 -0800
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Hayes Wang <hayeswang@realtek.com>,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 1/2] net: Assert proper context while calling
 napi_schedule()
Message-ID: <20250213-camouflaged-shellfish-of-refinement-79e3df@leitao>
References: <20250212174329.53793-1-frederic@kernel.org>
 <20250212174329.53793-2-frederic@kernel.org>
 <20250212194820.059dac6f@kernel.org>
 <20250213-translucent-nightingale-of-upgrade-b41f2e@leitao>
 <20250213071426.01490615@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213071426.01490615@kernel.org>

Hello Jakub,

On Thu, Feb 13, 2025 at 07:14:26AM -0800, Jakub Kicinski wrote:
> On Thu, 13 Feb 2025 01:58:17 -0800 Breno Leitao wrote:
> > > Looks like netcons is hitting this warning in netdevsim:
> > > 
> > > [   16.063196][  T219]  nsim_start_xmit+0x4e0/0x6f0 [netdevsim]
> > > [   16.063219][  T219]  ? netif_skb_features+0x23e/0xa80
> > > [   16.063237][  T219]  netpoll_start_xmit+0x3c3/0x670
> > > [   16.063258][  T219]  __netpoll_send_skb+0x3e9/0x800
> > > [   16.063287][  T219]  netpoll_send_skb+0x2a/0xa0
> > > [   16.063298][  T219]  send_ext_msg_udp+0x286/0x350 [netconsole]
> > > [   16.063325][  T219]  write_ext_msg+0x1c6/0x230 [netconsole]
> > > [   16.063346][  T219]  console_emit_next_record+0x20d/0x430
> > > 
> > > https://netdev-3.bots.linux.dev/vmksft-net-drv-dbg/results/990261/7-netcons-basic-sh/stderr
> > > 
> > > We gotta fix that first.  
> > 
> > Thanks Jakub,
> > 
> > I understand that it will be fixed by this patchset, right?
> 
> The problem is a bit nasty, on a closer look. We don't know if netcons
> is called in IRQ context or not. How about we add an hrtimer to netdevsim,
> schedule it to fire 5usec in the future instead of scheduling NAPI
> immediately? We can call napi_schedule() from a timer safely.
> 
> Unless there's another driver which schedules NAPI from xmit.
> Then we'd need to try harder to fix this in netpoll.
> veth does use NAPI on xmit but it sets IFF_DISABLE_NETPOLL already.

Just to make sure I follow the netpoll issue. What would you like to fix
in netpoll exactly?

