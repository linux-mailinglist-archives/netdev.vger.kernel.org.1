Return-Path: <netdev+bounces-287793-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLzDJgc1BWonTQIAu9opvQ
	(envelope-from <netdev+bounces-287793-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 04:35:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F2F53D12E
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 04:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 975F8300DE38
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 02:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A01248867;
	Thu, 14 May 2026 02:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h1+kWQdg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57461459FA;
	Thu, 14 May 2026 02:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778726146; cv=none; b=lbDy1uTyocoXqDgWa6cI2jFbZ9kCvcw6/J+1mOwpp36znmQVCet4A6sf+/irSsH4otfJlviyCotuLMvthYerIAxwknUcn+a0833dHqnC0jMc7wxg4PqRPsnAnYvEgbzZQcsRyNCPKcKbRcR6l+0++LWJp+JXcanXsPt4aD0Pd5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778726146; c=relaxed/simple;
	bh=FAxIPJuCdBfxFLr7b5SZBZadKglB80+7msXC94z0AZk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZrBJbJ0oyYOuVH8W36oU6KDDvxphebSDmoAg6czMpY1ljrdCj3IgV+YusUqMJrSnFZczUVnZ7goCWHkwJw2SbCpTkbwMx0gVlemRgyn4Ag1BBulNDEgE1jJY/TwFQU/WGY5PPxxBYkuUU07kr4Xdk71Fc8YAoquBbkggPHAxNQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h1+kWQdg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCED5C19425;
	Thu, 14 May 2026 02:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778726146;
	bh=FAxIPJuCdBfxFLr7b5SZBZadKglB80+7msXC94z0AZk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h1+kWQdgmHwUxvSaWxu6ZIzdcu4n9pbUvRW8UR37uj9WjzwqsgtXmjkAIAkdQ+1LI
	 A4z3ba7QfllMdu4idZJlVKWiaDhU5iq5rfkqf2xL6VMmQBcJDyHhDuO4B1Y+WFoz6K
	 l3ent/5w/bqWXlu67zKrRdX2h9mCcYgjQxQ0oMyJnerGO9SN+i/CrfyHxLXdAOUx9m
	 A7ksmaEIV7+Q2rQBh6hCBEpu/7wKG4p7q5RvkoMZXnFoYqaN+EEaBcSa3SQttLwLNx
	 qeVgMo+VD5SIjgjhTjxBMcl+WP/WQniNSNPRYsgsr36TXG0ttkFvgpNZtGmk6DClYw
	 gdczdOoMx6nyA==
Date: Wed, 13 May 2026 19:35:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 horms@kernel.org, pabeni@redhat.com, edumazet@google.com,
 dsahern@kernel.org, davem@davemloft.net
Subject: Re: [PATCH 3/3 net-next v4] selftests: net: add test for IPv4
 devconf netlink notifications
Message-ID: <20260513193544.47970cb8@kernel.org>
In-Reply-To: <20260510081528.5257-3-fmancera@suse.de>
References: <20260510081528.5257-1-fmancera@suse.de>
	<20260510081528.5257-3-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 04F2F53D12E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-287793-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Sun, 10 May 2026 10:15:28 +0200 Fernando Fernandez Mancera wrote:
> Introduce a new test, `ipv4_devconf_notify`, to verify that the kernel
> sends the appropriate netlink notifications when IPv4 devconf parameters
> are modified.
> 
> Since YNL currently has a bug where it declares an array of u32 values
> instead of the nested attributes expected by the kernel for devconf set
> operations, a temporary hack (`patched_add_attr`) is included to
> pack the netlink attributes correctly.

Right, YNL doesn't really support the level or weirdness that netconf
requires. Why use YNL? Can't we test this with iproute2?

nit: sashiko found a typo in "notificiation"
-- 
pw-bot: cr

