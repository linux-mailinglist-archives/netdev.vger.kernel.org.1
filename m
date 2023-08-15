Return-Path: <netdev+bounces-27547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7D977C60A
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 04:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCC132812E5
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 02:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37A517EF;
	Tue, 15 Aug 2023 02:45:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB922622
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 02:45:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93522C433C8;
	Tue, 15 Aug 2023 02:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692067530;
	bh=0jae72dUtO4J4G32Ts+li+r0BcK6uWhskBdEb04ieUo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pw4JSgGeLqMB/Dk+f88EXTTHTWHIq2iCZ07YbYCATn5Coirn7DVm2pbYm04lYa3B4
	 UdHBsgTTicgnOdvIm/C9xajI+2wotQKY6SDZM5S0xtG6dJMD/69UqnASNXNBGOcW0i
	 xzYAQnjRQGpd+JN0Jvf6exZTIfbRNQkmnQOnHc/kn85RkU0Ar9e3HRaXWxL1q7F1K1
	 KA7N9biVz+WU3VW1i4JhRae1UNAkV4r2/oAwLM5aHe23q1lTicB5o1eb5mWdp570U3
	 rZpfaieGW2NakV9KhzI3fENLizbxEmBeoDHDoQY7iV80WAtTS1aiOkoTLBNADI82SP
	 4VhE7jMLa621g==
Date: Mon, 14 Aug 2023 19:45:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Jiri Pirko <jiri@resnulli.us>, Arkadiusz Kubalewski
 <arkadiusz.kubalewski@intel.com>, Jonathan Lemon
 <jonathan.lemon@gmail.com>, Paolo Abeni <pabeni@redhat.com>, Milena Olech
 <milena.olech@intel.com>, Michal Michalik <michal.michalik@intel.com>,
 linux-arm-kernel@lists.infradead.org, poros@redhat.com,
 mschmidt@redhat.com, netdev@vger.kernel.org, linux-clk@vger.kernel.org,
 Bart Van Assche <bvanassche@acm.org>, intel-wired-lan@lists.osuosl.org
Subject: Re: [PATCH net-next v4 0/9] Create common DPLL configuration API
Message-ID: <20230814194528.00baec23@kernel.org>
In-Reply-To: <20230811200340.577359-1-vadim.fedorenko@linux.dev>
References: <20230811200340.577359-1-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Aug 2023 21:03:31 +0100 Vadim Fedorenko wrote:
>  create mode 100644 Documentation/driver-api/dpll.rst
>  create mode 100644 Documentation/netlink/specs/dpll.yaml
>  create mode 100644 drivers/dpll/Kconfig
>  create mode 100644 drivers/dpll/Makefile
>  create mode 100644 drivers/dpll/dpll_core.c
>  create mode 100644 drivers/dpll/dpll_core.h
>  create mode 100644 drivers/dpll/dpll_netlink.c
>  create mode 100644 drivers/dpll/dpll_netlink.h
>  create mode 100644 drivers/dpll/dpll_nl.c
>  create mode 100644 drivers/dpll/dpll_nl.h
>  create mode 100644 drivers/net/ethernet/intel/ice/ice_dpll.c
>  create mode 100644 drivers/net/ethernet/intel/ice/ice_dpll.h
>  create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/dpll.c
>  create mode 100644 include/linux/dpll.h
>  create mode 100644 include/uapi/linux/dpll.h

Feels like we're lacking tests here. Is there a common subset of
stuff we can expect reasonable devices to support?
Anything you used in development that can be turned into tests?

