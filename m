Return-Path: <netdev+bounces-264637-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLPwGT1GqmnxOQEAu9opvQ
	(envelope-from <netdev+bounces-264637-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 04:13:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA7421AED6
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 04:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BED8A301FD6F
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 03:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D9D36997D;
	Fri,  6 Mar 2026 03:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WHTi4Tzu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96718331A7E;
	Fri,  6 Mar 2026 03:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772766701; cv=none; b=Fu2fBQg2IURjEFfJaQSVYxZJegc2EMglJzOWP/d0VdhoaJVbQMU40ap3rUJzaoV9j7hw6iOavZZ0UpTPPGLmTkWVu9znEqV1pGM1z1nzlok/AWUlyUOXsL9NgH8geKXkTHa//tZDHQpmVQi6GIHWknV65PXHU3ORzh4qQb+mR7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772766701; c=relaxed/simple;
	bh=hzghbVU9PWt4YBpLOfXoyj78C9FtEGJLhIQfLff/1GE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SD1vKUM0jSfjEvJit6Etw8ScBX3TZCLk1Wr8r6IccYKcAAPL5jvEONEYAh6vVCLyyyp/+G09X8KM0kE1dscMCgnx61425ZX5oLMxUOo0F01jADtE/BUYRSyK2/HFfewVoulW1Swa+ACkQSsCrSNJNfEeSmeQK81UJk875ZrG7RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WHTi4Tzu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 267A3C116C6;
	Fri,  6 Mar 2026 03:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772766701;
	bh=hzghbVU9PWt4YBpLOfXoyj78C9FtEGJLhIQfLff/1GE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WHTi4TzuVFa6mRPEmR038ojSkahWxC8DyO53/0nX6GJFSRrs8xKivxj2o/HEAEANo
	 YemdxYLBzRC+WsyckXbc7qsY6amqugntbZjFMvo1pVlEFIOh0trqmgBVZ/nM3yV6l6
	 krwUTc2ZS9wqJS2Gh4nNiYo4D+kTjtPGKCeuufseFix+F/iDCZvci2kFzKRZKjGmc/
	 elFz8qEo+9Gf2X9uKOwYuHZnCqefiNpWa5pXqBuj+m/X5FWzfR1qk/cqHXaSo3LQNS
	 YKRH/wfbuJ9MaH+4jLRWRSkY6eQk+WUVCyGQCBf2LjitMasxsbOfoHbgpjr/QlSBCG
	 dRnqcq4YwC4Mg==
Date: Thu, 5 Mar 2026 19:11:39 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?VGjDqW8=?= Lebrun <theo.lebrun@bootlin.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>, Claudiu Beznea
 <claudiu.beznea@tuxon.dev>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev
 <sdf@fomichev.me>, Richard Cochran <richardcochran@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, Gregory CLEMENT
 <gregory.clement@bootlin.com>, =?UTF-8?B?QmVub8OudA==?= Monin
 <benoit.monin@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next 0/8] net: macb: add XSK support
Message-ID: <20260305191139.71d929be@kernel.org>
In-Reply-To: <20260304-macb-xsk-v1-0-ba2ebe2bdaa3@bootlin.com>
References: <20260304-macb-xsk-v1-0-ba2ebe2bdaa3@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: BEA7421AED6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264637-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[microchip.com,tuxon.dev,lunn.ch,davemloft.net,google.com,redhat.com,kernel.org,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org,mobileye.com,bootlin.com];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wed, 04 Mar 2026 19:24:23 +0100 Th=C3=A9o Lebrun wrote:
> Applies on top of net-next (4ad96a7c9e2c) and Paolo's XDP work [0].

You have to wait until dependencies are merged.
If you want to post in the meantime is has to be as an RFC
--=20
pw-bot: cr

