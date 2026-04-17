Return-Path: <netdev+bounces-279394-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCw7ALty4mnR5wAAu9opvQ
	(envelope-from <netdev+bounces-279394-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 19:49:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B42DA41DAFA
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 19:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BA29C300C0CB
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 17:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC513AEF33;
	Fri, 17 Apr 2026 17:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="do47RhCS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623EE2FFDC4
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 17:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776448177; cv=none; b=lrAYcK6MeHY9/VIZDn1svcBaqYEaWjIgrNJKmHkzeiI8mUX1PuAscn7zfCh2Pv5jeCnEwNMlabU+Mudc0OKz68ddZxPwyJKFH0rcWK8XSgp4GYrl2De8ToEzf5qD5TL+HkWLrnJ8+YKQtjvog5UIQMzFVGqfSnK2pBc1l+g08Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776448177; c=relaxed/simple;
	bh=Y5gGVtPUQWWV9DgXubawA41gEn2jv0Fyb1w6SaJul4Y=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:To:Cc; b=RjvENE7ZZt7CNM8avPYMZX4IQPOwBdhQpXFy84OB2Szzq/wZqbXGPjH46hmpjKEeaHs9uoVCVD8i8V/889z+iv1VxV16qA1Ewgtu1/yy/D62Sdv5nSOWKbztBOCBKJ2RtAK/2upxKjRKzKiWtC6Zf/DghKZtfdEkJUuGr1eIvfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=do47RhCS; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-82d0b68837aso650327b3a.2
        for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 10:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776448170; x=1777052970; darn=vger.kernel.org;
        h=cc:to:subject:date:from:references:in-reply-to:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EY6Kxrq1+okn9a1kU1LHUIX3F/DntU2kfVrB9AkbALc=;
        b=do47RhCStnn/9/vsRCby6oMNJzZRM+LRzrTp/9iIJh7I8MumC1X9xrTLXQFSV/8GRN
         yvMYedxv9D5ox0sCfrEHTKoKDANSlI86VwrrxUETSKIfhNISUwPGflp/WSvSUkraKTZP
         TXKTUAik9JFo7mJVQpGy8wXBaMW6pNQptnV9YDtL6JVQNFbDFi1KzdgOg1EVCsgqdswI
         QIYuBdGIvGO8FUx/QepfyHBjt+IXTNmD4lALR3Qo3I2OReV+B1kW7POyoPquhisUkA06
         8lnrK0/vTZbM+axNatdx9m6azt6Nfc/1jV4iPj9nmCZYd0RKdEYlLHD0XM7wdO4MyGuv
         Vsmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776448170; x=1777052970;
        h=cc:to:subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EY6Kxrq1+okn9a1kU1LHUIX3F/DntU2kfVrB9AkbALc=;
        b=H8tgaHw1QOnjfjPGflMGHrIWxAk1Aix3VEm/kWhzKsg54/V7k7q5504K1TW4U/jG9k
         QShEagP3+y9kcRKXRDiS4Ns0gGfzkR3QsFGnWz9WLDzJ1UHviItrUVbvT0TVDbbr3EMQ
         ZkrJLLq5H34ANohsODQPfl3Xqj6muFRNW0//szmG3bl7GNK3hH1MBhEXLQTR5ZN0WOtL
         812l5xoQ8qUB3wXRC4dmke5iKi6wPM+G+4OuZQ9ju0HvR5SFOB7etB1Zj7SBMH9ww06H
         uoZSzy3Bu8TAryjTLx2epjR0ScIYW9hW8Tu3tzLq/io69w1XXJG1SJJ7y2nHUhl3NLIB
         MADg==
X-Gm-Message-State: AOJu0YyOxz6e7edahk+J3V8/B54ClpdGwny9fK8wfepkmWIzXv4dzh5O
	1unbPB2rL191670Q3I9fpgOdakr+r1MUnSg0shD6VjbtsPKWgGmklXZ00FEQ/g==
X-Gm-Gg: AeBDiessZvGCj8Trw27lE2CUy4jrXHpDA3n1czgeFqbWWgrF7pL2u2uSGN8WcRkrPWZ
	Bgv8maOAnEEyVUs14c/T5+f0LINYihgRa7GbRZ8HgZfmZJUXFu0eTtNb7uNhb52XgwJ2zA0ZtwB
	9W1ClmDg5WdMKdq/QMxyeHn/RIftqTDnhZz/UaKs2TKsUcQbFVWAVa9ALrjsYmP9AwEZEzZpqe1
	aCYjZNkuFLvCGj21oIyolFlH73RHtni4I5xP9Pw0VB/EW2BHhTYXj7Rc4OIUeHWNfxyxKiiADCu
	RbGWs4AprMoRAMug1L7nE+VBzrvlNv4GSM1HiRAgAnMlCpP9q1tUom03BB2jZSgDxvNbiD+GwiQ
	6tIIB3Z7qlRxHpWHfeO5JOln80eFDHAjbUEXmV8uGaJHzT9GE2EuGK3iZbF4GnX/nf9KQ1PIW7a
	XkOoO0v5oqYIlVK2Ib8f4FjMee790+P2adMLRzc9Fx8/cIqx8vwb83LR7hUsuOrQUGqxKUF5tFl
	bSo09Zk4hX73zpZmX+cMGjwFDI=
X-Received: by 2002:a05:6a00:bb0d:b0:82c:e60c:f376 with SMTP id d2e1a72fcca58-82f8c934432mr4531401b3a.47.1776448169406;
        Fri, 17 Apr 2026 10:49:29 -0700 (PDT)
Received: from Shuvs-MacBook-Air.local ([43.245.86.86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ec23b19sm2949913b3a.59.2026.04.17.10.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 10:49:29 -0700 (PDT)
Message-ID: <cover.1776446840.git.shuvampandey1@gmail.com>
In-Reply-To: <20260414071322.30851-1-shuvampandey1@gmail.com>
References: <20260414071322.30851-1-shuvampandey1@gmail.com>
From: Shuvam Pandey <shuvampandey1@gmail.com>
Date: Fri, 17 Apr 2026 23:34:25 +0545
Subject: [PATCH v2 0/3] mISDN: fix socket/device lifetime and naming races
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279394-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shuvampandey1@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B42DA41DAFA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is a respin of the original get_mdevice() reference leak fix.

Patch 1 makes unregister wait for the last device reference and closes
sockets that still point at the device before delete_stack() runs. It
also serializes bind against unregister so a new socket cannot attach
once teardown has started.

Patch 2 drops the temporary get_mdevice() references from IMGETDEVINFO
and IMSETDEVNAME, and serializes those ioctl paths against unregister.

Patch 3 keeps an mISDN-owned copy of the device name so ioctl, sysfs, and
debug paths no longer depend on the kobject name storage remaining stable
across device_rename().

Previous discussion:
https://lore.kernel.org/r/20260414071322.30851-1-shuvampandey1@gmail.com

This series was developed with AI assistance. I reviewed, revised, and
tested it, and I take responsibility for the submission.

---
Changes in v2:
- split the fix into three focused patches
- close sockets before delete_stack() and wait for the final device release
- serialize bind and ioctl lookup/rename paths against unregister
- cache stable device names for mISDN paths outside the kobject
- keep existing debug behavior while switching layer1 name reads to the cached name
- document the device_lock(dev) -> lock_sock(sk) ordering
- build-test the series on arm64 with W=1 for drivers/isdn/mISDN and
  drivers/isdn/hardware/mISDN

Shuvam Pandey (3):
  mISDN: serialize socket teardown against device unregister
  mISDN: socket: drop temporary references from get_mdevice()
  mISDN: cache stable device names outside the kobject

 drivers/isdn/mISDN/core.c   |  37 ++++-
 drivers/isdn/mISDN/core.h   |   1 +
 drivers/isdn/mISDN/layer1.c |   2 +-
 drivers/isdn/mISDN/socket.c | 263 +++++++++++++++++++++++++++++++-----
 drivers/isdn/mISDN/stack.c  |  36 ++---
 drivers/isdn/mISDN/tei.c    |   2 +-
 include/linux/mISDNif.h     |   2 +
 7 files changed, 284 insertions(+), 59 deletions(-)

-- 
2.50.1 (Apple Git-155)

