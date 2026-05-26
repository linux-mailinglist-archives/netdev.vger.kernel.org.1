Return-Path: <netdev+bounces-291970-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0AfsLFglFmociQcAu9opvQ
	(envelope-from <netdev+bounces-291970-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 00:57:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5CB5DD5FE
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 00:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3E14C300E2A1
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 22:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675C43C76AC;
	Tue, 26 May 2026 22:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jrAZrVAf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1C2369203;
	Tue, 26 May 2026 22:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779836244; cv=none; b=Ofat9f+ttGcNtMYu/YDAEgEBONdek16pHFNc4C56XWC6gcrxw0KBeAtqRrL7ypRLJNKpN52YbSKg3svq48NyIvKUSvCXj8ut0y+LJy3IQ7YU4O+pkmYUzkyOVdU7XP0uzOxG/tieO/8THrxW59c5pdxtobXI2bkvm2byDgoAwu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779836244; c=relaxed/simple;
	bh=rrm1X2Au+GwWM7X248OH5MAqa2qLhw0nxEyO79WXfdw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tZEFVNA4J6iMl+wQnSeRl1wyRonfOs44oyQuVqyGzLQLouIvwh4ho+d5a2xbHU97bhV8aDmrXowCEZC6kaW4iiT5jVhHAxOWCOWlxFQBAx/fAkIOfezJFOkZyBzpwdihk3f0Cad9lyiYA8RJIhBMG3rzQpd8SPxkiPkIkK0rWNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jrAZrVAf; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DCD51F000E9;
	Tue, 26 May 2026 22:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779836243;
	bh=GTLQbQirWCX9wneQxMJs+zrdeHvDyYa9lL03+uAy86k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jrAZrVAfWe5reoPlJzAvC0IunOmAr3jfsAMnufUy0DSpPA8pWHG3wkkMtYQLNY8/r
	 h17vDPURuVj+SwJbgdgdYupLniYFm8h+JX9rcq8run04D02CUL+M0+i7IUt4ec0Slp
	 52MNOK4zlevHB+n+JxK9emNwl495Y6Ux64z6JFaUt1j91K+SY2FMXvP0LCr2GPpUqf
	 Ai/cBhijYBMtMEYsQ7U+GqXliCBGCQq63sHmdM4JPDZ/h6eB26l9eWOr/s/7Z0Wpwd
	 z+smdefEGbhcrBvETFN5vLF8vxm95mK/enTZ055bUJzYWAYBe2RD8CesP6HWURkl0I
	 defyHEprr3JMQ==
Date: Tue, 26 May 2026 15:57:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Kuniyuki
 Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>, Willem de
 Bruijn <willemb@google.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-crypto@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] sock: add sock_kzalloc helper
Message-ID: <20260526155721.16154829@kernel.org>
In-Reply-To: <ahWezce_kddgrgy6@linux.dev>
References: <20260427104129.309982-7-thorsten.blum@linux.dev>
	<ahBRCxCXbCq5LeCc@linux.dev>
	<ahVkZOxZtFes6Huf@gondor.apana.org.au>
	<ahWezce_kddgrgy6@linux.dev>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-291970-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4F5CB5DD5FE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 26 May 2026 15:23:25 +0200 Thorsten Blum wrote:
> Could you take a look at this small include/net/sock.h addition and
> provide an Acked-by: tag if you're okay with it going through Herbert's
> crypto tree?
> 
> The series has Reviewed-by: tags from Kuniyuki, but it hadn't been Cc'ed
> to netdev before.

IDK, feels like the usage is low enough to border on pointless churn.
Other netdev maintainers may feel differently.

