Return-Path: <netdev+bounces-284094-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIaSBmMx+WkG6gIAu9opvQ
	(envelope-from <netdev+bounces-284094-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 01:53:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C634C4F9E
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 01:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 006D9301D4E0
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 23:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079F03E717C;
	Mon,  4 May 2026 23:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u8uWwS7Q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82A72264A9;
	Mon,  4 May 2026 23:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777938781; cv=none; b=H1e6OCL7FPH68jyjpRbEDgKdcgacTs75WYbUFhL7O3XQB4DPxpP0BTlG6+Khr5NUlM1gQX35HsfHVX2ILDiqWJMT5En6jorvBeUrph1MP9yXrUisUoCLtTNw7J/2zjFSxJOL5llxyt2EVZzE0Q7fzR28JazCI+UiAcf/LzN1QW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777938781; c=relaxed/simple;
	bh=KAOd1V9M6ZWqHCSjDNjv4F8nmp8wTumJhk0Vw3mgNZc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hFk+6mTWv9GLivU29MSNSHy3YQ1r7RIMCdXgWE+U7BLDXAqeNVOEJgFZkYtwCv0kDuqo8GUYn25gO8tx8qRrgAXLTXrrGuyTRmfRgRYYINlobdTv0TRCljy0fhdr4tKtkFyEqGw60i0CXEExursSmtyO0KK2rrTAAKK89HPOx+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u8uWwS7Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6C2FC2BCB8;
	Mon,  4 May 2026 23:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777938781;
	bh=KAOd1V9M6ZWqHCSjDNjv4F8nmp8wTumJhk0Vw3mgNZc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=u8uWwS7Qzn6wA7JSIKsO0sKF2G+VlRXqBQsxSe4/fk6fahgfaVOW656JguZiNUqKS
	 5DI3BzNywNszZ40oGTo4QRBrzSBkYXrkofQAgNUt2mCNgeNas0njNZz69IMCg65Btp
	 mvTgVaMcx5+wQXbFZagAhoVv/l+WlDwpF3KelSs+X2TRsa00lydA4dz1J5jsuqSA4T
	 4vkf6nMFPbzHSA/66+CjKd0leHCoJmWc3K1cWmQ/2Skquvu0YHLt6PCdDmQF96DxlQ
	 RROPDH/Gp1CrLd8pZryGatPE9Oy76gKptmGL6wQXWBrPjdo0MaA0bLXfeptNxCvEAR
	 QcwJBcsO5earw==
Date: Mon, 4 May 2026 16:52:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Steen Hegelund <Steen.Hegelund@microchip.com>,
 <UNGLinuxDriver@microchip.com>, "Sebastian Andrzej Siewior"
 <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, Steven
 Rostedt <rostedt@goodmis.org>, Bjarni Jonasson
 <bjarni.jonasson@microchip.com>, Lars Povlsen <lars.povlsen@microchip.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, <linux-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-rt-devel@lists.linux.dev>
Subject: Re: [PATCH net 2/4] net: sparx5: fix sleep in atomic context in MAC
 table access
Message-ID: <20260504165258.30b81158@kernel.org>
In-Reply-To: <20260504-misc-fixes-sparx5-lan969x-v1-2-6604306b5743@microchip.com>
References: <20260504-misc-fixes-sparx5-lan969x-v1-0-6604306b5743@microchip.com>
	<20260504-misc-fixes-sparx5-lan969x-v1-2-6604306b5743@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 85C634C4F9E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284094-lists,netdev=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[17];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Mon, 4 May 2026 16:43:43 +0200 Daniel Machon wrote:
> sparx5_mact_learn() is called from .ndo_set_rx_mode with
> netif_addr_lock_bh held, but takes sparx5->lock which is a mutex.
> A mutex may block, which is not allowed from atomic context.

Could you try to switch to the recently added ndo_set_rx_mode_async?
We added it exactly because most drivers have to sleep / wait for FW
to do something.

