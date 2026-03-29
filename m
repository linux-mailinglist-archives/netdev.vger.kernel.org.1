Return-Path: <netdev+bounces-273033-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id xiSrLyK1yWlO1gUAu9opvQ
	(envelope-from <netdev+bounces-273033-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 01:26:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E1FD354672
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 01:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 653EC3005163
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 23:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80722DC767;
	Sun, 29 Mar 2026 23:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QnY/YxM4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f225.google.com (mail-pg1-f225.google.com [209.85.215.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEBA76026
	for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 23:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774826781; cv=none; b=EMbXSAPDwyENPLXREZbzQdBaV/mRVSFkpqYQCnHpGYcOXg4RBr8jMtUc/VNiSMr60J2ZCnMQlg6iwW6x3Dybv14q8CLZG/yczyCeldJtXbnMbUFSRaPHDxUgptAAaA8hpD9lNbRVyXG6L3AV5yh8S2b1SBRiBdjrQCFYG9WANGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774826781; c=relaxed/simple;
	bh=1xOHODMAgvKgd5GgJmQS/F2KWMI29korXGGFzg/RfEc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NgIvZ+/0u4VawsdV2gFtb3NaJQoPyr8DOO48ZD0oR8cqQQbd6XAZ8RQ13MpRyNogGTeMm4++rarkjCi8iB6kx2VPigYHkZ0s3miDiz14rVpwpLVaQQ68nP3xaWbqOdeJWnFe8K+XAjVwBhcg5vTwVeGU5htdWx0b934GRaGrSf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=QnY/YxM4; arc=none smtp.client-ip=209.85.215.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f225.google.com with SMTP id 41be03b00d2f7-b6ce6d1d3dcso1344958a12.3
        for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 16:26:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774826780; x=1775431580;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dy7kQgmt0nTqUEAxGOoU8xpIjihI+S3fDEVXuwNPr6I=;
        b=RNGO3eR9AnTQgA8op+9kjp5hodyE08uF5tVME8/mXtRip/k+mcGYjtuOncELIThkJ6
         C9rByElWggIsXdpoPFCjn+DT8afTLKmeXeaCNERQ29/47/kLoEW/PLrVA68nxmbyN6aY
         0ZqAixHRtctmkdp5b+YkyqAFgT4dC97qJte8kwmCxgKoR5eiI8aK3Nw8ahffBaMoeUAp
         kk3jgXlk52Ts0c72I3dUjcqz7rDuvgil3dJjKJ3YDgydgIh1rEzPY3yfLkw+iYp3uoT7
         ZykE4Ix9PnsFbCV73kxKesUmqJ62t5Pp57SFJQ/UhTgKJA32R34HaTeuL8SSk74UqiaH
         sDGw==
X-Gm-Message-State: AOJu0YxUzj9LIAX9lim+RTwaEzcYaLJkqAa1oLrcXOwtey1FJtU3hf7y
	Dc5d2AVdffB5oLYnx42BiVuGgnW9ziqf4nqTkksdvcSGQs9Nb8hukcEd4ui/Lq8Wl5BlM/dLWxV
	cvtKIKhOO9+DYz27oxuimJVgOfD4pOermENaTFxjm+VGVwwKe5GojOtGgEQArpG6ckaMUET46z+
	RAP/BkDy+naX5810XY0x7QIo77TjoD5kIAxuPemKZBOQIBBo/vbzHniM1M53pIFjmmKRh3/6tWl
	QVwaahoOOk=
X-Gm-Gg: ATEYQzwnb2lahjqvG/HISjjYBgHawLBBk6Ehc5nEgb9KL9fT0UtkKvdCVnYQtpdGS67
	kBP6oegG6u0SRSkzFLSxxz/tGCtvkia5oIcZEh2H5uWE8lzhiFOdGbrUQ7fcLLPwYyiPK4eklYB
	I+5dNAq/7lD9Ik4IMKNWEfsz58Jo2J1XJeF/YBxJtsT+Mod9y84I642qfUnCslf4COkgyI9X9BX
	WTFR7GCcEL2I69aRALHloAIqrHTr8jfQ2+ijdKdlUdTf/ahJ9CsTBzKKn+tsXs0ZgXNBdSPUdbw
	u2irk0ntFtRzW3ZS95caEwy+EhBcBmYUSWqw1tLraKes+RkXWZsD5Og2nkjZrDIVNSKhFWaV2TJ
	PS1O9CFqec012B1SXuapcRYZLNH06uGWOEx3RQZF1lgfAqc5L7xoagDi/cLXXoZbM0JQ9+XuRSH
	jwJY00j1d0flVKLfEuFGZwqw+7qcfjHPGHO5wSZUBhTMeKpMNx4vEI0UYa
X-Received: by 2002:a17:902:e952:b0:2b0:571f:6f09 with SMTP id d9443c01a7336-2b0cdcd5695mr108886065ad.44.1774826779448;
        Sun, 29 Mar 2026 16:26:19 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-15.dlp.protect.broadcom.com. [144.49.247.15])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2b242765926sm6704335ad.45.2026.03.29.16.26.19
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Mar 2026 16:26:19 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-509219f94b0so76322381cf.3
        for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 16:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1774826778; x=1775431578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dy7kQgmt0nTqUEAxGOoU8xpIjihI+S3fDEVXuwNPr6I=;
        b=QnY/YxM4WkKRAN1Bci3xf50eunszZJlWgENkvG556d8IJYjG0S+cMGdrMw1xbMHqUB
         6ga0rTrSkVl5r03n+g0ZqsjmE1lFOxYs3MiO285JT7+KuqtZaGd3pMWp+3cK82VKmorr
         3GvR1wjianLKw1dYaLMD0iYi6sbFoZCe6ccdI=
X-Received: by 2002:ac8:58c1:0:b0:50b:8ccc:a420 with SMTP id d75a77b69052e-50ba37f2722mr142453351cf.16.1774826778052;
        Sun, 29 Mar 2026 16:26:18 -0700 (PDT)
X-Received: by 2002:ac8:58c1:0:b0:50b:8ccc:a420 with SMTP id d75a77b69052e-50ba37f2722mr142453071cf.16.1774826777514;
        Sun, 29 Mar 2026 16:26:17 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50bb7729698sm41601531cf.29.2026.03.29.16.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 16:26:16 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net 0/3] bnxt_en: Bug fixes
Date: Sun, 29 Mar 2026 16:25:25 -0700
Message-ID: <20260329232528.870637-1-michael.chan@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273033-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michael.chan@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 1E1FD354672
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The first patch is a refactor patch needed by the second patch to
fix XDP ring initialization during FW reset.  The third patch
fixes an issue related to stats context reservation for RoCE.

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


