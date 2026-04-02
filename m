Return-Path: <netdev+bounces-274584-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Ow2ArKCzmmWoAYAu9opvQ
	(envelope-from <netdev+bounces-274584-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 16:52:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B35DB38AD63
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 16:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AF6463039F65
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 14:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3DDA3ED5C8;
	Thu,  2 Apr 2026 14:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d8dAl7TZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10BF230BDB;
	Thu,  2 Apr 2026 14:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775141139; cv=none; b=uxHXFgZ+fZAmhwzQXgzQ07/7bItuU6MaeZxYdESxLwhHLxjbl+wiaEECuMUAqFPkO9GyHU/n3SKPRWR+nXUaNLgBtCUkwssGzRZQy7gTxlq8XuBDYEhaPQZDZthL2/dfd9ykQcdPJFfqx94oI9RaeNydh2LBVuHfBlwecx7bKt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775141139; c=relaxed/simple;
	bh=gvCF29bUCHwJ9Lg/NWYbhStqBZr2WqLBc0/ROdoowB0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A5FO9fIUoJcWh6EPdw6TNQqCu8ivDAzjrLt+nfxGk/KsdRXtumgNE+S/nGO/QdWnxR02Z3ZZn8afhcGFxyqe+xIzL3ZChD1tYQRVyaqjpDpviurG7m2REkdixm0bEvdrJNhEeIyK2OVgtA8fLNu794Xfz8WOEkamSbqmoCbl9x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d8dAl7TZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D46CAC116C6;
	Thu,  2 Apr 2026 14:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775141139;
	bh=gvCF29bUCHwJ9Lg/NWYbhStqBZr2WqLBc0/ROdoowB0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=d8dAl7TZHveZA/z6CpPKuclkcdN1PUljky7NtRixAkyMuOQx/1I+zduCy5FC45D5b
	 K0qeCzS5Vioo1v189C0154q7fr0AU48cO9wtKmxP0m+lTa1RiLVqeIRma7ZSeCL4r1
	 XpOO3Z0c6jCuuKPT1WKHcEqdAzyhZA74kwqfmCFE5aRHdjQ6Tb6bhmxsHm7rBPpJ0X
	 yvaxRn7vw7rrZKocFpS4OqOwqJ7ipzuvAzL4Ii9zIqKzsaSg/KpiyFg4pl1KaktBsD
	 JXZB0mq/OtHMQVuXeFVuc9MHPuN5hC2Pd4qC4h376ayb6s9P66SqI1LMJDFFTo4Bdi
	 /IkKtvP1IUXJw==
Date: Thu, 2 Apr 2026 07:45:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Marc Harvey <marcharvey@google.com>
Cc: Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
 <shuah@kernel.org>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v3 0/7] Decouple receive and transmit
 enablement in team driver
Message-ID: <20260402074538.205e307c@kernel.org>
In-Reply-To: <20260402-teaming-driver-internal-v3-0-e8cfdec3b5c2@google.com>
References: <20260402-teaming-driver-internal-v3-0-e8cfdec3b5c2@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274584-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B35DB38AD63
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 02 Apr 2026 06:24:13 +0000 Marc Harvey wrote:
> Allow independent control over receive and transmit enablement states
> for aggregated ports in the team driver.
> 
> The motivation is that IEE 802.3ad LACP "independent control" can't
> be implemented for the team driver currently. This was added to the
> bonding driver in commit 240fd405528b ("bonding: Add independent
> control state machine").
> 
> This series also has a few patches that add tests to show that the old
> coupled enablement still works and that the new decoupled enablement
> works as intended (4, 5, and 7).
> 
> There are three patches with small fixes as well, with the goal of
> making the final decouplement patch clearer (1, 2, and 3).

Sounds like Jiri asked for changes, when you respin could you run
shellcheck and clean up the warnings? We ignore SC2317 SC2329 FWIW
selftests confuse the checker.

