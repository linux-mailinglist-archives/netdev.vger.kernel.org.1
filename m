Return-Path: <netdev+bounces-155531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D0DA02E58
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 17:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EC301650FC
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 16:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0EC71DE3AB;
	Mon,  6 Jan 2025 16:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IeorpYK4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A68A3597E
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 16:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736182468; cv=none; b=bGd3GvkXbPQes33SC5l7RB1QeoyPWvoiNwbtCEWB1xMbhnOVp7X5FlYc6FvdnWsQL+lIdvumMZpnp1OcRIT36HnWNVqDjXhBhK7pd07wKFumfa9ZewUKjd4zu6nRsIylnJBim914qYLrFPsgjW/kPB6sdH4saKSBywFeXTOc6No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736182468; c=relaxed/simple;
	bh=kreSqX6CgEmQlKUY8IDUgjXX2lmJy8lT6ApmU7+CyHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tX6WrjLc4PRwX3Cm+jg/4zh3aPX68k63muoPG8fHTM745soq6EtfCt7Zp6olKG09YT2y0FJzg4+rJq3JDxnIketm/Q/nQdlUPtsI/3cNhogWtRH+TxmEt6aPIeMosUHrcInfWb/OMQ8Nv52/e9dcb07VVXJ3crrMAxa9ZN5A6Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IeorpYK4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3359C4CEDF;
	Mon,  6 Jan 2025 16:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736182468;
	bh=kreSqX6CgEmQlKUY8IDUgjXX2lmJy8lT6ApmU7+CyHg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IeorpYK438LaaRxOUvVCPyB6LRaWb4ABNX8rvF6VCCdkJFy5oxh6BDy4FbVyTurqa
	 //APzoWsYiE+WSTMVpME/NVraZ3QOA8jkHN5gRL05nRJF999yVlSa0YOLq4m9r+7po
	 N/VHrz69cP2Jmd9hKaQIBPirzjIqM1R8r4E/e21U1bTryggcxvfjqAuOjZ5CaG33uH
	 syKyK07aOZGBJbJmV7AkSZiryTd09K1xC1RZ8qzSW6hwnKJEbFeFs/MjhfCEM1MlD+
	 9MpXS3Zu/elo6DbV+a8FrCLxPoHuPxVoD5K4FQoqH8h32kgeV90y+3NkjVYuheouVe
	 f8Yknj9pihI+g==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	Jakub Kicinski <kuba@kernel.org>,
	jv@jvosburgh.net,
	andy@greyhouse.net
Subject: [PATCH net 3/8] MAINTAINERS: remove Andy Gospodarek from bonding
Date: Mon,  6 Jan 2025 08:53:59 -0800
Message-ID: <20250106165404.1832481-4-kuba@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250106165404.1832481-1-kuba@kernel.org>
References: <20250106165404.1832481-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Andy does not participate much in bonding reviews.

gitdm missingmaint says:

Subsystem BONDING DRIVER
  Changes 149 / 336 (44%)
  Last activity: 2024-09-05
  Jay Vosburgh <jv@jvosburgh.net>:
    Tags 68db604e16d5 2024-09-05 00:00:00 8
  Andy Gospodarek <andy@greyhouse.net>:
  Top reviewers:
    [65]: jay.vosburgh@canonical.com
    [23]: liuhangbin@gmail.com
    [16]: razor@blackwall.org
  INACTIVE MAINTAINER Andy Gospodarek <andy@greyhouse.net>

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: jv@jvosburgh.net
CC: andy@greyhouse.net
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 91b72e8d8661..7f22da12284c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4065,7 +4065,6 @@ F:	net/bluetooth/
 
 BONDING DRIVER
 M:	Jay Vosburgh <jv@jvosburgh.net>
-M:	Andy Gospodarek <andy@greyhouse.net>
 L:	netdev@vger.kernel.org
 S:	Maintained
 F:	Documentation/networking/bonding.rst
-- 
2.47.1


