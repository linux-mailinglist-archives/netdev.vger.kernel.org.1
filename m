Return-Path: <netdev+bounces-296844-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id S4GWJbVxJ2rywwIAu9opvQ
	(envelope-from <netdev+bounces-296844-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 03:51:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3D165BC0E
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 03:51:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ECSNIKfs;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296844-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296844-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A5BE43014B38
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 01:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2BEA35674F;
	Tue,  9 Jun 2026 01:51:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2356B344D85
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 01:51:42 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780969904; cv=pass; b=CQVeG+WIM4NXcxqDl2Proox3sW7IKWMaDu6efuYKXLphQrCgjZ7EgT2VljUszrURFyywwhGkqzjCgwiMBqzbzlL9hKkQQmSbwwVgDBakA2rkpjmVdURAE7NBXP9Ai/tPJNhKKor+cTBr+4o7dAd3X90YIx+htZkDpJMvjSSNLIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780969904; c=relaxed/simple;
	bh=DG2z+CgAc130z/ZJD+bw8GRE2MAJLCwEuwKNS2woxaw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TFPjqJo65W2pNtQx3YgaAdCP6Fe+k8L02BDARH2fF2tYe+8k4mXGt3/jys9cy/5HulUDs34iUlPGGdGEqaHxJISrxg/3PeHPQH2geXC6ibFUq+j6tOOf7FwJB8S/TF61mAbzzOs3RudFnlTs5uqDefV8XbUjh107tdHcJr3XFNI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ECSNIKfs; arc=pass smtp.client-ip=209.85.218.44
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-beeba001887so651038466b.3
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 18:51:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780969901; cv=none;
        d=google.com; s=arc-20240605;
        b=j6FYRWxgJUCK+ggnp6q368g71Lrmo5bRga3NB3WzzAYZGHubUXB2RlGgnvmS/BteGH
         u4AeKiCj6MYQE03YwmmD4wUQhPFxuqJReN6hmdKdNlLvUIWnxm9/T13icYlC+bKL774U
         xmHTT+zgrTzV72Fmh6JGbk31FwtU3JhO7C4WbobsWHq56CxrJqnQmYqhwtHwnijB79Ek
         Bngkz7TO2RbfjrzA9ImaCG+76CDe1NUiPCfvVi8Glls+pyHmDQMNgsgN/xTwfxRxwaNp
         jP17Yrm0Q6f97+runxZ7RiD8M3iOtfr9o1Q8f/rtNWzV7f0m+ADOVA3jTtJkTS1bQP0O
         U4pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=N52lrZLTm3nuFLbL3LFr8YAsaDWpnwEExzpC9d+xchA=;
        fh=c60WuBMlbelu3SOJsyBDvkET3FuoY3g78BMqvN3C3Q4=;
        b=JmVKkmTWXCr2jMz86jbxrzDzhNRnOqN6fx6XnST7tzDsOTNQcf/llJR8YiXjs5A8r4
         Gcwy0s6K3H9B5zyOyGJAqGHh05E9qjkVU0Lgu6/WxY9eK0YakKHijngOHvS0CdxgPhyV
         1mobgcbpJ8aY2kEb39vd20R8+IQJrho5WfRyqhgdzk6CEC56cCCex139pK4RLBo03/f1
         00ILYT0ekEvGQVsTpjLVHwgunL/7aeIn3rLXcckH2dBFXYtC0/b9LtV1to7ofTtjw5U+
         maAZ3m+w92C1fsHp/+asSJx5ohyXsXT0VF395firTLIdSywzTcS/wlcTFWWK5TVCqCdC
         paWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780969901; x=1781574701; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N52lrZLTm3nuFLbL3LFr8YAsaDWpnwEExzpC9d+xchA=;
        b=ECSNIKfsgS3pHMPrbiHNXg100x8ZR9b6ETIlUMyP94wO+1eSbOYwQPS5TIy9AyIhH6
         HJGKLQmZkizRl6CH5+zazP4QTe92+jayuRCfpYrH4u8ruAE868fv50phd/s0K8VMA1JE
         zvTVFa8lF0yMtlpAhFZFZ+awWCqnQhmK/sbIZhlO9Um1uA4XjQ8GOWZW8zdpIuYhbLT0
         bOOqWqnDi1D1RamQCQgcV1CYkvEmfnxG4vd7KsuJzW7VTWpbyae5E6nalXYF9iUcG+cn
         CpobLWGLr8wm9O7upBx1yLasekm9KSUqEeYXyFmsnXySU0YdlY5it6isG7u/LGyPLrTl
         SDkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780969901; x=1781574701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N52lrZLTm3nuFLbL3LFr8YAsaDWpnwEExzpC9d+xchA=;
        b=Qo/IVN+oKEj6CWL6T9qUjBK7GUCZopdjC38lqUHnfn3vI0nPN58vQCKUQkjnGIxxRI
         z7PagrGNpMLf6P8vqzRaftwq0MMyROAxBjjKlWbPiE9uuUvLjNzRI3yL+/uNG2vTa+qx
         gVogfvub2pqrgPCoZ/15NdhARZhll2TH4X5CJVMvBxW6tYG6s+/WamZSbbUEmqT0lmbs
         PNIGaUgAMKQHGhiLfO0bDjw2QbFQ72bhsPflSxphIsZ4gqee0AUywzqTVttCv9BMWsnM
         uFCfZlqGt4+UCVNX0+Iikoz/pN6aHwipYSzJSThVOnxDW9AP9jePkdvKbdkEFBvU0WN2
         PclA==
X-Forwarded-Encrypted: i=1; AFNElJ9JqLgAXISzLNlUSB6+fmHMAkuXHKKNhDadsowhPCv5rm5cf1hvkS0suNyPeJba+2dtgvh7/7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4MGA4VL/EEi4GCH5hc8UYrK5i/4TgfUBWsJ57E4tEqvVmR5V1
	PcGhbtYwVjSuDeEjClLLKKpd4Fo+sP+oGe+XtwknkueD1wJrmBxNaDTBpH+kIyQg9w0ttHrEOXb
	kWZGG8+Az40TCnEErhPAtRjfeCuJitCQ=
X-Gm-Gg: Acq92OE7dQjJB0vxf0IhA3DBB4nNINgJmEL1+EIhvYZG7xTLSbTcuQFrDF4kaR580PF
	QZ/741CvExRdzT4JynS1Yb4p6hBjgXHa0p5FWDGoG/etTrZOJVGSpCIamoWnW1Mn8hkxuqhVjVH
	aFhG4Y64do4Cjp1yFx+WzF/fAd/QSalsktzaPHeoencc0Qeblzo1mJqdId2bDRgzwNc356E3xM2
	SoXdz1u9Qu7ybhb8KoBjuhiAzExAvYZbvSieKlMAYNgszmRuUoUJ0wdTntEpZ/9XfDBw3XwasDO
	esVRHaySLaKNK3zYHsvwViW5GBonVqvl8e50zcx1l+F3tmp8iy0EoWCk1DX43zjow1ljhklumE9
	drsRBN7qIaLGPxS0VvscbtCuz0QQfqF6DDm3x8dB3Tu+8EYbvMgto7+YN9kP9Mxmj/KCp
X-Received: by 2002:a17:907:d109:b0:bf0:2253:ad67 with SMTP id
 a640c23a62f3a-bf374ef2099mr867628766b.46.1780969901149; Mon, 08 Jun 2026
 18:51:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603230821.5619-1-rosenp@gmail.com> <f49d5ac6-ef78-4530-a420-d94e612581aa@intel.com>
 <CAKxU2N8oh03r2-zJhbOXF0Qqx7RzNSX=zq+i6Ld1c9YXJqDfKQ@mail.gmail.com>
 <20260608173638.74da73fe@kernel.org> <4575ae96-2084-4f96-8260-5025fd1ea7f5@intel.com>
In-Reply-To: <4575ae96-2084-4f96-8260-5025fd1ea7f5@intel.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Mon, 8 Jun 2026 18:51:29 -0700
X-Gm-Features: AVVi8CdIZ-VV7zgNUMszBz4WnqYrikHiriszP6sSYWl7cLh7UqP_AwFh6wXUgP8
Message-ID: <CAKxU2N-0RnWV_BxQMX=ofcoH947L3icyKqReO7rf_4Q8tO2CSA@mail.gmail.com>
Subject: Re: [PATCH net] net: ibm: emac: mal: fix potential system hang in mal_remove()
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jeff Garzik <jeff@garzik.org>, 
	Roland Dreier <rdreier@cisco.com>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296844-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jacob.e.keller@intel.com,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:jeff@garzik.org,m:rdreier@cisco.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8C3D165BC0E

On Mon, Jun 8, 2026 at 6:14=E2=80=AFPM Jacob Keller <jacob.e.keller@intel.c=
om> wrote:
>
> On 6/8/2026 5:36 PM, Jakub Kicinski wrote:
> > On Thu, 4 Jun 2026 16:03:43 -0700 Rosen Penev wrote:
> >>>> -     if (!list_empty(&mal->list))
> >>>> +     if (!list_empty(&mal->list)) {
> >>>> +             napi_disable(&mal->napi);
> >>>>               /* This is *very* bad */
> >>>>               WARN(1, KERN_EMERG
> >>>>                      "mal%d: commac list is not empty on remove!\n",
> >>>>                      mal->index);
> >>>
> >>> This one doesn't make sense to me. The list_empty check does a WARN()
> >>> indicating that this is not supposed to happen.
> >>>
> >>> This implies that list_empty should be true, otherwise we'd see a WAR=
N
> >>> every time mal_remove is called.
> >>>
> >>> But in that case, we'd have been calling napi_disable incorrectly in
> >>> most cases where it was previously unsafe according to your claim.
> >>>
> >>> At best, this list_empty check is the wrong way to tell if the napi i=
s
> >>> disabled, at worst, this whole change is pointless.
> >> I asked the AI. It doesn't agree:
> >
> > FTR I agree with Jake, the patch seems to indicate bigger structural
> > issues. Then again I don't want to encourage the stream of patches
> > to this driver so let me just apply this..
>
> I don't see how applying this discourages the stream of patches?
> Wouldn't that be encouraging?
>
> Or I guess the patch "does" fix something (an extra call to
> napi_disable) and you don't want to encourage a raff of future changes
> to try and fix the overall structural issues? I guess that makes sense.
>
> I still don't follow how this fixes
I don't either. But runtime testing shows it to be an improvement.

Anyway, it seems various subsystem maintainers want me to fix
pre-existing issues reported by sashiko.

I also got this feedback previously:
https://lore.kernel.org/netdev/20260107185605.7932173f@kernel.org/

