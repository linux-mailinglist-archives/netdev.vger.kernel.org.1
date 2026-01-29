Return-Path: <netdev+bounces-254583-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SEdaB3/7emlaAQIAu9opvQ
	(envelope-from <netdev+bounces-254583-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 07:17:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E394AC2DD
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 07:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8B9383004610
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 06:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79432289378;
	Thu, 29 Jan 2026 06:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FKwtX97/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f100.google.com (mail-qv1-f100.google.com [209.85.219.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2961ADFE4
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 06:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769667450; cv=none; b=q+yO1X0sjUWlnGiajtZqnOTCkfzJIfM0zpwp16233aykXsloB2jWwy9toOjZtpePkZpUq+g7TJsXPl2arSQSOztzgoaZTd9k7Szj6OoEDCCUmdmNbCOWfOIbx9pr+VGqBoibmn0zQGPN7ozjbmSQ8mEU2n/hCGf93hHbHB2KZ/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769667450; c=relaxed/simple;
	bh=LIizz2Kx2hPVKd4bPrMvau70yqah7kSWq02+ohLG4LA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pyjyUM+DimX/mnLFlBYBnPeQSDPeXAHXphjWfCarNLN8ZsiHS6bqLkbMJgppaaz+FwoNtrkoh1oYhMkg0G7NufLvQLSkEGwcvab54Oz1gusAjUS+Wpfk6xnGaJOFtDKP8VcaHuHI72FahnjY4C7TJdW5qL3CeW32yyIsaABR5XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=FKwtX97/; arc=none smtp.client-ip=209.85.219.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f100.google.com with SMTP id 6a1803df08f44-894774491deso8583506d6.2
        for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 22:17:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769667448; x=1770272248;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+IT4G/5qCufRPvVleg8rBTuTzjrYDWks1C0eYf86ieU=;
        b=AxTjL9wY60IgWF9zVu728kHNm9aOAvRIZHbe/VeWsOvcXiCo6tugJ6Su2Dv4b4ghzb
         9gXrHjg7OW6gvxHucMDq5EX/fGDnA66OLjesB+KQIKuwoxiiehDT0sLy3738xVnWbc8F
         9J1JyVQsbd9J/tBzixxRu3urC8DZLr/KOHZV6aQd+jR954cK9y4qm2TUfyd35oLgko5i
         o/RAjZTugvsOl+hdzjcD6CUkK/ljM+V5kVH2lVjWT0JR/jq3A+cx5xLjRtcUZTI0iguV
         cXsv74gusf9PkNjGCEa8IrZLb8roWQbdk4EeiTWXUbn2aKnyHMZpswDLF6oFXJj04zPL
         edDA==
X-Gm-Message-State: AOJu0YwFPY14ix8pOeiOZDAQYq7J8sTNRH/1lXsBpJzgJzvmOrg59G74
	cBmT1SFFA+nZ/6BgtTXQamnfeWi5rHaBNmhbdnEV2GN272Je/xGG3N0vLoBNHD9hKU+qt0BWAwy
	x8bdENeERhaPSoI8ZxoDkqfBgVuXtNNrWzEAMnnsxfzCiHGj7c4WBz2K6XTn2q8kEV2mmdoU0hV
	H89qB34H/KRjKI0+hDNBzlVdL6NvnJ/Tnct56bfyF5D7MorOvxjdGsPRM6Ch03v6LDbUlBNQ0iK
	iAL4PgQ6i0=
X-Gm-Gg: AZuq6aIYQpl+4rh/81ovC2WWLxu9pgMeYrm3DDcVzkV9avKf1dPDea5dS1aI0o/492J
	J/y91eKUXXYfJ6YRnc3ZeNOZySzKEon7bZgBVuPGdM+WX2HP4ZqFAOy6PPeuRUOtju2CbCzpQWC
	gFfG+ANtrCvp9QL6b6qFKH9yFSmSLxUvzH08bulRChP1hVX3U7wmx0Wz5Jrb4/v/KCTQyndAGa7
	p1oHpxle9FYCV7evSAOs75lr1Bqe3GrpPQ8qX2ci0MdT8oi7yakr4Dmxz1gB2h4H7Q5Vl5RxxJ3
	W45h+DxTo/Kd9LPlIYsqnVaFJ6z3PfYLP6FzlW4r6J1+vgs93ne9Zx3pgJAsT367L92YKsnRD3Y
	yeRDJyLQACTxk+RLKh+K8x0pflnseOGRUW2N8NYw9aVgfM9SoL8hF8aMUJLNZnLmXHjcvGlOEck
	m8lWLpN8xUAZY5iT4B00iVlQUEYJ2463D2bXWbtCQJvQ==
X-Received: by 2002:a05:6214:5018:b0:894:60a9:d45a with SMTP id 6a1803df08f44-894cc8f0ef3mr101679276d6.48.1769667447929;
        Wed, 28 Jan 2026 22:17:27 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-0.dlp.protect.broadcom.com. [144.49.247.0])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-894d373fbdcsm5716336d6.23.2026.01.28.22.17.26
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Jan 2026 22:17:27 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-1247bb4db53so1026696c88.1
        for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 22:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1769667446; x=1770272246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+IT4G/5qCufRPvVleg8rBTuTzjrYDWks1C0eYf86ieU=;
        b=FKwtX97/MLBES1+dI6UnHqAlbaWtmkEQ8HTIWZi4Fvc7xnF+JSNQ9nJE5HhyYlVwNy
         c6Uxq8ui+CUFSr0TEMcwtk5WSX6ULzg6cPiQynORFcWXFKj6FjeSCv9XZARjr4MLoIq/
         9oRzIkhvHLmiYae3FVgjwXRc0wukR3YdTMl50=
X-Received: by 2002:a05:7022:4387:b0:11b:8b4b:bff7 with SMTP id a92af1059eb24-124a011a4b1mr4103722c88.39.1769667445395;
        Wed, 28 Jan 2026 22:17:25 -0800 (PST)
X-Received: by 2002:a05:7022:4387:b0:11b:8b4b:bff7 with SMTP id a92af1059eb24-124a011a4b1mr4103708c88.39.1769667444823;
        Wed, 28 Jan 2026 22:17:24 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-124a9e0304bsm5318226c88.14.2026.01.28.22.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 22:17:24 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net 0/4] bnxt_en: Fix RSS context and ntuple filter issues
Date: Wed, 28 Jan 2026 22:16:42 -0800
Message-ID: <20260129061646.1417185-1-michael.chan@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254583-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michael.chan@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4E394AC2DD
X-Rspamd-Action: no action

The first patch fixes the problem of ifup failing if one or more RSS
contexts were previously created.  The 2nd patch is a cleanup patch
required by the 3rd patch which fixes ntuple filter deletion errors
in ifdown state.  The 4th patch adds self tests to cover these failure
cases.

Pavan Chebbi (4):
  bnxt_en: Fix RSS context delete logic
  bnxt_en: Don't overload fw_vnic_id for RSS context's filters
  bnxt_en: Fix deleting of Ntuple filters
  selftests: drv-net: rss_ctx: test RSS contexts persist after ifdown/up

 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  28 +++--
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |   3 +-
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  12 +-
 .../selftests/drivers/net/hw/rss_ctx.py       | 117 +++++++++++++++++-
 4 files changed, 141 insertions(+), 19 deletions(-)

-- 
2.51.0


