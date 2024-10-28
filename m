Return-Path: <netdev+bounces-139431-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9169B2403
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 06:07:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 994FD1F2127C
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 05:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1663D18A922;
	Mon, 28 Oct 2024 05:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="dRXjB4rF"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113CD524C
	for <netdev@vger.kernel.org>; Mon, 28 Oct 2024 05:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730092070; cv=none; b=q5ZSRE9nnSH2C4dsvnTxdkJEpEoUfkvHRmdlFpanNlN1obLLbBMcpXaxEmBFLuN9ChECehlSd0ClKnWti9eoyH9raZuH2bru6G9cqCGXneLMZS+zfvsZaAgMHDK1+v28ZYWxpTyppeWbcbR1+TJuacHktQzABlQWy65Va7WfmWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730092070; c=relaxed/simple;
	bh=MHJ8M0XTUw3n0+B/OPNfqM7omj7kjjTtjuDhn67q+D0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Gtb+fjv9G8UjhjbIAwQ+UiPT8R1hIPOkJnBCV8ZKyV9NVRR8kDI/UtPMJP2XAOacNZ+mlAQmV7uSYSzXvvfxWaRiLw2tdCACqf8biD2c7kNrm31bXbi5OQWdk0XBdesaP+MuD8VHrEsSCqawUFAfM/jSn59CMb+PWwoNSQnxzDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=dRXjB4rF; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1730092065;
	bh=dFYODk9XYqLSsrJugiCA3ButOG0qKjr88vQa8m+VQ20=;
	h=From:Subject:Date:To:Cc;
	b=dRXjB4rFgXhmzQGYwlvaMeUgNAl7vYtDGc3hLxrT0v3nMOMFPKPJXGr0iAH/iH+ps
	 ekqvnjwedHSkPlnL7cWzK02rm2p1Ud2xvVp+sl8v3nUjt7m1eXzBSk3hUi40YvLZks
	 ZZ1LTaICjnZiyKtIzElDBZo50yF0dRqDhWp+ie9gedmPYgbAnK+AUzH7sGj3xJbeP6
	 +HjoGCgmdo7YtCAN4tPp29Yg3DaQdnZZAnZN4hUhw9B+Vw5eKbtoBn5vatMOWspEC1
	 r7lxOr1IWWAII42JosiZzWAv9Ww2a49Z9SvqeJ80oPZU7P2FmB1uDx+StxqzM4m6OV
	 2CHB/jXKJg8sw==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id D80C969E63; Mon, 28 Oct 2024 13:07:45 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Subject: [PATCH 0/2] net: ncsi: minor fixes
Date: Mon, 28 Oct 2024 13:06:55 +0800
Message-Id: <20241028-ncsi-fixes-v1-0-f0bcfaf6eb88@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO8bH2cC/x2LQQqAIBAAvyJ7TlBJk74SHdLW2ouFCxGIf086D
 jNTgbEQMsyiQsGHmK7cQQ8C4rnlAyXtncEoM2plvMyRSSZ6kaVyYbIhOeetgT7cBX/R+2Vt7QO
 wcS87XAAAAA==
X-Change-ID: 20241028-ncsi-fixes-06b75bf66852
To: Samuel Mendoza-Jonas <sam@mendozajonas.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Vijay Khemka <vijaykhemka@fb.com>
Cc: netdev@vger.kernel.org
X-Mailer: b4 0.14.2

This series contains a couple of fixes for NCSI handling: one where
we're assuming a platform_device for the attached netdev, and another
where we're assuming a nul-terminated device version response.

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
---
Jeremy Kerr (2):
      net: ncsi: don't assume associated netdev has a platform_device parent
      net: ncsi: restrict version sizes when hardware doesn't nul-terminate

 net/ncsi/ncsi-manage.c  |  4 ++--
 net/ncsi/ncsi-netlink.c | 11 ++++++++++-
 2 files changed, 12 insertions(+), 3 deletions(-)
---
base-commit: e31a8219fbfcf9dc65ba1e1c10cade12b6754e00
change-id: 20241028-ncsi-fixes-06b75bf66852

Best regards,
-- 
Jeremy Kerr <jk@codeconstruct.com.au>


