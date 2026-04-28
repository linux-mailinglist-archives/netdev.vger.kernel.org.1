Return-Path: <netdev+bounces-281853-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oBkEBhSz8GnsXQEAu9opvQ
	(envelope-from <netdev+bounces-281853-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 15:16:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 120BD485A70
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 15:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4A21131245BC
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 13:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0271144D005;
	Tue, 28 Apr 2026 13:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fdQoeFhZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02D4212542;
	Tue, 28 Apr 2026 13:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777381295; cv=none; b=rokLj7DUfIcX+yCbFMrP4mYDOOz/NR+sCPHISPQF5dJcnbobdvZmv/1ntuZY45S+RJo4Cc13trLSLG2eoEchy6iVJxSpeOe8+eRlR+6SCphXN1wCqvxH1CVMKVFwphFvNezXuWU3iz2xmgxUWVy5I8+lbpgtNqBKmZxMw3T2JKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777381295; c=relaxed/simple;
	bh=mYMvL3RT0JQEkkV8OC+iZfRT5L4605aTgd/Wc9MdFO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZxnuI5N2TrTV6z9VS033b+9WWUBUhx3KOcmXT6mxaJKseef/g2GU9q2bjqhDmPcxO3WM9pR8JINke0liag+apGKNTiBwrziqvKhqBV917GXhatCPMviMg9OSVqaaEgu7sHHJwH5H1tr2NONXae5txYGVoWc250Vx6zci6CXjMk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fdQoeFhZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B72BDC2BCAF;
	Tue, 28 Apr 2026 13:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777381294;
	bh=mYMvL3RT0JQEkkV8OC+iZfRT5L4605aTgd/Wc9MdFO8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fdQoeFhZBreFNnWW+ZqREafCfVPWpjBGzHW23FP6hJOP3IoyUinShHrF/Z6g0nBen
	 v6fiRGyFWR9TB19DWi7GOPX6M31IXzivNjEWm1S4iXRJ3oDsiWodVyhrG5+YZ5cGuI
	 GqWTBGo64cGjJE2zPxKkdSu4d0EPM8LKm2OnZTAWQ2nfn5YfuqRIK5A/In6u90AiSp
	 KHP6wD8z1Uy6V2dFPJgP+B9a+IR8rLr8u6/17F0W7hYoamQhFOQN02S0Xvxue60hKY
	 mnZmhh5FUHGO5sIiIIPfP/MJMweDD+ZxsWTDVlDaerS2ytELHcjLfqs+nKScS8e6sT
	 QPjX7I7YKgNkQ==
Date: Tue, 28 Apr 2026 14:01:28 +0100
From: Simon Horman <horms@kernel.org>
To: Heiko Schocher <hs@nabladev.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] net: phy: dp83869: fix setting CLK_O_SEL field.
Message-ID: <20260428130128.GR900403@horms.kernel.org>
References: <20260425031339.3318-1-hs@nabladev.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260425031339.3318-1-hs@nabladev.com>
X-Rspamd-Queue-Id: 120BD485A70
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,gmail.com,kernel.org,redhat.com,armlinux.org.uk];
	TAGGED_FROM(0.00)[bounces-281853-lists,netdev=lfdr.de];
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
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,horms.kernel.org:mid,nabladev.com:email]

On Sat, Apr 25, 2026 at 05:13:39AM +0200, Heiko Schocher wrote:
> Table 7-121 in datasheet says we have to set register 0xc6
> to value 0x10 before CLK_O_SEL can be modified. No more infos
> about this field found in datasheet. With this fix, setting
> of CLK_O_SEL field in IO_MUX_CFG register worked through dts
> property "ti,clk-output-sel" on a DP83869HMRGZR.
> 
> Signed-off-by: Heiko Schocher <hs@nabladev.com>

Reviewed-by: Simon Horman <horms@kernel.org>


