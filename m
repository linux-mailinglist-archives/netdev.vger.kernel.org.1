Return-Path: <netdev+bounces-281540-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iA+rMJPv72nYMgEAu9opvQ
	(envelope-from <netdev+bounces-281540-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 01:21:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A8147BC69
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 01:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 737AA300AC8B
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 23:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA4A3AD527;
	Mon, 27 Apr 2026 23:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fpaqMdl2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F62364E92;
	Mon, 27 Apr 2026 23:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777332113; cv=none; b=QeCBg+4r8XCPNjK8OHSPbeRTsr8MOrXTUkra2gkoSc9g1OnVxguP8I4jQEhxRQrVlmQhsyAkd67SNJA+bd9a/zuBvl0RtifpVDJzhICS4chlbheB3BxRl5w3BzmYONsMSMyaGSrn6lWmHIRMYgTTwvOQpyFalFWhoKM1Cp3hl7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777332113; c=relaxed/simple;
	bh=Q2hQsgYw45RQ6lsi5Z/STthBpvPXGMk2unvl5kytVUM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RbOMcaNwYq/Ep81+5nRq8gpRA3P+A617LHzC3K6eg4rvFh+JkoNzcdTYn4w3rACw4KXv4FJP7VKUgtWqMlMmskZuOBG3b7uQORiyFTJlokzCWS+7s5qv0GkSlfOwZsko6yY/yoBdGGH4zPJRoMaYkDcm3qZlx9ME3rJGGwZMhPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fpaqMdl2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 426DEC19425;
	Mon, 27 Apr 2026 23:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777332112;
	bh=Q2hQsgYw45RQ6lsi5Z/STthBpvPXGMk2unvl5kytVUM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fpaqMdl2a8ebYpyDMjN1575+a0FgqoEi2U0gT+5RN4H1nn8N3frBjBQX5YmMOkNfo
	 SWGKSYU+4hlcJc+NAE5mcmKhPjfmYs3wAKHK8/I0D0CFbzfeaS6mF8S9G04jhz88OT
	 cICNl0qP+lhEBeubdB16wJRTiZsJEA5c9e53BnN6g7ytx6UR6ObgFjZ+yo1xjiMAQW
	 Yk4BkALpWq+e1Xp+h/HfanCpl2wyVHlZxoc+ObYm7VZPmk2in3ufZbe0WPRx2mlvJy
	 oBtOvsfC0LB6qUwSgE25UAZ7lLprxtXUA6AVIYvUFcZvgfb6UEW6ojkscLyL/wWwNE
	 5Xhve7SgE1ILQ==
Date: Mon, 27 Apr 2026 16:21:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: David Howells <dhowells@redhat.com>, Jarkko Sakkinen
 <jarkko@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>, Tim Bird <tim.bird@sony.com>,
 keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/2] keys, dns: drop unused upayload->data
 NUL terminator
Message-ID: <20260427162151.37fee368@kernel.org>
In-Reply-To: <20260427114422.313356-3-thorsten.blum@linux.dev>
References: <20260427114422.313356-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 64A8147BC69
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281540-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

On Mon, 27 Apr 2026 13:44:23 +0200 Thorsten Blum wrote:
> Subject: [PATCH net-next v3 1/2] keys, dns: drop unused upayload->data NUL terminator

to be clear - I expect "keys" maintainers to handle this, not net-next
directly.

