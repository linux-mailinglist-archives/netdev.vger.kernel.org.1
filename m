Return-Path: <netdev+bounces-306115-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yyl/JntqT2pVgQIAu9opvQ
	(envelope-from <netdev+bounces-306115-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 11:31:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF78172EF86
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 11:31:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=Jlw+qUrd;
	dmarc=pass (policy=none) header.from=linux.dev;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306115-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306115-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9128B30696CB
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 09:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B843EEACE;
	Thu,  9 Jul 2026 09:30:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6DF374E66
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 09:30:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783589409; cv=none; b=g3rTSbXS1CVpGP14nBEEaGKK4YFb7K+Y0ZqdvEq6hNz80uIc9axgqpKNIH7176mKm6Dr9j4OZ4wJFxXIAZVivjfQeQTd2xxP5jgyJLWmG6gpGLYH/rM9Yib7vaOSRpgiQDSYYdawJN4LxCG3ZDbEeVjgtnA+duSy/xFpvYLCeEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783589409; c=relaxed/simple;
	bh=WcLpTNgXteV+1I3Yv9kbxguCi72yncRISpDGfUY2+Zc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mvYkcZffUnn18raJB31js0syNSF2VA60BuL1ijetxXKyJMu5RHnNT1nQqJ2a5s1i2eV/zUFdhgwPqmara3USLP50c+GFdi03p39NObLg5Vaw71EWVskr7KNnxV2WtVockmJkJ8iP2oAjfu9zhYJPjCmI8YfJj3zFLblzNppESUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Jlw+qUrd; arc=none smtp.client-ip=91.218.175.188
Message-ID: <9e1d71b5-f3c8-4b96-a2e0-cc83ef7f38cf@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783589395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZvVJY+QMF/10NBIDrBLoXoGcw1iTZ414fZExGXzKIik=;
	b=Jlw+qUrdLHKd4Zp4rJN9eDyWpQUMcUc5okjOIVPgCjKe9MyZVTFw/bKC5dXtgcpueoOp0+
	JQSr9FIwhqJT7VjoOlhAW3RJEgVnwNSglN3pr18A5HTxEbjBXEmhVa4KAIgCAbZ4/PhrLq
	bQTeAcqzZeTTB9aNNre9BZnVfTCo9tA=
Date: Thu, 9 Jul 2026 10:29:46 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v3] tipc: fix u16 MTU truncation in media and bearer
 MTU validation
To: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
Cc: AutonomousCodeSecurity@microsoft.com, davem@davemloft.net,
 edumazet@google.com, horms@kernel.org, jmaloy@redhat.com, kuba@kernel.org,
 kys@microsoft.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 pabeni@redhat.com, tgopinath@linux.microsoft.com,
 tipc-discussion@lists.sourceforge.net, tung.quang.nguyen@est.tech
References: <7a6d7de8-7c33-42fd-a0f3-68bc1911b0e5@linux.dev>
 <20260708224129.3722-1-blbllhy@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260708224129.3722-1-blbllhy@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS(0.00)[m:blbllhy@gmail.com,m:AutonomousCodeSecurity@microsoft.com,m:davem@davemloft.net,m:edumazet@google.com,m:horms@kernel.org,m:jmaloy@redhat.com,m:kuba@kernel.org,m:kys@microsoft.com,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:tgopinath@linux.microsoft.com,m:tipc-discussion@lists.sourceforge.net,m:tung.quang.nguyen@est.tech,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[vadim.fedorenko@linux.dev,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-306115-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vadim.fedorenko@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:from_mime,linux.dev:dkim,linux.dev:mid,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EF78172EF86

On 08/07/2026 23:41, Cen Zhang (Microsoft) wrote:
> Sadly NLA_POLICY_MAX() cannot be used here -- its .max field
> is s16 instead of u16 in struct nla_policy, which will
> overflow to -1 during my testing.
> 
> Please let me know if we have any other better choices.
> Otherwise, I'll prepare a patch adding .min check (
> TIPC_MIN_BEARER_MTU).

Ah, yeah, you are right, let's keep full range check

