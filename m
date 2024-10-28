Return-Path: <netdev+bounces-139726-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD54B9B3E89
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 00:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5869A1F232D2
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 23:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C61F1F9AB8;
	Mon, 28 Oct 2024 23:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="prgVaey4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DE61DEFF3;
	Mon, 28 Oct 2024 23:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730158557; cv=none; b=QdOzEXNYWdfAI+01YL+PS9/M7LG0xW3isrP8sZHMWb3TDDPrzZXmb1mS3k1y4+P/VVVXnsqS6YM84G0MXj7lA4lI7C40R1eW1Kx56zb/T+L/YOlUFM6c9z/wV8xyjUdqEp3EHZGCUrT7hPb5C18jeSVEv8V+H/EOEU6ZefhJmDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730158557; c=relaxed/simple;
	bh=W8pfZA6viHHs7pAzU1HH7Szrm0NhNriF9ySxCegfBKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eTmMgTycpNnPZQKtx0Q8pQ7WAlpTUoOaIWoNl11htUZMHalTenbez0nnUuuhao1zD7Hq60eVjWkPVdfdaF75Lgbe9Gaj40oO8hlsvDsH63hXCR7YNMCixMrShB8UoVK5GTS3fwfZpZNugFp0WMmcijyeGxisUib0zYzBkEMSdoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=prgVaey4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFB3FC4CEE4;
	Mon, 28 Oct 2024 23:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730158556;
	bh=W8pfZA6viHHs7pAzU1HH7Szrm0NhNriF9ySxCegfBKU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=prgVaey474iHPt6HYLMSg2uJPxffSYIyIZvoqws18LwgAOyM2w7xP8dnzqK0mpYyt
	 2SS9A5yjZIcn62mKMJc9vkfX2by1wXDsETO1LtO72QKZ4E/DF2HK2ETYS7y9GLea5J
	 SAOldJdTRA8fBh46bBLA5gLLg222gcFFK3lerTx3qyytVOP1llYDUo8CCovsAG42N/
	 RVZKlT43LETpa/eolyNkatl4rgz4Eb//Zla5rk/ChxPvxBQA83KboP8cZUej/d0g+n
	 lN5h/AaZGzV9cHdItsW76mgIncNEQAjJS4ImO6LY6aIeEdnrwhj8yQU1/PgZLioHbZ
	 JVBvTLAJupwoA==
Date: Mon, 28 Oct 2024 16:35:53 -0700
From: Kees Cook <kees@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Johannes Berg <johannes@sipsolutions.net>,
	David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH v2 3/4][next] uapi: net: arp: Avoid
 -Wflex-array-member-not-at-end warnings
Message-ID: <202410281635.3BC028D@keescook>
References: <cover.1729802213.git.gustavoars@kernel.org>
 <903f37962945fe0aa46e1d05c2a05f39571a53fa.1729802213.git.gustavoars@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <903f37962945fe0aa46e1d05c2a05f39571a53fa.1729802213.git.gustavoars@kernel.org>

On Thu, Oct 24, 2024 at 03:13:45PM -0600, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> Address the following warnings by changing the type of the middle struct
> members in a couple of composite structs, which are currently causing
> trouble, from `struct sockaddr` to `struct __kernel_sockaddr_legacy`.
> 
> include/uapi/linux/if_arp.h:118:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> include/uapi/linux/if_arp.h:119:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> include/uapi/linux/if_arp.h:121:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> include/uapi/linux/if_arp.h:126:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> include/uapi/linux/if_arp.h:127:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Also, refactor some related code, accordingly.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

