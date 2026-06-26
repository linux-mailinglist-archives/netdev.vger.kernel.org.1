Return-Path: <netdev+bounces-302115-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SWrRJdAwPmrnBAkAu9opvQ
	(envelope-from <netdev+bounces-302115-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 09:57:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D59076CB2BB
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 09:57:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=aXhebV7X;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302115-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302115-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8E93302E7AE
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 07:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE753D4137;
	Fri, 26 Jun 2026 07:57:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380533314BF;
	Fri, 26 Jun 2026 07:57:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782460622; cv=none; b=gJVMFmkbf4o+I55bgFmIaYDcpFGao5qM5jOcrmjadeeEf5uaujG5V+Bvk8GXQLUeNkfVniYHEJWuubn8KP0aKEdG71afLXsbHTWxsYOFZwQ6gRHCz+M8pJziT8F37r6p1Tiv0qRWV1IsTQShJuoRci8Efho5wi+wCSRW6Murcvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782460622; c=relaxed/simple;
	bh=2dZ+Glog+01+bX6LN1nISAt9iuBFt4THcKeuav/sEdU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B55pOPpiZrSxfHx86FxcdgeQ/47niWHbO59Wfwri3kvG4g0nt6qn7GoSjoTEI4RQ/uHCdjMekE01MmzgLEzuXmveNGWwc8HH4TXffWudgpnG5mGB3jTKfkCoWJ7tmQ9XdPvuPjmQ4x80y1DjyWC3OCMyR0rLYkMgEYyNwFC8u1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aXhebV7X; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 332BE1F000E9;
	Fri, 26 Jun 2026 07:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782460621;
	bh=GN5MvdROi0tOUKfD0W+kRWQmAmHuLI14vqAQY7OLfyE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=aXhebV7X4mdJGnIv2koajjnqKaGEoWcmmDke0BYFoX7iLI7PhMjXXGKdKBjybLfv4
	 g3HwOoxiZAAFd1OyoRmrpdAK5DOpRkhsjbXgpU7sC4RQOxmEGieShfDuXfUZw7tSUQ
	 K5Ihb3zN7UAhwY/FeS9O0C9K3XHW6QnkEChs+N/yP2Es8sag+zTJVIxj3M72x2LXg1
	 4M731l0jV8loXDtCPnKuztIA0atwsmxWRW4lpn9gsopdOW4XK8V/qrB6sO8tb4Lz/1
	 J8n03XoyKVhuNF5jGKUzCUVMNNQqv4aciTUh1PciAdg5tQ4rewtkudv/mR8HKk0zjQ
	 5uCME/vGixSrQ==
Message-ID: <a0358bb3aa8e2d45bd1e74851416728c3f08ddff.camel@kernel.org>
Subject: Re: [RFC net-next 00/17] MPTCP KTLS support
From: Geliang Tang <geliang@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Matthieu Baerts <matttbe@kernel.org>, Mat Martineau
 <martineau@kernel.org>,  "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, Kuniyuki
 Iwashima	 <kuniyu@google.com>, John Fastabend <john.fastabend@gmail.com>,
 Sabrina Dubroca	 <sd@queasysnail.net>, Hannes Reinecke <hare@suse.de>,
 Geliang Tang	 <tanggeliang@kylinos.cn>, netdev@vger.kernel.org,
 mptcp@lists.linux.dev, Gang Yan	 <yangang@kylinos.cn>, Zqiang
 <qiang.zhang@linux.dev>
Date: Fri, 26 Jun 2026 15:56:53 +0800
In-Reply-To: <20260622090059.5d1813dd@kernel.org>
References: <cover.1782123118.git.tanggeliang@kylinos.cn>
	 <20260622090059.5d1813dd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-302115-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:matttbe@kernel.org,m:martineau@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:ncardwell@google.com,m:kuniyu@google.com,m:john.fastabend@gmail.com,m:sd@queasysnail.net,m:hare@suse.de,m:tanggeliang@kylinos.cn,m:netdev@vger.kernel.org,m:mptcp@lists.linux.dev,m:yangang@kylinos.cn,m:qiang.zhang@linux.dev,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[geliang@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geliang@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,redhat.com,gmail.com,queasysnail.net,suse.de,kylinos.cn,vger.kernel.org,lists.linux.dev,linux.dev];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D59076CB2BB

On Mon, 2026-06-22 at 09:00 -0700, Jakub Kicinski wrote:
> On Mon, 22 Jun 2026 18:43:20 +0800 Geliang Tang wrote:
> > Subject: [RFC net-next 00/17] MPTCP KTLS support
> 
> Please no. We have a ton of unfixed bugs and may have to revert some
> of
> the features we dropped back in. I'd prefer to avoid large new bug
> surfaces until we reach an LTS release.

Sure, I can wait. During this time, I'll go over the implementation
more carefully to make sure there are no issues on the MPTCP side.

Thanks,
-Geliang

