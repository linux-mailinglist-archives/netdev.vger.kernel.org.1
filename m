Return-Path: <netdev+bounces-184204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 705A4A93B8C
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 19:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9490C442205
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 17:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E49215047;
	Fri, 18 Apr 2025 17:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oyRmt8ta"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA8B1C3306;
	Fri, 18 Apr 2025 17:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744995649; cv=none; b=m9h0ilNXyDWi4xaa1WM/Al6tpUTrNvxeu78AEX8H6gdny0TcYT+QoeqCFQT3SoDlIILTIwjyyOuz/ovMMaPjlhGG/evmG0hSgO/fysYV6I2zYPw0IPebaPhXlKNRjlvxoldfwpIXaJksWangj35MSygECyEJQSKt2kh5I4CZiY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744995649; c=relaxed/simple;
	bh=KN5qU6sNgXb/lB3tOKNCKsgEQKT9PjlafHKBd6uAs1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ABacL+nnkE0Ha23CSF0p3XPMFqnq9EIhTcYtUg+TtzFvEuTxTLZUqzhN9Z9Np4bYrt74yoAIy4Jo33mkgS+NFJgEl8cfN/jeyZrfrtRQJrSEHl+N4bpOR3+uW6nLY87X7NuczI+WKrUJFLPPiq4iR1PXpnfgB0WBljT12oLfoOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oyRmt8ta; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C740C4CEE2;
	Fri, 18 Apr 2025 17:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744995648;
	bh=KN5qU6sNgXb/lB3tOKNCKsgEQKT9PjlafHKBd6uAs1Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oyRmt8ta0EKg/VIkuao40EQIX29eTgTxTMHT47FwGRw6sK6rjLOi0yFgnahdMHnac
	 t75NYzMpEKgXmLTEcH6w/nQWeq6k9RlDuqIs+VX54Pcd+gsgo7eRC2UIpzPUOHtCUv
	 Yoz8uUigK67i0brdGb8AgogwQkGEi9QdVefE58LK4iIDVXU+zmrOmzd3CCRNlFPxZy
	 D43WFaaRe1aIWBNGOhwcXEDbSFFAVcao8R58IJ0rFno3oseIqaxU3m3LqIe5XeuqIB
	 +ba6bR7WYGKDL1Y4oObnIpOk2RkClsABc5WwRHQPf8HUTqLsOsEMO7lSL5mDgbTAGw
	 4puU/kpivKT/A==
Date: Fri, 18 Apr 2025 18:00:44 +0100
From: Simon Horman <horms@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-afs@lists.infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net-next] rxrpc: rxgk: Set error code in
 rxgk_yfs_decode_ticket()
Message-ID: <20250418170044.GB2676982@horms.kernel.org>
References: <Z_-P_1iLDWksH1ik@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_-P_1iLDWksH1ik@stanley.mountain>

On Wed, Apr 16, 2025 at 02:09:51PM +0300, Dan Carpenter wrote:
> Propagate the error code if key_alloc() fails.  Don't return
> success.
> 
> Fixes: 9d1d2b59341f ("rxrpc: rxgk: Implement the yfs-rxgk security class (GSSAPI)")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Simon Horman <horms@kernel.org>

...

> diff --git a/net/rxrpc/rxgk_app.c b/net/rxrpc/rxgk_app.c
> index 6206a84395b8..b94b77a1c317 100644
> --- a/net/rxrpc/rxgk_app.c
> +++ b/net/rxrpc/rxgk_app.c
> @@ -141,6 +141,7 @@ int rxgk_yfs_decode_ticket(struct rxrpc_connection *conn, struct sk_buff *skb,
>  			KEY_ALLOC_NOT_IN_QUOTA, NULL);
>  	if (IS_ERR(key)) {
>  		_leave(" = -ENOMEM [alloc %ld]", PTR_ERR(key));

Not a bug, but it doesn't seem ideal that _leave(), which logs a debug
message, is called here and with a more general format in the error label.

> +		ret = PTR_ERR(key);
>  		goto error;
>  	}
>  
> -- 
> 2.47.2
> 

