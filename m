Return-Path: <netdev+bounces-252534-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Jt/DkONcmlJmAAAu9opvQ
	(envelope-from <netdev+bounces-252534-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 21:49:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C84A6D8C2
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 21:49:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8DDA9300EFB6
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 20:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87AE73A7034;
	Thu, 22 Jan 2026 20:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="TZGhD2q+"
X-Original-To: netdev@vger.kernel.org
Received: from mx27lb.world4you.com (mx27lb.world4you.com [81.19.149.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D63B21D59B
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 20:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769114913; cv=none; b=p378drTRehga6QWNLttpf2U7WQphdlg2Kz6lSe95UD3bfF3n2hPEZlqxaUQt0LGqdGCDYBWYO/vYe895fkLEW1uF0NTtzOY2QLYqzYHRvvw/BeMV5GJiJMa2ytK2QKJZiRR11Jkxs5MagZdCLSSxS2D3r4cPhVqhT1vSXqATVfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769114913; c=relaxed/simple;
	bh=ZxRzWIa2RYrCjblR8FU1QpFVaCx9tygXC9Uf0jNb22w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FI8auZJJobNQq+oVvl6dQ3SlQH0BUgJjVDtPD7jqubXu9KpaxlarLokCbrHMXjh08ziNu9CRkP0iXLJyYrBgON0y1aJHC5ohH4vJKIfo0GiAK8fsv8BBhOtxF/nKMM9FydwlirjjgZDwV2y5CwWgoyPkrnPUWC3AprICC0ZXz2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=TZGhD2q+; arc=none smtp.client-ip=81.19.149.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=sDVB9pQemhkH2KV7SHjCh7VrpYGRuz2iO0t3CU9ClFU=; b=TZGhD2q+6T+fjXSdjPP8R0wy/H
	oobmBlntXwcND1F5rvBacjig3kiVRwsDWnRGOOjKqNHBhB76zVMRXZ1rldWfXT35xr9UIFaAkOWKd
	e8XkGToBpEfqFDayrzX/2/OiKVCK5stsy2obNBgj6mxWReDRD/ScX3otrduJHrz+OP2g=;
Received: from [188.23.33.245] (helo=[10.0.0.160])
	by mx27lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1vj0ul-000000007vz-0YKZ;
	Thu, 22 Jan 2026 21:04:24 +0100
Message-ID: <c5ba02dd-e81f-4590-9e35-90c9b2c33bee@engleder-embedded.com>
Date: Thu, 22 Jan 2026 21:04:23 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/2] net: extend ndo_get_tstamp for other
 timestamp types
To: Kevin Yang <yyd@google.com>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Willem de Bruijn <willemb@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Joshua Washington <joshwash@google.com>,
 Richard Cochran <richardcochran@gmail.com>
References: <20260121160458.990785-1-yyd@google.com>
 <20260121160458.990785-2-yyd@google.com>
Content-Language: en-US
From: Gerhard Engleder <gerhard@engleder-embedded.com>
In-Reply-To: <20260121160458.990785-2-yyd@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Do-Run: Yes
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[engleder-embedded.com:s=dkim11];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[engleder-embedded.com : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252534-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,lunn.ch,davemloft.net,redhat.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[engleder-embedded.com:-];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.951];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gerhard@engleder-embedded.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,engleder-embedded.com:mid]
X-Rspamd-Queue-Id: 5C84A6D8C2
X-Rspamd-Action: no action

On 21.01.26 17:04, Kevin Yang wrote:
> Network device hardware timestamps (hwtstamps) and the system's
> clock (ktime) often originate from different clock domains.
> This makes it hard to directly calculate the duration between
> a hardware-timestamped event and a system-time event by simple
> subtraction.
> 
> This patch extends ndo_get_tstamp to allow a netdev to provide
> a hwtstamp into the system's CLOCK_REALTIME domain. This allows a
> driver to either perform a conversion by estimating or, if the
> clocks are kept synchronized, return the original timestamp directly.
> Other clock domains, e.g. CLOCK_MONOTONIC_RAW can also be added when
> a use surfaces.
> 
> This is useful for features that need to measure the delay between
> a packet's hardware arrival/departure and a later software event.
> For example, the TCP stack can use this to measure precise
> packet receive delays, which is a requirement for the upcoming
> TCP Swift [1] congestion control algorithm.
> 
> [1] Kumar, Gautam, et al. "Swift: Delay is simple and effective
> for congestion control in the datacenter." Proceedings of the
> Annual conference of the ACM Special Interest Group on Data
> Communication on the applications, technologies, architectures,
> and protocols for computer communication. 2020.
> 
> Signed-off-by: Kevin Yang <yyd@google.com>
> Reviewed-by: Willem de Bruijn <willemb@google.com>

Like Jakub in his reply
https://lore.kernel.org/netdev/20260119115710.6fdde8c0@kernel.org/
for me also the question why this is a driver implementation came to my
mind.

With vclocks it is already possible to get timestamps for arbitrary
clock domains in parallel. So it is already possible to synchronize
the hwtstamp to CLOCK_REALTIME, CLOCK_MONOTONIC, ... in parallel.
Therefore, user space synchronisation is needed, but e.g. ptp4l does
a much better synchronisation job than your solution.

Maybe CLOCK_REALTIME is not supported by ptp4l, because due to daytime
saving this clock jumps. IMO these jumps will also be problem for
your solution, as it will lead to wrong delays two times a year.
So usually CLOCK_TAI or CLOCK_MONOTONIC would be a better choice.

To sum up: IMO you suggest a driver specific in-kernel solution where
already a driver independent user space solution with higher accuracy
exists.

Gerhard

