Return-Path: <netdev+bounces-271378-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id woXvLq1ew2lLqgQAu9opvQ
	(envelope-from <netdev+bounces-271378-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 05:03:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A0BB31F68F
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 05:03:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7FAC23137EEF
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 03:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873932E6CA8;
	Wed, 25 Mar 2026 03:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rxiumUV4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6264717BEBF;
	Wed, 25 Mar 2026 03:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774410947; cv=none; b=o2R5RJURhS1ob96+w2k4nJTsg+MVXeqSCLEKUVpliFyHhxLrbUiigVZfCweVylTznmOwCvUpb9CFKSjVO3zBZrdDpaIfqDHaWbBbexXU5DZaO4i+uPca7N/pDEPxcAFRLsPw96lnLB2038FACbqgzwL/3Q8kOaXXX43ZzKOFxOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774410947; c=relaxed/simple;
	bh=ecEYSLeERewWN89IgeuDUXiRprg8d06yYRo95t3oLZk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tp5yF/hIqg0nWgPdeRpVMnAcR9ei1S5k059auBKf43VCc+NAep9//LRIH1NngG9VpKMNzJGqhEZ3Hv+ioSNgkiCPvdoJBa2WvEI/e3PWxc7aBRF6h2lyfTLxSrV4Ye/TZG518ACYyhhiY+I/iDutkFAe3UpLXRIjk1n0dvQCF8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rxiumUV4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C39DC4CEF7;
	Wed, 25 Mar 2026 03:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774410946;
	bh=ecEYSLeERewWN89IgeuDUXiRprg8d06yYRo95t3oLZk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rxiumUV4hJzKBiPBF+9ocT4oGqv8xVpTEn62Hp+7/IYRnshnSfyYBDaeguD2uXoyO
	 CN8S8UyM8zoQkJCHmwm4ugNcLRU2CeOUZEtRQrpTcD0IKDtUppP9E7USWuj4X+IwYc
	 5B/6e+10Rq+V8mmeV3v21mJzwZUdbIIcIc3oLsm5/BT3k6uOchCGhygpEaTESGucvh
	 +8S43uSJCJbq2AT7WtX7UrfY8ScFgGVx3KRlhnWYHEEiJ2SQ5qDBOq64xYPcuX/cmX
	 MbAW7XL9FQ5SuA9zc+vJkBG7ZxrgBkJAum+4oFJXqLPNYa3Gtxqf5aqt7/d8S4Euc4
	 SXdHG+6NK1CRA==
Date: Tue, 24 Mar 2026 20:55:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Cosmin Ratiu <cratiu@nvidia.com>, "andrew+netdev@lunn.ch"
 <andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, Dragos
 Tatulea <dtatulea@nvidia.com>, "shuah@kernel.org" <shuah@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "edumazet@google.com" <edumazet@google.com>
Subject: Re: [PATCH net v5 0/3] macsec: Add support for VLAN filtering in
 offload mode
Message-ID: <20260324205545.7bbd8fdc@kernel.org>
In-Reply-To: <acKrRrOG0v9KDk_J@krikkit>
References: <20260323123633.756163-1-cratiu@nvidia.com>
	<acFODtfaa8LCKX4r@krikkit>
	<5ae5d08d578fce1a01a548fad8552a14df8c5679.camel@nvidia.com>
	<acFWIxzM-GxpAhjH@krikkit>
	<20260323093243.17c14edb@kernel.org>
	<acF1jeGLpq7qDKgY@krikkit>
	<62b3b47291879328a868aa15fb7319b5ff13a20e.camel@nvidia.com>
	<acKrRrOG0v9KDk_J@krikkit>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271378-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2A0BB31F68F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 24 Mar 2026 16:18:30 +0100 Sabrina Dubroca wrote:
> > Adding back the nsim debugfs file and test assertions guarded by "if
> > cfg._ns" would ensure filter propagation correctness, but would feel
> > non-Pythonic and a little hacky given that the same assertion can't
> > work on real HW.  
> 
> I think that's fine. The tests are anyway python wrappers around
> iproute commands, it's neither "Pythonic" nor pretty.
> Jakub, any objection?

No objections, I already added this nasty little piece of code in gro.py

    try:
        # Disable TSO for local tests
        cfg.require_nsim()  # will raise KsftXfailEx if not running on nsim

        _set_ethtool_feat(cfg.remote_ifname, cfg.remote_feat,
                          {"tcp-segmentation-offload": False},
                          host=cfg.remote)
    except KsftXfailEx:
        pass

I agree with Cosmin that the check feels a bit non-Pythonic. Dunno
if the try except ends up being any better tho :S

Let's not use "if cfg._ns" tho, please add a method that will return
true / false (or feel free to come up with a cleaner way if you can
think of it). We definitely don't want to encourage nsim-only checks,
if you add new methods please mention in their documentation that we
strongly prefer if the authors can think of a way to prove correctness
that would also work on real HW.

