Return-Path: <netdev+bounces-300013-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6Rv2ILIgMmpOvQUAu9opvQ
	(envelope-from <netdev+bounces-300013-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 06:21:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D89AE696653
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 06:21:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=Pr605MSg;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300013-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300013-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 754BD30382AF
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 04:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060343002A0;
	Wed, 17 Jun 2026 04:21:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944A1165F16
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 04:21:02 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781670063; cv=pass; b=vEvi7yb4f8u9lzpt4P6RpIi0mO95/ZSJ1wgYUpUZr5Oiw4AWort89SKsdSo/QSDr4M7WfPHgNwgji+zMNMLLD6NMxK+cYV4/UhAVPw9zQFb+zY1Dn9ibE7PdcSZnhzzyss6z/sSKGI4DC/526qJs/wjDzQ2VpZC+e6GUOsWvvG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781670063; c=relaxed/simple;
	bh=hBy0mQ2RsyA0xA1QfjnETR8aa0YHYu+VVm75ByONQVU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=smEZznuR6iYQBhkp9eBtzi8bteLk23CJNY5ETAEZC40DowD3qWR+FuZkUHA8l4mEPbKpFe8P6BZiyuqV/mLEiEzoz+TQt02VO3oc0zHV+z7IfFge6eyxnD7PUW8qit8Or+yIP5k0hHqE3+G+lcH7Rs5orRNR5s3QMx64aFSJPtU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Pr605MSg; arc=pass smtp.client-ip=209.85.160.182
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-517a5cafc3dso57645491cf.3
        for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 21:21:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781670061; cv=none;
        d=google.com; s=arc-20240605;
        b=UZcXhA+sDCa0GH8pvE0rJWUq4Ocxb8lJDL5mrtyg2sdjROvhz8975Js4tn3YrPl/CS
         891XNV6rwv+lNlF3UHz7waxt3EFRqOgFfL6U3wMmqEA8JDwqGlZqQiU7/o7vLcRr+9ye
         SIr4WBRF6WGBMXjLovvIFVPAcDChn8Lp5b/uNTxLXbMMW5Qbh0TxbmvAXonVVUOsiYIg
         r3ogIJQHm5wflJYs0h/M2AwiM7bqohsAPSELncB9/Wkv3G6+R/BnKtlBRsq94YwnRHHI
         ARJHO+OgZ2j2gUUoK1Dr2O2MTYem0P7IdplbcZkToB9NtLH4Fn2x+hqifWPEwTKp4ixi
         kDJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bFm33L594+J0QvjWjU5JHWqSjPE/8xjzen/1P3B6Pvg=;
        fh=zvG9YcPw56FRTonupyaQUX4OS11UkAAe1UQklZxC8ko=;
        b=ERKwQxZPF1NUtWr2Oe9enATpRoxVB8V1x4JUEpI80vtx/VNAiWOUGtQ/kf15gvs05U
         OAJ89LYgDsQQ0x5BOjdn8sNsFXMP0fGY3iVRQeVXEMAlLCEy/MXx4aMI7E4LT59VBQ6K
         ky6vCmvhQlTpjFhyvhsxy3FCd0lrrfAp3ZId1lxC0mTVckq72+ZnQlVLYlFxlxndW+dC
         yPC0DZeZoInT98yHb06F+X7FfM0hM8HWzNFAmOfidJh9gubyTIfbvYps5Kus72Nj56XI
         y2PZLu9QxyrkQc524Na8lEM0bApNIEZLAYsS3++DdNdstpHasyxx2tqVGxjnC7lz7dti
         PVcQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781670061; x=1782274861; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bFm33L594+J0QvjWjU5JHWqSjPE/8xjzen/1P3B6Pvg=;
        b=Pr605MSgpUM0NDJSxqbXNsk2d2Vb/TaY4PP+6SaIdBXyrar3K3jzm+bKSVzHq4n7Q5
         snEuhKpU1wtb5eE2N8GHMpMvyPNJ8AITW8ohzNM+pQjUdIsWLuA7m3i5NIkGzI1J1G/t
         ziZfJuQeh8fErVG5C6UdA+EjbYFi95gHdkpvnYD5KzZ2DHN50KUQO3rSNDPTPkzEicPK
         8zBtnCvbgJdHjm/Lk8G1GqsXBRIlAbJltLqtweiTMA/jUjRQCOHs9QIP0tYiSG1uqRrH
         8BdJHg1DYnunoZ461257Y7bMrfCPtth+qknNNnYWz00ftT2jBzjVeFHEZpjD2T9UXYoe
         rhvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781670061; x=1782274861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bFm33L594+J0QvjWjU5JHWqSjPE/8xjzen/1P3B6Pvg=;
        b=c4UKwvcTxmOdRWb9pfuofyYKZbIP2X4Wy5vKsbiDbMbnOpQnY+aBvDzHVHMk3mstAg
         YRwVRspXk7bSTJLSNdLmMB3MIxdIAVhRb+GQQf2y7xmWBwJqOHcIxz6WgOLa7XhaOt7P
         UNSBvAEtY6POYrF0t8iCNiF4E7C0KaGULrkK+Y0N/9ZD9I/CRWB4d7leQh5N++tAiesy
         bd6yEfnW8QG9/1hwVILzdaCPJ41KYWnzB9qlOPZukiV21LHcrMYjGcew7B9joRauJLyi
         iMEZveXaeADlvnglXDiAs5+xxCHSOsjP3AFEAUYNUQEsqDArNtKv1HGrpOAFOr+wGfoz
         dqFg==
X-Forwarded-Encrypted: i=1; AFNElJ9FvlDFYmSMRXKL2kN+1BkoRnmMGlQo68ibraIE1GVeK8nRPGgLhjFkw47gmJA7CcuicnjLYUY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCvcnmWHE32MLbA6pYHljwvViQBo8Ou/N/q5JQclSL0OsBvvni
	XAhytQLZKISrEyPkkzJ9iPxjHgYtxZ0/u7Bymj5SznR82Esrkn53ztGWb4bJM3CIWIm2ZDxOklc
	mSQ4K/A6zFnznAQ8Af5pjJTajkVtvpy7S9cauHscH
X-Gm-Gg: Acq92OEShLdQF9uvzfmGPIDm0cLVGypIjAwx/UTWejKeVT4PPzInMw1ONBMdvUtT8y1
	fUFXjobtg2zOALopUJcmq1H1D+gc9b5WCQMrnXa2+jMvrEhLjQL5QfKomrOxg6UzB1/KNbloC+y
	scvPRWUMZojbpPRKX2ozbAhjQStTZrUa6FqePPcmKzRQ7fU0/UIgROo7neAKFHXF60mx6DPOGfU
	LmYw0doYlaw+8bfWUvvYGwFWa1pt7TG42KENak0hDFL8EAWDpwy+RzKElWhigt97R4L+hANyHSO
	EwhHb/zhErPwD43hCCNfEPQdZ2zc9B7eWMUcTcoiNlLIg7uGWcoih2/u8pFm+k7ene4gQ4UmMiv
	Yp0C1rl2l
X-Received: by 2002:a05:622a:9001:b0:519:8b20:ff12 with SMTP id
 d75a77b69052e-519a8e5bb99mr30713201cf.33.1781670060973; Tue, 16 Jun 2026
 21:21:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616191359.4142661-1-kuniyu@google.com> <178165020689.1270198.450287651539968178.git-patchwork-notify@kernel.org>
In-Reply-To: <178165020689.1270198.450287651539968178.git-patchwork-notify@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 16 Jun 2026 21:20:48 -0700
X-Gm-Features: AVVi8CcOHl-3RTLUUh1yeLP2U4B82kUjrM8-l90bNe6F3EHJvBB1cOeRdUr00lc
Message-ID: <CANn89i+8Gz7t1r7X_BNYhSozGZb61wH7eMgkdbmXWYE7RRP7Pw@mail.gmail.com>
Subject: Re: [PATCH v1 net-next] ipv4: fib_rule: Move fib4_rules_exit() to ->exit().
To: patchwork-bot+netdevbpf@kernel.org
Cc: Kuniyuki Iwashima <kuniyu@google.com>, dsahern@kernel.org, idosch@nvidia.com, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	kuni1840@gmail.com, netdev@vger.kernel.org, 
	syzbot+965506b59a2de0b6905c@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300013-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[google.com,kernel.org,nvidia.com,davemloft.net,redhat.com,gmail.com,vger.kernel.org,syzkaller.appspotmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:patchwork-bot+netdevbpf@kernel.org,m:kuniyu@google.com,m:dsahern@kernel.org,m:idosch@nvidia.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kuni1840@gmail.com,m:netdev@vger.kernel.org,m:syzbot+965506b59a2de0b6905c@syzkaller.appspotmail.com,m:patchwork-bot@kernel.org,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev,netdevbpf,965506b59a2de0b6905c];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D89AE696653

On Tue, Jun 16, 2026 at 3:50=E2=80=AFPM <patchwork-bot+netdevbpf@kernel.org=
> wrote:
>
> Hello:
>
> This patch was applied to netdev/net-next.git (main)
> by Jakub Kicinski <kuba@kernel.org>:
>
> On Tue, 16 Jun 2026 19:13:48 +0000 you wrote:
> > syzbot reported use-after-free of net->ipv4.rules_ops. [0]
> >
> > It can be reproduced with these commands:
> >
> >   while true; do
> >       ip netns add ns1
> >       ip -n ns1 link set dev lo up
> >       ip -n ns1 address add 192.0.2.1/24 dev lo
> >       ip -n ns1 link add name dummy1 up type dummy
> >       ip -n ns1 address add 198.51.100.1/24 dev dummy1
> >       ip -n ns1 rule add ipproto tcp sport 12345 table 12345
> >       ip -n ns1 fou add port 5555 ipproto 47 local 192.0.2.1 peer 198.5=
1.100.2 peer_port 54321
> >       ip netns del ns1
> >   done
> >
> > [...]

Note that even with both patches:

fib_net_ops runs its exit handler -> frees rules_ops and fib_table_hash.

The devices are still fully UP (because default_device_exit_batch()
has not run yet).
An external packet (e.g., from the host side of a veth pair) arrives.
In enqueue_to_backlog():

Since the device is still UP, netif_running(dev) is still true.
Our newly merged lock-serialized check will pass, and the packet is queued.

The softirq processes the packet and calls __fib_lookup() or
fib_get_table() on the dying netns.
It will hit a UAF on the already-freed rules_ops or fib_table_hash.

If we want to make the netns exit 100% bulletproof against this
remaining window (and not revert Kuniyuki patches)
I have patches hardeniin the routing layers (RCU-safety), making
rules_ops and fib6_table RCU-safe and checking for NULL),
and additionally make fib_table_hash RCU-safe.
This way, even if a packet arrives during this window, the lookup will
safely fail-safe (returning -ENETUNREACH) instead of crashing.

I had these patches written yesterday before realizing the issue I was
looking at was generically fixed in enqueue_to_backlog()

