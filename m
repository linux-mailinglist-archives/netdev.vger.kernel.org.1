Return-Path: <netdev+bounces-262230-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UILeA31no2kkCgUAu9opvQ
	(envelope-from <netdev+bounces-262230-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 23:09:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D64541C9603
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 23:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5DA643001868
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 22:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00E639A7EF;
	Sat, 28 Feb 2026 22:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AhZ6mEcX"
X-Original-To: netdev@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7BE175A8E
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 22:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772316537; cv=none; b=t3RB+2GXEZPmozo5wzrngXNE5Apt+UvIdmWqcK85a+UjKad/d+IKowpZhqg4X6hHQEneNqvNICK1j6/qdNgLaJU9gOfs75napAwP1RpMFjKhM/mh8fgWeJ2ToChNcuxvhMBkqto30E94vqnfDE7i8kF0LOCwS3yusezYr5tpEJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772316537; c=relaxed/simple;
	bh=Pb92vVKgwC/O99keXdyjnobFUpXttJWAxt4jOxCXCEw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K32g/oBWj7UY5jjfNbAaaevI+216b3L724QLNWuxZLc5ZNf05zry7hNFs4ySV9wKcKH69/N+gUN8qvbijgDdbB7LisghUM2cwZd1Yy4vs++C5hHT5YxTWKCdZXulN3v+GyX8ObXjAT00LR5PZxPaVo2dAviwCbAWJuTZwihH/50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AhZ6mEcX; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=F6v5HrsFbbu6mESkQwwsvyB4Mu4+nVVbm0QfVD4jI70=; b=AhZ6mEcXskQN8LiFqCggAehXtp
	yRrGAxWFO0dkbAS3kz1TNTNuQnFkWW5BGOVH/GEHvgiZm7LzLPrhwV4wZ5hSkpiGpFIrExMIZFHrt
	OqaJwV12m8xWWAwprJgIFa9WzMGb0Cubq6bkr2yPH/jruDnZ1fKaUUWrOfFD1PHb4fBrjE7oBjhP1
	EkG2hddx8lWbFB9GjDds3dTxWYWA3B8J9tpsA9c3lFm+FpS+1g/Oekjk/m9So06gpUBEyQ6kC8oTv
	giFAwHdkogug6t8RBWY+v7oOJicsBkqnh6Ip55TKINMy2E5kbd1yky+P6gdGXTlslCqf7UbF5Fn5x
	WZKc4Z6Q==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwSUV-0000000AJaB-1CzQ;
	Sat, 28 Feb 2026 22:08:51 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: netdev@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Chas Williams <3chas3@gmail.com>,
	linux-atm-general@lists.sourceforge.net,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net] atm: atmdev: add function parameter names and description
Date: Sat, 28 Feb 2026 14:08:45 -0800
Message-ID: <20260228220845.2978547-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[infradead.org,gmail.com,lists.sourceforge.net,davemloft.net,google.com,kernel.org,redhat.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262230-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[infradead.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rdunlap@infradead.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:mid,infradead.org:dkim,infradead.org:email,davemloft.net:email]
X-Rspamd-Queue-Id: D64541C9603
X-Rspamd-Action: no action

kernel-doc reports function parameters not described for parameters
that are not named. Add parameter names for these functions and then
describe the function parameters in kernel-doc format.

Fixes these warnings:
Warning: include/linux/atmdev.h:316 function parameter '' not described
 in 'register_atm_ioctl'
Warning: include/linux/atmdev.h:321 function parameter '' not described
 in 'deregister_atm_ioctl'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Chas Williams <3chas3@gmail.com>
Cc: linux-atm-general@lists.sourceforge.net
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>

 include/linux/atmdev.h |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- linux-next-20260213.orig/include/linux/atmdev.h
+++ linux-next-20260213/include/linux/atmdev.h
@@ -309,17 +309,19 @@ struct atm_ioctl {
 
 /**
  * register_atm_ioctl - register handler for ioctl operations
+ * @ioctl: ioctl handler to register
  *
  * Special (non-device) handlers of ioctl's should
  * register here. If you're a normal device, you should
  * set .ioctl in your atmdev_ops instead.
  */
-void register_atm_ioctl(struct atm_ioctl *);
+void register_atm_ioctl(struct atm_ioctl *ioctl);
 
 /**
  * deregister_atm_ioctl - remove the ioctl handler
+ * @ioctl: ioctl handler to deregister
  */
-void deregister_atm_ioctl(struct atm_ioctl *);
+void deregister_atm_ioctl(struct atm_ioctl *ioctl);
 
 
 /* register_atmdevice_notifier - register atm_dev notify events

