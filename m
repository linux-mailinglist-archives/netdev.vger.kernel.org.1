Return-Path: <netdev+bounces-267273-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kF+zDF51s2loWgAAu9opvQ
	(envelope-from <netdev+bounces-267273-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 03:24:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B7E27CB2F
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 03:24:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9867C308B745
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 02:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712D6340286;
	Fri, 13 Mar 2026 02:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GAfkFZLt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A3E33FE05;
	Fri, 13 Mar 2026 02:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773368573; cv=none; b=gG+rO6tWB+khB0gvestj2dnInaUkfmHMjO2aKU2zNAr85GxKaQnkjEdBwlnV5qyHf5VrPAyJ+b9m4HU0jzVwSgDtyTfu50MGJ8TQpMdStQVESMVLyI7JUY0fVrN1zwMQI3o3HR/m8MtvVRgCh5SeP0IfBRBpV+gSkfDLqTT4/AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773368573; c=relaxed/simple;
	bh=70xGEyGDgOgnf31VEtVCOBWcG9h6+8Ya5+AMeOljfx0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HjKK3WkvpoqdnAIFKDGAsCi7IHK3pQvjBGFgBjzA6pCQe5OBNIRoqMcknDySclupW8xEKWm2KkGDwKQEtgV9Ri4PsM/X3sy+uQuSgW4wgEDBFMRgi1lHfcDKZjk+nS9W3oSw6UdQvXmCHhgy3zcp9F6m8p5A05tGwvUPevsQGFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GAfkFZLt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EE1DC4CEF7;
	Fri, 13 Mar 2026 02:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773368573;
	bh=70xGEyGDgOgnf31VEtVCOBWcG9h6+8Ya5+AMeOljfx0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GAfkFZLtVma5j9wqieMccxhCfXv/0Kb6OKAnVtm9AxDmRZBCjs+xEbb5LBLrEpF+i
	 Q7cgDngvSkBkOSo9HTxYi5SpsK0/NXbtjfkXr7Rq4op+4bxovPRQKZu8kRCctzew0i
	 L4BzdHaL7gcZHzbU4BBNNiyOU3vJwa+i2T8lLmPvKmOZDyEKEFPrJVPlJdStqYMrQR
	 I5+683fEtaEuiHHSMlU/09vmGB0t/bMGpWgyMpj9pMyhIEwzH+8YBWO5DaVhC/7LfK
	 G5xU7F0Jx0e2CeXtcitBUUE7RDW7YBDeQ/VMe9j+cNzLgm/HIp8RXqL+Y5qgeF6lPF
	 pVa0/gQ/dol5g==
Date: Thu, 12 Mar 2026 19:22:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, vsrama-krishna.nemani@broadcom.com,
 vikas.gupta@broadcom.com
Subject: Re: [PATCH net-next v6 10/10] bng_en: add support for ethtool -S
 stats display
Message-ID: <20260312192251.61243873@kernel.org>
In-Reply-To: <20260310144044.21672-11-bhargava.marreddy@broadcom.com>
References: <20260310144044.21672-1-bhargava.marreddy@broadcom.com>
	<20260310144044.21672-11-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-267273-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 93B7E27CB2F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 10 Mar 2026 20:10:44 +0530 Bhargava Marreddy wrote:
> Implement the legacy ethtool statistics interface (.get_sset_count,
> .get_strings, and .get_ethtool_stats) to provide per-queue and
> port-level visibility.
> 
> A. Exclusions:
>   To comply with the "no duplication" policy, excluded all stats already
>   covered by rtnl_link_stats64.
>   For ex:
>   1. tx_err
>   2. tx_fifo_underruns
>   3. tx_total_collisions
> 
> B. Retained Stats Analysis:
>   Retained the counters which provide unique per-queue granularity or
>   represent different hardware events:
> 
>   1. rxqN_errors
>   2. txqN_errors
> 
>    These provide per-ring visibility for debugging.
>    While they look similar to ndo_get_stats64's [rx/tx]_errors counters,
>    they map to different hardware sources:
>    For ex:
>    - ethtool rxqN_errors: ctx_hw_stats->rx_error_pkts (per-ring)
>    - ndo_get_stats64 rx_errors: (rx_port_stats->rx_false_carrier_frames +
>      rx_jbr_frames) (per-port)

Still a lot of stuff here that has standard APIs. Here is random 4:
 - oom_discards
 - rx_total_frames
 - link_down_event
 - rx_fec_corrected_blocks
Please explain what the per-ring errors and discards are exactly.

