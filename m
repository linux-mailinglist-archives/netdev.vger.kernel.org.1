Return-Path: <netdev+bounces-296652-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lRduMbXpJmoBnAIAu9opvQ
	(envelope-from <netdev+bounces-296652-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 18:11:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 757D265889D
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 18:11:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=NbD4Jpuj;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296652-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-296652-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EBDAD310F78B
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 16:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB03633064A;
	Mon,  8 Jun 2026 16:01:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EB532FA2E
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 16:01:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780934463; cv=none; b=IQkpJDtzSDGiSZjBrqu1OdxGPRl++xeXjY+Qjs8f/TYhCSsm96kQdyRZaVqhQp8ewiE7SQWZVhiDAmVgTZ4LPzmjh10pQIdTEP6urVz+eFudO0R9M4r70k3TjU7OzL+TWi9z+KBhc/OXWRLvX7He2aASVQX4JA3saoNfZhVoNZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780934463; c=relaxed/simple;
	bh=Ts8u5y43FkUxGVOnBltJQb/YAn0hirg3J7c793j5p54=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m9CZEcCtkcBSi8cG+oDv9fWxOJACaWA52xJdg2+2hIcibNfezbkwIkaF7Rzeg95O96ARx9BiTwONWIfascr6Jhf8Zy2JfprdQRSRR/6j3HaVk+S2zxx6mStqKoljCHxys26nCRm5rXIdzdN9Pcpq5JKaJi2KtRZRl9wC4iUU33c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NbD4Jpuj; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33D961F00893;
	Mon,  8 Jun 2026 16:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780934462;
	bh=Cd+2dTQEsuVtmckVeu5cIadqjrd3NxxW5x6IS+111+M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NbD4Jpujgo+tgnMDUDiZ7fr35vlavVwjfHf/nNm84/7nYtp2+0uEziuYySI39Jy9F
	 nC8ehpQ+rM09jAvhF/SlJgUQqrG+rGUoKA/V9LVR+DfbER4S8yU0bpsXI7rfwImkui
	 b6QCrh79b9IZ0t2syjOiCCJ9pbddWdEHKGjFwyH2xx+X5tD6DAWv6pbUIpnz/06hAX
	 Hr5rZnRfLJ2I+OzemIebZZBaOcE+Fylm98Bwaqsff5NerKFW7BvF6lwIVTWBdvzeRw
	 eHmoMLSXbqpuqAvXVRl4qcJDlw8LSdUizueE5n7gJRm2Wf2hHgyde7MjFlZY8l3GUj
	 yiLJ+jlH+qP+g==
Date: Mon, 8 Jun 2026 09:01:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Kuniyuki Iwashima
 <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot+381d82bbf0253710b35d@syzkaller.appspotmail.com,
 syzbot+3479efbc2821cb2a79f2@syzkaller.appspotmail.com
Subject: Re: [PATCH net] net: watchdog: fix refcount tracking races
Message-ID: <20260608090101.42b9f43c@kernel.org>
In-Reply-To: <20260608123935.524879-1-edumazet@google.com>
References: <20260608123935.524879-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296652-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,redhat.com,kernel.org,google.com,vger.kernel.org,gmail.com,syzkaller.appspotmail.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:pabeni@redhat.com,m:horms@kernel.org,m:kuniyu@google.com,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:syzbot+381d82bbf0253710b35d@syzkaller.appspotmail.com,m:syzbot+3479efbc2821cb2a79f2@syzkaller.appspotmail.com,m:ericdumazet@gmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev,381d82bbf0253710b35d,3479efbc2821cb2a79f2];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linux.dev:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 757D265889D

On Mon,  8 Jun 2026 12:39:35 +0000 Eric Dumazet wrote:
> Blamed commit converted the untracked dev_hold()/dev_put() calls
> in the watchdog code to use the tracked dev_hold_track()/dev_put_track()
> (which were later renamed/interfaced to netdev_hold() and netdev_put()).

selftest kernel build says:

net/sched/sch_generic.c: In function =E2=80=98netdev_watchdog_up=E2=80=99:
net/sched/sch_generic.c:594:39: error: incompatible type for argument 1 of =
=E2=80=98IS_ERR_OR_NULL=E2=80=99
  594 |                 if (IS_ERR_OR_NULL(dev->watchdog_dev_tracker))
      |                                    ~~~^~~~~~~~~~~~~~~~~~~~~~
      |                                       |
      |                                       netdevice_tracker

config:
https://netdev-ctrl.bots.linux.dev/logs/vmksft/forwarding/results/682182/co=
nfig

