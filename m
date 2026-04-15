Return-Path: <netdev+bounces-278822-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0LNUCdar32mOXgAAu9opvQ
	(envelope-from <netdev+bounces-278822-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 17:16:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B0387405C5F
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 17:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 27F9C300C0DF
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 15:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA5D3B6366;
	Wed, 15 Apr 2026 15:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="aj93GCqE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f97.google.com (mail-qv1-f97.google.com [209.85.219.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CBA30DED1
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 15:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776266195; cv=none; b=NuAbNW1LqfObSlYV4Id74ztKKAZxmIYwW9kpLwK4Rh627B9b6Iz+b+E50rgDaUbdjMNoX3DePA1k+QhOsjqswG9vRI/b0sCpyqnc+KqHQyzyBcuJLjJJjaUzJ8d2xckFdBJDdwNPqszsT4JzvG4fNLwGh5KCNTvRkNntEMlIHlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776266195; c=relaxed/simple;
	bh=Srk644+bNqJq5RA6SAJCy3e9bFT49ErAzejjc3ydeiM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IPpO3a51Z8eUAqRSSBtJvnO7/+51h+lEM8l8kBxB3wJhEdkoMqyJgCoD4P4GFAHNYkgiJeEL/9j3sKgBQHADpE241KZvAjMwDGyscjXHqL9MBv/BM/hiE4xVQZEEpVqPAOUfPFWzW7VXvhLvs+OINSMYCBQwWz91vgwIQEljiFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=aj93GCqE; arc=none smtp.client-ip=209.85.219.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f97.google.com with SMTP id 6a1803df08f44-8a08fa355a1so95321526d6.0
        for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 08:16:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776266193; x=1776870993;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p+nVPv5Zxd7EVJgUfsHfDkDa79GyPlzDpbf/dWXyTUY=;
        b=EpXrLjIqEZAtuGttB3co4mc+NeIF8cX5WKcLJFvHbxBlOzwr7jME1exE0pTdaA6iSR
         xC4qMbFH0yJSaxWurGG08MJo3TcqlsttLsi8tJ2EtEeGVtkgIHXthn16u22zxGO7Do/c
         kyngAzaOeDtnWl9zJgaPYPXDBuJgGbCpsdijQAHRI9D9Ovvjxrl1oBnJO8TvHNjxpHWo
         mFmkGOTojIdzhpnMLWFRLJvZmMpUJTxGZxiqwEaQfhSQMg/FEmL49wVP77T0JRkUbrAg
         WdcpQgAodgKY9AYYYki0ebpmz7T3sHRa8pSuIp1FGcyNAS7hCqiwo2bpdx29PwxUF2OX
         +J8Q==
X-Gm-Message-State: AOJu0Yx8BeD0Ze6BssRjCC+4jZM0t6lPZxbOh6G+qf6xWmGDw5R60Wyn
	J/SdBkRac48Fo/pSRPfPU4rKO1U7bvehYBScLxVfqMUwjpelyd1+EY3Ml3zixQ/QW25midRqoyf
	ZFlrysAV18ZqjrcirqOKg43bZJiaCIF5SfMYZNR3CECfOdOoXDjWBjqbn2W8TfrxEJCDnZlKX1M
	9A9dOW7FWpFVievn+BzhlXXmayoVoYO103ktIS2bHP4UENe9zoCfeETu+HtUrABQFVWSPRRGFfy
	0ohmc6FZw==
X-Gm-Gg: AeBDievMfwZSJW7czhUYQT1yFbRC4PuVTIc5Fj59BRFwdbI9JdRgurIpkwQMFP7Kcdw
	BKA80Ds1W18ojOpPY2N/QuTy5pf2ryZKI8wM5YYpBEuTg7SYpI8YsUnTeGyds5oatY2xxotHzRM
	Su5WSTx9H9w873VNFRDm+k59fyIDPaAZACm9pArUQvLhIPGRtATckJTyxBo0+jAcNlhulHb7BNY
	bO+0mnzbpFLTu7bu/Aha37DWmx+H6/fT87onMgi+Ho5TWUdQ1rbEutwTJo7P96E9bxHXApXavEb
	XSEuW2w+3iviqJ74w9/PmbPWEOFHllmbw3PclzEaiINn/O1Fno671tViCxd4pqp8iNfXpVxEADY
	6NP3xSMgsudpNQjVPY+EtQvlw6yHijQ+tl/UjWq9iVrI8rL5W1otzk1H5j0YslyzaCo3OP14D2N
	/TFsbPD316qHiP2EpUU6H+Bq8DdG/8k66xZetVXmOHpanortL7ucJ9tsE=
X-Received: by 2002:a05:6214:2f8c:b0:8ac:7d70:f0da with SMTP id 6a1803df08f44-8ac861ad7d4mr345761976d6.14.1776266192544;
        Wed, 15 Apr 2026 08:16:32 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-24.dlp.protect.broadcom.com. [144.49.247.24])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8ae6cb96b0dsm1481646d6.17.2026.04.15.08.16.32
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Apr 2026 08:16:32 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-82f6e6a3a76so546760b3a.0
        for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 08:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1776266191; x=1776870991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p+nVPv5Zxd7EVJgUfsHfDkDa79GyPlzDpbf/dWXyTUY=;
        b=aj93GCqEonWd/jYV27mA9CVu1uCJvD+d4TP1dgz8CPEXs03Zz6FHba2Ybjx+Y0LK3O
         N11QENPsu9nVKmYFfWyrWK7/xJbpja2JyYvkMYZKTqlDVqrA0CHB1ulpHzmS8nUKvcC/
         duSg8f69JVqKZLOw2hdKMvnpiBXxBv8gaIpmM=
X-Received: by 2002:a05:6a00:368d:b0:82c:e0d7:268b with SMTP id d2e1a72fcca58-82f0c247d6emr22886246b3a.23.1776266191249;
        Wed, 15 Apr 2026 08:16:31 -0700 (PDT)
X-Received: by 2002:a05:6a00:368d:b0:82c:e0d7:268b with SMTP id d2e1a72fcca58-82f0c247d6emr22886204b3a.23.1776266190783;
        Wed, 15 Apr 2026 08:16:30 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f673e0f15sm2996555b3a.35.2026.04.15.08.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 08:16:30 -0700 (PDT)
From: Vikas Gupta <vikas.gupta@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vsrama-krishna.nemani@broadcom.com,
	bhargava.marreddy@broadcom.com,
	rajashekar.hudumula@broadcom.com,
	ajit.khaparde@broadcom.com,
	dharmender.garg@broadcom.com,
	rahul-rg.gupta@broadcom.com,
	Vikas Gupta <vikas.gupta@broadcom.com>
Subject: [PATCH net v2 0/2] bnge fixes
Date: Wed, 15 Apr 2026 20:46:19 +0530
Message-ID: <20260415151621.1104956-1-vikas.gupta@broadcom.com>
X-Mailer: git-send-email 2.47.1
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-278822-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vikas.gupta@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B0387405C5F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,
 This series fix two issues.

 Patch-1: 
    Due to wrong HWRM sequence, driver do not get the correct
    information regarding resources and capabilities.
    The patch fixes the initial HWRM sequence.
Patch-2:
    Remove the unsupported backing store type initialization, which is
    not supported in Thor Ultra devices.

Thanks,
Vikas

v1->v2: 
   Include Fixes tags.


Vikas Gupta (2):
  bnge: fix initial HWRM sequence
  bnge: remove unsupported backing store type

 .../net/ethernet/broadcom/bnge/bnge_core.c    | 39 ++++++++++---------
 .../net/ethernet/broadcom/bnge/bnge_rmem.c    | 16 --------
 2 files changed, 21 insertions(+), 34 deletions(-)

-- 
2.47.1


