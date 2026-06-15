Return-Path: <netdev+bounces-299443-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id s2NCG771L2piKAUAu9opvQ
	(envelope-from <netdev+bounces-299443-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 14:53:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B84D86866A7
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 14:53:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="Uk6/+ac9";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299443-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299443-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4647C308DBF3
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 12:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1185F3EDAD2;
	Mon, 15 Jun 2026 12:40:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1014C3E6DC3
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 12:40:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781527207; cv=none; b=j7OyNUKL1UmFl8oq3tvJgReR09YVq5gkp0UPqrt26fAtMtakGbmT26HeY4gk/znlYonqJ/Dd7oKaXtW6onVUYD+Qf28ukkygKprBoitWC+iR0jF6wQnIjtn5Fy0VioSElfFsRFJQHo/XcvtLuaN056Lq69lpHRWDHq8ZlH4qbmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781527207; c=relaxed/simple;
	bh=YYkLqubwLwHWlGrJmkdnXDBhsuvs3fKvQlBhXwPEVoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lWZGPcWtSAV9iwMY7i6bxiwpDyuAUGvOC7qhXVyOopv2BsKoB3qc8Fa59Vlo24ZOR9RArJRKbMPL4uJN+AwEngEf36mu0ci4q0DT1f/F/PfcdONqy31BEW48ikP+phGA42/XrMqO2BELY0SK6HtbEx6rEC8mPBzmGIDoZQmpXKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uk6/+ac9; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93E321F000E9;
	Mon, 15 Jun 2026 12:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781527205;
	bh=bXgYtHMie+RmyUB/eHjMs9ZC08mgVE4IJMBwQnvw2Cw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Uk6/+ac9bmrBWbFhSZ+B/KE5aTp+V0Qmzpt/aG/tVpfj4uIpHUrBb9kv6JOQej7zt
	 11mZCYa0ZURJo+xjl/yUZwtGe08aN02lV+vjAiBWJRQQ3A7QeFxNvmwMkA1PV87Vf9
	 1nOOYGxUokROnlKZcH1dPvW+g3ude16KEhcJ+vOzsBLRtcMf6paXP+PEENHFGimEAE
	 M3455QgBJHctAxJA28j5tG6WPp+CNQIwNL3HITPRNOfu5/v9/akTNVO4SkqgxgrsoH
	 Ilf6WByrDIiSKNRQ4J85ComfAy2nsz9/yfP22G34w3Ioy/35jn/LXQ3G+pVShh1OIL
	 GAGpd4EswiI9Q==
Date: Mon, 15 Jun 2026 13:40:01 +0100
From: Simon Horman <horms@kernel.org>
To: "Wayen.Yan" <win847@gmail.com>
Cc: netdev@vger.kernel.org, lorenzo@kernel.org, pabeni@redhat.com,
	kuba@kernel.org, edumazet@google.com, andrew+netdev@lunn.ch,
	angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] net: airoha: Fix skb->priority underflow in
 airoha_dev_select_queue()
Message-ID: <20260615124001.GK712698@horms.kernel.org>
References: <6a2de8c5.2c570c9e.53b1a.0e1b@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a2de8c5.2c570c9e.53b1a.0e1b@mx.google.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-299443-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:win847@gmail.com,m:netdev@vger.kernel.org,m:lorenzo@kernel.org,m:pabeni@redhat.com,m:kuba@kernel.org,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:angelogioacchino.delregno@collabora.com,m:matthias.bgg@gmail.com,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:andrew@lunn.ch,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,redhat.com,google.com,lunn.ch,collabora.com,gmail.com,lists.infradead.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,horms.kernel.org:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B84D86866A7

On Sun, Jun 14, 2026 at 07:30:54AM +0800, Wayen.Yan wrote:
> In airoha_dev_select_queue(), the expression:
> 
>   queue = (skb->priority - 1) % AIROHA_NUM_QOS_QUEUES;
> 
> implicitly converts to unsigned arithmetic: when skb->priority is 0
> (the default for unclassified traffic), (0u - 1u) wraps to UINT_MAX,
> and UINT_MAX % 8 = 7, routing default best-effort packets to the
> highest-priority QoS queue. This causes QoS inversion where the
> majority of traffic on a PON gateway starves actual high-priority
> flows (VoIP, gaming, etc.).
> 
> Fix by guarding the subtraction: when priority is 0, map to queue 0
> (lowest priority), otherwise apply the original (priority - 1) % 8
> mapping.
> 
> Fixes: 2b288b81560b ("net: airoha: Introduce ndo_select_queue callback")
> Signed-off-by: Wayen <win847@gmail.com>

Our CI guessed incorrectly that this was for the net-next tree,
where it doesn't apply cleanly.

Please post a v2 targeting the net tree like this:

Subject: [PATCH net v2] ...

I suggest including Lorenzo's Acked-by tag.

For more information, please see:
https://docs.kernel.org/process/maintainer-netdev.html

...

-- 
pw-bot: changes-requested

