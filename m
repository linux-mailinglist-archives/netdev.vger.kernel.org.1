Return-Path: <netdev+bounces-139617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C985F9B393A
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 19:34:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07CAE1C21752
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 18:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1794D1DF998;
	Mon, 28 Oct 2024 18:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=armitage.org.uk header.i=@armitage.org.uk header.b="AKGVimQC"
X-Original-To: netdev@vger.kernel.org
Received: from nabal.armitage.org.uk (unknown [92.27.6.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1111DF747
	for <netdev@vger.kernel.org>; Mon, 28 Oct 2024 18:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.27.6.192
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730140451; cv=none; b=Lgea+V+35KKoiubDj21VBqllQqNvMPVV3+0WRp6TCZ9WhAUkqf1yclbMTYN70NfANovWpq/vQ4SUxW1ZxBPDmCgv5kQ+K6W5FsofVbNFDammT9kiEktBvMVxHQoj4X4rsyvFAwNDDuDwpMvaWYUcIFZ3z/GiO1bv+rOTFLxHocY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730140451; c=relaxed/simple;
	bh=ntwe3xFcSfe163Fw5yau7H3b+l20QWW7k4nNHkbjPGo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=krCClLw69mZcNjKpD5hAkBZYqxBDDOeDztsJTx3DjksZ1lqYLySkzQgQv/kdQpfQigg2tBRdIdoKjvoiDzdu+UZrO0+72pgotcZyqBvFPzmyP7kGeoL25lXbW/X3/1n4mbr1fhOL7b+8qB3G2IoCH9Qxoz7xzCupBjoKZpktwsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=armitage.org.uk; spf=pass smtp.mailfrom=armitage.org.uk; dkim=pass (1024-bit key) header.d=armitage.org.uk header.i=@armitage.org.uk header.b=AKGVimQC; arc=none smtp.client-ip=92.27.6.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=armitage.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=armitage.org.uk
Received: from localhost (nabal.armitage.org.uk [127.0.0.1])
	by nabal.armitage.org.uk (Postfix) with ESMTP id A56DF2E53AA;
	Mon, 28 Oct 2024 18:27:22 +0000 (GMT)
Authentication-Results: nabal.armitage.org.uk (amavisd-new);
	dkim=pass (1024-bit key) reason="pass (just generated, assumed good)"
	header.d=armitage.org.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=armitage.org.uk;
	 h=content-transfer-encoding:mime-version:x-mailer:message-id
	:date:date:subject:subject:from:from:received; s=20200110; t=
	1730140027; x=1731004028; bh=ntwe3xFcSfe163Fw5yau7H3b+l20QWW7k4n
	NHkbjPGo=; b=AKGVimQCb12YRFsucM6ghmmWL734m5YYt/9VawUMBPTTMYiUfhE
	HGF/fVdVmIuWFlFnZEGcwwaTdRBG6L+IcvTBbhzoMfSMMSdwnsz4Zc/HNQX+pvDT
	dAyPKMgfZnuNUIbMqHMXdYnJtMi7wb/0ikFHYhndGJauMaH2vx6P1Wfk=
X-Virus-Scanned: amavisd-new at armitage.org.uk
Received: from samson.armitage.org.uk (samson.armitage.org.uk [IPv6:2001:470:69dd:35::210])
	by nabal.armitage.org.uk (Postfix) with ESMTPSA id 405DE2E5353;
	Mon, 28 Oct 2024 18:27:07 +0000 (GMT)
From: Quentin Armitage <quentin@armitage.org.uk>
To: netdev@vger.kernel.org
Cc: Quentin Armitage <quentin@armitage.org.uk>
Subject: [PATCH 0/1] rt_names: add rt_addrprotos.d/keepalived.conf
Date: Mon, 28 Oct 2024 18:26:59 +0000
Message-Id: <20241028182659.310537-1-quentin@armitage.org.uk>
X-Mailer: git-send-email 2.34.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The patch adds an address protocol identifier for keepalived, which now
sets the protocol field when adding IP addresses.

The value of 18 was chosen simply because that is the value of
RTPROT_KEEPALIVED, whick keepalived sets for ip routes and rules. The
value can happily be changed if another value would be better.

