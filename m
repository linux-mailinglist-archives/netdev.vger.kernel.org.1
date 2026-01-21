Return-Path: <netdev+bounces-251729-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0IkZFHM+cGnXXAAAu9opvQ
	(envelope-from <netdev+bounces-251729-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 03:48:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B137850031
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 03:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A15B3850075
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 02:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0CD346FB7;
	Wed, 21 Jan 2026 02:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RpUsS3+s"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1000F33F8CE;
	Wed, 21 Jan 2026 02:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768963325; cv=none; b=LG5neiklaaPx2282ktDO3/5M+9BAQdg24NU7VhwWmxI8rGTGDugGK/9lF4/U3gn0vD7eBTCMUOHlX7E4HgIhNO4+6zjRBLA9OvUHy3pXI/qX4uOotOHokaClHCt8us/Bf++Sbu6CkSf7GBB/pIFMLSdMvbvnn2cmhOYzrd5TdUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768963325; c=relaxed/simple;
	bh=v6iM2yAiePFKIrDAfdbKUGOtEjOGrJcEX1d0m5fqtzc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T2bgXveM//SFv4ZbGIyHbCheOLjAYP84+V/0ts8dFPRts+T1hvW1x9QSy44c21+XMl2ULKX/B0fyaW9McBKkz3F+HByPOJbyJqjmJY/uTsuCiVxASHTp1KEDMb+nVMUgILyosCvTjjfdEJKwBY5frzkkMtQo+kpkV7M6AhrI838=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RpUsS3+s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D75CDC16AAE;
	Wed, 21 Jan 2026 02:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768963324;
	bh=v6iM2yAiePFKIrDAfdbKUGOtEjOGrJcEX1d0m5fqtzc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RpUsS3+svJ7wU44s7Lrl6l37xAuKy9c+32CPVneqmEiNATCL8aT0KgHmRSznKcH2O
	 Zd4Sm2Cn3cf4ObLU4l+FRIKNaCHajuzbPPwNvG9a654obIVXOC/lk3vmgfcBRs7vBe
	 4YJlD0ZNmbRrnO60XPUFBgiW7ppTMtEQarKsX0D2O/C6nmUrgSKTpspStRJy8/xnya
	 vBBt/Ba34i7Y0g4PBB/SQg/3lO01ejrY+uqTQ0eyB26j32Zyw8xzS1M8rB4LDeAxJh
	 SmBvnmF5XMDhugBWYLuBUQOqTkGzAzyVvlu9TklzpljShCemXSF+gryFS+nES2RxTC
	 crQnJJ/WR/m/g==
Date: Tue, 20 Jan 2026 18:42:02 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: <mturquette@baylibre.com>, <sboyd@kernel.org>
Cc: Suraj Gupta <suraj.gupta2@amd.com>, <radhey.shyam.pandey@amd.com>,
 <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <michal.simek@amd.com>, <sean.anderson@linux.dev>,
 <linux@armlinux.org.uk>, <linux-clk@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <bmasney@redhat.com>
Subject: Re: [PATCH V3 1/2] clk: Add devm_clk_bulk_get_optional_enable()
 helper
Message-ID: <20260120184202.30ca2a5f@kernel.org>
In-Reply-To: <20260116192725.972966-2-suraj.gupta2@amd.com>
References: <20260116192725.972966-1-suraj.gupta2@amd.com>
	<20260116192725.972966-2-suraj.gupta2@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-251729-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: B137850031
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, 17 Jan 2026 00:57:23 +0530 Suraj Gupta wrote:
> Add a new managed clock framework helper function that combines getting
> optional bulk clocks and enabling them in a single operation.
> 
> The devm_clk_bulk_get_optional_enable() function simplifies the common
> pattern where drivers need to get optional bulk clocks, prepare and enable
> them, and have them automatically disabled/unprepared and freed when the
> device is unbound.
> 
> This new API follows the established pattern of
> devm_clk_bulk_get_all_enabled() and reduces boilerplate code in drivers
> that manage multiple optional clocks.

Michael, Stephen, if this is okay with you could we get an ACK?
https://lore.kernel.org/all/20260116192725.972966-2-suraj.gupta2@amd.com/
I can try to apply it on top of -rc1 in case you want to pull it 
into the clk tree as well?

