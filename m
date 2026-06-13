Return-Path: <netdev+bounces-299060-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TsjREGLSLWqckgQAu9opvQ
	(envelope-from <netdev+bounces-299060-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 23:57:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F01767FD6D
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 23:57:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=fTwZKeFv;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299060-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299060-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 48F6F300291E
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 21:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295E03A5443;
	Sat, 13 Jun 2026 21:57:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D433859DE;
	Sat, 13 Jun 2026 21:57:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781387868; cv=none; b=RIyBDNhCCU9EafcpMDK8ASsXJLrmsVSI6jeT1m5lwNUb2MyG+a7n4kaZwK8j02VqTV6DMeGnKc5Mtt6XTkFlmOA5zzWI4wItHM6ZFNr3+n9OWM+LDaaHD7U9Idcw+yg1b3WQDdgsUidn6CUW84CDtUNZw9BttYZY1h2LWLB0PQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781387868; c=relaxed/simple;
	bh=6NQ2s0f/MOg3LP4SOx5Sg5CMSqdXSNQtJ7rh0ggzxr8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YgsKAVu86bWvG1MJXbMwjc9amJ82mqd1npLp8A+QE7+ZCYLAFx4EwTdBk9vJowDvL4NiRNSZ+S7ikWx23UhLkbdplHRUWSBGoYf591LvjvwJOLTWb9DTIkcZ3tlXokRsykovACcgkwkWgYc9kb4JcRIR58a5hkpwE8vIHrfC/bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fTwZKeFv; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DFE91F00A3A;
	Sat, 13 Jun 2026 21:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781387866;
	bh=X7e2OPAFhMbwhdtXfMUgF9EH5ALpvDIAwiduKVL6wfo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fTwZKeFvDUxPQnLiSJVYyon5k4ZkAkZEQOEAmoVguxzYGnyKGuPQUsv/QkBWKm0tU
	 0+C0kjOd4nkeKJ4iFWOWtSlAlmqJGIudZev8X8w8/jvoj26XcW/RU03e532G6ulLaN
	 VdDJ29oFZ8XFXBMZZ8lJpAd3xliC685Hv/uBvVPO4eEq9WIKVvFv3LtAnirCvo8vVp
	 1V4qnDY70G+lgpX/0qAkm+U+HmN68TPcE9j+3K+JuIgONAviaF8pkmZaqtXM6Jg9Y5
	 JeRnXNWIa8FclvmuzPBUjfifhegO9jAqsLjPVQNxkFOQlmT3/sOhwg/CQDVWJMbgDg
	 Ul+mW0H9V1JzQ==
Date: Sat, 13 Jun 2026 14:57:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: Doug Berger <opendmb@gmail.com>, Florian Fainelli
 <florian.fainelli@broadcom.com>, bcm-kernel-feedback-list@broadcom.com,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Justin Chen <justin.chen@broadcom.com>, Ovidiu Panait
 <ovidiu.panait.rb@renesas.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/3] net: bcmgenet: collapse TX priority queues
Message-ID: <20260613145745.36c5403e@kernel.org>
In-Reply-To: <20260612205915.3156127-1-nb@tipi-net.de>
References: <20260612205915.3156127-1-nb@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299060-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:nb@tipi-net.de,m:opendmb@gmail.com,m:florian.fainelli@broadcom.com,m:bcm-kernel-feedback-list@broadcom.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:justin.chen@broadcom.com,m:ovidiu.panait.rb@renesas.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,broadcom.com,lunn.ch,davemloft.net,google.com,redhat.com,renesas.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1F01767FD6D

On Fri, 12 Jun 2026 22:59:12 +0200 Nicolai Buchwitz wrote:
> Tested on Raspberry Pi CM4 (BCM2711):
>   - Ovidiu's reproducer (iperf3 -u -b0 -P16 -t60) no longer trips
>     NETDEV_WATCHDOG.
>   - UDP sustains 956 Mbit/s line rate over 60 s with 0 datagrams
>     lost (0/4952890).
>   - Single-stream TCP throughput unchanged at 943 Mbit/s.

Of course it has no impact on a single TCP stream test, since TCP
stream can only use one queue. If anything it should help.
The testing here is not very convincing. At least install a realistic
qdisc (fq/fq_codel/cake) and run multi-stream test with multiple cores?
What's the CPU idle delta in such a test?

The reason for this change is not coming thru from the submission.
Ovidiu's patch makes much more intuitive sense. I'll apply that,
please rebase.

