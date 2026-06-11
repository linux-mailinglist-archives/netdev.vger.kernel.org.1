Return-Path: <netdev+bounces-298073-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 92GKI4WNKmoTsQMAu9opvQ
	(envelope-from <netdev+bounces-298073-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 12:27:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6684670D71
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 12:27:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=eWPvu2My;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298073-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298073-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E94383002E28
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 10:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1A13CBE69;
	Thu, 11 Jun 2026 10:27:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1DC3C417E
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 10:27:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781173634; cv=none; b=VOm1dg4JGTqcXTy/uBy7uFL2AW6KZqcPBgesap5DV3a0oEchlhf5+nOk5KvUW9Bx6AOEl+VsGFr2lovk2twllEqDZhhL/tka/8DrfMDsfMB29sMcM+vdx+BDixV3j0H6fKENHr4v7BE6WnfVF1kycuCaa2ZFjtUtKXa4UveUF5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781173634; c=relaxed/simple;
	bh=mGuWnBJ0YF4lIDVErJvA/dHQhHiT0U7xix/8Q58p0ik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hpd5p4l6xZoXTaNdDvfcqyEGyE2FYTkjsHz3KaOI0Nu/EXhsngiVmQTmTJZnsuc5Y5li6grhnhx5Cl46LLfSMU2ZOIb5mcm/agOhNbJqU9h95tmjfqBu764n9ynqRuXHUYnoWhMUQ2WQUV/0zNxfoQno+KBrX7n3b7kqEruh9JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eWPvu2My; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A0361F00893;
	Thu, 11 Jun 2026 10:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781173633;
	bh=DzjtudXBoeDJMAmrpGr3WXAi/sP2pduwjgnBqvaHH8Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eWPvu2MyRHUhkqDgQ7mrXD7ZjH8z2e1yojjtPmMT8cHxnucb6N5T3oMp7u9xEoN18
	 HBxqHLLmtDeiFHTOAWegGAsMc/K62I84EkY5Ki23cdjefDSo9EcTLtSrhfpfSzVDig
	 JdHYzz1fbRz7CVAFAXeFHC1LsoErs8iSApKdN+s3F6LyT7hPLA+WAhoqnqZaSDwCIY
	 g0MQk9+RPXm/ka5+RcjodUQbIWKHuomXjope1OOOuxV3Ql/bdpzx+pGAAWNZbNlERE
	 jxFh8+XrlDL2o9+/2pXbprwH5zyPG4RORbJ8ATa/ODcyXBVWrZo0spSr0RubLgEj5P
	 F2/sZjeHeqncw==
Date: Thu, 11 Jun 2026 11:27:08 +0100
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: airoha: move get_sport() callback at the
 beginning of airoha_enable_gdm2_loopback()
Message-ID: <20260611102708.GQ3920875@horms.kernel.org>
References: <20260608-airoha_enable_gdm2_loopback-minor-change-v1-1-1787a0f42b31@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608-airoha_enable_gdm2_loopback-minor-change-v1-1-1787a0f42b31@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298073-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:lorenzo@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E6684670D71

On Mon, Jun 08, 2026 at 11:24:15PM +0200, Lorenzo Bianconi wrote:
> Move the get_sport() callback invocation at the beginning of
> airoha_enable_gdm2_loopback() routine in order to avoid leaving the
> hardware in a partially configured state if get_sport() fails.
> Previously, get_sport() was called after GDM2 forwarding, loopback,
> channel, length, VIP and IFC registers had already been programmed.
> A failure at that point would return an error leaving GDM2 with
> loopback enabled but WAN port, PPE CPU port and flow control mappings
> not configured.
> Performing the get_sport() lookup before any register write guarantees
> the routine either completes the full configuration sequence or exits
> with no side effects on the hardware.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


