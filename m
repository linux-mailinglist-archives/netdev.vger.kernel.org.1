Return-Path: <netdev+bounces-287742-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDoXLVsEBWpnRgIAu9opvQ
	(envelope-from <netdev+bounces-287742-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 01:08:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 788D353BC69
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 01:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B311D3038974
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 23:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB9A3CAA3B;
	Wed, 13 May 2026 23:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BTkbeQaN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C3E37D11D;
	Wed, 13 May 2026 23:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778713602; cv=none; b=jCOjIvcVVB01ncTf5dKcnZkHtX7g6mnPfcxPMmafXT51vRsfGA3ZygeQQBRN/YOVUKBh1Y4q3zFWsoynW4glurX7Ad3hlCvwbON9+oD8Of53q3j/jTQyf69W7Sf44yJVxSSUFh7YNMK4uE6MY0U4KVwaQYIhvisxEa/5Ckp6Lwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778713602; c=relaxed/simple;
	bh=DlAbAtOk3x6I8PGdX/PgiHRv4Qup6WPVLeUY8Disf1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PkJpea4T7YqGwM8F1/YX1c867wU3+csv3a2APCSB9tzwgHZpLmywq4gjXzIrFwZr31EpP8NbTq57yLvNM9BFbNvTw54PohvUUFSfSWZ5qXQNElwvQconTD5BhD7ITWzViSOWdtMpfD29eH7o4gcZhSvwEtxh7XvhPGv9kImWxgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BTkbeQaN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0992C19425;
	Wed, 13 May 2026 23:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778713602;
	bh=DlAbAtOk3x6I8PGdX/PgiHRv4Qup6WPVLeUY8Disf1Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BTkbeQaNHGC1BPlEuISVj2AdP8A07sxaIuOHKiy8+87z1XAT2ZbbLEhclWFKSeG8P
	 /Hd/O5EcpHx2Rc5S3WxjRhg7fm7mIne9ylGYKejlFAb6H9R5oiUz1lMiU6l5NkToHn
	 wIf+z6lkmRWrxRozLu9/DR4JaMvQspjvfuU/WShks54qYOq+etKrPCTLXAE8eWbVOe
	 L3Fmh/tS4OIBQ+WgfRIZG26asLwEJDEquPjaU2snHLKMuJC7iYFsPcSawowTjspCQc
	 1a8gW++rd682Fj0LZ1bG2UCOfbkkjH6E6zeSIJA8pgBRdW4PPKoggCyz9gzVFMHn9x
	 qa5d5OaFNwfUA==
Date: Wed, 13 May 2026 18:06:39 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Changhuang Liang <changhuang.liang@starfivetech.com>
Cc: linux-hardening@vger.kernel.org, Hal Feng <hal.feng@starfivetech.com>,
	netdev@vger.kernel.org, Richard Cochran <richardcochran@gmail.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Ley Foon Tan <leyfoon.tan@starfivetech.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Sia Jee Heng <jeeheng.sia@starfivetech.com>,
	linux-clk@vger.kernel.org,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Alexandre Ghiti <alex@ghiti.fr>, Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <pjw@kernel.org>, linux-riscv@lists.infradead.org,
	Albert Ou <aou@eecs.berkeley.edu>, devicetree@vger.kernel.org,
	Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v2 07/22] dt-bindings: clock: Add StarFive JHB100
 System-1 clock and reset generator
Message-ID: <177871356173.2271810.4990360775235090390.robh@kernel.org>
References: <20260508053632.818548-1-changhuang.liang@starfivetech.com>
 <20260508053632.818548-8-changhuang.liang@starfivetech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508053632.818548-8-changhuang.liang@starfivetech.com>
X-Rspamd-Queue-Id: 788D353BC69
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,starfivetech.com,gmail.com,dabbelt.com,pengutronix.de,kernel.org,baylibre.com,esmil.dk,ghiti.fr,lists.infradead.org,eecs.berkeley.edu];
	TAGGED_FROM(0.00)[bounces-287742-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[starfivetech.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action


On Thu, 07 May 2026 22:36:17 -0700, Changhuang Liang wrote:
> Add bindings for the System-1 clocks and reset generator (SYS1CRG) on
> JHB100 SoC.
> 
> Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
> ---
>  .../clock/starfive,jhb100-sys1crg.yaml        | 71 +++++++++++++++++++
>  .../dt-bindings/clock/starfive,jhb100-crg.h   | 20 ++++++
>  .../dt-bindings/reset/starfive,jhb100-crg.h   | 11 +++
>  3 files changed, 102 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/starfive,jhb100-sys1crg.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


