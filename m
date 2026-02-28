Return-Path: <netdev+bounces-262196-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CFT5DldPo2nW/AQAu9opvQ
	(envelope-from <netdev+bounces-262196-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 21:25:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7421C8562
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 21:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E281E318B929
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 19:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9BF34CFD9;
	Sat, 28 Feb 2026 18:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r0epXK9Z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB0933D506
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 18:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772304349; cv=none; b=Ur3rq2xo8eLySSxGWwzdETZkpb3U71++GodeQpSrIjSUlszreTSorfOzlXQUaIGk8efctpdZs28+26DMYNBC8YGXzc6Y/RGLSfNmFjeOtSbNJO6xdRgRwOfXYlEu5InfFdZCunQsr0bIuUqwGF5aqHwt6AXTOJy/nd3yLEOHHqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772304349; c=relaxed/simple;
	bh=u3n0XsrnEAIgqgqlA31gZGjOHyYHDYEH1llZ+tI5tGM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YSItVTvdqo98+1lS+pbbV1hSiPfYDg9ClddXnGeId1qE++puN9s+5sCAGUqUHZ/Wt/+RfY9WUdJ1jd5EEatt9T1RSHyRRdhC+wsWuiHTz4QRWwc4D4OgEQKDnIb/X3XrCgwJ4ZP6+S5JcczUSe0XuINB+0RTR/FWTNTvifUmcIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r0epXK9Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6461DC116D0;
	Sat, 28 Feb 2026 18:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772304348;
	bh=u3n0XsrnEAIgqgqlA31gZGjOHyYHDYEH1llZ+tI5tGM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=r0epXK9Z4lXiobFTd5S/J/x21z2o8rtztaOI1IYeIAfXy0rIwfZ5YPNKfubm29IYL
	 0bu2m8ZqJ+VQX8L6AJwMBHPoPb0etUvmykJ4vgzNgsssCKj5hbC0tJMR9kX3UmZke1
	 y+5hDXCopmKtwIPW/3OYTUWCR+UkkQu/ys/LJ4F8speC74hfSkOGxbnBPgdgKuAxSH
	 CVX2GDFUOKu5NWttH6nBgT+oYGbH7B/xGzKRzJOV/jwZql5UrbMzxMelpuU3xlr5W1
	 c6fiE2QMN6wvePZ/LxKn6/eR90PjKaYs38Liwg/sbC11Cc9H0Qk+0+Z7q8P+QU0uHE
	 AMSy3Z3hLSQYA==
Date: Sat, 28 Feb 2026 10:45:47 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, tgraf@infradead.org, horms@kernel.org,
 pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
 davem@davemloft.net
Subject: Re: [PATCH 2/2 net-next v2] ipv4: bump rt_genid when a relevant
 devconf value changes through netlink
Message-ID: <20260228104547.56186b2d@kernel.org>
In-Reply-To: <20260226133949.17070-2-fmancera@suse.de>
References: <20260226133949.17070-1-fmancera@suse.de>
	<20260226133949.17070-2-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-262196-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.de:email]
X-Rspamd-Queue-Id: EF7421C8562
X-Rspamd-Action: no action

On Thu, 26 Feb 2026 14:39:49 +0100 Fernando Fernandez Mancera wrote:
> When modifying IPv4 devconf values using netlink for some relevant
> fields the rt_cache_flush() call was missing. In addition, if forwarding
> is enabled on the interface then disable LRO.
> 
> This is needed to avoid possible connectivity issues and ease the
> responsabilities of user space tools.
> 
> Fixes: 9f0f7272ac95 ("ipv4: AF_INET link address family")
> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>

This OTOH probably deserves to be a real fix for net?

