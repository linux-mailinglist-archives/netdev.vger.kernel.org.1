Return-Path: <netdev+bounces-279396-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +ORdFcBy4mnR5wAAu9opvQ
	(envelope-from <netdev+bounces-279396-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 19:49:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C2A41DB01
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 19:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2AF78300D354
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 17:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2273603E7;
	Fri, 17 Apr 2026 17:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZiUcdxqs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EBC39FCB5
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 17:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776448183; cv=none; b=NescH8czVHD+/xrMQ/djbsd34+HRAiMZ22JyxhLWtNnbkFCroNrs3ej6GlgUaX6U8kbYxiHN3Arn44cbgZ9Z8c5/vUCdEF+YLRSxOc0wdyLqeIbmFJJf1YwdneoA2zj66/uUaaw7uuVC0Q0Pstd0tN4TRxXBxc25ThF2Sji2B18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776448183; c=relaxed/simple;
	bh=tAdlcRQThT0aO8/5Zua1LK1/+0KDjbglhVfgvGDjUeg=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:To:Cc; b=udHln1c/IuqsqpGy736XvyeuAFXJ8tItOpYMu6SKhVgY/GEDAQjwmjmj6KASd1MNyS0F2eC2K8+hFXE+t544AMcJrRXwiXFuSVX5eBTnOj/w2Gm6eaAFNyufLRgadMt+SZAVbX7OU9zEeD2/6tY6Ti4fIVJPkje/B8mIofFddhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZiUcdxqs; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c795f096fa5so422976a12.3
        for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 10:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776448174; x=1777052974; darn=vger.kernel.org;
        h=cc:to:subject:date:from:references:in-reply-to:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uwVV6/549C9ObZhSY3TGmlcvB54RDFmpSsT82OUItwc=;
        b=ZiUcdxqsbvXxo+p3Si0Rjwt8b2q+ZpxqKW9knUZ7Humiy+PwDVNdmzvTCjuR3BPpE7
         is3zA8dB5jip+P4u4mJLxnLIQf3lGnGevzdENFtg0tzPDCbYo59bYl15MFnxKC0K3m0D
         bXkPi0wE4hd6YCESu+HsLyfhHEVL7T9WeKy0Bt5LL1hCtOPscEEk1QFkdZXKspVIwacf
         UmpJxMQU0hTXeauNoceYAiU8dyWuSurnsvnMmuQ5B7ZNcqjWkuNmJ+7xlsM7Qb4zFuCi
         l9eNyksRqgz+cmE1ihEglVsOFNzCTd1sD7JWOxNh36FaTca7k0zeoYlE6c+CCifmqVc8
         fuhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776448174; x=1777052974;
        h=cc:to:subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uwVV6/549C9ObZhSY3TGmlcvB54RDFmpSsT82OUItwc=;
        b=AT/PjgSb+htsLU+wEc+p0GEpEL5dueQQD/8vI4tNTP3/mDuemWIssV/YAeO0P/w5m6
         H5sYPx1WwOBlgjHvPfa0/tL2A2qRe2UjGRfLMfAv0gY4FeEXTRl6b9UtyBBfupbwvQI3
         LP/1BaZr+xhY0aVDvtuvDlmaD3A4XmO09ekkR/1agzso0Y7GiAA1Mq1ZEBFfVVUJVzHN
         XwTAS2zinXFEd5pR577ZuSJ/mg5ZRQqqdMMMNas3qQaL7gUHuus85IEohs87rdvheF8+
         sAKdeKuBzKsfLfiKA6uoVlNk9bi+8ZXR4OZnWD9V9xzu0mM0Xf219DUC/ZdNSe/PE1SJ
         F81Q==
X-Gm-Message-State: AOJu0Yyrn1oL2zadCaRnCO65DIpWjLxBdqmWIQr6tJjMkSpP6DJsbSzR
	p8ceiuNw4uItYX+EAvfJEQ6ZUKPfzuxWShfkCjLUJVxzD0+hUgs7SECBqIcJsw==
X-Gm-Gg: AeBDies1KBzFZv2eaC6UOiqbVAXMHWlAOjJCJrWccVyu2oLccKTSXyCvXmkZhsJ+CKP
	SRNp8w5Xmw6KIEIQlXOLSXVHBc+1JH1pRVctzLmXySFYmy+XHdi9VVG6fYY2B6qU5C36eKf0sNw
	2plY4u0ZOqPlyi9RUgHJ1RJjSxSw2PgYt2YeTMXYajnrr0DQZPwAx+Z0LaLmivlPOelbGZU0kbm
	/P9ybH0CqS42Y3Kr1i7MEdI2LE6uN/GsK6FCVoL+O9aEoyxvHE0BU1G1gCheBOZilj+5cTau1rx
	7Hqg5P2N/+t7epwxGtn//ey+q6AXrQsGCP+JdRej5poQH9EhGVP8ECdR8He1yIVndPvGD/hilt+
	xtol7gNqDDl0XrpVshV2pgHpzUZaRTHtgyEnd6b4+3NyRNw7DJE4kPhmXR3els4mQdnRB/ZjywQ
	gzXGHuQ+Z6cXzuNjEhFwJ8DvC9ZbHYXcQJ+tXdCIIsDdzsFAzpjfTDCfTetTkAwX9fcrUYf11cg
	Gfp1vcoM2ABk4DN+E6S/UOsrss=
X-Received: by 2002:a05:6a20:3949:b0:394:3001:8b59 with SMTP id adf61e73a8af0-3a08d8fb8bamr4540797637.53.1776448173940;
        Fri, 17 Apr 2026 10:49:33 -0700 (PDT)
Received: from Shuvs-MacBook-Air.local ([43.245.86.86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ec23b19sm2949913b3a.59.2026.04.17.10.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 10:49:33 -0700 (PDT)
Message-ID: <2325518b6d24b62e50629473e1cee5563f21a15c.1776446840.git.shuvampandey1@gmail.com>
In-Reply-To: <cover.1776446840.git.shuvampandey1@gmail.com>
References: <cover.1776446840.git.shuvampandey1@gmail.com>
From: Shuvam Pandey <shuvampandey1@gmail.com>
Date: Fri, 17 Apr 2026 23:34:25 +0545
Subject: [PATCH v2 2/3] mISDN: socket: drop temporary references from
 get_mdevice()
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279396-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shuvampandey1@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,dn.id:url]
X-Rspamd-Queue-Id: C5C2A41DB01
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

IMGETDEVINFO and IMSETDEVNAME only use get_mdevice() for a temporary
lookup, but neither path drops the reference returned by
class_find_device().

Drop the temporary reference once the ioctl finishes. Serialize the name
read and rename paths with device_lock() while doing so, and reject
lookups that raced with unregister after device_del().

Fixes: b36b654a7e82 ("mISDN: Create /sys/class/mISDN")
Cc: stable@vger.kernel.org
Assisted-by: Codex:GPT-5.3-Codex
Signed-off-by: Shuvam Pandey <shuvampandey1@gmail.com>
---
 drivers/isdn/mISDN/socket.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/isdn/mISDN/socket.c b/drivers/isdn/mISDN/socket.c
index bf3ad0a2a42bc..42cda5b8bbe16 100644
--- a/drivers/isdn/mISDN/socket.c
+++ b/drivers/isdn/mISDN/socket.c
@@ -484,6 +484,13 @@ data_sock_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 		if (dev) {
 			struct mISDN_devinfo di;
 
+			device_lock(&dev->dev);
+			if (!device_is_registered(&dev->dev)) {
+				device_unlock(&dev->dev);
+				put_device(&dev->dev);
+				err = -ENODEV;
+				break;
+			}
 			memset(&di, 0, sizeof(di));
 			di.id = dev->id;
 			di.Dprotocols = dev->Dprotocols;
@@ -493,8 +500,10 @@ data_sock_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 			       sizeof(di.channelmap));
 			di.nrbchan = dev->nrbchan;
 			strscpy(di.name, dev_name(&dev->dev), sizeof(di.name));
+			device_unlock(&dev->dev);
 			if (copy_to_user((void __user *)arg, &di, sizeof(di)))
 				err = -EFAULT;
+			put_device(&dev->dev);
 		} else
 			err = -ENODEV;
 		break;
@@ -802,6 +811,13 @@ base_sock_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 		if (dev) {
 			struct mISDN_devinfo di;
 
+			device_lock(&dev->dev);
+			if (!device_is_registered(&dev->dev)) {
+				device_unlock(&dev->dev);
+				put_device(&dev->dev);
+				err = -ENODEV;
+				break;
+			}
 			memset(&di, 0, sizeof(di));
 			di.id = dev->id;
 			di.Dprotocols = dev->Dprotocols;
@@ -811,8 +827,10 @@ base_sock_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 			       sizeof(di.channelmap));
 			di.nrbchan = dev->nrbchan;
 			strscpy(di.name, dev_name(&dev->dev), sizeof(di.name));
+			device_unlock(&dev->dev);
 			if (copy_to_user((void __user *)arg, &di, sizeof(di)))
 				err = -EFAULT;
+			put_device(&dev->dev);
 		} else
 			err = -ENODEV;
 		break;
@@ -826,10 +844,17 @@ base_sock_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 		}
 		dn.name[sizeof(dn.name) - 1] = '\0';
 		dev = get_mdevice(dn.id);
-		if (dev)
-			err = device_rename(&dev->dev, dn.name);
-		else
+		if (dev) {
+			device_lock(&dev->dev);
+			if (!device_is_registered(&dev->dev))
+				err = -ENODEV;
+			else
+				err = device_rename(&dev->dev, dn.name);
+			device_unlock(&dev->dev);
+			put_device(&dev->dev);
+		} else {
 			err = -ENODEV;
+		}
 	}
 	break;
 	default:
-- 
2.50.1 (Apple Git-155)


