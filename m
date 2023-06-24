Return-Path: <netdev+bounces-13758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 127CE73CD48
	for <lists+netdev@lfdr.de>; Sun, 25 Jun 2023 00:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9742A2810FD
	for <lists+netdev@lfdr.de>; Sat, 24 Jun 2023 22:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B285DEAF7;
	Sat, 24 Jun 2023 22:28:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55747FBE6
	for <netdev@vger.kernel.org>; Sat, 24 Jun 2023 22:28:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CF96C433C0;
	Sat, 24 Jun 2023 22:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687645707;
	bh=Xr9seD7Mt0PFVk1QOrKGfmugFEuY6PJhYDOWIjAJ3WA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FDUqIVyjZ3Cfh7ExAtZpIjceASv+BaEVlPCa8QEJ4bwPEW+jTqHQZEhfONR2MUwc3
	 5Mp0gKdkLj4yYQLd4HON2qkF41Gafrrox+E8wFnOW/o5l/4AJbOUNJWX33+EWfgGPg
	 IMlt1eu3C19cBzoreFP44pgNG2aoeP1nlScOiTGit6W6FmW3c+wdZg8Z/Irg/2VY/z
	 Va3h1a652baAJCbUVekzBE2STG4luQM/yDQ6HLorqhIp8fbo+xUhdkDX4AMjOZ5DwS
	 gkOJ3WQc57aXgpkdEaF2BUlXnavrG1sH82rKexDKVDH4aTA6K8cg+7HxoqVa2B0Lza
	 4jV57LkHmGFlQ==
Date: Sat, 24 Jun 2023 15:28:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Julia Lawall <Julia.Lawall@inria.fr>
Cc: Veerasenareddy Burru <vburru@marvell.com>, keescook@chromium.org,
 kernel-janitors@vger.kernel.org, Abhijit Ayarekar <aayarekar@marvell.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/26] octeon_ep: use array_size
Message-ID: <20230624152826.10e3789b@kernel.org>
In-Reply-To: <20230623211457.102544-3-Julia.Lawall@inria.fr>
References: <20230623211457.102544-1-Julia.Lawall@inria.fr>
	<20230623211457.102544-3-Julia.Lawall@inria.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 Jun 2023 23:14:33 +0200 Julia Lawall wrote:
> -	oq->buff_info = vzalloc(oq->max_count * OCTEP_OQ_RECVBUF_SIZE);
> +	oq->buff_info = vzalloc(array_size(oq->max_count, OCTEP_OQ_RECVBUF_SIZE));

vcalloc seems to exist, is there a reason array_size() is preferred?
-- 
pw-bot: cr

