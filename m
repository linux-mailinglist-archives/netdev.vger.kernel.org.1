Return-Path: <netdev+bounces-62703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C586C828A3B
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 17:45:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C7181F25F6A
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 16:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D96138DF8;
	Tue,  9 Jan 2024 16:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LV9c5H65"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B951E4AF
	for <netdev@vger.kernel.org>; Tue,  9 Jan 2024 16:45:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0F1CC433C7;
	Tue,  9 Jan 2024 16:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704818723;
	bh=k/bv/wD6UeWlCVWnNLzECDE+ReJGMW1smBmYoFub2zs=;
	h=From:To:Cc:Subject:Date:From;
	b=LV9c5H65Ho1vHvWM/oByB9VdwTpg4eHQCfacx65Z2dSRMRUJ9cd1quBO4LH4SgX+5
	 30by7NYIYZ0wIVtRiAvUxnOCOkd8XQGfKuiO2ggXGJFhHfjBdnVGboblxkBniL8K6L
	 iNyLn6eBHuwDKzpd1YfDS0PYOOKA/gMrKe15zktBtouQh9Ln3+6ZPIigjULG4bNw8+
	 zDWhvCsMcYvKLMJ5ovNRhSP/HwtF7VhSNhnkAPJ0B/eEOvHCY3cdviguFL6qoRg5Wc
	 IjZcAN7LHH3x3YoBB86V2UbMEXfgvQYsZEaMgM/xBGdskrx2pXv7piGXC57JEkeTLo
	 LUbaFP+9MUsGA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net 0/7] Networking MAINTAINERS spring 2024 cleanup
Date: Tue,  9 Jan 2024 08:45:10 -0800
Message-ID: <20240109164517.3063131-1-kuba@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Starting in 2021 we had been using Jon Corbet's gitdm scripts
to find maintainers missing in action [1]. The scripts analyze
the last 5 years of git history, locate subsystems which
were touched by more than 50 commits, and generate simple
review statistics for each maintainer. We then query the stats
to find maintainers who haven't provided a single tag.

[1] https://lwn.net/Articles/842422/

This series removes folks from Networking who haven't been active
in recent history. This helps shorten the CC lists on patches, and
generally makes MAINTAINERS "reflect reality" more closely.
Moving folks to CREDITS is in no way disparaging their work
as maintainers, we'd be happy to restore them as maintainers
if/when they plan to become active again!

Jakub Kicinski (7):
  MAINTAINERS: eth: mtk: move John to CREDITS
  MAINTAINERS: eth: mt7530: move Landen Chao to CREDITS
  MAINTAINERS: eth: mvneta: move Thomas to CREDITS
  MAINTAINERS: eth: mark Cavium liquidio as an Orphan
  MAINTAINERS: Bluetooth: retire Johan (for now?)
  MAINTAINERS: mark ax25 as Orphan
  MAINTAINERS: ibmvnic: drop Dany from reviewers

 CREDITS     | 17 +++++++++++++++++
 MAINTAINERS | 15 +++------------
 2 files changed, 20 insertions(+), 12 deletions(-)

-- 
2.43.0


