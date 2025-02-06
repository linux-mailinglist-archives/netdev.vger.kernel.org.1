Return-Path: <netdev+bounces-163384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 208D0A2A185
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 07:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4720A1884C06
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 06:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0972253EC;
	Thu,  6 Feb 2025 06:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="d/KVp/VA"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFBE2253EE;
	Thu,  6 Feb 2025 06:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738824588; cv=none; b=iiQoQnosuUFyxFVpr5CHMzctlyi0XYzHbcZ2Xlb9jwLrqYTSk4569thjdZuH71p9uYgPSg2/A5cX75iyrEK3hC9NiXJbE86CNspcWI/Isu/WHBCgILM9vWvPTXmj7s+XwpDpgEG3JCa/Fo0N/uSEmMdjHqUro0gsDVUOOCZwgLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738824588; c=relaxed/simple;
	bh=dCM8SuxiUwy3AKxwtl1wkFOXtbVKQdH6LYAJqskM93Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=G6PWLEfa99tmT8ptOE2s1PItPoAK6WfJu7twkmUX1WyykzhH6/rf9sSLJCgQSooOXceb1J9dnJETH2m1xX6/L3AB9xhtoSN+KUtSYXjc8S6JvwaZdZ7RTrhayCIW8Np0KCuqp49SgOwhTF29UNx6RELShAjNKuT7a4yWOnJoDCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=d/KVp/VA; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1738824578;
	bh=uSFvExJxC1WzKZYTAoDe3aA4t+X//ecUZW7qZNVhEjg=;
	h=From:Subject:Date:To:Cc;
	b=d/KVp/VAy4MCnOKxMtW7kF9aSmsjucyoQ2LtDumuM7aqGLHOhH5NAAWJUoayLD2rc
	 ogLkcwbPHXkERMElhMZ8Dh7GgYO1ttG8j6F4llgiurAUsCPT8N8xXJQyy01PoIMRH1
	 RwNIAgefJV8fRYYrTFauQsbabSBI2O+vRfMlwgGjJxdc5zbcU7cowU0HDvSZ7Q4hBd
	 5+gO6+gNK2zfwJaZYdRNZPd/I6PggkjI9/gdYU8kX+hlttkmdv4Y45zrerDd1ffur0
	 Yta3/NU58GXc69CLp3DEA1pUQBRWCQiLLs1KTbcdrl6E/58fPwA6/j5xnP0JOXGTMQ
	 eE3PqB4IDoI/g==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id 38E5974858; Thu,  6 Feb 2025 14:49:38 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Subject: [PATCH net-next 0/2] mctp: Add MCTP-over-USB hardware transport
 binding
Date: Thu, 06 Feb 2025 14:48:22 +0800
Message-Id: <20250206-dev-mctp-usb-v1-0-81453fe26a61@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADZbpGcC/x2MQQqAIBQFrxJ/3QczDOoq0aL0VX+RhVoE0d2Tl
 sMw81BEEETqiocCLomy+wxVWZBdR7+AxWUmrbRRWjXscPFm08FnnNia1mHMqm4N5eQImOX+dz1
 5JPa4Ew3v+wEVKABMaAAAAA==
X-Change-ID: 20250206-dev-mctp-usb-c59dea025395
To: Matt Johnston <matt@codeconstruct.com.au>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org, 
 Santosh Puranik <spuranik@nvidia.com>
X-Mailer: b4 0.14.2

Add an implementation of the DMTF standard DSP0283, providing an MCTP
channel over high-speed USB.

This is a fairly trivial first implementation, in that we only submit
one tx and one rx URB at a time. We do accept multi-packet transfers,
but do not yet generate them on transmit.

Of course, questions and comments are most welcome, particularly on the
USB interfaces.

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
---
Jeremy Kerr (2):
      usb: Add base USB MCTP definitions
      net: mctp: Add MCTP USB transport driver

 MAINTAINERS                  |   1 +
 drivers/net/mctp/Kconfig     |  10 ++
 drivers/net/mctp/Makefile    |   1 +
 drivers/net/mctp/mctp-usb.c  | 367 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/usb/mctp-usb.h |  28 ++++
 include/uapi/linux/usb/ch9.h |   1 +
 6 files changed, 408 insertions(+)
---
base-commit: 7ea2745766d776866cfbc981b21ed3cfdf50124e
change-id: 20250206-dev-mctp-usb-c59dea025395

Best regards,
-- 
Jeremy Kerr <jk@codeconstruct.com.au>


