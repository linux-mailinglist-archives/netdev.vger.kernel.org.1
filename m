Return-Path: <netdev+bounces-249891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC0A9D2040E
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 17:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5748F30039F6
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 16:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676DB3A4AC4;
	Wed, 14 Jan 2026 16:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="TdlnJSQa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9C33A35B6
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 16:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768408832; cv=none; b=B+P+2F1eSVnj32a2YxTMIAtrzgNOmzOTvzaFm0PVkW4+kxu2CNhONRy3D+peXOarQINDGDKR37f3atO5t5yR1t5AHZIINQ+WeKzKB5eYoYWEnBDwvW/vIlQCcilSGHeN3r0wmYBiOMRCoj9MGzY90zIPnhqM7W3h3H2kWeGVP4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768408832; c=relaxed/simple;
	bh=s/fD5xvGs2utvhqODnMb/L+upL6xmROHs/yMeG5HRGg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IJbRNHEWYqBLKQDI49KM12aoRNEBo1ZP5OidPH6Ki+PMCLfW6lU2BA6+rXu0B0/0MHCCm0CKgXrclrQ+euLLAPD1QM+p2pAFHm60i7ibFaW9nms44N7PxAZtNPJZuigMQ8S5vipftqLO0g09CmA1NlF+Bb4BtX74ycten1BagFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=TdlnJSQa; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c46d68f2b4eso19489a12.2
        for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 08:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1768408830; x=1769013630; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s/fD5xvGs2utvhqODnMb/L+upL6xmROHs/yMeG5HRGg=;
        b=TdlnJSQaZjFuHx6q9SlZFnsROeRujZK98HANzkvdlfS79zBGXPBx3bOLt9U5kB/sos
         ssk0CRqHyYuVrk0xRwPO6I3F5vQ7nM8DqXhlZgboI8eylzJzS5EAhTptGwCFLJU3FiIH
         CuUuq5AAtsYaSBvAgeFePm70hpXIbOdkdahArAgt/m9sEOaEUUVnlAjGw5yu4e5/36nC
         vjvPz8qPIih9Sbg3W5oH08U58PPjmcM/THsDyWhwfoU+cu56h+o39tdgdZwtGee4CfE/
         VavPTIG2p08tSi3YLueVB9cpzTtv4Ll8wdL3cXWENJRGDlBJQTcwrf+qMzqD+8GtAQrO
         EUfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768408830; x=1769013630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s/fD5xvGs2utvhqODnMb/L+upL6xmROHs/yMeG5HRGg=;
        b=Il89r+uoZY/zl4K8qQEDtYObcOLBMrmSim1tNCwLlHXVFJGdCRoLD3IqHLvoe/P5Fj
         q5c8n3Z8ZRogoBHx+skRnBMSNEATCl9v7vltZv1frdGbhXIv9fgZZ6FPYVj2IVZBa3j1
         aGlXQ4J6wIaUMj0nsBSe67abMXxWfn3MUBgQPqSlg/vuqzp93mBfv4kln2yNdZz0SZZy
         MNSBdlEJrndSxXfpuWYFdQTn+gW88A1nFkNhXv1VKguK3/K05cFy2MpMi0eRReU6FZ3J
         CqfqDoSbr0n8ehVAe6WjOhOyIqiH1spOSTWa2DE4dv+I/05LpIMxP8C2oWPJapEuFUGw
         6Fdw==
X-Forwarded-Encrypted: i=1; AJvYcCWoomEuG55MjKGl8fvoSozk9jejYU6jz1pRYvGm203yr+K2JStttrL9k3jIXBi8BEKfYEYXjUM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzvsJbeFTC4WpEPQLlLCQdezdXm3ljLa18c6JGRij+32vOdXad
	YX4yRFNcxiazPZSvWgAvrbjghG3KPcznRW/A8OUctGqM4koScSvSaJpRowWFy9ucBmldS36zefN
	gx0Ei3Y1BKzCCuyWRzuxa5g4eyvRkqnM4dA7XWv/m
X-Gm-Gg: AY/fxX5pBL9rqpQs8cdYixCXdiafltkete3L4v5n4/DXCn9F1mziJbclcdpwYHfavpp
	KanP32ZzmvjWf8Xd8pnoqPuCQVmj/Ox5psM+wjStvqsen7URuGEsB1oGnJhjLj3yV9uRl/VBaw9
	LD9Yh57NslHu6AtKQGN9/iQpLHSomGsF7SIPzKNaY3MNCLW5iaNcwF0HtissXUEmLOFGEuQlu7e
	PerPhuboUIm+tDMIjjl1/X8lpOoJhHXuZTVFtF2Okq4KgY9mi7O1uNWV5OgJmud5hIykIBDQHYz
	XxY=
X-Received: by 2002:a05:6a20:e290:b0:38b:de3d:d52c with SMTP id
 adf61e73a8af0-38befa93994mr2928287637.3.1768408830348; Wed, 14 Jan 2026
 08:40:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260111163947.811248-1-jhs@mojatatu.com> <20260113180720.08bbf8e1@kernel.org>
In-Reply-To: <20260113180720.08bbf8e1@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 14 Jan 2026 11:40:18 -0500
X-Gm-Features: AZwV_QhQpZ25u2X2LNZn5BpYx8rrhPXxGdKMryc_JQfQo8v_CapUiIOJGhkcc6c
Message-ID: <CAM0EoMmZA_1R8fJ=60z_dvABpW3-f0-5WhYzpn1B1uY9BA4x4A@mail.gmail.com>
Subject: Re: [PATCH net 0/6] net/sched: Fix packet loops in mirred and netem
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	horms@kernel.org, andrew+netdev@lunn.ch, netdev@vger.kernel.org, 
	xiyou.wangcong@gmail.com, jiri@resnulli.us, victor@mojatatu.com, 
	dcaratti@redhat.com, lariel@nvidia.com, daniel@iogearbox.net, 
	pablo@netfilter.org, kadlec@netfilter.org, fw@strlen.de, phil@nwl.cc, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2026 at 9:07=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Sun, 11 Jan 2026 11:39:41 -0500 Jamal Hadi Salim wrote:
> > We introduce a 2-bit global skb->ttl counter.Patch #1 describes how we =
puti
> > together those bits. Patches #2 and patch #5 use these bits.
> > I added Fixes tags to patch #1 in case it is useful for backporting.
> > Patch #3 and #4 revert William's earlier netem commits. Patch #6 introd=
uces
> > tdc test cases.
>
> TC is not the only way one can loop packets in the kernel forever.
> Are we now supposed to find and prevent them all?

These two are trivial to reproduce with simple configs. They consume
both CPU and memory resources.
I am not aware of other forever packet loops - but if you are we can
look into them.

cheers,
jamal

