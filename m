Return-Path: <netdev+bounces-21623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92DD17640F0
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 23:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D92328107D
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 21:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA9E1BEFE;
	Wed, 26 Jul 2023 21:09:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64D81BEF1
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 21:09:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35B81C433C8;
	Wed, 26 Jul 2023 21:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690405782;
	bh=mQq2biQR8y/tg4kRgcCOfzcSSkHg/EcJfyRdllIr2Dw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=q2WEOM/u+/oCPrSFPnLa4UHb4aJvm4hmjv9nhsX0a+3vzR36n9Jp9vthDyDTD0fxb
	 idZsn10T5hnManAZqEN+Y5usaVp7wqFLiac1wvBOv4NgsA2TqrbPlgAboCK7uRe1VL
	 E0bn6Y0ZLo46/rD8yZkV2X8ocs3S1Og6DvR6DttZ9cKvWLymrjzzgLuOSmgNHs90Ws
	 FC7l2oL1mugg17LKUUIuemhVB+a0L+nnJ04vLkn3+Lg161qR54Dt+LJVarv8dPVQUb
	 E/2aRMy9JmziCPcChFp6ohmTiXFPmKHzkQJ3QHCSx3MSoWb6aMvsVPfqcpT7tIaU+B
	 nZTZv3Px9efLA==
Date: Wed, 26 Jul 2023 14:09:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 donald.hunter@redhat.com
Subject: Re: [PATCH net-next v1 1/3] doc/netlink: Add a schema for
 netlink-raw families
Message-ID: <20230726140941.2ef8f870@kernel.org>
In-Reply-To: <20230725162205.27526-2-donald.hunter@gmail.com>
References: <20230725162205.27526-1-donald.hunter@gmail.com>
	<20230725162205.27526-2-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Jul 2023 17:22:03 +0100 Donald Hunter wrote:
>  - add an id property to mcast-group definitions

nit: my first thought would be to call it "value" rather than "id"
to stick with the naming we have to other objects. Any pros/cons
you see?

Other than that the big ask would be to update the documentation :)

