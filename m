Return-Path: <netdev+bounces-20568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9142176022A
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 00:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E1F6281439
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 22:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E08D125C1;
	Mon, 24 Jul 2023 22:22:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55854125B4
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 22:22:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77FC7C433C7;
	Mon, 24 Jul 2023 22:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690237377;
	bh=wl0mhF3cT7PchdnsU4gO3ay5fRcn/U2R4MFE/0a4lFA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eRRa48YJ3pJE/D39YCQvQn/rWkDeXn1qydMkK3bxvkZ1YrF89SKrTP2cDHRPaa146
	 rIYyc5aN6sKBU857PM3yTkx56MeLo4hohmemBVgnXIpZvr1OZKFBCuR1UBIHEibq+A
	 pdgfDaVUe018Fe1epjzAzuG01Fjx0KRr/njht8AC5HjDGsJ3k/+GUdiH3ySaHdWn93
	 fWE12aAehyEnbGPr01uwCaL/WCCT3y8OFg+OcL0rqoJf+0aFd18ryffbf/7j2wstgX
	 XcDnOGcK6YbUx9ieqKyQ4rDiGH7kEdH/Xg4au9IzWGYgvb4s3ZOlgcS38ox5MocDHz
	 w36jpquA3E9pA==
Date: Mon, 24 Jul 2023 15:22:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>,
 Eric Dumazet <edumazet@google.com>, Herbert Xu
 <herbert@gondor.apana.org.au>, netdev@vger.kernel.org, Paolo Abeni
 <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>, Simon Horman
 <simon.horman@corigine.com>, Ilia Lin <quic_ilial@quicinc.com>
Subject: Re: [PATCH net-next 4/4] xfrm: Support UDP encapsulation in packet
 offload mode
Message-ID: <20230724152256.32812a67@kernel.org>
In-Reply-To: <051ea7f99b08e90bedb429123bf5e0a1ae0b0757.1689757619.git.leon@kernel.org>
References: <cover.1689757619.git.leon@kernel.org>
	<051ea7f99b08e90bedb429123bf5e0a1ae0b0757.1689757619.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Jul 2023 12:26:56 +0300 Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Since mlx5 supports UDP encapsulation in packet offload, change the XFRM
> core to allow users to configure it.
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Steffen, any opinion on this one? Would you like to take the whole series?

