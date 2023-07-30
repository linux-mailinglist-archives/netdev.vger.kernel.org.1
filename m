Return-Path: <netdev+bounces-22635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB50876863F
	for <lists+netdev@lfdr.de>; Sun, 30 Jul 2023 17:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A98F1C20AA6
	for <lists+netdev@lfdr.de>; Sun, 30 Jul 2023 15:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D52DDA5;
	Sun, 30 Jul 2023 15:38:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6408020EE
	for <netdev@vger.kernel.org>; Sun, 30 Jul 2023 15:38:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB6BDC433C7;
	Sun, 30 Jul 2023 15:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690731514;
	bh=6Tg+YnOjTOzZ36qidVpHdrfFL8OCIoJOBbOccF6fXOs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G6XNmH6q8NDph4s4tKRMg1HzXO7d35v8KhJ1rYKyCvQihaXbPSrstWu3yHWFtGkN/
	 /AzMPjt5EMO9fj3uXNksTc7eE3aKQq7U9tVt4qCrEADu3lZUWFH7+mpPvb9Elz3q/J
	 //AedUHZd032n0qia2V8EB13C0zLZD8+dsF2gzM8KGR7s329KwTqo+IZSpemxP0cJo
	 YeJ1fY+iykWTSdll3IK3NjWqidVEt8YcBbC/UkyGB/DBNr9gkdnLo5t/R0UQElPJvG
	 wqGBnpzrG1w4mQ1CFy9nDxt0QdKk1NJD5NRZZdxKkxKkZ2D0ThOQY5P2jOjMlgJHpj
	 lu5d/lS0oRZFA==
Date: Sun, 30 Jul 2023 17:38:29 +0200
From: Simon Horman <horms@kernel.org>
To: Min-Hua Chen <minhuadotchen@gmail.com>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sunrpc: wrap debug symobls with CONFIG_SUNRPC_DEBUG
Message-ID: <ZMaD9ZIxQ3kRuCgB@kernel.org>
References: <20230728145751.138057-1-minhuadotchen@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728145751.138057-1-minhuadotchen@gmail.com>

On Fri, Jul 28, 2023 at 10:57:50PM +0800, Min-Hua Chen wrote:
> rpc_debug, nfs_debug, nfsd_debug, and nlm_debug are used
> if CONFIG_SUNRPC_DEBUG is set. Wrap them with CONFIG_SUNRPC_DEBUG
> and fix the following sparse warnings:
> 
> net/sunrpc/sysctl.c:29:17: sparse: warning: symbol 'rpc_debug' was not declared. Should it be static?
> net/sunrpc/sysctl.c:32:17: sparse: warning: symbol 'nfs_debug' was not declared. Should it be static?
> net/sunrpc/sysctl.c:35:17: sparse: warning: symbol 'nfsd_debug' was not declared. Should it be static?
> net/sunrpc/sysctl.c:38:17: sparse: warning: symbol 'nlm_debug' was not declared. Should it be static?
> 
> Signed-off-by: Min-Hua Chen <minhuadotchen@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


