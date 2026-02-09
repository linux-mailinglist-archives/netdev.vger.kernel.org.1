Return-Path: <netdev+bounces-257967-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IGkbGv8dimljHQAAu9opvQ
	(envelope-from <netdev+bounces-257967-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 18:48:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AE64311335B
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 18:48:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 809783013EE2
	for <lists+netdev@lfdr.de>; Mon,  9 Feb 2026 17:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B2A2FD1C1;
	Mon,  9 Feb 2026 17:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=u-northwestern-edu.20230601.gappssmtp.com header.i=@u-northwestern-edu.20230601.gappssmtp.com header.b="NUsjFmO/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9D02D9780
	for <netdev@vger.kernel.org>; Mon,  9 Feb 2026 17:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770659324; cv=pass; b=oK1cFaA92gNNkqE2I7TwtHiMcL5mW/TdTmOnrFTVQnuZozLI6FBp0IWQAVL5G9F/M/2xWkQyhrRertUXdKjkhG+bSwqVG3bfyT2Cn9Dk/famfYdM1eePK1ErgP93HDpWlzz5+gQLOc2R06TmGSruyNfBvNjFU8+bALm5GzeLm1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770659324; c=relaxed/simple;
	bh=g0HZbw2/H8FR47tfpPFL+qeV0wCatbkCangR7IZxcHg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rrTL0IE8n0dYqEXkFT5xC/j+nf2arAgCTAH4XSjy15nwK4s33Zomv8wRzJ0vLlbwHV8z5t0yMh5DnMC3CyLxZe2rMi7FSaisQELeHbgoM3iTJv9u1i9vnukmB6BVFjwQ1Zu6vZEeMLO0mkNEJo4DjlfnSrgWMuXhlAyiFCDUQD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u.northwestern.edu; spf=pass smtp.mailfrom=u.northwestern.edu; dkim=pass (2048-bit key) header.d=u-northwestern-edu.20230601.gappssmtp.com header.i=@u-northwestern-edu.20230601.gappssmtp.com header.b=NUsjFmO/; arc=pass smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u.northwestern.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=u.northwestern.edu
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7cfdf0c8908so2741368a34.0
        for <netdev@vger.kernel.org>; Mon, 09 Feb 2026 09:48:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770659323; cv=none;
        d=google.com; s=arc-20240605;
        b=WQwffyiy+4Y9oIVbaTcL/UlbLlYc1/Vlvt8TEPVDLOJ1ymaWyvJeYYxb3ZoAbyUCF5
         qq1ne9npZCKnUED0WyRuH0qlDfBpCXS8lR9tbhm9IZjy24zxXKyfuHwSYgfShq7w6ad1
         dKYgCH2DiVj0n5hlSyQj8xnAvQGk+rgZApljxlo5aftTkvdIpyQu/i/Qf1mdzEIXgN4c
         DMqQDMtVFg2268sFenR/xnoM/37DTaFTWG/pLcHEVeZi/Q1zkqjNDnVTWw9H3VmxRhl8
         eyGmx89Em8Vzgqqw0Uj0mBk3/wm/mFDFFljHzsxr3b1v2WShViKZJtSYCbWasGhTEtBY
         1ydg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LHYo9+17/jdy/rTmLrbaDBuIFiHrvbUePiuYWeSHyxE=;
        fh=ExcuDk2+01a+JQI11zkwExUjdCOMhuTcyY+5VmY7DU8=;
        b=WfB4DNAPKkXtMD+p1oWvUZAlL+G7Vq31YAZ2yTlGvpTvYvRHds4WWIVJLGf3mlT6zP
         N7Ma2ibWgdljy2SjHXxbSUTal/v7CKi/6O9aM/CIV0iMnjS9IIVAT6pHMhYZCGExWWjG
         2hcv4rxy6dLlCVdjobQb0mkwcJ/RBrAQhM9rBfLP7R9WVxg0S/7nBtLX6e0RuAKadlVl
         Sd6rqruq7raUSyqK4SMBYpgjpfFtK4f/xoSMtohZLUt4XrCLJHpYkDXxYQ8/hCCWsKW3
         CtdJZCC33TTYT2rW5oDVEyW/2QBiHsmUTBDnMiMgQ+Mbay0C9NarWUCSK2u7s3EAmE3x
         o0Eg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=u-northwestern-edu.20230601.gappssmtp.com; s=20230601; t=1770659323; x=1771264123; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LHYo9+17/jdy/rTmLrbaDBuIFiHrvbUePiuYWeSHyxE=;
        b=NUsjFmO/oTK4qwz8MT4fL1kk46CZpO/Fny+x4M77xWmpgVfRoBColNX1m/piztLuMz
         FAxF95WRCQ6puTUo5CHJRzaFydaG0OzA8CPTpvwCLsX+ouvu1uoxuVD4RBcVwl5kZQQu
         xLT1oET8vtdbjgpzeznYRb0CVUxeBbsKk9VASntVKbfq2XUwOhTKs93a4ZWD8V7REX/s
         u9ScdqzoM+mbtiXs2/W7rbTe3urIN/JoxjnQIUYPrxyMk4EnOAKH2fZET9w1+3LKBDgK
         64Z35Lh2vUk7iupH3gC5X4jmUvX6AE+5SUV7J9midgBL0KritfFeIqgASaV9g5bdfRyC
         4tCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770659323; x=1771264123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LHYo9+17/jdy/rTmLrbaDBuIFiHrvbUePiuYWeSHyxE=;
        b=MIAIYb+7Li+blNxz1Uq9KDrelyq1k/SNzQTb/OB9qWez4KmbFmzQgPheh5eTnWjjuf
         b5r4CkfXRcgafLnCfqjtGrOppgDout6ZYldVDCD7gVCNahvN6v3NuxtQx1B5OTw6jV2i
         jeuo/wKnQH1D0pS5jz5TuOHYi4EFA9yRyAVIKNVKNoPKwMo9NX+4cExFe2gLSSa0JQtW
         sJ8qb3GtNIi3uZnV4Jsh8442Wp6+K0uGMUGHfKrB0XJOySUR9RbtumrKoDlNZU+7W2JS
         ho34gTAQnWIg/PANfcHp4fZvX2WvME6/6D1FxTyH1E4BcheiEmFukeHdckPkvAeD83PO
         1/ng==
X-Forwarded-Encrypted: i=1; AJvYcCXDDu4TAaRW0JHwch1dus+pweDwLi8b5uqv+TJmqSEbm/QOo8m2k8w9rykQXCEDmyozPfkAkOo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf+xtlvB9Zq/TOT8vGW1jl/ZIxf+N+Qol5ViZmo/8rmdaA7RZU
	m85dygiOsq85SEkrXKm8ZtBVggjrL3DQmz8+EdQy0Lu7WCYDVqwaoHP9Z4Vw+Jkq1WGNmDzpqDA
	8HvVxArQoinZN1M6CMaFUPR8db3ZFIxuyU2LPHh2QOg==
X-Gm-Gg: AZuq6aIGCrcoiNJUw0hpb2sESmhoBgJGywYebQUmfCw7ZSUYJ2pTVwXob6AS4S7deDI
	dgjaIG2ovtz/YUjRi4biGKGbHVL1VIP/Wjd5lmfEoMwacmypRGt+XuvoiW9EM9grVhkR4pLyQ61
	tKJHGh8o7+VdnTBg+xP6FSFFzDQPSYJLyPscJsWN6B/oUD3IlX6Gp+4iF16lokjnUdWaJsYMJiA
	FPVZA+uWcKHQYt9b0TP4TlYmIqF9LfLBVyiMv7NaeOfZwRG/0dvWugcdrQpfH5oE4nGZXqV6o9v
	HJQlgdMvGbVdAszjUvD8Kf5TkaZlnIA5qHYKouSOWcc/wuK+C0NHqXQJZ44=
X-Received: by 2002:a05:6830:81d6:b0:7cf:d1e2:d386 with SMTP id
 46e09a7af769-7d4646ade26mr7579234a34.33.1770659323048; Mon, 09 Feb 2026
 09:48:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260209053013.1701134-1-n7l8m4@u.northwestern.edu> <d697a88f-dd8c-4ec1-ae4d-c97578a98498@lunn.ch>
In-Reply-To: <d697a88f-dd8c-4ec1-ae4d-c97578a98498@lunn.ch>
From: Ziyi Guo <n7l8m4@u.northwestern.edu>
Date: Mon, 9 Feb 2026 11:48:32 -0600
X-Gm-Features: AZwV_QjvH53WnJ9lJUe27OVtS-KqGcnJKAmovZNjB9GgwAFFxmwcMkg5R37bZeA
Message-ID: <CAMFT1=bFkHFsh-3U+Ca7Dey1mzPdz0rpQweCLmXFrattwZ_uMw@mail.gmail.com>
Subject: Re: [PATCH] net: usb: kaweth: remove TX queue manipulation in kaweth_set_rx_mode
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[u-northwestern-edu.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[northwestern.edu : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257967-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[n7l8m4@u.northwestern.edu,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[u-northwestern-edu.20230601.gappssmtp.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,u-northwestern-edu.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: AE64311335B
X-Rspamd-Action: no action

On Mon, Feb 9, 2026 at 7:56=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> I think there needs to be a better explanation why it is safe to
> remove these stop and wake queue operations. r8152 does the same. Is
> it also broken? Rather than removing these, should we actually be
> waiting for the completion of the urb?
>
>         Andrew

Hi Andrew,

Thank you for your time and email, here is my understanding (correct
me if I'm wrong).

I think ndo_set_rx_mode runs in atomic context with a spinlock held,
if we wait for the completion, this would sleep under a spinlock.

And it seems the architecture of r8152 is different from kaweth and
rtl8150. In r8152, the ndo_set_rx_mode callback (rtl8152_set_rx_mode)
won't directly call netif_stop_queue/netif_wake_queue. It only sets a
flag and schedules delayed work.
The function that does call netif_stop_queue/netif_wake_queue is
_rtl8152_set_rx_mode(), which runs from the work handler
rtl_work_func_t() under tp->control mutex, not from the ndo callback
under netif_addr_lock_bh.
Also, r8152's start_xmit never submits URBs directly. It only queues
SKBs to a software queue. Actual URB submission happens in a separate
tasklet using a pool of 4 independent TX aggregation buffers, each
with its own URB.

So even if netif_wake_queue() triggers start_xmit, it just adds an SKB
to the software queue, no URB is touched, and no double-submission can
occur.

In kaweth and rtl8150, start_xmit calls usb_submit_urb() directly on a
single shared tx_urb, so the netif_wake_queue() from the ndo callback
causes the stack to call start_xmit while that URB is still in-flight.

