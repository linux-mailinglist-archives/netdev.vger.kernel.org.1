Return-Path: <netdev+bounces-273854-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eHqxJAmDzGlXTgYAu9opvQ
	(envelope-from <netdev+bounces-273854-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 04:29:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F676373E19
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 04:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BE0E63048147
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 02:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2793321A2;
	Wed,  1 Apr 2026 02:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JZ+p8zHi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BAD233120A;
	Wed,  1 Apr 2026 02:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775010539; cv=none; b=khP5eCyzz3udu0l4YM1p6fbcqkuMXnlFIaSl/jrdJHsYpoWBAaaXnsGyXBI2iJiqDaMLZ8jmpcwvQSb4Xk6hqRsTet8ETWDeEw5TpUQfDCFXVxirJzR5L3CzWywr+RX0kWts4KRuKwDw9Ej6FfedU6QGyvQnItWKfLcOUZIHNy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775010539; c=relaxed/simple;
	bh=bDqnA8Y+MHF307E/ucS2d/pscQlQbAeqhbq//vhlwCk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F+OJ7trishTKTHuRQ1WeDopQtjr+2hMXwZpjJpPpZvfb3HimSL2xalJ2UdOEen72DHTTSkIZzcYrdqmvCLsHXIG1fuylHqCFIeQL2kNRCSUNBkA1YmWePLENd+9lbYPc+HJVHRCAW4tiT/UrjXaWTsyoh4VI01DUzNL5bITuNPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JZ+p8zHi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FEEBC19424;
	Wed,  1 Apr 2026 02:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775010538;
	bh=bDqnA8Y+MHF307E/ucS2d/pscQlQbAeqhbq//vhlwCk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JZ+p8zHiOA66yDrvD9spYRhEXTZDD1NptX39j94tpv3zGgaD0LisYb6Os9URwsIPW
	 yBKe0pWTC9K9HUPAogAULFABBzMJQg67Rhd8MqV2hhe2Z+jlbE77FMNml1OKh3ABvF
	 +TpCZUnvgHWpL5OkzVy2TrywJlCk7ZR/4I4cMaqShZu+ERVOjIg49iZX87B0x29yPQ
	 lAsW4lgZCdLMyOq7eQ0Pet6EnTm6Wk9tFj8jNwBWfCqA0fXZV4Iq5D/qWLh8KzxFIK
	 rka2bYLUD0icOG8FIG5rSIc4/6U1E+nZwlTsCPeC8vT/AgIuW1L38tWdeH4kHV3g7x
	 Lt1Kz0EqistaQ==
Date: Tue, 31 Mar 2026 19:28:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Carlo Szelinsky <github@szelinsky.de>
Cc: Kory Maincent <kory.maincent@bootlin.com>, Oleksij Rempel
 <o.rempel@pengutronix.de>, Andrew Lunn <andrew+netdev@lunn.ch>, Heiner
 Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/3] net: pse-pd: prevent regulator cleanup
 from disabling unclaimed PSE PIs
Message-ID: <20260331192857.500d6e3a@kernel.org>
In-Reply-To: <20260330132952.2950531-2-github@szelinsky.de>
References: <20260329161014.2908509-1-github@szelinsky.de>
	<20260330132952.2950531-1-github@szelinsky.de>
	<20260330132952.2950531-2-github@szelinsky.de>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273854-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[bootlin.com,pengutronix.de,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,redhat.com,kernel.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7F676373E19
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 30 Mar 2026 15:29:50 +0200 Carlo Szelinsky wrote:
> --- a/include/linux/pse-pd/pse.h
> +++ b/include/linux/pse-pd/pse.h
> @@ -260,6 +260,7 @@ struct pse_pi {
>  	struct device_node *np;
>  	struct regulator_dev *rdev;
>  	bool admin_state_enabled;
> +	bool admin_state_synced;
>  	struct pse_power_domain *pw_d;

new field is missing from the kdoc:

Warning: include/linux/pse-pd/pse.h:267 struct member 'admin_state_synced' not described in 'pse_pi'
-- 
pw-bot: cr

