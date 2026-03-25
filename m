Return-Path: <netdev+bounces-271773-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFp/G0pkxGmBywQAu9opvQ
	(envelope-from <netdev+bounces-271773-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 23:40:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C39C132D1C2
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 23:40:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9B4F301BC35
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 22:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B8C3563FB;
	Wed, 25 Mar 2026 22:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JxOd7hZT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB1F34D398
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 22:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774478161; cv=none; b=Yu9AIMX2FY7GxksPyl7r/tyiuzkmKsM6kMsY7wju4oaZiCakwBFo8DZAYf14b8EqIaTnDcE2Res3qM3SnvghpUowQXulqUP3VZU7DTcIuC3Nk6/KvvsOyjZz9KFhX1wciSsZa53qkv4cPZEIN8VXC+j3EQ6cJPh9aQnIuHSVrHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774478161; c=relaxed/simple;
	bh=44iRR8m/XegOSdPWUGbXk2jl5bSd2QmBPmIBixtWoRY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A02b4g83db3y/Oq2OYwvzhxMZZ9aWKGDsAqI32g7ZwCDEttmHKWMNgWxVvpQ9TB4Px+0V/XSqAyPvJn1xBrJJ5RCmYbs31t0GIZM1xYxpOFJQ3RBR8FLnCzuuOwdCQXsnfpIzaL4fPK8jtukcbKXHUhrnOLK44wPfXK8eHfjZvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JxOd7hZT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68087C4CEF7;
	Wed, 25 Mar 2026 22:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774478160;
	bh=44iRR8m/XegOSdPWUGbXk2jl5bSd2QmBPmIBixtWoRY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JxOd7hZTE1RHI4+H6TyvDtbw0w1TL01Kida+8qArfF7tfIUX10e0qo9G8gzxb0BGz
	 QzyKzPTSx4ZdiOYDKVyhmaIz4EWjKN6hsUXio7CD6JajZLOlkphR/SC4wCLTmu6QVN
	 WsPjCqqe8ypKZiyAZtFDVBmE+25OyGcpEOdIO6dvJt6dB9lRu+U5VhC+a/Za+HVZZg
	 PFmCbCcHM2yzWOhkcz2vO7vXh0xZS1XfjCRoma2gH8jIB+pZzwYdFoUocbqGFbQdLw
	 iW1ZtuCFiA9OA6Od/pboJXTK/fav/nUrDOQPx6XufAj0mTBQJKy0dctcg0hJ2WzAHX
	 Q+vVckHO4xyGQ==
Message-ID: <9c93ed45-2af8-466c-9b3d-ad87ba144fc0@kernel.org>
Date: Wed, 25 Mar 2026 16:35:59 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] vrf: Remove unnecessary synchronize_rcu()
 invocations
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, petrm@nvidia.com,
 lirongqing@baidu.com
References: <20260324155521.525292-1-idosch@nvidia.com>
 <20260324155521.525292-4-idosch@nvidia.com>
 <CANn89iJ9hD3vBiViEz886sVwuqQVbaocnE0UJHZMhchFHKiM-w@mail.gmail.com>
 <1ea4c187-9c1f-4e15-b472-07a82abd3260@kernel.org>
 <20260325144228.GA686135@shredder>
 <CANn89iJ9MQ_3af3XiNAGQWwr-t1kF=E-mKmu6h-XVDVyi7c4mA@mail.gmail.com>
 <20260325201155.GA909880@shredder>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260325201155.GA909880@shredder>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271773-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C39C132D1C2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/25/26 2:11 PM, Ido Schimmel wrote:
> Did some more digging. I don't see a reason for keeping the dst pointers
> RCU protected. I can replace patch #3 with the following one in v2:
> 
> https://github.com/idosch/linux/commit/3fbc1cad610df95cfcde117394c2c3d9e9a04e65.patch

LGTM. Thanks for digging into the sequence.

