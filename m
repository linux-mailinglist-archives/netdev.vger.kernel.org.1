Return-Path: <netdev+bounces-229829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3674BE11A1
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 02:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E26D19C7CBB
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 00:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737B513B5A9;
	Thu, 16 Oct 2025 00:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PHL6p96d"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A795129A78;
	Thu, 16 Oct 2025 00:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760574411; cv=none; b=mgTysJDTATxpu5dBp0jBDl9C8ZxAWdGiYRkPLoTtQPL9tqcFCcJhpj8Wrh2hMWpTLZ16DL004mOq3sOoAr1AIzbzJwsGsjvvvsXnlKva72FIxSskUoUiq1SnzD/IBETljZdUUnAOoprgx7IOUEZK54y6g0gq1Tye2SAM7lOixGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760574411; c=relaxed/simple;
	bh=dci8/nvjeserDU1XSRVaB0LJUfcrtMjJxrA+wBXlPLk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=juzpzlY/4Sgr1hwlzJW+dJIHVtWFShbwAMaZFIrHIY/qrggkau22ipEEGTk7DRcc+QcYEc0CMT2n6W6NXvUJ/JnAui/dC/p2iybvlVl2oUBG+qh6aKxLXRFNuKhKu4lIhJzP3w0yfdspOqKYQE56SZQhI0UOu7gNZgDF3H+F5Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PHL6p96d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CE49C4CEFB;
	Thu, 16 Oct 2025 00:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760574411;
	bh=dci8/nvjeserDU1XSRVaB0LJUfcrtMjJxrA+wBXlPLk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PHL6p96dLRo6FBa7H7Toa2kolJrhgiuIFBUpZYZxmD4Jdz81XAc2b2Qg0u5Howgqb
	 oCR9C1ABgWqDduxpgBHRAlRZTCIxSgHzz2oNaB+pnhEmz9ObKuTF5YAXwKHLLFigMP
	 ztptc54ByvdbgUHAANTRtS4hjX8XS8bOWxLf9qHlrNfbAUzYjSfP3hWVlkrvSTMG68
	 rDIOIXkx5OQ51TbGibvQyvsdIPOrqqetxjUTMPtaeZljQu3pDU7iJVY4AQbBU9yQMM
	 NL2SJ2Ey0sdIjuVvPZ2715gL64iBt6j/fCB7g8X531WKE7KDgAnw+DK6sWFHcpTZoK
	 k50dU1qxVqEbg==
Date: Wed, 15 Oct 2025 17:26:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Zhu Yanjun <yanjun.zhu@linux.dev>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Leon Romanovsky
 <leon@kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>, Cosmin
 Ratiu <cratiu@nvidia.com>, Ayush Sawal <ayush.sawal@chelsio.com>, Harsh
 Jain <harsh@chelsio.com>, Atul Gupta <atul.gupta@chelsio.com>, Herbert Xu
 <herbert@gondor.apana.org.au>, Ganesh Goudar <ganeshgr@chelsio.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <lvc-project@linuxtesting.org>
Subject: Re: [PATCH net v3] net: cxgb4/ch_ipsec: fix potential
 use-after-free in ch_ipsec_xfrm_add_state() callback
Message-ID: <20251015172649.279cf382@kernel.org>
In-Reply-To: <20251013095809.2414748-1-Pavel.Zhigulin@kaspersky.com>
References: <20251013095809.2414748-1-Pavel.Zhigulin@kaspersky.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 Oct 2025 12:58:08 +0300 Pavel Zhigulin wrote:
> +	if (unlikely(!try_module_get(THIS_MODULE))) {
> +		NL_SET_ERR_MSG_MOD(extack, "Failed to acquire module reference");
> +		return -ENODEV;
> +	}
> +
>  	sa_entry = kzalloc(sizeof(*sa_entry), GFP_KERNEL);
>  	if (!sa_entry) {
>  		res = -ENOMEM;

I think now you're missing a module put if something fails later.
-- 
pw-bot: cr

