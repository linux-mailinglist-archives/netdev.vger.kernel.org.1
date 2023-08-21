Return-Path: <netdev+bounces-29383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F8A782FB0
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 19:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45709280E10
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 17:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D65218F49;
	Mon, 21 Aug 2023 17:53:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2E2320F
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 17:53:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20F4DC433C7;
	Mon, 21 Aug 2023 17:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692640409;
	bh=Eu4xMibsspcitVnv+IIV/Kx019f1TZ1UkcODOoyqgV4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lpCqkMyQ+gt1LpYBem+D7uY4ZoncSoP1FIaKg75t+C5wRcoWjGwzMsBGrfSNzQDNs
	 FIzvfLcjTaG1icKsnEuJoxghy+QYKOXmYkQVnhFW2gUZ0if2gMMQytu+RFOxNTHouk
	 d1jr/eTUbuqmG/Sz8zWK+qNX4vXhax6RTJKhmL1rVrB6PvxIsPNNp8tSrfVbZXOiu2
	 8Bye11DLq7Wmy6neiMbbdZnl7Is08Mm2afyyTF4WdId9M7jXDG6A8QCp0mncjhpSfV
	 VFQnrliN0PLeaX996jlBxWLvflfJb2sz8rTo18ZGRHNnOMAnJdgn6xapz6DyPI568n
	 MqrXEn6JIm69g==
Date: Mon, 21 Aug 2023 10:53:27 -0700
From: Saeed Mahameed <saeed@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [net-next 14/15] net/mlx5: Convert PCI error values to generic
 errnos
Message-ID: <ZOOkl76HBMqYbDfH@x130>
References: <20230816210049.54733-1-saeed@kernel.org>
 <20230816210049.54733-15-saeed@kernel.org>
 <20230818152853.54a07be1@kernel.org>
 <20230818195502.22b416b3@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230818195502.22b416b3@kernel.org>

On 18 Aug 19:55, Jakub Kicinski wrote:
>On Fri, 18 Aug 2023 15:28:53 -0700 Jakub Kicinski wrote:
>> LMK if you want me to apply from the list and skip 14.
>

I will push a new PR without this patch, since the series is already
marked as Changes Requested.

>-110

