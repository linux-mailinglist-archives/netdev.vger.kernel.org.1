Return-Path: <netdev+bounces-111435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA175930F76
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 10:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E75831C2102A
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 08:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA241849D9;
	Mon, 15 Jul 2024 08:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BUJ3ISum"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCE213B294;
	Mon, 15 Jul 2024 08:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721031654; cv=none; b=I+JINkNoSRG3DvloPRUf17ljH1fnAb07tDd/L8gvMBGh6MlhfAaUjkabs7uNMaE5q+gu93BbPJPmuR0lrYil8ozhKaCLkHgL0FNZN358J4HtD/854o/8oDDlISWRLp6lODNqwiMA6DmyuP4KTVRcprLKDQwTSxHWwmwnvIgNeus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721031654; c=relaxed/simple;
	bh=1atlJa6pg5MLixwt13GOXk12gmJnNDnLh6Y2IRgFabk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T0qHA62iPGBKXfGLKtORjspvJ0e4XjOw9o+3DeZGpFk7GkS/99mKfn7QMP4tO+nbpwkkTAMXlA9Rr53/LtL9QAL8SVWNpZBab2KeWOO3FfCrhBBudXr2iWGkQPiZobdvBEoyUZIrH7gcL6HpegO4Wmqny3Z9Lk0TZ5NpaBjHQhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BUJ3ISum; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 791D0C4AF0B;
	Mon, 15 Jul 2024 08:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721031654;
	bh=1atlJa6pg5MLixwt13GOXk12gmJnNDnLh6Y2IRgFabk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BUJ3ISumVYGL9TRsL2xf6Jx3DbqqfeCPuD79Mp8KZ+eHP+qMp14sDxeuIqprLWxiI
	 +cl6qYJKOXWdNy/hT4FqLkUwKbDNEyREgwmzOOiBeG/cDxckxpsQD+WD7DxhRA7xVn
	 VR5VLHqyHri/Ix3cO8T7Q18ldTJWXO32OP/v1bfvhfIO8HhgGKmAzZxfjJCYbzu7HH
	 rCVHMgncLXuppXW4T9OsL7JtfqOfaPsuK8qHWF689yo4o70XobEdReVoi4xZhhPvgd
	 tN34OvqJlSIM4PpjGFnPUHaHbaChT7Bx1M+e/ha0eBJomVLvRzSAWObNrl8r9k3r+8
	 +2J80W8mYcTag==
Date: Mon, 15 Jul 2024 09:19:19 +0100
From: Simon Horman <horms@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	netdev@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: Re: [PATCH net-next] llc: Constify struct llc_conn_state_trans
Message-ID: <20240715081919.GB8432@kernel.org>
References: <87cda89e4c9414e71d1a54bb1eb491b0e7f70375.1720973029.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87cda89e4c9414e71d1a54bb1eb491b0e7f70375.1720973029.git.christophe.jaillet@wanadoo.fr>

+ Iwashima-san

On Sun, Jul 14, 2024 at 06:05:56PM +0200, Christophe JAILLET wrote:
> 'struct llc_conn_state_trans' are not modified in this driver.
> 
> Constifying this structure moves some data to a read-only section, so
> increase overall security.
> 
> On a x86_64, with allmodconfig, as an example:
> Before:
> ======
>    text	   data	    bss	    dec	    hex	filename
>   13923	  10896	     32	  24851	   6113	net/llc/llc_c_st.o
> 
> After:
> =====
>    text	   data	    bss	    dec	    hex	filename
>   21859	   3328	      0	  25187	   6263	net/llc/llc_c_st.o
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Simon Horman <horms@kernel.org>


