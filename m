Return-Path: <netdev+bounces-210267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB41B1285B
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 03:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA1043B98A4
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 01:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B012198E8C;
	Sat, 26 Jul 2025 01:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n/REJ1vF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724EC80B;
	Sat, 26 Jul 2025 01:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753492049; cv=none; b=rd+Pb9PwapWEZTuM3vKAcWl2LplvZhGvz+omNW9StR7Qc8OddU8jrS2fA1dCerlq5yPklYKnhc4Kcm2lA9oQziVK0H1nxk4/+ZO+7/gOmR8HQd4RN2PzCDY0+5id8l2AGPW126nAp7CHC4+p6t8XuVTI9eM4tPH7G1LCyh+qQTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753492049; c=relaxed/simple;
	bh=qhx5Nhwil4hIiHo0q96bZOQw24prZ38dEsURdMUdluk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RtAwQQqXCI6u8JWPW2MbGrGQTmDzYugxYChouafLXaLfQpOkvAdFtqYIFHtBiaikjBIfTVZg5CbcV9gP6TyQ31dQgzo8wrdggBuFPnJczVnMlcL2wWO0p8qCJrfUaEerZFKMo+I67V/jTQn3l3VQTu5CV0k6+YMnY2qkafAmd6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n/REJ1vF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A386CC4CEE7;
	Sat, 26 Jul 2025 01:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753492048;
	bh=qhx5Nhwil4hIiHo0q96bZOQw24prZ38dEsURdMUdluk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=n/REJ1vFnJLn585c7zHdJCidhnZPBZwm76CCXrLnvKk1seJqjco7Dq9SNxR/ilwcP
	 Pt42hAS8QOspEcjXXbAXLD1Rq9L5sGpqk6SlcuMUhaicLJbLtBj0x2qRQ8Zh2A6MKM
	 /KzlOlLhz/hZs3YZe1PJVCT8Byi4yQ/BdISKZ/mxJ+b4/IWZWntRc5UX86RmOV3Jt2
	 JJCAubM++IYLrkdes74/CXkT2ha/yAg/SdJb7xbUqxEYnUJCLc0Qa8K2KSzTPD6zF6
	 1sV5TTmUMF9qjDAFq2jouXzkwPjQLN2TQWQggecCw/cmtsWOOkHWxwbYo2LgNU920P
	 B+eWEMNpFd5QA==
Date: Fri, 25 Jul 2025 18:07:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vishal Badole <Vishal.Badole@amd.com>
Cc: <Shyam-sundar.S-k@amd.com>, <andrew+netdev@lunn.ch>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND PATCH net-next] amd-xgbe: Configure and retrieve
 'tx-usecs' for Tx coalescing
Message-ID: <20250725180727.615d1612@kernel.org>
In-Reply-To: <20250719072608.4048494-1-Vishal.Badole@amd.com>
References: <20250719072608.4048494-1-Vishal.Badole@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 19 Jul 2025 12:56:08 +0530 Vishal Badole wrote:
> +	/* Check if both tx_usecs and tx_frames are set to 0 simultaneously */
> +	if (!tx_usecs && !tx_frames) {
> +		netdev_err(netdev,
> +			   "tx_usecs and tx_frames must not be 0 together\n");
> +		return -EINVAL;
> +	}
> +
>  	/* Check the bounds of values for Tx */
> +	if (tx_usecs > XGMAC_MAX_COAL_TX_TICK) {
> +		netdev_err(netdev, "tx-usecs is limited to %d usec\n",
> +			   XGMAC_MAX_COAL_TX_TICK);
> +		return -EINVAL;
> +	}

Please use extack to report the error to the user rather than system
logs.
-- 
pw-bot: cr

