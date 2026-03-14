Return-Path: <netdev+bounces-267773-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id /R4AAmyQtWlR2AAAu9opvQ
	(envelope-from <netdev+bounces-267773-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 17:44:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 858A528DF55
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 17:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 80F3930156D2
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 16:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC7230DD3C;
	Sat, 14 Mar 2026 16:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kv0lBT0n"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C15335898
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 16:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773506665; cv=none; b=Y1BoWAiOtP95cUFip5zhfpRu23hQPxPEjcD9KeVxv/N7gmzkqWQ0jM8y11q2czXfySKa9HvaqHHbSiItICA8112R8WYORK3EFCIq/Q+vWRb9Jo6WH9V+PVfVdCLErylMGvLzFNDhyvC2sXRaGY1zupgSNktf7VNeNKqx1xJJkNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773506665; c=relaxed/simple;
	bh=1AoH8p7scZskefPdSpTpd3T6tdQlotazxTP2An3TiE8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EY/QiQdO19BNCggmiJSZVFc7VgXMqj8hdKPeDX9dW7GPxp5UTLb4zw9D5/JIXgLG5R7w4XhQEEO/d7LwlRZKAGTkhaz6DO0+0KgyAD7PzX4izwbCt7M5vEKhT2PvdKLgj1FhNYPSQxIsqwQqAdkt1G27Y3B9WwLgnUilwpuOp2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kv0lBT0n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 621D1C116C6;
	Sat, 14 Mar 2026 16:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773506664;
	bh=1AoH8p7scZskefPdSpTpd3T6tdQlotazxTP2An3TiE8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kv0lBT0nC8OWGRbH/dIwtr7ftpPdLhzdSulMbcy8vaJ9JuWNKBGhFuXwp8RSajf+/
	 v0TIz376XDEql39GPYvARZOjp6vv2RPWfy0IZ/LQ/awhKcAg/EVNfnW5ViMux/2MXh
	 meQl7oOzOZgH2Oob1yfX5qcR4QfcDHTvq7YiKLGqA1TWRuJbzcUpgKhXVmxxlEkGIo
	 5xjmCf7g7KzYm1EvR01yyTFEZKWPubEmSCODX3KS9lDAq2M5WZ+gJQvStZ8uWRF9Zn
	 E+LVaLQIpTALG6wMGQN3dJU1x5BPO7Z5ajw313TXWR09LpjJMZyxUneYkJt98fY8jV
	 GA/lxEOwk81CQ==
Date: Sat, 14 Mar 2026 09:44:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org, Paolo
 Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] net: stmmac: avoid passing pci_dev
Message-ID: <20260314094423.6a908938@kernel.org>
In-Reply-To: <E1w0evI-0000000CzY7-1fyo@rmk-PC.armlinux.org.uk>
References: <E1w0evI-0000000CzY7-1fyo@rmk-PC.armlinux.org.uk>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267773-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 858A528DF55
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 12 Mar 2026 12:13:52 +0000 Russell King (Oracle) wrote:
> To avoid unexpectedly exposing the device name through ethtool where
> it wasn't provided before, add a flag priv->plat->provide_bus_info
> to enable this, which only dwmac-intel needs to set.

Seems fine, but maybe as a separate patch we can expose it for all
devices? Is there anything special about platform devices here?

