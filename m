Return-Path: <netdev+bounces-275347-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +GOGMVDg0GklBgcAu9opvQ
	(envelope-from <netdev+bounces-275347-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 11:56:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA3C39AA87
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 11:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 149CC3005ADD
	for <lists+netdev@lfdr.de>; Sat,  4 Apr 2026 09:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A618D3A5E83;
	Sat,  4 Apr 2026 09:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EpFInEa3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832B7288C30
	for <netdev@vger.kernel.org>; Sat,  4 Apr 2026 09:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775296590; cv=none; b=XEJ457PSfJF4jnQAmTO/IBh36ekkeWOvnIHtU/ijODzLTbjNTtiGIGEbqoRyd6ARXyhBu8MI4XdFN4uW1qKxVdehigNj+wRVS3+GFmi8ykQ3wVQBGxc5m49zQ4odb5ByAK9vLL63X6DxCgLwd7UcUnvkqCpuVUK29EgRS6am6/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775296590; c=relaxed/simple;
	bh=EHEpMniwIHOZ6/r+AlZSaysXedBfbFrCyNCdnIX5QSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LkepUf1AxpDWP5fdVJLilpBzQX5Z3LJ/fMGqYWOAhvTKbfkaVPjFsI9LGPBKqXtcjpf6kQeBa48IGa7fiYQxNa9ivOkB3gEQBLIaqgs1LtK0pC1sBoLiUbjIVBm8hY+HMeP/nD67PgSEffrTkhp4qoEVqgmIRthbEoi+f+UEtvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EpFInEa3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 913E0C19421;
	Sat,  4 Apr 2026 09:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775296590;
	bh=EHEpMniwIHOZ6/r+AlZSaysXedBfbFrCyNCdnIX5QSg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EpFInEa3iA2hKMnR92Z+WlJRkMpt167QjKW6f0a2bsMbDpI6bou3HngwHVgDt/jG6
	 +M193pykKv2VS3SjKzhndZOpitGbAWuF6ZGYa3aWfeJrukVNvTiOg9Hmn771w5d4Rx
	 PSb/Lrd1Z6IaXH95EhT9nO0DfNjhj8/7028nC8zE+Jrxf4aSeT1i9j9U1YUV8fMzAa
	 3ktpXupLtNp/0wFEfc/DVcylP6pvx5MJ1xtb5Uh7/IzuMEbp2SywwgnKiD8txsH5wP
	 rs/zqoNS7bUO0biXxF1Vr99n07RVmgoI1//Tx3oCNjPCwK+mx15wV2FB31KzmWFCRk
	 ecSmj+c5OfnMA==
Date: Sat, 4 Apr 2026 10:56:26 +0100
From: Simon Horman <horms@kernel.org>
To: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: Matt Johnston <matt@codeconstruct.com.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: mctp: tests: use actual address when
 creating dev with addr
Message-ID: <20260404095626.GB113102@horms.kernel.org>
References: <20260403-dev-mctp-fix-test-addr-v1-1-b7fa789cdd9b@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403-dev-mctp-fix-test-addr-v1-1-b7fa789cdd9b@codeconstruct.com.au>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-275347-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[horms.kernel.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,verge.net.au:email]
X-Rspamd-Queue-Id: 3AA3C39AA87
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 03, 2026 at 10:21:04AM +0800, Jeremy Kerr wrote:
> Sashiko reports:
> 
> > This isn't a bug in the core networking code, but the addr parameter
> > appears to be ignored here.
> 
> In mctp_test_create_dev_with_addr(), we are ignoring the addr argument
> and just using `8`. Use the passed address instead.
> 
> All invocations use 8 anyway, so no effective change at present.
> 
> Fixes: 22cb45afd221 ("net: mctp: perform source address lookups when we populate our dst")
> Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>

Reviewed-by: Simon Horman <horms@verge.net.au>


