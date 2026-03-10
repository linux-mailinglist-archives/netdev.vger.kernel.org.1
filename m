Return-Path: <netdev+bounces-266350-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sOeMA7aQsGkukgIAu9opvQ
	(envelope-from <netdev+bounces-266350-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 22:44:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 676BE258705
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 22:44:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0580D31ADA69
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 21:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3CA3DDDA5;
	Tue, 10 Mar 2026 21:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qre9doRU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490943375AA;
	Tue, 10 Mar 2026 21:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773178947; cv=none; b=HRsbMgg+7k22248EJOctEjSDrf+DoiF9HXEuTtYkx443Y1zaJdpbmUQ1KCx+OrecXglIc5aEDBIYEHLzLI6qZQa8+wc5WOLGr/q1+WGrQC6+oZhxhLKD7DFVqtMUCXqvDOfJ8qSdTJ8z9L1NdjmO1ad9cROUTePpxwNBjpft7zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773178947; c=relaxed/simple;
	bh=sMDkgyCiwcQcFG/IS+8zt4O6+QmcSTnnqcmooA0MlUI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mV6hWDIrhMdRj4E3HGn5PGE03CQF3ozLOYsRJHHix7d7By2LcMzW1h8NZl1FjDKGPGGTbeTC/sT6R1T/wvuRO+j5wZ/Sob92+zUVesQYewpsVcQqy5f1grkjMFykom75H2/9bsc+DxrH4YHdHn+uPg2+nxeME382gRO/pOw9xHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qre9doRU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99DDBC19423;
	Tue, 10 Mar 2026 21:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773178947;
	bh=sMDkgyCiwcQcFG/IS+8zt4O6+QmcSTnnqcmooA0MlUI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Qre9doRUAZfl7IsLZYgWmK4ZOEWZ+9p+o1AYKArTbYPc+q9WtjOz9PDJzsQiu1BPf
	 l90M+ZQ3ygsgqs9mHHggWBCasEX1pteRCASZr0qgWlM8f8webc2eOtyHKvO0pn2CTG
	 KZffiKNhJVmhqZhwvRGS6JwpoJep4F2/DsvNi3pA6LHXJ5oS0B5QHnqM2+mpV74GdU
	 mwnjHkh171UMhHwFuDmvndU87de03hNKRVU0w8Mizubn2+gKTnbQhsYSYy6+La6+Fs
	 jwhYkoiLbe1/FfBNqGqSpqAH4MJS58/z1iF+lR6yRsZ4RMtS/OLp03/V+sxIpPYari
	 ymqe0eVEpGGCA==
Date: Tue, 10 Mar 2026 14:42:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Fernando Fernandez Mancera <fmancera@suse.de>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org
Subject: Re: [PATCH 00/10 net-next] Convert CONFIG_IPV6 to built-in and
 remove stubs
Message-ID: <20260310144225.46501657@kernel.org>
In-Reply-To: <411bcf03-5993-478d-9809-3e04567ff09a@kernel.org>
References: <20260309022013.5199-1-fmancera@suse.de>
	<48ccec3f-dbc8-45c8-afda-e4f7e8f150d6@kernel.org>
	<f4598201-2115-43e3-9da8-22583ae67db2@kernel.org>
	<20260309161826.46074d55@kernel.org>
	<411bcf03-5993-478d-9809-3e04567ff09a@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 676BE258705
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-266350-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, 10 Mar 2026 21:02:40 +0100 Krzysztof Kozlowski wrote:
> > Here is the top line of bloatometer without debug info:
> > 
> >   add/remove: 1769/7 grow/shrink: 86/0 up/down: 374521/-228 (374293)
> > 
> > The vmlinux increases by 200kB with IPv6 built in.
> > Not a very dramatic increase.
> > 
> > Please note that opening any dual-stack socket will cause the IPv6
> > module to get loaded. And opening a dual-stack socket will fail if 
> > IPv6 is blacklisted. So I find it quite hard to believe that other
> > that deeply embedded systems with custom configs there are systems
> > out there which don't end up with IPv6 loaded. Whether they have 
> > a single IPv6 address configured or not.  
> 
> Yes, Ubuntu for that reasons does not have it even as module.
> 
> This should be used as *the* argument for these changes.

Completely fair, the submission is severely lacking in motivation 
and impact analysis :(

