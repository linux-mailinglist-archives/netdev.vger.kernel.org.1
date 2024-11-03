Return-Path: <netdev+bounces-141353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 272C89BA869
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 23:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 432F61C20C59
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 22:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7515118C022;
	Sun,  3 Nov 2024 22:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pv0Fny39"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47AE87494;
	Sun,  3 Nov 2024 21:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730671200; cv=none; b=SDLLco+v2PJoZ9b4cB3hGlhMIHMfiM7pIL9nNPPwx+m9IWIol6IHIXsFggRLNEO17uYnvXd94dzTMhv86Njq6FbK4gx+6DxkZXl8lubkxq6ozRc83OVIUx8KWqXdDqYHhK2ogRpvQjC9Y45BPpGrEMAelCXHVZ8K6IDEAOlw3Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730671200; c=relaxed/simple;
	bh=dzjPKWiZRwZuxl1cYC68AYFcJpejyg91wMMC28iirbo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fyl4Vu5Es5alTbmnFiGRrMV4cz3v6X89MfGBVnVXubk5m37mkpyMYEG3k17P8a1cNFtbEN/u6LdIEVU/ovoneYI7ixTWmLqj5iC+DG1JzBIIaaJMXtqfdDXgQsHNLhJ/U3EDX9uZ9zKbz/X36TGdAOZZ3JAXkiXIceTaxYzDlSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pv0Fny39; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F9E1C4CECD;
	Sun,  3 Nov 2024 21:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730671199;
	bh=dzjPKWiZRwZuxl1cYC68AYFcJpejyg91wMMC28iirbo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pv0Fny39cL9zKpECNucL0qWh5BczvmQesiBeiS4DLMfFG9BkXKOKcPcTkPWmWnq8v
	 ilB5nCczrul0SkFMa2zbHmqY3YCB+lFQFDCz/uMAnkRO/cF0+wiTQr18xwoB/sP7f5
	 DRpU/PxE3tSZftI6EioEAG2pOSObTK3R8ZX8L4oYCk0I+KxrXN/PY6Ecjr2fdShpQE
	 k8xx+eT7gQjE9bf2ImSLrVR1gUggNwiG/YWqz2UxsXTqb21cCQyx29ISCTMeOI1jqo
	 6++7+5dXTJu2GSV29dY+D4x6EkCIMJyyzO0QalidMFqKqtc3PD8CjB0DL2zqkpclK0
	 99Z3/9ep+PkQQ==
Date: Sun, 3 Nov 2024 13:59:58 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Sudarsana Kalluru <skalluru@marvell.com>, Manish
 Chopra <manishc@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH net-next] net: bnx2x: use ethtool string helpers
Message-ID: <20241103135958.28eba405@kernel.org>
In-Reply-To: <20241030205147.7442-1-rosenp@gmail.com>
References: <20241030205147.7442-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Oct 2024 13:51:47 -0700 Rosen Penev wrote:
> @@ -3220,13 +3212,13 @@ static void bnx2x_get_strings(struct net_device *dev, u32 stringset, u8 *buf)
>  			start = 0;
>  		else
>  			start = 4;
> -		memcpy(buf, bnx2x_tests_str_arr + start,
> -		       ETH_GSTRING_LEN * BNX2X_NUM_TESTS(bp));
> +		for (i = start; i < BNX2X_NUM_TESTS_SF; i++)
> +			ethtool_puts(&buf, bnx2x_tests_str_arr[i]);

There are three cases - MF, SF and VF. 
You seem to have covered SF and MF, but not VF.
-- 
pw-bot: cr

