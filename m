Return-Path: <netdev+bounces-276880-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFMeDANf12kCNAgAu9opvQ
	(envelope-from <netdev+bounces-276880-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 10:10:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C39D3C789B
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 10:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 408813016819
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 08:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460C638F92D;
	Thu,  9 Apr 2026 08:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eb5pMRTC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020B6387348
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 08:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775722239; cv=pass; b=Q4G+QsE6yzgXEAzeWQmvnYEdeiL266DHAMTDbf88lN/CHqn85BS7vHmLc2hGKT0Wgq/IOES/pCXxIdRmniQafQFiYOTQ7Ge+CHjXtaibKUyxPBxPuTbC7Y59OouJxc5no93sapnJkk+4dDWZjPlBga4VJHhPCyxKCsU4aHByOSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775722239; c=relaxed/simple;
	bh=v9QIYML/zg/aOAPCJtSeT5qfEgNWsyXfyw1uy75N0TI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jj68NDeXXFRXEkPbxauT9b1csnjOn5zniYNF317EKyUpMhqXJk+p7Z4CXJ93xGQT8/NisWNCtuyZyaGEzd//sM+tYhcbUaEyHGfphgoCi2UukEcTdasPrCoE9lBFTTeYzjlrIcnDT4YW5U8Fn71V8ibeeouFFOi+kNbAe+Qrb4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eb5pMRTC; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-50b3488fb31so6849801cf.1
        for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 01:10:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775722237; cv=none;
        d=google.com; s=arc-20240605;
        b=Qwwk69+NYXIIqe5iY26/pSWALkLrVPE3fv8V4uvMeLX3NdNDMAexaKD6g/oxXPRSv1
         wKThbNxfaeLN/StLYmTNgjzgRhYfO85/aAp64H8kK46UdpA5zAnjYKRZ2DvmifZ3Dq6d
         NQqWxPeMykAxswwtNNpcUHnsGmy+jPlrJYuH2p0yJITSd8oIVHD2fXY/H7TIogYlNqRH
         25lgDYRlAb4EV9KU0DakpBtp/F1yKv1udJAFpndkkYKzp/RjOZL+XlSoKblpQAjWl/WH
         F7CKl+uz3l1EFUQqjDICw3qvdSx4v6Dug9cRSrLA+tPasuPcC+MPAs1Q++Wn8HFOiOHB
         QTUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=v9QIYML/zg/aOAPCJtSeT5qfEgNWsyXfyw1uy75N0TI=;
        fh=R19Ya4Es2bFXigoknl1CDkvp90z982EEgHFT/zk2zX8=;
        b=lwVZJhtjXoAp6xIKam2HXSFh2c9gU8MXKL8i8+5LAl5KZkyUlXtvmc6z6xdZckfmmV
         syPuRHYPWmuxClT+43MXc1l6wjtUmtWJji4kKdkfcDTr27e2fI9mJITl18G6v3LAz4E9
         9kJ2X9R8RMNb3hHgS39KbG4K/4JXS4BE+S+fFay/gkMJHqi7mUuhw9ZD60hyamgH1WKq
         DGrmDR9IxQmQr/MjIicWAE1dSMi3/Ze7eUWhaZwwX5TVRpfQXrdMi5Y4lDKs0BdLHI4p
         jPpCXCmUvT5ofQDFhoMP1f+uPDBkW+cxky5I+S4Ku2928VaSWM3mJaOcW9CHxZi28Caq
         OacA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775722237; x=1776327037; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v9QIYML/zg/aOAPCJtSeT5qfEgNWsyXfyw1uy75N0TI=;
        b=eb5pMRTCWIuHx6ywsek6jR7tQmr0dRqwSB7HVL64tHQyjVdZ1+d928sNTwzCKIdRO3
         uJ1WEU6Uqv1DiAl/sYotxPc8rHLeQR0GER2iVEQ2mE2jJenZcgVCXREk6I3abH0/142C
         dFIerat2eZTrHwZZAyhoDa9hvoObtWFdETtGjy1vrxuzfP/7zeoL8Tbm9U7VOHF21aAZ
         Hxlb50WQe0nQn7aGJSXVxyGbt/ggmXelwHXN5lRxQQjUesNVP15RM4XsNuqjAYACqP7v
         1L8OayphR1lJ+wgi9tizaJY5kdwQjZR/Nbp5GBYAi5cvDU3zPX5zRBJUI3h6tWhs5Zvd
         qFwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775722237; x=1776327037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v9QIYML/zg/aOAPCJtSeT5qfEgNWsyXfyw1uy75N0TI=;
        b=UOMow9TS720kYSPkuCgEuzcYgae55mPj+C/RGJxBK4ufvP33yu4wfMS8ZyarHoQ8eP
         q7TYFfQv51pVYVGw4kJG+AhjwPOMSL8/0FqE25VSzA/bn8d8S0bnmi+kVf0lFse+BTgI
         4ahzs5CNggdfrvfRATBQPR6MlYRkOdDFkREyb6uWg9hIq4eOr5NHTIevXsZzS08gtMXN
         7ATtV1fEL9A2v8LIW2NKmPmUA7QaviuBvFw2aKAujn6AjiQBWw0ltikE8m6TYUK8YquN
         NDCThGbTgxT0haUUXnFwzuhthipPDLZmxWMeCct51TQdzVYg02EdUOF8nk0nefGSKXoa
         HJBQ==
X-Gm-Message-State: AOJu0YypCcTzesXlj48bjyK457q30rB1P0XUWY03OosaXzAuc+7z6AjG
	7yQS0OVo3h0EFWnx+p8D5uB1/pIvNA99HuI9P+Yd5GCRrJnEgMR5zp6ViJy5TcIIJvlPQOg57Kf
	ICI/p3dD8W9ZghIN/xmW/Rfgb+apOGhVG1ZA0TZ88
X-Gm-Gg: AeBDiesXdddWMW4ktFYOc7n+UGAVPK7eHA8yK3XxHxnXayEomKQYA4cI8ZNEVJ7XF0l
	l1iqQ0hCyzPVrVgGPH48KeAXqD6MSpCo7mD7MoWq9saOZVxs46WEt6rFeE6fUqXfJ11aYarvkEz
	HyiIlr/G7wSKYixdRSwk3W52c26kRDjKvirvJYPwU+T5G2tUO+Nm2fRVAWMKUakph6e8Ce8gwsx
	V/PqLUvYHSwJCkAinDAzWBzHULkSnD6EAeKKoah2XdCU9W/BpQkPIWrF5QPteubBT7jCaeuTtpU
	2zBTVmyARsGikxh/0Q==
X-Received: by 2002:a05:622a:1b15:b0:50b:2542:e16f with SMTP id
 d75a77b69052e-50dc1a45100mr30831291cf.15.1775722236548; Thu, 09 Apr 2026
 01:10:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260409035344.214279-1-jiayuan.chen@linux.dev>
 <CANn89iLEpVVo=q4FPpBQ5FomoLmdrfW3su7Mb0ZES4EV9=Q4xA@mail.gmail.com> <8c761de0-4d8c-4b2e-89a6-80f12016fd78@linux.dev>
In-Reply-To: <8c761de0-4d8c-4b2e-89a6-80f12016fd78@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 9 Apr 2026 01:10:25 -0700
X-Gm-Features: AQROBzCBtDoZDHyHWUXGSZbLoakt6E4qIMNHHWibRdm3YQM3Mv3ItHOQNXPah5g
Message-ID: <CANn89iL5=jdmPayGiri1O2P9CYANcq=mNF4QE1-4eSmMquZb4g@mail.gmail.com>
Subject: Re: [PATCH net] net: fix __this_cpu_add() in preemptible code in dev_xmit_recursion_inc/dec
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Weiming Shi <bestswngs@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276880-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,kernel.org,redhat.com,lunn.ch,linutronix.de,goodmis.org,gmail.com,lists.linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 8C39D3C789B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 9, 2026 at 12:50=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.de=
v> wrote:

> Thanks
>
> I checked all callers of dev_xmit_recursion_inc(). Most are fine.
>
> The only problematic ones are iptunnel_xmit() and ip6tunnel_xmit(),
>
> I think adding guard(migrate)() at the top of both functions is enough

Seems fine to me, thanks.

