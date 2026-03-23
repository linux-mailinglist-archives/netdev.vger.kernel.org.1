Return-Path: <netdev+bounces-270332-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QDSHHa6HwGkvIgQAu9opvQ
	(envelope-from <netdev+bounces-270332-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 01:22:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E46EA2EB3EA
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 01:22:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D4A4E300650C
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 00:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF7D136672;
	Mon, 23 Mar 2026 00:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Trwtsm3D"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6962F171CD
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 00:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774225323; cv=none; b=vFJkTbDIkyJkw6z2BEIxA7gBnyOpQF+Nqs3C52lONhqKCOhy64u/6SIsg446REf7Jybd7cYLkEd7aP2aMXP3Rvu0dKmguhRRZPnRtwHCMVPCKHgdbd4vNsLw4nvxTWsRU8G3M+bxQF9c7xpxcv2FEinefUklP619PXL+vWr3XUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774225323; c=relaxed/simple;
	bh=R/DSxzoTdLH0Ml/JiJlBi3na3/ldXYRwmKtOsUMjNPQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N7CE6xJx1o4EORhG6y/zcKTqDjXhAE3NZnr4hkGHFfRXqs2SmEqOvn8oobJ+EWeM1L/xDVnIBV6zMqgACuknVWn9fB96yr/ag8jJVJRpvpuoKzTm8OARdujJxqz96B0Yp1oHgR9qXPGKUllq8ohRfZsXag9miXs1PxPQXSO5AVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Trwtsm3D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF7FAC19424;
	Mon, 23 Mar 2026 00:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774225323;
	bh=R/DSxzoTdLH0Ml/JiJlBi3na3/ldXYRwmKtOsUMjNPQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Trwtsm3DXLiUlAdTsdXiQq2dCjHfaM3Ys4VeUnPUcEYp3mzD5nkVQMOjic1nlS2ji
	 SWbH+ZnYKxsdle4c+tJIqOr8NbI6VjQurBPThh6U0dA09sSBluq0/1HLpIxmHBd7t3
	 dGljwekJOSS5OvrmBor62TNJDVeIfx/VwwxFhWj775KcYs0EfWKlOIU9cDP2BTOpi7
	 154pw+K4VN7MXpXiMtmZcLxzV826ENMA2YjJb253JLTh8yNe92tyB5nsTCPyhlXw0v
	 fqg3ac4nDBG5OqFynBAjWI+aWXME7qaMC80/JZMSakXyYPuppW82aDh7fUuujfSCHm
	 wGmxGarGEQFuw==
Message-ID: <2fd3d4bd-afad-42f3-8a2e-805940e078cd@kernel.org>
Date: Sun, 22 Mar 2026 18:22:02 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2] ss: print IPv6 zone identifier within the square
 backets
Content-Language: en-US
To: Jan Engelhardt <jengelh@inai.de>, stephen@networkplumber.org
Cc: netdev@vger.kernel.org
References: <20260317182245.87996-1-jengelh@inai.de>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260317182245.87996-1-jengelh@inai.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270332-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,inai.de:email]
X-Rspamd-Queue-Id: E46EA2EB3EA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/17/26 12:22 PM, Jan Engelhardt wrote:
> ss was printing the zone identifier in the wrong place.
> The zone identifier belongs to the address [1][2][3], and should thus
> be enclosed within the square brackets, not outside of it.
> 
> [1] glibc (since about 2000) accepts "fe80::1%eth0" as an input to
>     the `getaddrinfo` function.
> [2] Zone architecture specification (drafted 2003; released 2005):
>     RFC 4007 §4: "The scope of an address is encoded as part of the
>     address".
> [3] RFC 6874 §2 pg. 4: ABNF syntax showing where zones go in
>     relation to square brackets.
> 
> Signed-off-by: Jan Engelhardt <jengelh@inai.de>
> ---
>  misc/ss.c | 28 +++++++++++++++++-----------
>  1 file changed, 17 insertions(+), 11 deletions(-)
> 

This change is definitely going to break existing scripts handling ipv6
addresses. I do not see how this can be applied.


