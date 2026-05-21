Return-Path: <netdev+bounces-290264-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJCGJqC4DmrBBgYAu9opvQ
	(envelope-from <netdev+bounces-290264-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 09:47:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33CA75A057D
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 09:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0DDBE302F3A0
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 07:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4042384CE8;
	Thu, 21 May 2026 07:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UPGvCxvR"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA1A369970
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 07:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779349360; cv=none; b=sVUChuTvQz9Gg4KlPygCLAOnVxKT3n0y5TMb50QAMMaCnF+i4/0L2YJG1v4pABem1OkX2nkOmGMJtU69J7Uxg8+hlgKz5mdJdIaK7HSiAbAl5pnbpSmrK45zU2Il4JsLJdVFdtpEKNC2CA7ipRY7+/pkswU95wsBoASk2TjM03U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779349360; c=relaxed/simple;
	bh=j1mdV7OC7OIpYI7saIa/DWoNbEvAqsQycuTbEzIbups=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D+waSA2Uk/CEWPzudAXsGLbE1vEyL8vPIhAF2/IPI/0z0YSVO+RC9uAOXV0G44kYMSsH5nrupddm5+m3yfqIgIQF28FSsmx0ZTU2rwqc4sT5L63joPQfF6vxnT/DVQrnx5ue4AAFbvQbe26i+nb/+h5ZFzUpRTxZ+hsLe54kPuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UPGvCxvR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779349358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OpRJi5ew7UC6Tw+onC7/ETTvlR3lzS4+PzEgUivNZSU=;
	b=UPGvCxvR4hEbMnrzMVRkUIdwsp6Lu8ASRYcdjZU81tHiTcROZMZfL5mSjtsTz8dZdIcGRl
	rIEfyqhXnguRinOLNqyMru/iZj2x3IPpAiuq3Mt0U++oGWdulI6jf5RwlK7NLKCXAsCmzr
	vcogJxYwOZAfQr8nsx0JWKSILQkGaMc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-161-x8IFRELKPDm0-Yg-QbsxLg-1; Thu,
 21 May 2026 03:42:33 -0400
X-MC-Unique: x8IFRELKPDm0-Yg-QbsxLg-1
X-Mimecast-MFC-AGG-ID: x8IFRELKPDm0-Yg-QbsxLg_1779349352
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6A86E1800611;
	Thu, 21 May 2026 07:42:31 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.32.79])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BA9EF19560A3;
	Thu, 21 May 2026 07:42:26 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Michal Schmidt <mschmidt@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Pasi Vaananen <pvaanane@redhat.com>,
	Petr Oros <poros@redhat.com>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Simon Horman <horms@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 0/2] dpll: add NCO pin type and zl3073x support
Date: Thu, 21 May 2026 09:42:18 +0200
Message-ID: <20260521074220.432590-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[intel.com,davemloft.net,gmail.com,google.com,kernel.org,resnulli.us,redhat.com,microchip.com,linux.dev,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-290264-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 33CA75A057D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a new DPLL_PIN_TYPE_INT_NCO pin type for virtual pins representing
the NCO mode of a DPLL and implement support for it in the zl3073x driver.

Patch 1 adds the new pin type to the DPLL netlink spec and UAPI header.

Patch 2 adds a virtual NCO input pin to the zl3073x driver that allows
userspace to switch a DPLL channel into NCO mode. The pin reports
connected/active state when the channel is in NCO mode and handles
the hardware-specific details of mode transitions including automatic
df_offset capture and 1PPS phase preservation.

Changes:
v3:
  - fixed SoB position
v2:
  - See individual patches for detailed changelogs.

Ivan Vecera (2):
  dpll: add DPLL_PIN_TYPE_INT_NCO pin type
  dpll: zl3073x: add NCO virtual input pin

 Documentation/netlink/specs/dpll.yaml |  13 ++
 drivers/dpll/dpll_nl.c                |   2 +-
 drivers/dpll/zl3073x/chan.c           |  68 ++++++-
 drivers/dpll/zl3073x/chan.h           |  25 +++
 drivers/dpll/zl3073x/dpll.c           | 277 ++++++++++++++++++++++----
 drivers/dpll/zl3073x/dpll.h           |   2 +
 drivers/dpll/zl3073x/regs.h           |   7 +
 include/uapi/linux/dpll.h             |   4 +
 8 files changed, 357 insertions(+), 41 deletions(-)

-- 
2.53.0


