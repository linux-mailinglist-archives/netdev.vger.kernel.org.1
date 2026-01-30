Return-Path: <netdev+bounces-255245-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFaqLfIJfWnhPwIAu9opvQ
	(envelope-from <netdev+bounces-255245-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 20:43:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3908FBE3FA
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 20:43:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9ED65301692B
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 19:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840542FD1C1;
	Fri, 30 Jan 2026 19:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J5UBbNgo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E1E274FEB
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 19:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769802223; cv=none; b=ITsUc+yl13c2mm3m7ZZoRf42t8YqW3hLv9fmMNxj0+drgQtwyCwsJVI/yk0/wXk5uBSZB88WjsISZTeUJvQ+B2vOawTCUUU0teFCP1+zuxjtFCKlz1Egy7r9B+za7j7ZmVvXaAV8zU7oEY70DWS0pHfS045T11Dc7EYBpK1d0AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769802223; c=relaxed/simple;
	bh=nqAWr8fuwVjkvulQ7GFw8d5GIzUhxphPz8APX3Tr7Hk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B2jNtUFO3XNEs2tpmK1IkRMJavhAvaVnaMdMhBiAXM/VEh5kbWJMA1zwy0du9pDvjdmt0DS8hCZM7dtgP/eUBf8uaTIX7K90osLa/6vy73Q9eTVs4A2vnlMAgyR5uDiloMkjQbvdScSBtwuEnoA6SvJ3w1fCJzXxw49rSERlIDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J5UBbNgo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DFF9C4CEF7;
	Fri, 30 Jan 2026 19:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769802222;
	bh=nqAWr8fuwVjkvulQ7GFw8d5GIzUhxphPz8APX3Tr7Hk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=J5UBbNgo1oY0/ph3tOao2Xd59djGyyMAlI29qVQIGgY/iaPf8V330UKuAau3wC+8w
	 /4R4vsmX5frjVCQlCUKJ/2LhQAoBU2ZNwW+9LDX7eI/Q+yrNxDnGYWKPQ1PYes3zLz
	 c6fI8OM7biSPWkTLMgh9+tndogpC7BdLNh/1ddazAhN4kUYOZWOa1k6r/HprJQUkKq
	 IIQuAFpi99QfZm1F8rNpFury20m1iBuSx5g8gZ+Ue9zk7hMO6q/2PrLs0DzqvKTPeG
	 Q9/lq2eq4DH2f6FKy/VVMzAvzWDzlJ/rkFyLlJVbDjPw6p4N9M2x1USe54O7vZrAIq
	 ajjFDi34bnilQ==
Message-ID: <d153e3c2-381f-438f-b7ca-7dfb846464d9@kernel.org>
Date: Fri, 30 Jan 2026 12:43:41 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: l3mdev: use skb_dst_dev_rcu() in
 l3mdev_l3_out()
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20260130191906.3781856-1-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260130191906.3781856-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-255245-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3908FBE3FA
X-Rspamd-Action: no action

On 1/30/26 12:19 PM, Eric Dumazet wrote:
> Extend the RCU section a bit so that we can use the safer
> skb_dst_dev_rcu() helper.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  include/net/l3mdev.h | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



