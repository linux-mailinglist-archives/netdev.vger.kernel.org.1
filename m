Return-Path: <netdev+bounces-283441-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AIPrLNAu9mmHSwIAu9opvQ
	(envelope-from <netdev+bounces-283441-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 19:05:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 868C54B2F3C
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 19:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB9903009B27
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 17:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38866382F10;
	Sat,  2 May 2026 17:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MVBBxDOA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD333859F3
	for <netdev@vger.kernel.org>; Sat,  2 May 2026 17:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777741518; cv=none; b=TmqeXHViSSfivzW74FzxHWy6cXGLfyFYRHZ8RuDo6HGlDjhyU12EPKa0TVWYXL46+/9M+WAa3vHynsPV0pj0+524+HATjUmfEiT4Dr6smSCaPAS6RIDW62GlL+TA2U3H/VpoSE5qtehJ3X0PHZIkdcg4BRHaZEK4I9NDlV/mGsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777741518; c=relaxed/simple;
	bh=WOxF3lefhgUJcnAak8BNDhXN3CbTE4+93ugGsFvIy3M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mGOM2aQtJjr4Km9Cr2Yty8Toew9xSpn+zBYbwf9IBDF0u79HXGI9tsBcNN3TT8ljdWs/2CVuEECYEvCCkvNVYUYb6hNUScsryD3WeHJ+az1mOhEclEGx8cN5waCIS4sr0XyLew2ZJE+R8syLrx2BmmyW+Ggk7NXVh2zF/6dJ5SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MVBBxDOA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AB73C19425;
	Sat,  2 May 2026 17:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777741517;
	bh=WOxF3lefhgUJcnAak8BNDhXN3CbTE4+93ugGsFvIy3M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MVBBxDOAxwBifjxQcurMlZu0ZO6EvMSwf3WB3zeTpROpki6eLzTLngKRWe60EvnUu
	 S25gqSXdaA3ZfbY0b5t6yUeUDE3w0fw813r1Af20F5qJmGO8naA2sADKFAikoHDIPL
	 PAKDb9KIbe8T8CHyMZ2vt+CHzRv6oQYpjiHIipmrAg9e+VqD6kiPpvrfecyGMTJG3Z
	 ehiL7bqMrJxSRmbDNxnm1KueUAXOkC6DqfvGXN0wji1wjOjVv+Cmi1zViBKGU3TyUV
	 V3AdviFvpvXzvJrbbtxFwvbJAR1cZUNw1LdBnu2K3ee7JLiTtSuyxJhESYPRnG7Jrh
	 vJOwAKny3uNIg==
Date: Sat, 2 May 2026 10:05:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Wei Wang <weibunny.kernel@gmail.com>
Cc: netdev@vger.kernel.org, Daniel Zahka <daniel.zahka@gmail.com>, Willem de
 Bruijn <willemdebruijn.kernel@gmail.com>, David Wei <dw@davidwei.uk>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Simon Horman
 <horms@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Wei Wang
 <weibunny@fb.com>
Subject: Re: [PATCH v12 net-next 0/5] psp: Add support for
 dev-assoc/disassoc
Message-ID: <20260502100516.428ae359@kernel.org>
In-Reply-To: <20260501175528.2130551-1-weibunny.kernel@gmail.com>
References: <20260501175528.2130551-1-weibunny.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 868C54B2F3C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,davidwei.uk,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,fb.com];
	TAGGED_FROM(0.00)[bounces-283441-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Fri,  1 May 2026 10:55:22 -0700 Wei Wang wrote:
> The main purpose of this feature is to associate virtual devices like
> veth or netkit with a real PSP device, so we could provide PSP
> functionality to the application running with virtual devices.

Does not apply

