Return-Path: <netdev+bounces-161199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A329EA1FFF8
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 22:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BE82165775
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 21:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA31F1D86E4;
	Mon, 27 Jan 2025 21:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="VrMHoolz"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4B71D7E31;
	Mon, 27 Jan 2025 21:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738013846; cv=none; b=AbE9TN1+4wCWjhkLr3hyij3AYzO8k1OPXZ3XgjQMyCnF1fOXD1AqC5hGKDNF2IurnC3jBMxiKj1FJsTTS8vNKi+8CwyUKYN3gg7MlIycdXWghQRTTHqshgZteMIEfNrlG/S6Pl80Mw19XkUJKPIMQzAZdnSDUg7kyzmpdQebvvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738013846; c=relaxed/simple;
	bh=azgMEnD6r8HfsrMZT1Y82Fn/fiuBFmXON8stF68REpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aTdtM2JTzmu4OVmLmCLL0ZLZdHlf/YLc1YcxTwusn5zcg2AoJciQUXEZAiYerSWHK22hAcmEcaw4A98ekh0rcjtPXlO/9LLhx1MCCwIX4W/hFHj0IVv4Q1ZMiC1nmVBumDQXHaTy6oeBmyQoaZCL2PZK9OXq/2xTT6wNnJUtXHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=VrMHoolz; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=ifMP4EWyzhCrMfXhnckJ28Yc7rD0y2bx5+E1WJBchr8=; b=VrMHoolzruMRtoWl
	FscqVcwsbJXTVaOapHqbHziOsCiBjLmY9nmWzm3Dn9kiVKueoCrIkittPhUCftBlbKkccXwobasau
	PyCjZL4e9n6qI8vM/0e0A7bcJaiY9I+b/VnjUh3L/yxi/Yp9PfPZwIlWnYp5+tuIsIZtCxe44FZ0q
	tsvyeGDvGJ2Ub3u3FbweoQLxxGTuGu99M0C5XY2jD8G7EDfS7Z9TgmjSijAn3vnihfskpuLYcCJKC
	ONOJ8SxPzZg6c0JC7LrlXwqJUVetg8MAZb5/dBqlKhPYmvXlGPL4ublQAlzAUKitgSIvqRY6jX8O7
	XPg4+MTCuG4Rbb2rrQ==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tcWnF-00CMm7-0K;
	Mon, 27 Jan 2025 21:37:17 +0000
From: linux@treblig.org
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 0/2] Bluetooth: MGMT: Deadcode cleanup
Date: Mon, 27 Jan 2025 21:37:14 +0000
Message-ID: <20250127213716.232551-1-linux@treblig.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

Hi,
  A couple of deadcode removal patches.

They're both strictly function removals, no internal changes
to a function.

Build tested only.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>


Dr. David Alan Gilbert (2):
  Bluetooth: MGMT: Remove unused mgmt_pending_find_data
  Bluetooth: MGMT: Remove unused mgmt_*_discovery_complete

 include/net/bluetooth/hci_core.h |  2 --
 net/bluetooth/mgmt.c             | 40 --------------------------------
 net/bluetooth/mgmt_util.c        | 17 --------------
 net/bluetooth/mgmt_util.h        |  4 ----
 4 files changed, 63 deletions(-)

-- 
2.48.1


