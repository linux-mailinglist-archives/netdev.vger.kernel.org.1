Return-Path: <netdev+bounces-44532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D157D876C
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 19:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 127B5281F90
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 17:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB1038BD8;
	Thu, 26 Oct 2023 17:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dHvoQu1U"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118C6156FA
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 17:17:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 233D2C433C8;
	Thu, 26 Oct 2023 17:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698340646;
	bh=IYv7ckSXIHomFlKV00BZVQ1yGlkJ2beREQcNt3zDRVc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dHvoQu1UlmF46AFzWTo+akFbYWGVbF1hdsl/BX11sJiebolkHxK2ffePGHFzNu4od
	 ASuMlX1Z5seL2K1lUTDkzAd25sfSDnASH9lKNolMBOAu7QykEgQQqEs9vGBoUgaa7g
	 MHjzVjaj5g06QdtRRe6o9zol7hMjMVtST6J6DtxWpXtTCGHJ+rQrdMIO3mSmJm11Km
	 XYaJ2Kk7JibIARfHE5VWs/yubzbNzw41+WA0GClnmokxxrfP35A1e/mSgSPgTyB9Q/
	 1WZug+PZVkv1RlkMpbkmmvsobR7oEptljS7MR13svBQ72edRTfMpO7zUTCv0nU3+Gn
	 relCIysZ3PuAg==
Message-ID: <c3921640-5a77-4ddc-a774-9fb40a110db3@kernel.org>
Date: Thu, 26 Oct 2023 11:17:25 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] inet: shrink struct flowi_common
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, wenxu <wenxu@ucloud.cn>
References: <20231025141037.3448203-1-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20231025141037.3448203-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/25/23 8:10 AM, Eric Dumazet wrote:
> I am looking at syzbot reports triggering kernel stack overflows
> involving a cascade of ipvlan devices.
> 
> We can save 8 bytes in struct flowi_common.
> 
> This patch alone will not fix the issue, but is a start.
> 
> Fixes: 24ba14406c5c ("route: Add multipath_hash in flowi_common to make user-define hash")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: wenxu <wenxu@ucloud.cn>
> ---
>  include/net/flow.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>


