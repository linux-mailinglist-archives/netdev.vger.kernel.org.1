Return-Path: <netdev+bounces-39437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF3F37BF36D
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 08:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A85AE281941
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 06:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8139469;
	Tue, 10 Oct 2023 06:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eGoBSQjb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEBE1C29
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 06:57:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4F33C433C8;
	Tue, 10 Oct 2023 06:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696921066;
	bh=TIRu023yRiAn4rr+cVhgd1+H6BjEpKUsZCa1Z/im/zU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=eGoBSQjbQGUMyzFoSyJfbtWDcVCfyhQnmnKf1C58Cre/eyW9BSnD1X6qSu/KgVJwL
	 CuYTKv2kCCa/5qmXQbltfB84K7Unkx/9oqPkHAPg5Z0oBf5wR37XihttMeMlOURRG8
	 kwJZGqR6MiCd1iGkpJKvNhEOu+K+bXFXuFq0EnrDNmI4A2LARuG2NdYTNOM+b+LVnc
	 5odic9AdqSNJmPmuZXRI7x45Hqpr1a0zO2bKcnHLNeukJb1hP/kD9ki84d+4yGPTv0
	 6+J0ED+5upIMUz86XpvNNUrcxSzl3TFpGDrnqqrVCuTGs38IM3SEtR6Cbqm1V3eP3T
	 WL3uvlp4W9nIA==
From: Kalle Valo <kvalo@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>,  netdev@vger.kernel.org,  Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>,
  linux-wireless@vger.kernel.org,  Johannes Berg
 <johannes@sipsolutions.net>,  linux-wpan@vger.kernel.org,  Michael
 Hennerich <michael.hennerich@analog.com>,  Paolo Abeni
 <pabeni@redhat.com>,  Eric Dumazet <edumazet@google.com>,  "David S .
 Miller" <davem@davemloft.net>,  linux-kernel@vger.kernel.org,  Doug Brown
 <doug@schmorgal.com>,  Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 09/10] wireless: hostap: remove unused ioctl function
References: <20231009141908.1767241-1-arnd@kernel.org>
	<20231009141908.1767241-9-arnd@kernel.org>
Date: Tue, 10 Oct 2023 10:00:12 +0300
In-Reply-To: <20231009141908.1767241-9-arnd@kernel.org> (Arnd Bergmann's
	message of "Mon, 9 Oct 2023 16:19:07 +0200")
Message-ID: <87v8bfezcz.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Arnd Bergmann <arnd@kernel.org> writes:

> From: Arnd Bergmann <arnd@arndb.de>
>
> The ioctl handler has no actual callers in the kernel and is useless.
> All the functionality should be reachable through the regualar interfaces.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

In the title we prefer "wifi:" over "wireless:" but that's nitpicking. I
assume this goes via a net tree so:

Acked-by: Kalle Valo <kvalo@kernel.org>

Let me know if I should take this to wireless-next instead.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

