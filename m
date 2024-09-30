Return-Path: <netdev+bounces-130387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F305098A5A1
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 15:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35EF1B25284
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 13:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28AE4190059;
	Mon, 30 Sep 2024 13:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b9g4YVpm"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827C518F2FD;
	Mon, 30 Sep 2024 13:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727703554; cv=none; b=pAsmAYSVPnyKf8vDxqIPPrBQaQevd1RsMJnbONcmB2EVAWN+NWxilP5PW2ISQdBxfDHtnEmpEDOfktAnSQTf6W3qePqHQSlzEMEPKmaoaTs/zkjlJ77j1Ukbkn9AcbQnfonh6G6rqxRMpDdrh6Yv/USMPnRB1DLnHq2XixbuII4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727703554; c=relaxed/simple;
	bh=NJhYW5MdDUlRWkUHgJpWUneYsgOxetOfQxKhtwQwTQM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KUbixWrkMSgtg/X1lZXt+qohA7vbEwMg+h0LY49SzcS6+6exkqdYLwzTAzUCMNeUtD6WYH/XVlkcsm3sJAKMjbineqQ6RfISt1ZUyL7aGD904Xw9wgjOEyyUtM4nblc6ObGmcZ64/qodIO84BMGG9FVR5PFCpze4XULxPrqHdj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b9g4YVpm; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727703553; x=1759239553;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NJhYW5MdDUlRWkUHgJpWUneYsgOxetOfQxKhtwQwTQM=;
  b=b9g4YVpm++hDKruwsIgbGuHNNqSar8vWt9EdSGVzL3mgcdakIRIXHfow
   fqKU1/2GfTw7Ja0z1G/zrhsW2AA1zZRXWzSkXbTBNOGJBS50EJy8NuXqh
   RWZnKvrQ3XBIWHQojKYXgRPjOjkHusnvdqYP+UjEQIMmOkq95rU3H7220
   h9+QwMQjiEmbTWbW3N23DN1EfTZh/oEx/mO2mqxaiemkGjY0+s5TEfj35
   wDFUdcutReN/mhLOIf0f/HjefzYB9erVf8cyWOE5lz9L7GBqyfI3UsgzU
   sjk7l7RYWcfa0bhnCqm4/umQkv+pCE0vS/OT5+o+PC74Zk6DOpZpdpYyS
   A==;
X-CSE-ConnectionGUID: gLHIfwWgSLGUmYRrK654qA==
X-CSE-MsgGUID: Q52CtxV0QRyFKlW48qEpSw==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="44312445"
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="44312445"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 06:39:12 -0700
X-CSE-ConnectionGUID: GUG5EYWxQRmBQUp42l996A==
X-CSE-MsgGUID: ZQb5fdVFRLCzfhXG7NFVag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="77831847"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa004.fm.intel.com with ESMTP; 30 Sep 2024 06:39:09 -0700
Received: from vecna.igk.intel.com (vecna.igk.intel.com [10.123.220.17])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 673E328169;
	Mon, 30 Sep 2024 14:39:07 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: netdev@vger.kernel.org,
	Andy Whitcroft <apw@canonical.com>,
	Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	linux-kernel@vger.kernel.org,
	Jiri Pirko <jiri@resnulli.us>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Subject: [PATCH 1/7] checkpatch: don't complain on _Generic() use
Date: Mon, 30 Sep 2024 15:37:18 +0200
Message-Id: <20240930133724.610512-2-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240930133724.610512-1-przemyslaw.kitszel@intel.com>
References: <20240930133724.610512-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Improve CamelCase recognition logic to avoid reporting on
 _Generic() use.

Other C keywords, such as _Bool, are intentionally omitted, as those
should be rather avoided in new source code.

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 scripts/checkpatch.pl | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 4427572b2477..29b510ddd83c 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -5848,6 +5848,8 @@ sub process {
 #CamelCase
 			if ($var !~ /^$Constant$/ &&
 			    $var =~ /[A-Z][a-z]|[a-z][A-Z]/ &&
+#Ignore C keywords
+			    $var !~ /^_Generic$/ &&
 #Ignore some autogenerated defines and enum values
 			    $var !~ /^(?:[A-Z]+_){1,5}[A-Z]{1,3}[a-z]/ &&
 #Ignore Page<foo> variants
-- 
2.39.3


