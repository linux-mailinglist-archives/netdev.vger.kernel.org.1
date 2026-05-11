Return-Path: <netdev+bounces-286461-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uEcpNkp6AWqMagEAu9opvQ
	(envelope-from <netdev+bounces-286461-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 08:42:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBEE508A88
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 08:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 303EB300F7B0
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 06:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2A033F8BE;
	Mon, 11 May 2026 06:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TcI6t4Xo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDD42DC791
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 06:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778481732; cv=pass; b=LLQfAdV1l3f++Vz2A9um0ctqmyz8g1rBmaVOziHY3GuOhdUwZpchtWyOEFqd1OCjNML+5ploqizQfdkpXaw2Gl30p+aFmGW9JGnT0ME2KHdmq6nMk12GGkl1unoz58RE2lgd8+cueGapMHjlpM3ugJwxIvlI7xsLXMpBRiA4A8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778481732; c=relaxed/simple;
	bh=FfTedBOMUlVnj5CTRngWKFRj3NK32yJ5+3edLfpIC2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bW/13A2cC03oHEzpsSnH0u4MPCWytBq1pSOmdvvUvmc1y5wbF4s5zFUg3rQkIix1PVaE78bJSOurgkzukWYvWoyJTYErJPiLlWaQL+R1+hw19jsXOYv74Mm6Qxbo1Pp0U1h7QnNF99e3lxO+t3+NvBCPyjf0XwX6Ozs9WUViZM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TcI6t4Xo; arc=pass smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-44e5624c053so2137282f8f.2
        for <netdev@vger.kernel.org>; Sun, 10 May 2026 23:42:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778481730; cv=none;
        d=google.com; s=arc-20240605;
        b=eyvC0NLqm/svJo2mIAPiZfr/OCFTZbLPm6Ec7GCFVbJCIGkqQYc/wtFrgarPVrJV/r
         tzfuyn/JoRKEh5+bWyZ6bHoH2xAI50aT9LtJHOtNK3165sXHAlCmARS5Ga0Jir+6Yx1/
         hpoTzrJhap1ep3W2PPLKQChyDfW0skukjlXLqbp9z+ZH3v3ShJe140bl2OJYjojCgNuw
         nBhqMjH60JVjxS5l2aQS3abbpAQwgE9OeEDFX9RlmqYSrQrYfRIJvWC+6xD4ybZqYEBN
         0knZNet/Ghy3+mqTxNW6pMSQTVrjfvlfl/nR7T9bFrZGQ71WLEKtk72Y+gO8UT71MYVq
         54WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Ixl+rregM98dF27c4lqph6kYPtmIdfqfI1YXLoMUfoE=;
        fh=W/LGvausQnRRlsx0weIb0yyydmQRjCtgqTUsXisDF/E=;
        b=Kf9BG3EPbkzAt3cskI04sMbIanBfmCKf0lqWBN7o9JmY1luPawLHdGxRu5sclFTi/l
         FaDNOfEx/8+gcFDRwJ1plXQpYVj3WCEQfcvk+jldhAvuCk2E4YkaCSWdjBLTG7B8m3ht
         W6EmUkaQtWTtRuS8TQTzIBC3eg4cmnvgTUtf9ij5oo11nTvQ2RuVtyMn4wZzHBtyjkWJ
         hn5LNd1xGTHR6xrP1x9oaJ8QaBJz2iPF7kfMOMCniR5T4P1SLXyrKh/gyFi6dEJsPLH3
         PTXQrCWo50yMqrTFsk5vug6sKddBQ06LA72Ya2A4EZ3MrCVemNHB7/OPLaV9ef5YB0TL
         TyxA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778481730; x=1779086530; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ixl+rregM98dF27c4lqph6kYPtmIdfqfI1YXLoMUfoE=;
        b=TcI6t4XoE4oVv5VNTniiSh7h/mHG2rHlTE1CYGC0rm4RBFOJ362Gh/RUV7PGpGKbBQ
         dVzLHIapjJwr73JI87SH4/hVdDx/95BilugTGqAq7o1bpfuj7lcrQAOjX3Yoke9K/l1k
         3HJxetX4HylMAGrCkDNHk9da9XcbY5cW4w8TMhrJ80l78O1jrZHg81igqwo/zy5Q7fc1
         qc+1AQhcXpjv2s7ChtjpjFhVztQPiiPJGeIs41YOumpw4At/eRXyftgHdH6gi7ubEKcJ
         AmBXSdaMrnG2RnXqiYdR1+d5F7abAujTNG7cdZGDy1VtUb73/JkoQuw0Xkn8G+9jxraX
         gyfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778481730; x=1779086530;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ixl+rregM98dF27c4lqph6kYPtmIdfqfI1YXLoMUfoE=;
        b=NHbDYZhoEA0SVZQiS23FdooAcVnDRvc86TbnMJpDF0OKQ78vU5wKjtE2JELMajoXQb
         0n5k59DEmGf0ezgf7mxgu3uJqMGTvYfqkdmmjoJQGLOTq/TtzEJH50XA8s9dy53TkLwU
         vkQcZOq27B1PmxiU9+/MiWZ4mqzIN8wGYy0eXaPaxcUqi6jTOkcZTFmYJz+FwbohFLyY
         C0UR/dhKpKHh61V3oH/sKODmDld2dlZJBhq3e15zj7j8NaYEawtXG1g+dlOBV1hAt6t7
         N7U0+AUngXZfbmV7bP/7nf5o8oXJMCgmpjOdsqk7dqGTD+I53yhXhdtnm5LC/H7//h14
         dVgQ==
X-Forwarded-Encrypted: i=1; AFNElJ838CC8nAKyfAVE8ghkx8c12MrqFvkCSCkMaqtLxB7L57l+6uXW49GjD9ClRbHeRwEKh8rxs2o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjNecjxp72JUXh4cmxSKtceDVcywnqyJ9LKPWY2oe+XNT9uwTe
	6rgTcR4ON54lXxZN4F3YIpGQcOVg0p/cIoG6OwLq/DelFEVPgmOiz49IdwGTYWd0pJFnb8Yxa1e
	oM+9ODCy1ntiFSkp/xAAu5E1ROmRWFRs=
X-Gm-Gg: Acq92OEbDVUTQR6QGrXakZ2BUEfq43v4H6Rq+04A4WjE941tn40zyxP9Ij4+c7B3Ukh
	7+p8mrQ49E7nk1cT2MAlK6yq49Sav3kykcAV0PW9LBpxA+7cc45iA1rRp8SKWuFgJrydsnjQL+9
	8VaiqfIvXXYkQN6/G4KW9RBrSGgbgJf+HUU8M1DZQGuxlNx+BwzTC86N4vZyb64CJJ+sfDQ2dkw
	NA/krSK5eELeDp3o/JTc+iyDhvuyk8X6Ax1EodDeYGamGvUVx0Mf207+mYQFGQztTStQGN7vEsC
	mLelOJw=
X-Received: by 2002:a05:6000:144b:b0:43c:fbfa:20a0 with SMTP id
 ffacd0b85a97d-4515ce1c859mr35646350f8f.25.1778481729487; Sun, 10 May 2026
 23:42:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507081332.2868770-1-maoyixie.tju@gmail.com> <20260510145425.1372018-3-horms@kernel.org>
In-Reply-To: <20260510145425.1372018-3-horms@kernel.org>
From: Maoyi Xie <maoyixie.tju@gmail.com>
Date: Mon, 11 May 2026 14:41:58 +0800
X-Gm-Features: AVHnY4JlowENWaXpdZEiEfTxuQ71SK893QjOzWDT766OkjMpq0H-gQ-YWIqd_C0
Message-ID: <CAHPEe=FDQUTZn5QVfYiqf_p1OwiUOehe49WLXHGWzB+hgnnWrw@mail.gmail.com>
Subject: Re: [PATCH net v2] rds: filter RDS_INFO_* getsockopt by caller's netns
To: Simon Horman <horms@kernel.org>
Cc: achender@kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com, 
	linux-kernel@vger.kernel.org, maoyi.xie@ntu.edu.sg, 
	praveen.kakkolangara@aumovio.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 7EBEE508A88
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-286461-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hi Simon,

Thanks for the review.

> Does this early-out check using the global rds_sock_count break the
> namespace isolation and force callers to over-allocate memory?

Both effects are present. The size returned via lens to a probing
caller is still the global count. A caller in an isolated ns that
sizes its buffer to that value can also see ENOSPC on the second
call. The precheck compares against the global count. The data
written only covers entries in the caller's ns.

v3 addresses this. Each handler now does a first pass to count
entries in the caller's ns. The precheck uses that count. A second
pass fills the buffer. The change applies to four handlers:
rds_sock_info and rds6_sock_info in net/rds/af_rds.c, plus
rds_tcp_tc_info and rds6_tcp_tc_info in net/rds/tcp.c. lens->nr
now reflects the ns scoped count on both probe and full reads.

Re-verified on a KASAN VM. One AF_RDS socket is bound in init_net
to 127.0.0.1:4242. The attacker is the same process after
unshare(CLONE_NEWUSER | CLONE_NEWNET) and uid_map "0 0 1".

  [init]     count-probe rc=-1 errno=ENOSPC optlen_after=28 entries=1
  [init]     full-read   rc=0  len=28 entries=1 (127.0.0.1:4242)
  [attacker] count-probe rc=0  optlen_after=0 entries=0
  [attacker] full-read   rc=0  len=0 entries=0

Pre-v3 the precheck returned the global count of 1 to the attacker
via lens->nr on the zero-length probe. v3 returns 0.

> Can concurrent getsockopt calls trigger a NULL pointer dereference
> here?

Yes, the window looks reachable.

The writer takes rds_tcp_tc_list_lock and calls list_add_tail. It
releases the lock. Only after that it assigns tc->t_sock = sock.
The reader takes the same lock, walks the list, and dereferences
inet_sk(tc->t_sock->sk). There is no NULL check on the read side.
A reader that enters between the writer's spin_unlock and the
t_sock store observes a list entry whose t_sock is still NULL.

The companion restore_callbacks path is safe. list_del_init is
inside the lock. A reader holding the lock cannot observe the
unlinked entry. The matching tc->t_sock = NULL outside the lock
is then harmless. Another reader in the same file at line 676
already checks !tc->t_sock before use.

The smallest fix is to move tc->t_sock = sock into the
rds_tcp_tc_list_lock critical section in rds_tcp_set_callbacks,
just before list_add_tail. The list insertion and the t_sock
store then become atomic from the reader's view. The diff is
one line moved. It does not affect the callback_lock side
effects below.

This is independent of the netns filter. I have not built a
runtime PoC. The window is short. Does the code analysis above
match your reading? If yes, I can send this as a separate patch
with a Fixes tag.

Thanks,
Maoyi

