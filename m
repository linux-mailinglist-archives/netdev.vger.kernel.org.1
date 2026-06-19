Return-Path: <netdev+bounces-300550-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KAvnF/OHNGonagYAu9opvQ
	(envelope-from <netdev+bounces-300550-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 02:06:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B854E6A3253
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 02:06:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=f5QFekeu;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300550-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300550-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C12D63024A3E
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 00:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB5140D561;
	Fri, 19 Jun 2026 00:06:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D64510F0
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 00:06:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781827567; cv=none; b=eWLEZvJlbnIl40O93K6BVohGhdMth4AbCLtCwe3QZGFeALX+cyp97QxR9ubkfmxf85k2a25CWSd2ZWW1xxteAo4De0qA3bxb8jihr4PZYJXWTj1ss7i7YJ6rNsh9tSQb8JaQzre/fexTVye/T/tv+j83KuIrl9ZViNYknBmzmOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781827567; c=relaxed/simple;
	bh=rYHqSmGsH4cbKSWk54QP1sTrqPfbU0FMq9rs35T482U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mOm61R4EgsxroQJVv8mE9Nqu/2xXii71WCkVGo7AkggJ9bNbJ58e6r3B2Ggg5JKpUDewKOhOkhT785Y/l5wdtPMbs9G8Xy38SsssIJJGAyKCTvifNtmGB3yFeN9ty+RZdswihiuW110TIbkPYNUiO/y5L5XhhvNX+STzU4YFYNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f5QFekeu; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D54551F000E9;
	Fri, 19 Jun 2026 00:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781827566;
	bh=mFQ9tkYMs09gniDlAXC2Ca4YvMszBGigo8IziUjXlxw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=f5QFekeuScwVIKcJsGZEG5HvoyHnSvc8XERa5UfwpShqTINeMbnrk5YzI8pVUxxsV
	 c1didLOkTmqZU07W3eqluQyY5HiRbgxat5ekMkxcVaXk37DtQ9WmW5/h16n5di2ZRH
	 plBbhnqKCDN8Ix/WNLqcBjqxKKewQEFg2D9RxAJHKiuMpRGYzHBvbbIb2xRE69Wqg8
	 STOwpCnJHqnVducG5rZh6jLhDRrhFWsJWUG26rZZ/G4nzHjSD/ImWvbxySPYaJnGax
	 +eEWnfQJBsdhZ2HfaSaBKItbVmDfmL4xbveu809meunevLvH39qwDJ36CyRZuWQv03
	 9MBl0sFSB3sEQ==
Date: Thu, 18 Jun 2026 17:06:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: Donald Hunter <donald.hunter@gmail.com>, netdev
 <netdev@vger.kernel.org>, Riana Tauro <riana.tauro@intel.com>
Subject: Re: building ynl afaics requires updating the UAPI headers first
Message-ID: <20260618170605.0e2e4dd4@kernel.org>
In-Reply-To: <ade91456-2f93-442c-b76c-28bd7157f074@leemhuis.info>
References: <ade91456-2f93-442c-b76c-28bd7157f074@leemhuis.info>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300550-lists,netdev=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:linux@leemhuis.info,m:donald.hunter@gmail.com,m:netdev@vger.kernel.org,m:riana.tauro@intel.com,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,intel.com];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B854E6A3253

On Thu, 18 Jun 2026 15:39:46 +0200 Thorsten Leemhuis wrote:
> DRM_RAS_CMD_CLEAR_ERROR_COUNTER was introduced to mainline yesterday as
> ee18d39a087792 ("drm/drm_ras: Add clear-error-counter netlink command to
> drm_ras") [v7.1-post].
> 
> I finally looked closer today and noticed how to prevent this: update
> the kernel's UAPI files (e.g. the stuff that lives in /usr/include/) on
> the builder. Thing is: that's basically impossible to do from a srpm, as
> those should not change the build environment and can't even when
> working as non-root.
> 
> Note sure if relevant and just a shot in the dark, so maybe ignore the
> following:
> 
> While investigating this I noticed this comment in
> tools/net/ynl/Makefile.deps:
> 
> """
> > # Try to include uAPI headers from the kernel uapi/ path.
> > # Most code under tools/ requires the respective kernel uAPI headers
> > # to be copied to tools/include. The duplication is annoying.
> > # All the family headers should be self-contained. We avoid the copying
> > # by selectively including just the uAPI header of the family directly
> > # from the kernel sources.  
> """
> 
> Is that maybe not the case anymore with the recent changes to ynl?

Can't repro for some reason, but we probably need something like 
commit 46e9b0224475abc to add the explicit include rule.

