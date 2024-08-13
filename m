Return-Path: <netdev+bounces-118131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 672FE950A84
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 18:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10A461F255FD
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 16:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A231AAE29;
	Tue, 13 Aug 2024 16:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U83X13tZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFDF1AAE24;
	Tue, 13 Aug 2024 16:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723567147; cv=none; b=fHKKFE6Ck1ak8WwxIQDllZUZVKRvV2Mstu8UHVFCs7yz7pxwjBgLf7iqTrMFSLuWfL1NN92aw7Kbj9qCiTVlEqrPvzLLg0XqYukvZmYVbJz/jubZDS66abj5U0APGB9NUFfPYz1Op3sz48IEw0++ueJa4yexHPA8mTyuuO2DUyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723567147; c=relaxed/simple;
	bh=roREPA9w0B4QAmH4r0DoxNSGqiEyAAIoSzcgMliRsOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pM1KUONsZKu4eNcEYSQ65K7Ddhl6+1+J763u0D4xMW0mXAfTyx4QqvS6rZS7oI2d1X22YNrh2XNRPEHC+dUiPeCA6LO5+aQEOuXwnxPo01GbE0qG9LbaRk0us+49Qp37tO+apue7A4GuhbhqyXWEqHie0vrc52/ibYhixEGtsxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U83X13tZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF608C4AF09;
	Tue, 13 Aug 2024 16:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723567147;
	bh=roREPA9w0B4QAmH4r0DoxNSGqiEyAAIoSzcgMliRsOE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U83X13tZQk/OI6R78ui8JndwEQGAras2KVqWeG8ITZK1AZFFWUMvuOlXV3Gg5wTex
	 6U3o+vGf2sUnQMgLNvhrkNhkoPKaYaddn0yVuTJtSzGFvigS4841h2ChI+BsW2uROw
	 KqX+quzQSkwtFDemaMxN1OPkYRbmJqvsah/NfmKMStAiJj50bwvu29jt5PcS4JRWvV
	 JXsNf6TuS3ItTKQ0x0bCGBbtFeS39vvvDF11JADw4MzxjGfqRW48g+DnOK1C4AsENb
	 5+GrvXq6OWkZncL+SSROQwFfr2V/FszfaU4WTxXGqVS5Lu99qBtFGHoffaf2994qGb
	 e3fJeIFmi0U3Q==
Date: Tue, 13 Aug 2024 10:39:05 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Ayush Singh <ayush@beagleboard.org>
Cc: Eric Dumazet <edumazet@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Alex Elder <elder@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jakub Kicinski <kuba@kernel.org>, Tero Kristo <kristo@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	robertcnelson@beagleboard.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	lorforlinux@beagleboard.org, greybus-dev@lists.linaro.org,
	Nishanth Menon <nm@ti.com>, jkridner@beagleboard.org,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: net: ti,cc1352p7: Add
 bootloader-backdoor-gpios
Message-ID: <172356714476.1180285.11438350948461770539.robh@kernel.org>
References: <20240801-beagleplay_fw_upgrade-v2-0-e36928b792db@beagleboard.org>
 <20240801-beagleplay_fw_upgrade-v2-1-e36928b792db@beagleboard.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801-beagleplay_fw_upgrade-v2-1-e36928b792db@beagleboard.org>


On Thu, 01 Aug 2024 00:21:05 +0530, Ayush Singh wrote:
> bootloader-backdoor-gpio (along with reset-gpio) is used to enable
> bootloader backdoor for flashing new firmware.
> 
> The pin and pin level to enable bootloader backdoor is configured using
> the following CCFG variables in cc1352p7:
> - SET_CCFG_BL_CONFIG_BL_PIN_NO
> - SET_CCFG_BL_CONFIG_BL_LEVEL
> 
> Signed-off-by: Ayush Singh <ayush@beagleboard.org>
> ---
>  Documentation/devicetree/bindings/net/ti,cc1352p7.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


