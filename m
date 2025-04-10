Return-Path: <netdev+bounces-181219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B56A84222
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 13:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0E308A1C74
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 11:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA397283CB5;
	Thu, 10 Apr 2025 11:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kzIQN42V"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11778283C8D;
	Thu, 10 Apr 2025 11:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744285967; cv=none; b=Y4xrcOI39f9/rOgdLF66OLaAJ/jhlKaBC+8rc/onEnf9lXGN7jqiu2yEYJFfQBOnk2Y48aUZ9zlxNFHuvEzhuTN0eEnLcoUvynvXGImSLoC/ujVvC+/j6k5/FgaqxCXddvHHOHL64BwpL3WwBw/6b9os+TF/KHwi5LFSp561LLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744285967; c=relaxed/simple;
	bh=XFQzoxeqsD9v2JOgNHZGxnrAw6ddmJkdJnpFrk0ivkc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jjKjC+dCocSVqUAzbymmLTmcZulW+dzxlVh4F5sGuYaLDubB9km0w7/my2X8SEJy1eJV0OLcIODIO2yjmCR1t6NuT12ndaZK2gj3HG6jZvyR4xT4XdvzLnJvSxi5Il5lyLFPq9uDO0pmZnebdZzQHdJ/oWnc+zTbbnd+ZFYTmls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kzIQN42V; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744285966; x=1775821966;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XFQzoxeqsD9v2JOgNHZGxnrAw6ddmJkdJnpFrk0ivkc=;
  b=kzIQN42VhE/Xi1pJ6obatowS7swlN1klI34zELPWlrQiop9JKhMr938R
   e5KMlYWGpRpuM0cmy2GX4q9sfKO1Ok1wGJFOu5QAFFblETgBezGGVPqCY
   hGglyNUhF1JAaHpfimgczG+ZDTwvPjUJwHzXz6Lw+qAWuV9vnByQir6Mk
   0SzplkFR4dxjpOFN9seqEQweBkCJk2GjHlffWP49ACbufVsJWDAyyHQP0
   ZVSmDG7NdyuUEq+NACaIRC040LtxOP7FvvCPwJpByxY3LRXW3f+4cJNHx
   t6xFXwzGlW5hHXe5/LeIycPyBy/3dJCe3QsDj+Zx2ZFCN2COwlzdg82MN
   w==;
X-CSE-ConnectionGUID: wDmMDZ9qSjetr6XI3mmoyg==
X-CSE-MsgGUID: Luch5LP9R3iBu76uXtxXZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="44939952"
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="44939952"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 04:52:42 -0700
X-CSE-ConnectionGUID: YHA03Bs4SNi8jD6bPNuJYQ==
X-CSE-MsgGUID: q617/JOcRmiqox68+dv2oQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="129731691"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa009.fm.intel.com with ESMTP; 10 Apr 2025 04:52:39 -0700
Received: from mglak.igk.intel.com (mglak.igk.intel.com [10.237.112.146])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id DD87C34312;
	Thu, 10 Apr 2025 12:52:37 +0100 (IST)
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Larysa Zaremba <larysa.zaremba@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Emil Tantilov <emil.s.tantilov@intel.com>,
	Madhu Chittim <madhu.chittim@intel.com>,
	Josh Hay <joshua.a.hay@intel.com>,
	Michal Kubiak <michal.kubiak@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH iwl-net] idpf: protect shutdown from reset
Date: Thu, 10 Apr 2025 13:52:23 +0200
Message-ID: <20250410115225.59462-1-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before the referenced commit, the shutdown just called idpf_remove(),
this way IDPF_REMOVE_IN_PROG was protecting us from the serv_task
rescheduling reset. Without this flag set the shutdown process is
vulnerable to HW reset or any other triggering conditions (such as
default mailbox being destroyed).

When one of conditions checked in idpf_service_task becomes true,
vc_event_task can be rescheduled during shutdown, this leads to accessing
freed memory e.g. idpf_req_rel_vector_indexes() trying to read
vport->q_vector_idxs. This in turn causes the system to become defunct
during e.g. systemctl kexec.

Considering using IDPF_REMOVE_IN_PROG would lead to more heavy shutdown
process, instead just cancel the serv_task before cancelling
adapter->serv_task before cancelling adapter->vc_event_task to ensure that
reset will not be scheduled while we are doing a shutdown.

Fixes: 4c9106f4906a ("idpf: fix adapter NULL pointer dereference on reboot")
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_main.c b/drivers/net/ethernet/intel/idpf/idpf_main.c
index bec4a02c5373..b35713036a54 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_main.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_main.c
@@ -89,6 +89,7 @@ static void idpf_shutdown(struct pci_dev *pdev)
 {
 	struct idpf_adapter *adapter = pci_get_drvdata(pdev);
 
+	cancel_delayed_work_sync(&adapter->serv_task);
 	cancel_delayed_work_sync(&adapter->vc_event_task);
 	idpf_vc_core_deinit(adapter);
 	idpf_deinit_dflt_mbx(adapter);
-- 
2.47.0


