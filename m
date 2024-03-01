Return-Path: <netdev+bounces-76437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3633486DBCC
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 08:03:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E21EF281A94
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 07:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C89469306;
	Fri,  1 Mar 2024 07:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oRAD6tUM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4518464
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 07:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709276587; cv=none; b=SMQAqNzJC5TCmd3N/YxY7bsxOvL9NUAJkqAT2rjwS2B+UZ/SikgEmYo250XbrkQwD116FmLRohrcDTnfw10CEqUyC0uGzuKoFasTgTgkjgniFjl4tdwImYiz1xF8PeZ2XcgvrO8Id7mLs61/PMcwVGiszQrzTbKFbHmZ2tzdjsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709276587; c=relaxed/simple;
	bh=5WmlDNkYeMKnLcSIkP4v8rKpr9XupluTVCy4xLASi+0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aSkN367sGdmVQ7kJyQeK4ZDyti4Lguy8CNRQGHChHISAEb0Fuj5ehdAtnXEuA7fv0akZH/MHwv9LlSSUO0RMlkoQodhgIiWaEu1QTiC8adCphFbjBtMxTMEGTz8ebByOwsv/zN2ECqmIg++W/3PK+I2/kRfKI/71Is+sVnhhK1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oRAD6tUM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 378B7C433C7;
	Fri,  1 Mar 2024 07:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709276586;
	bh=5WmlDNkYeMKnLcSIkP4v8rKpr9XupluTVCy4xLASi+0=;
	h=From:To:Cc:Subject:Date:From;
	b=oRAD6tUMrARhLdBa3uyjmkfhm7OU9nbToqq16vkszJMpR+c1ZwOyVjX7g5dSJQy5i
	 sagyuDqd6NMtoWTpyzuueJl+0hngD9xH7slgId63rpVQWM1Bc1+xL8bQZ8KcRLxbNo
	 QskCCK7i4st5Ul6RVrl8yje27tJLGEITndaRU3MxjqQkSyu2d8lYvmk5NhFqt5JV95
	 l7oTqlXiBQNlBZN64JLZ262VqP+Sopn2hJxgtA2LAmxEaeHKhNEouG+XdtV4b2MoQc
	 NsQGEe9ra8SwANUAvxJC51WMn334b3Vajn5at7ZBXszXpq3nuSkQpo67pcyyJCISAZ
	 V/csbwOkijUpg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org,
	Jakub Kicinski <kuba@kernel.org>,
	jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com
Subject: [PATCH net-next] eth: igc: remove unused embedded struct net_device
Date: Thu, 29 Feb 2024 23:02:55 -0800
Message-ID: <20240301070255.3108375-1-kuba@kernel.org>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

struct net_device poll_dev in struct igc_q_vector was added
in one of the initial commits, but never used.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: jesse.brandeburg@intel.com
CC: anthony.l.nguyen@intel.com
---
 drivers/net/ethernet/intel/igc/igc.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index cfa6baccec55..90316dc58630 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -570,7 +570,6 @@ struct igc_q_vector {
 
 	struct rcu_head rcu;    /* to avoid race with update stats on free */
 	char name[IFNAMSIZ + 9];
-	struct net_device poll_dev;
 
 	/* for dynamic allocation of rings associated with this q_vector */
 	struct igc_ring ring[] ____cacheline_internodealigned_in_smp;
-- 
2.43.2


