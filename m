Return-Path: <netdev+bounces-297337-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id avbDOpaVKGokGgMAu9opvQ
	(envelope-from <netdev+bounces-297337-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 00:37:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A006A6649D2
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 00:37:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=UQRVuGae;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297337-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297337-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1FB7C311A3EE
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 22:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E1A4071FE;
	Tue,  9 Jun 2026 22:27:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D50B30C629
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 22:27:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781044027; cv=none; b=nFttqrNefkUHAStchK/XyuXsHxOVAJ4id5bokjSSa7YlX7ITKkkvg2A9uYLRNGhWSPvN/tvmNSeByKT6KivvO3urDXnFCWLqv7hK93OpPuhfVfaVtUOEAR6w8+Da67ELL1nMLoBVVoLAJU33xNee/AKVHreYoen+G2e34XAbYgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781044027; c=relaxed/simple;
	bh=t8IXsILI7McNhKssp3rbCYyBlz/RIsjszHWT6+rInME=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O92NBJTx5+hZHRuQIUY2BayljsCRycdKxnnRSV895Ym0Cucj+T69Uo69iI8ag12OU4snn45oztpYys1yhFDHm20/0HbZHXP26lV+0tz1ZnB5iwZ+uRozeaocCxfs3hNdPrCAZugvPXMHdiXmeuDNVkPXRgJ261UQtBII3U2WMvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UQRVuGae; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A59681F00893;
	Tue,  9 Jun 2026 22:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781044026;
	bh=t8IXsILI7McNhKssp3rbCYyBlz/RIsjszHWT6+rInME=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=UQRVuGaeqx3lcHnF2uQpfJKWslZYLrsn3LTqktd1vKqypjM4LB6jbcrtbYI694NpN
	 SH7Wivy4Ptqn2vbCQtYcZo/+gN3PpDXDc6havEbTmuyF4B1A2SsJyrkv3AonJvOlns
	 pfc+nBu4HHwscYx14Mq4N6MXQs41yxDA5jYXHDrePRW5UINDc3AozJvj96QZc/zPn+
	 GVupljhAfYwQA444sMfiOoPAhlKGR8joh9/xcVzGITkQTDVRNc6C35VUENvX0wNuaO
	 HrZgj136XvR4xuaGi+8yyvupgxvBwdimqfCGXlXpp80C9SxnjzHkm5aj8Jhg9XYVvj
	 KH0CJdWCpS7OA==
Date: Tue, 9 Jun 2026 15:27:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mariusz Klimek <maklimek97@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, pabeni@redhat.com,
 dsahern@kernel.org, idosch@nvidia.com, ncardwell@google.com,
 shuah@kernel.org, kuniyu@google.com, alice@isovalent.com
Subject: Re: [PATCH net-next 00/10] tcp: support non-GSO jumbograms
Message-ID: <20260609152704.2512ce9d@kernel.org>
In-Reply-To: <715cf429-9f2b-4898-84b4-15dfba4a9a8e@gmail.com>
References: <20260608130755.5626-1-maklimek97@gmail.com>
	<CANn89iLjG0krEoEE__3KUrcK+ZO+USZRC_2qZV5hAsxRpkTmhw@mail.gmail.com>
	<715cf429-9f2b-4898-84b4-15dfba4a9a8e@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-297337-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:maklimek97@gmail.com,m:edumazet@google.com,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:pabeni@redhat.com,m:dsahern@kernel.org,m:idosch@nvidia.com,m:ncardwell@google.com,m:shuah@kernel.org,m:kuniyu@google.com,m:alice@isovalent.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A006A6649D2

On Tue, 9 Jun 2026 19:01:02 +0200 Mariusz Klimek wrote:
> I understand your concerns and they're reasonable. I would still like to
> proceed with this series, though. What can I do for you to consider this
> series? Would it help to submit a few less-significant patches first before
> resubmitting this patch series? Should I resubmit it as an RFC?

AI tools changed how much we value code, but they did not change much
about how one joins a community.

