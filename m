Return-Path: <netdev+bounces-123697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA11966306
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 15:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADD6A283858
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 13:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57BB1ACDE2;
	Fri, 30 Aug 2024 13:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xkdqqy85"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E320165F05;
	Fri, 30 Aug 2024 13:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725025017; cv=none; b=Qm6kkNO86oZwoHQxHf1ZJEfve3nKYnbLV8JQZmGhR+fsmAagYTw2zE6tn3AqYzA87i8x7LjMPlG/OoEu2sXXCNJf29uMA9Cs44M39+Ac7iLsQKwpWC/wo9ohrrEhQezRKAIKjnTla0tY/6IqcTwKZcKmTQAZeX/xC33ptBiq/4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725025017; c=relaxed/simple;
	bh=B8BSk5O38/8MUZsMqZ+hw7BLNb4ZXNw2yWEqAdF7/fQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OTxoiP2t0qWpsmayCPHwAMQNdqtOVibjEJtcEx9GjYARtGgTiunywKnJmf3FLlbFY7gaA9x74dVu06ajfMJh+tCf3rGJQD7veSQB0t5c08zPglp4f6iFhX+EKoGtIuY7PwsawJTsJhyhS4w1oPFwLxRgun08Y7bxclFSSLR8I2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xkdqqy85; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D97CC4CEC2;
	Fri, 30 Aug 2024 13:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725025017;
	bh=B8BSk5O38/8MUZsMqZ+hw7BLNb4ZXNw2yWEqAdF7/fQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Xkdqqy85Hw+vPB8+glCiFXV8PTiuIk21tfzVOOca8GSX7Zy/DbOmL3p9U9MeF3CAX
	 O7LD/OFTcTOOYRVfTWa899WlLmwQkHanYcmS7mrRQ12Nb5i/lcuDrO7xspX/7+21Jk
	 kswzGeyPoe1lZKUZLCw1CztPI6H/GZh/3NG6YaCeX4UDht3Dw+l7lhiYgzfw0tXDcQ
	 pLZBB8yYZWp7y108TPVAelhNXqutWmn0wQl4uzlTo/XNsZgSiDB97PyuTVjrLXAlH/
	 KbTGpzgIciao1jHFVj0uYlyZVPaaqAAkPryBpTxfkYn4lspnkjL+ualeHxlZ8CNRXz
	 U8N7pBX7QxlsQ==
Message-ID: <2348bf11-9ef1-41ef-aa53-8985a6d716ba@kernel.org>
Date: Fri, 30 Aug 2024 16:36:50 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 6/6] net: ti: icssg-prueth: Enable HSR Tx Tag
 and Rx Tag offload
To: MD Danish Anwar <danishanwar@ti.com>, Andrew Lunn <andrew@lunn.ch>,
 Dan Carpenter <dan.carpenter@linaro.org>, Jan Kiszka
 <jan.kiszka@siemens.com>, Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Jacob Keller <jacob.e.keller@intel.com>, Diogo Ivo <diogo.ivo@siemens.com>,
 Simon Horman <horms@kernel.org>, Richard Cochran <richardcochran@gmail.com>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, srk@ti.com,
 Vignesh Raghavendra <vigneshr@ti.com>
References: <20240828091901.3120935-1-danishanwar@ti.com>
 <20240828091901.3120935-7-danishanwar@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240828091901.3120935-7-danishanwar@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 28/08/2024 12:19, MD Danish Anwar wrote:
> From: Ravi Gunasekaran <r-gunasekaran@ti.com>
> 
> Add support to offload HSR Tx Tag Insertion and Rx Tag Removal
> and duplicate discard.
> 
> Duplicate discard is done as part of RX tag removal and it is
> done by the firmware. When driver sends the r30 command
> ICSSG_EMAC_HSR_RX_OFFLOAD_ENABLE, firmware does RX tag removal as well as
> duplicate discard.
> 
> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>

Reviewed-by: Roger Quadros <rogerq@kernel.org>

