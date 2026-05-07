Return-Path: <netdev+bounces-285422-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yGyWFmK5/Gl2TAAAu9opvQ
	(envelope-from <netdev+bounces-285422-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 18:10:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E634EBDE2
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 18:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1D0A930691AE
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 16:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B9F3FF88F;
	Thu,  7 May 2026 16:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m/Qb/ZrF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CEAE3EF64A;
	Thu,  7 May 2026 16:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778169920; cv=none; b=Ctg1Hijd5UbYl3WGxZEvL2rnZCfuosnWHRJ9E3S5OPYUJ5yqziGlj86qmuqfH5/O8zJeU9SzaPNrH1W9mzMv/YgYiqOhNTvtANxSiXlHdGtoQVAxT5a+/IHi2RguzJJ3DWl9YMSfyHF/DN0GdrW8NLgtZg7nzAvDc0cC/FQlgho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778169920; c=relaxed/simple;
	bh=PjiuOCfQhhHUvzf8Uf9+2t04GxEw19A/aaBiN0wxIgU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tlbP5cWa/Vy8xpt/8Jtb7eeLN/V/4lcaEXSK5OAZT7SgVB1YPgNgdEwNlu0zEt5OMigCGVswGvfvV2iVnui5ol0p2Rty2n9gSs460zbFWQAXjHkzION5cLqw57n8xfpFUsqGdMTzClZArRFQKD4pt9QwuJkIigqJkDRz4rYzpYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m/Qb/ZrF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66663C2BCC4;
	Thu,  7 May 2026 16:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778169920;
	bh=PjiuOCfQhhHUvzf8Uf9+2t04GxEw19A/aaBiN0wxIgU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=m/Qb/ZrFZeOIrKmB5azSqQPPJ0IYaVU1yfajUHAsL7P9NvA52ohkKg6aXahZh3lwv
	 TbYqYMTX4hlG+1YpqQPH8JdhJj7sClc010xKHdBSHGBiVA5l93lQlDF9xCaa5Lh2x8
	 TaGe/rmDkhCG9ojuhbNGG1XwAYi0QGQiBM88s8eDMcGwwpyVOeFZD0QkVRkl6h5jP1
	 Qo0wpAuMjriqA3HqC3mbjl0NrmuSL+rSjuNSwFWdHKmfEHy1DWmQtcv+b2gs6jEdRT
	 /JePvg2TnCiR/zU9hdftYvCiswy/e3z78w7YxYWDYCL7nyp86HlBG12qf1If6910Y+
	 tYAYnJzJU64ow==
Date: Thu, 7 May 2026 09:05:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Steen Hegelund <Steen.Hegelund@microchip.com>,
 <UNGLinuxDriver@microchip.com>, "Sebastian Andrzej Siewior"
 <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, Steven
 Rostedt <rostedt@goodmis.org>, Bjarni Jonasson
 <bjarni.jonasson@microchip.com>, Lars Povlsen <lars.povlsen@microchip.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, <kees@kernel.org>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-rt-devel@lists.linux.dev>
Subject: Re: [PATCH net v2 2/4] net: sparx5: fix sleep in atomic context in
 MAC table access
Message-ID: <20260507090518.47b64fef@kernel.org>
In-Reply-To: <20260506-misc-fixes-sparx5-lan969x-v2-2-fb236aa96908@microchip.com>
References: <20260506-misc-fixes-sparx5-lan969x-v2-0-fb236aa96908@microchip.com>
	<20260506-misc-fixes-sparx5-lan969x-v2-2-fb236aa96908@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: C8E634EBDE2
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
	TAGGED_FROM(0.00)[bounces-285422-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[18];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Wed, 6 May 2026 09:25:37 +0200 Daniel Machon wrote:
> sparx5_set_rx_mode() runs with netif_addr_lock_bh held and iterates
> dev->mc via __dev_mc_sync(), which per address calls sparx5_mc_sync() /
> sparx5_mc_unsync() -> sparx5_mact_learn() / sparx5_mact_forget().  These
> take sparx5->lock, a mutex, and then poll the MAC access command
> register with readx_poll_timeout(). A mutex may block, which is not
> allowed from atomic context.
> 
> Convert the driver to the new .ndo_set_rx_mode_async callback introduced
> in commit 3554b4345d85 ("net: introduce ndo_set_rx_mode_async and
> netdev_rx_mode_work"). The async callback is invoked from process
> context, so the mutex and sleeping completion poll can remain.

Sashiko points out that the switchdev handlers are currently racy,
but I think that's orthogonal.

