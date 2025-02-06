Return-Path: <netdev+bounces-163612-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B73A2AF28
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 18:41:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42091163AD6
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 17:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E358C18787A;
	Thu,  6 Feb 2025 17:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ShheOfjS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9732239568;
	Thu,  6 Feb 2025 17:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738863575; cv=none; b=pCcFTZmwtLLGRBVKLA2z5kbgN2rr/1ynAyNEv3tMJqXyx8AY/xODXAAK09zn33lMxcP3xVNXlyAGRr9I/RZs2aTk9EXCbFQd1mDpdaY7Q1MWl9Nk3662SB/DaB0MIEsshtMbVRQDtotjXCUPYMDzrOBqR6QIsT/MqUcdARf5HdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738863575; c=relaxed/simple;
	bh=uKCgky6o7JLliLo5xg6T+BXoL+X3Gth14F53Io1F03E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CBW8/jZ3DmoRvLQu8GdMZcMW2rdhM+43vvMpkPhOcWFeAKnq+FYZSIUqevTYtbB+WK1BKBMeILP2v6tR6Xwu5GT32dreEY0HjG2YWwdnn6OvhY9YurL0KlAMxO7RC+StEKKgoI/7hcXDArZBBGKtqNNHMJYC/PhTFS0gFyBV51k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ShheOfjS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41768C4CEDD;
	Thu,  6 Feb 2025 17:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738863575;
	bh=uKCgky6o7JLliLo5xg6T+BXoL+X3Gth14F53Io1F03E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ShheOfjSzb9SrFQ9INefnYFUy8Fqync/Dbw/f6n+47EYE3UtIfr1OPNYpI8uF0uxp
	 0Zq/o9NsCg4aSg6e1iIajEq5xTly4ZBw7Mg/uFOGQDzkqeJM2HUiYeDn21MRJgea1g
	 BBvm+k4F4Q+RAmU11N0niEk3pdL8y91oS8soXuCbFOigcO6YAwcwag27SM4S2Mb0qo
	 Rw9ia9uohcGjF7rkGKGWobcYDypKhyGpHjr2bkk7hlmxmQO5E5TAjMcvl0yE/HZGJL
	 /2dg6yFcCAU4XQLHg18IEM+mS0t4PqR22njVLQnr7DNX6xtrFIi9jqItyjolTneaLU
	 qr2/zPLWRJTpQ==
Date: Thu, 6 Feb 2025 17:39:30 +0000
From: Simon Horman <horms@kernel.org>
To: Chintan Vankar <c-vankar@ti.com>
Cc: Jason Reeder <jreeder@ti.com>, vigneshr@ti.com, nm@ti.com,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Thomas Gleixner <tglx@linutronix.de>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, srk@ti.com, s-vadapalli@ti.com,
	danishanwar@ti.com, m-malladi@ti.com
Subject: Re: [RFC PATCH 1/2] irqchip: ti-tsir: Add support for Timesync
 Interrupt Router
Message-ID: <20250206173930.GZ554665@kernel.org>
References: <20250205160119.136639-1-c-vankar@ti.com>
 <20250205160119.136639-2-c-vankar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250205160119.136639-2-c-vankar@ti.com>

On Wed, Feb 05, 2025 at 09:31:18PM +0530, Chintan Vankar wrote:
> Timesync Interrupt Router is an instantiation of generic interrupt router
> module. It provides a mechanism to mux M interrupt inputs to N interrupt
> outputs, where all M inputs are selectable to be driven as per N output.
> Timesync Interrupt Router's inputs are either from peripherals or from
> Device sync Events.
> 
> Add support for Timesync Interrupt Router driver to map input received
> from peripherals with the corresponding output.
> 
> Signed-off-by: Chintan Vankar <c-vankar@ti.com>

...

> diff --git a/drivers/irqchip/ti-timesync-intr.c b/drivers/irqchip/ti-timesync-intr.c
> new file mode 100644
> index 000000000000..11f26ca649d2
> --- /dev/null
> +++ b/drivers/irqchip/ti-timesync-intr.c
> @@ -0,0 +1,109 @@
> +// SPDX-License-Identifier: GPL

Hi Chintan,

I think you need to be mores specific here wrt the version of the GPL.

Link: https://www.kernel.org/doc/html/v6.13-rc6/process/license-rules.html

Flagged by ./scripts/spdxcheck.py

Also, compiling this file with GCC 14.2.0 for allmodconfig with W=1
generates a significant number of warnings. You may wish to look into that.

drivers/irqchip/ti-timesync-intr.c: In function ‘ts_intr_irq_domain_alloc’:
drivers/irqchip/ti-timesync-intr.c:38:13: error: unused variable ‘ret’ [-Werror=unused-variable]
   38 |         int ret;
      |             ^~~
drivers/irqchip/ti-timesync-intr.c: In function ‘ts_intr_irq_domain_free’:
drivers/irqchip/ti-timesync-intr.c:82:32: error: conversion from ‘long unsigned int’ to ‘unsigned int’ changes value from ‘18446744073709486079’ to ‘4294901759’ [-Werror=overflow]
   82 |                         writel(~TIMESYNC_INTRTR_INT_ENABLE, tsr_data.tsr_base + output_line_offset);
drivers/irqchip/ti-timesync-intr.c:74:44: error: unused variable ‘n’ [-Werror=unused-variable]
   74 |         struct output_line_to_virq *node, *n;
      |                                            ^
drivers/irqchip/ti-timesync-intr.c:74:37: error: unused variable ‘node’ [-Werror=unused-variable]
   74 |         struct output_line_to_virq *node, *n;
      |                                     ^~~~
In file included from ./include/linux/irqchip.h:16,
                 from drivers/irqchip/ti-timesync-intr.c:9:
drivers/irqchip/ti-timesync-intr.c: At top level:
./include/linux/minmax.h:24:35: error: comparison of distinct pointer types lacks a cast [-Werror=compare-distinct-pointer-types]
   24 |         (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
      |                                   ^~
./include/linux/of.h:1525:31: note: in definition of macro ‘_OF_DECLARE’
 1525 |                      .data = (fn == (fn_type)NULL) ? fn : fn  }
      |                               ^~
./include/linux/irqchip.h:37:9: note: in expansion of macro ‘OF_DECLARE_2’
   37 |         OF_DECLARE_2(irqchip, name, compat, typecheck_irq_init_cb(fn))
      |         ^~~~~~~~~~~~
./include/linux/irqchip.h:24:10: note: in expansion of macro ‘__typecheck’
   24 |         (__typecheck(typecheck_irq_init_cb, &fn) ? fn : fn)
      |          ^~~~~~~~~~~
./include/linux/irqchip.h:37:45: note: in expansion of macro ‘typecheck_irq_init_cb’
   37 |         OF_DECLARE_2(irqchip, name, compat, typecheck_irq_init_cb(fn))
      |                                             ^~~~~~~~~~~~~~~~~~~~~
drivers/irqchip/ti-timesync-intr.c:105:1: note: in expansion of macro ‘IRQCHIP_DECLARE’
  105 | IRQCHIP_DECLARE(ts_intr, "ti,ts-intr", tsr_init);
      | ^~~~~~~~~~~~~~~
./include/linux/of.h:1525:34: error: comparison of distinct pointer types lacks a cast [-Werror=compare-distinct-pointer-types]
 1525 |                      .data = (fn == (fn_type)NULL) ? fn : fn  }
      |                                  ^~
./include/linux/of.h:1540:17: note: in expansion of macro ‘_OF_DECLARE’
 1540 |                 _OF_DECLARE(table, name, compat, fn, of_init_fn_2)
      |                 ^~~~~~~~~~~
./include/linux/irqchip.h:37:9: note: in expansion of macro ‘OF_DECLARE_2’
   37 |         OF_DECLARE_2(irqchip, name, compat, typecheck_irq_init_cb(fn))
      |         ^~~~~~~~~~~~
drivers/irqchip/ti-timesync-intr.c:105:1: note: in expansion of macro ‘IRQCHIP_DECLARE’
  105 | IRQCHIP_DECLARE(ts_intr, "ti,ts-intr", tsr_init);
      | ^~~~~~~~~~~~~~~
./include/linux/minmax.h:24:35: error: comparison of distinct pointer types lacks a cast [-Werror=compare-distinct-pointer-types]
   24 |         (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
      |                                   ^~
./include/linux/of.h:1525:54: note: in definition of macro ‘_OF_DECLARE’
 1525 |                      .data = (fn == (fn_type)NULL) ? fn : fn  }
      |                                                      ^~
./include/linux/irqchip.h:37:9: note: in expansion of macro ‘OF_DECLARE_2’
   37 |         OF_DECLARE_2(irqchip, name, compat, typecheck_irq_init_cb(fn))
      |         ^~~~~~~~~~~~
./include/linux/irqchip.h:24:10: note: in expansion of macro ‘__typecheck’
   24 |         (__typecheck(typecheck_irq_init_cb, &fn) ? fn : fn)
      |          ^~~~~~~~~~~
./include/linux/irqchip.h:37:45: note: in expansion of macro ‘typecheck_irq_init_cb’
   37 |         OF_DECLARE_2(irqchip, name, compat, typecheck_irq_init_cb(fn))
      |                                             ^~~~~~~~~~~~~~~~~~~~~
drivers/irqchip/ti-timesync-intr.c:105:1: note: in expansion of macro ‘IRQCHIP_DECLARE’
  105 | IRQCHIP_DECLARE(ts_intr, "ti,ts-intr", tsr_init);
      | ^~~~~~~~~~~~~~~
./include/linux/minmax.h:24:35: error: comparison of distinct pointer types lacks a cast [-Werror=compare-distinct-pointer-types]
   24 |         (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
      |                                   ^~
./include/linux/of.h:1525:59: note: in definition of macro ‘_OF_DECLARE’
 1525 |                      .data = (fn == (fn_type)NULL) ? fn : fn  }
      |                                                           ^~
./include/linux/irqchip.h:37:9: note: in expansion of macro ‘OF_DECLARE_2’
   37 |         OF_DECLARE_2(irqchip, name, compat, typecheck_irq_init_cb(fn))
      |         ^~~~~~~~~~~~
./include/linux/irqchip.h:24:10: note: in expansion of macro ‘__typecheck’
   24 |         (__typecheck(typecheck_irq_init_cb, &fn) ? fn : fn)
      |          ^~~~~~~~~~~
./include/linux/irqchip.h:37:45: note: in expansion of macro ‘typecheck_irq_init_cb’
   37 |         OF_DECLARE_2(irqchip, name, compat, typecheck_irq_init_cb(fn))
      |                                             ^~~~~~~~~~~~~~~~~~~~~
drivers/irqchip/ti-timesync-intr.c:105:1: note: in expansion of macro ‘IRQCHIP_DECLARE’
  105 | IRQCHIP_DECLARE(ts_intr, "ti,ts-intr", tsr_init);
      | ^~~~~~~~~~~~~~~
drivers/irqchip/ti-timesync-intr.c: In function ‘ts_intr_irq_domain_alloc’:
drivers/irqchip/ti-timesync-intr.c:40:9: error: ‘output_line’ is used uninitialized [-Werror=uninitialized]
   40 |         irq_domain_set_hwirq_and_chip(domain, virq, output_line,
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   41 |                                       &ts_intr_irq_chip,
      |                                       ~~~~~~~~~~~~~~~~~~
   42 |                                       NULL);
      |                                       ~~~~~
drivers/irqchip/ti-timesync-intr.c:36:22: note: ‘output_line’ was declared here
   36 |         unsigned int output_line, input_line, output_line_offset;
      |                      ^~~~~~~~~~~

