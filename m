Return-Path: <netdev+bounces-285966-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKzWAWJF/mlFogAAu9opvQ
	(envelope-from <netdev+bounces-285966-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 22:19:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 75DA24FB6A1
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 22:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AFA0E301158D
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 20:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8405A37E303;
	Fri,  8 May 2026 20:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wYs+PV0k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A2B3AC00
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 20:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778271582; cv=pass; b=h7w+w5axWORi9Caczx9YCo80DT6HpGCxRWPL+VrF0ZJDuaPjaeUgzE3ZqjYSEwENihM638qMzsRxgWgl3PmAKI0wXmSTnQ/DXX0U0QA8fa63c7NM2yiOIgRvPoJT4fGtbFYesLROHgbO42JrOEwcvTgZtCmzDcVGxZY0EkxXYes=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778271582; c=relaxed/simple;
	bh=8ItX+BQrb8DPPcdx7Fc0ebuh1W7HIG67JuXl7zgZvCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jecjq6stdeVkQ8S+r2UsNEFyewWGjN3k+JOEoBzCg9aQJbB1a7c2Iwu7sUHa9Qj3ZVh9ei0+Svl/5pMj990BaJYNrZaspOO/X+ZTxb4vEvkEwiUKuuSYUjVynxEfY1I9wYQIGZt8L+lXdVnDLQFGKc5NAFaQqWltyF1MmhZ6ngc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wYs+PV0k; arc=pass smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-132830d8281so2005517c88.1
        for <netdev@vger.kernel.org>; Fri, 08 May 2026 13:19:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778271580; cv=none;
        d=google.com; s=arc-20240605;
        b=Z8nLFpjoD530KpCS+DlZ2mZnN9gVPrHFc2C6kP1fDXgYdXhSygQtn8oMkYL5ZFyXUo
         /DzDkNJL9QUrfuhwIA7SoJhrfe1DKw0cvEFH/ju4aQlTvqZzH54CaKQO5dHYijW7R1u3
         EENrBKFAQdw3CawYvqpRG3NWLA40rbnteUJZfigfYEHKPe9CFmzAC9sk1h+WXC1Qwix4
         m5O0GhVDO7ZY8iAk4Szgy+S21JJjhzEeCxkujLBix5S6iekQRhiDWNTA4yqmPwfl+dJY
         I34GSSn8i33+bXxdsq5WEhyXSZlvXlyDJilQOUntdz30+gj73tSmyTZpqFtndNpFbp+a
         FGpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+B1AKZI8ovjXprcofyiqirQq75Rr4Az3Z8kwmuK7zZw=;
        fh=q1FA/NqUDBv09xsTu0s8+ai9lUZo3nMKpgNjAva7dBI=;
        b=Ag9slmEM/chgpktG/xF1eY55RffFZlOitGkAH2Cm4E2M4tnF0yqNO8n5FP2GfgDWdy
         QO0uPk1q3Q37gccipACdp0NBBqwIVPXgWzO16gwXb7ytrjgo6uAEtrBBFCy5xNwGYIj/
         Fhp0jvkYF9SmpTA40DAXMezzYzpu1qp9wjriWoBP+MQlXfb/R3fPhtqjz/IosVnSdRn1
         yf0XwFcGGV7VhlaKF3l/BEY6aHz4KGhrSDcvTGKN43mBTs27YXyk3IppUb3cZvxlisbd
         3IEpI9UreBEpgTKqy50Ujq+JHpxZDJDPT9fEk8HDbphkfoq5pGAJBmXts27s9+FzPchG
         Iomg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778271580; x=1778876380; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+B1AKZI8ovjXprcofyiqirQq75Rr4Az3Z8kwmuK7zZw=;
        b=wYs+PV0k3yvi6BXrCJcKkZaKqSCOdvCzQ83KBluIldeKIae/TC0Azi8rhyjRXo86uh
         N9wHPO9MAEwufJkYcU+kHDCajyTOYs844+2mtG/vy2TkGrT2QCyLDce8xVnJq6j+j450
         oFVLHf3li4Xwsmadbeni0Ug71ieUl0CjT28POlRBTYHnW29l2WKFJqoxC4rDGcT+F9Y5
         0yXgseMBoSIPgDw0KxGPTC6ZR0+F2iDEGbslP/KDpi50JR2QaNa6NP1VGFO13XMC9yo4
         H2gLZUvfxtAhIg9oSGNt6wrEVZSjexpjZQSSN4sbo28xE2C4D4xZrckbR4diUxX881IB
         64Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778271580; x=1778876380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+B1AKZI8ovjXprcofyiqirQq75Rr4Az3Z8kwmuK7zZw=;
        b=ZkyAMeF8IKZkbqCMYamIBEMeA5tMbv3y5cBniVDP60PXvDey3RfImDx8jv9fR99ZF9
         aZSyCvTxiiewMk0t3XtUdshdSWc92PAr+bA4B0EIIfwnFbOSdIN28cECIjnXHpiwXvfZ
         560oqFeDBJZezpNIMkPJi0UCMb4Tn5dQ21wvm4BOPhiH2gPhMX0Qn6xMSyIOevd8VMxM
         wo6xue/1R3Dax/Qz3px8n+9mwFNI89l9TbmcGUwU3XKBswTHwLHNN80gs4AK3mLO9ah2
         LDLQWAulThkVdqO8elLZxM/IFi1ljvBeVhqH59poj2N9uUMxE+Cd/mqsPAqK2O3EB3Zm
         LaPQ==
X-Forwarded-Encrypted: i=1; AFNElJ9i6Z21912zA2hMuJizTRE7s6ZUY1FAn/iXMfrioY1qfIEPPgIe4b2VjLDO8fkRbR1jNH9hXUY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGhXBwZkQ+XCOigICZWUzy+UyjljONVCHZh0op87lIxV4FnaYW
	VnlS+WW/AbBH8gHQ6zSv9vTot5bGK2KZ4Rgcr3nmhHGgSETHNj9Sqc2omwT1n2O1ks3uSFCBc2A
	ehMDk2D7EsS69udWeUjYXKBYvLljvzaYNxMbPrCm6
X-Gm-Gg: AeBDievjVMYQxOXYk7JwJeM5Fh79NcabBjxxsLkO2ZZh5bZNkJFN/YmHIjsCUY4n6dR
	IOUlBeyT5Xo98llD8fq0gNH8/SjB95KD9CRyHMa9uztrWEtw9XTaiVMfltwCFHli5aPRYDhP7bA
	lvK8nYL7Sw/V8EoVVtyyUYbg9gHoMno2gc28Sigdl6VdLqLQIRl0bSbn3s7/pCTysR7pbhZiIKO
	SyHVxH/iY16bEEDQKfMbTkPtjLVFX8pZR4XD4Q0svJlJMNpcnHFArXQRJ82noA80mEwezHmLcz4
	dQbtRwH9mtOsaULMM6r+bCwzS/g+aAC5YvVPYpiJh8A6R7v3couBgLIsHgyiZYerCKZC5h5OcHf
	HSV+Uw8CFPrnDOevUDeIG9hKpw/I17q4=
X-Received: by 2002:a05:7022:4392:b0:11a:641f:ba11 with SMTP id
 a92af1059eb24-13271c9c205mr2423392c88.29.1778271579731; Fri, 08 May 2026
 13:19:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260508073355.3916746-1-kuniyu@google.com> <20260508073355.3916746-9-kuniyu@google.com>
 <af4CV5itdz5Dzwo7@devvm7509.cco0.facebook.com>
In-Reply-To: <af4CV5itdz5Dzwo7@devvm7509.cco0.facebook.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 8 May 2026 13:19:28 -0700
X-Gm-Features: AVHnY4IfgnSdHVQGqmUp9c8TPr6rc7CoIlimLF0FkCpLI5deyQ5bxtFAPQGZg_k
Message-ID: <CAAVpQUD01-UJorFM=4sT1b4XbiVF0TPorpzpU+b8DYXzn0FH0g@mail.gmail.com>
Subject: Re: [PATCH v1 bpf-next 8/8] selftest: bpf: Add test for BPF_SOCK_OPS_RCVLOWAT_CB.
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Tenzin Ukyab <ukyab@berkeley.edu>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 75DA24FB6A1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285966-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,berkeley.edu,vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Fri, May 8, 2026 at 8:35=E2=80=AFAM Stanislav Fomichev <sdf.kernel@gmail=
.com> wrote:
>
> On 05/08, Kuniyuki Iwashima wrote:
> > The test is roughly divided into two stages, and the sequence
> > is as follows:
> >
> >   I) Setup
> >
> >     1. Attach two BPF programs to a cgroup
> >     2. Establish a TCP connection (@client <-> @child) within the cgrou=
p
> >     3. Enable BPF_SOCK_OPS_RCVLOWAT_CB on @child
> >
> >  II) RPC frame exchange in various patterns
> >
> >     4. Send a partial RPC descriptor from @client to @child
> >     5. Verify that epoll does NOT wake up @child
> >     6. Send the remaining data of the RPC frame
> >     7. Verify that epoll finally wakes up @child
> >
> > During setup, two BPF programs are attached to simulate
> > a real-world scenario; one is SOCK_OPS and the other is
> > CGROUP_SOCKOPT.
> >
> > While the SOCK_OPS prog handles the dynamic adjustment of
> > sk->sk_rcvlowat, the CGROUP_SOCKOPT prog is used to enable
> > BPF_SOCK_OPS_RCVLOWAT_CB via userspace setsockopt() using
> > pseudo options:
> >
> >   #define SOL_BPF               0xdeadbeef
> >   #define BPF_TCP_AUTOLOWAT     0x8badf00d
> >
> >   setsockopt(fd, SOL_BPF, BPF_TCP_AUTOLOWAT, &(int){1}, sizeof(int));
>
> Hmm, so you do want to have this enable-on-a-per-socket use case.. Then w=
hat
> happens to the skbs already sitting in the rx queue by the time
> we enable BPF_SOCK_OPS_RCVLOWAT_CB? Isn't there a race? Or am I missing
> something?

If the upper protocol is designed that way, it could be racy.

For example, HTTP2 could have multiple streams within the
same TCP connection while only one stream can be upgraded.
But this use case simply does not work with a single
sk->sk_rcvlowat in the first place.

This feature implicitly assumes a single stream per connection.

In our original implementation, it traversed all (technically
up to 100) skbs in the queue and parse them like psock.

But this will be unnecessary if the server drains the queue
properly before enabling the feature.

If needed, we could return -EBUSY when the queue is not
empty.  It's always under lock_sock() or bh_lock_sock().

