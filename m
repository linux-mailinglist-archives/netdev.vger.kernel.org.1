Return-Path: <netdev+bounces-20890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9FBF761C36
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 16:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63850280EF5
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 14:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E1521D4B;
	Tue, 25 Jul 2023 14:47:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0241E1549F;
	Tue, 25 Jul 2023 14:47:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA407C433C7;
	Tue, 25 Jul 2023 14:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690296439;
	bh=Bo0L8NVAyrHOgGQCPLhEipmIw8MhpD2MSjL5nHcNdsA=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=aTwLe2S/soCzZmmI2FjM24eQj/SpC2A5oY2AfGtxo+LczogipNM3KYOe7h0nzUYeM
	 NIt6FPH2RkGimz1HDPBKdPgQkDOpCXPe5VN3kQ3+K7qEUIwIG7yQoe7NRPBOdEJwFm
	 df9A9JRMsNSOZL0kqy17+5K7UXuXE3nJw0fJgBX+1Sz6DsnBHJur54LkX482WxRepE
	 avfYJ9V0FqigXslCrZr5ruo35nt0QMfyuAFaS/e/R2BwcKVLfoBZ+X4eCdilR2aqHy
	 0b7nt/cbddP5/Rbdv4lPFddDYWsIeNPAjVfLqAox5XCTzPDvnpePEHVRHlBmjCOVgZ
	 1c7g/pXq5OdlQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [3/8] wifi: zd1211rw: fix typo "tranmits"
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230622012627.15050-4-shamrocklee@posteo.net>
References: <20230622012627.15050-4-shamrocklee@posteo.net>
To: Yueh-Shun Li <shamrocklee@posteo.net>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 "David S . Miller" <davem@davemloft.net>,
 "James E . J . Bottomley" <jejb@linux.ibm.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, linux-scsi@vger.kernel.org,
 mptcp@lists.linux.dev, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yueh-Shun Li <shamrocklee@posteo.net>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169029643392.3309254.342001893123754863.kvalo@kernel.org>
Date: Tue, 25 Jul 2023 14:47:15 +0000 (UTC)

Yueh-Shun Li <shamrocklee@posteo.net> wrote:

> Spell "transmits" properly.
> 
> Found by searching for keyword "tranm".
> 
> Signed-off-by: Yueh-Shun Li <shamrocklee@posteo.net>

Patch applied to wireless-next.git, thanks.

2d5947830868 wifi: zd1211rw: fix typo "tranmits"

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230622012627.15050-4-shamrocklee@posteo.net/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


