Return-Path: <netdev+bounces-297320-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZUYhIJyMKGpDGAMAu9opvQ
	(envelope-from <netdev+bounces-297320-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 23:58:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 30446664657
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 23:58:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=diWE4W+L;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297320-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-297320-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C1FD130071FE
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 21:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56094C6F0D;
	Tue,  9 Jun 2026 21:58:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42093EB107;
	Tue,  9 Jun 2026 21:58:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781042329; cv=none; b=hOpoY6iDbuUaY2MG1PbuGKjEHHnwGqIwNzzadh/EcILNSeZ2sfIXZ1Q9WULOMYtZ7cmRqRicXzJ4C20fgcwPTW0+giqbwYcalgq92sdkN5q2HEa6pvpztJhCzN7ycH/in0FrS9jTskXNhq1Mzf9wK7Fm5x/lJ+4INuEZ0LqC/E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781042329; c=relaxed/simple;
	bh=uYgbcY09GqZtU3jLp2xVFHwFduSa+bi462BtQuxERkE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WYY9WAJf7+6vb1mwcnJ2Zk8MuYsQrLJMtz0dPtDaYlZ6A/Vu0mUpyPH49G8OpMWqBhd+fjnIAsiYIY4v/o2SqHFJeDDj1uqYymmsj/ISXSwTO3n76QotM47NMahg+8Z8Kw46CNUEHm5MA88zFTrM/0jTYXj+A/VyforGeO1DPCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=diWE4W+L; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 598661F00893;
	Tue,  9 Jun 2026 21:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781042326;
	bh=79L0Owc0rw+517WX6RX3SV/gc6w/+G6+e4h3Uz7/jbQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=diWE4W+LxUCuXT00sq+lPGr79NF3C4wI5JoJtL4NpLZqnER8f1g6AH7VYqJ8eKiwV
	 NJmvRKglJVQ4ncyd5L38EMkvd/sw9qTahaOHRhNHyM8bbucO6mWkigNab2p4bdmoUO
	 QrYwjrN7zbmmKAmFvprO87g7VX7vAPaqiNPabk2FILqXingayYGGRzvYiK7TE/QH1L
	 8ZaHBD0F9kwzBXAXCdyfWKmOOa/7aMqGW3Zii4hVysyM6U2G05wTwb0En29+2BswTU
	 WHYxY5hVoQ01Hm7r8/qCrCpfjpvlmhRWDrJ2/wntyWkG/VdZnWz3SwPtV4BCYhW93S
	 dBV/YTzeDEkEw==
Date: Tue, 9 Jun 2026 14:58:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sechang Lim <rhkrqnwk98@gmail.com>
Cc: John Fastabend <john.fastabend@gmail.com>, Sabrina Dubroca
 <sd@queasysnail.net>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Jiayuan Chen <jiayuan.chen@linux.dev>, Alexei
 Starovoitov <ast@kernel.org>, netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] tls: fix use-after-free in tls_sw_sendmsg() cork
 error path
Message-ID: <20260609145845.2ce5517c@kernel.org>
In-Reply-To: <20260605214802.1647008-1-rhkrqnwk98@gmail.com>
References: <20260605214802.1647008-1-rhkrqnwk98@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-297320-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:rhkrqnwk98@gmail.com,m:john.fastabend@gmail.com,m:sd@queasysnail.net,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:jiayuan.chen@linux.dev,m:ast@kernel.org,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,queasysnail.net,davemloft.net,google.com,redhat.com,kernel.org,linux.dev,vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 30446664657

On Fri,  5 Jun 2026 21:48:00 +0000 Sechang Lim wrote:
> Subject: [PATCH net] tls: fix use-after-free in tls_sw_sendmsg() cork error path

This patch has already been proposed, it's not enough and there's no
clear path to fixing sockmap + TLS so it will likely get de-featured
soon..
-- 
pw-bot: reject

