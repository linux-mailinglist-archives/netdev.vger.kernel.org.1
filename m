Return-Path: <netdev+bounces-62710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4589B828A44
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 17:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7DA1288397
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 16:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB403B295;
	Tue,  9 Jan 2024 16:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PMc5IywX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B727C3B292
	for <netdev@vger.kernel.org>; Tue,  9 Jan 2024 16:45:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6D2EC43141;
	Tue,  9 Jan 2024 16:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704818727;
	bh=/V60nWTTmAE8ey2q2ExJ4VhiITaM6caIycyRpm0cEoQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PMc5IywX2hwhD1L9Irmn5O2n4JT/5DSYAmSd8ptnHfXa0cvZhXfofL+um2AHk93FQ
	 brrBWhw9aa+U2BJflQQRF+DYraz+NKCQ+DEqdEw5WnIAewJShIoMYXEUtHR3deXzd/
	 TTgXDts3n6DqHTwKzCXDasVDvya4xR0lxzmSPAEVeY6RM9Az7u8S++LDopv0okVCxv
	 My53DE3csGHdwcnjFIrAhWUygxjrCG9lgoQHO1v9hv+ycU0BHVIBj9GWsCiQTNVtrV
	 MZbjfKjrnj7IiaQ1M1LHRI/6R49uuOXw5jACX2pOOTpTovMyxxGnU1c1r4Mk8HCtDC
	 vC5tI1Z0WvStw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	Haren Myneni <haren@linux.ibm.com>,
	Rick Lindsley <ricklind@linux.ibm.com>,
	Nick Child <nnac123@linux.ibm.com>,
	Thomas Falcon <tlfalcon@linux.ibm.com>
Subject: [PATCH net 7/7] MAINTAINERS: ibmvnic: drop Dany from reviewers
Date: Tue,  9 Jan 2024 08:45:17 -0800
Message-ID: <20240109164517.3063131-8-kuba@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240109164517.3063131-1-kuba@kernel.org>
References: <20240109164517.3063131-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I missed that Dany uses a different email address
when tagging patches (drt@linux.ibm.com)
and asked him if he's still actively working on ibmvnic.
He doesn't really fall under our removal criteria,
but he admitted that he already moved on to other projects.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: Haren Myneni <haren@linux.ibm.com>
CC: Rick Lindsley <ricklind@linux.ibm.com>
CC: Nick Child <nnac123@linux.ibm.com>
CC: Thomas Falcon <tlfalcon@linux.ibm.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c8636166740f..fee64589b180 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10115,7 +10115,6 @@ IBM Power SRIOV Virtual NIC Device Driver
 M:	Haren Myneni <haren@linux.ibm.com>
 M:	Rick Lindsley <ricklind@linux.ibm.com>
 R:	Nick Child <nnac123@linux.ibm.com>
-R:	Dany Madden <danymadden@us.ibm.com>
 R:	Thomas Falcon <tlfalcon@linux.ibm.com>
 L:	netdev@vger.kernel.org
 S:	Supported
-- 
2.43.0


