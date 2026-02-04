Return-Path: <netdev+bounces-256855-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6M8fCvfLg2m6uQMAu9opvQ
	(envelope-from <netdev+bounces-256855-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 23:45:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CAA1ED0E0
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 23:45:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 440AC30182B8
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 22:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E94238F225;
	Wed,  4 Feb 2026 22:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mDPzL3+A"
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FB838B986
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 22:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770245065; cv=none; b=EbPj6KzG21xPJ2Eamr1JRkFuabv/duNArxTYtfS/BFqBO1z610UMFHxpe8qTuq+MOVWjDu3OQUHBfJWRmivqd5OdPNgbmcBnBAMOBSIz6d1DmxUPNOXniGygNq0x+CwucsdTqxHM53K/RNw7N/LntSRRJKt7sxUHDbH8apWZfuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770245065; c=relaxed/simple;
	bh=oRv8IAXE2m2eev4ZylxxZFrc5LS8Dd1TT9UnZ1lCPaQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z4XXysteXdhVwXOQiKfUpeqDLpjzcFxpMOcVSHVR5oyqiJDG9z4r4DM/qhGOv8HQNgbi8JN/+zOrlwCWZVRqSM0xJNBpfs0GQrUtPO0eCJ4IKFORfEgHR5TnX1M3s18E/9FXZGRzDXtGZIBwNJ+khhroBwY1Ok6QucaKghj8OSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mDPzL3+A; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f08dc67a-059f-4f5c-86c1-4c51b8939b56@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770245062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qSUw9bwce56DZz1u0SBYzca0iWcxiBGlQ0CXcrp4AYI=;
	b=mDPzL3+A/l8YA/8AOIjYxDOpOrMvFbzLLt4BD/BscIZoPJPl8fLn7lD9vjLJ0O1y3VBBda
	kTPKWCzlXm2iLMwKgFgB2GdV8a/VLew+98xf+55kK6ORiOXPbM7cXSv0kLSLn07SdxTxxT
	7WT4SdYQEAu7HGPZMLcxCuhZVDVBKGY=
Date: Wed, 4 Feb 2026 14:44:18 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 bpf-next 0/2] bpf: Misc changes around AF_UNIX.
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org,
 Daniel Borkmann <daniel@iogearbox.net>,
 Network Development <netdev@vger.kernel.org>
References: <20260203213442.682838-1-kuniyu@google.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20260203213442.682838-1-kuniyu@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256855-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,iogearbox.net];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin.lau@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5CAA1ED0E0
X-Rspamd-Action: no action

On 2/3/26 1:30 PM, Kuniyuki Iwashima wrote:
> Patch 1 adapts sk_is_XXX() helpers in __cgroup_bpf_run_filter_sock_addr().
> Patch 2 removes an unnecessary sk_fullsock() in bpf_skc_to_unix_sock().
> 
> 
> Kuniyuki Iwashima (2):
>    bpf: Use sk_is_inet() and sk_is_unix() in
>      __cgroup_bpf_run_filter_sock_addr().
>    bpf: Don't check sk_fullsock() in bpf_skc_to_unix_sock().
> 
>   kernel/bpf/cgroup.c | 6 +-----
>   net/core/filter.c   | 2 +-

The bot is slow. The change in filter.c is small and the cycle is 
closing, so I have landed them to the bpf_next/master.

I just noticed the netdev list is not in cc, so added it here also.


