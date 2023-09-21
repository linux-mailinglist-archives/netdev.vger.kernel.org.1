Return-Path: <netdev+bounces-35398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1287A9481
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 15:07:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4E841C20845
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 13:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1903B656;
	Thu, 21 Sep 2023 13:07:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE95B641;
	Thu, 21 Sep 2023 13:07:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C7A1C4E681;
	Thu, 21 Sep 2023 13:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695301645;
	bh=qyHw5bApCQu5BdpZyleyylD8P6jiSQ1K+rp1yYyvtMk=;
	h=Subject:From:To:Cc:Date:From;
	b=PPZa5YQpyP2JvrM0Raai8QOxGBXh85R3oFgOT0XMb/NQwEaahu9ah3QwUsGDFFSyG
	 2HJ760Ro/Jn9uqEcwuetjeex3Wdm9jXlWFIWpC8HIx4GcjDltWuaZR2GhrxEghbnWr
	 YEnF7FS44leWpScMexvqwNhJaxNbAhJmhIdJ/chkty5ppMxWKKv4iwJ2HjicAjdMMr
	 AvcNQN14pdi2XuWZogEtIFtVT53xlSk8X2hg2WDt6G2dQNvu6/KdCvjX/SGTeGVdgO
	 L22hDNAP3YF79kx1romkzHSdNEDTVfCVfNykY0hs12fQu16DTdIXyDz3zvjPL0qwSb
	 9l6GbzHGAnV0w==
Subject: [PATCH v2 0/2] Fix implicit sign conversions in handshake upcall
From: Chuck Lever <cel@kernel.org>
To: netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev
Cc: Chuck Lever <chuck.lever@oracle.com>
Date: Thu, 21 Sep 2023 09:07:14 -0400
Message-ID: 
 <169530154802.8905.2645661840284268222.stgit@oracle-102.nfsv4bat.org>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

An internal static analysis tool noticed some implicit sign
conversions for some of the arguments in the handshake upcall
protocol.

---

Chuck Lever (2):
      handshake: Fix sign of socket file descriptor fields
      handshake: Fix sign of key_serial_t fields

Changes since v1:
- Rebased on 581512a6dc93 ("vsock/virtio: MSG_ZEROCOPY flag support")

 Documentation/netlink/specs/handshake.yaml |  8 ++++----
 net/handshake/genl.c                       |  2 +-
 net/handshake/netlink.c                    |  2 +-
 net/handshake/tlshd.c                      |  6 +++---
 tools/net/ynl/generated/handshake-user.h   | 10 +++++-----
 5 files changed, 14 insertions(+), 14 deletions(-)

--
Chuck Lever


