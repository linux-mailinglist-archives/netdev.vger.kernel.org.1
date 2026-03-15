Return-Path: <netdev+bounces-267947-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kKdrFpHvtmnnKgEAu9opvQ
	(envelope-from <netdev+bounces-267947-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 18:42:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E0A291CF5
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 18:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2704430185D8
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 17:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB089376465;
	Sun, 15 Mar 2026 17:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J4ctht+T"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAA3368291
	for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 17:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773596556; cv=none; b=XutNouipTKYiFeZk5MrQ6kflEWKBv6JsPJGPKKIw7Z+ZuEiYXucJHvGXg1+hr5qo/Vz99OZGhRb0ZnS/X0L7DLml5kPC1NpKFLSqF+v2GyJAhxWro8W0acy0fBBK4zIjjg157H67zvPq1H3fDU0IqVlzxyajIpWpzmq013ZvK2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773596556; c=relaxed/simple;
	bh=TIKTUIQt4G2yU8FBTNuCfD3VR4PTxsfsi4m4UitfwP4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UGzuaOGe5ioKVwDxpbwf6P1W9EzKMh21qwBAauDEF/S7xSFEtF6D9UNM5OtuPlaCYJtX2UKVZ0C4gLjRZ1CgpVsYVn4NxuP83g76jPRY+Wnjm6CIrSO9naIpCK2zFNMsO3omCXUS9g2/9dsftykX8sIQfm+KaQ0/0259YmkDwww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J4ctht+T; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773596554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nLhctV4waxsZ9dP+PFfPPeTT3/maOHitrXz8Ap3A8pA=;
	b=J4ctht+TgCTw22fq8OUlB0xH6al5JlkOsenBme5o57WIf9PHuv+v2MF2M20O0Iw8kzckS+
	mQCFM0UdnUVaa8uiwS4PVxuVL/PAL81ejCP3RHyoVWRZoQElGlVtZQSUmKpyPTbc7Tz6jp
	VGVNzy1x/kLiAicEP377jPwGi2EOibg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-190-D72rq0e9Nz6VwebGoORxNQ-1; Sun,
 15 Mar 2026 13:42:31 -0400
X-MC-Unique: D72rq0e9Nz6VwebGoORxNQ-1
X-Mimecast-MFC-AGG-ID: D72rq0e9Nz6VwebGoORxNQ_1773596550
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D1280180035C;
	Sun, 15 Mar 2026 17:42:29 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.45.224.46])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E78DA1955D87;
	Sun, 15 Mar 2026 17:42:25 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Prathosh Satish <Prathosh.Satish@microchip.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Petr Oros <poros@redhat.com>,
	Michal Schmidt <mschmidt@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 0/6] dpll: zl3073x: refactor state management
Date: Sun, 15 Mar 2026 18:42:18 +0100
Message-ID: <20260315174224.399074-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-267947-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: E1E0A291CF5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series refactors the zl3073x DPLL driver to centralize hardware
state management behind dedicated per-module state interfaces, replacing
scattered direct register accesses in dpll.c with cached state and
proper accessor functions.

The driver already uses a fetch/get/set pattern for ref, out, and synth
modules. This series extends and refines that pattern:

First, struct_group() is applied to the existing ref, out, and synth
structures to partition fields into cfg (mutable configuration), inv
(invariants set at init), and stat (read-only status) groups. This
enables group-level memcmp for short-circuit checks and bulk copies in
state_set, and adds invariant validation guards.

A ref_state_update() helper is extracted to encapsulate the per-reference
monitor status register read, keeping direct register access behind the
ref module interface.

A new zl3073x_chan module is introduced following the same pattern,
caching the DPLL channel mode_refsel register with inline getters and
setters. The refsel_mode and forced_ref fields are removed from struct
zl3073x_dpll in favor of the cached channel state.

The chan module is then extended with cached mon_status and refsel_status
registers, converting lock_status_get and selected_ref_get from direct
HW reads to cached state lookups refreshed by the periodic worker.

Reference priority registers are cached in the chan cfg group, removing
the ad-hoc ref_prio_get/set functions and the redundant pin->selectable
flag, which is now derived from the cached priority. The
selected_ref_set function is inlined into input_pin_state_on_dpll_set,
unifying all mode paths through a single chan_state_set commit point.

Finally, selected_ref_get is dropped entirely since the refsel_status
register provides the selected reference regardless of mode, and
connected_ref_get is simplified to a direct refsel_state check.

Ivan Vecera (6):
  dpll: zl3073x: use struct_group to partition states
  dpll: zl3073x: add zl3073x_ref_state_update helper
  dpll: zl3073x: introduce zl3073x_chan for DPLL channel state
  dpll: zl3073x: add DPLL channel status fields to zl3073x_chan
  dpll: zl3073x: add reference priority to zl3073x_chan
  dpll: zl3073x: drop selected and simplify connected ref getter

 drivers/dpll/zl3073x/Makefile |   4 +-
 drivers/dpll/zl3073x/chan.c   | 165 ++++++++++++
 drivers/dpll/zl3073x/chan.h   | 179 +++++++++++++
 drivers/dpll/zl3073x/core.c   |  36 ++-
 drivers/dpll/zl3073x/core.h   |  14 +-
 drivers/dpll/zl3073x/dpll.c   | 490 +++++++++-------------------------
 drivers/dpll/zl3073x/dpll.h   |   4 -
 drivers/dpll/zl3073x/out.c    |  27 +-
 drivers/dpll/zl3073x/out.h    |  21 +-
 drivers/dpll/zl3073x/ref.c    |  58 ++--
 drivers/dpll/zl3073x/ref.h    |  33 ++-
 drivers/dpll/zl3073x/regs.h   |  12 +
 drivers/dpll/zl3073x/synth.h  |  16 +-
 13 files changed, 627 insertions(+), 432 deletions(-)
 create mode 100644 drivers/dpll/zl3073x/chan.c
 create mode 100644 drivers/dpll/zl3073x/chan.h

-- 
2.52.0


