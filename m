Return-Path: <netdev+bounces-254307-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8JODIFwhemmv2wEAu9opvQ
	(envelope-from <netdev+bounces-254307-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 15:46:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3BAA3133
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 15:46:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B4301301105D
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 14:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD83350A14;
	Wed, 28 Jan 2026 14:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GbQM+qyE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q17C4LQc"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED62A35A933;
	Wed, 28 Jan 2026 14:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769611495; cv=none; b=WAq1+B3rS2+xU/wepLG67xc7TmqFilmPaV52RTw80quNN+kPyMDf8EJ7Y9fzCKy8w6LVViSYw5lmAe3MWl2Pcl5jTzdRWBcgt44ACz3TPQ9Wxe9KL1EaMN8kEINkxsfG6ZlPp4FHMoUcgxDWvmIU5L+ApyQZf2qsJzd5oa3DV2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769611495; c=relaxed/simple;
	bh=VpDqKc4rf3OC6EocT4g5M791ylmLo4jg4ZC1gd32OZc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gJIwqTFh6uoA6igrjGxxJwcHq32RiMg1YDz8Bb+k13CNktnkAxsNPlZLG5KM6Jq1RAQM9nty4yDJes4pJJzR7gI2CPe2pWSrFh5jpXnUY/29OwuZepfLxLwBO1eA07KdNB9PVCpQLOC+0WAKcGtaqy8yG44uRtNHOqUyD97wVZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GbQM+qyE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q17C4LQc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769611491;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VpDqKc4rf3OC6EocT4g5M791ylmLo4jg4ZC1gd32OZc=;
	b=GbQM+qyELe0Gdrw4WAOlaz+JzylGlMOr6U70ewG4peNrJi/YreMdn/vavIhwOy55Qdh7B3
	gGtcBdOD8c+176kY/qb75U2xCHwXmEDHXCR18Eiet53DlGQ+2rWTfbtpJGe9x+b85465oH
	2iHV7+4nJ19Mqa//c6iUPEbFGqYFR2LU/BEjULhas7kdWIcEudHl/4L/UOvYIyBGKv10wv
	xO5OVzm9cfeyQues35wfZHunnFXcrufqdhsyljFsm/TIgy3C5muXCAFlonCPhilTu/WHdH
	g2yFrCS7UdeIpMBfuj0trOdIbxx/hXHNCyRIp4VfDZBOLC/x8Uc2rPdhn5fXrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769611491;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VpDqKc4rf3OC6EocT4g5M791ylmLo4jg4ZC1gd32OZc=;
	b=Q17C4LQcrdmD8KMsWtCchKgd7CCDOYieFU40cgQYAUlZJW+ztRmSfdxLeD+mXg1mvv75G0
	Ppe2pUpOFbwhKLAA==
To: Breno Leitao <leitao@debian.org>, Breno Leitao <leitao@debian.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, pmladek@suse.com
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Steven Rostedt
 <rostedt@goodmis.org>, Sergey Senozhatsky <senozhatsky@chromium.org>,
 Andrew Morton <akpm@linux-foundation.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, asantostc@gmail.com, efault@gmx.de,
 gustavold@gmail.com, calvin@wbinvd.org, jv@jvosburgh.net,
 mpdesouza@suse.com, kernel-team@meta.com, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next v5 2/4] netconsole: extract message
 fragmentation into send_msg_udp()
In-Reply-To: <20260128-nbcon-v5-2-93b4ddbc181a@debian.org>
References: <20260128-nbcon-v5-0-93b4ddbc181a@debian.org>
 <20260128-nbcon-v5-2-93b4ddbc181a@debian.org>
Date: Wed, 28 Jan 2026 15:50:50 +0106
Message-ID: <87fr7plrtp.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254307-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,goodmis.org,chromium.org,linux-foundation.org,vger.kernel.org,gmail.com,gmx.de,wbinvd.org,jvosburgh.net,suse.com,meta.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[john.ogness@linutronix.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:email,linutronix.de:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.com:email,jogness.linutronix.de:mid]
X-Rspamd-Queue-Id: EC3BAA3133
X-Rspamd-Action: no action

On 2026-01-28, Breno Leitao <leitao@debian.org> wrote:
> Extract the message fragmentation logic from write_msg() into a
> dedicated send_msg_udp() function. This improves code readability
> and prepares for future enhancements.
>
> The new send_msg_udp() function handles splitting messages that
> exceed MAX_PRINT_CHUNK into smaller fragments and sending them
> sequentially. This function is placed before send_ext_msg_udp()
> to maintain a logical ordering of related functions.
>
> No functional changes - this is purely a refactoring commit.
>
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: John Ogness <john.ogness@linutronix.de>

