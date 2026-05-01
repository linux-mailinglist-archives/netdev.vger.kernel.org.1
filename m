Return-Path: <netdev+bounces-283140-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPO4Cppn9GnRBAIAu9opvQ
	(envelope-from <netdev+bounces-283140-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 10:43:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2EF34AB1AA
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 10:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1B513015C8A
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 08:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE5B2DB789;
	Fri,  1 May 2026 08:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="aiU7vvza"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D8D7262A;
	Fri,  1 May 2026 08:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777624981; cv=none; b=datf1YF3tEYrfWeFuked+9prueFPC7x6hs8iFNSdOh4tBb6JpWSsdHbHwEw+p8Kjlr/SXUOjbIzGzBdEDuXpz4fdwxKeZujf9Y+XkofkdTHWm/ug1yMUJUUymwgyNTDyeyP6oAtm9UMRjxCtgdfCwGhUoPZchdNIABnhzjA12oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777624981; c=relaxed/simple;
	bh=XHGoYBSbV5xa7ZqsGVZi3EUAzMEbrmZsbivg8GRr+Lo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tCZt2dPla0DmO/NaoqEdikdyY49g5J4i5p/N4unlgkwcmRu9kP2zr5f8v/dJFKME+eEPeyqwUGmHXrGVF7x3YZTBd+bTuyDEL24QBFeiL9APuxp3DUPu31dRuN819U7lbg+PiZm2UeRsjYiu5CU/f7FsR6dzRXogLjEhISxykzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=aiU7vvza; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=75QipLhpY8NOK7to28Nf/hWM8FZV3CQYXlf6ZO0HbH0=; b=aiU7vvza7zrwnXPhQbgQS3YZK1
	+RdFFHoX2mJe2e0mWeppW1UVkl0g025h4nugw1CQ400wortOSrAm7I4zr2j4+GgUJBBKwnn0jPycM
	B/KPMiq9fC/Q+wLCND4GmhRQU42r4jWVPTxMNV/LzfglrYuccD+2C4O10JESUM3smeSTJG20a01np
	H3quWBas8Zc7Y4VH6hVVDzFM4LBInTZxAAlWB6sYcY1kkp20rq9JXemYzZskmGhGUIbV/BfIxOtgo
	RvffZNHeQeGJ5rfhqbUFi08boiUjZW/xTE+KeS5uzKiQJvKHqI2TgRhC1Fe9fp2GfqBrixAGhEvZs
	SQdOs1EQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wIjSY-008S94-1D;
	Fri, 01 May 2026 08:42:54 +0000
Date: Fri, 1 May 2026 01:42:47 -0700
From: Breno Leitao <leitao@debian.org>
To: hawk@kernel.org
Cc: netdev@vger.kernel.org, kernel-team@cloudflare.com, 
	Jonas =?utf-8?B?S8O2cHBlbGVy?= <j.koeppeler@tu-berlin.de>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v3 5/5] selftests: net: add veth BQL stress test
Message-ID: <afRnXhsNMBRJ0LdB@gmail.com>
References: <20260429172036.1028526-1-hawk@kernel.org>
 <20260429172036.1028526-6-hawk@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429172036.1028526-6-hawk@kernel.org>
X-Debian-User: leitao
X-Rspamd-Queue-Id: C2EF34AB1AA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283140-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Wed, Apr 29, 2026 at 07:20:32PM +0200, hawk@kernel.org wrote:
> +compile_tools() {
> +    echo "--- Compiling UDP flood tool ---"
> +cat > "$TMPDIR"/udp_flood.c << 'CEOF'

The biggest structural issue: the test ships ~250 lines of C source as
heredocs and shells out to gcc at runtime to build them. This is not
how selftests normally work.

