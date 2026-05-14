Return-Path: <netdev+bounces-287774-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHWhDF4pBWpUTAIAu9opvQ
	(envelope-from <netdev+bounces-287774-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 03:46:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BDEA353CD49
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 03:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3C575300DD71
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 01:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8153E2C21F8;
	Thu, 14 May 2026 01:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OjCmNiAa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5D729E0E5
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 01:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778723162; cv=none; b=ty6DaB+eNXY++cLF9USj/R43py2VygLQZdV0PyjuQfOSmEICxjkRjST1SCcmtsJqJh7JNNUDEEbySaO+tk6CM8XIJQ7AfLkw1JjX/eps2nmkORniSSn2Lf2QE4qhes8pTAlxOJx4/s+1t/9JpU9dufK5Mk8vHQx69P7jZfZZ4j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778723162; c=relaxed/simple;
	bh=zDhRmMjeNUSoCCokrAERomrrsIpx+i8+quKKevHInLg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=piQuAEWyZm9HgJf/6iETxvgY+htiKHAAb7rEucRAbq0Jtfj8jBJ5K2kZ1NH/Q+ANMOibCjxNvdqh2zpNt0tfMVcDdKvN/DC/SifNI4s74rBw3a/8u2z65EPfRtvoYdgRLCuLQ9/TiBM49ap9MC79kru51h7X3i/P6g4hOXWhjAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OjCmNiAa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8263EC19425;
	Thu, 14 May 2026 01:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778723162;
	bh=zDhRmMjeNUSoCCokrAERomrrsIpx+i8+quKKevHInLg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OjCmNiAaQVOcBnyZUpo8pE9Lsap8Cr50X+rM5SkF/aZWGW6t2bGtA3iYMwQdXfyLu
	 lpn/fIcXMXporp9VjOK5Z17ex2Ai/QjNho/iOdhVhR9/E6gbOnufM3kxLRxrKjNcPw
	 F1Xv3Jveyt+Thrb0ifnmGOoHTDTt41izgke17aOrNL+Zyy6O8IaSIdzRDc6XfXHjzg
	 KdnKQ7urk795LJt5jBi1Flcz5BmVdzYu5q5urYF2HCVbRxiNvOv6gGtHGmPht3WIA6
	 /f8XplEO+SmJ2aolUd2GzIFfQQS3KJqyu14+7334ddVKd0eM6EyCSkB/e3YreR3HYN
	 uw0JeB0n5f7Kg==
Date: Wed, 13 May 2026 18:46:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Wei Wang <weibunny.kernel@gmail.com>
Cc: netdev@vger.kernel.org, Daniel Zahka <daniel.zahka@gmail.com>, Willem de
 Bruijn <willemdebruijn.kernel@gmail.com>, David Wei <dw@davidwei.uk>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Wei Wang
 <weibunny@fb.com>
Subject: Re: [PATCH v14 net-next 5/5] selftests/net: psp: Add test for
 dev-assoc/disassoc
Message-ID: <20260513184600.29c6f5a3@kernel.org>
In-Reply-To: <20260508042611.130945-6-weibunny.kernel@gmail.com>
References: <20260508042611.130945-1-weibunny.kernel@gmail.com>
	<20260508042611.130945-6-weibunny.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: BDEA353CD49
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,davidwei.uk,lunn.ch,davemloft.net,google.com,redhat.com,kernel.org,fb.com];
	TAGGED_FROM(0.00)[bounces-287774-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Thu,  7 May 2026 21:26:10 -0700 Wei Wang wrote:
> --- a/tools/testing/selftests/drivers/net/config
> +++ b/tools/testing/selftests/drivers/net/config
> @@ -10,5 +10,6 @@ CONFIG_NETCONSOLE_EXTENDED_LOG=y
>  CONFIG_NETDEVSIM=m
>  CONFIG_NET_SCH_ETF=m
>  CONFIG_NET_SCH_FQ=m
> +CONFIG_NETKIT=y

I think we consider K to before _ in the checking script

>  CONFIG_VLAN_8021Q=m

