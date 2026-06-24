Return-Path: <netdev+bounces-301799-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7/6gENxaPGqYnAgAu9opvQ
	(envelope-from <netdev+bounces-301799-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 00:31:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ECF26C1C4A
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 00:31:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=KXiSDVgr;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301799-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301799-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5319D3011861
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 22:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00DB139A7EF;
	Wed, 24 Jun 2026 22:31:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04848261B9B
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 22:31:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782340307; cv=none; b=ejSUt8ahWPJA2bIn9tu8Cvr83BZ6DVucyw66WMlSp2MnYXBkUUxvqZ7YbKUW1YyHS54U9gQQpCo7sISY9Iht9LDKttaIxKgQYYdhWLcd11YFtbzkBygz/OddBRixBuG4ghGtqoj3i+Hym4rNNKcOoe7bcDmgZyNVlFEP4rwE2Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782340307; c=relaxed/simple;
	bh=s8k3/6YIogxMvXLnwCat3AUIfmMsKkl7H7qfg4rEcpI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SB6IYE1d0kGlM6lot+SuMEnHjbvCYL9sgWnKesGeo+xOd7PqE6QuV65GrkMbYmxOddod3qseMCsL/CzToBNeBNGx6r+CI0O2FE0S1kcPFBrJInMo1wpw0foPBAEsW1UKlUQHBJpwFho6OLjlaqSIBpHnCCvCwl/D9O+e3areaZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KXiSDVgr; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C5771F000E9;
	Wed, 24 Jun 2026 22:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782340306;
	bh=mqDU0jYT7fql0ZGUSAd4YOFzVEzIxtmqJobN1DH6XcI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=KXiSDVgrG7pLxbQbzapAbBLTaHQBxEwYrQOmQPswMa8CHOoaVMhu6hl0ZI695ma7I
	 KSUWZs1lGxRsAnUw368ecjZfCya9TBbNmn7rCRYuXzplqJf5/9xYvJb/d3NQ522Al6
	 e/59VFoqmTgYXTcwXz1xsM1vgc9edhqfRGGqYHQlm44fh77qJzj20VHGJexphKnkoO
	 bhV8i7PhzFHH16nhXTI4XJhsLrIZFVIoxg8N1f7xx+ccY7TeSNVC4TA2iMOIkEK1vD
	 uko1sY77VMRC6amOOTg9WAE3UrFoh8i8c0vpq/Jomz7XL9EtUhKEf06dynZNOz814m
	 KgBm7Yg/WrbGA==
Date: Wed, 24 Jun 2026 15:31:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Ido Schimmel
 <idosch@nvidia.com>, David Ahern <dsahern@kernel.org>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, Yue Sun
 <samsun1006219@gmail.com>
Subject: Re: [PATCH net] net: udp_tunnel: fix use-after-free by refcounting
 udp_tunnel_nic
Message-ID: <20260624153145.3b0b9f49@kernel.org>
In-Reply-To: <20260624145722.083632b6@kernel.org>
References: <20260624171034.4117423-1-edumazet@google.com>
	<20260624145722.083632b6@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301799-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:pabeni@redhat.com,m:horms@kernel.org,m:idosch@nvidia.com,m:dsahern@kernel.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:samsun1006219@gmail.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,redhat.com,kernel.org,nvidia.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9ECF26C1C4A

On Wed, 24 Jun 2026 14:57:22 -0700 Jakub Kicinski wrote:
> so we just need:
> 
> diff --git a/net/ipv4/udp_tunnel_nic.c b/net/ipv4/udp_tunnel_nic.c
> index 9944ed923ddf..d7db89a222f8 100644
> --- a/net/ipv4/udp_tunnel_nic.c
> +++ b/net/ipv4/udp_tunnel_nic.c
> @@ -863,6 +863,7 @@ static void
>  udp_tunnel_nic_unregister(struct net_device *dev, struct udp_tunnel_nic *utn)
>  {
>         const struct udp_tunnel_nic_info *info = dev->udp_tunnel_nic_info;
> +       bool pending;
>  
>         udp_tunnel_nic_lock(dev);
>  
> @@ -899,12 +900,14 @@ udp_tunnel_nic_unregister(struct net_device *dev, struct udp_tunnel_nic *utn)
>          * from the work which we will boot immediately.
>          */
>         udp_tunnel_nic_flush(dev, utn);
> +
> +       pending = utn->work_pending;
>         udp_tunnel_nic_unlock(dev);
>  
>         /* Wait for the work to be done using the state, netdev core will
>          * retry unregister until we give up our reference on this device.
>          */
> -       if (utn->work_pending)
> +       if (pending)
>                 return;
>  
>         udp_tunnel_nic_free(utn);

Maybe not even.. by definition the driver should not race with its own
netdev's unregister? I don't get what the race is..

