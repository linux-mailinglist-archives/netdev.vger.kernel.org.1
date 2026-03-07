Return-Path: <netdev+bounces-264974-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YC7iJSZtq2kodAEAu9opvQ
	(envelope-from <netdev+bounces-264974-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 01:11:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 943D8228EC5
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 01:11:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 74FD4301CEF4
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 00:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 121561531C1;
	Sat,  7 Mar 2026 00:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TpsZvZ5R"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33B29463
	for <netdev@vger.kernel.org>; Sat,  7 Mar 2026 00:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772842272; cv=none; b=SXcXsPnJWlGhf2mDvHSUORomPKiiWfJtJGeE5yWcgrrIzWQd6LbbOEg6lgPn9ENV5MJbIixur/pfoIr+AigwDtUbewNtaA4pc1+dNy7Uug41ANofkx1POoyMjgPt1zoIA1YbjpnAyLNDk9dEomoIuktxBN48ToI0u6eIZV0rUHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772842272; c=relaxed/simple;
	bh=oDT+Q+qqL4+dAXxfDM936gfjKS8/9E6lxJFLn8cJlo4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ot6avfzrqcQ7fwV4pK2u2Cyt6O24jT0FuO2g5tUelrAnogl9pXtjbCHVUNV2MFCrB/2xTu6tJhKBucmIf2kSnhN9E02WxRt4/qBDQljtnnlHLOYQaQdEFz8UsG3jCq/e5zXZaVcjfZ2itwZfFSr94CFeALqOyvi5wpoV/3rZ/5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TpsZvZ5R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 004DEC4CEF7;
	Sat,  7 Mar 2026 00:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772842271;
	bh=oDT+Q+qqL4+dAXxfDM936gfjKS8/9E6lxJFLn8cJlo4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TpsZvZ5RXY8dlJEUJtVXZDgaANzJEth6S5IY936usaROES6iqVeRCOtF8Udk4sZfM
	 JfkDvnFY3rqPIXLx2TqtUCyZOsUSx2x/cmG5I760h0qNoDcn8AIELjFmMf4LcFcPwc
	 JwiyVyOS3M8nwYVn2Ukh03ld8i10pwUK4aDFlu+Gr+AchgPu7Z6gn1zPa5t2APfwpa
	 +IbNs8X4XnPPT8+k5DP93oi9M24KHs0B7zLE+X28JQUDGCeL9K5tz+OaQjEaiIjbg9
	 IdMhC3teb5uFANXdq6V6c6OWL6V82RS2Dgc3YNk57QnWSnNIPNb7QuV1D4+oBGkdds
	 iWa2bQrYV26GA==
Date: Fri, 6 Mar 2026 16:11:09 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 liuhangbin@gmail.com, matttbe@kernel.org
Subject: Re: [PATCH net-next 07/10] tools: ynl: convert devlink sample to
 selftest
Message-ID: <20260306161109.1a4a9b11@kernel.org>
In-Reply-To: <m2ikb9i388.fsf@gmail.com>
References: <20260306020901.524105-1-kuba@kernel.org>
	<20260306020901.524105-8-kuba@kernel.org>
	<m2ikb9i388.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 943D8228EC5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-264974-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.986];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rt-addr.sh:url]
X-Rspamd-Action: no action

On Fri, 06 Mar 2026 11:53:11 +0000 Donald Hunter wrote:
> > +# SPDX-License-Identifier: GPL-2.0
> > +source "$(dirname "$(realpath "$0")")/ynl_nsim_lib.sh"
> > +nsim_setup
> > +exec "$(dirname "$(realpath "$0")")/devlink"  
> 
> exec is defeating the netdevsim cleanup in the exit handler.
> 
> .../ynl_nsim_lib.sh: line 22: echo: write error: No space left on device
> Error: ipv4: Address already assigned.
> Error: ipv6: address already assigned.
> 
> Same for ethtool.sh, rt-addr.sh and rt-route.sh

Ah thanks! I've been testing these with:

  vng --user root -r -- ./tools/net/ynl/tests/devlink.sh

didn't actually check if the cleanup works..

