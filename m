Return-Path: <netdev+bounces-286292-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6JpyD0OSAGrqKQEAu9opvQ
	(envelope-from <netdev+bounces-286292-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 16:12:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E815048DE
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 16:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 22D13300B9D4
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 14:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01DD39B951;
	Sun, 10 May 2026 14:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HIB5EraM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA65F39B49F;
	Sun, 10 May 2026 14:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778422333; cv=none; b=rf45LwyhG+luGNEvYYPhob4/k00cXBwqgjmTn902KF93klqO1kuTVlbKV3ZeL5LPErZzV3vzJPXhcX3Ornb4CcQtHIP7KAaEfMK1v5WIAzh+LpF6215bYCi0Ao9U3UaSVsViw+kMwijYyzMb7TayC2HUpBwIaZxmi6YQ1yO5xPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778422333; c=relaxed/simple;
	bh=BLl+/W7VW9QtdhdpgQ4Gyg9VVkG5/0xjqw+dAMoiJyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HR8iQnDVrClBtfP1b7iO7FMbwXBakt+fvRt9dLYS2/EvaPjoL3kjKDAKiRgK6iRHDqHq56bb4ntqtP00iFe1KTbgRha1RvFyYPwzWzzkPypbmoacNCNM5VeImKkgNeNKScVZ6ArZkv+gdEEG+UJf13wtmWgLBzHpE+RugOh+IYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HIB5EraM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08590C2BCB8;
	Sun, 10 May 2026 14:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778422333;
	bh=BLl+/W7VW9QtdhdpgQ4Gyg9VVkG5/0xjqw+dAMoiJyI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HIB5EraMcgxMAT+wKydH5XNlirWzPUHVAWQ3cpGUhA0d8xQ6wMjE2miEx9zJ8gYGY
	 wzOfgHbN9vk9/XO7EkL4uUcOxpZtJMSS49q6w7xShnjLJFxTuU64jPuS2sKfY+xKKJ
	 eiI2xQm2JgmpdhN3lnFsLycXHpMsxIRJKPp2mUeA4AoyaLPM+vLF3btVruG2562ygS
	 yU5plsx2znq/EcdaynSG/iS2gi3oJCw/v4z7qyYNIusT6xzoinUtNfkccgVE0ivC4Z
	 XO3PtTaXUEgYmV4p44txKNMBs0EJl6QMzKq3FzhMXbDDVas23k70AnPysIs/hV6kpv
	 ssmZ59thbSlig==
Date: Sun, 10 May 2026 17:12:05 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: David Howells <dhowells@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Tim Bird <tim.bird@sony.com>, keyrings@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/2] KEYS: annotate struct user_key_payload
 with __counted_by
Message-ID: <agCSNaiHTcsN3Ye8@kernel.org>
References: <20260427114422.313356-3-thorsten.blum@linux.dev>
 <20260427114422.313356-4-thorsten.blum@linux.dev>
 <af8ZUXn4uStU_vs5@kernel.org>
 <agBiPEJZhWHydwuz@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agBiPEJZhWHydwuz@linux.dev>
X-Rspamd-Queue-Id: 88E815048DE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286292-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email]
X-Rspamd-Action: no action

On Sun, May 10, 2026 at 12:47:24PM +0200, Thorsten Blum wrote:
> On Sat, May 09, 2026 at 02:24:01PM +0300, Jarkko Sakkinen wrote:
> > On Mon, Apr 27, 2026 at 01:44:24PM +0200, Thorsten Blum wrote:
> > > Add the __counted_by() compiler attribute to the flexible array member
> > > 'data' to improve bounds checking via CONFIG_UBSAN_BOUNDS and
> > > CONFIG_FORTIFY_SOURCE.
> > > 
> > > Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> > 
> > This is again a crippled commit message.
> > 
> > I.e. this requires either knowing, remembering and/or cross-referencing
> > "bunch of" unrelated to keyring.
> 
> I kept the commit message short because it follows the same pattern as
> many other __counted_by() patches that have been accepted across several
> subsystems.
> 
> I'm not sure which part of the message you want expanded. Could you be
> more specific?

"Describe your problem. Whether your patch is a one-line bug fix or 5000
lines of a new feature, there must be an underlying problem that
motivated you to do this work. Convince the reviewer that there is a
problem worth fixing and that it makes sense for them to read past the
first paragraph."

This is a direct quote from https://docs.kernel.org/process/submitting-patches.html#describe-your-changes

> 
> Thanks,
> Thorsten

BR, Jarkko

