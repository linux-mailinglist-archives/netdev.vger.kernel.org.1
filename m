Return-Path: <netdev+bounces-259566-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id L8kSFT5cl2lexQIAu9opvQ
	(envelope-from <netdev+bounces-259566-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 19:53:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B01A5161CC6
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 19:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8EA22300D631
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 18:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E852D24B7;
	Thu, 19 Feb 2026 18:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GVjB3Rfh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f100.google.com (mail-ua1-f100.google.com [209.85.222.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A968D2765D4
	for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 18:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771527226; cv=none; b=QFlmwHsRNIQ2DuHvzXEEPyDtsakDinymuU2XhDtapwlM4QAlDCzXLJva8/K0hTCRRDX31wEOGbsq9t9LH9YmZG3K/vJD+bVr94jbgJt7pTx6ecRsObW/bVDdCYraU5slbHd/CD4VAu9FQblH9IuFvnWbdN52+ETg1s7zaNXu09g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771527226; c=relaxed/simple;
	bh=5xYH/Q5MFKn2DhNn0eF7Oy3ixSmHeVc1Xl6+LbU5Rtw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J9kKoi++9hIp4LrWOBjhQLp7tos9e9Aqyyz0ZKYSgtLEl4agu0vc/RlNyq+9nJNuO9ibDzxOSrS7dnpcIpP8gP2OMYhxCg9uOfMm/nmI4C6Ym96M3xv4VFcV0LSaY86ZT6KPDzEVoGmmIJeIN138DJX95uv3Y49YQl4KJLnqTwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=GVjB3Rfh; arc=none smtp.client-ip=209.85.222.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ua1-f100.google.com with SMTP id a1e0cc1a2514c-94ac7f22d23so418075241.3
        for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 10:53:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771527223; x=1772132023;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=44g0shefn1wIJCvNoF7acpEzzzBdQW8mCA+IBgkiKOQ=;
        b=TxVtVUcmqPuu1DqP03/2m0ZPZFK13i50sXwv4sJ+SQE4L3rpOdhheUYkQmW561LQsw
         Pv1albasWrS+RMTEEUO61sTOM3btVbR8gNcsRLNOpFjC88vfviOXEKYZvh6rsoSqINZY
         1TjLlTQbSEvCI9rmSjhMln1KaGdl9e66fa3EkokukCIiq/+MDdxoWYRJJzJ7iM1ZdBOh
         LzEnJwgMGDUWlc38aaY144n99TNliDZ8h86FzJpGOXO96wF/a7Xyl7aPO3vjlrEGon0p
         0H60wYF1KhBeD1cVSNAWvZiVEfifC7RJDs7TwXc+oUqNB9Wa2dBg4O21q1tyBsFE7dBr
         bdsQ==
X-Gm-Message-State: AOJu0YwDjAsgYB1SUjhsU8S5fSaKhguZCVyClDOceqei+S9t3eSZhZcp
	ykKdp8r+oynPforeBKidRy8a7vvvRloO9Yl+vr+BtAHOvMOSJRkmrwS4Fe0XCsM21p/+PE4Kl0/
	6+t8s9EgJhC4xS74+H11h/hiaG8IKRvbYMWJljG3QUFrT4FwTMIA5pxNSZbBVCswzGGHHqKhvsL
	EMwMueq+XEY+C5mwmkXUppP5CH0JsaOrOcgl+VU5G7B8jyxwB3JcMx/MzGC8dLY9rHUWtod1ZCn
	+ZxWzmBSWk=
X-Gm-Gg: AZuq6aITrCI2eboPTWc9n/SwaTtrJXC+EakLsLaMZH3hxlePAHwQUAfrvD58W7hDNMk
	eGYe4MzAsKn3tHCdQWMQ05yBN7PHRSA5sPWRJ4qEpZMmtaGn3qMzcl+3sJBAh+/gNhaNbnL+peY
	mhbZWVwH114tPvnxAAJxoRIV++jmW/kTVt4FubS0ONWZJprTJufWlCqDP18yA6+C5mduAKyXWzX
	BsblZLDadk9VDcFjceCWxTo63LITUyV7dF8UWeKAX9alGFXEUjjMJXxf7bUlNE9zp57wVq/MC0V
	wMNZOkdnq59I5u86m3YkKgY5YfDzQ4OqgMo8V1MfNz9SZRAdjPhJVAWl00q5swVFTmGR4xEy6Jj
	x4LR2UzHqQ/mK97BAO2m0IZbTsv3cLndvE9TtLGcSUqjBgq4qyFHbrHdndCHHoXASjXpxSxLH3P
	tB89vExKC8MmwC99YLSi0WaSaXQPVPOisom3zqP94/5a7Qosb1L8B1WWnLxSY=
X-Received: by 2002:a05:6102:a54:b0:5ed:f13:e58a with SMTP id ada2fe7eead31-5fe2af86345mr6818725137.37.1771527223206;
        Thu, 19 Feb 2026 10:53:43 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-5fde8a0ca68sm2284879137.3.2026.02.19.10.53.42
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Feb 2026 10:53:43 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2ba67282cabso23531234eec.1
        for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 10:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1771527222; x=1772132022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=44g0shefn1wIJCvNoF7acpEzzzBdQW8mCA+IBgkiKOQ=;
        b=GVjB3RfhIvBp+WW6A/gL5D5q7IgAPHxODf/jLKYsaORizBaIkd3Ora5IgrDpMAz7/c
         y9urPCqaz2wTBVLtJbjkwTWjx8reAZqxieEWwqe52u6hda/m7x46ARC8q+nYqv3DIs7g
         ZrgYR9NBsVVlqImgcK3xs58BtxGoy1Np8Cmjs=
X-Received: by 2002:a05:7300:a984:b0:2b7:a3a9:9c28 with SMTP id 5a478bee46e88-2bac9795c4cmr8964699eec.20.1771527221955;
        Thu, 19 Feb 2026 10:53:41 -0800 (PST)
X-Received: by 2002:a05:7300:a984:b0:2b7:a3a9:9c28 with SMTP id 5a478bee46e88-2bac9795c4cmr8964687eec.20.1771527221306;
        Thu, 19 Feb 2026 10:53:41 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bacb6782e5sm21488155eec.29.2026.02.19.10.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 10:53:40 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	horms@kernel.org
Subject: [PATCH net v4 0/3] bnxt_en: Fix RSS context and ntuple filter issues
Date: Thu, 19 Feb 2026 10:53:10 -0800
Message-ID: <20260219185313.2682148-1-michael.chan@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259566-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michael.chan@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B01A5161CC6
X-Rspamd-Action: no action

The first patch fixes the problem of ifup failing if one or more RSS
contexts were previously created.  The 2nd patch fixes ntuple filter
deletion errors in ifdown state.  The last patch adds self tests to
cover these failure cases.

v4: Elimianted the original cleanup patch #2 from earlier versions.
Simplified and improved the ntuple filter deletion fix (new patch #2).

v3: More improvements to the selftest in patch #4
https://lore.kernel.org/netdev/20260213074503.2302046-1-michael.chan@broadcom.com/

v2: Many improvements to the selftest in patch #4
https://lore.kernel.org/netdev/20260206052930.1882740-1-michael.chan@broadcom.com/

v1: https://lore.kernel.org/netdev/20260129061646.1417185-1-michael.chan@broadcom.com/

Pavan Chebbi (3):
  bnxt_en: Fix RSS context delete logic
  bnxt_en: Fix deleting of Ntuple filters
  selftests: drv-net: rss_ctx: test RSS contexts persist after ifdown/up

 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  13 +--
 .../selftests/drivers/net/hw/rss_ctx.py       | 100 +++++++++++++++++-
 2 files changed, 105 insertions(+), 8 deletions(-)

-- 
2.51.0


