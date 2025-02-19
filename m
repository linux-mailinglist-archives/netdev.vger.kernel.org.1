Return-Path: <netdev+bounces-167911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13CCEA3CCA8
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 23:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 159541897032
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 22:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BABA825C701;
	Wed, 19 Feb 2025 22:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ckcgofDE"
X-Original-To: netdev@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3644E23C8CC;
	Wed, 19 Feb 2025 22:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740005492; cv=none; b=MCtWpS0bzr3bBFFQ8XriaJ82ADX3cC140agz5UJT6AejoP3YtsXW+4t/b/F3IjsHYyntckN/NcDlcWY61qz1DLiQoqrjZzFoYygoILMTQ2QvOFpjkSytLu1wMPAjEde0I0aBwPwhH4TQnOqHGeDF8G6KyjPAqraxxWh+ChQNtpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740005492; c=relaxed/simple;
	bh=pZjpSlTU9Gu1+mrJmipjqNGPZ19IIS+zBmhe//BAogQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LGQZt/No/3UZLtpAiABcszOyRSp98T5lIVx1T5KszJkamNVmOyX7voUwnzZGtj+siR7g+Emlj0oWRn2hWg+h+BUy+OpJQzIkNOiumMUOxP7TBRG9yRniHs8wP+pESIliJHu6utHt70Z2lpAwvMjdS02QsNCuTZEnEXLJW7wK3lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ckcgofDE; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from eahariha-devbox.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id A6D112043DEB;
	Wed, 19 Feb 2025 14:51:30 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A6D112043DEB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740005490;
	bh=kOHh9LYrSJLeelyupZnwHRYiV4YeXv4E28YqBvlGdQU=;
	h=From:Subject:Date:To:Cc:From;
	b=ckcgofDESTqrDjkAKYJcGMCKIwRyKk0HKgG5MUVCq+D6CYywX7jzELu1NqWGeTLAj
	 IJe8BcCAT/TeJF+kEr+38Sye4i2lh44uIoYFdvfVfAb9P/0HibbhiHf1CbkmdLCnrV
	 sjUfr2b18T1uNMJ2fdb2Zv0wJJoKI87uaxFKdRjs=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Subject: [PATCH 0/4] Bluetooth: Converge on using secs_to_jiffies()
Date: Wed, 19 Feb 2025 22:51:28 +0000
Message-Id: <20250219-bluetooth-converge-secs-to-jiffies-v1-0-6ab896f5fdd4@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHBgtmcC/x2NQQqDQAwAvyI5N7CGFrVfkR7aNVsjZSObVQri3
 xt6HBhmDjAuwgb35oDCu5hodmgvDcT5md+MMjkDBboFagd8fTauqnXGqHnn4oZxNKyKi6TkLST
 qr10cwpS4Aw+thZN8/5PxcZ4/GwAfiHQAAAA=
X-Change-ID: 20250219-bluetooth-converge-secs-to-jiffies-22847c90dfe7
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Johan Hedberg <johan.hedberg@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, Easwar Hariharan <eahariha@linux.microsoft.com>
X-Mailer: b4 0.14.2

This series converts users of msecs_to_jiffies() that either use the
multiply pattern of either of:
- msecs_to_jiffies(N*1000) or
- msecs_to_jiffies(N*MSEC_PER_SEC)

where N is a constant or an expression, to avoid the multiplication.

The conversion is made with Coccinelle with the secs_to_jiffies() script
in scripts/coccinelle/misc. Attention is paid to what the best change
can be rather than restricting to what the tool provides.

While here, convert a couple instances where the timeouts are
denominated in seconds manually.

This series is based on next-20250219

Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
---
Easwar Hariharan (4):
      Bluetooth: hci_vhci: convert timeouts to secs_to_jiffies()
      Bluetooth: MGMT: convert timeouts to secs_to_jiffies()
      Bluetooth: SMP: convert timeouts to secs_to_jiffies()
      Bluetooth: L2CAP: convert timeouts to secs_to_jiffies()

 drivers/bluetooth/hci_vhci.c  | 4 ++--
 include/net/bluetooth/l2cap.h | 4 ++--
 net/bluetooth/hci_sync.c      | 2 +-
 net/bluetooth/l2cap_core.c    | 4 ++--
 net/bluetooth/mgmt.c          | 6 +++---
 net/bluetooth/smp.c           | 2 +-
 6 files changed, 11 insertions(+), 11 deletions(-)
---
base-commit: 8936cec5cb6e27649b86fabf383d7ce4113bba49
change-id: 20250219-bluetooth-converge-secs-to-jiffies-22847c90dfe7

Best regards,
-- 
Easwar Hariharan <eahariha@linux.microsoft.com>


