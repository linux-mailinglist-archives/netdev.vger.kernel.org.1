Return-Path: <netdev+bounces-226698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67488BA4144
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 16:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF3611C011C6
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 14:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CFFD187346;
	Fri, 26 Sep 2025 14:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oC+5PZ06"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A4D34BA4D;
	Fri, 26 Sep 2025 14:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758896215; cv=none; b=PRnZfcgcDe3sDn7ppP6tqb5W+EPb/nE161IgZPLMciG39K08UvORHkZwWhjbPgZ4gN3GQ0XIZKstVZCSczljR9Ftw+VLtXmWpd8Q6J9gyS3+SpPY135I6J/Cw96507Q4aBEIgKu7hBoP3gPJqbQGuenrZQSk2mdHGV8/W+Ej3E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758896215; c=relaxed/simple;
	bh=F4CqQMNBgfWe4UbwdKx5Y63fVKA5uKqONA1gN72GIX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A+pLt9LiFJRYCbfBshVEdcx7zgawp5Hp7uC6sLf3dDs7+feMGPlc4Q1SqmV40B2eyzYj4FV7tg6HiO+dXH49HJ2hxOZeObFN2E7fuCgk1QzDnEhJKTej7L8E7vJ39HAI1A74KZExnWJeDPYxG/wT601ISmDW8eXllY3IAKO8cyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oC+5PZ06; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 262F3C4CEF4;
	Fri, 26 Sep 2025 14:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758896214;
	bh=F4CqQMNBgfWe4UbwdKx5Y63fVKA5uKqONA1gN72GIX8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oC+5PZ06H3soR/JIkFyonjknXzN/9X0ZfeAKMVrj01hHfCeUpV2HMmnF14nZ3WUC2
	 MlGqGXl0g/JBM154y7q2oKzQquSdi7J2fjR6dzZW5l1fJFw5o7CGiIQinUx3PkgwyK
	 +4GaKpFdSnIqqwaVoxHQQzakOXCd8gAjgLqaPbh6Dz1H2AGUbn+vHOGwlSsfxuZ8/I
	 ekNKq/yjcwKr4i1idojRPjv/2CzAi7sCML1ospUoYF5q5vWM12Uz+NMAwSQ2o9relz
	 iczc0hWKQgdlNtj4ArK/woRxO7amuYXpua2SY2SdyZ668pSiqYllDsFWalx2LI42jT
	 E55X73GFM8iYw==
Date: Fri, 26 Sep 2025 15:16:50 +0100
From: Simon Horman <horms@kernel.org>
To: Adam Young <admiyo@os.amperecomputing.com>
Cc: Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Huisong Li <lihuisong@huawei.com>
Subject: Re: [PATCH net-next v29 3/3] mctp pcc: Implement MCTP over PCC
 Transport
Message-ID: <aNagUmU8GOMbpfGq@horms.kernel.org>
References: <20250925190027.147405-1-admiyo@os.amperecomputing.com>
 <20250925190027.147405-4-admiyo@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925190027.147405-4-admiyo@os.amperecomputing.com>

On Thu, Sep 25, 2025 at 03:00:26PM -0400, Adam Young wrote:

...

> +static int initialize_MTU(struct net_device *ndev)
> +{
> +	struct mctp_pcc_ndev *mctp_pcc_ndev = netdev_priv(ndev);
> +	struct mctp_pcc_mailbox *outbox;
> +	int mctp_pcc_mtu;
> +
> +	outbox = &mctp_pcc_ndev->outbox;
> +	outbox->chan = pcc_mbox_request_channel(&outbox->client, outbox->index);
> +	mctp_pcc_mtu = outbox->chan->shmem_size - sizeof(struct pcc_header);

Hi Adam,

On the line below it is expected that outbox->chan may be an error value
rather than a valid pointer. But on the line above outbox->chan is
dereferenced.

This does not seem consistent.

Flagged by Smatch.

> +	if (IS_ERR(outbox->chan))
> +		return PTR_ERR(outbox->chan);
> +
> +	pcc_mbox_free_channel(mctp_pcc_ndev->outbox.chan);
> +
> +	mctp_pcc_ndev = netdev_priv(ndev);
> +	ndev->mtu = MCTP_MIN_MTU;
> +	ndev->max_mtu = mctp_pcc_mtu;
> +	ndev->min_mtu = MCTP_MIN_MTU;
> +
> +	return 0;
> +}

...

-- 
pw-bot: changes-requested

