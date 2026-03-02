Return-Path: <netdev+bounces-262791-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLZyAQ7spWlLHwAAu9opvQ
	(envelope-from <netdev+bounces-262791-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 20:59:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A10C31DF096
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 20:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF1893047436
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 19:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25B93859ED;
	Mon,  2 Mar 2026 19:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="X0mzwRe6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f230.google.com (mail-qt1-f230.google.com [209.85.160.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC5331DD97
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 19:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772481261; cv=none; b=IIyMPRkcaNFYoqLD5O8h2y3wgtqjmZCV2Bys4YrOaUE+A8CigLCBiW9TxcDxvlODQigkTuaHa+TohN5Jv4s/Xow9H563O3pl2/dFSKlk+fDHrQQryjwB/xX6yg4+1dSG0ib2Nek+jjHhSEXoJabPwMHePX/7urUaeUXLkXIuIrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772481261; c=relaxed/simple;
	bh=LzqPu7L6T4YwFwjXpkufWilIbKqvpyASAL/dATsZvWU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gIaqIo5yWSTzRbMosvkWLyQsNGNqQGmQ3i2ynlLXdFRvkWt60D3jsyO321M0dDrF80jQwW9E/JL4x/f1pznyr2O5nSUCIo6872Py6sRPYGdOxuHOerbA1i8JLE1p++pWlGYW46CTivnF8Aq30vRY6m2DrIcT6bVuqQxkJoLAcuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=X0mzwRe6; arc=none smtp.client-ip=209.85.160.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f230.google.com with SMTP id d75a77b69052e-506cb1b63d0so59712701cf.2
        for <netdev@vger.kernel.org>; Mon, 02 Mar 2026 11:54:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772481258; x=1773086058;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kp62pTRO4045l8GHJKeT43ykB7HAFj8ocijoq9c4Eo4=;
        b=OhcHuVkbCueTnA1tx7dI9P7o5WUVMQySym9UsbCQR6Ubec/5w1ZCtXSxM/L3q8L/Ji
         rJ34UPcGn7/7euyeSPkGZggnQvabVddjF9oOdEpaSHQ0r1FWvLxWKkSFVY6c++6LIQWm
         /+kvHspMv6teYFQwaYncO/CNnmvF8ZRXvgihLas0J+ncfSQXp5FYCwV6eANkdMUHxwft
         6l5j9gkZMH+zIpG2RBBAAhDCBHgZ+mSIsBgcQjC742LbdQyzpBfvjjb+mT/67IvcV6DH
         I4xMtOLLMhRUiklrcEHv1u5JRoH2MDdYWL9KmTpfhorEcBc8E39dTWY+afI0dtGxxy5j
         9FlA==
X-Gm-Message-State: AOJu0YxI35tkyOZIeimztbslyl1bxNAaKh6u2y5Y1apxElBOD5D44OtT
	2efb6ZOp9cd8D9rVvxNKuYkxNP4QmN/+oXOXMlV4rQxf8GMXkN+snuSUc6+bcRBsWrxtgA5PNAT
	iwElXIkkWh5gyr/L9NRKFMBrVvIrFAN3hDTQCtptVyHKGE+rKvfh3cmoSknR6H97CVgfrbexjNg
	iOkCCkN1i11Q9F3IWbYZc6LHD0rBDeyMxYlBsuThFWFEmwno30fSi8gfBxjd1gqW/QP7b8rwiwX
	tTS31y9vRgHtTjOE6ScslA=
X-Gm-Gg: ATEYQzzod5Yjv9i2pu95u56ZwMBHhPFWfJoN7efLR8trZyWs2B7pe+IWMuf+g5fsejW
	KvgTNWKhIrJVlJuDv7bGtzpnKa5AUTKH7pzItWXsSPSJ1gBvJb+6XHptzOoPxeO2J2lY6DH6oWk
	leGaWjYtdEHxojpkFrRB7POhK9YVPpD4t3+d5H/vqXJnJllEQuR4yaOtR6BrtDE0UwkhPIwnDgt
	3OovFsLnjM5VNTPtSPq/0Y2CgLB4EMNQQ/+GlbaGgnRnHdv5YnvksLjDh5Bc84L4ksnOlsyesBB
	Yws+9O5402xk0+PW2CiCgpxUC9UsTfpPYQN234YtYP7kGORBEZ1cHVLQkzi4ndGWB8ZmcUobvmk
	Kq3eNyODIdHmgPBHmS4WQYa+uxdzLpYXI2QL0cfLWN3u4dgLs/rjUnjOFRX99ZfwHolJMlqRDZM
	6lcge1pVmnD/nm4duPt4/z4WOw3p9k+GzZrMkWKz8ubXeicFpTHrP8DJE2S77owfwFYQ==
X-Received: by 2002:a05:622a:313:b0:4e8:b446:c01b with SMTP id d75a77b69052e-507528a69d5mr201327561cf.61.1772481257618;
        Mon, 02 Mar 2026 11:54:17 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-899c732a408sm14607236d6.18.2026.03.02.11.54.17
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Mar 2026 11:54:17 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-899afef8eebso693891626d6.3
        for <netdev@vger.kernel.org>; Mon, 02 Mar 2026 11:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1772481257; x=1773086057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Kp62pTRO4045l8GHJKeT43ykB7HAFj8ocijoq9c4Eo4=;
        b=X0mzwRe6/a8+v1zuBDNJWlaMdvY5g3nSMGqcS51v/O/JxP/gshC2Db5UaGPPa00oct
         jrco2RrxJZ/SzpTMFCvwko9mZSfUr/3RYQ4n6MqhZ6Pvta285qjJVYZlEx9g7n0fDflC
         PyTghMTsAO3zZ3AinnvzsY+Lz1ldFfpR9GXT0=
X-Received: by 2002:a05:622a:313:b0:501:4cd0:a486 with SMTP id d75a77b69052e-507528a59b2mr180401781cf.54.1772481256857;
        Mon, 02 Mar 2026 11:54:16 -0800 (PST)
X-Received: by 2002:a05:622a:313:b0:501:4cd0:a486 with SMTP id d75a77b69052e-507528a59b2mr180401551cf.54.1772481256386;
        Mon, 02 Mar 2026 11:54:16 -0800 (PST)
Received: from lvnvdb0691.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf736cfasm1208049285a.49.2026.03.02.11.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 11:54:16 -0800 (PST)
From: Akhilesh Samineni <akhilesh.samineni@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	willemb@google.com,
	daniel.zahka@gmail.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jayakrishnan.udayavarma@broadcom.com,
	ajit.khaparde@broadcom.com,
	kiran.kella@broadcom.com,
	akhilesh.samineni@broadcom.com,
	sachin.suman@broadcom.com
Subject: [net-next 0/3] psp: Support PSP reset statistics
Date: Mon,  2 Mar 2026 11:53:49 -0800
Message-ID: <20260302195352.1015990-1-akhilesh.samineni@broadcom.com>
X-Mailer: git-send-email 2.45.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Queue-Id: A10C31DF096
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,lunn.ch,gmail.com];
	TAGGED_FROM(0.00)[bounces-262791-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akhilesh.samineni@broadcom.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:dkim,broadcom.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,psp.py:url];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

The series adds a netlink command to reset per-device PSP statistics
and implements it in netdevsim with reset stats in data traffic test.

Ran selftest for PSP :

# python psp.py
TAP version 13
1..28
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
# Totals: pass:28 fail:0 xfail:0 xpass:0 skip:0 error:0
#
# Responder logs (0):
# STDERR:
# #  Set PSP enable on device 3 to 0xf
# #  Set PSP enable on device 3 to 0x0
#

Akhilesh Samineni (3):
  psp: Support resetting statistics on a device
  netdevsim: psp: Handle statistics reset
  selftests: drv-net: psp: add reset statistics test

 Documentation/netlink/specs/psp.yaml       | 13 +++++++++++++
 drivers/net/netdevsim/psp.c                | 14 ++++++++++++++
 include/net/psp/types.h                    |  6 ++++++
 include/uapi/linux/psp.h                   |  1 +
 net/psp/psp-nl-gen.c                       | 14 ++++++++++++++
 net/psp/psp-nl-gen.h                       |  1 +
 net/psp/psp_nl.c                           | 24 ++++++++++++++++++++++++
 tools/testing/selftests/drivers/net/psp.py | 18 ++++++++++++++++++
 8 files changed, 91 insertions(+)

-- 
2.45.4


