Return-Path: <netdev+bounces-272204-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QAmYCpKAxWkk+wQAu9opvQ
	(envelope-from <netdev+bounces-272204-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 19:53:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A8033A70A
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 19:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9840B3081D57
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 18:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A48631DD96;
	Thu, 26 Mar 2026 18:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="U4cKbcjn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f97.google.com (mail-oa1-f97.google.com [209.85.160.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7F41EEA31
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 18:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774550738; cv=none; b=TgpBHRAwUBkIK40dbibM46KA5eUB5d4zMRWg+Mg1riitNMQysZPE1NZzvdzBEhOSRWARBvBtBKQaha2JdGTH8QeFJHShUWsM6rM5zi8hUA7rv0xb3SjvvN2npQsU+EIZF5YVkBHtsvrydeqUQaTFFAJRPmVg0Yl5URv39oQRKIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774550738; c=relaxed/simple;
	bh=V/GjqZH4rjxtP7x5E1P4bNL232mVbPZX6U//n3DBWl4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ozd750ukJFnttywkCWRUqNhn3JBru/3QaUJb59d55BV69oZKR/tUndGEadNzLuTjFaFTHW56KX3EOxgwWYePaoAwoFgdFIKKNcLaq2BT0WU4BkSs+n0/DxmfgKFvW8CnlKtQYeZa23w9+0ObNCSR78nQeRCeEwvHUqo7cLBVdDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=U4cKbcjn; arc=none smtp.client-ip=209.85.160.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f97.google.com with SMTP id 586e51a60fabf-4043b27ddeaso846713fac.1
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 11:45:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774550735; x=1775155535;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xj6tHuIrKi1GnYuJLo39zeLEPdnBN4JvZ3maNjgQkx4=;
        b=IcyuDES/xI8qrX50jv1yU3XB8LIVsVP6idmsWzdm0dQc+cPxinCjUKCS6poW/azJhw
         3SZu4hA48D6G6ltvvPjJsxHSFOpM5Op3B9by4RR10i1Q1mXMGSzfJwL8H3fV1WzOwTuf
         9ACqR267wIU8UwbCC9cWFkBT7A+kNqaer5XvlXZQMDrcmgPNAVdZUUjtLtLcKt+QK411
         AKtjjnbOS75KfQm5CN9/nZAh3IDuTcoLBdP/qhwBbsbRsPoohcwT/1TmpSsKYl9lHt3T
         UOq7R6VxQzsnx0V/UKUfIRGD1LUOcCwrJUvQoh4b8Cm2XEiDhqt9GUzAorAXyn3Ipqie
         1deg==
X-Gm-Message-State: AOJu0YwAzjMgx+n7+ENchM5l8I7zF/mBzOkfEofYcQVF0ov4ttmrqwwn
	9QouKXjM/yotDDCIjuaQ5HMw6r5+DTuCZV1IhcfXwuhPHz3bLe4luoJgQFpvwwrVoIBNv2k8hHV
	TJliGiQ5Q6cOtGcQj7Q5rKTdl15J0kgbwityWYiebpH4lgCowIaEcrnDKACjKqQpJJf6aOU50uK
	SmX0jXYAHT0qXq5S63JYR2HGuiRzOWpE7u+Utm8LdJ53W8t/cUrkv8S8CmPAaTQE4r386cAAKQr
	TlwebXcOA==
X-Gm-Gg: ATEYQzzLzHJGH1ie6HY5o7tLb0EKLZMKM123hAEixJDlSzFQUlNFeVMrKS4+PZbVYtk
	1AI0wVhOO7p+omzFb/kaLw2e0RWDqx7a0OSCiG/hmqt2GuhessIeu2Wyv4PBhbp9bcLg5wh5Omt
	yDZs2ZLcn9U1DY+llSj+QJ6Oh/9ZBhszSbuazMkYyywXtAZ2ziw2+VpIePoKqzVLaR8eLgxpSu8
	dvAMSN7LTxeTpNa6ak1Hzf7QE6uBKI+SW7OLvG6gpZ3HQZm0rgtGUWG0AjkGU8OaK77ufYGprVJ
	RIypd/P5IfybOzmwc8DOcatxVpdCB2bCVPVPaj8GIOseli/sJfRtYG1Gm5MtM2wnp21RBGE9j0a
	qZvcmyaqyqlollBkWQHI0OP+7g+99evqgKy4p3SJyRsAod5F+UQWe0qeZKCGO24sH95yCLkEPzr
	4SCuqy63GsawLD4mvDk3RzvmY3fnNcyAOdK3WxMgOKCOTBvT8HhbATULQ=
X-Received: by 2002:a05:6870:c6a4:b0:417:6713:5dae with SMTP id 586e51a60fabf-41ca6fd5139mr4949257fac.24.1774550735518;
        Thu, 26 Mar 2026 11:45:35 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-22.dlp.protect.broadcom.com. [144.49.247.22])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-41cc76bd97csm429301fac.2.2026.03.26.11.45.35
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Mar 2026 11:45:35 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-89ce5eec0f0so6633366d6.3
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 11:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1774550734; x=1775155534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xj6tHuIrKi1GnYuJLo39zeLEPdnBN4JvZ3maNjgQkx4=;
        b=U4cKbcjnxCR1luVOAALnR6BbsyYExQTzUQPfQYY7vzcA9Jv+JRPhrEXVHKTEMAR0rV
         JUIzG0m4hod07Ak109Tgt4c1hIS8J/OXFFQNUZB0/RSTnOP6RT7nKR9uuGZtJc3yesUC
         g1cCyAq4+K3OYDzGR+4IgrybzYlBa4cRMLxQw=
X-Received: by 2002:a05:6214:61cb:20b0:899:c469:8943 with SMTP id 6a1803df08f44-89cc4af07d1mr100238696d6.55.1774550734227;
        Thu, 26 Mar 2026 11:45:34 -0700 (PDT)
X-Received: by 2002:a05:6214:61cb:20b0:899:c469:8943 with SMTP id 6a1803df08f44-89cc4af07d1mr100238096d6.55.1774550733646;
        Thu, 26 Mar 2026 11:45:33 -0700 (PDT)
Received: from stbsdo-bld-1.sdg.broadcom.net ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89cd5a18eddsm31054196d6.30.2026.03.26.11.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 11:45:33 -0700 (PDT)
From: justin.chen@broadcom.com
X-Google-Original-From: justin.chen@brodcom.com
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	bcm-kernel-feedback-list@broadcom.com,
	florian.fainelli@broadcom.com,
	opendmb@gmail.com,
	nb@tipi-net.de,
	Justin Chen <justin.chen@broadcom.com>
Subject: [PATCH 0/2 net] net: bcmgenet: fix lock up when queues time out
Date: Thu, 26 Mar 2026 11:45:27 -0700
Message-Id: <20260326184529.1393438-1-justin.chen@brodcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[redhat.com,kernel.org,google.com,davemloft.net,lunn.ch,broadcom.com,gmail.com,tipi-net.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272204-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justin.chen@broadcom.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 91A8033A70A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Justin Chen <justin.chen@broadcom.com>

We tend to timeout on our smaller queues. This will be solved later, but
occassionally when we hit the timeout handler the queues lock up entirely.
This was due a leaking and racing timeout handler that is now fixed.

Justin Chen (2):
  net: bcmgenet: fix leaking free_bds
  net: bcmgenet: fix racing timeout handler

 .../net/ethernet/broadcom/genet/bcmgenet.c    | 24 +++++++++----------
 1 file changed, 11 insertions(+), 13 deletions(-)

-- 
2.34.1


