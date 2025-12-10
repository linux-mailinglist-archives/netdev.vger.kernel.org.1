Return-Path: <netdev+bounces-244220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD1DCB28E6
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 10:29:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 075E2302C4E2
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 09:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636F3304BC5;
	Wed, 10 Dec 2025 09:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FL5i5bE2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359392701D1;
	Wed, 10 Dec 2025 09:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765358993; cv=none; b=cm5/T5897jF3qbbo1tpdJB3uk9jXa8SCTs4//8YQoqgep6IofGB43B3x2xo+8FGT02IhRo5jArsW8fGLkI4lzELXI/FvptrmR6Ydf4pfP3XweK5pcBIWDp7MMNHk+LwUscCppUlleEFBrTFryuAqEnsU/EJIXYRN1zVXpDKCLjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765358993; c=relaxed/simple;
	bh=AynZBjv1eSG1MhPauC7nKqm3Up3b7E1eGgP/VWwx9KM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q1wMj7R3unOnTldr9gUrLCEiQpFRNan47yzxP9o3yIOfAfqL8XUJ8h4VSPOHAUyF/OgOB5uKesjoJyDkCd/yv18nyM42dQCZgSj+tDswR+WVYxlwyL4YfdYxUsaFfL88GkRT81AV8EL6TJPajTbDj2Ji/P1hHCU/DKI8dEc3frQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FL5i5bE2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C156BC4CEF1;
	Wed, 10 Dec 2025 09:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765358992;
	bh=AynZBjv1eSG1MhPauC7nKqm3Up3b7E1eGgP/VWwx9KM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FL5i5bE2SR/jbZ1e33g3aMnHrXfI0346A9r4E/T3tLdiH4fyFTSMnXstwdnM/MEt7
	 z476/Q/Oq63J8L0lmJlQ0wOCdVtG4Qaz1Ez2NNykENtC1/kZeHcV7jqEqqUVqCTUIl
	 LWUsMMkXHVk9PBQgnEAZGkwZtMZkPAdFjeMc1LppRRhvW3CM0GYxoANB2/fGOGlZ+p
	 aYTVpMzbekBcizxZq6dxp97NUES0g2wwLIZfTSF2H6tVbpJde1CwV/AzmPvwrtq+cg
	 SB38PcBmNiVLIR0e6B/PfIafnKTz0brh+RFkJ6eJ4yIpdq3HipB5tZo0GOzPHJX6NT
	 k+OWrm9sabPlg==
Date: Wed, 10 Dec 2025 18:29:47 +0900
From: Jakub Kicinski <kuba@kernel.org>
To: david.laight.linux@gmail.com
Cc: Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Crt Mori <cmo@melexis.com>, Richard Genoud
 <richard.genoud@bootlin.com>, Andy Shevchenko
 <andriy.shevchenko@intel.com>, Luo Jie <quic_luoj@quicinc.com>, Peter
 Zijlstra <peterz@infradead.org>, netdev@vger.kernel.org, "David S . Miller"
 <davem@davemloft.net>, Simon Horman <simon.horman@netronome.com>, Mika
 Westerberg <mika.westerberg@linux.intel.com>, Andreas Noever
 <andreas.noever@gmail.com>, Yehezkel Bernat <YehezkelShB@gmail.com>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Subject: Re: [PATCH 1/9] nfp: Call FIELD_PREP() in NFP_ETH_SET_BIT_CONFIG()
 wrapper
Message-ID: <20251210182947.3f628953@kernel.org>
In-Reply-To: <20251209100313.2867-2-david.laight.linux@gmail.com>
References: <20251209100313.2867-1-david.laight.linux@gmail.com>
	<20251209100313.2867-2-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  9 Dec 2025 10:03:05 +0000 david.laight.linux@gmail.com wrote:
> Rather than use a define that should be internal to the implementation
> of FIELD_PREP(), pass the shifted 'val' to nfp_eth_set_bit_config()
> and change the test for 'value unchanged' to match.
> 
> This is a simpler change than the one used to avoid calling both
> FIELD_GET() and FIELD_PREP() with non-constant mask values.

I'd like this code to be left out of the subjective churn please.
I like it the way I wrote it. I also liked the bitfield.h the way
I wrote it but I guess that part "belongs" to the community at large.

FWIW - thumbs up for patch 8, no opinion on the rest.

