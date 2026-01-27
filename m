Return-Path: <netdev+bounces-253638-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJEIEK4JeGk2ngEAu9opvQ
	(envelope-from <netdev+bounces-253638-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 01:41:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1FF48E85B
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 01:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ADECB300D378
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 00:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15EC51DF963;
	Tue, 27 Jan 2026 00:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nCLiRYhX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E830C1DF72C
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 00:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769474465; cv=none; b=tsdEI+D5tUlEbRiYziKbrMuQuKuXslqnKj7rVbda9NCYQGIH7cDeVLaWG92iWW7lCgspiQk9ue54hKXsAJk6gdKttuvMNxHnjQjkELrlEHIOuV2sndO+HoaP/cfromjFc8/l8fFEwD9rFpq1dNKJF6dVzAOmQoxotxYjrWglr6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769474465; c=relaxed/simple;
	bh=nB6yjbNXx42GKTBaXT02ZrBwPDOQ+Wsz8KL8vGzVQaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zz8InAcrDvcqNhg+6m9H2gfAVI4env3i/zGLdFSQIFELpPJK8lVYdaaHRDNWOLVA+2AVVnaYarbG8FBQF17GYgUVFNcvllAmtwRZzeGwuYPJ10VQNFnbw1KQvYlPweoXuI8dmKr1cWeW7c6h3UYgdKRgN02mBb03tVYiRk8kBDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nCLiRYhX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AEAAC116C6;
	Tue, 27 Jan 2026 00:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769474464;
	bh=nB6yjbNXx42GKTBaXT02ZrBwPDOQ+Wsz8KL8vGzVQaU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nCLiRYhXSjC0cyWgFzfpBfJz3GNGLNuwr8vZmbLNiPP0025V4EsEpQZ2mNpPf5yLV
	 S+N/f4ZgDlNfz6MiEJahyApVGOTfnTp3e/Dhyj39TDiQfKpKYyw6UsxbPCG4wiwQog
	 PDXoIrevY3UX/IqyOqJQpVLeSRwWcON7gX1EthcZZV9NqkeUMMpfICM7AnomZSpJKA
	 IS8yLo13jC5CYTQk39EdkZpsbmvdOyUgwkppwIHx3E/0anYLWw2rOIXPsJIobLh213
	 5CqFqOGb5/euCk663qw+qv+iYaPHWqs+DIEFRzsbCVhxJFHwSFBJnzsU8q+5kvtUxF
	 ArgQDm22sXoKQ==
From: Jakub Kicinski <kuba@kernel.org>
To: rmk+kernel@armlinux.org.uk
Cc: Jakub Kicinski <kuba@kernel.org>,
	linux-stm32@st-md-mailman.stormreply.com,
	andrew+netdev@lunn.ch,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	linux-rockchip@lists.infradead.org,
	heiko@sntech.de,
	alexandre.torgue@foss.st.com,
	andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com
Subject: Re: [net-next,v2,22/22] net: stmmac: rk: rk3506, rk3528 and kk3588 have rmii_mode in clock register
Date: Mon, 26 Jan 2026 16:41:03 -0800
Message-ID: <20260127004103.3785897-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <E1vkL3S-00000005uuG-2qFN@rmk-PC.armlinux.org.uk>
References: <E1vkL3S-00000005uuG-2qFN@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-253638-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D1FF48E85B
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: stmmac: rk: rk3506, rk3528 and kk3588 have rmii_mode in clock register

This patch moves the rmii_mode bit configuration for rk3506, rk3528 and
rk3588 from the SoC-specific set_to_rmii() functions to the common
rk_gmac_powerup() path, using the new rmii_mode_mask field in the clock
register configuration.

>     net: stmmac: rk: rk3506, rk3528 and kk3588 have rmii_mode in clock register
                                          ^^^^^^

This isn't a bug, but the subject line has a typo: "kk3588" should be
"rk3588". The commit body correctly refers to "rk3588" and the code
changes reference rk3588_ops, rk3588_init, and RK3588_* macros.

