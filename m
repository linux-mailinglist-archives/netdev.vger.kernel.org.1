Return-Path: <netdev+bounces-258458-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHbjHMTbjWlm8AAAu9opvQ
	(envelope-from <netdev+bounces-258458-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 14:55:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0B912E025
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 14:55:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6E4C330073E4
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 13:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E62285CB8;
	Thu, 12 Feb 2026 13:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K/QB9ozZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9506B35BDC2
	for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 13:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770904511; cv=none; b=ls68efNfEKKMY9FB9qxIM8dxkUdzcRKSLcNHmI4MxD6LfYiKCaVOYDHw2BD9XAYsuSm1HP9x+vC91ryEJbopOqBOkbi6vX8uIDcXsH0cUno4HqX1a79irmhgx1sR9HUBXIoSPRQfCmVJfee7Q0o9kEQDMw1SuFbgUzeW+is+aFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770904511; c=relaxed/simple;
	bh=KAT1lJQDph4IFw7BNipqvXdkU4CRDXaLeP7nEPQKiK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C7WGkxXJ/YruJhy7sCfrEsiC7hnhyl8b9Z3N0qtxrv9Wxqbsyo+Kjn8/Ch0RNHFO3NzbH1qxf9uBUCuLljNvK1RCbg65/kbcYsj7FVyByQXj9L5ptQJPqb33S80XJua6QaPMI02wsRKJ+d4WvSPSHGTwBGZLO8Xv1+4kyJKTG30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K/QB9ozZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 164A4C4CEF7;
	Thu, 12 Feb 2026 13:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770904510;
	bh=KAT1lJQDph4IFw7BNipqvXdkU4CRDXaLeP7nEPQKiK0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K/QB9ozZsDBlozpX7Rh+xTFwvklKOdbdBEFXiHw5MV4DnD62n1DWcIucInMj59t8U
	 gVKWY0lIF/rsswpONmswXsr9IyuPux+oB/9tS6vlxm50HrMC+W08sGfyvYUsGZTdhe
	 oOSRJZKanuM24QpF75WqtYTOifwQAlfn/DCfbkV0StD0u0ZzVYD1BDlHb3O6yg2rPh
	 oR7a/neELSJaRyxfIO8EuYFqGcnMMaaU9MOf58Pfqf2ymniwe0cERKnbfo2U3Ct8Om
	 IiuQRRZwFmmQX8i7TiJTrKM57vMOKLzDBNniyaBrnVxc6AIcpGEhes0WZNrqlqjPUz
	 jF6BYX4rJKbcQ==
Date: Thu, 12 Feb 2026 13:55:06 +0000
From: Simon Horman <horms@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
	Ido Schimmel <idosch@nvidia.com>, mlxsw@nvidia.com
Subject: Re: [PATCH net] selftests: mlxsw: tc_restrictions: Fix test failure
 with new iproute2
Message-ID: <aY3bujP8mB2vDhTk@horms.kernel.org>
References: <88b00c6e85188aa6a065dc240206119b328c46e1.1770643998.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88b00c6e85188aa6a065dc240206119b328c46e1.1770643998.git.petrm@nvidia.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258458-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: DC0B912E025
X-Rspamd-Action: no action

On Mon, Feb 09, 2026 at 02:53:53PM +0100, Petr Machata wrote:
> From: Ido Schimmel <idosch@nvidia.com>
> 
> As explained in [1], iproute2 started rejecting tc-police burst sizes
> that result in an overflow. This can happen when the burst size is high
> enough and the rate is low enough.
> 
> A couple of test cases specify such configurations, resulting in
> iproute2 errors and test failure.
> 
> Fix by reducing the burst size so that the test will pass with both new
> and old iproute2 versions.
> 
> [1] https://lore.kernel.org/netdev/20250916215731.3431465-1-jay.vosburgh@canonical.com/
> 
> Fixes: cb12d1763267 ("selftests: mlxsw: tc_restrictions: Test tc-police restrictions")
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


