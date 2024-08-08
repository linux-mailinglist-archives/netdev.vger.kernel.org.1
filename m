Return-Path: <netdev+bounces-116801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3F694BC35
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 13:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F62E2818BD
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 11:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7DD18B475;
	Thu,  8 Aug 2024 11:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IWVlWqkk"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A85146018;
	Thu,  8 Aug 2024 11:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723116285; cv=none; b=FM5sIVqNk/91eKjwudmaXXU28DrdRQva1ApOL8L4cCs4qnepTW6B6SQqi8vpmX4WxK1nQ/hA8RazuL2RzhB5wM55HQFlTT6UTfgEG3PRxDbCiDuJBBQMol9i3BhOU6IyAttltG4QwXfwq5EsTLXVbiCI69vmaeXuEM2ibM0atIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723116285; c=relaxed/simple;
	bh=FKhwymwtQp+7MFj4s4zUBHDLdUOsp81sRosDZ+m3lZI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rNFaFgezkJXF8PAQ11OI2kKdzbt07F9j79hgnHlCq7puVTqhhoQ0XXNvp0nWiTnrXtvqppA/FAm/4iC2b3Fkb2GNNzq5lYgF0TuJKdEUTweUFehbBfL3O87US5lYOcWm46VzY2pBsljDUSBtiq8CaNil3VcNKc6IxPecNydpyKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IWVlWqkk; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723116284; x=1754652284;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FKhwymwtQp+7MFj4s4zUBHDLdUOsp81sRosDZ+m3lZI=;
  b=IWVlWqkkgzVT9lF+zmJYta9uzPDii+yUL8FncUfyh8Y+aW3nOSHjNoJ0
   G4gZpJIJuAfRev+73NrfNAlbd8H14OlOpH6nFzVRAg2QvxJYU0DD6+N9/
   abkpwrkInu2HescxGAF0urCSInfHP35wscVX55J7N8lLtyYn206uM85Bj
   DlAazRSxwK4J+oRJAI3d65TKqa7cDzfTHkN6RAxHFegnrSHVsImKoGnQ8
   M0RC4whZcHVL7vNdDPRTmF9UeY8pUQb1CpLrVmN7VVuJwwqwuC3HCqr05
   ksiDyas5doG0HofeAeOleNQksCQ+S3Qj15jTkyH23OmQF6LeaCYB7tD5a
   A==;
X-CSE-ConnectionGUID: 8IxoP77lRBWyVZZcLxLM8Q==
X-CSE-MsgGUID: 1Ma6C4DqRKWh5LGZVCy1Pg==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="38741850"
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; 
   d="scan'208";a="38741850"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 04:24:43 -0700
X-CSE-ConnectionGUID: I76V1HI1Q3OWX6GvvAJODw==
X-CSE-MsgGUID: 9Nb0zhylSnaniygqY41l2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; 
   d="scan'208";a="61574899"
Received: from amlin-018-114.igk.intel.com ([10.102.18.114])
  by fmviesa005.fm.intel.com with ESMTP; 08 Aug 2024 04:24:39 -0700
From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
To: netdev@vger.kernel.org
Cc: vadim.fedorenko@linux.dev,
	jiri@resnulli.us,
	corbet@lwn.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	donald.hunter@gmail.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	intel-wired-lan@lists.osuosl.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: [PATCH net-next v1 0/2] Add Embedded SYNC feature for a dpll's pin
Date: Thu,  8 Aug 2024 13:20:11 +0200
Message-Id: <20240808112013.166621-1-arkadiusz.kubalewski@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce and allow DPLL subsystem users to get/set capabilities of
Embedded SYNC on a dpll's pin.

Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>

Arkadiusz Kubalewski (2):
  dpll: add Embedded SYNC feature for a pin
  ice: add callbacks for Embedded SYNC enablement on dpll pins

 Documentation/driver-api/dpll.rst         |  21 ++
 Documentation/netlink/specs/dpll.yaml     |  41 ++++
 drivers/dpll/dpll_netlink.c               | 127 ++++++++++++
 drivers/dpll/dpll_nl.c                    |   5 +-
 drivers/net/ethernet/intel/ice/ice_dpll.c | 241 +++++++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_dpll.h |   1 +
 include/linux/dpll.h                      |  10 +
 include/uapi/linux/dpll.h                 |  23 +++
 8 files changed, 464 insertions(+), 5 deletions(-)

-- 
2.38.1


