Return-Path: <netdev+bounces-23713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1774876D409
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 18:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3A9E281E3B
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 16:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C080DDAF;
	Wed,  2 Aug 2023 16:48:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934F7DDAD
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 16:48:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9D8EC433CB;
	Wed,  2 Aug 2023 16:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690994913;
	bh=Pdn2EtB/K/X3AmHuk5ox8AefKm9knP0sFeo3NYu+Yb0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hIBCvG+wTP06Y0lUk+87/LHyaSYCg9BZabwl8+s2O4iVuO+S7lgKbLbPzPu4COcYL
	 OYzCEsqxqQ0nXz6W0mKtdFW0XER54/HkWS86YZUDQJthVTDP27KOr/OVfOzbGsnxHG
	 f1Sx8mA1A16GnoStSPSxY9SbvJDJuv5EdsUV/HXRmXtJ+8V2hx6bRb9H5JrJ/f0UVQ
	 9j47BgG1z1CiRZ9x9t6zbmF5moVMSbsdC3DUHrLVhUqjZ+etIxuZwUOQQRoZXdCB/K
	 UbaRES0STA3u6/CyT4XS9colYzQQAtLxO+jKMmOD2UUkSIq2tGob9VFzniZHpUHZPo
	 00VhP/b/gKR4g==
Date: Wed, 2 Aug 2023 18:48:28 +0200
From: Simon Horman <horms@kernel.org>
To: Li Zetao <lizetao1@huawei.com>
Cc: lars.povlsen@microchip.com, Steen.Hegelund@microchip.com,
	daniel.machon@microchip.com, UNGLinuxDriver@microchip.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: microchip: vcap api: Use ERR_CAST() in
 vcap_decode_rule()
Message-ID: <ZMqI3MOQQr80UFa+@kernel.org>
References: <20230802093156.975743-1-lizetao1@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802093156.975743-1-lizetao1@huawei.com>

On Wed, Aug 02, 2023 at 05:31:56PM +0800, Li Zetao wrote:
> There is a warning reported by coccinelle:
> 
> ./drivers/net/ethernet/microchip/vcap/vcap_api.c:2399:9-16: WARNING:
> ERR_CAST can be used with ri
> 
> Use ERR_CAST instead of ERR_PTR + PTR_ERR to simplify the
> conversion process.
> 
> Signed-off-by: Li Zetao <lizetao1@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>


