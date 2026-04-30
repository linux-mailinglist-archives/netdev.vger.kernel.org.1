Return-Path: <netdev+bounces-282958-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNdjGzOO82kQ5AEAu9opvQ
	(envelope-from <netdev+bounces-282958-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 19:15:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF174A63E9
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 19:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3538F300B469
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 17:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0B12C3255;
	Thu, 30 Apr 2026 17:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pphg7XQ5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7D51FBC8E
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 17:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777569328; cv=none; b=IOr71Sq/87INB8v5Mq9F/ZqBsuA7zMjAtrqr4RKlg4+KaXkoI+Pc18Qw4nDf+iloedikvUa5VnzWYj2iYF241V9ebwUvPTCNmH1lmxKkL9FH9KlS/tVKYWdPmQbOLJpqZU04xwYjW03s3bTkmdmJO7KuzcosAU/1qqbB2D4nbDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777569328; c=relaxed/simple;
	bh=mb1Rt9GJDM6MFUJmF+OZpJrprjSJxcsE/PCQCUOVtbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JHL2p62PII5/K2Me/sRcFKII6Z17eWUl51+19EwlAJNVHBnOPxzOKE4YHdhpqjhRHCZYfX5cRjn1lajkwhcl0JlNGKshbLliLgF3dNolBGkBbQr7PfHEbGO/dJ1VcfH8PwGZEhRUcG31NZSYK00Xt++xyF3DmqzjEBNv6f3sD4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pphg7XQ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4518C2BCB3;
	Thu, 30 Apr 2026 17:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777569328;
	bh=mb1Rt9GJDM6MFUJmF+OZpJrprjSJxcsE/PCQCUOVtbE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pphg7XQ5aPXiMO1eyuQwlUOcgAgyKmjXmzMKSp0Gaio2wl6nqC5yLnCPPxhUGuKcu
	 fmOBvwwGdrFmg2zzViZYai0Jtmvh5+tJc7J5z1tAJUN7s5eL1yXPlXqRYpGszbIVaD
	 rv+cahNw/Dai1BBvFe0ddFDT/gNOQjHpjXs3YRskAX2pUBDlBXpCrtnWojOB4OPGDM
	 BrjIUh0mAj/sHcaXfluEGPfHAeABim6Vr4lE2Si4AACz+3fYM63EeylBhgKt8wDY4+
	 TMmiNvpY+GhZNg1UQ52kL5YKnl9BOk0yqd7/OTt97BxByr7WGUTcpTSceBhXjRlF0Y
	 DZk4AJQOMh91A==
Date: Thu, 30 Apr 2026 18:15:24 +0100
From: Simon Horman <horms@kernel.org>
To: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: Matt Johnston <matt@codeconstruct.com.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH net 0/2] net: mctp: test: minor kunit test fixes
Message-ID: <20260430171524.GE900403@horms.kernel.org>
References: <20260429-dev-mctp-test-fixes-v1-0-1127b7425809@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429-dev-mctp-test-fixes-v1-0-1127b7425809@codeconstruct.com.au>
X-Rspamd-Queue-Id: AAF174A63E9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-282958-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,horms.kernel.org:mid]

On Wed, Apr 29, 2026 at 04:21:40PM +0800, Jeremy Kerr wrote:
> This series provides two fixes in the MCTP kunit tests - one exposed by
> ktr, and one found while debugging the former on different VM configs.
> 
> Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
> ---
> Jeremy Kerr (2):
>       net: mctp: test: use a zeroed struct sockaddr_mctp
>       net: mctp: test: Use dev_direct_xmit for TX to our test device
> 
>  net/mctp/test/route-test.c | 2 +-
>  net/mctp/test/utils.c      | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

For the series:

Reviewed-by: Simon Horman <horms@kernel.org>


