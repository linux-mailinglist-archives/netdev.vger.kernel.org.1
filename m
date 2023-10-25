Return-Path: <netdev+bounces-44215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 028647D71B1
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 18:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFE89281C51
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 16:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4072E65E;
	Wed, 25 Oct 2023 16:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UwEshaNT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7CC2869A
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 16:28:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F301C433C9;
	Wed, 25 Oct 2023 16:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698251311;
	bh=mrHjaT4q6kssAF2OM/Fu1vwtXIetFcoYLYr87oCTnHU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UwEshaNTsjGOW9nwZ9mfu5KgLNKpJljF1eNcXgynlUeRTVQOwPwf7ZBAYIhm6NXHr
	 6bRa/OUqNpS77MRwzLMaaOEretgcaxpYAHt/ehWFlcRPlJ5EJnGbqqfTvGv/gG3tsA
	 UsSs4CQ7atMJytcQWwYO9Jbp+OMlBOyvOP7X0ei15D2ratX65XbMJGKZXKDrq48mlT
	 wQTpWexmD4oOtE6+ZOZmRfPlYTCXC+0wfT6IMF625aS0HepBhmoC9SwMLJfVbP1b8c
	 VKo7I50Zm/xwKz8qBkW3ENU+buxDspUnznjC+2g0V2nGYqImKVOmY7JZfc1ncfX/Tp
	 JRqx8Jo7glB3g==
Date: Wed, 25 Oct 2023 09:28:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, jlayton@kernel.org,
 neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,
 trond.myklebust@hammerspace.com, anna@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, linux-nfs@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net v2] net: sunrpc: Fix an off by one in
 rpc_sockaddr2uaddr()
Message-ID: <20231025092829.6034bfcd@kernel.org>
In-Reply-To: <ZTkmm/clAvIdr+6W@tissot.1015granger.net>
References: <31b27c8e54f131b7eabcbd78573f0b5bfe380d8c.1698184674.git.christophe.jaillet@wanadoo.fr>
	<ZTkmm/clAvIdr+6W@tissot.1015granger.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Oct 2023 10:30:51 -0400 Chuck Lever wrote:
> Should these two be taken via the NFS client tree or do you intend
> to include them in some other tree?

FWIW we're not intending to take these. If only get_maintainer
understood tree designations :(

