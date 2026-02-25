Return-Path: <netdev+bounces-261016-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FcSKTUcn2kzZAQAu9opvQ
	(envelope-from <netdev+bounces-261016-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 16:58:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2C119A1F0
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 16:58:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C40A530F994E
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 15:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9543B8BC9;
	Wed, 25 Feb 2026 15:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b="XrvWed/J"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-of-o55.zoho.com (sender4-of-o55.zoho.com [136.143.188.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3ECEDF59
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 15:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772033961; cv=pass; b=fFoxkIQaUIF4LUB78iMnm1V1pasUAdUky5RQWwv1YWViVEQRW9FPe7geM5zvvahBcqF191s/EkvW7li5+g0IyEw/my7oqdrIMLF1uiCzKaEqzPZRkLHMfqscK+IWcAnrcyiV2pqTDS/X8ZUfQvq0BDf7M+E988YzhVUKRM8h9Xc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772033961; c=relaxed/simple;
	bh=Ql+f/PUyREpv1bayGUzKoD/0twwhHgBAkPR2Rcq3SbA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t7vYNcvyw6z7UvavtvmkEEOntubSGaMLTiZ1fu3xzZZc0Hydy8ZjtCBGnoBh+5L2rmzCy3TtQDpOvRvbTuf0GBhrggI5+yO8ucTmg/nYfLz6Zk++e20bi2/4we602HajEWecsNlTwEXk9YffT7YhUaVZ91skdgOCD+nwJD4a02o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net; spf=pass smtp.mailfrom=machnikowski.net; dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b=XrvWed/J; arc=pass smtp.client-ip=136.143.188.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=machnikowski.net
ARC-Seal: i=1; a=rsa-sha256; t=1772033946; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=DL2dJ0Ou7Ukqg4NPbefR1Akb+eFu2UTQbmFH6VxJ23Lhhzf2M85mHg4nmvrF+ziBSftFjT53Bhl8wH18z4/jNgjCvb5zBw9jkCrf+skXsLnISgtcuIc8Rsg/saCy3mYQYOTpLV19GOlMQldEIqU1rfrfEHt/B5wlwH7oWoI1pL4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1772033946; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=1W2NrDswjtunA36fVCKYVztkrv0Jcxla4YHzj2kv1lQ=; 
	b=iy3mmEoZo4PBCf7TjeYLSHnDZPQQSlvxsKxGUaLrtlyJPFajOt8+24/zMc5jmfFuwXYlWIZv2Wrghg4ou4j3qzleYIXIh2rM+Up5VcJq7AINtnl0iX1Z25SFyr1FryOYbRea36Q1E3L4neaWfkyLhUjl82gtotQyO+/N0TJagLE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=machnikowski.net;
	spf=pass  smtp.mailfrom=maciek@machnikowski.net;
	dmarc=pass header.from=<maciek@machnikowski.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772033945;
	s=zoho; d=machnikowski.net; i=maciek@machnikowski.net;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=1W2NrDswjtunA36fVCKYVztkrv0Jcxla4YHzj2kv1lQ=;
	b=XrvWed/JPn2WeyPTsIyrFjzuYNbexi7RlLoho+SQWvhCxxqEYjPEX/Np5iMeE+4u
	UTgCiA15QUWdmK4I15FrRz3EmwWvOq921kmU/uAYv0IVzK/4QvzQczzKCcFTeeZfaVy
	NARbEbIP1v4CdXLbz2+lw8Pb4wRq4kpXcFhmA9wy5Jzzuq2DXAhn2T6LcDFUAZKzyb/
	EGLfgaa5J9OTevgHSHS6yXZLt0eoj8QTCwStXviR8udMiWKDNAyzQZjNt1Dezph65ti
	Sti74hYNSaDDvFHDnpb8y7bRMWf/3nPXs85J1hn+cG3vfS8wW6jCi3I4mNHZ7LO9AJw
	mt0ChwiOig==
Received: by mx.zohomail.com with SMTPS id 1772033942765264.476133318193;
	Wed, 25 Feb 2026 07:39:02 -0800 (PST)
From: Maciek Machnikowski <maciek@machnikowski.net>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	maciek@machnikowski.net,
	richardcochran@gmail.com,
	milena.olech@intel.com,
	willemdebruijn.kernel@gmail.com,
	andrew@lunn.ch,
	vadim.fedorenko@linux.dev,
	horms@kernel.org
Subject: [PATCH v3 net-next 0/3] Implement PTP support in netdevsim
Date: Wed, 25 Feb 2026 16:38:55 +0100
Message-ID: <20260225153858.29486-1-maciek@machnikowski.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[machnikowski.net:s=zoho];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,machnikowski.net,gmail.com,intel.com,lunn.ch,linux.dev];
	DMARC_NA(0.00)[machnikowski.net];
	TAGGED_FROM(0.00)[bounces-261016-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[machnikowski.net:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciek@machnikowski.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.973];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,machnikowski.net:mid,machnikowski.net:dkim]
X-Rspamd-Queue-Id: BB2C119A1F0
X-Rspamd-Action: no action

This patchset adds support to the PTP HW timestamping emulation in the
netdevsim. It uses existing binding between netdevsim and ptp_mock
driver to generate transmit and receive timestamps.

It also adds the selftest to verify the hw timestamping functionality
running over netdevsim.

v2:
- Added selftest/net/ptp.sh
- Modified ptp_mock to use spin_lock_bh
- Populate ethtool defaults using ethtool_op_get_ts_info

v3:
- Fixed shellcheck issues in the selftest/net/ptp.sh
- Added selftest/net/ptp.sh to the selftest/net/Makefile
- Modified ptp_mock to use spin_lock_irqsave

Maciek Machnikowski (3):
  ptp_mock: Expose ptp_clock_info to external drivers
  netdevsim: Implement basic ptp support
  selftests:net: Implement ptp4l sync test using netdevsim

 drivers/net/netdevsim/ethtool.c      |  11 +++
 drivers/net/netdevsim/netdev.c       |  90 +++++++++++++++++++++++
 drivers/net/netdevsim/netdevsim.h    |   1 +
 drivers/ptp/ptp_mock.c               |  22 ++++--
 include/linux/ptp_mock.h             |   5 ++
 tools/testing/selftests/net/Makefile |   1 +
 tools/testing/selftests/net/ptp.sh   | 105 +++++++++++++++++++++++++++
 7 files changed, 227 insertions(+), 8 deletions(-)
 create mode 100755 tools/testing/selftests/net/ptp.sh

-- 
2.53.0


