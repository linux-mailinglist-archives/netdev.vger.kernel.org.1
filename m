Return-Path: <netdev+bounces-260169-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +LZTEYuonGklJwQAu9opvQ
	(envelope-from <netdev+bounces-260169-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 20:20:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C26B517C49C
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 20:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C465432F4AD0
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 19:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE2336C0C2;
	Mon, 23 Feb 2026 19:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hKOb5AqE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f98.google.com (mail-dl1-f98.google.com [74.125.82.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609F136AB6F
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 19:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771873928; cv=none; b=Q5Ik5/nEJFdyC5VqAsXZE+DnQWFH5ZPF9jV05nse4SQ0qSgpomuDVPcj7tzR32plzZmS1tm3qFopPVl0gaiKJ4LWEFv/jhL1Pa/tG4J7bZj6OmLndVd0+qQ1YR57+JVzclOgLV7G9IX5X6JTfQZkAsauqSBx4V7ZzJeNw1431zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771873928; c=relaxed/simple;
	bh=SCwe+t27d8QCPSJCzm+rQ6IUjffYevW8vs75ZU1hQVA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fna8APCbuFM5uJkv7rQEsBgM63f8our5/oPE//MLPU1U8HUdBegu4DHCiD9V7OBlzaIxQP2cBgKDtnTLa/wW9l7GPS+5VDzGgRxWYsNqJlELCaZnUPHBAteXmCniomn0hu5Oqg/jWVqSKT0mjkPiJJ0xm1EOFwCaH0bu7GXYrIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=hKOb5AqE; arc=none smtp.client-ip=74.125.82.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-dl1-f98.google.com with SMTP id a92af1059eb24-127423bea4bso768401c88.0
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 11:12:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771873926; x=1772478726;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rChNBXZrNe1CETweUbZuoEv1QuM46Wz/N53lv4Y4SLE=;
        b=p+Tq9BBueUMlETxJf89W1ln3pszqwDcknVz3DeYXQMjBybhuzNFkPM5g1UL/0Jm3tv
         EU31YZUKHwRDMUAYSsvhDX1x+xyEzzzAnN2Q3xVvBFZFsGWwCQ9Wl5Xl6qC++xWt7G2A
         PUPqjteh0HFiKWnK5Rum0ElxZcmRuvIKJGTA5+K/GFkqy5QlLtdoaVsLAEWFqoaTPt2K
         rS/yjhF0W8PWLZU0lUqmKFnhNLbeGzyBr3KKPeGnRKvaaBw+TLsgdGewKmpAVue39SD/
         pKDPfqjnbXQaQHYwW62SpYgzqCbAlFZUgyCz8lweImHco3ZeDrNdbcV5dJhnzo/vIlU9
         W1jQ==
X-Gm-Message-State: AOJu0Yw+ftbINXOqM7X5YmsQMYGbKF9oGDC/RlSb6Z+6beQElq6u5DlB
	Yv4IRz+R9Bep57NXUpzh68op9ocKbqk3PFdPl7ZXDoxpkOUlZGIe5yUUmonN+zW51/hbWWcv69l
	NiRi/yqi9sb2kCfQZiIs1ZzDkdCmXOQbbJdjAUl/2Ld5+e7dmUNiX0Y3G4tulqGBGjM/1LA0v1k
	I4B8hnO7XZmyVii6/eDpeLsmsn4TMivbE1XCqhXkWDXVIoOqdx/chvhY0wtgo6TdwXs4PwTrAXQ
	0GEvXL7XOZH
X-Gm-Gg: AZuq6aJ4615O/TyLMNLcarwMwSR0/z0IVGPfkIAGbhttG6lX8YEwYfL62Z2HSfuVDq5
	oNlpz5rgdrgNReBPpnbeStz/bDzHndjRZeFUZcU5lhs9Kfap7Xz9nm6dDMb3DktfJJU1viihaqt
	llpAJAROQQJXeOyjgDE0jqIjpVfzX4DpOPqwxJT17JktEckm12EOhhNOPY7ugq8ksFY9wkcMYY8
	3uukacNRs4GY2WO9S8f8Uwau8HdD2tqoT/eGKOiGO+/Tus41VCaH8BLsMrrD0JNtaXGwk6QZaq8
	PGJOUgSi9DCeFFMGAYelmgHSCEvMtSHJOJpnXkqDdfX3ZdtKbnOgHfdP6UkR4D6vTApkf+72T10
	EEVX/RX+fN6KjctS2ooa13AZXz288BveU/nQRtmaX8rbDeBY4qbZRpYbO0K9B4myQFHp+nYf27Y
	EBFg4jyP8PgMZNADngNle2xEdh3TV3Gd3zh4zkqtMVL6Vc1UTpKwGMTAnaWQ==
X-Received: by 2002:a05:7022:112:b0:123:2dd0:10bc with SMTP id a92af1059eb24-1276acb8720mr4595149c88.10.1771873926339;
        Mon, 23 Feb 2026 11:12:06 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id a92af1059eb24-1276af7557dsm1025780c88.8.2026.02.23.11.12.05
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Feb 2026 11:12:06 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-127337c8e52so18313933c88.1
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 11:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1771873925; x=1772478725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rChNBXZrNe1CETweUbZuoEv1QuM46Wz/N53lv4Y4SLE=;
        b=hKOb5AqE2qw8z5QAnZsErx+Wg4m9x8G2hPT/wRoyjn5HeMKlifXvplMSdDhQX3u4ym
         Y3jIYnRHb0nseVeU6sPMBDEa35UDVyD+gHL4IPBI2iB+GaYrdNyAiV099nQrf0YnSc7B
         Sv+rhVeaBW56Qwh/A1itR3HjdOPazILpf5MLk=
X-Received: by 2002:a05:7022:527:b0:11b:b064:f606 with SMTP id a92af1059eb24-1276ad1184cmr4436511c88.26.1771873924580;
        Mon, 23 Feb 2026 11:12:04 -0800 (PST)
X-Received: by 2002:a05:7022:527:b0:11b:b064:f606 with SMTP id a92af1059eb24-1276ad1184cmr4436493c88.26.1771873923975;
        Mon, 23 Feb 2026 11:12:03 -0800 (PST)
Received: from lvnvda4076.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bd7da3eec5sm5332734eec.4.2026.02.23.11.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 11:12:03 -0800 (PST)
From: Kiran Kella <kiran.kella@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	daniel.zahka@gmail.com,
	willemb@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jayakrishnan.udayavarma@broadcom.com,
	ajit.khaparde@broadcom.com,
	akhilesh.samineni@broadcom.com,
	Kiran Kella <kiran.kella@broadcom.com>
Subject: [net-next, v2 0/2] psp: Support PSP Tx on logical devices like VLAN
Date: Mon, 23 Feb 2026 11:11:52 -0800
Message-ID: <20260223191154.2800616-1-kiran.kella@broadcom.com>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,gmail.com,redhat.com,lunn.ch];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260169-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kiran.kella@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:mid,broadcom.com:dkim];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: C26B517C49C
X-Rspamd-Action: no action

This patch adds support to allow transmit if the bottom most underlying
transport device matches the PSP device associated with the
transmitting application socket.

  python ./psp.py
  TAP version 13
  1..29
  ok 1 psp.data_basic_send_v0_ip4
  ok 2 psp.data_basic_send_v0_ip6
  ok 3 psp.data_basic_send_v1_ip4
  ok 4 psp.data_basic_send_v1_ip6
  ok 5 psp.data_basic_send_v2_ip4
  ok 6 psp.data_basic_send_v2_ip6
  ok 7 psp.data_basic_send_v3_ip4
  ok 8 psp.data_basic_send_v3_ip6
  ok 9 psp.data_mss_adjust_ip4
  ok 10 psp.data_mss_adjust_ip6
  ok 11 psp.dev_list_devices
  ok 12 psp.dev_get_device
  ok 13 psp.dev_get_device_bad
  ok 14 psp.dev_rotate
  ok 15 psp.dev_rotate_spi
  ok 16 psp.assoc_basic
  ok 17 psp.assoc_bad_dev
  ok 18 psp.assoc_sk_only_conn
  ok 19 psp.assoc_sk_only_mismatch
  ok 20 psp.assoc_sk_only_mismatch_tx
  ok 21 psp.assoc_sk_only_unconn
  ok 22 psp.assoc_version_mismatch
  ok 23 psp.assoc_twice
  ok 24 psp.data_send_bad_key
  ok 25 psp.data_send_disconnect
  ok 26 psp.data_stale_key
  ok 27 psp.removal_device_rx
  ok 28 psp.removal_device_bi
  ok 29 psp.vlan_basic_send
  # Totals: pass:29 fail:0 xfail:0 xpass:0 skip:0 error:0
  #
  # Responder logs (0):
  # STDERR:
  # #  Set PSP enable on device 3 to 0xf
  # #  Set PSP enable on device 3 to 0x0

CHANGES:
v2: 
  - Simplified the psp_netdevice_event() to return if the upper device is
    bond device.
  - Handle the scenario where the psp_dev_unregister() is invoked by a
    driver before the unregister_netdev() that can result in stale
    psp_dev pointer in the upper devices. 
  - Fix the vlan_basic_send test to run on any lower device and not
    require nsim.

v1: https://lore.kernel.org/all/20260121073517.3323332-1-kiran.kella@broadcom.com/

Kiran Kella (2):
  psp: Support for transmit on logical device when the underlying
    transport device supports PSP.
  selftests: drv-net: psp: add test for VLAN sub-interface

 net/psp/psp_main.c                         | 109 ++++++++++++++++++++-
 tools/testing/selftests/drivers/net/psp.py |  86 +++++++++++++++-
 2 files changed, 193 insertions(+), 2 deletions(-)

-- 
2.45.4


