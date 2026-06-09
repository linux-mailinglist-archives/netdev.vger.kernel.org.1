Return-Path: <netdev+bounces-296862-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WUlWGwt4J2oDxwIAu9opvQ
	(envelope-from <netdev+bounces-296862-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 04:18:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 04FE865BD57
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 04:18:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=djnXbKzf;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296862-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-296862-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 728DB3030516
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 02:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C782C11C6;
	Tue,  9 Jun 2026 02:18:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE16C1A9F83;
	Tue,  9 Jun 2026 02:18:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780971527; cv=none; b=nFJf3jdOJe29ygB+XRjxJZVK/UEDjtfIufHrjxmvVjE9N58cGAwkbrMhlsByQ8siM+vqZuKUKfA7sCSivnyUkYfRb5DfwtzHZYdbHdOu1m9p9NlBBhHvNVY1KqJGvc2fq9RcBhXNsNYY2dau6mzIdnKRqIqEpBRmm0NpdrduGGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780971527; c=relaxed/simple;
	bh=I9U9k115McmluyRZ0AfqMeLOQM9cvy+nwwPqE5zOj3g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hvY6g9Jt+xmmxkqONeTos6UgMap4Jz3IxNJ1QjDo/5hyrl+SzWxzH2Dh/sD/ngixR3zoBFCvo+A/nPDn3uHoG41ccZlggEPw/PWK5TB7kxZ/hLaPSuApwKr1jClQ+LxhuOb7g7qs8JUfFnjBuEqiYmV8Y8AVprLRlDHQt8zqBuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=djnXbKzf; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E5771F00893;
	Tue,  9 Jun 2026 02:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780971526;
	bh=JtOK+WsH59Rk12yQhjznrdMTBaRsxDtA5Omclm8PG6A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=djnXbKzfJR1ud1CIL3l7DpjvCirULDD5+gqLNT+/faeWOf1sxmuHwgM+SydH3CFM7
	 86vAZRsqj6osWRQUcYujMXk06YwApWRCNlrC6bNMH9r8dqUK8g1lqjAJN/4YqAGOLj
	 ePA82mbs5rgA+gva4fhRqvi05uh1GlGuy3ncmblg40BfH3BJVZmP/IRddsxYiFwzg5
	 8HjtuHMAqw1eEGWra2waWqycISoa6a2y8e60mCm3NL/UVgfJRBLlfWOIKoD62/Pq0u
	 LzQyT7p2WFU2N4vIEN38WvfHLElBKN6ATTW0qs78KV1vU0XY/Rk3x7xQqhQfD8rl9/
	 elICtMxfkeSbw==
Date: Mon, 8 Jun 2026 19:18:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Samuel Moelius <sam.moelius@trailofbits.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, netdev@vger.kernel.org (open list:TC subsystem),
 linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH v2] net/sched: act_pedit: require matching IPv4 L4
 protocol
Message-ID: <20260608191845.72e968b7@kernel.org>
In-Reply-To: <20260607193621.1057618-1-sam.moelius@trailofbits.com>
References: <20260607193621.1057618-1-sam.moelius@trailofbits.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296862-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sam.moelius@trailofbits.com,m:jhs@mojatatu.com,m:jiri@resnulli.us,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 04FE865BD57

On Sun,  7 Jun 2026 19:35:46 +0000 Samuel Moelius wrote:
> The extended IPv4 L4 header mode in act_pedit can select TCP or UDP
> header fields without confirming that the IPv4 protocol field matches
> the selected transport header.
> 
> That lets a rule written for TCP or UDP modify unrelated payload bytes
> in a packet carrying a different protocol.
> 
> Verify that the IPv4 header is long enough, that the protocol matches
> the selected TCP or UDP header, and that the packet is not a non-initial
> fragment before applying TCP or UDP extended header edits.

This is a hardening patch?

It doesn't apply to either networking tree cleanly, please rebase on
net (if it's a fix) and net-next (if it's hardening) and repost
-- 
pw-bot: cr

