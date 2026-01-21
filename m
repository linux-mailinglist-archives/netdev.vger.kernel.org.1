Return-Path: <netdev+bounces-251674-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oEpkBqUdcGlRVwAAu9opvQ
	(envelope-from <netdev+bounces-251674-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 01:28:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B54684E7F4
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 01:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 454815467EF
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 00:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B4727FB0E;
	Wed, 21 Jan 2026 00:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tAOz4o5K"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03B527F73A;
	Wed, 21 Jan 2026 00:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768955295; cv=none; b=hvZhEdDnPppS8xVbJIIsoLIC+PI+rnE3nR81UNT2WZ+T+i4n7fvmABWrut7yHIOdFTLDz1YDGINZD11NvNUJz4ytpW9nF8pnulkCJmPDqDI7K+57UDunO0rzGEtrIpIwckHjZu71lwh57Q0W3yhCnt8K5yDWkcHd0h5rHPyeaSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768955295; c=relaxed/simple;
	bh=+NDrdrCqFOjjaaT7KuvL0mh+SHL0jBBifcCGBxmDrDE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CPa64Lnm7T1/do5wHvgIAaDmdROW8drYORm2C9J0DH63XDv+JQ1EdxHXUuOl8Vrhkgwxfwip7LsvfTWtrjYHXUw5ubQP9JegLbgV8IzKSMlMWKJNEp1hj7GoX3NqZukMGMMNhSbZKoKamU5/7HMMOTYXKmqCNODSr26rN9s6OQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tAOz4o5K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFC54C16AAE;
	Wed, 21 Jan 2026 00:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768955294;
	bh=+NDrdrCqFOjjaaT7KuvL0mh+SHL0jBBifcCGBxmDrDE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tAOz4o5K26pFw/zecP6X7gQrmxZpND3BZK79IWXhHxKGOaORV9El9ibc4+sDv50zF
	 0Bn587GeLfGUgHMc0nGjbu7pby7/PIJGUEJarfhRUQN1vLK322x/nrIinaaJiuK/wi
	 opdps/nfutNwLXUXam1KwKOg6EymMKoqGC86MsxrI6lx0hPbYuX6fMxQC6aeH9wTy4
	 4KCFT33ysYlTKJsDNd5FYpoIdTVgTQcuU6jS2MyIl+lo6bcvyodsQPVwG9V8egyorU
	 2eN51jJMJ0f2U03NZk0PxsR52d5PUSuPuBfmIe1IKKLNxl2uZZOnKe3dTHOeHKDLMs
	 ldpdRPr6ocKBA==
Date: Tue, 20 Jan 2026 16:28:13 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, Eric Dumazet
 <eric.dumazet@gmail.com>, "David S. Miller" <davem@davemloft.net>, Paolo
 Abeni <pabeni@redhat.com>, Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?=
 <toke@toke.dk>, horms@kernel.org, jiri@resnulli.us, edumazet@google.com,
 xiyou.wangcong@gmail.com, jhs@mojatatu.com, carges@cloudflare.com,
 kernel-team@cloudflare.com
Subject: Re: [PATCH net-next v2] net: sched: sfq: add detailed drop reasons
 for monitoring
Message-ID: <20260120162813.1926b364@kernel.org>
In-Reply-To: <176885213069.1172320.14270453855073120526.stgit@firesoul>
References: <176885213069.1172320.14270453855073120526.stgit@firesoul>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,davemloft.net,redhat.com,toke.dk,kernel.org,resnulli.us,google.com,mojatatu.com,cloudflare.com];
	TAGGED_FROM(0.00)[bounces-251674-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: B54684E7F4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Ah, commented on v1 before noticing this.

On Mon, 19 Jan 2026 20:48:50 +0100 Jesper Dangaard Brouer wrote:
> +#define SFQ_DR(reason) SKB_DROP_REASON_QDISC_SFQ_##reason

FWIW I prefer to be able to grep over the max line length issue, 
but up to you. We should have named the enum entries SKB_DR_xx :(

