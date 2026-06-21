Return-Path: <netdev+bounces-300909-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id N4VoAKhbOGrNbQcAu9opvQ
	(envelope-from <netdev+bounces-300909-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 21 Jun 2026 23:46:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 760356ABA5A
	for <lists+netdev@lfdr.de>; Sun, 21 Jun 2026 23:46:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=iMDc5Emh;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300909-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300909-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8202C300953B
	for <lists+netdev@lfdr.de>; Sun, 21 Jun 2026 21:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0436D3491D0;
	Sun, 21 Jun 2026 21:44:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166D12DCBFA;
	Sun, 21 Jun 2026 21:44:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782078247; cv=none; b=sUAtgKavUQXOp3uW+1IT9pElPMhaMwpi6i+lJyPYPPIlfXwDWlQ4CJZ9wEPwGl1JfuqLx3i0Yka6CIQoTywPG/mMZnh/E6ClX+A4q0yidpMInMoRKq5iXkgObSAekFbBQeEV5EdLyYuD0Vd20WQiGT4ZaXOYZfmE7/jbyAhNC+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782078247; c=relaxed/simple;
	bh=3LbQXs+qb3Suq/l1qNXkawU3pDbws2risYUp1hniM3g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IxA73R9tFHQpkmdWP/kYLB8S80a0BA55X9RkdwPTshOnq+cniC9ydBXzQvpM7ZWQ6GwY7BzHwEO73YE+EsIY+BjSFjtaH7JOPQ6HgjJjs5bvEV+QwhfQBcL04uK5oBy2P0e3ZJY8AWV9TZqdyxrNYhiubnGaCXJLZugKi12mXTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iMDc5Emh; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4320E1F000E9;
	Sun, 21 Jun 2026 21:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782078246;
	bh=Q/DDdrbAqpK3cXdB3Ec3oi2lstJK7AIFoyCnhXuQfqc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=iMDc5EmhG8RNHjUxE5d9giX8Nn86bVYfaLgrideVNyGGnrQ4VlByanYboGfWY4Dql
	 BIr7UYO6sA69pkk9SNHu4I3BvaC+RtQ03JNk9e6/q17VktVAJMRmjITntYR/GnNtp3
	 0ipez23UML697n+AuA7O+YArHMaPDTXARVZhJ2yFm3BlpOQveHmfqo5MS4oQdmyu0b
	 66W7aF1c2T7mMKdXQYUmqdXeoUWtSfER8b+1jOOwk6geiPg+Ecv4z0lI40Ph+7IWkM
	 M/Tc57aKx8a09VnEKJWwz16mtLmvAtyxzmd/wwtg7Zd7mWR7uODv3wgeAi6mmkL4QQ
	 /i0CkdCwaPUow==
Date: Sun, 21 Jun 2026 14:44:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: <davem@davemloft.net>, <hkelam@marvell.com>, <lcherian@marvell.com>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <pabeni@redhat.com>, <sgoutham@marvell.com>, <andrew+netdev@lunn.ch>,
 <edumazet@google.com>, Yuho Choi <dbgh9129@gmail.com>
Subject: Re: [PATCH net] octeontx2-af: fix CGX debugfs RVU AF PCI reference
 leaks
Message-ID: <20260621144405.0abfc627@kernel.org>
In-Reply-To: <20260617104525.1321395-1-rkannoth@marvell.com>
References: <20260617104525.1321395-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300909-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rkannoth@marvell.com,m:davem@davemloft.net,m:hkelam@marvell.com,m:lcherian@marvell.com,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:sgoutham@marvell.com,m:andrew+netdev@lunn.ch,m:edumazet@google.com,m:dbgh9129@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,marvell.com,vger.kernel.org,redhat.com,lunn.ch,google.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 760356ABA5A

On Wed, 17 Jun 2026 16:15:25 +0530 Ratheesh Kannoth wrote:
> +		{
> +			struct rvu_cgx_lmac_dbgfs_ctx *ctx;
> +
> +			ctx = devm_kzalloc(rvu->dev, sizeof(*ctx), GFP_KERNEL);
> +			if (!ctx)
> +				continue;

In addition to Simon's nit - please don't create floating code blocks,
just add the var decl at the start of the function.
-- 
pw-bot: cr

