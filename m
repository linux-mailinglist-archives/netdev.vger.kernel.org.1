Return-Path: <netdev+bounces-302277-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XqenLVX9Pmr8NwkAu9opvQ
	(envelope-from <netdev+bounces-302277-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 00:29:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B6F6D06ED
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 00:29:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=k2bFpxlt;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302277-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302277-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C689301B931
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 22:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF973C09F4;
	Fri, 26 Jun 2026 22:29:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EA13AD510
	for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 22:29:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782512978; cv=none; b=U4sL8nbI3Kr1cXcHNIgOvIv9oHAAxfexqOSZutjyFVXl71B799BIeTlfOc9rdHJceQAtK7Ctdmtvqsv4bhIC6XR78aPoxcp0CizX1MYUgC19Z47ByZyzjYhG/Ahdoi/OzUjiWKM8bPV2Rpv9HzXDkClZnrJNE00Lfe6G6lUaQzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782512978; c=relaxed/simple;
	bh=GjBxLbzrPN5i8iHbPTLj6GbG6RETFp6rUi+R2cHmzgI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aATA+PSfe2V+nD3vQRZCyBm63cUQgK/EY3MtXbALpLJPXIWa1V6ygUNW8OFG4Y3JvcsYomQoFeePnB8I5jWww4laIzt3XjnEZ6NA8YUzRK9yyTn8OCeAj4QVMth/eahXCbt0qJz9PoeOcP26C+82vM3R/PTk2W24r3Qb/v6mXBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k2bFpxlt; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 453C21F000E9;
	Fri, 26 Jun 2026 22:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782512977;
	bh=z/KOQXjMCL4+K9L12WXoB3UQ4LGC1afxPFJA9hVfjDA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=k2bFpxlt7Wm9C/8eujHy5dBqsKHRHfE+7Phr5425P0zVcZf5P3HfIXdwiYDsF7S7n
	 49W4wkBiHrCnY8cvl0dQxC+7KyTCydr35Ro8E/qX0lh0b9t+xlGntowCX4gcgTATnD
	 4XAeKALM4iLKt/KtufF8mdsu8Pq8JerCU9/JKGg6HNv0be+XBKiTzDMmPI6u/4qIA6
	 H9kMoLRPfq9ptcoD1NvFbRw37q590Hzog7+m1e3atx5xbiDGFmsznRYj4hxW4mbGTO
	 kTu1BWK6XIfWmKkWp6dSUpR8sTaTyh55Hos3O11SlyMAs0+Skdi5SdIwk4uc1H2rhB
	 QA09f1cdtAzIw==
Date: Fri, 26 Jun 2026 15:29:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next v5 1/2] ethtool: treat RXH_GTP_TEID as
 intrinsically symmetric
Message-ID: <20260626152936.7359509f@kernel.org>
In-Reply-To: <20260626054730.1126969-2-aleksandr.loktionov@intel.com>
References: <20260626054730.1126969-1-aleksandr.loktionov@intel.com>
	<20260626054730.1126969-2-aleksandr.loktionov@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302277-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:aleksandr.loktionov@intel.com,m:intel-wired-lan@lists.osuosl.org,m:anthony.l.nguyen@intel.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,paloaltonetworks.com:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 02B6F6D06ED

On Fri, 26 Jun 2026 07:47:29 +0200 Aleksandr Loktionov wrote:
> A GTP tunnel uses the same TEID value in both directions of a flow;
> including TEID in the hash input does not break src/dst symmetry.
> 
> ethtool_rxfh_config_is_sym() currently rejects any hash field bitmap
> that contains bits outside the four paired L3/L4 fields.  This causes
> drivers that hash GTP flows on TEID to fail the kernel's preflight
> validation in ethtool_check_flow_types(), making it impossible for
> those drivers to support symmetric-xor transforms at all.
> 
> Strip RXH_GTP_TEID from the bitmap before the paired-field check so
> that drivers may honestly report TEID hashing without blocking the
> configuration of symmetric transforms.

I don't know much about GTP, but "the Internet" does not seem to agree
with your claim:

  The TEID uniquely identifies the GSN tunnel endpoints. The tunnels 
  for an uplink and a downlink are separate and use a different TEID.

https://docs.paloaltonetworks.com/service-providers/10-1/mobile-network-infrastructure-getting-started/gtp/mobile-network-protection-profile

So I don't think this will fly..

