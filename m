Return-Path: <netdev+bounces-287745-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SO2tOr8EBWpRRgIAu9opvQ
	(envelope-from <netdev+bounces-287745-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 01:09:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 92ED853BCC6
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 01:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AB719300C033
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 23:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8BD3CAA5F;
	Wed, 13 May 2026 23:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c6TPnAKz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1912A38F633;
	Wed, 13 May 2026 23:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778713788; cv=none; b=hJ7ii5iu9CE7Wa8A19yAU8GugCQmaCPHSc7seMQviQj5HI8ZtWA76KwysMDTRZkV4FqC10rak8nNAokkkfuLh1javk4ld8g0FpbNe7rY4bY+3SUsBbk0IxEQ0DWpcw9X8LKs3N6b5D8UmC6W6BciWoSyyHbHpsNQ3kXlzRK/HgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778713788; c=relaxed/simple;
	bh=kjUAo1uOW2Oo49mudYiNDfnQY4SZr8+1RxA78MbMIyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pKP/QEhit+hUpuNWFcQsAjnSXkRCavH4vecm00BiTmYhTQmO8xm+dYQ4t2kftB23PaYHq7FvCmf9k/reqEM8Lmx3Yp1PNLAr6KND+Kkx1Haafqxlq0MsJdFtXQ9qi0xCpWTZaPcEtA/J4MeSu7cV5bwejaCUmGLY1Bc+YFb8yhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c6TPnAKz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BE03C19425;
	Wed, 13 May 2026 23:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778713787;
	bh=kjUAo1uOW2Oo49mudYiNDfnQY4SZr8+1RxA78MbMIyc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c6TPnAKzFqcyGd7Z0pRJZ77LleZGuZ0fwo6JJqE0tYkIUyk5pwr+PIf8W2mGNjiH7
	 3GHXZj7XJuvTPT+pxtAy6+aLj7wKS0iStVX2HerLhyPbEOH3ib34zX/SkCI/wocCJk
	 sfOPZJCI/9YdwlmbeHyvQEVUPwe4xxi8tsO502rYQX6FmlU/k/1pW6TsB+/rv1thxZ
	 rVjFob4zEBSPQcIAeCUs5XniAU+185asL8Ev0hpvdkrl3knht6Q9bQvLhNKAIBdJfm
	 Ei7WT9k3uYGG3aNOBBgrLcNceRaqOm43oF9YjSP4pTO9eZrcHqSQhQMcxwI5XSPyv6
	 TxLhLJxInm1pQ==
Date: Wed, 13 May 2026 18:09:44 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Changhuang Liang <changhuang.liang@starfivetech.com>
Cc: Kees Cook <kees@kernel.org>, Emil Renner Berthing <kernel@esmil.dk>,
	linux-clk@vger.kernel.org, Hal Feng <hal.feng@starfivetech.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	netdev@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	Alexandre Ghiti <alex@ghiti.fr>,
	Richard Cochran <richardcochran@gmail.com>,
	Ley Foon Tan <leyfoon.tan@starfivetech.com>,
	Sia Jee Heng <jeeheng.sia@starfivetech.com>
Subject: Re: [PATCH v2 15/22] dt-bindings: clock: Add StarFive JHB100
 Peripheral-1 clock and reset generator
Message-ID: <177871378355.2279463.2890936397180596400.robh@kernel.org>
References: <20260508053632.818548-1-changhuang.liang@starfivetech.com>
 <20260508053632.818548-16-changhuang.liang@starfivetech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508053632.818548-16-changhuang.liang@starfivetech.com>
X-Rspamd-Queue-Id: 92ED853BCC6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,esmil.dk,vger.kernel.org,starfivetech.com,eecs.berkeley.edu,pengutronix.de,baylibre.com,dabbelt.com,lists.infradead.org,ghiti.fr,gmail.com];
	TAGGED_FROM(0.00)[bounces-287745-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[starfivetech.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action


On Thu, 07 May 2026 22:36:25 -0700, Changhuang Liang wrote:
> Add bindings for the Peripheral-1 clock and reset generator (PER1CRG)
> on the JHB100 RISC-V SoC by StarFive Ltd.
> 
> Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
> ---
>  .../clock/starfive,jhb100-per1crg.yaml        | 70 +++++++++++++++++++
>  .../dt-bindings/clock/starfive,jhb100-crg.h   | 60 ++++++++++++++++
>  .../dt-bindings/reset/starfive,jhb100-crg.h   | 19 +++++
>  3 files changed, 149 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/starfive,jhb100-per1crg.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


