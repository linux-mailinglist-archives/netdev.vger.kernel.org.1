Return-Path: <netdev+bounces-296697-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cumqONkRJ2q2rAIAu9opvQ
	(envelope-from <netdev+bounces-296697-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 21:02:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 32ECE659F86
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 21:02:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=iSV5nJDm;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296697-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296697-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E250B3055816
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 18:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56677349CCF;
	Mon,  8 Jun 2026 18:47:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419BD25782A;
	Mon,  8 Jun 2026 18:47:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780944459; cv=none; b=tld73xi6m8VTzkJO2MRSUM2/OdGF9uQazu2JXXVNvX8TKsEwpNXO21sdDnv8rcz84Ql2yRRkxMGfaJx3AkhFQsCvalDkUmACDh2jUUrj5mn92Wcuir3ws6JwZQbFyzaJOpgNe6PXNeYv60zNb5dHKMyE+iSctAha4BXplYAuCzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780944459; c=relaxed/simple;
	bh=rPTlTseugqTt8+Ydju2GJZuV4m26u0vKUx87Hlan5Xs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NcxkfpgZrtg5llaA2u4hEKfn4FPowYu80oCzg7petV/WMjZ703NwjsN95xXwRlKiDv+4XsMG7L7BkSkbVwVA1US5g8dYAHhW14E/1156N+KbN6E3Vo6UiAhVIcD82aSS/zWZBaSTFWeoBVv+Rb9L/1cZlHsAxi8W3U28n9gIvAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iSV5nJDm; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68B251F00893;
	Mon,  8 Jun 2026 18:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780944458;
	bh=lyf/y2u1bO4hUmn6dQhfqSR5sYdLExgnJf82uOJss00=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iSV5nJDm4y9J2F7I06C098oJYHO5v1Ymc7DeaoT/wkUoGAU3LYd1mCNeowCzdhya+
	 cBPW3IKjvuS0yx1YbAS9tt02rHjznUMYJB/oSmDfKx/xCThhe2UdtwBwu3h1FFwDpp
	 dRIDJvkc1Ra2COgc7pqBAoeIIf7EtuJ+BA8yf+21Za3HnTs4+3SBd+YlomYKF/iwU0
	 tjNZKNYB2W45ZrelRYj4SBokZZlmz4ELPjdhHqDruNGS5sey2s9NJRdQkcKdJW77Ho
	 zqNeHjWrJAtNdVLjxFmBb6VIW4Qb7BXoxFokf2OSbwY4p+9ExYYiT+BogjPiyc75Ak
	 uA0HpE0Hx9+Yw==
Date: Mon, 8 Jun 2026 19:47:33 +0100
From: Simon Horman <horms@kernel.org>
To: Kshitiz Bartariya <kshitiz.bartariya@zohomail.in>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, aleksandr.loktionov@intel.com,
	jacob.e.keller@intel.com, jedrzej.jagielski@intel.com,
	piotr.kwapulinski@intel.com, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] ixgbe: implement get_queue_stats_rx
Message-ID: <20260608184733.GJ3920875@horms.kernel.org>
References: <20260603174857.78666-1-kshitiz.bartariya@zohomail.in>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603174857.78666-1-kshitiz.bartariya@zohomail.in>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296697-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:kshitiz.bartariya@zohomail.in,m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:aleksandr.loktionov@intel.com,m:jacob.e.keller@intel.com,m:jedrzej.jagielski@intel.com,m:piotr.kwapulinski@intel.com,m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,vger.kernel.org:from_smtp,horms.kernel.org:mid,sashiko.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,zohomail.in:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 32ECE659F86

On Wed, Jun 03, 2026 at 11:18:51PM +0530, Kshitiz Bartariya wrote:
> Hook into the netdev_stat_ops interface to expose per RX queue
> statistics through the netdev generic netlink API.
> 
> The following counters are filled:
> 
>  - alloc_fail: sum of alloc_rx_page_failed and alloc_rx_buff_failed
> 
>  - csum_bad: maps directly to csum_err, which is incremented for both
>    IP header and L4 checksum errors in ixgbe_rx_checksum().
> 
> The new per-queue stats can be observed with:
>   $ ynltool qstats show scope queue
> 
> Signed-off-by: Kshitiz Bartariya <kshitiz.bartariya@zohomail.in>
> ---
> v2:
>  Amended commit message with command to get RX queue stats as 
> suggested by Jedrzej Jagielski.
> 
> v1: https://lore.kernel.org/lkml/20260602100932.21838-1-kshitiz.bartariya@zohomail.in/
> 
> 
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)

Hi Kshitiz,

There is AI-generated review of this patch-set available on both
https://sashiko.dev and https://netdev-ai.bots.linux.dev/sashiko/
I would appreciate it if you could look over that.

