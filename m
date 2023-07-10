Return-Path: <netdev+bounces-16532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E301E74DB61
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 18:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FCE6280C19
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 16:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B74912B80;
	Mon, 10 Jul 2023 16:46:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B520125CA
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 16:46:12 +0000 (UTC)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4910C1A5
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 09:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689007570; x=1720543570;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pCrTvDY/RaS3ShNY7SD4RERRfOHhU5YnRHyfAY7yZjw=;
  b=ALwQjI4OOQB8lBiagQ/SNuSqSJRWjJ2wFI7Ib8rnM51om+5Tf0FGxa9K
   Zl928V9CKLLN762mnaREwh8AaIW3m1s/jdo4IuJ2YXnmfwFqunAcNplvc
   CsJfdKc+YxAxj3VpjKoqaRKBkertAIGa35NU0W/XrQH5mosnhInl5aYfQ
   W3+a1CukRuq6aHzV8nDufD4x8q5mMWXqYLSbvOcOdS6JVyphYJBwcdqAJ
   Nv+wz4Me/GK6UEtURScsj5v6iwtoGWHXAxt4lEHilYilTEhnvtNPcmoV2
   jlLbDuup+pny0bJ7BzgZy0GUJid3fIxlUoN0OPBIDsJ0zDiSm8nNAfkc6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="349198563"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="349198563"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 09:46:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="720755268"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="720755268"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga002.jf.intel.com with ESMTP; 10 Jul 2023 09:46:08 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net-next 0/2][pull request] Intel Wired LAN Driver Updates 2023-07-10 (i40e)
Date: Mon, 10 Jul 2023 09:40:28 -0700
Message-Id: <20230710164030.2821326-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This series contains updates to i40e driver only.

Ivan Vecera adds waiting for VF to complete initialization on VF related
configuration callbacks.

The following are changes since commit 6843306689aff3aea608e4d2630b2a5a0137f827:
  Merge tag 'net-6.5-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 40GbE

Ivan Vecera (2):
  i40e: Add helper for VF inited state check with timeout
  i40e: Wait for pending VF reset in VF set callbacks

 .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 63 +++++++++++--------
 1 file changed, 36 insertions(+), 27 deletions(-)

-- 
2.38.1


