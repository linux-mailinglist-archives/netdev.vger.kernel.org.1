Return-Path: <netdev+bounces-294378-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bA1NGxEuH2rKiQAAu9opvQ
	(envelope-from <netdev+bounces-294378-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 21:25:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 12175631624
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 21:25:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Cb0ZTrCG;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294378-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-294378-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9A3923024E0E
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 19:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B71DE3C8737;
	Tue,  2 Jun 2026 19:25:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3A43DA5A3
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 19:25:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780428303; cv=none; b=UUt3E/co5BxkKw2chIQC9H+yOgn2veuAmJHOEimtxzIjBHkMqeXK4MzkMVaJCg+zmFHw8VqpojHEkAIZ29uI/lYQValFRgOVPISIFYVvDsAuR/SDs/gblo0svMfkzrolD0rBahZVklE1B2NgypP5Vu6WkPQnyXrnvyO0odsqrf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780428303; c=relaxed/simple;
	bh=QdymjjW11+B0vxQdaIq0hRUu+ZWQs2nCqlXlNWNVGfA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pgf4wt+X4M4v/k3s3Ml7O75MRQmvu4Se5qBBXQxQbNWOYMEih3fCYYQ/QED7K8QeASELEw11Y5z1NJMXO8ULZo2MZa0N/d05S3cfp5w/g3nn+e+lRC2dRtqkvyE/NTWX1kSmfxMr2RuSUhJIBajS0fj2A2uyzeT3X/YqaEWKbno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cb0ZTrCG; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D57BE1F00893;
	Tue,  2 Jun 2026 19:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780428302;
	bh=+ujbgvaMsb/X7hcRsr/JpMFayhGLHviBM2WPg8igrY8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Cb0ZTrCGQ7zXMd9viMu34Xr7rK1h/tQ5wvPXs/RZlJREA5wBmf128BC07NxPrcNkj
	 7c3b5mGJ0GYlyzLk5/bgkw2YxXhAgPxGqvqtAAytzQuJIzt2lkn9+4s5Jm+sJt+Z1Z
	 awguTFoXqbayUI/eTkiUsWS7l8j9GbWk/VypKoHGGTo1uZfOvhI7DTEM02f3BFNpi2
	 UMvEh3PbSqK/UDCuxCiTE2FQcup3g9LLp0uIJvm7v9AD/rNKMFDAb74Ad7zNyVSHt4
	 mCPcKtkM1xsKHsapQoFgYN4rcEtDl1UfyjyQnLOxucfP4GmbAzVbJkoUuzaT4igtfM
	 WR1K18DoRUY5w==
Message-ID: <9d951e42-1df1-453e-85d6-a03ade8b4760@kernel.org>
Date: Tue, 2 Jun 2026 13:25:01 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] ipv4: raw: remove six obsolete
 EXPORT_SYMBOL_GPL()
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20260602165036.2712408-1-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260602165036.2712408-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294378-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:idosch@nvidia.com,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[dsahern@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 12175631624

On 6/2/26 10:50 AM, Eric Dumazet wrote:
> IPv6 can not be a module anymore, we no longer need to export:
> 
> - raw_hash_sk()
> - raw_unhash_sk()
> - raw_abort()
> - raw_seq_start()
> - raw_seq_next()
> - raw_seq_stop()
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/ipv4/raw.c | 6 ------
>  1 file changed, 6 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



