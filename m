Return-Path: <netdev+bounces-244071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A40C5CAF320
	for <lists+netdev@lfdr.de>; Tue, 09 Dec 2025 08:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1C3593008064
	for <lists+netdev@lfdr.de>; Tue,  9 Dec 2025 07:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3547B214813;
	Tue,  9 Dec 2025 07:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sXNnhTHr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F2E22F01;
	Tue,  9 Dec 2025 07:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765266551; cv=none; b=oUblWMpZuNxF2XhbCXDjp4saBFdtSjkxyC0qRisCf6wiEXAhIy0GgiZDtXRuah1Ssn77MVJWDQp3F5tlTDR3sSwTagI/PPAXSVzJjXNxpLcMj2LzQ2qzWm6MidC6dOOEc7KgAjxanvs3aKbS4WAAGTzubyvevEUCUnJ3lw8/hCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765266551; c=relaxed/simple;
	bh=AQfCgr/2BxTNWm4TTVxZ3VOxU83+R3WB1gT9ntGoYiw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CeYkfTfzMNJCAO5AODDHGp/y3PlcRSKGjYr3IFa7l00kmyiVvF9Vlhv+iDarkjGyyUg/w4F196RIrXPXtxpjqvzV+une4txS4Bs4N3d5I9j1uvie2WKet8nS6rW4FwXs6V1bCgyD+snuCsCtZ/zUyFE9+m5q6LIReqMTyBKO1mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sXNnhTHr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37934C4CEF5;
	Tue,  9 Dec 2025 07:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765266550;
	bh=AQfCgr/2BxTNWm4TTVxZ3VOxU83+R3WB1gT9ntGoYiw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sXNnhTHrT0sU+MIKJhbnTFh+TmfTKkddnJIk4Wlmsd+rh8Um/+uKUNYU5+pao8Se7
	 Two3SjztLjkTgs9yym43a9mNO7FHaSy8ZXPbiCK6oHxOdGc/aCQcO5iUpyN0fpfgJK
	 LoHyE0E3meNeV7lMwaVmg30qgoYgANtKY7FyPrjqZ8sypQMTxoO370vCFvz09iwUb2
	 z4iiFpGcl8KXPXE6yx7A99oeHso7Ks1+WJqKQwTrAVe99xiD/eCkGP6oeHaryhomvY
	 GO8HXdCMpu38zPNLH4rg/2ZtBAfPpLxf/zOAsmN2iLrOG7EL/iV1T4URiHTcHIIS6F
	 EsPZXwRv01R8g==
Date: Tue, 9 Dec 2025 16:49:04 +0900
From: Jakub Kicinski <kuba@kernel.org>
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
 david.laight.linux@gmail.com
Cc: Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Crt Mori <cmo@melexis.com>, Richard Genoud
 <richard.genoud@bootlin.com>, Andy Shevchenko
 <andriy.shevchenko@intel.com>, Luo Jie <quic_luoj@quicinc.com>, Peter
 Zijlstra <peterz@infradead.org>, netdev@vger.kernel.org, "David S . Miller"
 <davem@davemloft.net>, Simon Horman <simon.horman@netronome.com>, Andreas
 Noever <andreas.noever@gmail.com>, Yehezkel Bernat <YehezkelShB@gmail.com>
Subject: Re: [PATCH 0/9] bitfield: tidy up bitfield.h
Message-ID: <20251209164904.6163fcff@kernel.org>
In-Reply-To: <20251209070806.GB2275908@black.igk.intel.com>
References: <20251208224250.536159-1-david.laight.linux@gmail.com>
	<20251209070806.GB2275908@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 9 Dec 2025 08:08:06 +0100 Mika Westerberg wrote:
> > drivers/thunderbolt/tb.h passes a bifield to FIELD_GET(), these can't
> > be used with sizeof or __auto_type. The usual solution is to add zero,
> > but that can't be done in FIELD_GET() because it doesn't want the value
> > promoted to 'int' (no idea how _Generic() treated it.)
> > The fix is just to add zero at the call site.
> > (The bitfield seems to be in a structure rad from hardware - no idea
> > how that works on BE (or any LE that uses an unusual order for bitfields.)  
> 
> Okay but can you CC me the actual patch too? I only got the cover letter
> ;-)

Right, David, please fix your CC lists. kernel dev 101..

