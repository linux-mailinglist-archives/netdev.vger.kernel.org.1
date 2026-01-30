Return-Path: <netdev+bounces-254966-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id t5LMLMEBfGnuJwIAu9opvQ
	(envelope-from <netdev+bounces-254966-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 01:56:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07776B60AF
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 01:56:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8B73330157E0
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 00:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E931E311967;
	Fri, 30 Jan 2026 00:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="H3NVM6uZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ms17JHqF"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A72E2DFF28
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 00:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769734589; cv=none; b=Hn15QlNe0+WyJ7X5gn58bdVlP7n5nFAeXU6Bhqu4LlWezydbgmHXtbFhxKuOf4igKKIKEDwFc1u4wtHkz8HBQDnn96e1JxkThWN4l7847j16dG7rQLnUUUbX7jMeELOrQbNtUDkT18sfkiOofNAFqxSRSNGQX0fTxxRhhbk/CBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769734589; c=relaxed/simple;
	bh=P7EKM3EHqhvyDvJfZgxgHylSj6bn0or2aJf4wK9Zvmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tDeMC1uae8XfJoBLfZf/Kao01FQCoCkvlAi9ecG+bqyn3WOGPEGGGtCSjj6JFcEiCBZsOmoRyO/K/zlALR29PdScPnk7XrF3evixL/reYFku/rNbUz7A2UIhOAAoAwoO0K/WpXItazV3vR6WAXagL43JeXn4kW7hrFh3xG1sZrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=H3NVM6uZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ms17JHqF; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 1495F1D0013C;
	Thu, 29 Jan 2026 19:56:25 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 29 Jan 2026 19:56:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1769734584; x=
	1769820984; bh=x/IqoU/bRE+m2Myo+HJJkiQw1QN64LOGc3GgRY85x5Y=; b=H
	3NVM6uZRD2dW8pV0bshrN+eX3nb3VdBJLn6lgN+gd/Ix9x5E/kSWichSMxP/Yhes
	wBtRAINiivg583wQYv6MqUEE9sG2HJnnVr/VE3hJPc1SG5BK0i6qBvwNm1gqpVqf
	8daHDBkn54H8cSMpTOm4kph+4R33x1SE3nH5aGmdPgKSQCfFM82cz9xJ3mlyXH6N
	JpEzAAHk2WWeGbhO7fWUGRjXinf6JNCwy9O6UHRRtWcrx8+gbMvypt9Vac7oavjj
	X00ZMOfzl+qP4X6wUfT3xjQsCOAEhyD/PQ/oXm7EVtTkG7lXbnHtGZu+91Yo9QRl
	KcUxW8S+fi7mFWeZ3IgUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1769734584; x=1769820984; bh=x/IqoU/bRE+m2Myo+HJJkiQw1QN64LOGc3G
	gRY85x5Y=; b=ms17JHqFReOuUEAzAv5mkdidoT01QHoOsCUl+8xFWqdjqdOtbT4
	4plo8pXiZQLNIiOrwbonoAusSEAhr2unhmxHrYeOvyQTndrQI9JnfH6jkDGnVu0r
	s2Alw4VA+rtPlMHBTsT3/9v/6WZimYKHVkHiqv/Bf0VkgZqY+PDdJ3xxQOL7g8aj
	zPHH51sv9bwo0MDY8CjCau9d8BVC6u9bOgffhD124xqEfHgOoe8o0S0g08ZmWs20
	CltxRJSXDSElKY8xNfoinxAjbmgse/g8X6YzQvAqILgG5PPt4QEpr9Cwt/R87bhv
	Ekdpo79+ht2J4KvFvpa05T0UyMFwmqaJ9DQ==
X-ME-Sender: <xms:uAF8aaX09vYEXQoCxyfudYpOFHzAlkTxJytYtBB-eISokKEcLKLZsw>
    <xme:uAF8adkoPQhPBi_9iPGMT1qiUWGJMaoniGTjxEb2lt9mvUKzg7XMOQT3pz51tJ5pS
    CmrENStpLHhRcR2TLC7FdP6z6kZFjJDH3KeNQu9doTJHzBB093XmLLh>
X-ME-Received: <xmr:uAF8aTZos7hhnJt0daYVHlCA_TdJigTu0LiHcSWwZSRM4YeWnd52FYP-4IkU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieejieekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeegpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehmmhhivghtuhhsleejseihrghhohhordgtoh
    hmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjrghsohhnseiigi
    dvtgegrdgtohhm
X-ME-Proxy: <xmx:uAF8aQPx65LJugS5f8odctH2dlTvjdAroaDdOwiMXqK-_fJRKecYyQ>
    <xmx:uAF8aQaGA__mODH8ERGpgUmgNTjMlYvLxn-VUjsSPUx4esBoPMqOVA>
    <xmx:uAF8aW3CB896yBHzfTZiTV2NcYbf2-RnHUW7eLpHdDZ7YO8lfVAmBQ>
    <xmx:uAF8aefJYmlbxZDb9ZqaaNFODacl8eNyqRoz_Jh_nFih0BmkpB5y2A>
    <xmx:uAF8aYraPT0_padRwLmAI9THLhUlH64ByaO6c-IjM1EWZKfbrs2XYze6>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Jan 2026 19:56:23 -0500 (EST)
Date: Fri, 30 Jan 2026 01:56:21 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Marek Mietus <mmietus97@yahoo.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, Jason@zx2c4.com
Subject: Re: [PATCH net-next v7 04/11] net: tunnel: allow noref dsts in
 udp_tunnel{,6}_dst_lookup
Message-ID: <aXwBtY4tLDfO5rR4@krikkit>
References: <20260127070452.6581-1-mmietus97@yahoo.com>
 <20260127070452.6581-5-mmietus97@yahoo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260127070452.6581-5-mmietus97@yahoo.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm1,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254966-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	FREEMAIL_TO(0.00)[yahoo.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 07776B60AF
X-Rspamd-Action: no action

2026-01-27, 08:04:45 +0100, Marek Mietus wrote:
> Update udp_tunnel{,6}_dst_lookup to return noref dsts when possible.
> This is done using a new boolean which indicates whether the returned
> dst is noref. When the returned dst is noref, the dst is only valid
> inside the RCU read-side critical section in which it was queried.
> 
> Update all callers to properly use the new noref argument and convert
> all tunnels that use udp_tunnel{,6}_dst_lookup to noref. This affects
> bareudp, geneve and vxlan tunnels.

Maybe I'm missing something, but after this, all users of
udp_tunnel{,6}_dst_lookup need to be able to handle a noref dst? If
so, can we avoid the "if (!noref) release()" dance in all callers by
doing the release() before returning from _lookup()? The conditional
dst_release/ip_rt_put in this patch and some of the others feels
pretty ugly to me.

-- 
Sabrina

