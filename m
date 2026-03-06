Return-Path: <netdev+bounces-264904-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oK0TMOQwq2n2agEAu9opvQ
	(envelope-from <netdev+bounces-264904-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 20:54:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D4E22747B
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 20:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8718F3037402
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 19:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A903EFD1F;
	Fri,  6 Mar 2026 19:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cdwVtuvk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04081145355
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 19:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772826847; cv=none; b=gRiCnw7UuXpDvUKMRSMrUAmjLYkQJSQUvLcvxqtLIgON2mBTqpOEY/wcsv/OALrJMTgIANI26djXsVgnnRcyZ/5Jlcay2Z0/rnSuHdsOhupEDA9GUfJYdmjamds69NWC1OdLMOw9aRSC66aunZncL29Aijf9NINDgymtALwO2xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772826847; c=relaxed/simple;
	bh=3SsygiV7zp566IdjkNsXPEkg4/SAeelhgvEjpg88Nik=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O0LOo9L6ygLAwY0F9HJgp0Zcs7tdSe+3tnNg/ZuvpN79z5kc6Z1NrvgEeC/Nck0nvlWUPsBfGtzxL26yHOtKICX21Y3RDrLzNfU4wke68afyiwClVHlVHNRHV8g8ZW/AqKdHDyE8Aq/dmjpQoNHMo9nSeOY+Y10IYF1Ex71lHA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cdwVtuvk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A3ADC4CEF7;
	Fri,  6 Mar 2026 19:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772826846;
	bh=3SsygiV7zp566IdjkNsXPEkg4/SAeelhgvEjpg88Nik=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cdwVtuvkTUM+fFRpewA3i7ohSbsQgRvtzbd0zBpbKtD/PfWLi8uVRQmMCzQTA48bL
	 dQkqiKMrZatXmcHilZZ3+RZ8a2FIJh0S1uv9yRHu89YZG9vo4DSt+C+DkoK0G7s1zs
	 wEY76T+aaV5xeR+rE/6kDi3BnjSImdxljChEgxLS7RX1C3LAwEXdiVFKsVP8GVi3sD
	 M51Jv0HKNFoqSx1qqJmklypbDwmQnyeJScKInmNhf0It1/topw3WsrH+LTRjNygOrU
	 T/oMFGbYL8W7NjcrBuZoO/mG83OSpF2wVtwwLbUYSJDHpv9le+yPQ9ureuNkaJliv0
	 VBK6mikxpt8Xg==
Date: Fri, 6 Mar 2026 11:54:05 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: <netdev@vger.kernel.org>, Sabrina Dubroca <sd@queasysnail.net>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Dragos
 Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH net v3 0/3] macsec: Add support for VLAN filtering in
 offload mode
Message-ID: <20260306115405.0febac64@kernel.org>
In-Reply-To: <20260306115353.28f322e0@kernel.org>
References: <20260306151004.2862198-1-cratiu@nvidia.com>
	<20260306115353.28f322e0@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: E0D4E22747B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264904-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.978];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Fri, 6 Mar 2026 11:53:53 -0800 Jakub Kicinski wrote:
> Also please see

https://lore.kernel.org/all/20260304151647.2770466-1-kuba@kernel.org/

