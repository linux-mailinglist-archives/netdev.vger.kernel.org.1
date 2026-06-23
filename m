Return-Path: <netdev+bounces-301286-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jZAfAkMxOmoM3wcAu9opvQ
	(envelope-from <netdev+bounces-301286-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 09:09:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F140C6B4B9E
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 09:09:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=leemhuis.info header.s=key2 header.b=ITchBb2H;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301286-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301286-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DA37C3007AE5
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 07:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179CA3B3BEF;
	Tue, 23 Jun 2026 07:08:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [194.59.206.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5A139B97F;
	Tue, 23 Jun 2026 07:08:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782198534; cv=none; b=tu3CSRRrJMwn4sglpl4hA+vjKIsfKo+QvOfT0ioYukcc4dw84iVHZAek7s+WBLpvC5QFYW1XIZ+S4bAXq2LTrSm5UqGOEtb1hOtOMfv12Nmh1MmPVYArZadkvOCw3iJFmKw50oLlH/vgmCGd9q5RKX/YAEuFDwKh70E0pgfbu0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782198534; c=relaxed/simple;
	bh=kj/4cnt96eILQPYefGiJaKPu2Kq5RADso/2LSAZKwPk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hGPqhlxSKab0QBEIkKHtCoO6QXxIv22AeyPVyy7BVbCpoc69fVi5OPLfn8herspKeEjC6DEBgaWEzl4j/kO2xhyVMtdcEc+U8MBv5z3zS7qAtzjH9g8ojNbMC3K4VmHdScMVd4m7FjBGJqg2CHT78YQCrSpyZJZMqGQ4LLSnqtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=ITchBb2H; arc=none smtp.client-ip=194.59.206.189
Received: from relay02-mors.netcup.net (localhost [127.0.0.1])
	by relay02-mors.netcup.net (Postfix) with ESMTPS id 4gkx4Q3S9jz48Cn;
	Tue, 23 Jun 2026 09:08:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1782198518;
	bh=kj/4cnt96eILQPYefGiJaKPu2Kq5RADso/2LSAZKwPk=;
	h=From:To:Cc:Subject:Date:From;
	b=ITchBb2HFx19FmHofW/i8DDM8iXJmP76Hd3lyjpK5xxlypQK0TjjNA+BFACN+zaZh
	 84D2kownQSjm0pffDS2Q03ZxiKoYE3yPHKtTu8+/zN+sFpRtb8dmkg9VqA1+SeORIx
	 8hd1uleP3kkVKRxyzgiqIrXCcOTfXo/ynJVUarUXC17IeACHTqObQFd4bV3tL/ndru
	 HE8vrXg9htQUTeXO1JhKWRWaobwT5sV6qFFN9zOx6orinBSeWnBy+ik7fxFHjJnEvQ
	 9vVlUZDepRW68Vt/pQZZKRd4f5gibT2qQ9GHBF7G0L34vSrTDSg31M29hsi9qqzT48
	 3bNLuvvt5qdcg==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by relay02-mors.netcup.net (Postfix) with ESMTPS id 4gkx460W44z7w6q;
	Tue, 23 Jun 2026 09:08:22 +0200 (CEST)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4gkx452y1Tz8sgw;
	Tue, 23 Jun 2026 09:08:20 +0200 (CEST)
Received: from luggage.fritz.box (unknown [IPv6:2a02:8108:8984:1d00:a8ad:ebd4:6fc6:160])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id D33BD5F94A;
	Tue, 23 Jun 2026 09:08:19 +0200 (CEST)
Received-SPF: pass (mxe9fb: connection is authenticated)
From: Thorsten Leemhuis <linux@leemhuis.info>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	donald.hunter@gmail.com,
	riana.tauro@intel.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] tools/ynl: add missing uapi header deps in Makefile.deps
Date: Tue, 23 Jun 2026 09:08:18 +0200
Message-ID: <20260623070818.2161810-1-linux@leemhuis.info>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <178219850021.1431613.7857959409078267283@mxe9fb.netcup.net>
X-NC-CID: fthmGy+ngVgUYmq0YmkCnRZOKNsdl5Y7HnsV2gEWvhVHWd8tX5c=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[leemhuis.info:s=key2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,intel.com,vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:donald.hunter@gmail.com,m:riana.tauro@intel.com,m:linux-kernel@vger.kernel.org,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[linux@leemhuis.info,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-301286-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[leemhuis.info];
	DKIM_TRACE(0.00)[leemhuis.info:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,leemhuis.info:dkim,leemhuis.info:email,leemhuis.info:mid,leemhuis.info:from_mime];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@leemhuis.info,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F140C6B4B9E

drm_ras includes drm/drm_ras.h, which is a relatively new header not yet
shipped in most distro kernel-header packages. Without the explicit
entry, the build might fail with a message like this:

  drm_ras-user.c:19:10: error: ‘DRM_RAS_CMD_CLEAR_ERROR_COUNTER’ \
   undeclared here (not in a function); did you mean \
  ‘DRM_RAS_CMD_GET_ERROR_COUNTER’

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---

Lo! Quick note, I'll might be afk in the next few days and slow to respond.
Ciao, Thorsten

 tools/net/ynl/Makefile.deps | 2 ++
 1 file changed, 2 insertions(+)

diff --git tools/net/ynl/Makefile.deps tools/net/ynl/Makefile.deps
index cc53b2f21c4446..43d06ecbae93d0 100644
--- tools/net/ynl/Makefile.deps
+++ tools/net/ynl/Makefile.deps
@@ -14,10 +14,12 @@ UAPI_PATH:=../../../../include/uapi/
 
 get_hdr_inc=-D$(1) -include $(UAPI_PATH)/linux/$(2)
 get_hdr_inc2=-D$(1) -D$(2) -include $(UAPI_PATH)/linux/$(3)
+get_hdr_inc_drm=-D$(1) -include $(UAPI_PATH)/drm/$(2)
 
 CFLAGS_dev-energymodel:=$(call get_hdr_inc,_LINUX_DEV_ENERGYMODEL_H,dev_energymodel.h)
 CFLAGS_devlink:=$(call get_hdr_inc,_LINUX_DEVLINK_H_,devlink.h)
 CFLAGS_dpll:=$(call get_hdr_inc,_LINUX_DPLL_H,dpll.h)
+CFLAGS_drm_ras:=$(call get_hdr_inc_drm,_LINUX_DRM_RAS_H,drm_ras.h)
 CFLAGS_ethtool:=$(call get_hdr_inc,_LINUX_TYPELIMITS_H,typelimits.h) \
 	$(call get_hdr_inc,_LINUX_ETHTOOL_H,ethtool.h) \
 	$(call get_hdr_inc,_LINUX_ETHTOOL_NETLINK_H_,ethtool_netlink.h) \

base-commit: d07d80b6a129a44538cda1549b7acf95154fb197
-- 
2.54.0


