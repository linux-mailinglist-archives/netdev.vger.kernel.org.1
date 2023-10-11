Return-Path: <netdev+bounces-40081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC617C5A42
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 19:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABF72282237
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 17:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8657A41;
	Wed, 11 Oct 2023 17:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D8QiIfdk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9603B39934
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 17:32:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28C54C433C8;
	Wed, 11 Oct 2023 17:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697045563;
	bh=1f/EjuaPCbCGCWkRuzwu7a/NWcfvSrtywlpUesiHtM0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D8QiIfdkartjbgMJbdZfAIe/B8248Oe+9iU9+iNObtvUFhpcUx59HjafLbdesD7yY
	 9C39bIgRNubYlaCDttZgUof1EpP4dEP32Cl9MpjhA8O+DRja0sEdA0YtjXTtFPYJNw
	 6bBxWH1L8CsDbDNpWe3T3NGqwiC4xuNJ9S1QK1Y4AIXuZVZavIXj/YCY9RxiRtG8Jb
	 nKXAuXP7Hqt38P0ZIXlXkta7z+NYTlJdVwUML5xaxLNvux4O0rJi2MJYHTVI5FE4X5
	 r0LWeUhQuNvybeYIB9K8ldbcVQpDjUAECauna/3lUFllgKZ7HsWrfJq4bO/6iFE9Hh
	 dKUapuhSPA1mw==
Date: Wed, 11 Oct 2023 11:32:38 -0600
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH 11/18] nvme-fabrics: parse options 'keyring' and 'tls_key'
Message-ID: <ZSbcNnJP_ug4ojyl@kbusch-mbp.dhcp.thefacebook.com>
References: <20230824143925.9098-1-hare@suse.de>
 <20230824143925.9098-12-hare@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824143925.9098-12-hare@suse.de>

On Thu, Aug 24, 2023 at 04:39:18PM +0200, Hannes Reinecke wrote:
>  	args.ta_data = queue;
>  	args.ta_my_peerids[0] = pskid;
>  	args.ta_num_peerids = 1;
> +	if (nctrl->opts->keyring)
> +		keyring = key_serial(nctrl->opts->keyring;

The key_serial call is missing the closing ')'. I fixed it up while
applying, but a little concerning. I'm guessing you tested with a
previous version?

Anyway, I've applied the series to nvme-6.7 since this otherwise looks
good. I'll let it sit there a day and send a pull request to Jens if the
build bots don't complain.

