Return-Path: <netdev+bounces-301824-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id i5JiJV+KPGrnpAgAu9opvQ
	(envelope-from <netdev+bounces-301824-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 03:54:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E476C241E
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 03:54:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=JpkAQxuM;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301824-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301824-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46E4D3032F70
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 01:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707B43839B3;
	Thu, 25 Jun 2026 01:54:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C41D383980;
	Thu, 25 Jun 2026 01:54:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782352475; cv=none; b=YVmPHRGyFwAylsCDmRQVt4v3IRhY3zaugaYMsvimh8R+gFzjeDQa3lQA+J5Rvy0iUwAm4cOvEfWZy/IJFVylqBKrQS6tOk29VAaPDks4WhCYKj2CJO85a8S9sOLZ8UQDKw0aSg16I4hpObfT7tOzEvWKmcO9KjN8MR0Tdfc9W3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782352475; c=relaxed/simple;
	bh=97fKS2/77xyGAj6E6rnQNr+rlMBH79HuffSZ9p3mgtw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XHM3z1TRMNMhoueN4kaeGlFsaMYWZIDpFAk341o6J5q3cT3ataFl0UskaHxTcW5alKEjUF5abIO06FyB5eD+rgGc6dou59Z7WnT93v7O1Y47JvGrU3E6BioxJQhQtuZEud5sRXwoATA6cXm+e8WGVnqZ1OubISrE4D+rp+hXlrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JpkAQxuM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A59FD1F000E9;
	Thu, 25 Jun 2026 01:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782352474;
	bh=7R6Poq8sjGJXdHlWLk9FmKhkwwl1mLRpvuQp6vXdjOE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=JpkAQxuMRLKvWMLzENnWMzqNWPedjCxwzoF/vhwwERpDEob+HLiRWcxkE1Ui0LiNJ
	 LCZtvigND+x8B+T9wnJe1T6umMZA9huUYIqg6GJoLqCYeN033YMx7du4j/5KhLBCga
	 X8c2SYoDdSk1aKyZAXkLuM/LaCxOe4cAR1RrZD10rDIPVgq21+XwNV/aavS5kwCKtZ
	 EkrFbxyEv/DSXIU8mNrliRNhzUBBde+jBnMMBrBsJT/QmjVMZ7jKEoKtMFzB41XZBR
	 f/QvR0N/5c0mAKcg/XEOD2Jc0bZHgtoTBfb2UN+BgWbEAuGfcDX9xH3jbbJYBu+bb3
	 Olurw15xzujfw==
Date: Wed, 24 Jun 2026 18:54:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Siddharth C <siddharthcibi@icloud.com>
Cc: ast@kernel.org, hawk@kernel.org, andrii@kernel.org,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/2] bpf: preserve rx_queue_index across XDP redirects
Message-ID: <20260624185432.32d90aa8@kernel.org>
In-Reply-To: <20260620121321.45227-2-siddharthcibi@icloud.com>
References: <20260620121321.45227-1-siddharthcibi@icloud.com>
	<20260620121321.45227-2-siddharthcibi@icloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:siddharthcibi@icloud.com,m:ast@kernel.org,m:hawk@kernel.org,m:andrii@kernel.org,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-301824-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[icloud.com];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,rxq.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 16E476C241E

On Sat, 20 Jun 2026 12:13:13 +0000 Siddharth C wrote:
> diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
> index 5e59ab896f05..8f2d7013620f 100644
> --- a/kernel/bpf/cpumap.c
> +++ b/kernel/bpf/cpumap.c
> @@ -197,7 +197,7 @@ static int cpu_map_bpf_prog_run_xdp(struct bpf_cpu_map_entry *rcpu,
>  
>  		rxq.dev = xdpf->dev_rx;
>  		rxq.mem.type = xdpf->mem_type;
> -		/* TODO: report queue_index to xdp_rxq_info */
> +		rxq.queue_index = xdpf->rx_queue_index;

Do you actually need this or you're just trying to address the TODO?
You can always store the info you need in the metadata prepend.

>  		xdp_convert_frame_to_buff(xdpf, &xdp);
>  
> diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
> index dc7b859e8bbf..f419fa0e53e5 100644
> --- a/kernel/bpf/devmap.c
> +++ b/kernel/bpf/devmap.c
> @@ -339,7 +339,7 @@ static int dev_map_bpf_prog_run(struct bpf_prog *xdp_prog,
>  				struct net_device *rx_dev)
>  {
>  	struct xdp_txq_info txq = { .dev = tx_dev };
> -	struct xdp_rxq_info rxq = { .dev = rx_dev };
> +	struct xdp_rxq_info rxq = { };
>  	struct xdp_buff xdp;
>  	int i, nframes = 0;
>  
> @@ -349,6 +349,9 @@ static int dev_map_bpf_prog_run(struct bpf_prog *xdp_prog,
>  		int err;
>  
>  		xdp_convert_frame_to_buff(xdpf, &xdp);
> +		rxq.dev = rx_dev;
> +		rxq.mem.type = xdpf->mem_type;

Why are you setting mem_type?

> +		rxq.queue_index = xdpf->rx_queue_index;
>  		xdp.txq = &txq;
>  		xdp.rxq = &rxq;

