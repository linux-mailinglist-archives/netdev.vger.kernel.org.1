Return-Path: <netdev+bounces-26559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C32C677821C
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 22:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3E5B1C20CDA
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 20:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ACFB23BD2;
	Thu, 10 Aug 2023 20:24:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7032B200BC
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 20:24:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EBF3C433C7;
	Thu, 10 Aug 2023 20:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691699084;
	bh=jopQY+MDrQTMS3xALVuBPVjTeyBhfxPaw9HNa4wXAqo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J0nLVAaoxggl1/VDsP7crLb2P+88Vnh1A84/Ue4PnQePt83IrJVnvEy426UHvOBWN
	 g9M3L9OfbV5hxhTy/lGhtGA2nVYwBEnT+HVHB9u9+eyNAtynVyk78yqJP++v+M2eMg
	 o1mQPherG59JnkmVxIE0ZrhDUkKRYJY/2jlnNzCH+ab6YtG31qWno8HVatk3BwrupB
	 A1ZDNxbrR+J3ecPePjE1ibk+9rDlch70w3+KwD6c2jiNrYAb0K+W+DqUxKO2i9KoP4
	 Zkr0jN9Nt6JFTfRGfFW894ekLhW+QKvr5eHIPdt1AJr7qhJrkkfc9LgbsStA4rcKBA
	 z4GUfLey3zlkA==
Date: Thu, 10 Aug 2023 22:24:38 +0200
From: Simon Horman <horms@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Iyappan Subramanian <iyappan@os.amperecomputing.com>,
	Keyur Chudgar <keyur@os.amperecomputing.com>,
	Quan Nguyen <quan@os.amperecomputing.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andi Shyti <andi.shyti@kernel.org>
Subject: Re: [PATCH net-next 2/2] net/marvell: fix Wvoid-pointer-to-enum-cast
 warning
Message-ID: <ZNVHhslhaVJOO/tI@vergenet.net>
References: <20230810103923.151226-1-krzysztof.kozlowski@linaro.org>
 <20230810103923.151226-2-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810103923.151226-2-krzysztof.kozlowski@linaro.org>

On Thu, Aug 10, 2023 at 12:39:23PM +0200, Krzysztof Kozlowski wrote:
> 'type' is an enum, thus cast of pointer on 64-bit compile test with
> W=1 causes:
> 
>   mvmdio.c:272:9: error: cast to smaller integer type 'enum orion_mdio_bus_type' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Simon Horman <horms@kernel.org> # build-tested

