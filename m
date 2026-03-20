Return-Path: <netdev+bounces-270058-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cA1yEAGovWkAAAMAu9opvQ
	(envelope-from <netdev+bounces-270058-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 21:03:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 052B42E0B2C
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 21:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7238C300B986
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 20:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C2D355F5C;
	Fri, 20 Mar 2026 20:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jLA/Z9cF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B104C34EF06
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 20:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774036836; cv=none; b=BqUH3Nhr34bZChuKLaNR24jhcgb2QrKifXoN4kWuFbD8JYfRrg20SG6hwJ4eyS1uFWCfUXCG1gAUjCZZ7xwdLd3MPRaMM1ZDxa8R3NqG+dX4z5RUGd8E+BOJNquZ2BW5rs0MMWw2t+tDFNuytW4S9rARSJJHePvLQIgTXGAC++k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774036836; c=relaxed/simple;
	bh=7RWcsTU2360ka8mJ0tGJAWGE66My1KMl+jpt2ccA72c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R3s/74s63DN9NAvW6JKMcS4NOakKK95HpFF83q1/9pigO0YgWWrgC9nE2PWxtpSQfDFK55TNLDyb7g3SCE5nBkbGcUB9OTZpPKd3VhGgj9ij9OrZxHqOHBh74vXwa+6KLexe9eKiiI7x8L15ExjHlsOj31tYigGEOsh+5eYrAQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jLA/Z9cF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16507C4CEF7;
	Fri, 20 Mar 2026 20:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774036836;
	bh=7RWcsTU2360ka8mJ0tGJAWGE66My1KMl+jpt2ccA72c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jLA/Z9cFRVCNKBAonUR//Mbeb74tF+SBIDFDw39IgBxMUhtdwsFWunm/r2YWVexV4
	 o/8Nc8i2Jpvp4fiBrZeodAYZ7g9MxvhjwFqnV24S2JpM2uvr3e/ZycZjA/uvacjDRS
	 UP6mAnSQX3fxQ/1SXXsEe6efG3o+QR/11lpUvxrC8zaZc7Sx/VfiI/l81ulgQ7EN7J
	 x3sxIdBgc4wHRlL6wl82wovWUJP0953DjU/S4NkCnepy3hJOQKaVAHOt4gZL/v0rdz
	 3TNC8RUMdtKN088TH57nBYjCfa33SZksYHXzJ6VVIlQ526LtV9cUTkdGTNgQg5CrtA
	 4XHjhM2DtuDbQ==
Date: Fri, 20 Mar 2026 20:00:32 +0000
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org, Marcin Szycik <marcin.szycik@intel.com>,
	Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@intel.com>
Subject: Re: [PATCH iwl-next] ice: use ice_fill_eth_hdr() in
 ice_fill_sw_rule()
Message-ID: <20260320200032.GM74886@horms.kernel.org>
References: <20260320050556.422762-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320050556.422762-1-aleksandr.loktionov@intel.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270058-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[horms.kernel.org:mid,intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 052B42E0B2C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 20, 2026 at 06:05:56AM +0100, Aleksandr Loktionov wrote:
> From: Marcin Szycik <marcin.szycik@intel.com>
> 
> Use the already existing helper function to fill Ethernet header. Also
> replace sizeof with a (also existing) macro to reduce the number of
> variables.
> 
> Suggested-by: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@intel.com>
> Signed-off-by: Marcin Szycik <marcin.szycik@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


