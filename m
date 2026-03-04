Return-Path: <netdev+bounces-263504-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFYBMCGGp2m5iAAAu9opvQ
	(envelope-from <netdev+bounces-263504-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 02:08:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 174D31F9136
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 02:08:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E114E301C5B1
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 01:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B4D2F5321;
	Wed,  4 Mar 2026 01:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SIIu8f/h"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7719E29408
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 01:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772586523; cv=none; b=ORWFs7tVx84sfb6epu+g6XY3F/edDpmIQOzISrTrJm511RPqsh5RUiapjjZb9G5+TQB8Jixk77qeZ8+yYE70KDq5e4+d6m8CawYwdlpJOjem0P0WT2pRHtT9NjKowTVrf2JXy1EiKd2KMZCaCx1CXc18PhtKgQsttj8z25xDkxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772586523; c=relaxed/simple;
	bh=DQnIqIa8jSessrJ7z0E3IiEhGL1TxcQcGfMsY3LmGhs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DTFLfibr+EHXe4rYKtKMXCfre2ejUtW+SmUsJj0B8cLJ3A5YngKNB99EMhqHsJZsp3tWoamn0YNJJIhAwGPIsAs8BxJoH3Rjsalo4Dho+uPMsFzf3DF285fxQfYn8CyxasRjBqucD/UpByt5oASN2fxCC3h/9W/OYDNFcS3H3Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SIIu8f/h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E4A7C116C6;
	Wed,  4 Mar 2026 01:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772586523;
	bh=DQnIqIa8jSessrJ7z0E3IiEhGL1TxcQcGfMsY3LmGhs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SIIu8f/h12uLMM/JTLmvYi3N7DJbUrQKvJ6Kis/CcGxr63s+BWdLfEeNHqYWsLwKi
	 7UitPMzV5DQZfdiPCowI0H5dTPB6S5hVngVUwwBqd/nrYpAadN4w37WgCkeBKrWtC6
	 7Nj04rt65dWX+EbCtrJUCcmzrDw4T29y+bInIE2Z+093JjAoS54L9w4bihptxSk2mc
	 /RdZQ7MUw0wnpRDBBUNIlaQDpVyGUobsNeLUctSSXREFbmkj8De60DAmAXHT/B12w8
	 DvFyBUNf0JyaZkbfTPZZkErNEI7IpF0RS9jgDIOSYHA9/2envuu1cELQBT77o5prqG
	 /Q+Mqxy57BduQ==
Date: Tue, 3 Mar 2026 17:08:41 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Kuniyuki Iwashima
 <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, Ido
 Schimmel <idosch@nvidia.com>
Subject: Re: [PATCH net-next] ipv6: add IPV6_CALL() helper
Message-ID: <20260303170841.218b0816@kernel.org>
In-Reply-To: <20260302154201.1621117-1-edumazet@google.com>
References: <20260302154201.1621117-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 174D31F9136
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,redhat.com,kernel.org,google.com,vger.kernel.org,gmail.com,nvidia.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-263504-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Mon,  2 Mar 2026 15:42:01 +0000 Eric Dumazet wrote:
> ipv6_stub use is racy, we should add READ_ONCE() and WRITE_ONCE(),
> even if this pointer can only change once.
> 
> Add IPV6_CALL() macro to factorize the READ_ONCE(), and perform
> direct calls when CONFIG_IPV6=y.

Does not apply to net-next.
It sounds like we're going to remove IPV6=m, however, perhaps transform
this patch into that removal?
-- 
pw-bot: cr

