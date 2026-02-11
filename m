Return-Path: <netdev+bounces-258317-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mBZ3An+2jGnlsQAAu9opvQ
	(envelope-from <netdev+bounces-258317-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 18:03:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C187E126658
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 18:03:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 07478301451F
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 17:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DFDD345CC9;
	Wed, 11 Feb 2026 17:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jMFlzRlF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A21345725;
	Wed, 11 Feb 2026 17:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770829424; cv=none; b=d7MHBE3SOvHb7AdLPvtkQaCAzPALr93qh/o+NFEYcJJrDTUFXQcK0mN/3YOBrsdbB2NVr+wkJrsYCcPKUa3I5d7cSN4bVKqUY4IpmxarXnpYyB4yoh9kq3Cl5x7NygE5TxDqc/aV4WOFHCIsVT1TKX8l+K5n8VFWTqI+7eHMcE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770829424; c=relaxed/simple;
	bh=E99E2loPe1XNp/4rNcxLKLp/1fEYb2lWU2cfOaniQfc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ax1ucAFObH52a3dhINqu9CzwffVQglEf1VHFjS2kFe3TOMZfYK/foPLe21l6HYrg8xvotcuPQ6UVvZvZ6HC3dsK3+AOq0y0M4DR3VG+WqAmXrATqC8oXQm766Thjx9zpGWeP2w/2kLvKxtKyz+mruzDSQKR8R2jjPOcbNueySK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jMFlzRlF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 731C0C19423;
	Wed, 11 Feb 2026 17:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770829423;
	bh=E99E2loPe1XNp/4rNcxLKLp/1fEYb2lWU2cfOaniQfc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jMFlzRlFXIsiNrEqUqXhlSVsdXOgiUqKehMm6RtDeDD0gdBAuiB4Nrxx7miCl27Dv
	 47577Cbis/av4coUEQfVSRhzfwgx8g2LzgsRy3nuOVBl3Rx7afW75c5xSTavkV993R
	 ypqKS/7ypaOVauvJITohr1PpKpO+C4sGWmO7XVvem/0D0+j83D/2p9Gsv9l942EkiK
	 tBp/+KNeUxhi1pXeNMasd6ORr1ruhpv9CQ8oJXeoAfFUh9KJ+Ok+Bv/D2SIf9b3bNi
	 FPdBrI4H5OQtrgLiZVw7zPXwdk92EERZhSYpkRJ0uNOhlseq5T0F/0V+MgIL/jEp1E
	 1z3zaG2V74psA==
Date: Wed, 11 Feb 2026 09:03:42 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Yohei Kojima <yk@y-koj.net>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] docs: ethtool: clarify the bit-by-bit
 bitset format description
Message-ID: <20260211090342.561a9d54@kernel.org>
In-Reply-To: <f43999612ed9d17fb7fe8f21e777e1c784f23c46.1770457868.git.yk@y-koj.net>
References: <f43999612ed9d17fb7fe8f21e777e1c784f23c46.1770457868.git.yk@y-koj.net>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258317-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RSPAMD_EMAILBL_FAIL(0.00)[yk.y-koj.net:query timed out,kuba.kernel.org:query timed out];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,y-koj.net:email]
X-Rspamd-Queue-Id: C187E126658
X-Rspamd-Action: no action

On Sat,  7 Feb 2026 19:25:38 +0900 Yohei Kojima wrote:
> Clarify the bit-by-bit bitset format's behavior around mandatory
> attributes and bit identification. More specifically, the following
> changes are made:
> 
> * Rephrase a misleading sentence which implies name and index are
>   mutually exclusive
> * Describe that ETHTOOL_A_BITSET_BITS nest is mandatory
> * Describe that a request fails if inconsistent identifiers are given
> 
> Signed-off-by: Yohei Kojima <yk@y-koj.net>

I'm no native speaker but FWIW:

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

