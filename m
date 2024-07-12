Return-Path: <netdev+bounces-111041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D5D92F833
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 11:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AA011C21FC1
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 09:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3A715098E;
	Fri, 12 Jul 2024 09:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cXuMCsAa"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E971313D51E;
	Fri, 12 Jul 2024 09:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720777494; cv=none; b=TzwysmijXa9zp0rwGaTWBqr1SU6YhfwLU3tjz171tSQqCc/AvYsGjwxMmlqNdDnnTukJ4LFdZ6rzgzHg+AvRy9wfAGmj93O8gjdAAGOqgpEP/LEkhrXwU9BA6awOYS4tsEtggBOepSMU/onuH6oRXYs58qjMbos71KMUciR9ewg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720777494; c=relaxed/simple;
	bh=sQKpq1440VG+bHpu22o4DA2miwD/NHYAEoARj0gEpQw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WHkEp3AZfu6XAH9hp/BCh6Qrpd4OfJvelQu3s/xbuw0shiKNJroZtNBeQD4TZOo3KRLFQ86X2vHLKryb3oNQkeRfHmdYE75dsINz9LhWoMmrE3BM5cXZCjRpp6WsKRsIFDhFkja3tbo8ITRIi7Gfi0hRie+uBP0cXTOqEpfRsmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cXuMCsAa; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720777493; x=1752313493;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sQKpq1440VG+bHpu22o4DA2miwD/NHYAEoARj0gEpQw=;
  b=cXuMCsAa6l7o7CDQg9yN26kCmgamn4LjWvj7u9JdqnUXETpE9uWsPlf3
   oAQE8zppEjEvVX2zkSwfzZ05Sxtp1F54uu6hyAx0+9jw1420bBEEP9K6n
   6TcxqmrSumNqT1r8Bq5+rQTZIqI0Mu5kWTc253O2B86m/fVyVeR8s9LgB
   5DYVSTGkDaq8RRiJ65gpl5vLL9AdBHBoA5nhkhI9p+uplls+YQlkrnOG8
   PVs231x3gYPIyXjbBouvmezCjJkKEZEbe1fAdq4dUGFNSSv8RwABCxRS1
   F6fFMlcuvUFNCnUtUuXyuLBbN4dbtBidF7nvRVX1SHm1JFrfkTAnLQmwK
   Q==;
X-CSE-ConnectionGUID: vlmgwypwQfG3SPaL9o9QWg==
X-CSE-MsgGUID: Umi/3B9MSrGuDbhEtv/o7A==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="18076953"
X-IronPort-AV: E=Sophos;i="6.09,202,1716274800"; 
   d="scan'208";a="18076953"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2024 02:44:52 -0700
X-CSE-ConnectionGUID: OkcfGZRFSjyr9FwohQgC5Q==
X-CSE-MsgGUID: UEfdgnPOQ9yCOCtsSqkHBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,202,1716274800"; 
   d="scan'208";a="49524305"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa007.jf.intel.com with ESMTP; 12 Jul 2024 02:44:49 -0700
Received: from fedora.igk.intel.com (Metan_eth.igk.intel.com [10.123.220.124])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 410E412417;
	Fri, 12 Jul 2024 10:44:47 +0100 (IST)
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: apw@canonical.com,
	joe@perches.com,
	dwaipayanray1@gmail.com,
	lukas.bulwahn@gmail.com,
	akpm@linux-foundation.org,
	willemb@google.com,
	edumazet@google.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Simon Horman <horms@kernel.org>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Subject: [Intel-wired-lan] [PATCH iwl-next v2 1/6] checkpatch: don't complain on _Generic() use
Date: Fri, 12 Jul 2024 05:32:46 -0400
Message-Id: <20240712093251.18683-2-mateusz.polchlopek@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240712093251.18683-1-mateusz.polchlopek@intel.com>
References: <20240712093251.18683-1-mateusz.polchlopek@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Improve CamelCase recognition logic to avoid reporting on
 _Generic() use.

Other C keywords, such as _Bool, are intentionally omitted, as those
should be rather avoided in new source code.

Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
---
 scripts/checkpatch.pl | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 2b812210b412..c4a087d325d4 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -5840,6 +5840,8 @@ sub process {
 #CamelCase
 			if ($var !~ /^$Constant$/ &&
 			    $var =~ /[A-Z][a-z]|[a-z][A-Z]/ &&
+#Ignore C keywords
+			    $var !~ /^_Generic$/ &&
 #Ignore some autogenerated defines and enum values
 			    $var !~ /^(?:[A-Z]+_){1,5}[A-Z]{1,3}[a-z]/ &&
 #Ignore Page<foo> variants
-- 
2.38.1


