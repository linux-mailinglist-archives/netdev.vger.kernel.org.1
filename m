Return-Path: <netdev+bounces-268689-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QEhzBAqIuWmTJAIAu9opvQ
	(envelope-from <netdev+bounces-268689-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 17:57:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A1892AEB2D
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 17:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7211130078FA
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 16:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E1A3F23DD;
	Tue, 17 Mar 2026 16:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hiNB2V72"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444163EDADD
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 16:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773766078; cv=none; b=pOM7I6NzMKyHaveCpU5MzxWbHlWNuNUt//suY9nryd2aAVJXyUO5KM9HUH7mf5wsRpJdl8ntWmVfmW+6MGd74aZQJfnF/xYNgnLFAyOmTiQ3vQikT/0oswUxAFwAiZvk1XDy14z1eCwiEciBFcmhHX/YFAfl2BILDvB6hfPZOS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773766078; c=relaxed/simple;
	bh=rumOXYImD+L1idgG1Se/fSNUa0rCcEh1M1ShMRl0WKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XxPVbTIZR454I6vDATR6d78Ka9vmCuhv6sl0WbHMnFPstrWs7UVVX76PwAmqcOh5qru8+KE+ANx2WIGDmERXDlfoLx0e8A5Cj/kiB/rIbXdtKsVYZDy2vHCUQehnJLspvZ5fIPi74nioBLe8dvmJSAOsnzfinHg6PzRDFgAxnbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hiNB2V72; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23AC7C4CEF7;
	Tue, 17 Mar 2026 16:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773766077;
	bh=rumOXYImD+L1idgG1Se/fSNUa0rCcEh1M1ShMRl0WKo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hiNB2V72ffDhZsAKnAlwyPim7jN83hjH2y6phTw7Ux8vLXkq6c/w1QOkdPJ+ina2W
	 M/hXXS078/UjRWT91MCS7GruPbrksz2DovGptGH33I7OKx3JjbkaNszB0fc0v5Kgiy
	 Rnghs8XFuezkWYaNZVG/QMGfFacObUXhkVw9ECYHqZQicsl3DgqqG6abv9UeD98vRZ
	 D/tuLrESxHbukJbJUJBuCKFFIE3cTgjbErfLi9hsVJYAIukevATbi7EJ/CqLm1szZf
	 fyQuVv9UOnjsXpqS9kDnnnYh5c7tYYx4+MQSyj8WoHLWcUaPW6fL1S1eMeD60gI7nI
	 mAUOHOQFIwrDg==
Date: Tue, 17 Mar 2026 16:47:53 +0000
From: Simon Horman <horms@kernel.org>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: linux-afs@lists.infradead.org, marc.dionne@auristor.com,
	dhowells@redhat.com, kuba@kernel.org, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] rxrpc: Correct rack timer warning to report
 unexpected mode
Message-ID: <20260317164753.GB1753385@horms.kernel.org>
References: <20260314195109.3867287-1-alok.a.tiwari@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260314195109.3867287-1-alok.a.tiwari@oracle.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-268689-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,horms.kernel.org:mid]
X-Rspamd-Queue-Id: 7A1892AEB2D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 14, 2026 at 12:51:00PM -0700, Alok Tiwari wrote:
> rxrpc_rack_timer_expired() clears call->rack_timer_mode to OFF before
> the switch. The default case warning therefore always prints OFF and
> doesn't identify the unexpected timer mode.
> 
> Log the saved mode value instead so the warning reports the actual
> unexpected rack timer mode.
> 
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>

Reviewed-by: Simon Horman <horms@kernel.org>


