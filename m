Return-Path: <netdev+bounces-202781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9999AEEFF7
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 09:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D92221BC52B4
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 07:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9738724A044;
	Tue,  1 Jul 2025 07:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="K2M8ZDfn"
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8264536B;
	Tue,  1 Jul 2025 07:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751355933; cv=none; b=WtnnLKfYp1maOQNtdoWjR9EwWVVdqN+wB+kckPY5zY5ANsR/mhTs6tUbVgDcJJjGlb2C2SnPExqaDUX+0DTusPfhzDyMIHb/bjYigfASAb2nZOu15uc0BwAAAKzE5d710tYIf+Xqw9uGpZ4hpEs8nDfNkhNu5ybjQLgn+kfRsiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751355933; c=relaxed/simple;
	bh=hB/aY+gprfpuEYBJJ1+GZ6YqXSIcgsth+ikl30TWT3o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SHB8SmT2mf+mfhuE0O/CounlOFkuS3XeBhsMR3pTWesBl9Sj/93UKYHMCh8uS7AaXeKUSXEF56IWHm9uhBXJxvj8GtfCK48LRkAUv4LBImtn5BJ+8Mw2tTvQNhK1q7YMZ9th7CZsyExjIBh/rKfYxgfEpSimZ5Zip/GqVRMhCV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=K2M8ZDfn; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1751355922;
	bh=0nrbb+Xlx9X2VR8DDtJaUn2jnTTU7scYzRpnf9hQpPQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To;
	b=K2M8ZDfnTP1cVCGwKi4OSiVPO59nD2kyz9StAnSTWHxACcdVjAYEQWb4UOB6Vsuej
	 KoqLQcID5g9SmgHUMi+xguTMMuWREomnTqrvlpdcReUaDb+QcuHXpfpuFdnPP9znKZ
	 U799CYyRsMxlw/bD4rhHrcVhOVGKIQ6v/XZGAOac=
X-QQ-mid: zesmtpsz8t1751355918tea046ad6
X-QQ-Originating-IP: cwc96R1ZOC1CB5NdXrgvsfqLZbBeKO51qXhodojo/5c=
Received: from mail-yw1-f177.google.com ( [209.85.128.177])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 01 Jul 2025 15:45:16 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 710415980679416210
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-712be7e034cso28091997b3.0;
        Tue, 01 Jul 2025 00:45:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU7IweACEq2KGWzOE0s0faa0g4lnjtmJ3nRcabbWYgQkVt86XLaICS8Mr8Oav/yjVJ9iIQh9YYf2TDA5rk=@vger.kernel.org, AJvYcCW4eGeZMNiGBlpNpWpVFCP1bCGr/7ia1zRQnlqxOloGnEauG4e/RKwj/AXLPCUaKdcW44EskpmV@vger.kernel.org
X-Gm-Message-State: AOJu0YxC+wuDWa3BrgQ49QaUTUD1QMBUheHGyejbcd5naolkBVB1yRr4
	ZVdcV2o6zxgmLXJeiiQHxKep4nFUO9rmUvh3o6LwVsxGkjm2SBAg8G4iPwtTMR/WeumLrLOkuD5
	HD6ubOi72gbbf9an52RlA0Ed7JFmBmNk=
X-Google-Smtp-Source: AGHT+IGIRsBXQcJhGYXTCfBt0hyASdXL0BA4uSTH4M8TYpmOofV3kEHcY9bzIp4LWAS/sJggtXMBjS5RSboE3WmTFb0=
X-Received: by 2002:a05:690c:7105:b0:70e:a1e:d9f8 with SMTP id
 00721157ae682-7151719603bmr232677387b3.22.1751355915471; Tue, 01 Jul 2025
 00:45:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9EE5B02BB2EF6895+20250623041104.61044-1-wangyuli@uniontech.com> <20250623131141.332c631c@kernel.org>
In-Reply-To: <20250623131141.332c631c@kernel.org>
From: Chen Linxuan <chenlinxuan@uniontech.com>
Date: Tue, 1 Jul 2025 15:45:03 +0800
X-Gmail-Original-Message-ID: <646DF071C8F96DDF+CAC1kPDMkYdPVy-dG3uv92-JG2Ui8BxRqYt2U86ey7fKuJxBa0w@mail.gmail.com>
X-Gm-Features: Ac12FXxP9blnD2qovvex-KVhW6Thl2N1W_9TSMQWq9dYjFFhQYi3-yHsSL2uUCk
Message-ID: <CAC1kPDMkYdPVy-dG3uv92-JG2Ui8BxRqYt2U86ey7fKuJxBa0w@mail.gmail.com>
Subject: Re: [PATCH] nfp: nfp_alloc_bar: Fix double unlock
To: Jakub Kicinski <kuba@kernel.org>
Cc: WangYuli <wangyuli@uniontech.com>, louis.peens@corigine.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	chenlinxuan@uniontech.com, viro@zeniv.linux.org.uk, oss-drivers@corigine.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	guanwentao@uniontech.com, niecheng1@uniontech.com, 
	Jun Zhan <zhanjun@uniontech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: OKmnvHjth5YqTDiMX2KrAwaocDd+ueHOYWge+FAbUslWQi47ZJ+y5wR3
	cp2VAWxAHw22GuEKH0OxYGNJedUfMlx+d1WuKA/f23OVfGuWFBPsVGCvcGAYf/zSJN1+o02
	xFjfAz2LfYV6gnfljQUxEGLB+wKE5cQCcoYW1qPOSGejhUNSXQisbxAtpF0SN2CR2zSPgQ5
	kICcjrbp5bstgT2vFK5gbgkxdneCRKq98Il8X8n01VExhVZuJVFQnFVt/4tEp5TFPEqok/q
	AcNCWlI8eLg3ZYhGmF1+JxDDAotINI66tcRtfXaKoi5qObDtav95kGJXydot2J57/vRu1uh
	l8TPIDQDZIFr/9Sl7CgflvX+qfpfqVI30orf9yubPcgGWxI8P0aXuWcQfNj12uRHANb1DEv
	uMVCZgia2sCO9T4g44VhWjz73e6RZRfSjl7nopHePH+zq+mJ98EIMrArpxqLlQ9TMCzWZ/k
	sKRzReVn8yYBJMasdTN69wClMFA5IELmW4yW33odlkWkPg/uwAnslaVx69sY+Nv2UJ5AEVz
	PHEVamNiVijkepdBZxEMBd2qcX7ggafQSrtu5+stMxPX/0JBX499zCHaukOyQ5hPZM9s0OD
	4JPxqqZv13KOZErkkrq3t3ExkCrY2p7uMWB8DBylP6APUbaE7/nk8CYZAJ7UAPKswVZTigR
	RINdnSgiV7zknR2li35IJdj491Y8JiIMtWFPXnqaKUERtKJ3S9Qumko5whr9yFnRN39CACf
	yjUuIe5Xid+9MrSwOE3st2nC/Y69ZT5PuuUA+geVq3WuP3WeXxfE4I/9NmdrS+58xkbgo6p
	Q2I6qwbthpbi8wIaBp8KEYvVtacK49qVRxdNzNs365hPzA1+sVflPxGOymkw7i5IkM2YChR
	xzD0pDY2PeQazyo0G/NXdhK8pNNHm+IRezSs5EOS0MeQOsD2x5ACy9L1aEG8TegOKtHDU5S
	PuNWi3m5w3hBMx0vd/sKxrecfCBdqPtpIt7T5IUNWhvlBb/kl4FtzKv/8wPtKOz6K4rZNnx
	IOG63iZhTnpVHrKH8EIFy0VXJgbxTyJTNiMfDuy/QWVLEtDVhFhnPlJXmT5929X4BHUcvK8
	A==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

On Tue, Jun 24, 2025 at 4:12=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 23 Jun 2025 12:11:04 +0800 WangYuli wrote:
> > The lock management in the nfp_alloc_bar function is problematic:
> >
> >  *1. The function acquires the lock at the beginning:
> > spin_lock_irqsave(&nfp->bar_lock, irqflags).
> >
> >   2. When barnum < 0 and in non-blocking mode, the code jumps to
> > the err_nobar label. However, in this non-blocking path, if
> > barnum < 0, the code releases the lock and calls nfp_wait_for_bar.
> >
> >   3. Inside nfp_wait_for_bar, find_unused_bar_and_lock is called,
> > which holds the lock upon success (indicated by the __release
> > annotation). Consequently, when nfp_wait_for_bar returns
> > successfully, the lock is still held.
> >
> >   4. But at the err_nobar label, the code always executes
> > spin_unlock_irqrestore(&nfp->bar_lock, irqflags).
> >
> >   5. The problem arises when nfp_wait_for_bar successfully finds a
> > BAR: the lock is still held, but if a subsequent reconfigure_bar
> > fails, the code will attempt to unlock it again at err_nobar,
> > leading to a double unlock.
>
> I don't understand what you're trying to say.
> If you think your analysis is correct please provide a more exact
> execution path with a code listing.

In nfp_alloc_bar(), if

- find_matching_bar() fails to find a bar
- find_unused_bar_noblock also fails to find a bar
- nonblocking =3D=3D false
- nfp_wait_for_bar returns 0

In this situation, when executing nfp_bar_get(nfp, &nfp->bar[barnum]),
the code does not hold &nfp->bar_lock.
We referred to similar logic in other drivers:
https://elixir.bootlin.com/linux/v6.13/source/sound/usb/line6/driver.c#L565
It seems that a lock should be acquired here again.

> --
> pw-bot: cr
>
>

