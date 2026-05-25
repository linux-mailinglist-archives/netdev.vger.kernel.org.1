Return-Path: <netdev+bounces-291305-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sI2TLiNAFGo3LQcAu9opvQ
	(envelope-from <netdev+bounces-291305-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 14:27:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AAE95CA792
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 14:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F5D0303308C
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 12:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44DD93806B6;
	Mon, 25 May 2026 12:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="RASC9K7/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-71.smtpout.orange.fr [80.12.242.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833B2381AF0;
	Mon, 25 May 2026 12:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779711877; cv=none; b=Z16TUqOE69uWqIpNJFlvoIdkPxNLY3rYRWC7/TqlQ2ruQ9crdK4iRpEO986qZMpG+CCRx2ZhwarmKGOG9mqjEYuXBWniR32aeQQL9MS8sB3/QU2e4tDA5p45nH7jBB3enlqRE248vqKfbEhuv8mC0TtBU8hMUq6uGE0QwXMUzfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779711877; c=relaxed/simple;
	bh=6Lf9rTVqmT2MFhxoqT3iHGX6OQQpUWL2dsRdkam0Sgg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kk1rrtCWgG0vn6NESIy9X27b90Jq0zqYGll3JRgu9r+sFvuXSGz0sKiK3zm6vK9fJpalbFARxWTnUPe5QlA0SV+8Z/Gis6ihjL/9n0c4fa+WN4Z9yXQOvTlxGAqLq7ot4VIvFUFbA1yxTxhFlihz2dEkIkeA2GUYKO8uvFfYGYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=RASC9K7/; arc=none smtp.client-ip=80.12.242.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([10.65.86.59])
	by smtp.orange.fr with ESMTP
	id RUL6wlWOiYXA2RUL6wAVRV; Mon, 25 May 2026 14:23:24 +0200
Received: from fedora.home ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPSA
	id RUKswQkLW4u6pRUKswqNto; Mon, 25 May 2026 14:23:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1779711796;
	bh=m/R8tIupwdX7jr/A/rbgZTkdQCVVpjuXnm7Y+aWrBTk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=RASC9K7/vqJDXtXIjmeBvHKBP27uN67YvEpWjaj7UIADGAn3HydAvmno88qyNvJBW
	 +61G0IsHID67iGz+EUGteKCg95vE1KQExy7KvfCj6dCtF7g6+tcqHItMCdOjILhWSZ
	 XPOsyi/vf85SutuJpuymUuCX24pygOx019ER4hgfUsFdFeK0uWgecpz10pO0zSm3Wq
	 19I4MDJb4VrO3Yk0nXv+dA7OEYOK/ZZ3G0x9CaPpkBiyuQixq+/Saiv0rD/QzA4GMa
	 tlS70uAw+pW/d0fjnG9fC4x4OMKJ1ygd6rJm0FIbTZxSzVQQzGb4ZzKtXYRoMq49fn
	 UecsywFdsLlFQ==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 25 May 2026 14:23:16 +0200
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Breno Leitao <leitao@debian.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	netdev@vger.kernel.org
Subject: [PATCH net-next] netconsole: Constify struct configfs_item_operations and configfs_group_operations
Date: Mon, 25 May 2026 14:23:00 +0200
Message-ID: <7ff56bdb0cee826a56365f930dcdf457b44931df.1779711734.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[wanadoo.fr,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[wanadoo.fr:s=t20230301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,wanadoo.fr];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291305-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[wanadoo.fr:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[wanadoo.fr];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christophe.jaillet@wanadoo.fr,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1AAE95CA792
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

'struct configfs_item_operations' and 'configfs_group_operations' are not
modified in this driver.

Constifying these structures moves some data to a read-only section, so
increases overall security, especially when the structure holds some
function pointers.

On a x86_64, with allmodconfig, as an example:
Before:
======
   text	   data	    bss	    dec	    hex	filename
  64259	  24272	    608	  89139	  15c33	drivers/net/netconsole.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
  64579	  23952	    608	  89139	  15c33	drivers/net/netconsole.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only.
---
 drivers/net/netconsole.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index d804d44af87c..8ecc2c71c699 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1264,7 +1264,7 @@ static void userdatum_release(struct config_item *item)
 	kfree(to_userdatum(item));
 }
 
-static struct configfs_item_operations userdatum_ops = {
+static const struct configfs_item_operations userdatum_ops = {
 	.release = userdatum_release,
 };
 
@@ -1319,7 +1319,7 @@ static struct configfs_attribute *userdata_attrs[] = {
 	NULL,
 };
 
-static struct configfs_group_operations userdata_ops = {
+static const struct configfs_group_operations userdata_ops = {
 	.make_item		= userdatum_make_item,
 	.drop_item		= userdatum_drop,
 };
@@ -1370,7 +1370,7 @@ static void netconsole_target_release(struct config_item *item)
 	kfree(nt);
 }
 
-static struct configfs_item_operations netconsole_target_item_ops = {
+static const struct configfs_item_operations netconsole_target_item_ops = {
 	.release		= netconsole_target_release,
 };
 
@@ -1480,7 +1480,7 @@ static void drop_netconsole_target(struct config_group *group,
 	config_item_put(&nt->group.cg_item);
 }
 
-static struct configfs_group_operations netconsole_subsys_group_ops = {
+static const struct configfs_group_operations netconsole_subsys_group_ops = {
 	.make_group	= make_netconsole_target,
 	.drop_item	= drop_netconsole_target,
 };
-- 
2.54.0


