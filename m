Return-Path: <netdev+bounces-298807-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id p8RAArONLGpESgQAu9opvQ
	(envelope-from <netdev+bounces-298807-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 00:52:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA2067CEC5
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 00:52:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=BJeQ4xXW;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298807-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298807-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 42D0A30465C6
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 22:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F2C38E8C3;
	Fri, 12 Jun 2026 22:48:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D303002CF;
	Fri, 12 Jun 2026 22:48:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781304498; cv=none; b=hKe/UAxL+NLr9lH2TyL97I7P+FMNavVmoZG5U4FvtW5171RK+YUDygbVDnfK4pQdpx98uhBLIpT29GbJTuc8+YT5sFE9tjx1zgi75iQNSM5ow28G/iprkpAzQ6X469SM5cchQPax9F3PuRqt9ullPsBNKc6pjK7TltK0LTtY4qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781304498; c=relaxed/simple;
	bh=vwl+Kzvflq4BBOrvfguLLJIf/KFDxQcW5qKArMqzNDM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=imq527mNlEthh+IKe9H/ARGqXi9bwEe8q1Ek0ZJn3c9wkDFExcOoahUSc02UjzhyGE/+/CqkiOE1LN5ZULLgMF9VJvwH9SiCYn7F8DjVLwZ78+7zB/oa/gRh5mgrCPQINzGmMD27U/0bnJc7NS3JMgK9b0o4ELNvHwrFajWb96g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BJeQ4xXW; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFE741F000E9;
	Fri, 12 Jun 2026 22:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781304497;
	bh=O3H20/hJghCbyY6nSBzsuvN7jb+ijjvYLSpVFEBAvSc=;
	h=From:To:Cc:Subject:Date;
	b=BJeQ4xXWuV5Zocwx8Jef0xyp8zsbXufW3ucVa+h1CJVEPIUzhzh6d3xBdQLu/YHdR
	 LsaOQkHiwQKQg2J0977mNKjfSretBxeWbi4U6VyhF5NixAxt0Q3IGeOsl6HyXGaPrs
	 jOyDjehXVuRKPKUskaC07iDLcUkH6H7JTuxRHuL25/cQKGUa1sslhp6vbuhN0qcTOf
	 +cKQkVqrX6/DD4SuyOGIo2ON59Bu/AU/HNl0hoDv4eTFK5JzmHt7vaiqABmEApt4tQ
	 3xWnUtEublAD3al+iQ+dE1Nbb0SieocUCXGI8zp5fGN6CyD7lEuvhFXAHIOD6IGwMT
	 SsN+hYMD8Adgg==
From: Jesse Brandeburg <jbrandeb@kernel.org>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	kuba@kernel.org
Cc: Jesse Brandeburg <jbrandeburg@cloudflare.com>
Subject: [PATCH] mailmap: add entry for Jesse Brandeburg
Date: Fri, 12 Jun 2026 15:47:21 -0700
Message-ID: <20260612224727.141614-1-jbrandeb@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:kuba@kernel.org,m:jbrandeburg@cloudflare.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-298807-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[jbrandeb@kernel.org,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jbrandeb@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,comx.dk:email,qualcomm.com:email,intel.com:email,vger.kernel.org:from_smtp,quicinc.com:email,cloudflare.com:email,codeaurora.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7FA2067CEC5

From: Jesse Brandeburg <jbrandeburg@cloudflare.com>

My Intel email address is no longer used, redirect it to my kernel.org
address.

Signed-off-by: Jesse Brandeburg <jbrandeburg@cloudflare.com>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index a009f73d7ea5..829d609980c7 100644
--- a/.mailmap
+++ b/.mailmap
@@ -401,6 +401,7 @@ Jesper Dangaard Brouer <hawk@kernel.org> <hawk@comx.dk>
 Jesper Dangaard Brouer <hawk@kernel.org> <jbrouer@redhat.com>
 Jesper Dangaard Brouer <hawk@kernel.org> <jdb@comx.dk>
 Jesper Dangaard Brouer <hawk@kernel.org> <netoptimizer@brouer.com>
+Jesse Brandeburg <jbrandeb@kernel.org> <jesse.brandeburg@intel.com>
 Jessica Zhang <jesszhan0024@gmail.com> <jesszhan@codeaurora.org>
 Jessica Zhang <jesszhan0024@gmail.com> <quic_jesszhan@quicinc.com>
 Jessica Zhang <jesszhan0024@gmail.com> <jessica.zhang@oss.qualcomm.com>
-- 
2.47.3


