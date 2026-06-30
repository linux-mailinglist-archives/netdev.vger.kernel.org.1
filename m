Return-Path: <netdev+bounces-303207-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JEGsHnnOQ2ociwoAu9opvQ
	(envelope-from <netdev+bounces-303207-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 16:11:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5456E541C
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 16:11:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=debian.org header.s=smtpauto.stravinsky header.b=aJ+v0skR;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303207-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303207-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=debian.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C18053176E29
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 14:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF2F366566;
	Tue, 30 Jun 2026 14:02:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F5027F18B;
	Tue, 30 Jun 2026 14:02:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782828154; cv=none; b=H5ZeVOtiHZfpt+Orqhpcirt05Sp8HwgsEsFUPP28E5oufY3RZxDoHRViIHs/c4iSKMvj7Xo8XBxpGsZv3a7se0ArB0TThWkTajj0sCsXdCt2YScmCLTPaDyU0XFgZFo4xMSlAanRALoa0zpJM/b0IUTlKqrUjM+OAsBLxmZVxfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782828154; c=relaxed/simple;
	bh=fqTU4/K/Iv8YOXJm3+e+VaXEXcAUpKWwmWM9YUzs37Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UAX6ataiu3XXaJeG9/6KrdUUc8vEx60YntMgDRGUmaFAz6qyJ3nceoLLmDFjQQc+zdwZQ8/bVBdG7+wNcrJLf8L9HqnmSrGljt6ntWh93qa6W24xKd3nirYAazZSnq23mUMS7BcljCJphX+THdxyLfnKtSnhQyLrUizo/3XdHk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=aJ+v0skR; arc=none smtp.client-ip=82.195.75.108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/UZaRDcSeUBWPt64bwzhrjjDlBydxHm3hhbAzvzbKaQ=; b=aJ+v0skRXNh4rdadvMtsAUoTHV
	El8OK1LveIjd8nRCLMRQCIWjxDbuTyYwb5VtbMZpu1JSJgXdhdO/ALZPvpR23mha62WiSV5sqJUSQ
	E7P5+e35d9uzWqp06OTFk2Vlj/vWxX+fq2qZHYUhtEuXcEOdkE4N8dQT/wTU7Ukw4F/ygIn/zJ3ir
	f3rknsu9I1Omb5J29bQdj49CtLcBT9Ju9Risgsjcb41TsCd7LlQKTTGxkbGE7m1chEXN567mj1/tx
	WZTl9iqSvEzGQCQKEWHye9RUcfdLDAPLXl3GWomS7eeKfD+YZyQE7ngUXeWCub+CSaDvcHzJlWnT0
	KN7NrifA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1weZ2j-0077JK-0U;
	Tue, 30 Jun 2026 14:02:29 +0000
Date: Tue, 30 Jun 2026 07:02:24 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org, 
	petrm@nvidia.com, dw@davidwei.uk, noren@nvidia.com, gal@nvidia.com, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net] selftests: net: bump default cmd() timeout to 20
 seconds
Message-ID: <akPMZHpYV-eyl0oa@gmail.com>
References: <20260629233348.2145841-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629233348.2145841-1-kuba@kernel.org>
X-Debian-User: leitao
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303207-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:shuah@kernel.org,m:petrm@nvidia.com,m:dw@davidwei.uk,m:noren@nvidia.com,m:gal@nvidia.com,m:linux-kselftest@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DB5456E541C

On Mon, Jun 29, 2026 at 04:33:48PM -0700, Jakub Kicinski wrote:
> We always used 5 sec as the default command timeout. But soon after
> it was introduced, David effectively made us ignore the timeout
> (it was passed to process.communicate() as the wrong argument).
> Gal recently fixed that, but turns out the 5 sec is not enough
> for a lot of tests and setups. The fix regressed regressions.
> 
> In particular running reconfig commands (e.g. XDP attach) on mlx5
> with 32 rings and 9k MTU, on a heavily-debug-enabled kernel takes
> more than 5 sec. The XDP installation command will time out after
> 5 sec but since the sleeps in the kernel are non interruptible
> the command finishes anyway, leaving the XDP program attached,
> but with non-zero exit code. defer()ed cleanups are not installed,
> breaking the environment for subsequent tests.
> 
> Since "install XDP" is a pretty normal command a "point fix"
> does not seem appropriate. 32 rings is a fairly reasonable
> config, too, so we should just increase the timeout to 20 sec.
> 
> There's no real reason behind the value of 20.
> 
> Fixes: 1cf270424218 ("net: selftest: add test for netdev netlink queue-get API")
> Fixes: f0bd19316663 ("selftests: net: fix timeout passed as positional argument to communicate()")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Breno Leitao <leitao@debian.org>

