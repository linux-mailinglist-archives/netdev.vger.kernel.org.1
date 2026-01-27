Return-Path: <netdev+bounces-253819-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMH7HFafeGn4rQEAu9opvQ
	(envelope-from <netdev+bounces-253819-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 12:19:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D984F937FC
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 12:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D97A23028123
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 11:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50AD346FA0;
	Tue, 27 Jan 2026 11:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="iLEefQIA"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2623E346E4F;
	Tue, 27 Jan 2026 11:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769512699; cv=none; b=e7YyENRaflhAQ/0gIUGzNwsNlfQo+BNzwdUK787TY53UuLA1DeZ2HNwTKML2mKmc1glK41jHUvrACi5if1Qc3LxPkHqocthMZt51XciHj06DPatAFYNkRsCau5+X62gDRNClyizjthYWSsmVQHb3UICmkQw6Vf4tOtf6fK3eDOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769512699; c=relaxed/simple;
	bh=PxZfArF2f9QC2HRmqSw/ncdyVW5yLP3qOosAt1uFLbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d3weNoIfZtToNttr0vNp80sEOP/uzBsNV9LPt/8DjcTpBTEbrs4RUkTZNBGexVXRgCWRmaaIYNujgg7+Xu14ekLXy7yxYI90e+5mqou/8exZcwdPMqQw84tz9j4OcbTufNJwc7hDXoEdSebqja5lRK5tnUsanzIX32df0b23TVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=iLEefQIA; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2st2EtiwsmX0QduO+/qJ+/YFeBxFrKpsOovDr8NSg6w=; b=iLEefQIAzJ/Wah2OpF8J1RBPNu
	GdNbW/sC9FhMROOMFhXV+lIPZzOmBAvSXQpuNmJLAPNeez0vnzP7V6vqImsrp16GZfy004b3OJ0Bc
	BopA2gtNaUVYQruO0KO1KWvU6q6xHbdD84JSsdoNuvckqPVsuTEd8zqPzVdzWpfME2uGESAuTKE0r
	G7yDpSiZapUbR4a4aScW2j0d0dq7oKeJyOVZT959T/M+eC2A5IerPC6kFXGziA0p2KEzoUMwOc+Pt
	zfN2l1D8FfgUmE3sAodrqfJISdgyLmGumAZ7Vyt0matRkKFmSy7ihCzd7XaNd5/hP7eVXwpjrlvtL
	PEkyBsWQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vkh5C-00GwsI-Dc; Tue, 27 Jan 2026 11:18:07 +0000
Date: Tue, 27 Jan 2026 03:18:00 -0800
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andre Carvalho <asantostc@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] netconsole: selftests: Move netconsole
 selftests to separate target
Message-ID: <aXiefXsiKm0mBjKA@gmail.com>
References: <20260124-netcons-selftest-target-v1-1-d3937f44c4c2@gmail.com>
 <aXdYwphLx2O-Hxis@gmail.com>
 <20260126162800.10d5601d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126162800.10d5601d@kernel.org>
X-Debian-User: leitao
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253819-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[debian.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: D984F937FC
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 04:28:00PM -0800, Jakub Kicinski wrote:
> On Mon, 26 Jan 2026 04:10:18 -0800 Breno Leitao wrote:
> >
> > Thanks for the patch. Looking at NIPA, it seems none of the netconsole
> > test run?
> > 
> > https://netdev.bots.linux.dev/contest.html?pw-n=0&branch=net-next-2026-01-25--06-00
> 
> Do you mean after the patch?

Right. I am looking at the patch entry in patchwork and didn't see the
test run.

https://patchwork.kernel.org/project/netdevbpf/patch/20260124-netcons-selftest-target-v1-1-d3937f44c4c2@gmail.com/

> I'll have to manually add it to some VM config (presumably the SW
> drv-net one).

I didn't know that. I thought it would run automatically, sorry.

> I'll do it after patch is merged. (Remind me if I forget? ;))

Let me know if you want us to do it,
--breno

