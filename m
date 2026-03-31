Return-Path: <netdev+bounces-273481-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGyNESZvy2k3HwYAu9opvQ
	(envelope-from <netdev+bounces-273481-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 08:52:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F47364A39
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 08:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D7D113025903
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 06:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58160370D6B;
	Tue, 31 Mar 2026 06:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Y9Ezqp4f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f226.google.com (mail-dy1-f226.google.com [74.125.82.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD5B33F8A8
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 06:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774939930; cv=none; b=KZacfqqTsnvytMkrRBEx1ygp+rOTvGi4/HqgjLg+iMnxtBoEh62fIt+d1PY0J3J8WrAooHIFPYDwu6vez4w6jUxp5o6hWtYcU7VTzPmL0fbFqm4ADUipgcAESUq/I+x2DMCTF/OpS/VZhWZLvkcb8YYNVyo9tErAGwwJpFg11wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774939930; c=relaxed/simple;
	bh=GVxd5IjFafUfOGuoYPi+Y+ZZQSrJN9Y0Lo1OlHU4tpM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SJivW187QTNgGiIe6KO0kYKmLJw791I6BjiLnoDMkUbQiYJowPc4trED2WtQ7b8419svBtnDi2JQWUKZ8IFFEogaKOZXFqTO4O592MmgqyuwKBvuDa9ZQ4OPUQ94hpTPMGHd6Ag7ksrFWfnfK5NAELvs19pEIOQ9Sp0ZE02wuqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Y9Ezqp4f; arc=none smtp.client-ip=74.125.82.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-dy1-f226.google.com with SMTP id 5a478bee46e88-2b4520f6b32so5859917eec.0
        for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 23:52:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774939928; x=1775544728;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GfUoQMl7qs/0maO60rGvUyuoerZJ3f6tiPGro7etRVQ=;
        b=ZgKdBod2revfr16q56KA1Ty/TASDGWAhMEyV5cNsjPrT5Yfci8nzF1Tq2hhIJAb6lc
         IZR4w8O7hCQOZ/69x735rLKSAyFNPbbJnbZZHHdKBmbqXi6mjqsAwQiP/MxekwYZ8S8v
         fDEK5WBmePRX0ZfqqnBABmsiX4bHo9xOGVv+iKjsoBjqLlGYB0WQGr0F6xjJ7QsPiUla
         X1qwAAEaykaU4x5be9fCO7h/RCVbu4WwYsqeNtKAKHrK74d2JrjmRv8/MWjw6p32o5Qf
         Rp2jUe4/+tSZsxYR4fwdifWzuPblnVHolhQhzBR5UwDTjAluACaEF9VSuCHCEsaSTo4o
         wnYA==
X-Gm-Message-State: AOJu0Yyk9y4JmBDaH0xwXKqXmxbQexmO4w+jz9+rUkR7qQH1jzezAL+t
	M80hfHzmaagOo2yXdMYFwTrsouFc8U0WRCTf+41yoGNiZ9ZqMqHJI3AEVN11xxdetwzPOht07uH
	VtOH9DBXQ3sdzcz90qHJmtN5x7yGjs8r6v0syztczU2kZ16DEODe6RbAVaIpemaAt45jflkO1aA
	Lua74BvtqwMYbKGFSbFAw0k1pbIa+B6QCUTYv7jvVs3oJdW/XQCvNG3asizpy70YYL1w70zt2w7
	VT/hQ4z93w=
X-Gm-Gg: ATEYQzyZguhYuYd2NQHzHN0lH18vKzCVZoyd89v1b2euGKJDbeOYmPF5IqqVUiuSXxq
	SXRX9ppEqvhJsnhCLv8bTt69DjaqHjBqmSifhZgO+iLQmtrbL49ZvOztAXiGvWBbgZSOtJLrpFk
	x5eLWKajr4WNAlQLbl2q/koFRkCB6xAyfBpfzaN3cXZ8FnWlYIa/ITy4NAVFKezUm2nDbDyyVMs
	EkOng4JlUxibkEH9XANVelQmnaEn3u/kVbGHkVpmQmJ3qrNkk1lUAW5Vfpvvmbe1xbeYtN8uMvE
	6SRs9P18PN66DV+agaSE7kVaX3wdwUNUBWqg0Lh7E+QHveQSrulWIuFE4eB+vj62VN6aBk7M4NM
	nzBnqrjyS8SkCkMD11IlMVb8eGzAdQ9JVDEbN9vropj/4wtNzhoqE6BlOJccnJt/jxiZK2n6W8B
	remwW7
X-Received: by 2002:a05:7300:6412:b0:2c4:acef:292a with SMTP id 5a478bee46e88-2c4acef2d90mr5614299eec.12.1774939927717;
        Mon, 30 Mar 2026 23:52:07 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com ([144.49.247.127])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-2c3c7586b13sm1059751eec.8.2026.03.30.23.52.07
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Mar 2026 23:52:07 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8cd7fc27cf7so1591789785a.1
        for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 23:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1774939926; x=1775544726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GfUoQMl7qs/0maO60rGvUyuoerZJ3f6tiPGro7etRVQ=;
        b=Y9Ezqp4fekbQl1hzw+hMgL1dDyn9iSX5uVisH0ljpzzusIgd9frILG6K/6w+Z+aPXZ
         PQZpRBS7Ywa+jFJbXaIM9qqclMlqRXSDM0j7PSOZtpXLTRqWyhsVb929laRJ1v879sfl
         jDFxrO4dSmguqxR8ME2hkxN1dtWR6Dm+Bhogk=
X-Received: by 2002:a05:620a:1992:b0:8cb:2b30:1c82 with SMTP id af79cd13be357-8d01c7fb134mr1919828985a.36.1774939926242;
        Mon, 30 Mar 2026 23:52:06 -0700 (PDT)
X-Received: by 2002:a05:620a:1992:b0:8cb:2b30:1c82 with SMTP id af79cd13be357-8d01c7fb134mr1919826485a.36.1774939925746;
        Mon, 30 Mar 2026 23:52:05 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89ecbda4d50sm80543966d6.15.2026.03.30.23.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 23:52:05 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net v2 0/3] bnxt_en: Bug fixes
Date: Mon, 30 Mar 2026 23:51:35 -0700
Message-ID: <20260331065138.948205-1-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273481-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michael.chan@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:dkim,broadcom.com:mid];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B1F47364A39
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The first patch is a refactor patch needed by the second patch to
fix XDP ring initialization during FW reset.  The third patch
fixes an issue related to stats context reservation for RoCE.

v2: Fix Fixes tag commit ID for patch #2

v1: https://lore.kernel.org/netdev/20260329232528.870637-1-michael.chan@broadcom.com/

Michael Chan (2):
  bnxt_en: Refactor some basic ring setup and adjustment logic
  bnxt_en: Don't assume XDP is never enabled in
    bnxt_init_dflt_ring_mode()

Pavan Chebbi (1):
  bnxt_en: Restore default stat ctxs for ULP when resource is available

 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 68 +++++++++++++------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  1 +
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  5 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c |  5 +-
 4 files changed, 52 insertions(+), 27 deletions(-)

-- 
2.51.0


