Return-Path: <netdev+bounces-22625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B72387685A1
	for <lists+netdev@lfdr.de>; Sun, 30 Jul 2023 15:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74586281707
	for <lists+netdev@lfdr.de>; Sun, 30 Jul 2023 13:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9201C20F0;
	Sun, 30 Jul 2023 13:33:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150FD363
	for <netdev@vger.kernel.org>; Sun, 30 Jul 2023 13:33:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00D7EC433C9;
	Sun, 30 Jul 2023 13:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690724037;
	bh=lwVGJ9+3Te0pa2QRIC66+V0cTNt3FbPt7biwJ3NXE+E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e3wNhH/1RwNVYMYns+qb7Gfp7d2vvMXRpiJkSV1FROj4NYWSCKWAALlDfcPTziE/5
	 h5ZL/piJE+cMeo5EhzaUJJ4IUO/OC7dJnTOvIaLrgwN1SihGCmz6OFbmitx9cWaaeN
	 GIzbkCqqFb3vHhBI/S5su6wrOl0soxxGW7TQepYBjOpvTKoWsKxKz7jwbztH+Fr0F9
	 cclfy18JUnfX2u9d0FAYJD8fqyhno2SkzXS9Qc4Mr1ABZ5hRVMUU6jAiVaVVaGDG7K
	 pCGOi14OW0lxeOFAPKUAuxX9+bMIGw/bgfcLt19kmS1g+yhRMBCkRr7ZnnlqGchY3h
	 58WeETZ5Om1XA==
Date: Sun, 30 Jul 2023 16:33:53 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] xfrm: Remove unused function declarations
Message-ID: <20230730133353.GH94048@unreal>
References: <20230729122858.25776-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230729122858.25776-1-yuehaibing@huawei.com>

On Sat, Jul 29, 2023 at 08:28:58PM +0800, Yue Haibing wrote:
> commit a269fbfc4e9f ("xfrm: state: remove extract_input indirection from xfrm_state_afinfo")
> left behind this.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  include/net/xfrm.h | 2 --
>  1 file changed, 2 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

