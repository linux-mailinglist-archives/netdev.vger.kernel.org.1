Return-Path: <netdev+bounces-270316-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mh+7MQYgwGkOEAQAu9opvQ
	(envelope-from <netdev+bounces-270316-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 22 Mar 2026 17:59:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 158A82EA16B
	for <lists+netdev@lfdr.de>; Sun, 22 Mar 2026 17:59:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB63D300AB15
	for <lists+netdev@lfdr.de>; Sun, 22 Mar 2026 16:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4FD3644B6;
	Sun, 22 Mar 2026 16:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RAjgy7QH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C391B7F4
	for <netdev@vger.kernel.org>; Sun, 22 Mar 2026 16:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774198787; cv=none; b=rG8htqcnjHN+xsEoP8OaoC+43fqltIIZTackcn8TyJ/aCOEGhly54ihi0dNCsCZFU390k9VchV0JZIBNhjFI9PioiUnIKGgtak4HPf2peWVkCIJWNsLh/YGxyEmJsqxEVTHq+AMCJ+OXaK5HSPHoMutIYhBRLorDv1mJ2GaiQ/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774198787; c=relaxed/simple;
	bh=5tJA1LqJKLLiGOEaipN+GTAcqpajMXDyK7VmQJizpPE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=McNVDb33BjeqISLxMwG/v9TvZjtVbrBU5A4uuMH80ymHsFNwovdKawQ6CG+BZuMwkTnDMH6oNNzxTPKKqPUZt5VqzoVyP2LFY2z7l9UDSGK5tGhCW7dO18WtUWHTBkKXb6O+6b29m4/XphNdlfWIomKH/1JmawjnN/xY6w57RTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RAjgy7QH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DC24C19424;
	Sun, 22 Mar 2026 16:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774198786;
	bh=5tJA1LqJKLLiGOEaipN+GTAcqpajMXDyK7VmQJizpPE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RAjgy7QHDP0zPkOp55FXXUCczcG8Qj5eKUWbcnlpQoBGhpx7ahv7iciUkDJyO1kiV
	 LuBDx+WenphA4uvbZXE1JS0U8WRW5d4FTfgBzr7uJzD0HXbqgCCTAOmhWCJtvR/iyG
	 XdhsXZl+qx1PrCwg+N2/Z8s9uqo2o/SgkNyDNeWtNrellhjJyI/+MKXlgxIbCUI0vr
	 sdx66tV089Rc+lzSbwH9R9kW+5xr7D8EnYuwzILiWsTRGOEo0+QvMoIEZ0c4DhQ5gt
	 X3psOj4DIJ5KhKxCmm48eTsROVvR2o+LJxgJtZ+ZJ9nAcU211PimgJ5qL6EcFxP9J/
	 1/c5AtdHVSVng==
Message-ID: <168e2cfb-1e6b-4617-a930-922d06a66e7c@kernel.org>
Date: Sun, 22 Mar 2026 10:59:45 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 net 1/3] ipv6: Remove permanent routes from
 tb6_gc_hlist when all exceptions expire.
To: Kuniyuki Iwashima <kuniyu@google.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Kui-Feng Lee <thinker.li@gmail.com>, Xin Long <lucien.xin@gmail.com>,
 Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 netdev@vger.kernel.org
References: <20260320072317.2561779-1-kuniyu@google.com>
 <20260320072317.2561779-2-kuniyu@google.com>
Content-Language: en-US
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260320072317.2561779-2-kuniyu@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-270316-lists,netdev=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 158A82EA16B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/20/26 1:22 AM, Kuniyuki Iwashima wrote:
> Commit 5eb902b8e719 ("net/ipv6: Remove expired routes with a
> separated list of routes.") introduced a per-table GC list and
> changed GC to iterate over that list instead of traversing
> the entire route table.
> 
> However, it forgot to add permanent routes to tb6_gc_hlist
> when exception routes are added.
> 
> Commit cfe82469a00f ("ipv6: add exception routes to GC list
> in rt6_insert_exception") fixed that issue but introduced
> another one.
> 
> Even after all exception routes expire, the permanent routes
> remain in tb6_gc_hlist, potentially negating the performance
> benefits intended by the initial change.
> 
> Let's count gc_args->more before and after rt6_age_exceptions()
> and remove the permanent route when the delta is 0.
> 
> Note that the next patch will reuse fib6_age_exceptions().
> 
> Fixes: cfe82469a00f ("ipv6: add exception routes to GC list in rt6_insert_exception")
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> Reviewed-by: Xin Long <lucien.xin@gmail.com>
> ---
>  net/ipv6/ip6_fib.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



