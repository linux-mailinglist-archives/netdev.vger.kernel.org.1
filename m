Return-Path: <netdev+bounces-285378-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wLlEAF+s/GkNSgAAu9opvQ
	(envelope-from <netdev+bounces-285378-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 17:14:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C4E4EADAB
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 17:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ADDFF3006175
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 15:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246EF3FB7E9;
	Thu,  7 May 2026 15:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q/8K4M52"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019F63F54AD
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 15:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778166876; cv=none; b=h92J6C9G2ZbxdyLfGeJKfawGgD+RajTdKOCp/GYHX7iqvf9PGbHMwzSgjXpXz8hu54eZCPe5wSWkcC7MfHeDvy0tNgm2aHL/icELKo5+8jtzGqHEUbFhgNXl7+c0BRGYZFzI8v22RUzXEyjUUDcizd4KK07HVeGMYPZ3uhNRsCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778166876; c=relaxed/simple;
	bh=GHlsdUXYw3KpEdOKltzLJfsfCFEm6ZB6eRem9WLVwyI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hgYVeQNKgPyzuFVYWSHVuhN3BxY8ShNRxCT4EcQDUXJiK03iegr+kYiyksXCYn6cFDQEjFgUe5eYye+RMPTZStdlMEHHK2z+7+e28vbDMRlRi0qiGWZiXRHZGmwlL8gI0qn80ERFhjdTgeBkyo6qz3UDIm3RhCOnoGf7pyr/0QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q/8K4M52; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 355DDC2BCB8;
	Thu,  7 May 2026 15:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778166875;
	bh=GHlsdUXYw3KpEdOKltzLJfsfCFEm6ZB6eRem9WLVwyI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Q/8K4M52TkFcu66z5d5dddREseinyqAdqbiWKoBUE3z+k+vSiu42iAZrP6ocsmj1Q
	 WYkxaWX1wWlRQ5FR/QqsmM2xcV3BkWkKJXLVSOoNBXt0S44V6ZO2fboqBGV1lKhH2I
	 z+OU+2nnyNxTTdJ3e9UBqHAgnrvuQOl4oYXsruC9COtUwXnuN0jEVlE+ENTx/LvWv5
	 148mUJFYWom4HKXH9puMgjAdbGo4DkB6Itf17hH4TWuaivPhdD1G7eVyt24VNn+LZC
	 ejNqR0pU+ZsE1f+SVcr4Akw4FKiE6G4PMZJNTwpSSIdPaUgekEPAM1Qszvm6V7DZYx
	 2gjehRVVnA1dw==
Message-ID: <7e283b95-a96b-4e20-b062-6d43a8164395@kernel.org>
Date: Thu, 7 May 2026 09:14:33 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/3] net: constify sk_skb_reason_drop() sock
 parameter
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
References: <20260507084305.2506115-1-edumazet@google.com>
 <20260507084305.2506115-2-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260507084305.2506115-2-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 99C4E4EADAB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-285378-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/7/26 2:43 AM, Eric Dumazet wrote:
> sk_skb_reason_drop() does not change sock parameter, make it
> const so that we can call it from TCP stack without a cast
> on a (const) listener socket.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  include/linux/skbuff.h     | 3 ++-
>  include/trace/events/skb.h | 4 ++--
>  net/core/skbuff.c          | 5 +++--
>  3 files changed, 7 insertions(+), 5 deletions(-)
> 
>

Reviewed-by: David Ahern <dsahern@kernel.org>



