Return-Path: <netdev+bounces-295841-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0i/gHyThImr0egEAu9opvQ
	(envelope-from <netdev+bounces-295841-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 16:45:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ACC0648F59
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 16:45:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=lDeuFoH4;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295841-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-295841-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B1C27308291B
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 14:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD493B7768;
	Fri,  5 Jun 2026 14:40:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF773264D7
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 14:40:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780670449; cv=none; b=H+sIz/25+Evp4zFwRLfjYor5S8zbeQ/LwgUUdE5vmSyIp2c7bFEg7ZFvXQ+GZ+2bTBuglR11brzvRA0dt480zTqegzsYf7T1Ay3utV6AlW0lYPaDjSwitKHoDa0xyBsGykKlA5MWvRuO32tkU7i3JR5PlMudvtcZQhcFsvrIgtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780670449; c=relaxed/simple;
	bh=18idaFULcNw/q5t4kbpqfPm5Fx521vHHVHwuR+KJ+Rk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YPXiEKC6Sw+NwRClcL8dinT9yHQCaM/SPlTVy0WcXjKiIKhKiLTm13w9aXJlUT5Y9AODrWXDRsNQbMuaLJQp7cCbo4Dii2DQC8gbrXzzYITQ7y3uYOr5HlfyZ1B8aHhKBD4xJMdL63hmp/LubOmSRrabRAwDgif67X4jMtuWa8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lDeuFoH4; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB0D21F00899;
	Fri,  5 Jun 2026 14:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780670448;
	bh=gn9zYwuucWBEJQnBQlOhMcpiYln/tT1dOkuqyc/sZOg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=lDeuFoH4JZ9vY41zFqxXdlF+RaCUYvHWMnD+spdw0Hg+9MPiX4wZOw8Tv8E88NmPl
	 j0s4HbFTAIxixTjWxo+tE+MDmdcZk9RDNKcOAKkR0P846hoGeJXxfxGKgd+rR6NFlB
	 mFJDKfQwlm8Q86SfVBDpjTzP3NYDqp3yBCBPPb7t556myXL4w7mKVgP4lauq3m8Oey
	 IDuhtphNKiGMNzDAOuLjZG1x/UO1281vJZwiWfzTdCPJ+M4L92fdEmZ7O0lwi5jZBd
	 sigm2u7Ry33mjDng7grgXXZplNocH3LuBrWZdnRG5559MKUQrrAgTWWsauY28N9Ec/
	 KRgv/wfOvhhTw==
Message-ID: <1db331d2-d65c-4175-8790-2657f5455cb9@kernel.org>
Date: Fri, 5 Jun 2026 08:40:47 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] neighbour: remove obsolete EXPORT_SYMBOL()
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20260605073426.2922242-1-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260605073426.2922242-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295841-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:idosch@nvidia.com,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[dsahern@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2ACC0648F59

On 6/5/26 1:34 AM, Eric Dumazet wrote:
> IPv6 can't be a module anymore, we no longer need to export:
> 
> - neigh_changeaddr
> - neigh_carrier_down
> - neigh_ifdown
> - neigh_connected_output
> - neigh_direct_output
> - neigh_table_init
> - neigh_table_clear
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/core/neighbour.c | 7 -------
>  1 file changed, 7 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



