Return-Path: <netdev+bounces-26979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 883AA779BDA
	for <lists+netdev@lfdr.de>; Sat, 12 Aug 2023 02:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B28BD1C20C06
	for <lists+netdev@lfdr.de>; Sat, 12 Aug 2023 00:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24B019F;
	Sat, 12 Aug 2023 00:26:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D6E7E
	for <netdev@vger.kernel.org>; Sat, 12 Aug 2023 00:26:03 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E87B30FE;
	Fri, 11 Aug 2023 17:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691799962; x=1723335962;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4Hjl5ogh4rzaHBoES606WIZBISl2Q1mGKF+fQyelPu8=;
  b=cA83xzeKXMkh4NuT7eb1TEcqNYjJUAjFgGVP4rnhuefZtwo7ofKyqhms
   J9S2a0ou0kgceGx9QG1e3NE3outSkxSUsREWwhIos0SABcQOY6g9ojosT
   GNZg1BwQJVbbsZGnYDQp5IN3lO9Sa5h5oeL6L3BG7tafWSPlD98u+ETjj
   x7qz9zZSv0B1M2yPiG1CrO9OaKmQ1il+YChlMh/aeV8nhg3QmBuBzdTe0
   HbDW8M0PlkgCH/y4T2LO0mS57fz+actvCB2Y/EH9QIHUBl+7ohv62f7Fj
   evilOGJQm2s4dcCdvKPADGGHHBaD02toOnUDGK24jzSaWEPBktPZheTKD
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="375500075"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="375500075"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 17:26:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="979370605"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="979370605"
Received: from unknown (HELO fedora.jf.intel.com) ([10.166.80.24])
  by fmsmga006.fm.intel.com with ESMTP; 11 Aug 2023 17:26:01 -0700
From: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
To: netdev@vger.kernel.org,
	kuba@kernel.org
Cc: linux-doc@vger.kernel.org,
	corbet@lwn.net,
	emil.s.tantilov@intel.com,
	joshua.a.hay@intel.com,
	sridhar.samudrala@intel.com,
	alan.brady@intel.com,
	madhu.chittim@intel.com,
	jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com,
	willemb@google.com,
	decot@google.com,
	Pavan Kumar Linga <pavan.kumar.linga@intel.com>
Subject: [PATCH net-next 0/2] Fix invalid kernel-doc warnings
Date: Fri, 11 Aug 2023 17:25:47 -0700
Message-Id: <20230812002549.36286-1-pavan.kumar.linga@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.9 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

kernel-doc reports invalid warnings on IDPF driver patch series [1]
that is submitted for review. This patch series fixes those warnings.

[1]: https://lore.kernel.org/netdev/20230808003416.3805142-1-anthony.l.nguyen@intel.com/
---
These fixes are needed for the IDPF driver patch series to have
a clean CI. So targeting the series to net-next instead of
linux-docs.
---
Pavan Kumar Linga (2):
  scripts: kernel-doc: parse DEFINE_DMA_UNMAP_[ADDR|LEN]
  scripts: kernel-doc: fix macro handling in enums

 scripts/kernel-doc | 5 +++++
 1 file changed, 5 insertions(+)

-- 
2.38.1


