Return-Path: <netdev+bounces-118030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB2F9505C3
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 14:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D071CB2787F
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 12:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C0D19B3FF;
	Tue, 13 Aug 2024 12:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b="HfmmGj5Q"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8662B19ADBA
	for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 12:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723553778; cv=pass; b=CoO5P+wm+x61tCyaD+Ebpj9bsMgYyBXvPM4j63xXjunIkydq4anJ+0urGgsOVMGeGS1P71PSAki5bpiKtwz1drHNGvGLcr3jE4Gxy74OkPbzWNFutAXsy9VriLnSW7YEbJSwT6wtaUo1Tbd0hSGZfRvbynhLx1lILKosDiXVaP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723553778; c=relaxed/simple;
	bh=ZxuHYHkdRBnHrmqtZYmytkKrjNv6hYr2neyW/NeJqRY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bRw9dmGzoy4rFuChukqdfn1ZeC/1M0TcecxCDpTFXRpez6ncsVUV008ykpHI9zMiUO/Wv992AGxcMtPAdP2JxHayw/YLhYkq9GZqHZIwhR/q3jA8uVFAaO2t2SqBKR+aKJ96ijqW8xNuFw+8rfvOxaX6c2IJ/kKyEGxDb6ogxDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net; spf=pass smtp.mailfrom=machnikowski.net; dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b=HfmmGj5Q; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=machnikowski.net
Delivered-To: maciek@machnikowski.net
ARC-Seal: i=1; a=rsa-sha256; t=1723553769; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=bbOxxKt6p7rBC7KWmrwBxQF4V0G54wQ6RBn4gbWc9UKigrDeQblaSOJSsaDWhMNRD0VxYl7EVoOMu58fWZV7Pw26UNPwXm7farKNVuW3rrbpjqkIIh4m/FPOBdyGzo0WK4n4Sad+NsP+L1RBRaFajSRWsI5HEZnG+J79pJ4O8qU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1723553769; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=NVu3JX1cNE+kytMTtcPEpgg+dzqy8/YJsGYrAtcZCd0=; 
	b=QXDy1HI3FobWuEUuaTM+bp7+Utf6hj0XGi0yrxtYV5mB1r9O6SjgiFdZbrtEfd+beMyhYWk2Ru1awAQN8ecEPWJEHMRMgqIKExzI2PQfvIHYcEYmq1jSMYyjBmFbYjK+Zgx7g/ZUMP9fNE8wlXAQDuvJyXpCVvGbOyCg8/gnpZU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=machnikowski.net;
	spf=pass  smtp.mailfrom=maciek@machnikowski.net;
	dmarc=pass header.from=<maciek@machnikowski.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1723553769;
	s=zoho; d=machnikowski.net; i=maciek@machnikowski.net;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=NVu3JX1cNE+kytMTtcPEpgg+dzqy8/YJsGYrAtcZCd0=;
	b=HfmmGj5QMs2rz/4llTIZ7t23bPVAJ/E5EfrAX2EeClMkmH96VsH3xuoRKGuiqaDL
	dnxz8uy18JScNk/NZ+GJCbMJ1kBpGn1TSztuHtsa1q+JSxGi03Pz7QNPKV24lmxnGk3
	oHrCh0q52BWhifMXltDhWj7EqVFcH9LK5Io0Lk10cPmguAiRSywuSjQiZwPmbWG0gCX
	Fq+YMpQT973DPJfteDtb/3aTej+UdtMzLRXwnFNzFjptcPtsPy7H4Ti2xmJwdw+6O2h
	lSft5uF7x57MaYv69ckwKs43/uDq1cD1vNhhi/fXqS061IcxqtK53DLpmKw6EvyzPk4
	sXEl4YRnog==
Received: by mx.zohomail.com with SMTPS id 17235537680381006.3829471530764;
	Tue, 13 Aug 2024 05:56:08 -0700 (PDT)
From: Maciek Machnikowski <maciek@machnikowski.net>
To: maciek@machnikowski.net
Cc: netdev@vger.kernel.org,
	richardcochran@gmail.com,
	jacob.e.keller@intel.com,
	vadfed@meta.com,
	darinzon@amazon.com,
	kuba@kernel.org
Subject: [RFC 0/3] ptp: Add esterror support
Date: Tue, 13 Aug 2024 12:55:59 +0000
Message-Id: <20240813125602.155827-1-maciek@machnikowski.net>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

This patch series implements handling of timex esterror field
by ptp devices.

Esterror field can be used to return or set the estimated error
of the clock. This is useful for devices containing a hardware
clock that is controlled and synchronized internally (such as
a time card) or when the synchronization is pushed to the embedded
CPU of a DPU.

Current implementation of ADJ_ESTERROR can enable pushing
current offset of the clock calculated by a userspace app
to the device, which can act upon this information by enabling
or disabling time-related functions when certain boundaries
are not met (eg. packet launchtime)


Maciek Machnikowski (3):
  ptp: Implement timex esterror support
  ptp: Implement support for esterror in ptp_mock
  ptp: Add setting esterror and reading timex structure

 drivers/ptp/ptp_clock.c               | 14 +++++++++-
 drivers/ptp/ptp_mock.c                | 30 +++++++++++++++++++++
 include/linux/ptp_clock_kernel.h      | 11 ++++++++
 tools/testing/selftests/ptp/testptp.c | 39 +++++++++++++++++++++++++--
 4 files changed, 91 insertions(+), 3 deletions(-)

-- 
2.34.1


