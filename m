Return-Path: <netdev+bounces-298622-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id l5vBBqT6K2q7IwQAu9opvQ
	(envelope-from <netdev+bounces-298622-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 14:25:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE19679589
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 14:25:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=LeIUvZH3;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298622-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298622-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 939B43006B75
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 12:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C4739A7F6;
	Fri, 12 Jun 2026 12:25:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC6B395DAA;
	Fri, 12 Jun 2026 12:25:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781267105; cv=none; b=ebtmSI5Z0zOMh01u8LPtPzYZew1L6RlD9NXgMpJ4VFvmZMb5A9klYKLAuwe6bySUgw70fAftrC3h9jQXDk8YpqCrUmhtdbLt2tzJCEF5yfPFcz6LRcDG05QiVaSHWcoRspUJh/U0Aab+pzSU0LqChdw3Pv08oG4Vbk27gCB0nGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781267105; c=relaxed/simple;
	bh=8efJRhmrPygmrpPFw77bhT6JwWU62/INICk2jAhtO3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JzJlp4SD+nZNkldNUIdgrBuUASkEOB9kcESm2sNXIjXCAe6zIUjWG9QTTkDwzfbUnBlH4NDAS5CrVQc5MmgawY0A7lZCNvy/hSGPmX/8y5lTz27l7sNQrhFJj4eYQoSB+sZIRVN71DTtgIXGSFSbITFmcXC61E3qChZmbs2uEMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LeIUvZH3; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7B271F000E9;
	Fri, 12 Jun 2026 12:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781267104;
	bh=XyKeMQWx3qJwTBdaxlwr+ooF5i8jx3bmcjQwKrMhwiQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LeIUvZH3PIpohuB3LmYWMygUfc0OLrtkT13i5zT4gaGGH713+8TOGXFjnCqFceZwe
	 PbXzJYmk9jKDh1Xu9RNIDJC43Nc5u+eczm7K3gQOkAiU7FInTbJsbzzTr8SRR2Yjvn
	 AFK2DKqudWBGWNkWv2ojBr8iXqObYT4IYZpXbpMn8Z6CdOsocnsoSrGsEKjCqVXWTE
	 BDtLMDyHwYa6cbqYOp6qP6beZnByg8SAT53B58iSe9STKBWSKawGeVv3GA0mZkjLgQ
	 rcaZBIt4o/l5Wuw3UHFSmk/6s71fKNMQ7nT8jxKm+lnaZGYsh6OoTJY9B78Cc1x+DL
	 lzrfJi50RaaNQ==
Date: Fri, 12 Jun 2026 13:25:00 +0100
From: Simon Horman <horms@kernel.org>
To: Doruk Tan Ozturk <doruk@0sec.ai>
Cc: david@ixit.cz, oe-linux-nfc@lists.linux.dev,
	david.laight.linux@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4] nfc: llcp: bound SNL TLV parsing to the skb and
 add length checks
Message-ID: <20260612122500.GB671640@horms.kernel.org>
References: <20260609202543.42282-1-doruk@0sec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609202543.42282-1-doruk@0sec.ai>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-298622-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:doruk@0sec.ai,m:david@ixit.cz,m:oe-linux-nfc@lists.linux.dev,m:david.laight.linux@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:davidlaightlinux@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[ixit.cz,lists.linux.dev,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,sashiko.dev:url,vger.kernel.org:from_smtp,0sec.ai:url,0sec.ai:email,horms.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4AE19679589

On Tue, Jun 09, 2026 at 10:25:43PM +0200, Doruk Tan Ozturk wrote:
> nfc_llcp_recv_snl() walked the SNL TLV list using a u16 offset/length
> pair derived from skb->len, without bounding reads to the actual skb
> data. Three problems followed:
> 
>   - For a short frame (skb->len < LLCP_HEADER_SIZE), tlv_len underflowed.
>   - The per-TLV header (type, length) was read without checking that two
>     bytes remained.
>   - A declared TLV length could run past the end of the buffer, and an
>     SDREQ with length == 0 made "service_name_len = length - 1" underflow
>     (size_t), driving an out-of-bounds read in the following strncmp() /
>     nfc_llcp_sock_from_sn(). The SDRES case likewise read tlv[2]/tlv[3]
>     without a length check.
> 
> A nearby NFC device can reach this without authentication; LLCP link
> activation happens automatically after NFC-DEP.
> 
> Walk the TLV list by pointer, bounded by skb_tail_pointer() over the
> linear skb data, and validate each TLV declared length before use. Add
> explicit length checks for SDREQ (>= 1) and SDRES (exactly 2).
> 
> Found by 0sec automated security-research tooling (https://0sec.ai).
> 
> Fixes: 19cfe5843e86 ("NFC: Initial SNL support")
> Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>

Reviewed-by: Simon Horman <horms@kernel.org>


FTR: There is AI-generated review of this patch-set available on both
     https://sashiko.dev and https://netdev-ai.bots.linux.dev/sashiko/
     While I don't think that review should effect progress of this patch
     you may wish to consider it in the context of possible follow-up.

