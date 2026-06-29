Return-Path: <netdev+bounces-302687-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 89zvAFyNQmp/9gkAu9opvQ
	(envelope-from <netdev+bounces-302687-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 17:21:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F166DC934
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 17:20:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=DSvYaW5y;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302687-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302687-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B13F31971C5
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 14:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843F63BED47;
	Mon, 29 Jun 2026 14:59:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9414F2D3ECF
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 14:59:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782745153; cv=none; b=u72T8k3HQYtQmEu2qwwff3aG+TxuyZoaKXtOgZ5NYLp7Hdl//B3zWWdxzlNKDSx0EvuzRmga1WbhLFHYEYVSBUKNaVksSSGOczBC89ZLgSWNRycyrtMI+NLAsk30aSY/XJwU3SWuE2LK/XVGD5euacC4bRrdYDCgl5LFbr0DiU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782745153; c=relaxed/simple;
	bh=U73iG2jB4U3G09IyI7yXFibzsSq/khlKp9BoHFddutI=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=gxhrOl2h/5s8O65VufbTRO9pwBzYW0tzMm07SunoMzwA9jCprEyWKqvPKCBvZAjHn6/BisEMlNS7zMOHajm3wOTNlZwQRH7/lxc62e0S9evAi5PuS6EjAbwVtFcAPBZqQ/WJNCdhtVkmTmi0iGk+2QdafdVLpFOMpVyTqw2AfEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DSvYaW5y; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F13C61F000E9
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 14:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782745152;
	bh=Ty6y97JMdpTzGhE20SLOr6806cgGUcOEM1g9ulnp+70=;
	h=Date:From:To:Subject;
	b=DSvYaW5ytC8+ytMAmm4TXa38Dz2OG0MgCxa5txVSEWBDF0gb28JLGpKxJqBwbXKqH
	 fFUBxVoqyZH9b9lSJ8ArTk25cwElVU9SpTnwfyjqm2rBwe/+VwEcA3e/P+gGo7uEJl
	 C8RqdRH4Vdr7hlLhJoFMnc2Kf0JE5pJaivW7X2B7loLPNzNhCxgwKmojCMZhQVM1TX
	 GZpdDp/fqNrSa/woYMgrhuxwtFr3DRq5LKMawB1JjwHR+9R8LvlC5F8UF2tywRjS9Q
	 npUuu1xPpMbHAFuUCAb4gASTGXY0NcDXQ0lbFjKNpTbiXNBy500JG38R+E0Yq5Y40k
	 uYX93MeAGHu5w==
Date: Mon, 29 Jun 2026 07:59:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org
Subject: [ANN] net-next is OPEN
Message-ID: <20260629075910.20c08b2b@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302687-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 82F166DC934

Hi!

net-next is now open, and accepting v7.3 patches.

It will probably be quite bumpy in July with a lot of vacations 
and netdev.conf along the way.

