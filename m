Return-Path: <netdev+bounces-261871-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFRPBViyoWmMvgQAu9opvQ
	(envelope-from <netdev+bounces-261871-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 16:03:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CC1711B9673
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 16:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9DC30310EFE9
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 14:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043282D3A75;
	Fri, 27 Feb 2026 14:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rYH/hVvz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5942368971
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 14:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772204314; cv=none; b=cg4UdCv1TsP/bf+kPJGOGWhj5XJPaISAGlj97mOucIUHp0O8x2I6ykY7sndhUopzEvuRkHMjO1xbMKyFHDLB8Vwkl2aYmmtT8ZBBqGzjxI1C0t+W0Jj78dhINobGMFhCXGGLE0ayX89yQtYLkT8DtR2gtIJWq8qHaZbftNC9rj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772204314; c=relaxed/simple;
	bh=i2TVgEio6vDdbKNkvyM4S5XNu+0xJq6ljqvpbSzpaPU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UPL6vaX4h7c7YVmxhnst2294Ea2IxDxL0uxF+woXNuNSHzxrRpafcB5rm4HLIzdb5F2vfpUsU9izZ0/9iG0vwgPEOYF0OV5FN5xNuC4mOXuYf8oIYtZl4e5FHjO/vN9tOQt4v0Xo1R3obBSFv0LNQnQreDSxRHS9Qnb14tGiePA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rYH/hVvz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E1F9C116C6;
	Fri, 27 Feb 2026 14:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772204314;
	bh=i2TVgEio6vDdbKNkvyM4S5XNu+0xJq6ljqvpbSzpaPU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rYH/hVvzHj9g4lL4xritT9l38G+JVZzZRLrQNgGxiHSLzsPBr7Qbdeisoyf5/8P8a
	 SJ7hhlpIDZfkxWxjKAhLWX7vQ2qyH7NxQrwYbNcTYKXJ2Z2BI2sPqy5LzGhotjnHPa
	 NLRB3TVPDxd4tWuh1OPp8htGcSNSFyRYdp+7fVqnew11bb0WOkWEzXoKTYjNOuR6UR
	 VoqUoYyxYfqbWS+wY1cA8pyEWOv0sAUmIEtwjovqtZA2o0TEs2KbG9XQ0K8hXdniz1
	 InefQT7Dk0jS+rpBNNuI2TT1mdIDTQvOiW3KBOcYCY2aAAY+xdMj96rVE+huizf4Dm
	 me/MUGHrWHLlg==
Date: Fri, 27 Feb 2026 06:58:33 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: <netdev@vger.kernel.org>, Sabrina Dubroca <sd@queasysnail.net>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Dragos
 Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH net-next v2 2/3] selftests: Add macsec offload VLAN
 tests
Message-ID: <20260227065833.36edcc6c@kernel.org>
In-Reply-To: <20260227090227.1552512-3-cratiu@nvidia.com>
References: <20260227090227.1552512-1-cratiu@nvidia.com>
	<20260227090227.1552512-3-cratiu@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261871-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CC1711B9673
X-Rspamd-Action: no action

On Fri, 27 Feb 2026 11:02:26 +0200 Cosmin Ratiu wrote:
> Add macsec offload VLAN tests using the netsim VLAN support just added.
> In case that VLAN support is missing (e.g. when running these tests on
> older kernels), the VLAN tests are simply skipped.

You have to enable macsec in the config file for netdevsim selftests
-- 
pw-bot: cr

