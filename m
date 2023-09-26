Return-Path: <netdev+bounces-36335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 056517AF32B
	for <lists+netdev@lfdr.de>; Tue, 26 Sep 2023 20:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id B22B0281693
	for <lists+netdev@lfdr.de>; Tue, 26 Sep 2023 18:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E32138FBD;
	Tue, 26 Sep 2023 18:44:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3F329AB
	for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 18:44:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C864C433C8;
	Tue, 26 Sep 2023 18:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695753885;
	bh=KG2sRyrAO/Zemo0Lf4waWvy+trM3E7P3N8Bf2Td0z9E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AUvW9oG/V5HXkG38frkAq6WJzect8Sgy3xpgqbzNCDcmQcWeKBskGWSS86bxX22C6
	 pukD3Jz/wPvip4uK95+/ZcYWPuhGCFzsO0h5UQsaAE5LQ99akHuEfUuwky9s3lfPMl
	 6+NRLwrVT3y1vdc8iiQ0/utVKY+RZE0eYG6aQq//AYNcT2jri5C48JKLn8rIdauOox
	 fHe1VgYBkx+umMrpAJ+C7miVJRd2ZO8Foosapd1Tel1Ic3xLvzWGt56/JXn9nyfRof
	 tKaglTkf6d88T5y/wHNpIhY9BQV9ttPlzNx+KpnHhkVvwfkLbWQcqcju691qJ1m7Y6
	 MElvZMb99CogA==
Message-ID: <9670bbbe-e429-4a17-97a9-4d18c3ce907d@kernel.org>
Date: Tue, 26 Sep 2023 21:44:40 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3 net] net: ethernet: ti: am65-cpsw: Fix error code in
 am65_cpsw_nuss_init_tx_chns()
Content-Language: en-US
To: Dan Carpenter <dan.carpenter@linaro.org>,
 Grygorii Strashko <grygorii.strashko@ti.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 netdev@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <4c2073cc-e7ef-4f16-9655-1a46cfed9fe9@moroto.mountain>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <4c2073cc-e7ef-4f16-9655-1a46cfed9fe9@moroto.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 26/09/2023 17:04, Dan Carpenter wrote:
> This accidentally returns success, but it should return a negative error
> code.
> 
> Fixes: 93a76530316a ("net: ethernet: ti: introduce am65x/j721e gigabit eth subsystem driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Roger Quadros <rogerq@kernel.org>

