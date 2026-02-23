Return-Path: <netdev+bounces-260164-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEorKYKjnGnqJgQAu9opvQ
	(envelope-from <netdev+bounces-260164-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 19:59:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CB1EF17BEFB
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 19:59:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0ED543010216
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 18:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91E4369996;
	Mon, 23 Feb 2026 18:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IbMx2kpk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FD432FA2F;
	Mon, 23 Feb 2026 18:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771873145; cv=none; b=lieAgRpb/QNuQLtDzYs+z1IYsLgH4UTaRD2g2mE0ytVjqeomz398+hwXbOGm1jupqNr9bRlFAqVrprJUL8AOy/ArAczDmhSVG1XGuVKZw2/vIxBHqL2VFjrdDlDcrIupKCF80VYqrZBp02XCWCEBorWAn4H3+olmBLDax030XgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771873145; c=relaxed/simple;
	bh=pY0KVq2Wj3LDawJFlUFrQM3TUMEMLLex2D9LE717kVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ucvl1wBAxCBXb6qwhwJQcPH646itpWYyBpdM5hVx7T0KFfJultpBxLJwrw5hH5dGef2+TYyV2baUazKrxQgdO8N/2H1gpqZRKv5wdUOkOmyKjb9gYb59TUVJbX0vP1LDaRRKV37mgb5721iJghiw9YlpAKXFkRjkB464eFzff1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IbMx2kpk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 088BEC116C6;
	Mon, 23 Feb 2026 18:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771873145;
	bh=pY0KVq2Wj3LDawJFlUFrQM3TUMEMLLex2D9LE717kVI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IbMx2kpkSboeXVKG2Z4s1Fj7U0IGlfdtbaWuKaUccAEYJ/wkVpqtGrq3MQYyg7pzu
	 sVAM7D5rIJj+7NybIUPHcTW/bfWWR5mWjJNsc/ZRVCClMi+Zuq3Re7KWTiUL31iU+M
	 52ilohUNPL01hldU+6kKpS26YxAC8a7pXVIiy7l/pu0gzryrD22677ZdgJegedsW7Q
	 wC0TnbkNsYXm8jrnHRfedAhKj3mLwjlveFqN9om8q0v+WvKE3WyJr9ihynYSxhseGN
	 00wKlUUxB2g2CwSlforMTzz1/p6EEiJa9nKdtkIV6qKlvi+8P3R8CSz4Goy32JLC8f
	 F83ClP2ipDsSQ==
Date: Mon, 23 Feb 2026 12:59:04 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Stephen Boyd <sboyd@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
	netdev@vger.kernel.org, Brian Masney <bmasney@redhat.com>,
	linux-clk@vger.kernel.org,
	Richard Cochran <richardcochran@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] clk: baikal-t1: Remove not-going-to-be-supported
 code for Baikal SoC
Message-ID: <177187314339.164221.11792743317136132026.robh@kernel.org>
References: <20260220143436.2400888-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260220143436.2400888-1-andriy.shevchenko@linux.intel.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,pengutronix.de,vger.kernel.org,redhat.com,gmail.com,baylibre.com];
	TAGGED_FROM(0.00)[bounces-260164-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CB1EF17BEFB
X-Rspamd-Action: no action


On Fri, 20 Feb 2026 15:33:55 +0100, Andy Shevchenko wrote:
> As noticed in the discussion [1] the Baikal SoC and platforms
> are not going to be finalized, hence remove stale code.
> 
> Reviewed-by: Brian Masney <bmasney@redhat.com>
> Link: https://lore.kernel.org/lkml/22b92ddf-6321-41b5-8073-f9c7064d3432@infradead.org/ [1]
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v3: removed bindings header as well (now should all be gone)
> v2: added tag (Brian), removed YAML files
> 
>  .../bindings/clock/baikal,bt1-ccu-div.yaml    | 196 ------
>  .../bindings/clock/baikal,bt1-ccu-pll.yaml    | 131 ----
>  drivers/clk/Kconfig                           |   1 -
>  drivers/clk/Makefile                          |   1 -
>  drivers/clk/baikal-t1/Kconfig                 |  52 --
>  drivers/clk/baikal-t1/Makefile                |   4 -
>  drivers/clk/baikal-t1/ccu-div.c               | 653 ------------------
>  drivers/clk/baikal-t1/ccu-div.h               | 121 ----
>  drivers/clk/baikal-t1/ccu-pll.c               | 560 ---------------
>  drivers/clk/baikal-t1/ccu-pll.h               |  72 --
>  drivers/clk/baikal-t1/ccu-rst.c               | 217 ------
>  drivers/clk/baikal-t1/ccu-rst.h               |  67 --
>  drivers/clk/baikal-t1/clk-ccu-div.c           | 520 --------------
>  drivers/clk/baikal-t1/clk-ccu-pll.c           | 277 --------
>  include/dt-bindings/clock/bt1-ccu.h           |  48 --
>  15 files changed, 2920 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/clock/baikal,bt1-ccu-div.yaml
>  delete mode 100644 Documentation/devicetree/bindings/clock/baikal,bt1-ccu-pll.yaml
>  delete mode 100644 drivers/clk/baikal-t1/Kconfig
>  delete mode 100644 drivers/clk/baikal-t1/Makefile
>  delete mode 100644 drivers/clk/baikal-t1/ccu-div.c
>  delete mode 100644 drivers/clk/baikal-t1/ccu-div.h
>  delete mode 100644 drivers/clk/baikal-t1/ccu-pll.c
>  delete mode 100644 drivers/clk/baikal-t1/ccu-pll.h
>  delete mode 100644 drivers/clk/baikal-t1/ccu-rst.c
>  delete mode 100644 drivers/clk/baikal-t1/ccu-rst.h
>  delete mode 100644 drivers/clk/baikal-t1/clk-ccu-div.c
>  delete mode 100644 drivers/clk/baikal-t1/clk-ccu-pll.c
>  delete mode 100644 include/dt-bindings/clock/bt1-ccu.h
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


