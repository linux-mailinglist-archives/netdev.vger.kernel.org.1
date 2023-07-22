Return-Path: <netdev+bounces-20079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C886475D8CC
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 03:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 073D12824F5
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 01:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60B163A1;
	Sat, 22 Jul 2023 01:42:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF346133
	for <netdev@vger.kernel.org>; Sat, 22 Jul 2023 01:42:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 967C3C433C9;
	Sat, 22 Jul 2023 01:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689990160;
	bh=tQ8pM3KeguzILdZfQdAhGqFxNs7UM7wcMkX0LuUWcaA=;
	h=From:To:Cc:Subject:Date:From;
	b=gLHNV16ihSev9WOKqusfLmGT9RZKZ971dhHdNRlpTG4b0XpiufKCc4JyBJnXaIBy+
	 HBTK+5DDQoIRyCUKDd+goU7QwPgHkp2UpoSV6m2JWWm2KUWmkvxSVjK8jWFDUyM+/Z
	 xvLy2m20ym4dcvZ1+6KauqbbxxpZZzytjB39fSCoVZvMnqp/+cZIhPkpBMnE4Nn2ZE
	 SFHTLoPum4zRIkL9AKKYyeEvB6c00qA20+tQ40ayeY2mhXhDNR/qBTV3uLitvklqjI
	 HjsrQ9AL9it0WdvaPdoa/lu1DKVlO4GQlRRsPygfrK87BdBH+8RNoivlLtV9b4jDYI
	 MO/wPCZoLtDDQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	mkubecek@suse.cz,
	lorenzo@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 0/2] net: store netdevs in an xarray
Date: Fri, 21 Jul 2023 18:42:35 -0700
Message-ID: <20230722014237.4078962-1-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

One of more annoying developer experience gaps we have in netlink
is iterating over netdevs. It's painful. Add an xarray to make
it trivial.

Jakub Kicinski (2):
  net: store netdevs in an xarray
  net: convert some netlink netdev iterators to depend on the xarray

 include/linux/netdevice.h   |  3 ++
 include/net/net_namespace.h |  4 +-
 net/core/dev.c              | 82 ++++++++++++++++++++++++-------------
 net/core/netdev-genl.c      | 37 ++++-------------
 net/ethtool/netlink.c       | 56 ++++++-------------------
 net/ethtool/tunnels.c       | 73 ++++++++++++---------------------
 6 files changed, 108 insertions(+), 147 deletions(-)

-- 
2.41.0


