Return-Path: <netdev+bounces-93438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B898BBC76
	for <lists+netdev@lfdr.de>; Sat,  4 May 2024 16:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD4E61F21507
	for <lists+netdev@lfdr.de>; Sat,  4 May 2024 14:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068071DDC9;
	Sat,  4 May 2024 14:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PFHlcG4/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B8122F00
	for <netdev@vger.kernel.org>; Sat,  4 May 2024 14:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714833421; cv=none; b=NpbIk0LyDRVn+x+655GPEnmeVwEVZDCM7Df/obwFGg6mG3w8QFiS1NGVZf7MrUINMzQGMeDll5fPbhZGFUJGestn6V/yEqJuPQ1Xk1WTJsujbH/giuGMTqiMY2q9uZyIJ6X4D83IV96G9pUf/xzXQp6+/Jw9IPbjlAAlP9bHEgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714833421; c=relaxed/simple;
	bh=bi39/4fhcKEeEBV7l/lkmaE1vbOYopca9R8qf6/aHfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ca1Kjx/SF+KeaGDeOdO8BpWmYszDmTk55j3TiQ6RVlwpeATfMGSzN7Er56kX+g7gYu+Hbb0YVQ37YOfP+l7zpLspsCEbWPWnEoXCY53V3ihSNt196t1K8xxR37fHjpCdMXUOhYnth8LrbkujMzbHGC1NYkHTFeablE6g6Fi+aOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PFHlcG4/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AF18C072AA;
	Sat,  4 May 2024 14:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714833421;
	bh=bi39/4fhcKEeEBV7l/lkmaE1vbOYopca9R8qf6/aHfg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PFHlcG4/DxVnj9JLIyJYMYczujSE6pm5V1ZpHXoq5Ec0W5QWGR1fFzbvHlQBZTk1Q
	 DQf23lNYNsYzYjVSC8R2sjDcJM6QUQLW3zakRLAZMmkHSdPT0iWtm3vvR36Q/HjF5J
	 cYY0V768JRIwvXT/sS4OZT8g9PDiHfkH1xkfr7ha/2wLcQtTNxAswfzB2HF0oHYyFA
	 h17eLPtPU5PXrx8o/W8EdeGJxSnSmHQTxRzU4W8wLizlSxCXtjaciYYfq6aP5dG4QH
	 YLVzKp315N3GPhXqRE8J8bOfq05ViFI8UFn+0KwL2xvMUziVgrtIS3LgaKoPY4+QLo
	 RUJYwiLwn416w==
Date: Sat, 4 May 2024 15:36:57 +0100
From: Simon Horman <horms@kernel.org>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org
Subject: Re: [PATCH 0/5] pull request (net-next): ipsec-next 2024-05-03
Message-ID: <20240504143657.GA2279@kernel.org>
References: <20240503082732.2835810-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503082732.2835810-1-steffen.klassert@secunet.com>

On Fri, May 03, 2024 at 10:27:26AM +0200, Steffen Klassert wrote:
> 1) Remove Obsolete UDP_ENCAP_ESPINUDP_NON_IKE Support.
>    This was defined by an early version of an IETF draft
>    that did not make it to a standard.
> 
> 2) Introduce direction attribute for xfrm states.
>    xfrm states have a direction, a stsate can be used
>    either for input or output packet processing.
>    Add a direction to xfrm states to make it clear
>    for what a xfrm state is used.
> 
> All patches from Antony Antony.
> 
> Please pull or let me know if there are problems.

Hi Steffen, all,

This comment is not strictly related to this pull request
and certainly not intended to impede progress of it towards upstream.

However, while looking over it I noticed that Sparse flags a rather
large number of warnings in xfrm code, mostly relating to __rcu annotations.
I'm wondering if, at some point, these could be addressed somehow.



