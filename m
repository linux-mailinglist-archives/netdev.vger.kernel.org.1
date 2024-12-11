Return-Path: <netdev+bounces-150930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96EF49EC209
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 03:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF8C8284894
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 02:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77E01422A8;
	Wed, 11 Dec 2024 02:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bjR596X2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B215713B58D
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 02:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733883606; cv=none; b=iD62gWQYT+2Fh0broxnAMbolqP60NOdj3QBKFfgx2rOMZ9ijyRtCWi3NoMdKzrepVXdNcz9J22Dr12BWvsL+SDLucWkGM73kQyLMByQHrgEVllKLuJ06ttFQnbtKj0S3yYn/lEUTTguOgvwPqritZPhEIqnfR625dpCvyWXr3g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733883606; c=relaxed/simple;
	bh=HM5aLR3IBVerkpjsM1hqBPvGb9Y8YY27zoqzzNYFnmU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jhG/hjfdQyclgJ/JAQezvvNLKzEZ9bu642VKN2P21oIcXzU5kmm7RHjOQbfX+vqhk79rZFLJUniDbGhlZU3VScZS8S3PdRLldAOTIEA0nhXdBsb4RjyN1kMvI4RYg8JCro0EW/6Hykjm3YeMqusq2buRl+XD3ZGau7yzuadJzxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bjR596X2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BF8FC4CED6;
	Wed, 11 Dec 2024 02:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733883606;
	bh=HM5aLR3IBVerkpjsM1hqBPvGb9Y8YY27zoqzzNYFnmU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bjR596X2AECHmNFoGfq6NaFV5g4brrf8b1G/EnnjtPMDxH2AN285b5jdItre9Ugbd
	 jziwkYLLjYr7aEVMijOJfGOaPsfOP9YDNL/xyLbtTE+ZkfgEZJi9emHYPVWTqj04jY
	 lEt+c1/MR9VjVx85lWDT5HQefEo2LzxIZSTal+4BUtU21wArhCPXIbBoEOPyGHtWiZ
	 /VIHw3UVBp31IwZJ4igoO7m32ffDzCO79CWFSIBRUOFfST3QEcF7dspEOD7ea3WeZE
	 86bzvsyUZ+cc3SwNfNDWLvyGUmo5CCqhVYBgHP3ZpnM8Q6WnK5obT27EHqYMMulWf0
	 cNX4ge2lx6vTQ==
Date: Tue, 10 Dec 2024 18:20:04 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 <netdev@vger.kernel.org>, Matthieu Baerts <matttbe@kernel.org>, Allison
 Henderson <allison.henderson@oracle.com>, "Steve French"
 <sfrench@samba.org>, Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher
 <jaka@linux.ibm.com>, Chuck Lever <chuck.lever@oracle.com>, Jeff Layton
 <jlayton@kernel.org>
Subject: Re: [PATCH v2 net-next 12/15] socket: Remove kernel socket
 conversion.
Message-ID: <20241210182004.16ce5df7@kernel.org>
In-Reply-To: <20241210073829.62520-13-kuniyu@amazon.com>
References: <20241210073829.62520-1-kuniyu@amazon.com>
	<20241210073829.62520-13-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Dec 2024 16:38:26 +0900 Kuniyuki Iwashima wrote:
> +	net = rds_conn_net(conn);
> +
>  	if (rds_conn_path_up(cp)) {
>  		mutex_unlock(&tc->t_conn_path_lock);
>  		return 0;
>  	}
> +
> +	if (!maybe_get_net(net))
> +		return -EINVAL;

FWIW missing unlock here.
-- 
pw-bot: cr

