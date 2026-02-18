Return-Path: <netdev+bounces-259345-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mD2tLKQElmm4YQIAu9opvQ
	(envelope-from <netdev+bounces-259345-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 19:27:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1619F158B3D
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 19:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29AC2300B06F
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 18:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF3A334370;
	Wed, 18 Feb 2026 18:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="OnEFY4uA"
X-Original-To: netdev@vger.kernel.org
Received: from alln-iport-8.cisco.com (alln-iport-8.cisco.com [173.37.142.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F952DC77F;
	Wed, 18 Feb 2026 18:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.142.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771439236; cv=none; b=kPrqjXI5vLrwni4cen0hm/x/SXet46yoBdXLGMY24T2EySu3bvUlWPxw4xI8O0tf+adWXhmYbk3Xiqh6zMt4IldjYdu8f/3mGpLhqbrJixIFKs56gOzkSpUfG6Jdbx5jku0itCYrsbaTgIx1H/PBri/LGWyP4AJka/TdYxVCjSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771439236; c=relaxed/simple;
	bh=r6HQa6s2fq8zqm/ew5+2D8wLvGvJLQBi0MCcX6pFaa4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i/7VlKbEva4D/0nqFyHC+rKeWCmPIi0JbtyPxkePCinbviT7fuB0Chvhki9ir9U008hEGE25OQaNetEJiDy5JZNN6Xu/KmFPrYjTQDj4Z3Do+I6hBPVcmbt44s5QcxODgacHCxw5CFlY3rpbRwrqcTPwqYqbQKMx0xQT+Kg6gRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=OnEFY4uA; arc=none smtp.client-ip=173.37.142.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=200; q=dns/txt;
  s=iport01; t=1771439235; x=1772648835;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=r6HQa6s2fq8zqm/ew5+2D8wLvGvJLQBi0MCcX6pFaa4=;
  b=OnEFY4uAewQGcPmJbhfjKFGAZNRKsZvWPoq/P8h3t01DYln4rVamLm0L
   4/Kk3JSPF9MD2dsZrQhUu+W8fMTTv+agds0Vr1i9ThWAcC6tuZoqpZkvO
   KsKHZxdPFDc0+nS2kOBRW73Qg8jiPuPuusr+ETP4Po4AnXaIJiBE6ynwc
   tpgW/g8mq457tiNEFlQwEfDA17UaKMCsIoF/sICwRhOmz9KBE7ekqdM4B
   XHJqbf2UjzLVKjhY/M/b9pBaiCE/JkrW+WYdljPBLGaTvN3+qXwrwec3J
   5dHB4hYOORuKnN4nmQEXEpDeAp3o7fKBmsa16XTMrEZE+uTKbSX/FKzjT
   A==;
X-CSE-ConnectionGUID: 7g6KfQCCTLy6V/Hf/mvIdg==
X-CSE-MsgGUID: WSYsJGBFQxqRaOBZlQEtAQ==
X-IPAS-Result: =?us-ascii?q?A0DeBQCdA5Zp/47/Ja1aglmCSH5gQ0m0aBSBaw8BAQEPU?=
 =?us-ascii?q?QQBAYUHAo0fAiY0CQ4BAgQBAQEBAwIDAQEBAQEBAQEBAQELAQEFAQEBAgEHB?=
 =?us-ascii?q?YEOE4ZchlsCAQMyAUYbgRwGE4MCgnQDrXWCLIEBhHzZQoFwFYE4hW+HZoVuJ?=
 =?us-ascii?q?xuBSUSEPz6EDgESAYZlBIMwjTKGMUgKgRQDWSwBVRMNCgsHBYEjQwM1EioVI?=
 =?us-ascii?q?0sFLR2BIyEdFxR3GwcFEiEqBwmBdQICBIIQeIIBD4ZseQMubxoOIgIsElxRB?=
 =?us-ascii?q?T4LXy4DCxgNSBEsNxQbBD5uB447QYFBhF4cpVKhDoQmgWSfdBozg3EBEqZnm?=
 =?us-ascii?q?QaCWKIBhGiBaDxpcDMaCBsVgyJSGQ/PeCUyPAIHCwEBAwmRageBdgEB?=
IronPort-Data: A9a23:GQf9D6le6jD0tDplGpDkWI3o5gz1J0RdPkR7XQ2eYbSJt1+Wr1Gzt
 xIWCGmEa/yKZ2b3KI1/b4+yoRgOu5CAx4VgQQs6qH1kRVtH+JHPbTi7wugcHM8zwunrFh8PA
 xA2M4GYRCwMZiaC4E/raf658SUUOZigHtLUEPTDNj16WThqQSIgjQMLs+Mii+aEu/Dha++2k
 Y20+ZS31GONgWYubDpOsvLb8XuDgdyr0N8mlg1mDRx0lAe2e0k9VPo3Oay3Jn3kdYhYdsbSb
 /rD1ryw4lTC9B4rDN6/+p6jGqHdauePVeQmoiM+t5mK2nCulARrukoIHKZ0hXNsttm8t4sZJ
 OOhGnCHYVxB0qXkwIzxWvTDes10FfUuFLTveRBTvSEPpqHLWyOE/hlgMK05FdIXpMV5OEply
 dgJdg5KTh7EgvyXzL3uH4GAhux7RCXqFJkUtnclyXTSCuwrBMieBa7L/tRfmjw3g6iiH96HO
 JFfMmUpNkmdJUQTYD/7C7pm9AusrmL2bzxDqFGVjaE2+GPUigd21dABNfKLJYTWH54FxhbwS
 mTuwF/IGTM1HvKm2SO/+1WGtOv2sD/SYddHfFG/3rsw6LGJ/UQXBRoQfVi2u/+0jgi5Qd03A
 0gV/Dc+6Ks/7kqmSvHjUBCi5n2JpBgRX5xXCeJSwAeA1qbZ/S6HCWUeCD1MctorsIkxXzNC6
 7OSt8niCToqtPieTmiQs+/J6zizIiMSa2QFYEfoUDc43jUqm6lr5jqnczqpOPXdYgHdcd0o/
 w23kQ==
IronPort-HdrOrdr: A9a23:gLc8xK0TgXe0m24iNic6fAqjBJ0kLtp133Aq2lEZdPWaSKClfq
 eV7ZAmPHDP5gr5NEtLpTnEAtjifZq+z+8R3WByB9aftWDd0QPCEGgh1/qB/9SKIULDH4BmuJ
 tIQuxXFMDwAV9mjczz/QW0V+o7zMLvytHOuQ6n9RdQpcUAUdAY0++/YTzrdHFLeA==
X-Talos-CUID: 9a23:z9Als2E9buzxIGLHqmI4+xA3FPkOWUH53SnuZG+2TmN3abGaHAo=
X-Talos-MUID: 9a23:J4gSrgvlu6dP77p6qs2nuwpTL+VHyYqXGFk3mLIsic29GDBZAmLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.21,298,1763424000"; 
   d="scan'208";a="670423808"
Received: from rcdn-l-core-05.cisco.com ([173.37.255.142])
  by alln-iport-8.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 18 Feb 2026 18:27:14 +0000
Received: from satishkh-l-mj0bbv6x.cisco.com (unknown [10.25.134.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: satishkh@cisco.com)
	by rcdn-l-core-05.cisco.com (Postfix) with ESMTPSA id D9E7418007D9B;
	Wed, 18 Feb 2026 18:26:17 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Satish Kharat <satishkh@cisco.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: drop enic maintainer entry for benve
Date: Wed, 18 Feb 2026 10:26:10 -0800
Message-ID: <20260218182610.1138802-1-satishkh@cisco.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260215074139.GA12989@unreal>
References: 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-User: satishkh@cisco.com
X-Outbound-SMTP-Client: 10.25.134.135, [10.25.134.135]
X-Outbound-Node: rcdn-l-core-05.cisco.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[cisco.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[cisco.com:s=iport01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259345-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[satishkh@cisco.com,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[cisco.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cisco.com:mid,cisco.com:dkim,cisco.com:email]
X-Rspamd-Queue-Id: 1619F158B3D
X-Rspamd-Action: no action

Christian Benvenuti is no longer involved in the development of the enic driver.
The <benve@cisco.com> email address is no longer valid. I will send a separate
patch to update the usnic component.

