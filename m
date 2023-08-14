Return-Path: <netdev+bounces-27420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DEED77BEA6
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 19:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C70B428109A
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 17:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B705EC8D6;
	Mon, 14 Aug 2023 17:11:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD5828F1
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 17:11:28 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3830CE63;
	Mon, 14 Aug 2023 10:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692033087; x=1723569087;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=69krGW9gVz+8Dy69LvghUGFWJfVH9GXwoDIeCcF9xlY=;
  b=URr36XnKhNWmvoMZ46adjeRx1/E7ZZft4kTay5krHGYLjAusIRbxJ4T2
   fqhak1uFmP0pSN7ijIx23fgWud44en9JWtW0zj26V+hRA4DjEjC1vUfCS
   Yl6v+MWtdm+kRW7wctpPSEgoKOmROcuCbx+dtYT7H9C3e9XTGifH+zKaS
   3cwNgG3LOOYAkkY5jWSQa6Ipk6dWpgYbGDEM020lb8hnFCs5q2wJkgZqz
   FCIFZwHe2L/oqFzylcMWyK7fX9cAHjCRmzRDmVXrzXMZDMI823AW8bhOe
   /CzrTTV6QRrTf46ln+pNazH+yJ3qmIdCErWQ1sST+FSH+6oSGABNOOCc9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="435983109"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="435983109"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 10:11:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="763011320"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="763011320"
Received: from unknown (HELO fedora.jf.intel.com) ([10.166.80.24])
  by orsmga008.jf.intel.com with ESMTP; 14 Aug 2023 10:11:18 -0700
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
	rdunlap@infradead.org,
	Pavan Kumar Linga <pavan.kumar.linga@intel.com>
Subject: [PATCH net-next v2 0/2] Fix invalid kernel-doc warnings
Date: Mon, 14 Aug 2023 10:07:18 -0700
Message-Id: <20230814170720.46229-1-pavan.kumar.linga@intel.com>
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
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

kernel-doc reports invalid warnings on IDPF driver patch series [1]
that is submitted for review. This patch series fixes those warnings.

[1]: https://lore.kernel.org/netdev/20230808003416.3805142-1-anthony.l.nguyen@intel.com/
---
v1 -> v2:
 * Fix typos in the commit message

net-next:
v1 - https://lore.kernel.org/netdev/20230812002549.36286-1-pavan.kumar.linga@intel.com/

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


