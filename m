Return-Path: <netdev+bounces-299083-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZPNXA8ngLWoemAQAu9opvQ
	(envelope-from <netdev+bounces-299083-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 00:59:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ABEA67FFF8
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 00:59:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="V/1FXH0E";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299083-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-299083-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 909393002516
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 22:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC6B1C7012;
	Sat, 13 Jun 2026 22:59:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9A570830;
	Sat, 13 Jun 2026 22:59:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781391556; cv=none; b=DIwDgmaoDpiJOGtfjNuyJp82myDNbY0F+XYJCwhB9+RHOh6zqnIuUjln05shrH+ZkIkK+qkcyc553ssOTuN/qKyWqHxJ5O7AAosvv1qbPha+7aMTDy9siY0pIuKaE1NEb4o5OQlJB5PoH8Wbm3XlTJijGwmqkHRRuVkZHKkF5Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781391556; c=relaxed/simple;
	bh=/HcngOFacV4go3McTXOhGYFw4t1jgvxuhGFRwMZCRGg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ruH8ZJ9jMsvtVMkjYBZsl89wN7QkzeIHDwIiZJu3P7dZtFjwIHKvvfU8yfgsTbCzvpoAhp+gembNSPzSxJSecSfG9CHHww2iURBtzxn+Cx80M4eEXW7/xSf1ai0dkgNFjjVK41yhgyxHENKfaRMWhdKUdiQdhQIq7zD8FoO101M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V/1FXH0E; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2ABF1F000E9;
	Sat, 13 Jun 2026 22:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781391555;
	bh=bEj4ks/2XCQ+6BnDhYUjIHJe4oM/a1u+JgjglS9s4tQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=V/1FXH0EchJ3MZAidI8Po8S2ybsrh4jFqpIv749EY1JiYUhtB+bldDSFBEo4PyEKI
	 je5OdQWiKHAKacA+o0FXpGG4aSnu3JViXcQfPEbKrPffyy/kATMpYL6sddpLA5GJ/e
	 e9Sl7+b2a6RJ9urUnr9Y5kacF7C3BidWrH5af0qLMmtVSpuG53M2LLahyvKLx1Pfkr
	 9540oErSEdFrP72TzjZ0FYB2l6qn6wPmpzMZqN0OYIvHsRE25WpPOItR+5YE2n90LW
	 MX72gqzCdtlnAE2RTEzR6R9agDq+jMyEleA4cJeuuo8Ex1B+y48mw2/05EnUq1Thxm
	 uDiuCuhBDvqvA==
Date: Sat, 13 Jun 2026 15:59:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Robert Marko <robert.marko@sartura.hr>
Cc: o.rempel@pengutronix.de, kory.maincent@bootlin.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 luka.perkov@sartura.hr
Subject: Re: [PATCH net-next] net: pse-pd: set user byte command SUB2 field
Message-ID: <20260613155914.391515c7@kernel.org>
In-Reply-To: <20260611102517.445549-1-robert.marko@sartura.hr>
References: <20260611102517.445549-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299083-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:robert.marko@sartura.hr,m:o.rempel@pengutronix.de,m:kory.maincent@bootlin.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:luka.perkov@sartura.hr,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5ABEA67FFF8

On Thu, 11 Jun 2026 12:24:49 +0200 Robert Marko wrote:
> The Set User Byte to Save command has three subject bytes.
> The PD692x0 protocol guides defines SUB2 with value 0x4e, while SUB1
> carries the NVM user byte.
> 
> Template only initialized SUB and SUB1.
> Fill SUB2 explicitly so the command matches the documented layout.

Could you mention if you observed any misbehavior in practice?
If you can see any effect of this patch it needs to include a Fixes tag
so that it can be backported.

