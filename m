Return-Path: <netdev+bounces-58336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C12B4815E62
	for <lists+netdev@lfdr.de>; Sun, 17 Dec 2023 10:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ACD82837A5
	for <lists+netdev@lfdr.de>; Sun, 17 Dec 2023 09:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC651FB2;
	Sun, 17 Dec 2023 09:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j1Dt7ai7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CAB91FAD;
	Sun, 17 Dec 2023 09:45:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 563ABC433C7;
	Sun, 17 Dec 2023 09:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702806303;
	bh=SjfgyypNeosBVUqUNZsJw8cMhrT9jSZeCkrmvE4/Y+8=;
	h=From:Date:Subject:To:Cc:From;
	b=j1Dt7ai7IL2Mw9arRQR+7Xj5rc21ImNRqH50Z+YB0LWCDx2gs24JwSyjPVXoMDsnd
	 ac/Cz0gOQVsrvRElRAsWhEyoV+DU3ZI4lsxDPwDpSIsWF1m1nfRqLVQABOk9MokKlG
	 VPAFM962VT0d70+AcDa1UFx/Z3Wt46HbJVKN6kwKQClHzmLeZzx7NRbJoCKCCn3Tjm
	 J9unESeVGTj9nHvXsFumQhyLgD0i+YTxkPDAh7YMmw+GjqrgCNSZFnFznJNRa9lGnJ
	 xXqd7cYraSLZFx1+NgKLni537Evy9EGh6465noKcxCrvxAzoY0W5WvLS9EpIYQ1wKC
	 K4aCqc4Xj/esA==
From: Simon Horman <horms@kernel.org>
Date: Sun, 17 Dec 2023 09:44:50 +0000
Subject: [PATCH iwl-next] i40e: Avoid unnecessary use of comma operator
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231217-i40e-comma-v1-1-85c075eff237@kernel.org>
X-B4-Tracking: v=1; b=H4sIABHDfmUC/x3MQQqAIBBA0avIrBtIC6SuEi3UphooDY0SorsnL
 d/i/wcSRaYEvXgg0sWJgy+QlQC3Gr8Q8lQMqlaNVFIjtzWhC/tuULvWOqusmXQHJTgizZz/2QB
 8b+gpnzC+7wdEuNfSZgAAAA==
To: Jesse Brandeburg <jesse.brandeburg@intel.com>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 llvm@lists.linux.dev
X-Mailer: b4 0.12.3

Although it does not seem to have any untoward side-effects,
the use of ';' to separate to assignments seems more appropriate than ','.

Flagged by clang-17 -Wcomma

No functional change intended.
Compile tested only.

Signed-off-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 812d04747bd0..f542f2671957 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -1917,7 +1917,7 @@ int i40e_get_eeprom(struct net_device *netdev,
 			len = eeprom->len - (I40E_NVM_SECTOR_SIZE * i);
 			last = true;
 		}
-		offset = eeprom->offset + (I40E_NVM_SECTOR_SIZE * i),
+		offset = eeprom->offset + (I40E_NVM_SECTOR_SIZE * i);
 		ret_val = i40e_aq_read_nvm(hw, 0x0, offset, len,
 				(u8 *)eeprom_buff + (I40E_NVM_SECTOR_SIZE * i),
 				last, NULL);


