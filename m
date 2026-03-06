Return-Path: <netdev+bounces-264678-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDECBqpqqmlORAEAu9opvQ
	(envelope-from <netdev+bounces-264678-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 06:48:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F62821BCEC
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 06:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 973FE3040A87
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 05:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0F636D9F5;
	Fri,  6 Mar 2026 05:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2v0e1a9J"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DBE260592
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 05:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772776080; cv=pass; b=BaJgkwZBuLli0nCZlUWOOjZ1MgNPRSfWxvhPsGPl9o/7XI+UYC2t92VpQ2MagGolhuQecNrP2KcwW01HnguoGEcdiQSaVM/a8Q1iaK/jUMBvQB67u7Trlek4o1uu8fq2xJP5sZwRIqaZqKbOR5cKWYQQstuH9MVNlotqDqx4Aos=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772776080; c=relaxed/simple;
	bh=FWoKnzFkU1fho+/6SGBYDFjVkFjVU4+0P4fHA5HMTy8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OUQ6kyl6DSR1HOVKv9O5ivpP8jzKXR5OtG8dGwDz079Ms1jEloy912RRwsJS0RNsOkNiQDXGT1DcUjGl2XSe7jyDp8s7Rw1pIxKkbsrl0GzZdmTAfeWZQLTxq5gV076MPkbYs+CFABAejtIubzRH4v2X9wMbK1yfmGPg0wS9PCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2v0e1a9J; arc=pass smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1279eced0b9so7600199c88.0
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 21:47:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772776077; cv=none;
        d=google.com; s=arc-20240605;
        b=EWMq16KFm1brdRJVt3j3Xms6V2MWLKJv4BwGXYbzvKPNeGu8YzMlMgBNvbCI4fRrH6
         ZMjeKbkJBqf9vy0HQphfJ26n9Fl2hEGtz3TdPq8ay68Oa6d8BWSJWDgfViDePOO0Ul33
         vY1VaBQIvWYoFBVRzWI0z8THCdh1ZwQS98BSzqGoSpYnA0yvmko5Fok+2PT/GZbgeT31
         xkI6crtpNBEpjUsu3UAimcPIWahPXbQwQ4ANYn1GXrO8FYsmUA1jZhhcFaXnKs/tsKkb
         T8jbSN/vF7VGLPAcuQ6RpaMWp3AsdIQ7AhBRTBoKQWT74tFf52n4YzMPTjcPLYBMWPSU
         U6fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gpXO7mHlaGT+SvMmByXwqY9ET8QOSb7XZwHnLOlPXCw=;
        fh=B9zV541UzAhsKsI0hxOwxcm4JlFV3dyAuURLdCjGQfE=;
        b=aT84mYeZXWq4QykwnptExEN19ZIMFkr/bACX/hFS0nLOX/CPsevJBUXUU31GWatW5I
         Hi2jjhC2boDDSrNdzIFEnrmL5Mbg6mQDye8/O58k3E2hgrH5Q3CxTAYg+whPFv3pn5Nr
         LVG2OB1xv/1FgJBE1LiH4vNwPBSM1YoWtzofYlH5n3H5MaBy+0b1XMBpIy5/75d93+f2
         0x3hgEIJm2HZi+bdyq1SIPND3w2upUHQoPSTtTDjSUPY5kzT8gz74dMre4xR9ec3IrdV
         4QWM5JjaJ/mXtnHG+/y0b7WIuA+dqy2DuNKUd8TZfCHS4cAKKpzenCT2dYubBd55/R37
         LCWg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772776077; x=1773380877; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gpXO7mHlaGT+SvMmByXwqY9ET8QOSb7XZwHnLOlPXCw=;
        b=2v0e1a9JEOR8zNQUmfjtW3wi0m/G4WxMvKR7bat+cH/6HNE8pdFJdKITXphSCUbn91
         5Tgmf5g+6xeOw4ORMP9qvbw/rbc03dmet6xTn3HPz5356yS/uaVgIDGgiKyFD5Sy9rTs
         tY/U4AXi78fY2aeA8if9lSQsVjD+Mx0WOaPtrS/lrTj0nIMqrUJUEag+suicHin2fOKZ
         kmjC7RokPiEliw1CBdp8xyXj7lHoG/OpcNsPeKZC5e73qxDKPkTN6sddRxRzLlTmfFXc
         ZeQIJ5WMVJlYj/w/h4ObZRdRJNwjMEt26dfJOhPQ/Z2G5AYFT6blJgYtxiNyLKLZA8il
         fvBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772776077; x=1773380877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gpXO7mHlaGT+SvMmByXwqY9ET8QOSb7XZwHnLOlPXCw=;
        b=cD7B/Y+wwsfIImtlXl5h1h8avtRlsZYi4FFiZCa+Z3z0WbLsHHIuOxzpM8kO6dtr7A
         o2Cr1m3hAjZJzkKnKD0L1VMa3JFk8Xs/Bc90ocA2wN96LC1TKhIoTsyrKxA7A6r8IA2t
         KXgXk6fD71FlEGPT6QIakiRmL9pbQQpO5kmDdg30okSfET7mQWXbUOamC0fhyULGspCO
         dvLJOh2KGNg5vWYa1tbI6lYwU+ssx08aYA2QQsk4teFDtqHGlxIlnvu2AKGela28Gr7m
         OfqG+1eE7iZGVBLl8hftLPuXMAeedYGxX9l60fkJiuOdO7zq9XWKsKV30+Ehd5izmjtT
         pbWA==
X-Forwarded-Encrypted: i=1; AJvYcCUaUut42LK0MTD6przNriI56GNtnXuoWXzKbQbpZd6ZgkkdP3ot/MyVLqP95/d9aq3YBzXs6y0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpW/+D1KhA0NBvpIKTRsQQSgiGrhQywXzVb8XUz2Kes/IodRwN
	sOjzumyQSx1IgKxdlcSingL0GqrNvb8bXwRtn30cqiC8a4nc8cUTLjBvw3AEUTDRTxoTTOAsZ3k
	mrr0LzJ++UMJ9Oc3P0kuQmy4G0NkAg9V5A8K2kMPp
X-Gm-Gg: ATEYQzz3Ev4sko/pi0UjEIJksqlW3Cet11p3vnF7qBbWZGM41AxJYTaFwmF6fbSXK7M
	fc29BYM8JbxLaDsjmu8Nn4NHHFle7R7KOKaVdI8OZOO+Iiod5hzs6kRp1UDPGPiGPvlMYeGGEU+
	RaCNDqVvJ2pjVSjXXiAwrYkFUD1tng/dHoJYZK4kZhCOin4gkC1844S7IqC3X+jtDNiYbHF15Dc
	5/hGL87aWI4ztD3RbSVZJMj9CL7pw3pQpS2TfJrgAzyrLRvi1DQ0AMi0Xbgu6sgzOfvcB00HRc1
	TQ2Q0KDrx3MPaKJirTKaSYBo2qkqkUuaQaBWzhW/E2RDP3Oe0A7c064J6XdrYjXz+q4zL9z1ZBl
	xlsbzEz0=
X-Received: by 2002:a05:7022:117:b0:119:e56b:91ec with SMTP id
 a92af1059eb24-128c2e8b925mr401820c88.29.1772776076587; Thu, 05 Mar 2026
 21:47:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306-unix-proto-update-null-ptr-deref-v3-0-2f0c7410c523@rbox.co>
 <20260306-unix-proto-update-null-ptr-deref-v3-3-2f0c7410c523@rbox.co>
In-Reply-To: <20260306-unix-proto-update-null-ptr-deref-v3-3-2f0c7410c523@rbox.co>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 5 Mar 2026 21:47:43 -0800
X-Gm-Features: AaiRm51rtVtTlMmtHwM6HAI4yCYAH4c9qJkSJtwY41_Op2u8ii9foodM1xMuJa8
Message-ID: <CAAVpQUAdOCM1h-G-vU+tdEdOqc5+YoHypKwV_w5m4bAA4Ai8Yw@mail.gmail.com>
Subject: Re: [PATCH bpf v3 3/5] bpf, sockmap: Fix af_unix iter deadlock
To: Michal Luczaj <mhal@rbox.co>
Cc: John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, Yonghong Song <yhs@fb.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Cong Wang <cong.wang@bytedance.com>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 4F62821BCEC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264678-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	FREEMAIL_CC(0.00)[gmail.com,cloudflare.com,google.com,redhat.com,davemloft.net,kernel.org,fb.com,iogearbox.net,linux.dev,fomichev.me,bytedance.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,rbox.co:email]
X-Rspamd-Action: no action

On Thu, Mar 5, 2026 at 3:32=E2=80=AFPM Michal Luczaj <mhal@rbox.co> wrote:
>
> bpf_iter_unix_seq_show() may deadlock when lock_sock_fast() takes the fas=
t
> path and the iter prog attempts to update a sockmap. Which ends up spinni=
ng
> at sock_map_update_elem()'s bh_lock_sock():
>
> WARNING: possible recursive locking detected
> test_progs/1393 is trying to acquire lock:
> ffff88811ec25f58 (slock-AF_UNIX){+...}-{3:3}, at: sock_map_update_elem+0x=
db/0x1f0
>
> but task is already holding lock:
> ffff88811ec25f58 (slock-AF_UNIX){+...}-{3:3}, at: __lock_sock_fast+0x37/0=
xe0
>
> other info that might help us debug this:
>  Possible unsafe locking scenario:
>
>        CPU0
>        ----
>   lock(slock-AF_UNIX);
>   lock(slock-AF_UNIX);
>
>  *** DEADLOCK ***
>
>  May be due to missing lock nesting notation
>
> 4 locks held by test_progs/1393:
>  #0: ffff88814b59c790 (&p->lock){+.+.}-{4:4}, at: bpf_seq_read+0x59/0x10d=
0
>  #1: ffff88811ec25fd8 (sk_lock-AF_UNIX){+.+.}-{0:0}, at: bpf_seq_read+0x4=
2c/0x10d0
>  #2: ffff88811ec25f58 (slock-AF_UNIX){+...}-{3:3}, at: __lock_sock_fast+0=
x37/0xe0
>  #3: ffffffff85a6a7c0 (rcu_read_lock){....}-{1:3}, at: bpf_iter_run_prog+=
0x51d/0xb00
>
> Call Trace:
>  dump_stack_lvl+0x5d/0x80
>  print_deadlock_bug.cold+0xc0/0xce
>  __lock_acquire+0x130f/0x2590
>  lock_acquire+0x14e/0x2b0
>  _raw_spin_lock+0x30/0x40
>  sock_map_update_elem+0xdb/0x1f0
>  bpf_prog_2d0075e5d9b721cd_dump_unix+0x55/0x4f4
>  bpf_iter_run_prog+0x5b9/0xb00
>  bpf_iter_unix_seq_show+0x1f7/0x2e0
>  bpf_seq_read+0x42c/0x10d0
>  vfs_read+0x171/0xb20
>  ksys_read+0xff/0x200
>  do_syscall_64+0x6b/0x3a0
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
> Suggested-by: Kuniyuki Iwashima <kuniyu@google.com>
> Suggested-by: Martin KaFai Lau <martin.lau@linux.dev>
> Fixes: 2c860a43dd77 ("bpf: af_unix: Implement BPF iterator for UNIX domai=
n socket.")
> Signed-off-by: Michal Luczaj <mhal@rbox.co>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

