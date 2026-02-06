Return-Path: <netdev+bounces-257469-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EUXZKYh8hWlQCQQAu9opvQ
	(envelope-from <netdev+bounces-257469-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 06:30:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E3AFA5A3
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 06:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6FC7E301E3E7
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 05:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8171A3172;
	Fri,  6 Feb 2026 05:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="g2IZV/ZA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f228.google.com (mail-qk1-f228.google.com [209.85.222.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DA22AD2C
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 05:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770355845; cv=none; b=bMTaNwHdtmZY+CK6zC2NAQ21VMeW9e/wU78gtWU5w8X4qc9CGcRSTavHJ/4FlkR3MeuLXsrL63rzgHsKr7sYuEjKJe0V9jWZ1c2Ze3m8nVcbZfvBa0xiZe1W9I8SAFlEtg+f2KW6ZZuKrYvEPglbnAwTKfrBaYxqYgkl3eyKw0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770355845; c=relaxed/simple;
	bh=Mh/cawe9iUBTrgdUloPrmzJ7FeZoKpgMEZ6pjeTGP34=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DdMqS/BYrAkrNn2ro05U+/zvjfwCFeq3MFnpqWiNFuyONiNNxCqbjpKcVo/XYjkRSwTzMq2jB0eVF+kT0afJ2f0gaMt9Lo7xISGx1hoWHxIQxhcwd5XOMe43Mbh0Pj0M3pDldmW2PMopdqHJTP6+JcqnayAga0mvBPMc/62/bHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=g2IZV/ZA; arc=none smtp.client-ip=209.85.222.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f228.google.com with SMTP id af79cd13be357-8c6a7638f42so43190885a.2
        for <netdev@vger.kernel.org>; Thu, 05 Feb 2026 21:30:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770355844; x=1770960644;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2wYhSfMOh+M+4MnM4CJRTYE0/UIdu05l0qtXGZULPAE=;
        b=UrDUsdAl0n3/obB4tmYKcjzlQI/IvbtZH07TWjuLXYV0Adjk2sw1Db3xGcJmQ0dWcF
         GUlky0kAMU9weQ9O7D4YTF/RoISks4vDPjhztrTw6rlPPKKoE80z0eI+/Ao44kXvkrHG
         DLKLj4wjlY/WhJo5UbKKGXc8eC5TXKp1CDILJMKNcVfwiTihhPFJzP8/y5r0OMMY1Hcc
         Y/OBFYiGQqS4S8X2vTC+5EgKSLmNDalTu8hZWlB7+2Tjg2ABfiGX+3vdt5YDTt281YHr
         v99NsCrmiruaFPxpvNgxSJRhB45/RsLx9YP1vxuov9KQsUEBiSucdyJ5No2BsoK+p/9S
         5rhQ==
X-Gm-Message-State: AOJu0YxoyEsHaEcVqSC5Pk/yCuCo8oA2dEKrbkP0m161QCEpG0BR+Zm2
	ZwA9W258UXmHTgnMP3Lj3odRtHaKiaKvfL74t1B168TIq4l/vDRnTtTYTdHM3L2v236MXXtVp23
	vbZ8VSx9fj7TS7FJTFyWuSYYw4KSyxqiTOZdohvVuQROI+0sqZ2I1JO+cNnrrY0w7zoWqqSkSO6
	O1nJjB99YnwsEZNj7kAipCkN1dxR1nnKdudO2qtsOuFyqyeCHrBNS1O5E6v7DvqRjNxfwC7XrmQ
	7BXF2rFYWA=
X-Gm-Gg: AZuq6aJ/JHfR6hnxwcmH+rIQEQNQ8SYiC5ikTElmNosXeCwLeTVO0Pe+qSb9SUSzHC0
	NHlUy3ugyxalefBr/McCO8oyZtk7vp2kV2Zh8t6Pa0dP7d+ThA/O+YbmRgAq7mg+islP7cWAtms
	wM8m9j03itLhTuB2TFdRuQUsvWkBetTZdMhsBZAq7CBczxIZYSkIroJqVdsqTPIqR1oGMjbxjf+
	kjMd2LL9CoQjaIEnIxyRZyT0ogqWveJmgDdJArCBvkus+xVqnq2V6Eu9/SpY82UHGSmBFimM1ZR
	FaKPrhCLhh/lb2HZKnYHJyWNFygejm6Jhe4+ilVppC044ZEc2uTPPa6kNk1m83GOhP27GRxa8vt
	BbDdKh+p1u2J3ttCoFUUf5stfURPHhJy8yGLud00Qi5j3qyRDrFXm+Fgy2Z9VyCf4cAFIJDGC2T
	b4jZvgX8efs+KytBRH6f3+sYNH/AcHyS3oJzTVUTwLqajAEiw=
X-Received: by 2002:a05:620a:2994:b0:8c6:a0a4:b796 with SMTP id af79cd13be357-8caeef2f940mr174794785a.2.1770355844411;
        Thu, 05 Feb 2026 21:30:44 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-103.dlp.protect.broadcom.com. [144.49.247.103])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8953bf38308sm2418856d6.8.2026.02.05.21.30.44
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Feb 2026 21:30:44 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7cfd12d8245so531011a34.1
        for <netdev@vger.kernel.org>; Thu, 05 Feb 2026 21:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1770355843; x=1770960643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2wYhSfMOh+M+4MnM4CJRTYE0/UIdu05l0qtXGZULPAE=;
        b=g2IZV/ZAZqb4GB+LGs+eR+h5tmuTt73XATT2TKGkVg2/NWOtMWX1j4auRc03TFPKiC
         3MecDOUFmvJYaGP+vc0bUtwj/kN7FbyqFyWxJRWMeNjUtJa9YCzgWgb9qeLGiapCTetD
         Egh3ThDoVC8u6WG0ue2MDLXmS4pj3In9ojlHM=
X-Received: by 2002:a05:6830:661a:b0:7c7:55e3:9117 with SMTP id 46e09a7af769-7d46447f45amr813842a34.22.1770355843521;
        Thu, 05 Feb 2026 21:30:43 -0800 (PST)
X-Received: by 2002:a05:6830:661a:b0:7c7:55e3:9117 with SMTP id 46e09a7af769-7d46447f45amr813836a34.22.1770355843221;
        Thu, 05 Feb 2026 21:30:43 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d4647aa6cbsm903529a34.26.2026.02.05.21.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 21:30:42 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net v2 0/4] bnxt_en: Fix RSS context and ntuple filter issues
Date: Thu,  5 Feb 2026 21:29:26 -0800
Message-ID: <20260206052930.1882740-1-michael.chan@broadcom.com>
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
	TAGGED_FROM(0.00)[bounces-257469-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:mid,broadcom.com:dkim];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: F3E3AFA5A3
X-Rspamd-Action: no action

The first patch fixes the problem of ifup failing if one or more RSS
contexts were previously created.  The 2nd patch is a cleanup patch
required by the 3rd patch which fixes ntuple filter deletion errors
in ifdown state.  The 4th patch adds self tests to cover these failure
cases.

v2: Many improvements to the selftest in patch #4

v1: https://lore.kernel.org/netdev/20260129061646.1417185-1-michael.chan@broadcom.com/

Pavan Chebbi (4):
  bnxt_en: Fix RSS context delete logic
  bnxt_en: Don't overload fw_vnic_id for RSS context's filters
  bnxt_en: Fix deleting of Ntuple filters
  selftests: drv-net: rss_ctx: test RSS contexts persist after ifdown/up

 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  28 +++--
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |   3 +-
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  12 +--
 .../selftests/drivers/net/hw/rss_ctx.py       | 102 +++++++++++++++++-
 4 files changed, 126 insertions(+), 19 deletions(-)

-- 
2.51.0


