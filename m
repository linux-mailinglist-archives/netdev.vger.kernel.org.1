Return-Path: <netdev+bounces-40959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A4A77C930A
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 08:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8060A282CCF
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 06:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523EA5236;
	Sat, 14 Oct 2023 06:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IFrC+uuA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC091C27;
	Sat, 14 Oct 2023 06:42:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7893DC433C8;
	Sat, 14 Oct 2023 06:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697265725;
	bh=Pvnp6ClDU4xAPFz+GWQJRLH4Q1XIrlzcHFNtXw92fUQ=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=IFrC+uuAlTszbKfHKFobiZGt35OWBZvGIonkyj/r68qF6fQ4z4aH3+ZHBwyT6DQKs
	 ELO4kjrrSll4lLcK9w56nn+NB7JrCGdQvbIJANYfbesEssGtFyCZ+tdDXiRLEuPNJq
	 NWwxEif8pM/z0It850p4If9P7PDrKK+caiQZm8Ke206qqfEU7zRXLr3O/dR9Rv3TjV
	 4E2UvmNu6xmMx5QDGnwzGOQOVNAsLbl/6xTKRmXaPgBolYcIOLnZEWONO1c4eYjN+/
	 1/nv6HMX+Fjtz2RfLiUGcLbZCxDtcsa6TkxLpQqA2KQc3slwOjmr8G4QkwkmDherTt
	 49buWmwGgjxzw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 08/10] wifi: atmel: remove unused ioctl function
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231011140225.253106-8-arnd@kernel.org>
References: <20231011140225.253106-8-arnd@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-wireless@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>,
 linux-wpan@vger.kernel.org, Michael Hennerich <michael.hennerich@analog.com>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 "David S . Miller" <davem@davemloft.net>, Rodolfo Zitellini <rwz@xhero.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169726572036.3637479.12619977038667266484.kvalo@kernel.org>
Date: Sat, 14 Oct 2023 06:42:02 +0000 (UTC)

Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> This function has no callers, and for the past 20 years, the request_firmware
> interface has been in place instead of the custom firmware loader.
> 
> Acked-by: Kalle Valo <kvalo@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

2 patches applied to wireless-next.git, thanks.

166ab7ca3418 wifi: atmel: remove unused ioctl function
f35ccb65bd18 wifi: hostap: remove unused ioctl function

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231011140225.253106-8-arnd@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


