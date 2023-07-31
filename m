Return-Path: <netdev+bounces-22808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D5E76950A
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 13:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 680972811A2
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 11:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89AA61801D;
	Mon, 31 Jul 2023 11:38:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40393182A0
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 11:38:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 075F5C433C7;
	Mon, 31 Jul 2023 11:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690803516;
	bh=Ud+g0fFvXQbb6PMgns2B8bYis70PDAJeRhBx4+CZSiU=;
	h=From:To:Cc:Subject:Date:From;
	b=G1kBlFN2xjE8658uHbIL41pmXa9EWuz/USFSfdAApeoCuprWellimYbT5JY+EITwg
	 35WoR3aQgIknXiWmQNKjeYacTuPzDyLV+bIJy9NtxtzXS5vmHH/gpWvRyl4fdjWOLR
	 mZ0v627K+C0cb9IRMmNbsRMJef0r//VVkTaZpc85OrEyt9qMxRo1O6LkiG40LbwaRL
	 PB2HTyRDM4R8cURVxZqBZQ4aJB8H6JHtxznW1KBtK5fyq2bT50Xx5h3LZZGt2WtAjF
	 3e8woC05/UqLJYeJBsQ9qbT4KLuI9BOREb7ey2fxWWr0I9gboY4vhnVwEsY3x45dpO
	 NltLvJh51hrMw==
From: Leon Romanovsky <leon@kernel.org>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Raed Salem <raeds@nvidia.com>
Subject: [PATCH ipsec-rc 0/2] Two fixes in policy/state offload area
Date: Mon, 31 Jul 2023 14:38:25 +0300
Message-ID: <cover.1690803052.git.leon@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

Hi,

These two patches fixes leaks of HW objects in IPsec packet offload mode.

Thanks

Leon Romanovsky (2):
  xfrm: delete offloaded policy
  xfrm: don't skip free of empty state in acquire policy

 include/net/xfrm.h    | 1 +
 net/xfrm/xfrm_state.c | 8 ++------
 net/xfrm/xfrm_user.c  | 1 +
 3 files changed, 4 insertions(+), 6 deletions(-)

-- 
2.41.0


