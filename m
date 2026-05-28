Return-Path: <netdev+bounces-292816-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kF4UKpWXGGqklQgAu9opvQ
	(envelope-from <netdev+bounces-292816-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 21:29:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0672B5F7163
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 21:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B247D300A779
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 19:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534183ABD88;
	Thu, 28 May 2026 19:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DmD8MP3v"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5861232695F
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 19:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779996227; cv=none; b=E/yjyl/Q2eXOdQEtynA5SyEdHQliHiicOivUAVL6BVVRmdPczKdtuKaNyvtwlZT8PTDUr1Vtdi8ILIbg5wEe01l0y3X4M7OIeL022MOc84fhGnPjp4pv6ttrVkRA0Oj4ASbe3EGTeIGWF57r09IqVygBVmXLHaNBSv266XHudPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779996227; c=relaxed/simple;
	bh=D+G8mYFvoi8kYoA0GEYxESd3ki5dJ6/ViaQg+yxFhWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mynUBeiuRSSxjeLPjFYqeaCiB3zTWJY/eimcbvYqJzUMlF85/nd61lht25rwMijBFI12uGFkgMWzlhDzyNAFtOEu5vsRX0DSQI8FV7BmN2eh5dzVq9r3LRBoPuwe3gAZ3dBq9C+eF1KnQxoLXOpZ+2x5wAsMpVrswhtfynAtwaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DmD8MP3v; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 708E71F000E9;
	Thu, 28 May 2026 19:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779996226;
	bh=uvVVvBaSnGMNoYKGOTw+6tArk/uUnyP0xWuZIUPp5Xk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DmD8MP3vrKkJ3rmTVFbjQ4LjQtid++XMY8moeI2TKYtOMLlAprnjbmD6JxqzzxZ61
	 c9Mt0RvDm2J7jw+uSxFY5a3UhgShzjU8EHP8iv4sjhpRSygVGu0uttw/hDqLLnIm2R
	 hWgLQFQf5Nhgg/Z5K/KiDfX+LqT+zZUrI7bMnmZM=
Date: Thu, 28 May 2026 21:22:52 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Wade Sparks <wsparks@vulncheck.com>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
	security@kernel.org, Disclosures <disclosure@vulncheck.com>
Subject: Re: Unidentified Fragnesia Variant with Public PoC
Message-ID: <2026052803-repulsive-outlying-b566@gregkh>
References: <CAA1v+Sj=THjpUA6m0wX26DVQWMe8=YMZ5HwMo8K8ArjZopCKxg@mail.gmail.com>
 <73b5b45c-08df-47db-b749-b4b7cd625b3f@lunn.ch>
 <CAA1v+SiTtZA74PONT8vsipoze7ZpdxncRO3vMNjRWy=jsRoDKA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA1v+SiTtZA74PONT8vsipoze7ZpdxncRO3vMNjRWy=jsRoDKA@mail.gmail.com>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292816-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: 0672B5F7163
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 28, 2026 at 12:25:44PM -0400, Wade Sparks wrote:
> Hello Andrew,
> 
> Thanks for your response.
> 
> The proof of concept for this finding is already public and was *not*
> published by VulnCheck but by an entity referred to as V12 Security.
> Additionally, we were able to reproduce the issue ourselves and can confirm
> that the exploit is valid (albeit on a downstream kernel).
> 
> While our team works to reproduce the issue against the latest version of
> the upstream kernel, we wanted to share our findings with the kernel.org
> security team. Apologies for adding in the wrong maintainer distro - we
> will redirect accordingly.

Please read:
	https://docs.kernel.org/process/security-bugs.html
for what the security@kernel.org alias is for.

thanks,

greg k-h

