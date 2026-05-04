Return-Path: <netdev+bounces-283936-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHm4HdvE+GlQ0gIAu9opvQ
	(envelope-from <netdev+bounces-283936-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 18:10:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8BB4C1328
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 18:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F4D630071D0
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 16:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79033DFC85;
	Mon,  4 May 2026 16:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="p1aS4hxX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nIlKXDsz"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7500237883D;
	Mon,  4 May 2026 16:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777910817; cv=none; b=Pz2TxUlgDgJQWl0HQ4N6YXmOxu46+/xEacK8oZvnqMAtgiFwk0hawxhuL9R6pgYDIPwjNNRqrkroL3JSje65FNVa9h8K0DHcaw6AfubT5CX64pD8Mc5RCIkMscX2TU4TMxGaWYQEI6ASER/xin7w84/vXJqYqjEpIgOz02wd3Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777910817; c=relaxed/simple;
	bh=L6r8oXJ9ZzBnwPL7FbXICpdtx3O3f8IZvpOHXbrL0Dw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cIft3yw8Z/bJFSsC2/bIXQfdH/Zakx8iSaCDnMCeYvyTubVafHWJSv63N2qQ2/ODVc7M4sNcUlHrAWM7ER2KMnJp8Mc86z+3hr5zHRmZVnA/p+khFxGBYGUKjfHGP4gNTMku1tSNSBKFVLHlLIoPq4X7h4+G/SXt8ynufataa3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=p1aS4hxX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nIlKXDsz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 4 May 2026 18:06:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1777910814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TXHH5R0BhkfDr9Rlhn4zkhBVScUk87tQK0t869TJNfs=;
	b=p1aS4hxXQdoYxJl01ex/zyh1gIBKENy6HFUjEuaXCgIlTmj/aGmQbRoWJ/6h8KGkWC0CUb
	A1IZO/9QpQSq5kxq3F/aYYJxCKDc40QKoZ+NfqarPnqO+CVjm38O5RZhJgwLDWP5Ykipi/
	ljCwV4z26CgUvCS7QgkwRz8uddzgqx5ZxiGUr9pOWD1lkEaCKRK5SsAxSVPvyPTsSCCz0X
	s2ZYRMylCw11Vgt/x4iQGuONyDal8xkZ05O6OH4RPenA8faTdBxJc6qcOHlkTSC0X/JoY3
	q2OJyknhxOft/Q2vucjl7oiRrrAohHITaAE58ObsfV20Fbo9cLsiz+VlKkGavw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1777910814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TXHH5R0BhkfDr9Rlhn4zkhBVScUk87tQK0t869TJNfs=;
	b=nIlKXDszLqqxfyZ58gmZFU0fcWEreTuYJ7Q+6yLWHuRvHqEXi2+06DZwnD6Ya+Rqgx+XEB
	K/FtxzX6m4jMq9CQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	UNGLinuxDriver@microchip.com, Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Bjarni Jonasson <bjarni.jonasson@microchip.com>,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH net 2/4] net: sparx5: fix sleep in atomic context in MAC
 table access
Message-ID: <20260504160653.4acdravI@linutronix.de>
References: <20260504-misc-fixes-sparx5-lan969x-v1-0-6604306b5743@microchip.com>
 <20260504-misc-fixes-sparx5-lan969x-v1-2-6604306b5743@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260504-misc-fixes-sparx5-lan969x-v1-2-6604306b5743@microchip.com>
X-Rspamd-Queue-Id: EB8BB4C1328
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283936-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linutronix.de:dkim,linutronix.de:mid]

On 2026-05-04 16:43:43 [+0200], Daniel Machon wrote:
> index 2bf9c5f64151..0797cfa32916 100644
> --- a/drivers/net/ethernet/microchip/sparx5/sparx5_mactable.c
> +++ b/drivers/net/ethernet/microchip/sparx5/sparx5_mactable.c
> @@ -50,7 +50,7 @@ static int sparx5_mact_wait_for_completion(struct sparx5 *sparx5)
>  {
>  	u32 val;
>  
> -	return readx_poll_timeout(sparx5_mact_get_status,
> +	return readx_poll_timeout_atomic(sparx5_mact_get_status,

If you do _atomic, it becomes atomic. That means it does not sleep as in
TABLE_UPDATE_SLEEP_US for 10 us but spins via udelay(). The
TABLE_UPDATE_TIMEOUT_US is set to 100ms which _might_ be high. 
This is probably just nitpicking (given that there are other drivers
doing the same with a greater timeout (READL_TIMEOUT_US)) so feel free
to ignore it.

>  		sparx5, val,
>  		LRN_COMMON_ACCESS_CTRL_MAC_TABLE_ACCESS_SHOT_GET(val) == 0,
>  		TABLE_UPDATE_SLEEP_US, TABLE_UPDATE_TIMEOUT_US);

Sebastian

