Return-Path: <netdev+bounces-290761-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KcmWJJM4EGqDVAYAu9opvQ
	(envelope-from <netdev+bounces-290761-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 13:05:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8553F5B2B39
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 13:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 890793073324
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 10:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF92D3CC32D;
	Fri, 22 May 2026 10:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lArq+iMh"
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586403CC310
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 10:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779446320; cv=none; b=W8mi9hPv81JMsZRevWH20k5qZKYbEqt7BeeqXzfRuPx1yxCdcGVJAPYQSjr67M9jQJ9OwgTfJrK2r930W1R3XmVN/ZY41+qHtTftHv4LbNmme6aEBaiS7k+aCPr8PmVqyDbTWn/yJ1q230BldipeLvJ5B/M//QJdnJdcaz/kMAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779446320; c=relaxed/simple;
	bh=UvYFNm8iymtli/Qya5etIo7DPsCtz1s3Shp9M/9yYOg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UglL4V3DA56u2+cgWGHWxfzU7oVu8jHWs1IuzBfb1DKyFJm7Vys+vOu5I8kdb21ZUBqC6zkduaXpMXSR60A54NZ26vVboMEy41teDsO14W2Gj36mNwHG0MVj8rThWi8eAGg2w6LS2O4lf6w6xDzyP+GpGbYlvhiyGGzSV4s+V2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lArq+iMh; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <186b4a77-3e34-4a87-9910-a9c5a756c766@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779446307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UvYFNm8iymtli/Qya5etIo7DPsCtz1s3Shp9M/9yYOg=;
	b=lArq+iMhI4erBdPxJn2Mo1jrk/I8AkDb29CUKG/hWKEiZTPgkw5c1MMj1NmAM/W8dK9lsD
	tQj/exqcWek7ZU6ehhRyi63ylCYCCSWqr/K8iurX6X4gggPmeB/wRBOebzN4p6uLxI4aO8
	w6/jYZpbirHkhARx/I6xIRZ6FBaFm30=
Date: Fri, 22 May 2026 18:38:12 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2] ipv4: igmp: annotate data-races around
 im->users
To: Yuyang Huang <sigefriedhyy@gmail.com>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Ido Schimmel <idosch@nvidia.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
References: <20260522093906.39764-1-sigefriedhyy@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260522093906.39764-1-sigefriedhyy@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-290761-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linux.dev:mid,linux.dev:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8553F5B2B39
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 5/22/26 5:39 PM, Yuyang Huang wrote:
> /proc/net/igmp walks IPv4 multicast memberships under RCU and
> prints im->users without holding RTNL, while multicast join and leave
> paths update the field while holding RTNL. Annotate this intentional
> lockless snapshot with READ_ONCE() and the matching writers with
> WRITE_ONCE().
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Yuyang Huang <sigefriedhyy@gmail.com>


Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>


