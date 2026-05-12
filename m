Return-Path: <netdev+bounces-286875-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id i4oSF+NuAmquswEAu9opvQ
	(envelope-from <netdev+bounces-286875-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 02:05:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 156FF517B73
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 02:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 76A223015700
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 00:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A9EEED8;
	Tue, 12 May 2026 00:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E762EdsE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6ED1FC7;
	Tue, 12 May 2026 00:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778544351; cv=none; b=f/puyNWW6exXAct3fvVjErLrBh8dqknkUTkSyHPax1qldIMbk8ZOan+FJLFb4qdmOwoWkMHCc7G7IqER2lB7/Kb9d81Yvqi991KRhH/6mtFV9ZANfvVDmLwnbWNW1aTBcpAxcvZ9Sf48l50TRwhtTVpao2b4uHTieO85J9xG+So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778544351; c=relaxed/simple;
	bh=kkCpz9U5igBoWHQPg2g2DTIcrL6yoXTvmxVfC6APpmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cp0HJ22olgqo3mmyqWpuYLFzj2TM9vwOFUM2sYJx5Ty/BxLYSOOUD6xpFbKLnr49KONSUOj7ynS7yE7MQEHUfrwzQz5Lnxflnt4kCqGcyIimKfAYsrgnFtsikuCij1XMdV41cauOEjYzS1mq0LG/3v56ZLXd5qSm+BJ2A1UCeyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E762EdsE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C095CC2BCB0;
	Tue, 12 May 2026 00:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778544350;
	bh=kkCpz9U5igBoWHQPg2g2DTIcrL6yoXTvmxVfC6APpmQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=E762EdsEUP7EeUzhirRq9i5MITTEaFNtN7TQO8/AG2hzT4JhP0YlYf5zWPMRW+vm9
	 vy8RE1eimM9ovu43s4LDcEBgeIJ1H1IJNYdY0SlvPlx94hODYdpj6g3MX6TrkSJhpB
	 eW3lcIEhn5mqC330gC482o9tc6f+sd0aqYEbXCPrFoGI5JwcoIbc3L69Y3areJiZsj
	 EAct2WD0Ehrl+YRpE3S7/PAl6v2sDGike04NBj1UZILhh5ScgIGsy8FExF4dVEiHaO
	 ccgLYIZX03UXYVZv8cLZwVaU4WYoRsLBn75inbCOBkjJ+NnQhvoY7g0hk8accfA67q
	 93jAypajenh7A==
Date: Mon, 11 May 2026 17:05:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Vinod Koul
 <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, Thierry
 Reding <thierry.reding@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Chen
 <peter.chen@kernel.org>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-tegra@vger.kernel.org,
 linux-usb@vger.kernel.org
Subject: Re: [PATCH v1 0/6] Add support for Infineon/Intel XMM6260 modem
Message-ID: <20260511170548.0065fd07@kernel.org>
In-Reply-To: <20260511135703.62470-1-clamor95@gmail.com>
References: <20260511135703.62470-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 156FF517B73
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286875-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Mon, 11 May 2026 16:56:55 +0300 Svyatoslav Ryhel wrote:
>   dt-bindings: usb: ci-hdrc-usb2: Document nvidia,external-control
>     property
>   usb: chipidea: tegra: Avoid controller/PHY init if bus is externally
>     controlled
>   dt-bindings: net: Document Infineon/Intel XMM6260 modem
>   net: usb: Add Infineon XMM6260 Baseband modem support
>   dt-bindings: phy: tegra: Document Nvidia Tegra XMM6260 PHY
>   phy: tegra: Add support for Nvidia Tegra XMM6260 PHY

You need to split this more on subsystem boundaries.

