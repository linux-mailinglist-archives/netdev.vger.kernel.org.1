Return-Path: <netdev+bounces-36253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D667AEAAA
	for <lists+netdev@lfdr.de>; Tue, 26 Sep 2023 12:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id A3A55281BA0
	for <lists+netdev@lfdr.de>; Tue, 26 Sep 2023 10:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2374241FC;
	Tue, 26 Sep 2023 10:45:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D4363AE
	for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 10:45:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C46EC433C8;
	Tue, 26 Sep 2023 10:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695725108;
	bh=Jr19cp7yaOhQeqgjjuOGhureNw6Qt3kSFYQrp6ys3gM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=dmpSq5h+4p12H+CMfVLWGr6ETOYNhl3F6Sk3hs5OTdZaCgxg9vXopsoT8+iBApq4X
	 BVCDUlNVkY5y4xOAwrLaE2L8WChSIa8aZpfpJTIbw0ABQVSgPZ0QP8Vh2QYOM4F98B
	 7M1FAFV4042aYxcHwDZllNMcsluHKgmogCVm9e9xvV3NJB+C54aIGl8no7cVXRq5DJ
	 vJNcXWYxkTDnNE0unGYbhe2eH2KRopax6YE61l8RGtt97NU5D1XTOdbvIpHP0f/hTW
	 /g5Z5Dkp080NoP6XJfXiFgb7SEDZ6bYBHex0spKL/7E4zCEaUVBnmvS4S8/6TZUZeD
	 WPfDzWJBCI2TA==
From: Kalle Valo <kvalo@kernel.org>
To: roynatech@gmail.com
Cc: johannes@sipsolutions.net,  davem@davemloft.net,  edumazet@google.com,
  kuba@kernel.org,  pabeni@redhat.com,  linux-wireless@vger.kernel.org,
  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mac80211: fix station hash table max_size config
 dependency
References: <20230923032834.9694-1-roynatech@gmail.com>
Date: Tue, 26 Sep 2023 13:47:08 +0300
In-Reply-To: <20230923032834.9694-1-roynatech@gmail.com>
	(roynatech@gmail.com's message of "Sat, 23 Sep 2023 03:28:34 +0000")
Message-ID: <87bkdpjjo3.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

roynatech@gmail.com writes:

> From: roynatech2544 <whiteshell2544@naver.com>
>
> Commit ebd82b3 ("mac80211: make station hash table max_size configurable") introduced config
> MAC80211_STA_HASH_MAX_SIZE, which is defined unconditionally even if MAC80211 is not set.
> It doesn't look like it is dependent of MAC80211_DEBUG_MENU either, as its only user is sta_info.c
> which is compiled unconditionally when MAC80211 != n. And without this config set somewhere, compile
> would error out.
>
> Make it depend on MAC80211 to correctly hide the config when MAC80211=n
>
> Fixes: ebd82b3 ("mac80211: make station hash table max_size configurable")

The commit id in fixes tag is too short, more info in the wiki link
below.

> Signed-off-by: roynatech2544 <whiteshell2544@naver.com>

Please use your full legal name, no pseudonyms please. See wiki.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

