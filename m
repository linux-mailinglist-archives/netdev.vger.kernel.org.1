Return-Path: <netdev+bounces-307143-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xKKfOXvZVGpLfwAAu9opvQ
	(envelope-from <netdev+bounces-307143-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 14:26:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 839B174AED7
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 14:26:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=W2tAy5hL;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307143-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-307143-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 25EF33013B9B
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 12:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606AF3E2752;
	Mon, 13 Jul 2026 12:26:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BC73126AD
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 12:26:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783945594; cv=none; b=SPea2B29fnE8xDRLTL0hU3HH4N/LVLam4VXmoALcDl99OqMkvA/8DfS/Lm7N4KyBKfzY/jDaIX4bKgApOduy+AX2i7CQMRQ6d1N1M0RpkjtCXOniRMJRG+yXNuj/KOuRLpnir8UGVSsrP+3erzAzrP5zP3RHn7X/eSb6CTNIQQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783945594; c=relaxed/simple;
	bh=0k4Gkc2lSaNlg3yelePb+YUuOKPa2uEegCxdpabFhF0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SKbkY/7F3Y6ilswl+rDH2n6CIZ7wM2RpYW9uG94MDPCcAwM2t6+mT+HT4ru9q8wv1sg5blpdcVJuXIRw0X8pUFR8s/cn5b9LLE0a4Wtajjj0Cn8sn41QVsDNTk5DFAHORzVyMfWQmYMP/othD/ZtVFX7m9f34ed0VIVMCVvwdzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=W2tAy5hL; arc=none smtp.client-ip=95.215.58.171
Message-ID: <f16a6ca2-c528-471d-83f7-8327a3d9bfbc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783945579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=21Y5q/ufuGUVxfworezwmSuvfxf6tIT8XyWioTVY+/E=;
	b=W2tAy5hLOR7PJmBMxdpQ11rwhZcbENOjxGhuDmixuEmr5SApAqrcST66rdJTM7ukRqUKCa
	h88LDWojufEhQ8HpN2yo5Q6pF1pmx44scF+xt2QrHkuvmBLgytudC82nURw515EwXPmhLK
	BliUeHnCwNT3Zi+99/wAr9VO8/8Vb5U=
Date: Mon, 13 Jul 2026 20:26:09 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Cc: cui.tao@linux.dev, dsahern@kernel.org, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, cuitao@kylinos.cn
Subject: Re: [PATCH iproute2-next v5 1/2] rdma: update uapi headers
To: Leon Romanovsky <leonro@nvidia.com>
References: <20260710011759.378893-1-cui.tao@linux.dev>
 <20260710011759.378893-2-cui.tao@linux.dev> <20260712090325.GF33197@unreal>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <20260712090325.GF33197@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:cui.tao@linux.dev,m:dsahern@kernel.org,m:linux-rdma@vger.kernel.org,m:netdev@vger.kernel.org,m:cuitao@kylinos.cn,m:leonro@nvidia.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[cui.tao@linux.dev,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-307143-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cui.tao@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:from_mime,linux.dev:dkim,linux.dev:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 839B174AED7



在 2026/7/12 17:03, Leon Romanovsky 写道:
> On Fri, Jul 10, 2026 at 09:17:58AM +0800, Tao Cui wrote:
>> From: Tao Cui <cuitao@kylinos.cn>
>>
>> Update rdma_netlink.h file upto kernel commit 5911f6d6e7ce
>> ("RDMA/nldev: Add resource summary max values for usage display")
> 
> This SHA-1 is incorrect.
> 5911f6d6e7cc ("RDMA/nldev: Add resource summary max values for usage display")
> 
Mhm... sorry for that
> Thanks


