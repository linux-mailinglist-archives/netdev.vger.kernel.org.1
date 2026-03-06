Return-Path: <netdev+bounces-264913-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBRmM8Y/q2mebgEAu9opvQ
	(envelope-from <netdev+bounces-264913-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 21:57:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 381BD227A8C
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 21:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0836E301DF5D
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 20:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D55F46AEC5;
	Fri,  6 Mar 2026 20:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NhHY0bt+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0E7211A05;
	Fri,  6 Mar 2026 20:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772830660; cv=none; b=ngztRpr80Hd471gNlUJ9BEFKoZq4KiOXu3IqVupf7xTbF6RJtgzrPSUco+NVoghbreD68rzY0dE7rinCTgNlNzbGRYQMhAR9VKZMJGf289HoE8qMr8eYutTv134uKugLvVuN0LLHcZcWHUkTSIWd6xPR0U5iO7jKjr9HxSqao3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772830660; c=relaxed/simple;
	bh=maChXA3sdH0SMYvMxQthAI/tM5iNsuyzsBJGVckJJEM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O4nLBi4tH5iht1qo0eeuNjTaQhpz4zCu2rr7ZxkoTd5jW1/hZGEWG7S+sKaSls7qbJxCYhi1y0zii9DaW3w/zyrK7P95XjRI7f+U5vDdoQAuq34ioT4EVKxWiXiOKPATin9B/gBVZg7+buoz5srcyHh4wfzu3Z5mhxNEvwmipvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NhHY0bt+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C914C4CEF7;
	Fri,  6 Mar 2026 20:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772830659;
	bh=maChXA3sdH0SMYvMxQthAI/tM5iNsuyzsBJGVckJJEM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NhHY0bt+zwzDxQWr5k7r8zCDjy4Ruo15GISNYpajSZawgQCMRi5+Z3dmohhfaM9VO
	 LOKrDAifRqUil8dK0e2VIe3XWHgU6CirO5oPFJlQx4crPj/CJdHmBeDsd7Sn+TBUyP
	 1PQ92IXCjxFu8N7icnN/tUWNMK/AZ5KpgTm/h8hMTdl+QlUd362DdAth4FEXlZ/+6g
	 J4b3OblFmT3MPJ41T9PwB4uqRG2k5JjN7Cf8iNfDBtvhd7k4JVCOsbRLmIkho2T9AL
	 CqK6zDaRIcpbc6tltuc+tqPuPxuAmA6NI/9deqnAc2pWIv5lsCvQE0uVWX6v/RjYPz
	 xa4Dvdb9x93Ow==
Date: Fri, 6 Mar 2026 12:57:38 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Ralf Lici <ralf@mandelbit.com>, Sabrina Dubroca
 <sd@queasysnail.net>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, linux-kselftest@vger.kernel.org,
 shuah@kernel.org, horms@kernel.org
Subject: Re: [PATCH net-next 5/9] selftests: ovpn: add notification parsing
 and matching
Message-ID: <20260306125738.73a17bb4@kernel.org>
In-Reply-To: <b3197cdc-83db-4739-966c-018f8570070d@openvpn.net>
References: <20260304230643.1014-1-antonio@openvpn.net>
	<20260304230643.1014-6-antonio@openvpn.net>
	<20260305191732.2bbc386b@kernel.org>
	<b3197cdc-83db-4739-966c-018f8570070d@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 381BD227A8C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264913-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.976];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[requirements.py:url]
X-Rspamd-Action: no action

On Fri, 6 Mar 2026 14:05:53 +0100 Antonio Quartulli wrote:
> > There should probably be an else branch which prints some kind of
> >   echo "SKIP - requirements missing"
> > 
> > Your requirements.py script prints stuff but the output needs to
> > contain the word SKIP  
> 
> If "has_listener_requirements" is false, the test script still goes on, 
> but it won't check the received netlink notification content.
> 
> So we're not really skipping the whole test, just one specific check 
> that requires extra tooling (which is normally found on all standard 
> distros).
> 
> 
> Do you think we should rather SKIP the whole test so that we can easily 
> spot that something is missing?

No strong preference. But speaking speaking just from the netdev CI
perspective it's probably best to report SKIP and then keep going.
The system does string matches on the output. If we report FAIL after
the pass it will show as FAIL, if it's SKIP + PASS the report will be
SKIP.

