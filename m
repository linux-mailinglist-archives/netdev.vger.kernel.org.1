Return-Path: <netdev+bounces-260635-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLlcCtj3nWlzSwQAu9opvQ
	(envelope-from <netdev+bounces-260635-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 20:11:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C6FDD18BB64
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 20:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A4643053B35
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 19:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AFE82EDD62;
	Tue, 24 Feb 2026 19:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="4g3xkOm7"
X-Original-To: netdev@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5DA2DB791;
	Tue, 24 Feb 2026 19:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771960091; cv=none; b=o8ZsYD7UdytLqxcSKOE8Co9c+EEH62iUdaDoB/pJFFGOw+lhgvDhAs+F/4URG5besSyWQmkQGj2hS/NbW8tLQ/ejKbDHbhuwcmPdsgLYJPoXEzEHm1/NrdIo1kL/GBqAmDquC8FYZOblse20cQWbQ6yChKlU4sZioy1IrjFv6Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771960091; c=relaxed/simple;
	bh=Ytxbffr51F0re4bW6nSVt2djpBTroGj9/O4LbmP+m8s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nHZVpfryiEiDBCgtJCdBxpA/U5tc9WdxMGHpLGXa1MoytvF3mB4VYEBPpQfJXJY2vmTBk2p7IcKkwAS6hFFfyTQyZLeWzpjtctGNhMqoj1HJT+am4F2EA1K5UlKQVYxjFYKmnPv9aRBkB4KKLzkvgg98KppIdiKAr2URbm/0Onc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=4g3xkOm7; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=r7Nl4vRIA8zq2/ErXR7S1Ueuua1WfoxbT3suotlryZc=; b=4g3xkOm75N/NMIdeMIw6vzO5oE
	Xfjs+FulGd3shI5guD2gYXgE8zpO1R7XnS+pwzSGnYyDnVDJOOWkqxEuZG1XCV/4PS/zr7VPOsH6j
	wAP9OV4A+K+N5y5Q862oMj2z+G02AKXBBC+4bnG8ra5CEMC/YbFnRKg4GW6wa6Gplpn3Xr/0armxL
	mAw2OX3wIH1/3EvdsobqnZCEpdGPRO4uJ8bVzTUcpc0wFjXwObleKRXCAcPHTetqf5lRCXpKm3ip0
	bdHMCqBwNOJUYqcEJEouiJUA07gui4fUkZZXfulN0oUV+94ikSJUEn9RfnjWNnDglmGB7siCS1NGc
	w7JU9ELg==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuxlQ-00000002fd2-2XBJ;
	Tue, 24 Feb 2026 19:08:08 +0000
Message-ID: <2b9b5702-1b30-415f-b734-8af9d1aef27c@infradead.org>
Date: Tue, 24 Feb 2026 11:08:07 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] clk: baikal-t1: Remove not-going-to-be-supported
 code for Baikal SoC
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Richard Cochran <richardcochran@gmail.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Brian Masney <bmasney@redhat.com>
References: <20260224111821.3491352-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260224111821.3491352-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260635-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[baylibre.com,kernel.org,gmail.com,pengutronix.de,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.983];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rdunlap@infradead.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[infradead.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:mid,infradead.org:dkim,infradead.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C6FDD18BB64
X-Rspamd-Action: no action



On 2/24/26 3:17 AM, Andy Shevchenko wrote:
> As noticed in the discussion [1] the Baikal SoC and platforms
> are not going to be finalized, hence remove stale code.
> 
> Reviewed-by: Brian Masney <bmasney@redhat.com>
> Link: https://lore.kernel.org/lkml/22b92ddf-6321-41b5-8073-f9c7064d3432@infradead.org/ [1]
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> ---
> 
> v4: added tag (Rob), rebased on top of last changes
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

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

thanks.
-- 
~Randy

