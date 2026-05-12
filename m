Return-Path: <netdev+bounces-287117-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8ElNMqkdA2r10gEAu9opvQ
	(envelope-from <netdev+bounces-287117-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 14:31:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4263E5202A6
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 14:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9B6C5308F6B6
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 12:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961D837C917;
	Tue, 12 May 2026 12:27:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF323B8BCB
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 12:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778588825; cv=none; b=aK42kau1QSVmGU2QsI4HFlcx3Srd7ERdkQ+WH7k9jIftLaL8io+iYFKmukp8avyzglZaV2nezbE8j1G6qmeVIGH2cnNEdmSNzWcbW6z94pp7Q3SpdHO42HNM04AMMv4wHGJOxxZPGVx5RiR217528a2BAM+/mdcXwL4Ul/G8pWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778588825; c=relaxed/simple;
	bh=yZqum8aQjfqQt6nz3oqR7Y9o2hlrz7TSFbWdaEDj5Jg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y1wpkBna/4kUinxyedkS5IiQ7iTOt222nGb7UfO5H0Ps7Wb5NXVKyckToHsy2oCMbQJFAsBzQg6QEOymgBT81mYQtiJwFZ69AeWxJRKXs/UPe1hBheSTPsDl3m3yqhraZBVEDjmd4lI8gluNhRwuNPos30KUv/Kkh3j10Gb48Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D7C7C2BCF5;
	Tue, 12 May 2026 12:27:02 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: kuba@kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	horms@kernel.org,
	idosch@nvidia.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net] MAINTAINERS: update the IPv4/IPv6 entry and add Ido Schimmel
Date: Tue, 12 May 2026 14:27:01 +0200
Message-ID: <20260512122701.2656064-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260428203924.1229169-1-kuba@kernel.org>
References: <20260428203924.1229169-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4263E5202A6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-287117-lists,netdev=lfdr.de,renesas];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[glider.be];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@glider.be,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.597];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,davemloft.net:email,linux-m68k.org:email]
X-Rspamd-Action: no action

On Tue, 28 Apr 2026 13:39:24, Jakub Kicinski wrote:
> The IPv4/IPv6 and routing code is not very well separated from
> the TCP/UDP code. Scope it down properly by providing a more
> accurate file list, instead of net/ipv4/ and net/ipv6/
> 
> Now that the entry is more accurately representing layer 3
> and routing merge in the nexthop entry into it.
> 
> Add Ido Schimmel as a co-maintainer, Ido's git history speaks
> for itself.
> 
> Reviewed-by: David Ahern <dsahern@kernel.org>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Thanks for your patch, which is now commit e73cafaf4acea544
("MAINTAINERS: update the IPv4/IPv6 entry and add Ido Schimmel") in
v7.1-rc2.

> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18672,19 +18672,59 @@ F:	net/xfrm/
>  F:	tools/testing/selftests/net/ipsec.c
>  
>  NETWORKING [IPv4/IPv6]
> -M:	"David S. Miller" <davem@davemloft.net>

Is this removal intentional? It is not mentioned in the patch
description.

>  M:	David Ahern <dsahern@kernel.org>
> +M:	Ido Schimmel <idosch@nvidia.com>
>  L:	netdev@vger.kernel.org
>  S:	Maintained

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

