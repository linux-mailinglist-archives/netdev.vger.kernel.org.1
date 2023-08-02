Return-Path: <netdev+bounces-23516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0FD276C48A
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 07:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E75FE1C211CB
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 05:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDFFFEC5;
	Wed,  2 Aug 2023 05:04:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB1615AA
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 05:04:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26A01C433C8;
	Wed,  2 Aug 2023 05:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690952695;
	bh=20F4xPeEvNj9IuAftI9KVAMz4n8aQOzO8rp3P7fmGNc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o9z225Vuo0O0cdGOCNgMKn+dvOU5eE4KM84og9IwU8gxi8fE1GdcLi226AenlSZDC
	 vyN968CCLHAicKjG2npw9QyTqf5V/7QZu14QhJGEr4DkIVbWKR7qYIecWtVJzw1T7W
	 EnZjm9vb2bb4d/bdiRASxZ05afIqPnbs8yXhC0nYM0Bqua4+iLDZ9cA8LvkqcX7Vsn
	 nvgxRUpo8d1lo4C+hmsSlHKapcKTwO2CsB0UjWlgs+UD3Vz5T/i3qPzZGITD2F2V4M
	 J9k1qrzUxWHpKqpbPVEyzMjyozTZzMyYntlUSlqJqOkJYXnhkJgBP5a4azkS2YzVeZ
	 YeliueNUPZC5Q==
Date: Tue, 1 Aug 2023 23:05:59 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH 2/4][next] i40e: Replace one-element array with flex-array
 member in struct i40e_profile_segment
Message-ID: <52da391229a45fe3dbd5c43167cdb0701a17a361.1690938732.git.gustavoars@kernel.org>
References: <cover.1690938732.git.gustavoars@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1690938732.git.gustavoars@kernel.org>

One-element and zero-length arrays are deprecated. So, replace
one-element array in struct i40e_profile_segment with flexible-array
member.

This results in no differences in binary output.

Link: https://github.com/KSPP/linux/issues/335
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/net/ethernet/intel/i40e/i40e_type.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_type.h b/drivers/net/ethernet/intel/i40e/i40e_type.h
index c3d5fe12059a..f7a984304b65 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_type.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_type.h
@@ -1487,7 +1487,7 @@ struct i40e_profile_segment {
 	struct i40e_ddp_version version;
 	char name[I40E_DDP_NAME_SIZE];
 	u32 device_table_count;
-	struct i40e_device_id_entry device_table[1];
+	struct i40e_device_id_entry device_table[];
 };
 
 struct i40e_section_table {
-- 
2.34.1


