Return-Path: <netdev+bounces-51712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD387FBD8B
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 15:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E017B20A8B
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 14:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7615C07A;
	Tue, 28 Nov 2023 14:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CeHVTmzL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAD25ABA6;
	Tue, 28 Nov 2023 14:59:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9995EC433C8;
	Tue, 28 Nov 2023 14:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701183558;
	bh=N3lECUyvXgqAdJlM/yuev49kTxv51GJ5+dkdngMrg8g=;
	h=From:To:Cc:Subject:Date:From;
	b=CeHVTmzLHdo8A0IMTe2aHsjsKbhZi2dc1wiIJ8H5twwlSrrzND/lUZfwDpo7466gg
	 Spb44TP2PDdfQswejZm6nBvRQQEnHJu1Gsd128nC9ynAIA0cRkAcKdZEeQGB/vUDk9
	 W24Z8ozVu3Y668OBlgrGACIPUDk27ZxYeg6FhK/jVJQ93ap63pcOCfe65QA5cRa/7D
	 IIms36jlL1i4ibTqhoegBTp3jR0lq2R/gfuWO0qVikSzpEF8tgOUIHGp9fMU9BduzK
	 dsVM5U4Mv3eXsBtWp+l7M2pFsDThivgxGCCYd0OdcQPdDBAoyWFwZaQnxGGsEtSs4I
	 +ndDfHxEoTU2Q==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	nogikh@google.com,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	v9fs@lists.linux.dev
Subject: [PATCH net] MAINTAINERS: exclude 9p from networking
Date: Tue, 28 Nov 2023 06:59:15 -0800
Message-ID: <20231128145916.2475659-1-kuba@kernel.org>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We don't have much to say about 9p, even tho it lives under net/.
Avoid CCing netdev.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: Eric Van Hensbergen <ericvh@kernel.org>
CC: Latchesar Ionkov <lucho@ionkov.net>
CC: Dominique Martinet <asmadeus@codewreck.org>
CC: Christian Schoenebeck <linux_oss@crudebyte.com>
CC: v9fs@lists.linux.dev
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 509281e9e169..87d6cc3db4b1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15068,6 +15068,7 @@ F:	lib/random32.c
 F:	net/
 F:	tools/net/
 F:	tools/testing/selftests/net/
+X:	net/9p/
 X:	net/bluetooth/
 
 NETWORKING [IPSEC]
-- 
2.42.0


