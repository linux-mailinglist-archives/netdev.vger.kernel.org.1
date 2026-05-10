Return-Path: <netdev+bounces-286312-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QBQsNOClAGoqLQEAu9opvQ
	(envelope-from <netdev+bounces-286312-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 17:36:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C86504DEB
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 17:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4B40B3003378
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 15:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3471039E6F0;
	Sun, 10 May 2026 15:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QW0Z/KvY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F70639DBF8;
	Sun, 10 May 2026 15:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778427358; cv=none; b=VRn2mK8wWUGKYDCxuSu5+dqgLZWMDQ5j8B6iZSwVp4e0HHBKoMe9zSUP3+r+IklzDL6B5Ff/BbQykjbt2g9lG11zWRfYdRAoxU988qfvee+v67352e3Vbbb4r8qvZf/EFG04TXO/GLpb7bN6aWs0HuvwrKvlHY0lQIdp77tVAag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778427358; c=relaxed/simple;
	bh=aUKoTe/d0V5RVsYZnKb7HxOHTVuqXPqbv1S0iDQnq28=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U+Ew2RZbA5iP2T5McD5ElafNXkZc+Y4qpYMn3IAA48xArwRz193qD7V4RpasJj5FI/E0XTb+GdeixEqxg2nVH8jjkH01ROTYZQoD6FJDGLVIcVjwfH3QXiPM8XxmjqOC10k8cJfl/eV7ky25Gx40Ujm/jeMEHpxFhH4e/x4SeAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QW0Z/KvY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53DEDC2BCB8;
	Sun, 10 May 2026 15:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778427357;
	bh=aUKoTe/d0V5RVsYZnKb7HxOHTVuqXPqbv1S0iDQnq28=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QW0Z/KvYyBFioEJAFrbCYO7t5szFKi8eO0KbJIY9cIyoYRT34gcIjFJawj0j1V62C
	 2JqMmYsLGNrfxNOa/qO4wfzdS+mRWXL9Kj+k22Jq61fMMTthOv7rQTldFkOGwqYorJ
	 IJ+NUXiQs3PDHmQLDRR1mSDsRi2DHfHVVBfkgw3riIszVa+Km1uBDqWfE47tqY0r4S
	 53XddhTwiY3x8R9VFJ5r2oBsCBl9mWLfJt7d8wJ/LmH0L9S5crRB/5hbu85DLQ3eyT
	 w0E9YFxgpLbVMIrQH47YR+LffvYiG+r0btgBWGD451k4fS0qYC3r3HsAtJIZqeFcMJ
	 yBbdZpURkWxtQ==
Date: Sun, 10 May 2026 08:35:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, donald.hunter@gmail.com, horms@kernel.org,
 sdf@fomichev.me, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] tools/ynl: add check-deps target to verify
 Makefile.deps completeness
Message-ID: <20260510083556.60e92d73@kernel.org>
In-Reply-To: <20260508204114.205896-3-sdf@fomichev.me>
References: <20260508204114.205896-1-sdf@fomichev.me>
	<20260508204114.205896-3-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 76C86504DEB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,redhat.com,gmail.com,kernel.org,fomichev.me];
	TAGGED_FROM(0.00)[bounces-286312-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Fri,  8 May 2026 13:41:14 -0700 Stanislav Fomichev wrote:
> Add two make rules that detect missing entries in Makefile.deps:
> 
> check-existing-deps-<family>: for families that already have CFLAGS,
>   parse each force-included header for #include directives and verify
>   that every included uapi header is either already listed in CFLAGS
>   or findable by the compiler without -idirafter.
> 
> check-new-deps-<family>: for families without CFLAGS, check whether
>   their default uapi header (linux/<family>.h) exists in the kernel
>   tree but is not findable by the compiler -- meaning it needs a new
>   CFLAGS entry.
> 
> (this is slop but I added extensive comments on how it works)

Would it be more suitable as a NIPA check? Or at least it'd feel less
bad to carry slop in NIPA than in the kernel tree. We already have a
test for YNL build.

