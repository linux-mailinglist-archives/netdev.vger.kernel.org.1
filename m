Return-Path: <netdev+bounces-127336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3683975142
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 13:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B9ED1F2887D
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 11:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B144C187869;
	Wed, 11 Sep 2024 11:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fh34XySv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C35187861;
	Wed, 11 Sep 2024 11:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726055756; cv=none; b=UZqF5uG+l+S211zZojha4l2ZH59RTQs5Sqjmo3lXSs0WOiCS8vK+/8LoavIfTe3J1BIgmn/BFIjddTeSqlNjqBFzaPbA400JQbBXlaerGCCwSuJvS5JGXoI6pvYlPm6NGajBaD/56UJhXZAC90/XKGMAlrNoC6ggIp+eY92er/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726055756; c=relaxed/simple;
	bh=BKZfmwCItsZ9kqea9hvrdqX3cRkygRWMUnFXWOAjBXQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cYSCJ6DfWUIqQ2MuXtRpu0okAgXWcEI1i0L94gSPBuYLZ+hpmEAJyVvGMTyvzUs05nsTqQZJptZRR7WWQxn3RhyDyXfKdrUxz/NWbgIzQnkTFjdGCADx1soyyi6Tga3Pr9TPvhspFvCad26BraEHuJUoN7+/NBUwXTaZ1j+i9Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fh34XySv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD534C4CEC5;
	Wed, 11 Sep 2024 11:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726055756;
	bh=BKZfmwCItsZ9kqea9hvrdqX3cRkygRWMUnFXWOAjBXQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fh34XySvZGhwXcO/P1MQqhz01AZ1NWivyD7MJ+aPsEvfKnK7WNzeSmPEvtAQe+sr5
	 njevjvE+NAT1YVph11YeFQN3bBr6Ta5TgVfVBZJlB9emWk4KGsNJ+TIJEnYFb92uJr
	 3XemSPu583iVRto9pNs4dTdYYl7pEGWcDeTcgj+z9AIHESbD01S7lZqAgCTmh2elES
	 j6ks6dil1JFwSRX1E1+ysSQm3n7Qt+D6xgaG2nWX/MRvnhXTrPEgbgAy2nM8rvZgDD
	 ezMFxjUKIbM1jGX/8kBdf/s5wi/yANnuqYx9k6g0C540WGT6pqJUxkZZnpMARofvuH
	 uyhp/nYbVebYw==
Message-ID: <61611bc5-6a4c-4c4b-9088-b0f00c4894a2@kernel.org>
Date: Wed, 11 Sep 2024 14:55:49 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 3/5] net: ti: icssg-prueth: Add support for
 HSR frame forward offload
To: MD Danish Anwar <danishanwar@ti.com>, robh@kernel.org,
 jan.kiszka@siemens.com, dan.carpenter@linaro.org, r-gunasekaran@ti.com,
 saikrishnag@marvell.com, andrew@lunn.ch, javier.carrasco.cruz@gmail.com,
 jacob.e.keller@intel.com, diogo.ivo@siemens.com, horms@kernel.org,
 richardcochran@gmail.com, pabeni@redhat.com, kuba@kernel.org,
 edumazet@google.com, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, srk@ti.com,
 Vignesh Raghavendra <vigneshr@ti.com>
References: <20240911081603.2521729-1-danishanwar@ti.com>
 <20240911081603.2521729-4-danishanwar@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240911081603.2521729-4-danishanwar@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/09/2024 11:16, MD Danish Anwar wrote:
> Add support for offloading HSR port-to-port frame forward to hardware.
> When the slave interfaces are added to the HSR interface, the PRU cores
> will be stopped and ICSSG HSR firmwares will be loaded to them.
> 
> Similarly, when HSR interface is deleted, the PRU cores will be
> restarted and the last used firmwares will be reloaded. PRUeth
> interfaces will be back to the last used mode.
> 
> This commit also renames some APIs that are common between switch and
> hsr mode with '_fw_offload' suffix.
> 
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>

Reviewed-by: Roger Quadros <rogerq@kernel.org>

