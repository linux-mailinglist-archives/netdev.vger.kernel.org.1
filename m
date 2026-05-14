Return-Path: <netdev+bounces-288111-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GL9qHd9ZBmqhiwIAu9opvQ
	(envelope-from <netdev+bounces-288111-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 01:25:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C8009547C20
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 01:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 628B7301D305
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 23:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3EA38B7A2;
	Thu, 14 May 2026 23:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mfTQnb53"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F531624C0;
	Thu, 14 May 2026 23:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778801070; cv=none; b=cpRr6SxIdDhgHeJf9bpXP1HP4ijifvdLO/8EPfYrRho6nDYsEIkJ4vP4dDguT2OPc9mGzdnx3n/EMBmm0VO0Hi/PikcpZL8Jm+YamNu7wH+PemaJl1Meewm3wxnzW9j3qGHG2mXFDNfui9HQEueASSaSHRF5L8nb21CNObt2lUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778801070; c=relaxed/simple;
	bh=abcUdZkExVsC3g0gsn6E8bZW1UNFsj1zLdTe3Vx+fWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A+3xnEBPNrG19IdV+C62Ob08shD86Axc4U57qZZI6XhFbWXplqEBZJUgVFXXhg9tWkTdRJ5L2FQxareKFLFwteltV1av8DSIcXkNiyaImruq0sWAcGsl2Z2vMdA6Fvk9rT0+cMfVuet47N/Kgb/G+aMxq069J8T4Hkcdk+GOQac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mfTQnb53; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBC2BC2BCB3;
	Thu, 14 May 2026 23:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778801070;
	bh=abcUdZkExVsC3g0gsn6E8bZW1UNFsj1zLdTe3Vx+fWQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mfTQnb53M/gyo+fqzJfJZzTPxPGmKkT3RJ4+AAzP+QvQ2ie+CIukFB7Fq7i7WZTvZ
	 WVPgFSWJzDnRN7dEhuTu1aui7NZnx+ffCTrHYIlBx24UEoNvJxcfYgFWEPPij69/fC
	 Ha19o3Cpd2GAbRN483e+tDZZzK/qKWd6xHLupty+MF45q5u4NoRHCZLx4DgFTOhHTO
	 P/5ykig/fy3JB2/H/lnQUD9+F7PjRwDwyCreZ6nMdgwRNE2/mL3HqDFqOdz5Ir3Fgm
	 7XCYcWiSI5TZUMFI/OffqPM4jq/kRK2c/IiI5xiiqKv6qypIVgTFgwVw11pYe3YcKa
	 OeDqr0uZm7Anw==
Date: Thu, 14 May 2026 16:24:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 horms@kernel.org, pabeni@redhat.com, edumazet@google.com,
 dsahern@kernel.org, davem@davemloft.net
Subject: Re: [PATCH 3/3 net-next v4] selftests: net: add test for IPv4
 devconf netlink notifications
Message-ID: <20260514162429.366b94c9@kernel.org>
In-Reply-To: <bd560c89-c71f-4ef5-a0fd-5ea096a0f767@suse.de>
References: <20260510081528.5257-1-fmancera@suse.de>
	<20260510081528.5257-3-fmancera@suse.de>
	<20260513193544.47970cb8@kernel.org>
	<bd560c89-c71f-4ef5-a0fd-5ea096a0f767@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: C8009547C20
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
	TAGGED_FROM(0.00)[bounces-288111-lists,netdev=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Thu, 14 May 2026 11:42:16 +0200 Fernando Fernandez Mancera wrote:
> On 5/14/26 4:35 AM, Jakub Kicinski wrote:
> > On Sun, 10 May 2026 10:15:28 +0200 Fernando Fernandez Mancera wrote:  
> >> Introduce a new test, `ipv4_devconf_notify`, to verify that the kernel
> >> sends the appropriate netlink notifications when IPv4 devconf parameters
> >> are modified.
> >>
> >> Since YNL currently has a bug where it declares an array of u32 values
> >> instead of the nested attributes expected by the kernel for devconf set
> >> operations, a temporary hack (`patched_add_attr`) is included to
> >> pack the netlink attributes correctly.  
> > 
> > Right, YNL doesn't really support the level or weirdness that netconf
> > requires. Why use YNL? Can't we test this with iproute2?
> 
> No, AFAIU, iproute2 does not expose devconf settings. The main user of 
> IFLA_INET_CONF are netlink libraries and other userspace tools that 
> heavily rely on netlink operations like NetworkManager, nmstate, nispor, 
> rust-netlink..

Isn't this ip netconf ?

> FWIW, I plan to fix the YNL side of things so we have this fixed 
> properly.

If it adds any hacks or new concepts to YNL it's unlikely to 
be accepted :(

> But I would prefer if this isn't blocked. Another patchset 
> introducing IFLA_INET6_CONF support is also coming.. being able to avoid 
> sysctl usage is quite useful for these userspace tools.

