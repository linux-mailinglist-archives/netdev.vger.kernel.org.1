Return-Path: <netdev+bounces-275344-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OI0zBwbf0GklBgcAu9opvQ
	(envelope-from <netdev+bounces-275344-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 11:51:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B7D39A977
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 11:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1B1EE3013705
	for <lists+netdev@lfdr.de>; Sat,  4 Apr 2026 09:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BCCE3A9629;
	Sat,  4 Apr 2026 09:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SjNSRcGt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628533A961E;
	Sat,  4 Apr 2026 09:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775296257; cv=none; b=JAho7C2TP6isu+nsZtoyCwBjPNPEwO39GYMgh6gQrs1kB0CmK4ej/wShfNKdtMf5CXP2nYAiKICiOBPBvm7oChSqrKMZ3tLV8/IG2SGWqJtDIiYmJ/0xfXDIEirHVPThqTd5WNLo6LJUBbML6YhL6M0cMDae72UrMVP2oRUcLFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775296257; c=relaxed/simple;
	bh=0SJtuqC39KmtSUyzWuWOAf4tJ3L7EgcDLpoqKFEXrA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lZWi2RA5/trcB2R0vM1kE08er6CToSY4jhpVBQdQUH80qIpAPYsN0aGq/oA7lzqu/sesMPaXCKZxyj7nZrIhmCgWpcoJOeZVs04YMtAcwEweMU2VcHrVKAWbSitwNhXLCU1jwjZeKDgOAGqfI9Rm2rUAEUcCgcHtKvBeTXYmY4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SjNSRcGt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17ED6C19421;
	Sat,  4 Apr 2026 09:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775296257;
	bh=0SJtuqC39KmtSUyzWuWOAf4tJ3L7EgcDLpoqKFEXrA4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SjNSRcGtho/CUbRtovxR7IFPS9yxMDD9USMLDMRohHW2BEf8kZF3ZE3w9Kahz5Smd
	 98x21CqJfsdfTR+IPZnZTBBRotTymNpvBu/yIUlvdui99PcPMUOY2EAPqzHhc7qPT0
	 zeX8KoLTfQ0GlEpkzcfur4QgsFIYJpunD68oVaz2JaAiyEPiJ1IKfZOx6aeJpZ7CCr
	 8/7IHrRH+pRqSsRWRU/DGYuL9e6lhHIk64zb5l3ALDnKvT/Md34f8/pCCThjZ+/7DO
	 5RWo2uoekm262uGdgnf2zMQUskIQv7awuvJL7vfhTvnuFXgBND6NFJtNzS9IJK/ReH
	 Pv5van8ipZ/Zg==
Date: Sat, 4 Apr 2026 10:50:52 +0100
From: Simon Horman <horms@kernel.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Peter Oskolkov <posk@google.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v3 5/7] net/sched: netem: null-terminate tfifo linear
 queue tail
Message-ID: <20260404095052.GY113102@horms.kernel.org>
References: <20260402202037.176299-1-stephen@networkplumber.org>
 <20260402202037.176299-6-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402202037.176299-6-stephen@networkplumber.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-275344-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[horms.kernel.org:mid,networkplumber.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 86B7D39A977
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 02, 2026 at 01:19:33PM -0700, Stephen Hemminger wrote:
> When tfifo_enqueue() appends a packet to the linear queue tail,
> nskb->next is never set to NULL. The list terminates correctly
> only by accident if the skb arrived with next already NULL.
> 
> Explicitly null-terminate the tail to prevent list corruption.
> 
> Fixes: d66280b12bd7 ("net: netem: use a list in addition to rbtree")
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Reviewed-by: Simon Horman <horms@kernel.org>


