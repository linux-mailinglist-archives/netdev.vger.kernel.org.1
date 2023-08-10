Return-Path: <netdev+bounces-26560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D9677821F
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 22:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C45381C20E27
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 20:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A7423BD5;
	Thu, 10 Aug 2023 20:25:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F498200BC
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 20:25:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB26AC433C7;
	Thu, 10 Aug 2023 20:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691699101;
	bh=1YYXvFAoppm4M8kiOkIWEqbRmKvfNZDSn9Ngz3JPAKo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nv2GjkKRJtwGJdVS4ReDMYIqunL3Pv+KtO1RireTzIkzYGUlPAjKoCRaSUhNqxQSU
	 UJTlYVOgEz12+kLlvWlYteXKKNkZGy4E8XQBxQUBTdKiuXgByFkYBGZA5CJMuZyJdH
	 Hg4ef9Y6DZ80my1N1Xf38e7y/O+0qU5lWt8Plj5LK7F6xa1JbJOrkrsSV28GcSYjk1
	 mWLwzP617xZ9ooLH56OWglb6fiZy+fRadKZ1I2lG2kKKBohHOcCl7/8r2qDWySDWR+
	 +J66ty5N0U288JNVifaIm0ZVWIKL+ZcbaDVDiFhaGTzwFj7e6R6DuKJdFHNAC2se6g
	 WLhye1H8PCcnw==
Date: Thu, 10 Aug 2023 22:24:56 +0200
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
Subject: Re: [PATCH net-next 1/2] net/xgene: fix Wvoid-pointer-to-enum-cast
 warning
Message-ID: <ZNVHmDgI9S1JKyht@vergenet.net>
References: <20230810103923.151226-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810103923.151226-1-krzysztof.kozlowski@linaro.org>

On Thu, Aug 10, 2023 at 12:39:22PM +0200, Krzysztof Kozlowski wrote:
> 'enet_id' is an enum, thus cast of pointer on 64-bit compile test with
> W=1 causes:
> 
>   xgene_enet_main.c:2044:20: error: cast to smaller integer type 'enum xgene_enet_id' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Simon Horman <horms@kernel.org> # build-tested

