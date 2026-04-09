Return-Path: <netdev+bounces-276759-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aQJoK8H01mnzKAgAu9opvQ
	(envelope-from <netdev+bounces-276759-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 02:37:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 150F33C50DE
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 02:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B3AF93011077
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 00:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14CF261B9B;
	Thu,  9 Apr 2026 00:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U+gWrai0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D34922339;
	Thu,  9 Apr 2026 00:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775695038; cv=none; b=uZqTh3+BbEX/EJuALC4aCiy/0SoJO4TdSSYW6TTUm4XURw19hhx0FsXadattdf0hciJ1gNoId3oD60ob5ypxUEKo/xN70kpNQ7tah74azWiDo6N94QlN6mx0pDmjetgO8wWdBI4x2waWi1XyGfP5LHswG8vTzM+YQPTe0zGVVdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775695038; c=relaxed/simple;
	bh=Lnf0KvVHrpWGAgDszvd4p/cDYRWH8oXxi8NAc7GrJqI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OOdYE8XYSmCVNfFeYZRSvXGkG/NgWCc+f49Oo9h2mSgoNM+E07rls5DFFa3cdl88vqSlYPaW8j2jJa6xFVm9xp/PQ5jHjYdTPS7jId5r7adzrvs7F3tMj1VzwagHDofWyL2nH5BDOmUDE0fXgqmAoX/jzvKzH0G6loSfytkCbSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U+gWrai0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEDB6C19421;
	Thu,  9 Apr 2026 00:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775695038;
	bh=Lnf0KvVHrpWGAgDszvd4p/cDYRWH8oXxi8NAc7GrJqI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=U+gWrai02H++LdRf4jJ4Nttoj9vl+DwuXfEqWtuRzjLA8lAG2l5JdWmHRwirEx7G6
	 +GbWKgz1q8wMdoGY3ZsZAJr17rDisooB+8nQMsoOf45jGWLIg/r6fdN2Z0fXvHALiD
	 2PqLoUVbSKIcm003IcRnjpC9byGJXGBNVcZKv6hfpwqT3PR6EYCDagHmzn3oW4LNPF
	 spueR9Hcnb6t3H7/w9nyU3BmwvLUNE/5A9SOAEnDzTriR9nEB1to9reY74NhnA4QPN
	 yUjdTQAWCOdT07AC1CjMfHV46D9bGAXTYjODF2Wgj8ewffdJr91TZn2LGV1+xO39Kf
	 xyUlIDTyDvi/w==
Date: Wed, 8 Apr 2026 17:37:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: Hangbin Liu <liuhangbin@gmail.com>, Donald Hunter
 <donald.hunter@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/5] tools: ynl: move ethtool.py to selftest
Message-ID: <20260408173716.0dedf22c@kernel.org>
In-Reply-To: <adaFLI2b5eb2mZHx@devvm17672.vll0.facebook.com>
References: <20260408-b4-ynl_ethtool-v2-0-7623a5e8f70b@gmail.com>
	<20260408-b4-ynl_ethtool-v2-1-7623a5e8f70b@gmail.com>
	<adaFLI2b5eb2mZHx@devvm17672.vll0.facebook.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276759-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,redhat.com,kernel.org,lunn.ch,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 150F33C50DE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 8 Apr 2026 09:42:33 -0700 Stanislav Fomichev wrote:
> > @@ -8,7 +8,7 @@ KSELFTEST_KTAP_HELPERS="$(dirname "$(realpath "$0")")/../../../testing/selftests
> >  source "$KSELFTEST_KTAP_HELPERS"
> >  
> >  # Default ynl-ethtool path for direct execution, can be overridden by make install
> > -ynl_ethtool="../pyynl/ethtool.py"
> > +ynl_ethtool="./ethtool.py"
> >  
> >  readonly NSIM_ID="1337"
> >  readonly NSIM_DEV_NAME="nsim${NSIM_ID}"  
> 
> Do we need to add some expects/asserts to the script to really make it into
> a test? Right now it just prints things, so it's not really a test.

This file is full of asserts? It's a bash script that runs ethtool.py 
and checks the output. Which one of us is missing the point ? :)

