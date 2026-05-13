Return-Path: <netdev+bounces-287478-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kF2nFdQ5BGphGAIAu9opvQ
	(envelope-from <netdev+bounces-287478-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 10:44:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CA44752FD97
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 10:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3B11E30154BC
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 08:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40AA3DC4B9;
	Wed, 13 May 2026 08:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="CXHbpdYk"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708423988FA;
	Wed, 13 May 2026 08:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778661796; cv=none; b=N7hZoHgbNC/r2ZCi6lOUhgbUKngj04k09GWXa5RXebVHzt8330to37800wiEKHt8ccBw4svHEGuqvvAB4hvWk6jyAthHv2j2SOVmzryh+rnX5WcV9ifUI/xeIaHiUquchUMJT1mjAvy3ZUc+3VeEgxNIeqhTNwLXBvWn3Q7Y72I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778661796; c=relaxed/simple;
	bh=0VkMMnq26s4mP6QQ4+plN3jXE2zXn6QWaCLFVrVSjxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WYT5pok4YxgKV3prkUmujIoGRzNYAppb91XkILlY5FQTmzlgCD/sb3b8mykN6ZTE52Fk5BfYsUIDg9T/zs0BLffXBS0e4wASuPFH+XDS7HwRfj0Rg0HsS84SePMlG+d/d4SxBPm23O+qI2gA1FeqgFqkl2sRTvFM0g2CXI6HrKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=CXHbpdYk; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=XTbl9imM9XXLaa+LSCrBqsB33iPfAB7LRFDJ8WSXePA=; b=CXHbpdYkn48wMEHsQ+dnHNTS3O
	J3JyoBpE//PLD8BSwWfUiw+qAqH0wNKbyXmPdgnr6lmqHZF+MLkxcqMpWx1oMoFXYh3MrZTGnX9nr
	Uvz2hbBY3BGuieTk41dYzX9VjfOZpCocDfUKZoV4NG4+jWoUUWoe03LczFRq/lE5zMsjsfsTguLOB
	yGChw9m0BxScvHXkcqyczcHYwFHQbdCsDPxpHsvh5CS5Xnc8oDSrri0Sgdsm8nPgkoW/uGQ8hS/LL
	Tykw71Ez8BKGhhP5LxVO0SVMRd5I9vGA7M1vDuR6Zgmz38PQwI4uoDT5olxdG2tGkBmIT7zgFWP8W
	WVIiRECw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wN5BH-0032Rj-1A;
	Wed, 13 May 2026 08:43:03 +0000
Date: Wed, 13 May 2026 01:42:53 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Fernando Fernandez Mancera <fmancera@suse.de>, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, horms@kernel.org, pabeni@redhat.com, edumazet@google.com, 
	dsahern@kernel.org, davem@davemloft.net
Subject: Re: [PATCH 2/2 net v4] selftests: fib_tests: add temporary IPv6
 address renewal test
Message-ID: <agQ5e5sSzKTU_L4h@gmail.com>
References: <20260511122645.6233-2-fmancera@suse.de>
 <20260511122645.6233-3-fmancera@suse.de>
 <agIKdx3q9ewyhq7r@gmail.com>
 <20260511170848.756e9347@kernel.org>
 <agLenteVpazkwn0j@gmail.com>
 <20260512165641.1f557ba8@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512165641.1f557ba8@kernel.org>
X-Debian-User: leitao
X-Rspamd-Queue-Id: CA44752FD97
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287478-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[debian.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 04:56:41PM -0700, Jakub Kicinski wrote:
> On Tue, 12 May 2026 01:08:15 -0700 Breno Leitao wrote:
> > On Mon, May 11, 2026 at 05:08:48PM -0700, Jakub Kicinski wrote:
> > > On Mon, 11 May 2026 10:01:00 -0700 Breno Leitao wrote:  
> > > > Should you check for ra6 before the "setup" above?  
> > >
> > > Not really. AI bots love to complain about this. But "ra6 command
> > > not found" is as good of a message as the explicit skip, honestly.  
> > 
> > Right, but why call setup() before checking if ra6 is available?
> 
> You cut off the sentence from my response which told you why.
> 
> Checking dependencies is not a priority for our tests.

Ack. Notes taken, sorry for the noise,
--breno

