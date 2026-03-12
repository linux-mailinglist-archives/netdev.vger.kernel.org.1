Return-Path: <netdev+bounces-267173-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GgyMNn2smmLRAAAu9opvQ
	(envelope-from <netdev+bounces-267173-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 18:24:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AD327688B
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 18:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E28803008C92
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 17:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B66E3D332F;
	Thu, 12 Mar 2026 17:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SzPgaMEP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A213D1703
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 17:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773336275; cv=none; b=gADNKorA+HJ9rkxS/fhEfhMdH/j8fdK2w2+tjXcqULgydaC4atbXnynb7ZURFW4UjoT52jA2fUa7umIxCxgNbe+GViWv+JEiaB0mFCSpRpO0KVxzIyPbEA7O0fDuDub+PJsTNJnJmd/+GyiqZJDMUffoMFwwRyU4zyg1chdtt7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773336275; c=relaxed/simple;
	bh=jV2J+lJWy8MZOh2+4/7XvcTYDLO+BUIFkgtlrJ53xFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pKuyfGRq3RqUgi83vI1WJJoyuWufBIx3SIKQZI8HigxP2rzXsNikg8Rs9+pxSs8bURtnLYXF7hwdAAhwC6pCuBbro5agZr+o8T153QLR3jesipcViRp/1lEsuWSfzbx4hxKfwJzbPNabtFGTTKdZK78B9NSwCvdk16iG93hiv4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SzPgaMEP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D509C4CEF7;
	Thu, 12 Mar 2026 17:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773336275;
	bh=jV2J+lJWy8MZOh2+4/7XvcTYDLO+BUIFkgtlrJ53xFg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SzPgaMEPUJx4IdFv6/yhBYBUV6GUyrhGm2KB2QnNkDaectWkOkvzjyoJWHxOsCnIc
	 QFTsdXdV5Dt4HJzfv66bH/H4aODSffR/L5JlO/EN+ZMns/HLH+XWgDe3g4JWH4DVUP
	 LYMR8NYY3+huxOXzhL+T1EOXNoCjVPquO5HTPhCHyiUaxGB6/wTYAn+KX130SuoSS7
	 lnATL25Te7C4Cx6rLDSAs1XyvszOEFnhzHj2zXHau/kQo2orMHGW2mUeIetOmLngtq
	 4HVdmQibfBFXgXjYIVkjAJ+FwjLhPBzvpcw7jaR314fT2gMZP937UFWNR/7CJ7sOuq
	 emRHpI5OR1o2A==
Date: Thu, 12 Mar 2026 17:24:30 +0000
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: airoha: select QDMA block according
 LAN/WAN configuration
Message-ID: <20260312172430.GA1267298@kernel.org>
References: <20260310-airoha-qdma-lan-wan-mode-v1-1-64ec74dea872@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310-airoha-qdma-lan-wan-mode-v1-1-64ec74dea872@kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267173-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C3AD327688B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 10, 2026 at 03:46:53PM +0100, Lorenzo Bianconi wrote:
> Select the QDMA block used to send the traffic to host cpu according to
> LAN/WAN port confiugration:
> - QDMA0 is used for LAN devices
> - QDMA1 is used for WAN devices
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Hi Lorenzo,

Is this a bug fix?
If so, perhaps it is for net with a fixes tag.

And at any rate, could you add some description of the before and after
behaviour?

