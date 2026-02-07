Return-Path: <netdev+bounces-257795-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AKRbDxbQh2mSdQQAu9opvQ
	(envelope-from <netdev+bounces-257795-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 08 Feb 2026 00:51:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88BB81076C8
	for <lists+netdev@lfdr.de>; Sun, 08 Feb 2026 00:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC7DE300FECF
	for <lists+netdev@lfdr.de>; Sat,  7 Feb 2026 23:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA252DB7B5;
	Sat,  7 Feb 2026 23:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="I7jdaa3u"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f100.google.com (mail-yx1-f100.google.com [74.125.224.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9CE22301
	for <netdev@vger.kernel.org>; Sat,  7 Feb 2026 23:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770508307; cv=none; b=qOZVECzHjp2VxIJIIo0hlox6pM1nvj86WxRhOVtvg7Xuwuccx7eGRDJtZON2iuoJkf6/azmlMc13JiynDceGpaTIyILmlCR4ubCl0QO+OXAx5oA6sPr9KYGBk5L2c2LMf7+9kFj9k24Fixl//mQVveKDuakxeu0iqBEhCkXWR7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770508307; c=relaxed/simple;
	bh=6XGbCf5/55IPMXnV6BhtTG1l6WKe+ChSwbsWN1irYjo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tFsXL9NsUKXhlaCEwuc7/wo57cKYMk+F9m/gEqcM9CMtC+6TVsU+FsGdLYpR1hjbNxMvcRE3n8QRRymslpY221yqHDAAwppVq4hK6J0ZcH7VPHu+5sqNmI36tbdVYaw4zKmDotbLAnP+Bfv6eYrPRKTUWf03E5vHqMg8U/NteYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=I7jdaa3u; arc=none smtp.client-ip=74.125.224.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yx1-f100.google.com with SMTP id 956f58d0204a3-64937edbc9eso1785146d50.2
        for <netdev@vger.kernel.org>; Sat, 07 Feb 2026 15:51:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770508306; x=1771113106;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xM6NZmJKILgi3mhVNX0/F7SdpaYU59E77G0c1oTyXDk=;
        b=XptTK/aW1IANLJPdREqyaIV4F6Wji2reRNTEHoY717GuH434xNx07pWXH9JmWp73Wg
         n7RefAy/3cV0A8qBAXRruXkP3UgODXRcO8pKprLxjKThktmknKlTsMTP2Ah2V/AHrbxw
         2dbPrlLpf8eMzRvyVhsDnIKNDlBMPDqzmLTIoNUVqNk1FwgJuqjsyHrueYFpB2K/L8MX
         UkK5YJ9O7vETzuanQTeDBcP8M+NNAwPI3ULBD9Prf63NKrMJykgEIUvMtj8GWpuAbcdU
         YtfIkaC66rJciliSowciMTMv0J5V9Rn/fvl7HpajGpVvQiHQB4mFH7L/j4mnfeDpRRTd
         OCQQ==
X-Gm-Message-State: AOJu0YzDPZ8Ddpui7JLtc63RTKn9KrYRYPMbn52kFZyba4A/ktE8YvZw
	K5KQ61eYTdh25uw2za9uddLhVo0ppIvvqEXfZS26jX4hFH1eya4imlXUhie5BZuGmJjuB5++I6F
	6w5CPecNJlRz0ka0oQyLgcJljJeqSaltw4L/96eeK8dOC0USPsmJh0kBACx1e1cycUuVTtd4caj
	ce0BpEa+vAQgBf8+HGdBkCpGGkzk8pIuZ+cQvwIUcqHF8pLJnocDhmRszJ2hefZNBT+D4/Knbyv
	Eq3Je2Xh1E=
X-Gm-Gg: AZuq6aLJRnNTYzq9PEfSnBZUNMerc2JXsk54eV8ZIHobXZ41rNolvkhStBJWUQod2hl
	3+IbEydNhNM88y7lnaJ1FVjj4el8gDxfngMPC2i8jJsjf25ados4Vx+NuBQgzR5yjTZjp3cSryz
	qZo+tsDFO0912FJ3YSg05E52f0MqYJ87cYgLgT3spKNQVJrFh4fOASrJ3ba+kdeC8u+Avf65Qtl
	EW93N92CgJi0VvyRxvvXnwHAQYNWpJIr+YskadL2xTFMoIzOo41VBDYoOtCUWgDBdd7z6nZTgYl
	YLuKYuZUgH0+TylPxrlIvJlRTbL2DMeDawlpTi4Ktgq+EEQaorP1jrfKQBmZHGXnMzPu/jDlS3z
	t3ju3HB5MXChdW1QTQWcyzM2vlMUDOu+VzBdt093hmOKq+2+SaFK+yN4WdykWdix49fdSh8QMN5
	JJuVg/2X4GUeCl7Hm3ghGvSJKP961ho0IdF9y7WIjO17ps
X-Received: by 2002:a53:ab45:0:b0:649:45a0:a29a with SMTP id 956f58d0204a3-649f2181305mr4655153d50.75.1770508305838;
        Sat, 07 Feb 2026 15:51:45 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-63.dlp.protect.broadcom.com. [144.49.247.63])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-649f24675c8sm545503d50.1.2026.02.07.15.51.45
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Feb 2026 15:51:45 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2b7a28264c1so2068506eec.0
        for <netdev@vger.kernel.org>; Sat, 07 Feb 2026 15:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1770508304; x=1771113104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xM6NZmJKILgi3mhVNX0/F7SdpaYU59E77G0c1oTyXDk=;
        b=I7jdaa3ui8w6ypOmenvO9rk5H4YNGxo4o2FJdVMsBKNGC5bbilMpIJ+6fG198uauae
         kwcGFwRO7e6fMtIqOtStMKWq8tlYKY1OVxOz4oyPLmk61LjfRlOjZgIrusC9KpjEUQav
         McH4nkz9+0dvUZN1Sy5SiY/rEO2GqHFVWGQAg=
X-Received: by 2002:a05:7300:23c8:b0:2b7:da62:a5f9 with SMTP id 5a478bee46e88-2b85649f824mr3719793eec.18.1770508303979;
        Sat, 07 Feb 2026 15:51:43 -0800 (PST)
X-Received: by 2002:a05:7300:23c8:b0:2b7:da62:a5f9 with SMTP id 5a478bee46e88-2b85649f824mr3719781eec.18.1770508303469;
        Sat, 07 Feb 2026 15:51:43 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b855c3db30sm4479446eec.21.2026.02.07.15.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Feb 2026 15:51:42 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net-next 0/2] bnxt_en: Add RSS context resource check
Date: Sat,  7 Feb 2026 15:51:16 -0800
Message-ID: <20260207235118.1987301-1-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257795-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michael.chan@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.990];
	RCVD_COUNT_SEVEN(0.00)[7];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:mid,broadcom.com:dkim]
X-Rspamd-Queue-Id: 88BB81076C8
X-Rspamd-Action: no action

Add missing logic to check that we have enough RSS contexts.  This
will make the recent change to increase the use of RSS contexts for
a larger RSS indirection table more complete.

Michael Chan (2):
  bnxt_en: Refactor bnxt_need_reserve_rings()
  bnxt_en: Check RSS contexts in bnxt_need_reserve_rings()

 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 47 +++++++++++++++--------
 1 file changed, 32 insertions(+), 15 deletions(-)

-- 
2.51.0


