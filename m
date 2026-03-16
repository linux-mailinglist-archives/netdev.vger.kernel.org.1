Return-Path: <netdev+bounces-268338-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CNqrOsuRuGkUgAEAu9opvQ
	(envelope-from <netdev+bounces-268338-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 00:27:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5444E2A1F29
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 00:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B6513045A88
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 23:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 639BA37880E;
	Mon, 16 Mar 2026 23:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ERhzkRD0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41044372B27;
	Mon, 16 Mar 2026 23:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773703587; cv=none; b=iIby0kJqM61PAjiy3YDHlbkio6Drrx5sZFteAaisbeicMLy/tf2hcLOghvi5phL8iviR6HCsZknmFsUqetm4IbGueFH4pbwNZou8kFFh+bT53jj2AJnK2sg501+FUxXJSzBJi9fPbo6raJzqPA+C5x6lyJF5fv6l05dF6BycP+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773703587; c=relaxed/simple;
	bh=KJlz8SSdNGgaHkDeRIBGgrbr6/4ndUBNjuNgpZhMooU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ha/TYP7PNpd9zKiW4NiDe4JzCmORYcGVGGJJDqNsQTmbPVNJWuVq4XU8PLmm09HP+Eft/Bu8hwOwYBL0iBDPODI8fLsCv1NK5WL2Rg8HzMO54M4C/nAoH/gx4/HxW+qXmFtm52seo0SCBgoxWniGuiZuPRhqdPmMU7/j/lLscNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ERhzkRD0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E597CC2BC9E;
	Mon, 16 Mar 2026 23:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773703587;
	bh=KJlz8SSdNGgaHkDeRIBGgrbr6/4ndUBNjuNgpZhMooU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ERhzkRD0KNo0t1lzJ2F7a3B5Y7m5ouUbyqcXdvuwyrW3DtPU4x8ZnTljG9bIm63Ag
	 rixFfZ0NK70OEBokyR7N3MUhfJNEVpOvfHTHO8Ft1k8O2ijQ0W4ZLBMAuo4KDfc3/+
	 LSpPb9UBaPpWUiESQx/HLCDZyFvL8FB33LEX9pHtX38iVSunSofEBBgwo4HvkaJKFj
	 wxD2KpXRrji5BZPa79zRXd95ILHz5BKJQGSPm/8aoXAMTCE/d5WPdN8hcer+UEG8SD
	 FQMBJCoTuU7Ols5Ogm0oAW+rpaP7LktULksIrpSL/LGltAAbuvajZTCETlaf4FckZS
	 +m4SJpNagyy1A==
Date: Mon, 16 Mar 2026 16:26:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [GIT PULL] bluetooth 2026-03-12
Message-ID: <20260316162626.6829f49c@kernel.org>
In-Reply-To: <CABBYNZJo0aZW1p1YqyKNDWURunAHxZcS8B86OZGstfgWr0S58A@mail.gmail.com>
References: <20260312200655.1215688-1-luiz.dentz@gmail.com>
	<20260314094707.105683b1@kernel.org>
	<CABBYNZJo0aZW1p1YqyKNDWURunAHxZcS8B86OZGstfgWr0S58A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268338-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 5444E2A1F29
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 16 Mar 2026 09:58:56 -0400 Luiz Augusto von Dentz wrote:
> > FWIW this is what our AI had to say about the series, mostly nit picks
> > but not all (LMK if you want me to hook the AI reviewer up to your
> > patchwork):  
> 
> Sure, I like to receive reviews of that, note though that
> linux-bluetooth and patchwork are for both kernel and userspace, so we
> may need so quirks for detecting if a set is for kernel or userspace.

I think similar thing happens for iouring.
The user space patches just fail to apply and the LLM doesn't run.
If that's alright with you please ask helpdesk@ to give the "nipa"
user permissions to post checks to your patchwork instance and LMK
when ready, I'll hook it up.


