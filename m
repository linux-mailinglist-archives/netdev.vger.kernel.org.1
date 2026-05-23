Return-Path: <netdev+bounces-290991-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IG53Djr6EGqJgAYAu9opvQ
	(envelope-from <netdev+bounces-290991-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 02:52:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B3CB75BC378
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 02:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65DB63008D35
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 00:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA38623EAB4;
	Sat, 23 May 2026 00:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xun0RiVp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6DB232395;
	Sat, 23 May 2026 00:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779497175; cv=none; b=Ts5fd+Egz2vT84HYhxXs0ZKzyHRwN13+jmSTrGgBtFUBTF4wGzFDiklIscfMOSlbwNDHmxI/fpkX+yp9tV88G8RI35cyRSORW6jFNziimCD/6jvUupLPW3lDgSr1lZUO4dYUJrQdT7dkTWKKm+IZeCTb4e/MSP7qCFbELEp1Mhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779497175; c=relaxed/simple;
	bh=Bleb7k56b+4cMT7uKTpy+AKd66w5NzGY2kkD3byUJUc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kV8jZ9AGoJ9hoabbFQ9an5x++6vUECRbYkQ9RYpKGmO5j1WKoo57TysurvhcBaOsZdYrt6ACKUdWWWTAwZ5YiaZzkvvbWAN84KiE0nDXXKimOvrqq6CGJ80h+s+OMIzpQWDx0kzuaeR3B0pG4elfp2t00VUtmoMPSp6E8nDbnPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xun0RiVp; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA2DA1F000E9;
	Sat, 23 May 2026 00:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779497162;
	bh=+0zxxmj97DeONwxwO9NqvLg1+7+0bBK+fcVh/Ly0R8c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Xun0RiVpKi8STCl2CzsPXL5xAre7C60eBE4mWImCc6JUdgHd+CFqk/J3IJPscFQz3
	 ZgLHn3WrpQNRxoGVYPFk/nrDTM+59cmlpGMiK0C/rKJkaBZ7Kf0xqjH6lnO26zzH80
	 qXQbfZldOHGjZxd/+KQD1t+3WyFvpggNvDVaJrLUsyXIi6WKqKl0Bijq+AmGHk+2QM
	 odwZWJucibSlIPZM+pz4jS1UsYB0JGFkJ9LwQCz8c3BfzH50xjBvxBq3V9JSPg3IMb
	 xKtQ9gQ6xnLZmJfweyXnQ6HxAp6Zdek+xrWMw0a5PZmDuKjMZOeRiW+oD6TEghPnEp
	 NBtUMiAxsnP3w==
Date: Fri, 22 May 2026 17:46:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Allison Henderson <achender@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com,
 horms@kernel.org, linux-kselftest@vger.kernel.org, shuah@kernel.org
Subject: Re: [PATCH net-next v1 0/3] selftests: rds: ROCE support follow ups
Message-ID: <20260522174601.3c2c2b46@kernel.org>
In-Reply-To: <20260522215430.3748226-1-achender@kernel.org>
References: <20260522215430.3748226-1-achender@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-290991-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B3CB75BC378
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 22 May 2026 14:54:27 -0700 Allison Henderson wrote:
> This is a follow up series to the "Add ROCE support to rds selftests"
> series.  The first patch renames run.sh to rds_run.sh, and also adds
> two wrappers to the TEST_PROGS target to run the same test over the
> rdma and tcp transports.  The wrappers rds_rdma_run.sh and
> rds_tcp_run.sh also provide self-describing names that appear on the
> netdev CI dashboard.

Could you make the RDMA test return XFAIL rather than skip when RXE
is not available? We try to use SKIP for cases which are easy to
fix, like a tool missing. We won't be running RDMA tests in netdev..
-- 
pw-bot: cr

