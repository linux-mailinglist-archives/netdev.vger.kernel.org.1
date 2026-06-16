Return-Path: <netdev+bounces-299701-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kzkSGAysMGp5WAUAu9opvQ
	(envelope-from <netdev+bounces-299701-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 03:51:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E8CBB68B579
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 03:51:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=K6GDSa8K;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299701-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-299701-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 53F6A300D1F8
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 01:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F0D322C88;
	Tue, 16 Jun 2026 01:51:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7D11A6803;
	Tue, 16 Jun 2026 01:51:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781574666; cv=none; b=OZlIWd6E85Y7oRXhJu7bwtdZKjQNBbDEjfbTglwdDiWpZBEwNXHV52vS9T3PQY6QBKdNyIG2j2TMnCzzT4aVfAfSNHu4hjlylaDqJHNCEfrLdXQ1Zyp8PV7t6ISQ+GqGZm8BSNp+3IvBJRUAZSw82nc0wFprjP34AylSJjAHVdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781574666; c=relaxed/simple;
	bh=InAN/+DXK/W8cGxVM14K0cOGH19NXi2V+PoPTxMMu+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JE0e4BqAuNgDHazTWiE25c61OiOXKaUKnoKAzX+H56Fd3eIFyHrpd+bm1ZxUxQ66g9E4LFeJNhzNfvwzgkYowTkjWBzGxJrj2sW7U5iqtaFgau85OcR33EUdTzNBazB1fFNszw5TRd31Z9uZFSwqZ1xt61YKCEig41DnSyciaVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K6GDSa8K; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CE041F000E9;
	Tue, 16 Jun 2026 01:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781574664;
	bh=D+B8b6zPxSJYJnAx76A6cpDHQqIWvpo+XApfG3oadEM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=K6GDSa8KRhY1gMm3/n1ZAjAbzfA77wCPtlo0jpGzxHWcYOHj+NUBo9O+l5nfY357w
	 kQ+E5OeKqy0NKB/zPdTXarsRj89QO85Fz/JxpaBLXFZnXndD3v2m4s/ul+q36gALaf
	 t0KQeoWPX/TNYXaGvdoQO5poj/bM6j7BhSJkx3qEzJbmK+G3mYUzjgmO1Dt4F5GqoR
	 aWLwL3PBo0TGERjP+Zd1g2UtNPDK5tSu/Z1u1SK30zaWnkTu2IqtsLNbboEgp8nIgk
	 SwhUe3zF6ZsKiiQeLrpqq6qUU8zZSG2Tddy45ynI6NjLGXkiK4ZDN+0B523QWlS7JL
	 ubDpzJeRMq3Gg==
Date: Mon, 15 Jun 2026 18:51:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: edumazet@google.com, ncardwell@google.com
Cc: chia-yu.chang@nokia-bell-labs.com, jolsa@kernel.org,
 yonghong.song@linux.dev, song@kernel.org, linux-kselftest@vger.kernel.org,
 memxor@gmail.com, shuah@kernel.org, martin.lau@linux.dev, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 horms@kernel.org, dsahern@kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, jhs@mojatatu.com,
 stephen@networkplumber.org, davem@davemloft.net, andrew+netdev@lunn.ch,
 donald.hunter@gmail.com, kuniyu@google.com, ij@kernel.org,
 koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com,
 ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
 cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
 vidhi_goel@apple.com
Subject: Re: [PATCH v2 net-next 1/1] tcp: Replace min_tso_segs() with
 tso_segs() CC callback for TCP Prague
Message-ID: <20260615185102.5e8de52d@kernel.org>
In-Reply-To: <20260614071756.239686-1-chia-yu.chang@nokia-bell-labs.com>
References: <20260614071756.239686-1-chia-yu.chang@nokia-bell-labs.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299701-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:ncardwell@google.com,m:chia-yu.chang@nokia-bell-labs.com,m:jolsa@kernel.org,m:yonghong.song@linux.dev,m:song@kernel.org,m:linux-kselftest@vger.kernel.org,m:memxor@gmail.com,m:shuah@kernel.org,m:martin.lau@linux.dev,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:horms@kernel.org,m:dsahern@kernel.org,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:jhs@mojatatu.com,m:stephen@networkplumber.org,m:davem@davemloft.net,m:andrew+netdev@lunn.ch,m:donald.hunter@gmail.com,m:kuniyu@google.com,m:ij@kernel.org,m:koen.de_schepper@nokia-bell-labs.com,m:g.white@cablelabs.com,m:ingemar.s.johansson@ericsson.com,m:mirja.kuehlewind@ericsson.com,m:cheshire@apple.com,m:rs.ietf@gmx.at,m:Jason_Livingood@comcast.com,m:vidhi_goel@apple.com,m:andrew@lunn.ch,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[nokia-bell-labs.com,kernel.org,linux.dev,vger.kernel.org,gmail.com,iogearbox.net,redhat.com,mojatatu.com,networkplumber.org,davemloft.net,lunn.ch,google.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[34];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,nokia-bell-labs.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E8CBB68B579

On Sun, 14 Jun 2026 09:17:56 +0200 chia-yu.chang@nokia-bell-labs.com
wrote:
> This patch replaces existing min_tso_segs() with tso_segs() CC callbak
> for CC algorithm to provides explicit tso segment number of each data
> burst and overrides tcp_tso_autosize().
> 
> No functional change.

Eric, Neal, looks good?

The min rtt thing in tcp_tso_autosize() helps a bit but if the sender
gets congested for a longer stretch min_rtts on new connections are
high and we're back to sending small TSO, keeping the sender overloaded.
Which is to say - I _hope_ this also solves some of Meta's problems :)

