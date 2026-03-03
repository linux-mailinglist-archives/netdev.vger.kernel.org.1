Return-Path: <netdev+bounces-263468-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNV4DjJzp2ljhgAAu9opvQ
	(envelope-from <netdev+bounces-263468-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 00:48:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1711F8739
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 00:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C7693077391
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 23:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B109F372EEF;
	Tue,  3 Mar 2026 23:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zd/08rzL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD39372687
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 23:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772581679; cv=none; b=ikr3PeLI2yEg1hWFN14RIpmpEgc33+/dOALbO9u7MMs7bpNLz/YLnaveGqTwaXZusqKTOTCd/zdkAN5+dVWf2iTl8ybwtZN5dCdswRipY6CYwDJxl50HZUj2dOJFtky2LX0gtGFKKRi5dHURDPKe2NFHJvcdJNcVIMV2zgv6DXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772581679; c=relaxed/simple;
	bh=9jDm+G7RdCl59yT6RWWg6MI5+TBnRDJ/FeWsZHEWLkM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VlK5Mrsk3Nio84oxp8exAmMMmuVDDii/5vauASrUuZmmwaaDZl24/ECqX3uqs+VzvCbYW224NGtvG3G6kXuGivZ7L5its2mGPOS51mw8PLdnDDWeEoCnPMq+CRsNZN6HaUvAh+lKh5ii0b37zAD1iLsf6NCvfPunC10Bg0qlYR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zd/08rzL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4829C116C6;
	Tue,  3 Mar 2026 23:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772581679;
	bh=9jDm+G7RdCl59yT6RWWg6MI5+TBnRDJ/FeWsZHEWLkM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Zd/08rzLc7M8JVyAGzKY+I8q10tP0ru1pj9BZKRvPi6tPOBuZ/2vWCYVl57irPgUl
	 pOK/vZ2KrDTPSGVI+eA9ZCDPO2eutkLLgYoZc6VQLP3+P09i/1Y+kqxY21hQ+hBj1q
	 QpMkrd/CxxOt9ztQtDmLKBaDMcZXqYMIbV3S7mUMxmbxFD38Kml9h7+JV59WTbfaCc
	 nKcwrVPEq/gRCfE/MISfk1FE3/hOWVksax5q2m+70nRIeDuik5B4BTn2SU0vtP70Ok
	 0FPexW65XMGrw7Jprf0hjBO+JWujM1OJOP7GZwagolD4H48nWOVlzNl5ufH01b6Nvs
	 tHN5Xi7PriR1g==
Date: Tue, 3 Mar 2026 15:47:58 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Joe Damato <joe@dama.to>, Wei Wang
 <weibunny@meta.com>, Bobby Eshleman <bobbyeshleman@gmail.com>, Stanislav
 Fomichev <sdf@fomichev.me>, Nikolay Aleksandrov <razor@blackwall.org>
Subject: Re: [PATCH net-next v2 3/4] selftests/net: Add env for container
 based tests
Message-ID: <20260303154758.0f55213c@kernel.org>
In-Reply-To: <20260302053315.1919859-4-dw@davidwei.uk>
References: <20260302053315.1919859-1-dw@davidwei.uk>
	<20260302053315.1919859-4-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 8F1711F8739
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,dama.to,meta.com,gmail.com,fomichev.me,blackwall.org];
	TAGGED_FROM(0.00)[bounces-263468-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Sun,  1 Mar 2026 21:33:14 -0800 David Wei wrote:
> +class NetDrvContEnv(NetDrvEpEnv):
> +    """
> +    Class for an environment with a netkit pair setup for forwarding traffic
> +    between the physical interface and a network namespace.
> +      NETIF           = "eth0"
> +      LOCAL_V6        = "2001:db8::1"
> +      REMOTE_V6       = "2001:db8::2"
> +      LOCAL_PREFIX_V6 = "fd00:cafe::"

Since you have to respin for the Makefile issue - could you rewrite this
to use 2001:db8 for all addresses? ULA is a funny and odd thing.

LOCAL_V6        = "2001:db8:1::1"
REMOTE_V6       = "2001:db8:1::2"
LOCAL_PREFIX_V6 = "2001:db8:2::0/64"

?
> +        try:
> +            net = ipaddress.IPv6Network(local_prefix, strict=False)
> +        except ValueError:
> +            net = ipaddress.IPv6Network(f"{local_prefix}::/64", strict=False)

dunno if the fallback is really necessary, not including the prefix
length is a bit of a bug IMO.

