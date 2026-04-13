Return-Path: <netdev+bounces-278111-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WNAUCfgD3Wn/YwkAu9opvQ
	(envelope-from <netdev+bounces-278111-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 16:55:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B38623ED996
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 16:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 749BF3004635
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 14:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E86E3E0222;
	Mon, 13 Apr 2026 14:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QYeLeuxj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6E53BF688;
	Mon, 13 Apr 2026 14:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776091667; cv=none; b=UJ6kRvKDP5vHIiSb654ixgsk6nczQ8ugnYnpw9mnY63q/davZhvLKL1MRU1pldTNdBYk3ChRvlmdTDA9iVCJROvuSOVRAtUYF871cEa5chuRKh5speZ6/JBMhOn7N2xunouYXqC6KQA6IVDqToLQzpP+P6sodQmPuXWk4Uh4oT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776091667; c=relaxed/simple;
	bh=J2ozv3jkSoH0KVJITX1EXK8AaUpbGFdIJW3lFO3MPnw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H3GK3FabJ4KsxLBOaEbw+EjDVSrzBOR7QHiWokwjyAFeMOm0F3imreq7w3b5UF/VXqRyp12LNlw8WPvhq94oBmkm+OLfa0hULryYfUP6mIRbY9Dr7nwQrkbJv7kZ+Er5lNadHR9YG2GqFSFoW8ocitaj2oKuBW0SC3OX4mO/+70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QYeLeuxj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0710C2BCB0;
	Mon, 13 Apr 2026 14:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776091667;
	bh=J2ozv3jkSoH0KVJITX1EXK8AaUpbGFdIJW3lFO3MPnw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QYeLeuxj4sdE5rneKSY+h8jJxE6/GYgLTim20Xp2oD6j2pXfknIgFeQzkNEf+qEQh
	 o8qlx0WGBJ1bSib0hJCXGK9ZrLInLHyiABmSVMWUlRXKML1pNrG9vFrzsCTfkM2xHt
	 QuyqfttUfigjRx8Vqo7R/Nx/llLMkcAx6gIjoovJ/1yo1dA7G0uu2MS70G++mmuWZV
	 29OSpZCWPN1ecL8/1z7FxbfxA+EDJJJVUHqgLpqQ/BF1apipoXiGYpjESpLKhKimvV
	 2ONgsoy/0aUJr72dktZZFADVeXpZ4bmHN3zI9aTPFaHppn8/rsC/6kVjZ7hM+KoXOw
	 j/trz+CJHgnBg==
Message-ID: <abaaa506-2e87-4aa1-9072-b1675a4bd21f@kernel.org>
Date: Mon, 13 Apr 2026 08:47:46 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1 2/2] selftests: fib_nexthops: test stale has_v4 on
 nexthop replace
Content-Language: en-US
To: Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260413114522.147784-1-jiayuan.chen@linux.dev>
 <20260413114522.147784-2-jiayuan.chen@linux.dev>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260413114522.147784-2-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278111-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B38623ED996
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/13/26 5:45 AM, Jiayuan Chen wrote:
> Add test cases that exercise the scenario where an IPv6 nexthop is
> replaced with an IPv4 nexthop while being part of a group. The group's
> has_v4 flag must be updated so that subsequent IPv6 route additions are
> properly rejected.
> 
> Two cases are covered:
>   1. Gateway nexthop replaced across families with an existing IPv6
>      route on the group (rejected by fib6_check_nh_list).
>   2. Blackhole nexthop replaced across families with no existing IPv6
>      route on the group (fib6_check_nh_list returns early) — this is
>      the path that triggers a NULL ptr deref without the kernel fix.
> 
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
>  tools/testing/selftests/net/fib_nexthops.sh | 22 +++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>


