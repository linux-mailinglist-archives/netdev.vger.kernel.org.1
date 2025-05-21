Return-Path: <netdev+bounces-192209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F7BABEED7
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 11:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD07B7AC290
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 08:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00995238C04;
	Wed, 21 May 2025 08:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VwLD+kch"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08D520E715;
	Wed, 21 May 2025 08:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747817997; cv=none; b=GjLzsnjtOk/FkfMYn8Ne1VOMmGy7OW5qe7U+Z9IbVedcBywZ0efwNH70IHPaG3GAECgKmgxXAyfBCy5pd4d6LHztkDmttOrr86TflSPA0AGePaKwGIbho6OBqEnOgJix90EJodyRl8KKIxWFC/Xac6NLfXdivcG66e7glFmmWys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747817997; c=relaxed/simple;
	bh=KSr1py+mpv6hL2cVk3wbDpFqUqhgU+ANqE7/KjCj9gM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uTd63yc5ZOUNuNwruGrM6ymePs42HGlhsYoxfnWrp+XWiO2lMGr8vrue2QB0ShRNY1IaaXXg+9w2v7Rt5rU4w9gm/jm1HJ5Z4JJMuG4E7gNOxWs3S5Qvya41bH+tJuuP2U+HFnA7UdN9KPUmarrsQMXHmG6D0FMNKIx1CeNngJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VwLD+kch; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF22CC4CEE4;
	Wed, 21 May 2025 08:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747817997;
	bh=KSr1py+mpv6hL2cVk3wbDpFqUqhgU+ANqE7/KjCj9gM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VwLD+kchrJE90JrzGeoR2fSeIE416vCJwOHwFdyzx+ReYM/dHUk8j0xKBX3CLGhQ+
	 YhM5VZiUjCNoP5ynnQp4bRB4uOFkKktQmGpXUzWHDg1yu1ew7o97qo+xq4Wb3J0fBD
	 uaTfz5AD3KKa4LMnYvbdV/omTm3ue/iRaYfXzjo2JZYTeHJemRTbkxPJQ4MSQirSUZ
	 Pul9Oimkbi/9CeSSUMzfJhXjz4V+W8cQyZOVCwOK78oGiSQ+/MP38wlSqzQxdnNk7I
	 1b6F5Vp04vJHD1LSTnUi+GTjc59DrzYmBLN8pw4IXhlXAlktWareFTqKwrODyX/I0E
	 NomKOaRpOP4Dg==
Date: Wed, 21 May 2025 10:59:54 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Raghav Sharma <raghav.s@samsung.com>
Cc: s.nawrocki@samsung.com, cw00.choi@samsung.com, alim.akhtar@samsung.com, 
	mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org, conor+dt@kernel.org, 
	richardcochran@gmail.com, sunyeal.hong@samsung.com, shin.son@samsung.com, 
	linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	dev.tailor@samsung.com, chandan.vn@samsung.com, karthik.sun@samsung.com
Subject: Re: [PATCH v2 1/3] dt-bindings: clock: exynosautov920: add hsi2
 clock definitions
Message-ID: <20250521-resourceful-majestic-octopus-cfaad1@kuoka>
References: <20250514100214.2479552-1-raghav.s@samsung.com>
 <CGME20250514095236epcas5p2c7a6c9380182da503bbe058edd69b84a@epcas5p2.samsung.com>
 <20250514100214.2479552-2-raghav.s@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250514100214.2479552-2-raghav.s@samsung.com>

On Wed, May 14, 2025 at 03:32:12PM GMT, Raghav Sharma wrote:
> Add device tree clock binding definitions for CMU_HSI2
> 
> Signed-off-by: Raghav Sharma <raghav.s@samsung.com>
> ---
>  .../clock/samsung,exynosautov920-clock.yaml   | 29 +++++++++++++++++--
>  .../clock/samsung,exynosautov920.h            |  9 ++++++
>  2 files changed, 36 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/samsung,exynosautov920-clock.yaml b/Documentation/devicetree/bindings/clock/samsung,exynosautov920-clock.yaml
> index 6961a68098f4..3cbb1dc8d828 100644
> --- a/Documentation/devicetree/bindings/clock/samsung,exynosautov920-clock.yaml
> +++ b/Documentation/devicetree/bindings/clock/samsung,exynosautov920-clock.yaml
> @@ -41,14 +41,15 @@ properties:
>        - samsung,exynosautov920-cmu-misc
>        - samsung,exynosautov920-cmu-hsi0
>        - samsung,exynosautov920-cmu-hsi1
> +      - samsung,exynosautov920-cmu-hsi2

List should be ordered. Stop adding to the end of the lists.

Best regards,
Krzysztof


