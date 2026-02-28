Return-Path: <netdev+bounces-262267-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wQnTL0N/o2n5FAUAu9opvQ
	(envelope-from <netdev+bounces-262267-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 00:50:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B991C9C22
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 00:50:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E790302417B
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 23:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70333176EF;
	Sat, 28 Feb 2026 23:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OyqTiH9r"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C3923C50A;
	Sat, 28 Feb 2026 23:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772322622; cv=none; b=bBwyFAxeY7VYG8aFBUh4QtjqrolswKNbGMUE5L3Yhfsfx1k7sUl8Kr05EwbuGikWi8t27Y6kdmT0neyev0K9T5xo8XlZN6SAG0fqubt7LsPVwZzGQ0xwfWp/xGE+1vEMcVEVp4KHwAb+99egJvzYBrBLi5PWBoqwq/98SvFUL1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772322622; c=relaxed/simple;
	bh=nVlPNvjcp5bH3FHH4gSFEM25vu7Wj0UJtLOs5CcgAmU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NL2LUdx/1G3PVm5adtC8XblMmF9AuzI6kDk+dUpOIcU1vX8EwrYOIDwFKFdYW+xuNEcAsrte4yUhAF9ky53o/WMkff/FCKS5ZxJ/morBCt/Rza6TQbvvfBNyEvIKc7NS+gQp4W7sVUU/PG3vxzUx0hBmK6+SZW1C6Eaie/xY+28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OyqTiH9r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE0A3C116D0;
	Sat, 28 Feb 2026 23:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772322622;
	bh=nVlPNvjcp5bH3FHH4gSFEM25vu7Wj0UJtLOs5CcgAmU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OyqTiH9rcOwH2NM3d0us8lnhjpGWEwpL9eT8h7L7vYWdy686PC/K+hP7Uium0c0Ig
	 HFRAzcdD9S40OFcFxR2jUoe/za+brX3OFaNfk4wGLN9LPcki9rrJ2PrEJgEb0E/tFc
	 CBqabPcX4cdQ35Bhsxv85QyMWzRv/M8I8cyuUbQeYF8ECnjTDtBXTCgABOqYKdyXs2
	 /mbOqa5qmSw0Ifq/P7xed047OGIc7LNoLXodTSNW3KIDLDXlkhegzAa1rDkhMSuPtG
	 E+kEA4n2mwCxeq9U+xPbpgsFG5kh3M70LVnIsnLbvMWlvwzcKJsVKRY4DEHm8FisjH
	 gbMI+fhVibQ8A==
Date: Sat, 28 Feb 2026 15:50:21 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jakub Sitnicki <jakub@cloudflare.com>, Paolo Abeni <pabeni@redhat.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf
 <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Network
 Development <netdev@vger.kernel.org>, kernel-team
 <kernel-team@cloudflare.com>
Subject: Re: [PATCH RFC bpf-next 0/5] skb extension for BPF local storage
Message-ID: <20260228155021.1dc9b127@kernel.org>
In-Reply-To: <87wlzydk12.fsf@cloudflare.com>
References: <20260226-skb-local-storage-v1-0-4ca44f0dd9d1@cloudflare.com>
	<CAADnVQKVfyh3_OZshvYf7GJUF-ph2eMfmaQsxNgwBJd1AJgXTQ@mail.gmail.com>
	<87wlzydk12.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,linux.dev,cloudflare.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-262267-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 35B991C9C22
X-Rspamd-Action: no action

On Fri, 27 Feb 2026 21:11:05 +0100 Jakub Sitnicki wrote:
> So to exhaust all alternatives I gotta ask - would you and Jakub be open
> to the idea of a plain byte buffer embedded in skb_ext and exposed as a
> bpf_dynptr?

I'm fine with that, but admittedly I (like you?) live in 
the comfortable universe of controlling which .config options
are suitable for the narrow use cases I care about.
So I don't really trust my judgment. Adding Paolo..

