Return-Path: <netdev+bounces-251790-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sC8EA+iBcGktYAAAu9opvQ
	(envelope-from <netdev+bounces-251790-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 08:36:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id ACCA352E1C
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 08:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 33BE7427764
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 07:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1662F352955;
	Wed, 21 Jan 2026 07:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YLYnC06N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937F62D1907
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 07:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768980962; cv=none; b=SW+w0j/pjYFCacHOaKg8CGKJjfY+HZ3jSxDJkDmeXv/E/a8t31xqKLTsUBp75T3H0spZO41kEr5gMAVatc0e+2FcwoQJNc2SxFVPas4gTccDPPhqSHknrRh6TgwoBv0iNkpMrXpFFPkNU3ozTCzyjSWwXYZWpA8MPP+EaZdcZqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768980962; c=relaxed/simple;
	bh=MrSwmIU7kZjNYfDwxuwBTlli+h4q7/oMI8OHyq27Iwo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eE3gHl7o7EEUBEXSM+Hdoed7+e4FmgsUZl/vSNfBakny/OYLdMU2QTOY8mubl9e5GGQQp132+hKZiXiKK83tL64CSJGcke5lhMftAPq4jqXYCxXcr+klnLnFdaLXQqmDrPGTLTkFUN24D3uVs/3CM6SWPDAxVO3eiOMHxkbFk8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=YLYnC06N; arc=none smtp.client-ip=209.85.214.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-2a7786d7895so8463395ad.1
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 23:36:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768980960; x=1769585760;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8S4gXj/gzk/19UtVj+ukSje9Ia0BXm/b5XYecV/QOrQ=;
        b=b1zthwp8Kh+jGX9z7z/x6ATvnn52lLWP5ou6PUqgMffRTv8eSEoSS/+laTptndoCJk
         SpP1b/ouF+mWMXSu3KfNBIpd5YEpDCoa5O1H3Fxe+ZxhWPguHupOGxTr8u9ho15rWBRm
         iJrAzmlDaeNuuxW97w9vI2CEeitkQSwR2Qsu6ndSPUQ+onBEPoct4X+M+BVwHfCQKn3E
         kT6bOTRjb44/Hvg/hWMuIS7Y1fp/IRXAK1d3dnxphbYkqFc17U53ACP7ROdp0QAidr1/
         9ij6hf8dMt301WUcS0yWHkic3EZvS8SZXjfdd9m3ypiqdusqLKAyTFdEC3IW3Fi8Kh2l
         7P3Q==
X-Gm-Message-State: AOJu0YyWFmqMV8kPxZMFLd+Q8fVdgWbjS9mvLE82TzVSqS6mYEUDkkMt
	5IYbhnu8k0yhyV/t9ATHIywIfrSsYARiPxD/Cx6ct/WQxsEMgRdkbTXi9PFtgwGnSWdAnJHbS+q
	exU75YpbzDQ5dt4eY8ngFVU3LafE+8eJzf7l7ad4rUSpLH0jt9SkeqQ9ao7AD5Afof8tF1hovNN
	bxaC7PSGS/f6Wd67LRHXV+TVJTdEy5Snu4bq8DqrlnYbHIrT3knQHr6YI+GJJGZJAcX88vigFEI
	WW8dJivuQ==
X-Gm-Gg: AZuq6aIUna0LpjPwgJ0kr88dGzcmdBhCr5T4FzN8KeR1H21aXy3l6D0wFhszgi0cDPT
	AHWI33VBT9QprzwRn3XYAzzsfdFG2HgWa47sbTmCcpeZo4d5Qy0rqnOcvsU6ZgG8M0eCdwmcU1L
	DB2vsqq6EoLjiRFYmZg9wlkk2w8TONOu9ac0wlQ7WDpeGxRExsrI9Fh4Nk7bwp3q7m0FbO9oUqr
	kDwRAAuey9DGr6UF0zBGk7iLm1BTqcexkycZ50Fq0AQzO41cIfDUsO55s7N3RXqH1B130UdeF3H
	2pLSMOhITWXs3/9sfBvm3VLqxndE3zZAtbyK2t/9Djelhj9qbiOhAsyZtGApREeLqD6+dlhOw1X
	xMi38PmOBLzU6fBbSwSXEn5e20AmEk5Djj0yycdetgMy+GsxdQep7EHshsi8PwsWbulCcCwHIg0
	XPasXwGROkP8zPeU4Cj1uH+YjzXKCYkAF5Tabrw6oXgiU=
X-Received: by 2002:a17:902:da8f:b0:2a0:9d16:5fb4 with SMTP id d9443c01a7336-2a7188896d2mr183702685ad.18.1768980959818;
        Tue, 20 Jan 2026 23:35:59 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-72.dlp.protect.broadcom.com. [144.49.247.72])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a7190a250bsm22042625ad.5.2026.01.20.23.35.59
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Jan 2026 23:35:59 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8946448adbdso40584896d6.1
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 23:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768980958; x=1769585758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8S4gXj/gzk/19UtVj+ukSje9Ia0BXm/b5XYecV/QOrQ=;
        b=YLYnC06NJIWjSeAJboUmn68muCXL084dBSwdpT1LsGTGGuZzAvQ8QLLl+nAf8O5v6q
         vqXJWzmSH+NuiVw46mfTVPFVyffH0ThPX+iLYYcIJAKVE11940L4yfHyvOr2vw6eaJs9
         Rvg3RSbM4cPJVHUN0+eOPB6cEMvWB0U6L4s/Y=
X-Received: by 2002:a05:6214:518e:b0:894:6cb7:da9b with SMTP id 6a1803df08f44-8946cb7dda5mr46464836d6.26.1768980958522;
        Tue, 20 Jan 2026 23:35:58 -0800 (PST)
X-Received: by 2002:a05:6214:518e:b0:894:6cb7:da9b with SMTP id 6a1803df08f44-8946cb7dda5mr46464656d6.26.1768980958172;
        Tue, 20 Jan 2026 23:35:58 -0800 (PST)
Received: from lvnvda4076.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894592ba642sm51439736d6.57.2026.01.20.23.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 23:35:57 -0800 (PST)
From: Kiran Kella <kiran.kella@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jayakrishnan.udayavarma@broadcom.com,
	ajit.khaparde@broadcom.com,
	akhilesh.samineni@broadcom.com,
	Kiran Kella <kiran.kella@broadcom.com>
Subject: [net-next 0/2] psp: Support PSP Tx on logical devices like VLAN
Date: Tue, 20 Jan 2026 23:35:15 -0800
Message-ID: <20260121073517.3323332-1-kiran.kella@broadcom.com>
X-Mailer: git-send-email 2.45.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-251790-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_NEQ_ENVFROM(0.00)[kiran.kella@broadcom.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[broadcom.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DMARC_POLICY_ALLOW(0.00)[broadcom.com,reject];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: ACCA352E1C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
 #   Set PSP enable on device 6 to 0xf
 #   Set PSP enable on device 6 to 0x0
 
Kiran Kella (2):
  psp: Support for transmit on logical device when the underlying
    transport device supports PSP.
  selftests: drv-net: psp: add test for VLAN sub-interface

 net/psp/psp_main.c                         | 114 ++++++++++++++++++++
 tools/testing/selftests/drivers/net/psp.py | 117 ++++++++++++++++++++-
 2 files changed, 229 insertions(+), 2 deletions(-)

-- 
2.45.4


