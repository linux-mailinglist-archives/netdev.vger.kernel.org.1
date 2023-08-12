Return-Path: <netdev+bounces-26981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACAF9779BE3
	for <lists+netdev@lfdr.de>; Sat, 12 Aug 2023 02:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD1661C20BDD
	for <lists+netdev@lfdr.de>; Sat, 12 Aug 2023 00:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821921377;
	Sat, 12 Aug 2023 00:26:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779F31114
	for <netdev@vger.kernel.org>; Sat, 12 Aug 2023 00:26:04 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E67630FF;
	Fri, 11 Aug 2023 17:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691799963; x=1723335963;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BmEiv3YKG+Lm04BvU0pkDSbhl/gQLbLwts7jJ8bsyCA=;
  b=SKr5yJ78cLpo9pA7h6n/Uuh9WXUc4cvuLqUXcGEW+1IRtwV4KAbU4fF9
   MEp9SBIZpwG3emZiqlPiY7F1Oqv7l5qF7ZNkBeJQHW50JCPprRCoeGT/Y
   fdMa60goix+I+PnyCrgGm7xfd1K6OsuDMF9lu6DCDTEtBWdsEKFkM3nX/
   67R6YMzmmqLlHXze1cJRs9nyc2BHT5GlsrHEzn1OZjL9r49hnlm6LKcZM
   cAu5FQ77HK2PDhKXxMyHIYRn+3i9s8mshaZIsnwjh5L4upT5m4+FQjg5s
   WnHHk9l1kNa8yxF21+7bnQ10Ikxslh+LlUXS2JYjbtmxDnv52GPcYNjG0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="375500081"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="375500081"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 17:26:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="979370612"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="979370612"
Received: from unknown (HELO fedora.jf.intel.com) ([10.166.80.24])
  by fmsmga006.fm.intel.com with ESMTP; 11 Aug 2023 17:26:02 -0700
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
Subject: [PATCH net-next 2/2] scripts: kernel-doc: fix macro handling in enums
Date: Fri, 11 Aug 2023 17:25:49 -0700
Message-Id: <20230812002549.36286-3-pavan.kumar.linga@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230812002549.36286-1-pavan.kumar.linga@intel.com>
References: <20230812002549.36286-1-pavan.kumar.linga@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
	SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

drivers/net/ethernet/intel/idpf/idpf.h uses offsetof to
initialize the enum enumerators:

enum {
	IDPF_BASE_CAPS = -1,
	IDPF_CSUM_CAPS = offsetof(struct virtchnl2_get_capabilities,
				  csum_caps),
	IDPF_SEG_CAPS = offsetof(struct virtchnl2_get_capabilities,
				 seg_caps),
	IDPF_RSS_CAPS = offsetof(struct virtchnl2_get_capabilities,
				 rss_caps),
	IDPF_HSPLIT_CAPS = offsetof(struct virtchnl2_get_capabilities,
				    hsplit_caps),
	IDPF_RSC_CAPS = offsetof(struct virtchnl2_get_capabilities,
				 rsc_caps),
	IDPF_OTHER_CAPS = offsetof(struct virtchnl2_get_capabilities,
				   other_caps),
};

kernel-doc parses the above enumerator with a ',' inside the
macro and treats 'csum_caps', 'seg_caps' etc. also as enumerators
resulting in the warnings:

drivers/net/ethernet/intel/idpf/idpf.h:130: warning: Enum value
'csum_caps' not described in enum 'idpf_cap_field'
drivers/net/ethernet/intel/idpf/idpf.h:130: warning: Enum value
'seg_caps' not described in enum 'idpf_cap_field'
drivers/net/ethernet/intel/idpf/idpf.h:130: warning: Enum value
'rss_caps' not described in enum 'idpf_cap_field'
drivers/net/ethernet/intel/idpf/idpf.h:130: warning: Enum value
'hsplit_caps' not described in enum 'idpf_cap_field'
drivers/net/ethernet/intel/idpf/idpf.h:130: warning: Enum value
'rsc_caps' not described in enum 'idpf_cap_field'
drivers/net/ethernet/intel/idpf/idpf.h:130: warning: Enum value
'other_caps' not described in enum 'idpf_cap_field'

Fix it by removing the macro arguments within the parenthesis.

Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
---
 scripts/kernel-doc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index cfb1cb223508..bc008f30f3c9 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -1353,6 +1353,7 @@ sub dump_enum($$) {
 	my %_members;
 
 	$members =~ s/\s+$//;
+	$members =~ s/\(.*?[\)]//g;
 
 	foreach my $arg (split ',', $members) {
 	    $arg =~ s/^\s*(\w+).*/$1/;
-- 
2.38.1


