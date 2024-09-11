Return-Path: <netdev+bounces-127338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B42097514C
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 13:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A1DD285312
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 11:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734F3188013;
	Wed, 11 Sep 2024 11:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lhraf1s0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A645187553;
	Wed, 11 Sep 2024 11:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726055933; cv=none; b=Z6rfbPStb3EFdFo19GTrSKqABy0xw9eKg8aiLjaKe3WzkmJdzB/CXh5yqxJblQJKDRC1se7yw0XB5cGXkCjkamYpDl1g5ZXBb/xS6Yg9rqRTtWYVOYlT6M6cH3Tp6QBLqopm70Nm8craaV4j908RBzhDw9g4vLuZqgAV7II84/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726055933; c=relaxed/simple;
	bh=W3MeGbMlXZEqOFQo3hp3zV5fFKX5WmK0/yDi8Hjdt+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XTWTQLYrYZEp4TUVrQ2BQ77gpncD7zRW5o/Wqqx7TcLo7rptCUh3qOmz/M1+dxRRHm3ZlX0CAXKLW4RyU0L5QSx0tsfzCAQgfpkuGYsdshkLnUQxIT074vgFmm07tmG46XlMUw9CoW3tclf4EDMzc9VQ6AMr83V/AoSJhd8seu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lhraf1s0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48D66C4CEC5;
	Wed, 11 Sep 2024 11:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726055932;
	bh=W3MeGbMlXZEqOFQo3hp3zV5fFKX5WmK0/yDi8Hjdt+E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lhraf1s0FVdZEzUazr/xZemjDjXENi2gI0E4s5fTSyrKC/cRXyth/VrPFehBk+oNB
	 P7t+iPh2LifTh3rXIXgVWILiPwybC49XZehOLplPjCA6Qrgo7kuNv15cBCt8f1vX3Y
	 onDJ+iUPlW8nAkGcFkr5KzFOC8q3FvJcd3j6wptUIAU9+0rV1laLq3dCNuStvlHKOG
	 r01Rq/BI8ZPFD2iMw0BbRBzx18JBVuEXb1KrbynSEr0Wka35xIT+qnVAYF5p8sd19b
	 p+gWynQAk7yliFxSu0sBfsddIsFBWoRVLVy2KgnzS/FzBq4vsND924GALFthTjhwIr
	 sNl7fdn1aVJzQ==
Message-ID: <1797e2e3-e500-4e35-902b-07f173d0e67b@kernel.org>
Date: Wed, 11 Sep 2024 14:58:45 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 4/5] net: ti: icssg-prueth: Enable HSR Tx
 duplication, Tx Tag and Rx Tag offload
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
 <20240911081603.2521729-5-danishanwar@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240911081603.2521729-5-danishanwar@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/09/2024 11:16, MD Danish Anwar wrote:
> From: Ravi Gunasekaran <r-gunasekaran@ti.com>
> 
> The HSR stack allows to offload its Tx packet duplication functionality to
> the hardware. Enable this offloading feature for ICSSG driver. Add support
> to offload HSR Tx Tag Insertion and Rx Tag Removal and duplicate discard.
> 
> hsr tag insertion offload and hsr dup offload are tightly coupled in
> firmware implementation. Both these features need to be enabled / disabled
> together.
> 
> Duplicate discard is done as part of RX tag removal and it is
> done by the firmware. When driver sends the r30 command
> ICSSG_EMAC_HSR_RX_OFFLOAD_ENABLE, firmware does RX tag removal as well as
> duplicate discard.
> 
> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>

Reviewed-by: Roger Quadros <rogerq@kernel.org>

