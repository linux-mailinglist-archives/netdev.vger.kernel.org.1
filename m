Return-Path: <netdev+bounces-91513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F7038B2EB0
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 04:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 714341C215B2
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 02:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E53C1860;
	Fri, 26 Apr 2024 02:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rdHuoK6a"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099B74430
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 02:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714098586; cv=none; b=MqdkGG4cBXa1XVJQ5ATWJpUyK4S6ps47PUfH6EEUXIEdaa/O2bxtxvkdWCGNoOpzsqvlLl0hSPH+hH4mOAm133QLHkULCgRk8N9MW1fHYWQXO+pkYa6tjKn5uNRgxLR8w5rYwufUZ8kKm15NPkTQjwULRUmdVCnzt8f4vjd+vlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714098586; c=relaxed/simple;
	bh=TKLY1/FgOBUJehL1qgt9TZFShFZtmUuoetJuy10tdE4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rLnXOSgvuTvuZMYUeaTvA2ndGbSc7nDPqPmJCy/hRYi+rDuAcc54SDrhpiIqULq+CfNlwnlmBKymj9zF2oXp37bKvsSlMTKayfCwW3Av1y2MAPPoiBV2njmiFRL7xL5ksxJmf7Ic2LodEBvgw6yvS1zuTSOj4bquk/ihodmtcrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rdHuoK6a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B44CC113CC;
	Fri, 26 Apr 2024 02:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714098585;
	bh=TKLY1/FgOBUJehL1qgt9TZFShFZtmUuoetJuy10tdE4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rdHuoK6aqMFGTxF3RTF1WIErMamefQUaBYr+qJtRaYnwoM9wC6Go04kYnCyFuEgQK
	 Ide2JhAQCgY+s2NqhBhGWIhJlu+YP0fGGSDf8ljYTSGctyahkkXp1PulsOPWQCD9Hi
	 hheYAhyU4kbrgmEn+33YP/gxFPDc/V9Ue90cl7x1njdfpsd5KYk1Uo9xBLtWJTJW/X
	 DsnaHpUR5aG9CoUjJkqzvfnLPwWnq+y1bsTrjEUyz9w0X1Ozb+L7XHeYkNxIIDQmYm
	 dNskh7bAlLATDFmQe0o3JRLWz2Ct3jr59gZcTqm8/brdMfb+gq1cpyyeHjRQqcR2Vl
	 qsjrWJLuPL9ww==
Date: Thu, 25 Apr 2024 19:29:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, laforge@osmocom.org,
 pespin@sysmocom.de, osmith@sysmocom.de, pabeni@redhat.com,
 edumazet@google.com, fw@strlen.de
Subject: Re: [PATCH net-next 00/12] gtp updates for net-next (v2)
Message-ID: <20240425192944.67c99bdf@kernel.org>
In-Reply-To: <20240425105138.1361098-1-pablo@netfilter.org>
References: <20240425105138.1361098-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Apr 2024 12:51:26 +0200 Pablo Neira Ayuso wrote:
> This v2 includes a sparse fix for patch #5 reported by Jakub.

Sorry one more semi-automated compiler warning, clang has this to
say about patch 12:

../drivers/net/gtp.c:606:14: warning: variable 'pctx' is uninitialized when used here [-Wuninitialized]
  606 |                 netdev_dbg(pctx->dev, "GTP packet does not encapsulate an IP packet\n");
      |                            ^~~~
../include/net/net_debug.h:57:21: note: expanded from macro 'netdev_dbg'
   57 |         dynamic_netdev_dbg(__dev, format, ##args);              \
      |                            ^~~~~
../include/linux/dynamic_debug.h:278:7: note: expanded from macro 'dynamic_netdev_dbg'
  278 |                            dev, fmt, ##__VA_ARGS__)
      |                            ^~~
../include/linux/dynamic_debug.h:250:59: note: expanded from macro '_dynamic_func_call'
  250 |         _dynamic_func_call_cls(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
      |                                                                  ^~~~~~~~~~~
../include/linux/dynamic_debug.h:248:65: note: expanded from macro '_dynamic_func_call_cls'
  248 |         __dynamic_func_call_cls(__UNIQUE_ID(ddebug), cls, fmt, func, ##__VA_ARGS__)
      |                                                                        ^~~~~~~~~~~
../include/linux/dynamic_debug.h:224:15: note: expanded from macro '__dynamic_func_call_cls'
  224 |                 func(&id, ##__VA_ARGS__);                       \
      |                             ^~~~~~~~~~~
../drivers/net/gtp.c:581:22: note: initialize the variable 'pctx' to silence this warning
  581 |         struct pdp_ctx *pctx;
      |                             ^
      |                              = NULL
../drivers/net/gtp.c:825:14: warning: variable 'pctx' is uninitialized when used here [-Wuninitialized]
  825 |                 netdev_dbg(pctx->dev, "GTP packet does not encapsulate an IP packet\n");
      |                            ^~~~
../include/net/net_debug.h:57:21: note: expanded from macro 'netdev_dbg'
   57 |         dynamic_netdev_dbg(__dev, format, ##args);              \
      |                            ^~~~~
../include/linux/dynamic_debug.h:278:7: note: expanded from macro 'dynamic_netdev_dbg'
  278 |                            dev, fmt, ##__VA_ARGS__)
      |                            ^~~
../include/linux/dynamic_debug.h:250:59: note: expanded from macro '_dynamic_func_call'
  250 |         _dynamic_func_call_cls(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
      |                                                                  ^~~~~~~~~~~
../include/linux/dynamic_debug.h:248:65: note: expanded from macro '_dynamic_func_call_cls'
  248 |         __dynamic_func_call_cls(__UNIQUE_ID(ddebug), cls, fmt, func, ##__VA_ARGS__)
      |                                                                        ^~~~~~~~~~~
../include/linux/dynamic_debug.h:224:15: note: expanded from macro '__dynamic_func_call_cls'
  224 |                 func(&id, ##__VA_ARGS__);                       \
      |                             ^~~~~~~~~~~
../drivers/net/gtp.c:787:22: note: initialize the variable 'pctx' to silence this warning
  787 |         struct pdp_ctx *pctx;
      |                             ^
      |                              = NULL

