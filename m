Return-Path: <netdev+bounces-270616-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELB/KSCDwWnATgQAu9opvQ
	(envelope-from <netdev+bounces-270616-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 19:14:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2159E2FB127
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 19:14:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75D413238A35
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 16:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFAE43B27F0;
	Mon, 23 Mar 2026 16:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oYBaKdSK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7F23AC0C9
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 16:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774284676; cv=none; b=WxM9Tok7xXMIcE6Wvh1cHvDjQmDpvGqFP9JONzt0UR2BxlpJxn3YaKejZDckKxIL4pO/9RUZ9JfhLwmskxERm+3BvjIaYOU4hVNva7qcbimlN/JyMR+OLXgR0YaD1WY/m1F7hyKwuxSgauNqM/DyTObUNwrDlWQP612PutNrT80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774284676; c=relaxed/simple;
	bh=WdjcxPTcT4Y1PoQE6XWTl+XVkmHgqj7rjddA4gBZ+fs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D49deEtybsWbpWpKpXo/7c32+iN4tzDMi4zMzPVx9Tz71aykFBmswQtIueriieK6piN6GOy81tlq0RS8upsoZnEyUfiK7C2iu0CDfJ+saoq0kTbDNltSpCd/pVVoYZ5pu/38fXptvkFsy2cary+bFYzTNnJwwM18ka1Ra1HJGUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oYBaKdSK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BF57C4CEF7;
	Mon, 23 Mar 2026 16:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774284676;
	bh=WdjcxPTcT4Y1PoQE6XWTl+XVkmHgqj7rjddA4gBZ+fs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oYBaKdSK6Rwh8nA7QIeDktYYeXxlL+ZSi7aXvMooTqNgyaRLPpymvsOHWKiHf+8EY
	 LRYBHuC6zk6xNtVsgPwaKNNjxKmfo9a9fZID0sbEKqJqMf3HYrS02XiAzeed6vGHff
	 NxE84qFs61x5Zu3CaiOGwx2MKU2F691PpHUOs+k6MYqbEGYMJW2tXakmoLAPurQDM3
	 WSNZqr94++bGnXOGE5wWPlcmObWMgio4pm8LnQMGfjNV2K7dx0wvvcPPOLuwI3w0+J
	 MhklBAuGx2qCp0o1w6kGDDOWqH279aIalL0YZsJNVXjLQlzprSSj9ML4Lnvc8YzJCR
	 p93PZUE0SnVHQ==
Date: Mon, 23 Mar 2026 16:51:12 +0000
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: airoha: Rework the code flow in
 airoha_remove() and in airoha_probe() error path
Message-ID: <20260323165112.GA137813@horms.kernel.org>
References: <20260321-airoha-remove-rework-v2-1-16c7bade5fe5@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260321-airoha-remove-rework-v2-1-16c7bade5fe5@kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270616-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[horms.kernel.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2159E2FB127
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 21, 2026 at 03:41:44PM +0100, Lorenzo Bianconi wrote:
> As suggested by Simon in [0], rework the code flow in airoha_remove()
> and in the airoha_probe() error path in order to rely on a more common
> approach un-registering configured net-devices first and destroying the
> hw resources at the end of the code.
> Introduce airoha_qdma_cleanup routine to release QDMA resources.
> 
> [0] https://lore.kernel.org/netdev/20251214-airoha-fix-dev-registration-v1-1-860e027ad4c6@kernel.org/
> 
> Suggested-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
> Changes in v2:
> - Fix eth->napi_dev leak if airoha_hw_init() fails in airoha_probe()
> - Link to v1: https://lore.kernel.org/r/20260320-airoha-remove-rework-v1-1-adeef7e3c01f@kernel.org

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>


