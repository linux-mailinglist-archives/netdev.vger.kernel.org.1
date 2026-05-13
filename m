Return-Path: <netdev+bounces-287744-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGcYA2IFBWpRRgIAu9opvQ
	(envelope-from <netdev+bounces-287744-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 01:12:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E3F153BD1B
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 01:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 906953091466
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 23:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C9E3CAA52;
	Wed, 13 May 2026 23:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h+u9yfW3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF71392C3D;
	Wed, 13 May 2026 23:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778713737; cv=none; b=oYraIIp7cBqDEPm8WZ1ofAxsZ+uI80zD6tTeICgkwT1JZlewPVrJraUYecryvnApZczI02IyX07ydsG4nIfyZRKGK/abHPJAmvzbc818ZD69aVGYeojD7535ascRJRm4CeRbsfjw8SzHl9D39p4hvwYM/N+zF2wtoDhGK3D97uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778713737; c=relaxed/simple;
	bh=D6bD9ihndQ7HnnIizWApF3388IXWv0B10nh9ibhu9wc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=neiMnwIUmHHexXY28DaZA3wcFe/bd57daHVae0qbX9vudFE4Wl2c5Oa66u/eWzzFmHsj3ozcaBPKM5id3yqYa608ibGjSwCnNMln5omiaZYTVLi8k9YAeqeHmywqSziGVQhcBWPKP+QNyjw4V19Azg9pry7nRVIeN9jyC8FUa+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h+u9yfW3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43648C19425;
	Wed, 13 May 2026 23:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778713737;
	bh=D6bD9ihndQ7HnnIizWApF3388IXWv0B10nh9ibhu9wc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h+u9yfW37hi1uHOXGYL36u4RWpfBvTDv/FOr7LqL5sg9XQ5+jb3eMMdtSLWATmAV6
	 GwZl/LO0jrxnI1OxgntQbXqh3OctiwORu+v47Ri5aq3IYs0LpJ6c498gn+7zMqzDiJ
	 NuWUlNCP13Z8olSU7fEVJ6lfz0Tbc7eytMK2YvgnU783Q4hvxHLfK8higCkHvikh0r
	 TeOLooV0sHJgqAtMqcRLKBw4+ZfWYtDTVRqGGXWRPqzeH5V1eMGR/ZEMxw0Mscit7t
	 gxUMVygeTm/Ok0tEqwyyT5yoX3Ajd1/Y+Cs28SDQUMuV4QP19kagMYcWbHBvU2xQCB
	 3dQ0VwLSibo+A==
Date: Wed, 13 May 2026 18:08:53 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Changhuang Liang <changhuang.liang@starfivetech.com>
Cc: Sia Jee Heng <jeeheng.sia@starfivetech.com>,
	linux-hardening@vger.kernel.org,
	Hal Feng <hal.feng@starfivetech.com>, linux-clk@vger.kernel.org,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Michael Turquette <mturquette@baylibre.com>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Ley Foon Tan <leyfoon.tan@starfivetech.com>,
	Richard Cochran <richardcochran@gmail.com>,
	linux-riscv@lists.infradead.org, Conor Dooley <conor+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <pjw@kernel.org>, netdev@vger.kernel.org,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Alexandre Ghiti <alex@ghiti.fr>, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v2 19/22] dt-bindings: clock: Add StarFive JHB100
 Peripheral-3 clock and reset generator
Message-ID: <177871373279.2278435.14464810348159113928.robh@kernel.org>
References: <20260508053632.818548-1-changhuang.liang@starfivetech.com>
 <20260508053632.818548-20-changhuang.liang@starfivetech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508053632.818548-20-changhuang.liang@starfivetech.com>
X-Rspamd-Queue-Id: 4E3F153BD1B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[starfivetech.com,vger.kernel.org,dabbelt.com,eecs.berkeley.edu,baylibre.com,esmil.dk,gmail.com,lists.infradead.org,kernel.org,pengutronix.de,ghiti.fr];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287744-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action


On Thu, 07 May 2026 22:36:29 -0700, Changhuang Liang wrote:
> Add bindings for the Peripheral-3 clock and reset generator (PER3CRG)
> on the JHB100 RISC-V SoC by StarFive Ltd.
> 
> Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
> ---
>  .../clock/starfive,jhb100-per3crg.yaml        | 76 +++++++++++++++++++
>  .../dt-bindings/clock/starfive,jhb100-crg.h   | 35 +++++++++
>  .../dt-bindings/reset/starfive,jhb100-crg.h   |  9 +++
>  3 files changed, 120 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/starfive,jhb100-per3crg.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


