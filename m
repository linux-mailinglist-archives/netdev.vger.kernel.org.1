Return-Path: <netdev+bounces-62707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C26828A3F
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 17:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5CD52881BF
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 16:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B970B3A8F1;
	Tue,  9 Jan 2024 16:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hdIPaf8S"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02AD3A294
	for <netdev@vger.kernel.org>; Tue,  9 Jan 2024 16:45:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E8E9C43390;
	Tue,  9 Jan 2024 16:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704818725;
	bh=sw6k7zADRODS6erdAlfREByAQRGc7rQRKFenjeofIz8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hdIPaf8SOtVvQX7pJEg35FQxToFmL+1ZF0+Nz28HrJSMTqYNxuY+zulmZdLC7yWGV
	 AEYkcH1lpPuTdw/xENhdNTY1q08uAuY0IUKvA8fWFk4EifBkxX61oK37NbZwVzyKxR
	 KkKv15yJbg04Osc44sl4qgpGEiVa3lqwB8Qcn1V6ZFV3Fh8I1jWUSWVw6/a4cpSRe5
	 NITgCW1QKOrd4t6oGHLJwwQkWlRA+sZyVWj0sAK8wPtNxsaT4QVPN6krsU7sMZDWOy
	 JJ1ohZ2u+trixcxop1Rrwlm/za/SP9z3ZMZyf0/zs8yHM9Vme9FjnIGueuc/loLDOP
	 49Er3EBhwtJAQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	Derek Chickles <dchickles@marvell.com>,
	Satanand Burla <sburla@marvell.com>,
	Felix Manlunas <fmanlunas@marvell.com>
Subject: [PATCH net 4/7] MAINTAINERS: eth: mark Cavium liquidio as an Orphan
Date: Tue,  9 Jan 2024 08:45:14 -0800
Message-ID: <20240109164517.3063131-5-kuba@kernel.org>
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

We haven't seen much review activity from the liquidio
maintainers for years. Reflect that reality in MAINTAINERS.
Our scripts report:

Subsystem CAVIUM LIQUIDIO NETWORK DRIVER
  Changes 30 / 87 (34%)
  Last activity: 2019-01-28
  Derek Chickles <dchickles@marvell.com>:
    Tags ac93e2fa8550 2019-01-28 00:00:00 1
  Satanand Burla <sburla@marvell.com>:
  Felix Manlunas <fmanlunas@marvell.com>:
    Tags ac93e2fa8550 2019-01-28 00:00:00 1
  Top reviewers:
    [5]: simon.horman@corigine.com
    [4]: keescook@chromium.org
    [4]: jiri@nvidia.com
  INACTIVE MAINTAINER Satanand Burla <sburla@marvell.com>

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: Derek Chickles <dchickles@marvell.com>
CC: Satanand Burla <sburla@marvell.com>
CC: Felix Manlunas <fmanlunas@marvell.com>
---
 MAINTAINERS | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index cad08f4eca0d..1e375699ebb7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4683,11 +4683,8 @@ F:	drivers/i2c/busses/i2c-octeon*
 F:	drivers/i2c/busses/i2c-thunderx*
 
 CAVIUM LIQUIDIO NETWORK DRIVER
-M:	Derek Chickles <dchickles@marvell.com>
-M:	Satanand Burla <sburla@marvell.com>
-M:	Felix Manlunas <fmanlunas@marvell.com>
 L:	netdev@vger.kernel.org
-S:	Supported
+S:	Orphan
 W:	http://www.marvell.com
 F:	drivers/net/ethernet/cavium/liquidio/
 
-- 
2.43.0


