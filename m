Return-Path: <netdev+bounces-288021-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Cd3Dq3pBWrpdQIAu9opvQ
	(envelope-from <netdev+bounces-288021-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 17:26:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF6FF544019
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 17:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6BA8A316AC82
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 15:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9782737FC;
	Thu, 14 May 2026 15:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="spUHly90"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F4E3DFC78
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 15:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778771786; cv=none; b=JAsJdx26XZlN++V3r6LjOGafN5j+ybWc4zPKiU3hHhlsQArmwfnB6Lr2qeXLge8rjMu85Jt+6fjy/BYMQDw7PfT4Ef9ieNJnVbuK1FI/3MXz9vDVLy2hasFDWFy3/TtSXMsCzrKnRiRo95XisY5afYZNEX99n+h9IkSbzZtCTro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778771786; c=relaxed/simple;
	bh=jBcaqElGYubB8bG4AWjnk9RRNh7Y33ubIpqhUY8mKfI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p13xF+M4zzBl4iGwKqeurj5KWDpvecFdNkzjiDof2PzoGAfHURkQzQ2iQ4S/m0q81Xv3EqX4IVmbDflk9oDmhOT1esQouOqo6TEurFjJ3Y+9F4c+mDtmdtkbU6kzJl+zziCGr21yYAXE28lj6PNuQsqogsJhK4bKrvpLPHMYFUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=spUHly90; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C4A0C2BCB3;
	Thu, 14 May 2026 15:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778771786;
	bh=jBcaqElGYubB8bG4AWjnk9RRNh7Y33ubIpqhUY8mKfI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=spUHly90a3udbhkIShgn6LnJQJvk0fm6rNNlGexa8Me7b9kPk4K2u6BnmFoahJNj2
	 rd8afSsDu07fX9qFZnd2UT538fi7SKv/W879+kArC+8AERml0pRH/A4c5oz0P3rXg7
	 8v/iFr34wFQvbFzAipGSFsPTclXQhxmaIN9RcyiNR7HBanxsKp/7qaU1c6ZcKaUAki
	 LfWT4T67p+r5LAkw4+5kqkWKRZfVOsQfvfKPUMxI8N7qVNfvszc1aK4Z/bS9H450MU
	 pWx8R6450FXfvUKWsOLOL+kZgo4mJ3sZMOndlqAUsTcptsJVFCnQcrEqn+OTdNjMNs
	 vCOXkRXJOHdRQ==
Message-ID: <3e12abeb-ea9e-4e2a-876c-4918368511e9@kernel.org>
Date: Thu, 14 May 2026 09:16:25 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next v3 2/6] netshaper: Add bw-min and weight
 parameter support
Content-Language: en-US
To: Mohsin Bashir <mohsin.bashr@gmail.com>, netdev@vger.kernel.org
Cc: stephen@networkplumber.org, pabeni@redhat.com, kuba@kernel.org,
 ernis@linux.microsoft.com, alexanderduyck@gmail.com,
 Claude Assistant <noreply@anthropic.com>
References: <20260511183915.797792-1-mohsin.bashr@gmail.com>
 <20260511183915.797792-3-mohsin.bashr@gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260511183915.797792-3-mohsin.bashr@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: BF6FF544019
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288021-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FREEMAIL_CC(0.00)[networkplumber.org,redhat.com,kernel.org,linux.microsoft.com,gmail.com,anthropic.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/11/26 12:39 PM, Mohsin Bashir wrote:
> @@ -33,11 +33,13 @@ static void usage(void)
>  		"OPTIONS := { -V[ersion] | -c[olor] | -help }\n"
>  		"COMMAND := { set | get | delete } dev DEVNAME\n"
>  		"	    handle scope HANDLE_SCOPE [id HANDLE_ID]\n"
> -		"	    [bw-max BW_MAX]\n"
> +		"	    [bw-min BW_MIN] [bw-max BW_MAX] [weight WEIGHT]\n"
> +		"\n"
>  		"Where: DEVNAME         := STRING\n"
>  		"       HANDLE_SCOPE    := { netdev | queue | node }\n"
>  		"       HANDLE_ID       := UINT (required for queue/node, optional for netdev)\n"
> -		"       BW_MAX          := UINT{ kbit | mbit | gbit }\n");
> +		"       BW_MAX/BW_MIN   := UINT{ kbit | mbit | gbit }\n"

BW_MIN/BW_MAX


