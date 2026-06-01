Return-Path: <netdev+bounces-293879-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eC+eCi/LHWrHeQkAu9opvQ
	(envelope-from <netdev+bounces-293879-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 20:10:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB93623C77
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 20:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 10F933015899
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 18:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4CE3E5587;
	Mon,  1 Jun 2026 18:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XwOOY1eh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EA53E5577
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 18:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780337452; cv=pass; b=jC/evElF4aYjGQpBc0ZHXOuMFmh2z4KhfZJkZxDsTd6Q6CwG40ZBPnRBYxOwqAI5eigTI4SyGEmQBL5HNk9MjP82ESl9qFUOgLDPCp/W7z0e0OMxYScRSjos9kE5kLlj2rsi+oRZJC5ITn2jH41ZA39Zu9fo4VgyqadRcr+hcuc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780337452; c=relaxed/simple;
	bh=1oTaoMnKFp6V67/ll4nyBvK1YSc9LT6dl6bWHRIuzI0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c4dFUwNQsvIVzy/YyjYxcfadPRn2bGE33NMd6qcQwq6PlAFVw0XAACnhqwXMUzqG+QP1v+tgzrJFs40sqwI0MgsecLb7+snmloIi+Kxnaczbbv2BqEKH7Yot5b3nTZV3v9KW2uoUCu9sHsvrG2/n1ML9FvNC+SyeebnPTnZAJZk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XwOOY1eh; arc=pass smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-137335bc3caso8705481c88.0
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 11:10:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780337449; cv=none;
        d=google.com; s=arc-20240605;
        b=kTzOJSwUHFAkX0lnpAjD6dilm6rBNhO8sHagXqS3GwwlhdV/tGzDYkrwNOTtXicjbi
         VIkPm4nf+mQMTh5siETuJXvsfCMeW9yDkizzwTKAAm4smTHzChfCuEZqOZfd529WNRSW
         3pCAVZ7icFteDPqkrhxS0gb90W8j9hOtnbQMRcFRYdlrWViGkOQlviwMG4zNlcXDPHfM
         o9YM597OxWdeRm1Yfhgi1nD0pH2ejWEyOQT3yTwhZ4g3Vq7KOj0F0JJoqqvVlZCk/oZW
         Ww97xLC6UrFU4Tkhb98MEDHj6Wd7Cy+xQAWGQtV6+X31aOTqrRBYv+izdkCQwLyPw/BX
         NgDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=evtP2iraeQXo+QnUVMHFu8FwMLQBMjhBm7p7VTcdi5c=;
        fh=oOgw7VSptf5IGHzjioQdmo7WiN38adUxV4Nrr7VO0qU=;
        b=ldD+LSYAcvUDho88KdCVkAb5yuf5IZnTAzIY5yrP6KsfOq0wNeI1Q1Qbw7BA/yXYLu
         I1uipAC2nojZIFZPe6a1aKpzMksz7/jEaXQhABe9Hr2HrJ/jBVDneKUFhGpFfFvck/DB
         uYrovmOMhgsgszH/d0aCh4tPZ1UpEkkoVQrySH656OOuMebLBYbHjTcusplQ3yJJHWEp
         Ip99Zqbi5QlL23BJV1CR8yLzBhbbyW6+Ip6n25w+tKzgWgAOadmqURYKJ2F9cPzFiRn7
         /M2/ZeqFnkgXfb2CyqHg7l67pSnjsfmFhdVA2z6Oh8b/b63eVQ8SlzTDpoNrCwzX6pba
         RWSw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780337449; x=1780942249; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=evtP2iraeQXo+QnUVMHFu8FwMLQBMjhBm7p7VTcdi5c=;
        b=XwOOY1ehusy1faggT3cbM816jvnuOV8BBK199WcTOkCQpNPbhqgchc5BlZlKa6doRX
         utEv8rqvyTfJ6tl6sCLHbvEyLEUQR7/OVFVVTelizg2AtrkU/zOV7WLwX+QSHRVQ2aZa
         dctUVnAfFyCeS0Cyed8sDp7hRWnERVBIRejR7XBYYllfacsjZts3pNjBoguUdRSsvMdu
         VrRnLNDqOJ4lSsEWCMwAxcb+JiPlLzuEennuqLdh5P2BzDU8WBX2QJWfKOWbMBcT2JP4
         cGku6GPsBiz4fYdKrkggkaFmdgTWIPesH4Q9iTDXyF69YpJ128rVlmmu0L4g9kudlmQC
         Rj2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780337449; x=1780942249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=evtP2iraeQXo+QnUVMHFu8FwMLQBMjhBm7p7VTcdi5c=;
        b=WALtpFvmlhk9frh50Hlr38vzvKCwlcBP0qbZmUQVag++0QcyegT3vfR9VSzXohPQLw
         nnaD3Tzt3IcK89LJGGWvMZWRhKtAuE9QvGjd6qYtHSssCtjp5L/QqNMmX1Q1aaIt989Q
         yJqw5Nm530sW8WsTFfYtAA7czVwJ5iAvYIl0WZteHyfLu6nBXlZYbTOJQjLV2hS1WJJH
         F0aRc216x3o1e0DHNn/eik/9zQ3S8SZRSj/7lUA7+o4LHPwo4NUxE7y3tRjiTizWeN8Z
         vsSMt2DnUKq7S8h8BqycHXwNTu27HgGxyxvmC/vF+xx6MxmJ1aZAYb+sJ9e7uWaP5r7J
         Vzew==
X-Forwarded-Encrypted: i=1; AFNElJ/a6MoJOuJ/faMenOyUkCMgDpEzRTSDyLPE3vjDbStLnBm1ow8dXGbsOoGUVgrcEhfpD8OR4pg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIlPqc4fsIxM4lqJrQJGGvkjdb8fAIV9z6QZ4mLpL+jl5Oo4wF
	d2JxgzMku3JPrNiHeZR8TLB54POmP35A7vVun0HndCL3BR5F/mCZGoeEb4Zk3G6MsyiKqjgP+xI
	nQX2A54gy9YNzZIIcv08xSPNIpTUNhpj6ICK83uzI
X-Gm-Gg: Acq92OFYGx6mH7MMiXCYUTPPdgyMfzhcIKvLIQhjJcLxtZjRqghNsSiJZLLv4VcrJag
	Z5LOMMR5FOKzP0HIWG5Gvtp0hfXDW4Srhs91c/OA3E7nVbQmROzr8KOVKaTTM6ngAO7oP/fR8UE
	VmIBbS/7G3HhLWMBf+YE3DGBZvYKsW+DcCUNTGDhPKU1gH3t3RHKYlIi49Qbvwbz+hwSPVxiLJA
	PKgkkDrK1ZH6ecIf+xCZEbd03bmFpxeqRJp3iyfNBqLv8wsDj4KOB+Up+8sQSyeme4XfV5oMyPh
	c/SSbHGhOcEvV0QgF18Aj2crqVwpvTI/gPW+pPUwqAr0FHdbBbVUip6JQWt4wlYiNAzVpmCmGla
	7t7FwGSKWoQtGYJ0UQ8TwJewZSSRszBPAhGB6VXkiBSNH3cQMWWdUPk5DtQt1i77j73G1S3g=
X-Received: by 2002:a05:7023:b06:b0:130:6904:8c17 with SMTP id
 a92af1059eb24-137d4120fadmr4300475c88.18.1780337448469; Mon, 01 Jun 2026
 11:10:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260530055907.280160-1-kuniyu@google.com> <20260601065009.YBMkQ84z@linutronix.de>
In-Reply-To: <20260601065009.YBMkQ84z@linutronix.de>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 1 Jun 2026 11:10:36 -0700
X-Gm-Features: AVHnY4KRwt2Fw8YPAHghkjaL6objvpR1vUdcTJiAIxkgF6u2Wglu5_2_tSRLDGA
Message-ID: <CAAVpQUCbCSEhnUSA+fV4nh60reTZ7WpYeort-dyWPNLRJVuLKg@mail.gmail.com>
Subject: Re: [PATCH v1 net] tcp: Add preempt_{disable,enable}_nested() in reqsk_queue_hash_req().
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	syzbot+e809069bc15f26300526@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[google.com,davemloft.net,kernel.org,redhat.com,gmail.com,vger.kernel.org,syzkaller.appspotmail.com];
	TAGGED_FROM(0.00)[bounces-293879-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,e809069bc15f26300526];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mail.gmail.com:mid,linutronix.de:email]
X-Rspamd-Queue-Id: AEB93623C77
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, May 31, 2026 at 11:50=E2=80=AFPM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2026-05-30 05:59:05 [+0000], Kuniyuki Iwashima wrote:
> >
> > Fixes: d2d6422f8bd1 ("x86: Allow to enable PREEMPT_RT.")
> > Reported-by: syzbot+e809069bc15f26300526@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/all/6a1a7bcf.0a9e871e.332604.000b.GAE@g=
oogle.com/
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > ---
> >  net/ipv4/inet_connection_sock.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection=
_sock.c
> > index dbcd37dfdc15..b546ce15ee03 100644
> > --- a/net/ipv4/inet_connection_sock.c
> > +++ b/net/ipv4/inet_connection_sock.c
> > @@ -1145,6 +1145,8 @@ static bool reqsk_queue_hash_req(struct request_s=
ock *req)
> >       if (!inet_ehash_insert(req_to_sk(req), NULL, &found_dup_sk))
> >               return false;
> >
> > +     preempt_disable_nested();
> > +
> >       /* The timer needs to be setup after a successful insertion. */
> >       req->timeout =3D tcp_timeout_init((struct sock *)req);
>
> That tcp_timeout_init() has a BPF_CGROUP_RUN_PROG_SOCK_OPS() in it.
> Could we move that preempt_disable_nested() a bit lower just before
> mod_timer()?

Fair point.  I'll move it before mod_timer(), thanks !

