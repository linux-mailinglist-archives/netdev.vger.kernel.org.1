Return-Path: <netdev+bounces-257234-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iFDTK9W6hGnG4wMAu9opvQ
	(envelope-from <netdev+bounces-257234-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 16:44:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B39F4B73
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 16:44:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5A0D9302BA26
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 15:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE62C423A79;
	Thu,  5 Feb 2026 15:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H5FvZDQe"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876B6423A6C
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 15:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770306244; cv=none; b=mtU8Encegn/aOssVqDCocYkHt1o1WpVENgbGw4W5/V1X3GJNfco27f2N7mSluvR85yNJw2h8vzZ4Aqj3vp0nDFRfiYCW2GMTD/k/krxWhs+5AgHEI+IF9/F4d+9GsXw0X4bf4RujXlXHJZQEiM19k515XLL1XGPsGPUSAyJletQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770306244; c=relaxed/simple;
	bh=H7q2J1/J1WOIM3h8FTGC79FzhhbRtPNHrzphmIMW3dI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MdYnJMvp+1/2Q2jdyRPJm8mr0R5F0vSC8XlWaHaL1dj8jxowOAeYL3RTC2gC73ZbBcS0oHHw8ElRigMbPtTLVHL3Tj8v6sQP1NP2AIJlMW2qpnd/7GmLZvcjEhSMp1dx9bBMA16fzQEXTfJVyqlTi6Z8oXInZIU1zWQ8PzKZT1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H5FvZDQe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770306243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=namUa4LSW2job2tTxSo2yNiR2IiIciWnpuvpbUA8DNg=;
	b=H5FvZDQevwfXCsLxQlwI2RDdas9dVtRij15a6DMjdHOB6WdXIxKydp8eDxWRKwCBWW+Xc7
	34j6UNzs2PV1rsdgDl2545mxwJa/GlanWtLZEnToUPvNhvGpC2QizrHlY/BHXlV5Rx/qjr
	p/Y+KDLYlOeOQaMPMNDg4WXekqY6LcY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-195-ZVubfYLYMA-1wpPNkab0Fw-1; Thu,
 05 Feb 2026 10:43:57 -0500
X-MC-Unique: ZVubfYLYMA-1wpPNkab0Fw-1
X-Mimecast-MFC-AGG-ID: ZVubfYLYMA-1wpPNkab0Fw_1770306236
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A1885195605F;
	Thu,  5 Feb 2026 15:43:55 +0000 (UTC)
Received: from cnb-01.lab.eng.brq2.redhat.com (cnb-01.lab.eng.brq2.redhat.com [10.37.129.36])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7E81B1800465;
	Thu,  5 Feb 2026 15:43:53 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Prathosh Satish <Prathosh.Satish@microchip.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/2] dpll: zl3073x: Include current frequency in supported frequencies list
Date: Thu,  5 Feb 2026 16:43:48 +0100
Message-ID: <20260205154350.3180465-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257234-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 19B39F4B73
X-Rspamd-Action: no action

This series ensures that the current operating frequency of a DPLL pin                                                                                      
is always reported in its supported frequencies list.                                                                                                       
                                                                                                                                                              
Problem:                                                                                                                                                    
When a ZL3073x DPLL pin is registered, its supported frequencies are                                                                                        
read from the firmware node's "supported-frequencies-hz" property.                                                                                          
However, if the firmware node is missing, or doesn't include the                                                                                            
current operating frequency, the pin reports a frequency that isn't                                                                                         
in its supported list. This inconsistency can confuse userspace tools                                                                                       
that expect the current frequency to be among the supported values.

Solution:
Always include the current pin frequency as the first entry in the
supported frequencies list, followed by any additional frequencies
from the firmware node (with duplicates filtered out).

Patch 1 refactors the output pin frequency calculation into a reusable
helper function zl3073x_dev_output_pin_freq_get(), which mirrors the
existing zl3073x_dev_ref_freq_get() for input pins.

Patch 2 modifies zl3073x_pin_props_get() to obtain the current
frequency early and place it at index 0 of the supported frequencies
array, ensuring it is always present regardless of firmware node
contents.

Ivan Vecera (2):
  dpll: zl3073x: Add output pin frequency helper
  dpll: zl3073x: Include current frequency in supported frequencies list

 drivers/dpll/zl3073x/core.h | 30 ++++++++++++++++++++++++++++
 drivers/dpll/zl3073x/dpll.c | 39 +------------------------------------
 drivers/dpll/zl3073x/out.h  | 17 ++++++++++++++++
 drivers/dpll/zl3073x/prop.c | 32 +++++++++++++++++++-----------
 4 files changed, 69 insertions(+), 49 deletions(-)

-- 
2.52.0


