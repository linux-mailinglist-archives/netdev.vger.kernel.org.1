Return-Path: <netdev+bounces-304362-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iL4KOvtVR2q8WQAAu9opvQ
	(envelope-from <netdev+bounces-304362-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 08:26:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E88716FF10A
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 08:26:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=JhIJJE4+;
	dmarc=pass (policy=reject) header.from=google.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304362-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304362-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 00A7D30074E4
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 06:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD9837F8CA;
	Fri,  3 Jul 2026 06:25:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491D537B400
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 06:25:55 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783059956; cv=pass; b=ARqbLABnTus2CiC9T6hTgW8FqyStm4w9hbnCHYtdyivnKhFNVZq7fNtNjXUkNyOBRIe9tnwl/yHrXNx7F10IqZcxDdFe7jw+jHxWKedTUpbdfn2tvxud/3DKzR4DA7gCvOh+FCHkoj4rZkD142+b372blmc59sM7WaykwUq28LU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783059956; c=relaxed/simple;
	bh=gu23m3G9I8LRrXwsMirKiBM83umbvVFeycfI4F8fQoU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ORWHGPW8NEDaW/4lSLBLxWqRnxwLPkZummROJTRy4erJPYitLZEYrgzs0myYItI9/4y/3j6TA1j43X1M9aOpUHOoVxvcsI9j9mNS8eZOgaZUe0Z2Qx4lchsfOplVLrdpAxwifh9J3mywIBodkg2I3eRyvTnFQ9dFJ9M0wnMELt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JhIJJE4+; arc=pass smtp.client-ip=209.85.215.181
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c9672e02e05so129586a12.3
        for <netdev@vger.kernel.org>; Thu, 02 Jul 2026 23:25:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783059954; cv=none;
        d=google.com; s=arc-20260327;
        b=ai1lPEW02G0fpJ6OuTpm8RjtIT/LlB0wt6F2m5KYKe/GYWDt//bjOJHuXwXLyZQVmo
         yU7LGaJqsvvKarpcTBKC4hl4bzn//mo09kkKQqB63ysfbweZDxTNrSOzUPosGE8VKqBH
         WkLFrnTLSOmuc456bceLz3EGEd1v2HzjHZkZz3OPTw+gjsh5uCcYKFBUIc3sCk2Y8e3A
         fPXN0wjn3KxhlviojM3+bd5iNmnYVw/rX+pDHP5h+46prhfkR2MeDaJfkIxzx4wiGNmH
         ZFca227jgLTF7Xpun79XIgBHaxd7XuW5vG6Qbp0eqlRJBRimb+vuaelFduDkP8uyYfuY
         Ylqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BSF6P/7OY1gFGFz/Cqzg8XWTkIoYPCEYs2S/9aAkdwU=;
        fh=NtdMffIPji6pGWrYl623L3Ar2063xHA4jw0/3+YwMPU=;
        b=kiwEGUm2Qq2g74h8tEQiZsExTL9ZU9HZH7IdACL34kxtsIj4LTmu79jtIzInNFP8he
         p9TIMl7EKdTlh6BwhHbpVRB5oakyB6es/Tm2j7d91J7mMDKCcKN2qNhS+ygAU3n69kBw
         kMKCm9I9Fz1XHAUjr6Aby/CMcXATDs8UzpG59yd76THgKorltVtHnfHu5WvmHUMh3IxK
         AjBrgKHc/Ea3d7ZDbkf2+YlSnXR8KPvKZrpI4qOeCOCzqP05Wu3MK4yeDgYO1cxse6dH
         t2PUh1aUuNjjOt11amOzgpSWDAbe1Z1iaHetapq1Ty/ggLRtaC2VLa80YFcb4wOyWG0g
         LvAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783059954; x=1783664754; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BSF6P/7OY1gFGFz/Cqzg8XWTkIoYPCEYs2S/9aAkdwU=;
        b=JhIJJE4+piKTJlV1hwDPUJjKLc8Nc/naNjthHuU6EFI//+HZhV5TMHPFTRqBoSGwiR
         wiW8G23vJAPyMGcJ1afE44N+gGgCGMZ64Co1wqMlFEAOk1Jf4qTJWnoS5fPOR0I/qnbH
         mtKvv6vpW3GTpUr2spOf/r6HsxwvJjRbrI2ecIZvzHADhDwRtvnkuWBnCp693PaX680C
         a+kS7/f3wky5yzLXk97NhJId/2zcu3nymNS4iThd534jnxdeHdHmUFbCLLG51aeiDnzn
         SP0odUvTPQ8MFqvossZmLSpn4NAOQFQmnhDCxlbbFLwhTKxDZrDA+uRJgp3cWzrgGfl/
         r5sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783059954; x=1783664754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BSF6P/7OY1gFGFz/Cqzg8XWTkIoYPCEYs2S/9aAkdwU=;
        b=jEPAsKJRc9WrmYRnKrakiQ4wusZT+qvg6wP2kS9FoFhiniqBaqhIk43SwMPy9TEp3E
         UEp7J4aJFjAk6T632YuKbIRIOSERbcnORZv6LcjZmCiJsyqAFLWGdp7oLyDPEdJ0cxCD
         Ysn45uc9AtZbnaRhs+APQVPv6Y+DxZlxgMBElscg4jC4KfCb6Dgzfbe0AcCEiUpgN1NH
         frp6Slm/p69csHRiaKfCkE8r1srnOFP0wFOtUDhA4zP4qjIsxetbfG1lTafz4TU7y8Tn
         hbIdcz07lYk+WP3TL/syDvNrY0xxSv2n/6NAy2y0EW3PwuhJfYCiiPNdUY3pLEEDz7xD
         KiRQ==
X-Forwarded-Encrypted: i=1; AFNElJ+NNMpnxeBPSYAbqqpXgSs+cHZa1urgT8X2ootHszL9+HQOfBYeq+erYyiTp4+mX5wB/H9S4qA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUSOwrTbtSRTyMzjboXn5c5MGwuqWtt9tRNFraG6fA27IiM5xI
	u2plvbu4T3MrglFLfG65odtgLAUB7vJ07tt9f19dZDdZv7SbTAJm/6q9uuCHwXOHT1x8xw5d5Jp
	aK4UwhTtxCb1HymXEaKvhMSkYHkng2uyhiGTTnv4y
X-Gm-Gg: AfdE7ckZS89ezpGEvMawDX9RGBWkz9nUFEKMamKH4N1XqVNM590H7yal7lVbBjUmsnM
	hPC/SGZkGvrmo8AZJplBiN3B8sp0rv2Nx5qSAHFXzb5u/MDu3ILrM4zC0Fx3Ib9bfxlZyfJZXPY
	hmcXX7gzk0pabzbNp4aNGbYkAXrvhO00yGsFJlPmvyZWKW5QlBUVzUaLw/A7TUpDocVm9aBM+zy
	sFXvEZuyZ6faxBAjALxIEJQfQ+REnDorHx741P59/XFI/8zR4Xn17pVv+vfWfurADaDwUAM/Rl/
	Oyal7XqUa9FoVfD9+0+e/cudmm8+Qucx99HPHzqkgClhfWpjPYv4iRJsBZEE339JpyKUMBmHI4w
	ZqFHw3sFd+F7nnA6MnDUfzo9S6gYfzEF1m0vUVT1J
X-Received: by 2002:a05:6a21:400d:b0:3b7:d8d5:2326 with SMTP id
 adf61e73a8af0-3bfed0e290fmr10485150637.1.1783059953937; Thu, 02 Jul 2026
 23:25:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1782922354.git.namcao@linutronix.de> <e663a83195f3d9f6d7ad4907c37ae3e45c151062.1782922354.git.namcao@linutronix.de>
 <20260702163608.0207A1F00A3A@smtp.kernel.org> <87mrw8sjo3.fsf@yellow.woof>
In-Reply-To: <87mrw8sjo3.fsf@yellow.woof>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 2 Jul 2026 23:25:42 -0700
X-Gm-Features: AVVi8CffnuaY4KiLN4AyhU_3QHylM_R_UciFhQADgsvWNfXQqFEwJUoE2kfoIl0
Message-ID: <CAAVpQUB+LDxRrF66=NKwLAdLN8kt+Hssm_KBc2oc_q6FTJF0VA@mail.gmail.com>
Subject: Re: [PATCH 1/2] af_unix: Do not wait for garbage collector in sendmsg()
To: Nam Cao <namcao@linutronix.de>
Cc: sashiko-reviews@lists.linux.dev, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304362-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:namcao@linutronix.de,m:sashiko-reviews@lists.linux.dev,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rt-devel@lists.linux.dev,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linutronix.de:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E88716FF10A

On Thu, Jul 2, 2026 at 10:53=E2=80=AFPM Nam Cao <namcao@linutronix.de> wrot=
e:
>
> sashiko-bot@kernel.org writes:
> > Thank you for your contribution! Sashiko AI review found 1 potential is=
sue(s) to consider:
> > - [High] Garbage collector is no longer scheduled when creating new inf=
light FDs, leading to permanent cycle accumulation and -ETOOMANYREFS failur=
es in isolated environments.
> > --
> >
> > commit 506189bd29f8ad56f5d9e51f3e0216203ebad5ec
> > Author: Nam Cao <namcao@linutronix.de>
> >
> > af_unix: Do not wait for garbage collector in sendmsg()
> >
> > This patch removes the garbage collector scheduling and waiting from th=
e
> > sendmsg() path for AF_UNIX sockets. It aims to prevent priority inversi=
on
> > by relying on RLIMIT_NOFILE limits and asynchronous garbage collection.
> >
> >> diff --git a/net/unix/garbage.c b/net/unix/garbage.c
> >> index 0783555e25266..f180c59b3da9d 100644
> >> --- a/net/unix/garbage.c
> >> +++ b/net/unix/garbage.c
> >> @@ -300,8 +300,6 @@ int unix_prepare_fpl(struct scm_fp_list *fpl)
> >>      if (!fpl->edges)
> >>              goto err;
> >>
> >> -    unix_schedule_gc(fpl->user);
> >> -
> >
> > [Severity: High]
> > Does this removal prevent the garbage collector from running when a pro=
cess
> > creates isolated socket cycles?
> >
> > If a process continuously creates socket cycles (e.g., passing FDs to e=
ach
> > other) and closes its local FDs, the sockets reference each other in th=
eir
> > receive queues, so their file reference counts will not reach zero.
> >
> > Because the refcounts do not drop to zero, unix_release_sock() is never
> > triggered. By removing unix_schedule_gc() from unix_prepare_fpl() here,
> > unix_release_sock() is left as the only trigger for garbage collection.
> >
> > This could allow the inflight count to accumulate indefinitely until it
> > hits RLIMIT_NOFILE, causing subsequent sendmsg() calls to fail with
> > -ETOOMANYREFS and permanently leaking the network namespace unless an
> > unrelated AF_UNIX socket is closed system-wide.
>
> Sashiko found a valid issue here.

This is same with my point, and

> But this is a pre-existing issue. It
> is not introduced in this patch.

your patch makes it much easier to abuse.
UNIX_INFLIGHT_SANE_USER is usually much smaller than
RLIMIT_NOFILE.

unix_schedule_gc() in sendmsg() is to self-regulate malicious users,
otherwise GC relies on unrelated AF_UNIX socket's close() and could
be triggered too late since GC is system-wide.

Previously every sendmsg() had to wait for GC, and now it's only when
there is a circular reference AND user has too many inflight sockets.

Please fix the root cause; the former condition on your system.
--
pw-bot: cr

