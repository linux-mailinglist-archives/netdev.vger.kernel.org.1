Return-Path: <netdev+bounces-288596-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aCR7Fi8kCGoVbQMAu9opvQ
	(envelope-from <netdev+bounces-288596-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 10:00:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B184955AAE0
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 10:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 555963010C32
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 08:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D861EF09B;
	Sat, 16 May 2026 08:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="byGTGqWS"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4365464D
	for <netdev@vger.kernel.org>; Sat, 16 May 2026 08:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778918444; cv=none; b=j8FGdYR9ZnHad3e5Iqn+JqMEd8C0OmddpaVU3cWDQhLUWGBRfNaJYcbj4hk+oTdVGDlEt91+PwDmK437EJ40Cgj4VEo8hq1ni37owkH5BYno67VLrFhxkXtaxSeSau5YgnQJaOJl5DwOcmR72f5ozNcenBwOftkIH6kHQ34RLYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778918444; c=relaxed/simple;
	bh=fEJlSVqmc2bxmMRH1wo4GpfJhyejMCa3YUjgPLoTRS0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bKDJbive/Tp9EnCqpCjqjnQpmjqFAggkvWKS0Dh9BxMT0Daj2zM+/IjoX2Ak+el+CKv9LoH3jNyWazqEj+BdQhqxiPGMhVC+BlAMd/jLap63vCGs3IUFasiJmL2FOXBgqWcNu6kkdZfMv2B+W17xHc0hbsbH6W5GpyVn8XaDYdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=byGTGqWS; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id C70FE2084C;
	Sat, 16 May 2026 10:00:33 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QLBrr_rtFD2g; Sat, 16 May 2026 10:00:32 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id AF74A20842;
	Sat, 16 May 2026 10:00:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com AF74A20842
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1778918432;
	bh=AjUji4Hir1wf22CgD2Vpbu3WokYpV9JLA78Z7DZ4AJc=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=byGTGqWSE6N0fyOxrdK13aMlstGUhiAmd07OhfTeQjf4WQYvGrWeExyR7hlD1lc/l
	 wztNriL6JZXJvQFP7Aev8R8egHxuKfi9EBnt9qxIoqBhRpC8gne2tlX0BsNJYz5QSy
	 LjE3XpNniIUDlljqovSaEuYe1CqNlcUsosh2ESc34mEA6ZxHevY7sdFXZMhs2ZWlFB
	 VMKpn6WApskNIVkvoMUaLv7uir3x1LwYEPYRYO56Oxa+bJ2m6M9Tn0FFkWfcUb0EXu
	 R+FbHJ6l7xC0QJclxKWCpcg5MgTwtfkg5AtwePgD+X01hQvn+2XEmhpoJ4HvB/znZZ
	 WDWFv0kQKbQ4Q==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Sat, 16 May
 2026 10:00:32 +0200
Received: (nullmailer pid 497082 invoked by uid 1000);
	Sat, 16 May 2026 08:00:31 -0000
Date: Sat, 16 May 2026 10:00:31 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Ahern <dsahern@kernel.org>
CC: <herbert@gondor.apana.org.au>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, David Ahern
	<dahern@nvidia.com>, Leo Lin <leo@depthfirst.com>
Subject: Re: [PATCH net] xfrm: Check for underflow in xfrm_state_mtu
Message-ID: <aggkH0ZYWgIDoJFJ@secunet.com>
References: <20260513164918.33145-1-dsahern@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260513164918.33145-1-dsahern@kernel.org>
X-ClientProxiedBy: EXCH-01.secunet.de (10.32.0.171) To EXCH-01.secunet.de
 (10.32.0.171)
X-Rspamd-Queue-Id: B184955AAE0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	TAGGED_FROM(0.00)[bounces-288596-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,depthfirst.com:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Wed, May 13, 2026 at 10:49:14AM -0600, David Ahern wrote:
> From: David Ahern <dahern@nvidia.com>
> 
> Leo Lin reported OOB write issue in esp component:
> 
>   xfrm_state_mtu() returns u32 but performs its arithmetic in unsigned
>   modulo-2^32 space using an attacker-influenced "header_len + authsize +
>   net_adj" subtracted from a small "mtu" argument. A nobody user can
>   install an IPv4 ESP tunnel SA with a large authentication key
>   (XFRMA_ALG_AUTH_TRUNC, e.g. hmac(sha512), 64-byte key, 64-byte trunc),
>   configure a small interface MTU (68 bytes), and set XFRMA_TFCPAD to a
>   large value. When a single UDP datagram is then sent through the
>   tunnel, xfrm_state_mtu() underflows to a near-2^32 value, and
>   esp_output() consumes it as a signed int via:
> 
>         padto      = min(x->tfcpad, xfrm_state_mtu(x, mtu_cached))
>         esp.tfclen = padto - skb->len   (assigned to int)
> 
>   esp.tfclen ends up negative (e.g. -207). It is sign-extended to size_t
>   when passed to memset() inside esp_output_fill_trailer(), producing a
>   ~16 EB write of zeroes at skb_tail_pointer(skb). KASAN logs it as
>   "Write of size 18446744073709551537 at addr ffff888...".
> 
> Check for underflow and return 1. This causes the sendmsg attempt to
> fail with ENETUNREACH.
> 
> Fixes: c5c252389374 ("[XFRM]: Optimize MTU calculation")
> Reported-by: Leo Lin <leo@depthfirst.com>
> Assisted-by: Codex:26.506.31004
> Signed-off-by: David Ahern <dahern@nvidia.com>

Applied, thanks a lot David!

