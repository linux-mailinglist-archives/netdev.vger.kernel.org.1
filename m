Return-Path: <netdev+bounces-15833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C5A74A15F
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 17:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1187F28137B
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 15:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E540AD25;
	Thu,  6 Jul 2023 15:47:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E247BA938
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 15:47:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 084B9C433C7;
	Thu,  6 Jul 2023 15:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688658450;
	bh=v4jGue9yUrQ15tRNs2k8or9Xz/JXP8QjRvYexu2gh3g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cFdOdI+kDlrfz/u27anBotvHcs3HvvpJyWKTZrGLgDFCUYqTdzogEV4KANa0HzJxI
	 TZAzvr6KaGMHjFQEePPFmjEkdRJWwqLyK75eE11Qalmed0owGp6y+QhwydY0q8rVDy
	 fb2mFsjWnJO6KvPATLz52ZMS64RtIMzg+shlHJL+nPzklP+E1+P67AkBqANJDOxmwG
	 bwhwCszL+cMyIY2gR9bjJDyikYzzoe/gJAYHMlphy1kzM20R5UQ8NZthwagJen3k0r
	 6sZ0s4nL9fCu4pat0y63mtoC5dkHD9FS6ZdUNNJE9OevRJDkP4Ta531rDUjNfU6cBb
	 YYLIPgqE+VUdA==
Date: Thu, 6 Jul 2023 08:47:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Wang Ming <machel@vivo.com>
Cc: Jon Maloy <jmaloy@redhat.com>, Ying Xue <ying.xue@windriver.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 tipc-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 opensource.kernel@vivo.com
Subject: Re: [PATCH v1] net:tipc:Remove repeated initialization
Message-ID: <20230706084729.12ed5725@kernel.org>
In-Reply-To: <20230706134226.9119-1-machel@vivo.com>
References: <20230706134226.9119-1-machel@vivo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  6 Jul 2023 21:42:09 +0800 Wang Ming wrote:
> The original code initializes 'tmp' twice,
> which causes duplicate initialization issue.
> To fix this, we remove the second initialization
> of 'tmp' and use 'parent' directly forsubsequent
> operations.
> 
> Signed-off-by: Wang Ming <machel@vivo.com>

Please stop sending the "remove repeated initialization" patches 
to networking, thanks.

