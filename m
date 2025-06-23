Return-Path: <netdev+bounces-200393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E60AE4CAC
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 20:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA86C1890B31
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 18:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF2529CB39;
	Mon, 23 Jun 2025 18:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qUkiFHzD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43A123BF9C;
	Mon, 23 Jun 2025 18:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750702755; cv=none; b=JhXct3AqMlUd0WhKHT12QXGyYtxKCW8AkntLO9PXOQYo3Adri6EEu99QinQM4tfHJogm40U59JVaDwkAJwwiGriwNfjf4MPSkPZsElHlGiHnPifo/LGQ/c5deuVCOA3PRUaFwuaiueeLXINQOqH0IHvd2mVn5KiBf7ySD7A6jCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750702755; c=relaxed/simple;
	bh=LEHYRu3/7xSfEv3Cjj1c9lr1mtyqcmzcegD0em3dLe0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KIo9RO7EETd3mVIahPle7ITaNW0zLmecZDbFIze7sQjZZzRNKkWx3qsAZvDDHkam57AjVQfJ8/gn1xxxmZDToOuV6iYf2UEC5J6NwxCb/rN2AHvgxa5Lf5NBgCAgA0RKtC8RI2nk+ESDOtJZsFE8O+UWEl97GFHCGealXzIZbJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qUkiFHzD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBBBAC4CEEA;
	Mon, 23 Jun 2025 18:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750702754;
	bh=LEHYRu3/7xSfEv3Cjj1c9lr1mtyqcmzcegD0em3dLe0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qUkiFHzDWHjmj+7AaeUsqTx6LaoZuR658XBb6spCB6SxnOCXkpftc+SibmM3wglN+
	 QN2XhAOqBZxJE6F4qsbq9+fd695vXIOL691rtVcf9UkUBHzoTly0p6N5rg71Qz88h4
	 Ul4Epjty0Hq3du+mSGXA4mApwXSfxSufhbtjuOESEtGKjBdO6qSMrahI59kiBCIjNa
	 iwpti94HrJG6ghCZnwwNiImkK+sca5EuZuo1//Qj7bQQnZaAH0zRyYhjxAYOdbrlY+
	 QsNODuefyMv6hG0dz8X7ChbSzexhNTCQzEIxy7k+iRKynQCR7yug/AgTWRgRz+6LbW
	 LAtAyNtVP0L0Q==
Date: Mon, 23 Jun 2025 11:19:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: Matthew Gerlach <matthew.gerlach@altera.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 maxime.chevallier@bootlin.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, richardcochran@gmail.com,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, Mun Yew Tham
 <mun.yew.tham@altera.com>
Subject: Re: [PATCH v6] dt-bindings: net: Convert socfpga-dwmac bindings to
 yaml
Message-ID: <20250623111913.1b387b90@kernel.org>
In-Reply-To: <20250613225844.43148-1-matthew.gerlach@altera.com>
References: <20250613225844.43148-1-matthew.gerlach@altera.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Jun 2025 15:58:44 -0700 Matthew Gerlach wrote:
> Convert the bindings for socfpga-dwmac to yaml. Since the original
> text contained descriptions for two separate nodes, two separate
> yaml files were created.

Hi DT Maintainers! Thanks for reviewing the IPQ5018 bindings!
In case my pings are helpful, this is the next oldest patch in netdev
queue. The v4 seem to have gotten some feedback:
https://lore.kernel.org/all/20250609163725.6075-1-matthew.gerlach@altera.com/

