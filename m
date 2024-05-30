Return-Path: <netdev+bounces-99426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7236E8D4D7E
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 16:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BCEF1C2105E
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 14:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0458C17625D;
	Thu, 30 May 2024 14:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CzXB3ir2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5342176255;
	Thu, 30 May 2024 14:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717078085; cv=none; b=dhytqclJGnoJ1cPpbE3rsVvywgYed3vdeZEo7FkgrIAmcnK/9fI9maNPomjR2YHceQJPdHRhVfwkYoRkfzIs+5vg/6XfvFTocke63Ujc7GIJ9h7fj09VFxHbguJixJKN/R1S2Za4aT5mXHFA6tLR7h1MLzKuIQJIn/efh/RPbyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717078085; c=relaxed/simple;
	bh=ypvHqt2ffZwH1g8JlbofDCv9yboiuwJHzR7LWZNKd+E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sUUv8+0juik+XsOb69i/61lYiuR+1nQXGMMeYT0BAsgNpF2BGrkEeUuqnNObUjRqe5LAf/mB4kka1m5Sib/YWabXIkQYxvvycguDfm56MUzcbdoFArUKv4DgnCBnDTWmnyw66sejF7tyWhSBgB+Pd2x9BlNpjcPKMwqxCMtRnF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CzXB3ir2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDD99C32789;
	Thu, 30 May 2024 14:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717078085;
	bh=ypvHqt2ffZwH1g8JlbofDCv9yboiuwJHzR7LWZNKd+E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CzXB3ir2IIgx94IToQJmZ8iqh0kroaIe+oun5Kv1IzpccWmxZrN3Jzd/5drYtUAk/
	 WAePxGqp5S+LfxQXooIICHksEIWTjLtRUkESWONn/IywD/+lCKhuve4Y3wGfStiRMm
	 dsoJoc2pbADoffIQYzoM3IroQKeQbDZzPJudsKZe8gnHXE1ULAcmQKXxhuP+v3/Qsy
	 AbNXd3i2E+FJpZf0wglY7qzMx4BSojZQ5z8UKTSdOPgsyHdQC0Oug8FQXCxXsWKmaJ
	 DtAKqVGnr/e5249etpWzceqk2LWmYs8HWiSkzR0segOoXQz6KzE7ugQ+DtHGQ9rAm3
	 Ivuark4MlLLpQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 30 May 2024 16:07:30 +0200
Subject: [PATCH net-next v3 1/3] doc: mptcp: add missing
 'available_schedulers' entry
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240530-upstream-net-20240520-mptcp-doc-v3-1-e94cdd9f2673@kernel.org>
References: <20240530-upstream-net-20240520-mptcp-doc-v3-0-e94cdd9f2673@kernel.org>
In-Reply-To: <20240530-upstream-net-20240520-mptcp-doc-v3-0-e94cdd9f2673@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Gregory Detal <gregory.detal@gmail.com>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=988; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=ypvHqt2ffZwH1g8JlbofDCv9yboiuwJHzR7LWZNKd+E=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmWIg+ifCDXKLYVlPymkLk0rUybrVr4VkGkvaV3
 WgrWxsKvSCJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZliIPgAKCRD2t4JPQmmg
 c93kD/wPQ76GXmHft0q7I15GXZijOXyOUGW11pA4yUJy/i9auOxvQa4PbS+HJhGEUJ2CmFYPNks
 K2jQ7s7cmNNZp5pgSFrfdCzkIQHrqj+n+ul6boz5iu7CePnyNwBQxwr7RpXOTXOWzFV9FD4k5mZ
 JsI/o2RtEWRuscZpI71/nYacsOXzDkz+D9HXlG1Ya3QdAYK1oKDt6LjqWn+MgtOezGT3Wxcj1Hs
 C+MWyXUSgHaNuLTv32EX1Y4F4DnSo8OcXlaqnUka4rTgjQALJWY1MwyxjO0ki1W1dP9ySPqMCSQ
 OB6NrPVSs0B6ZJB+5vmIV/MCcKyiJ+3HiNWysnvRc/URWNRTuaSB0Spf+Ew7LA3SEd08O4zpcv1
 4Q4a2RKJXIXoEQArasBMUb4mucVVcXl1dE6JmhV+/DErOV9brOdR97c4cZX5Ynrs6NFvAEdWaOo
 b9xvibxcrPEkyEJIX69UmAX1yob20PRN7HHxAyAk/wwk1H7T1HWKfDLpNmg20Y1htzTGZq64Ayu
 svcIq/lVTEy3STjBahoNb99MsoVbrAYli7gsDwiHG9LFPZRyqs0OspuC3t1HV1/PGoghXGpNmT8
 Agdmk8/Ik7t4bC4honbY/G9MG90q31kY0EAZGzl8TNR/5pUid7jli8ERw3kgZdUY7MWNj1m0lUR
 jrbTYe3yCGhXUog==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This sysctl knob has been added recently, but the documentation has not
been updated.

This knob is used to show the available schedulers choices that are
registered, similar to 'net.ipv4.tcp_available_congestion_control'.

Fixes: 73c900aa3660 ("mptcp: add net.mptcp.available_schedulers")
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 Documentation/networking/mptcp-sysctl.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/networking/mptcp-sysctl.rst b/Documentation/networking/mptcp-sysctl.rst
index 69975ce25a02..102a45e7bfa8 100644
--- a/Documentation/networking/mptcp-sysctl.rst
+++ b/Documentation/networking/mptcp-sysctl.rst
@@ -93,3 +93,7 @@ scheduler - STRING
 	sysctl.
 
 	Default: "default"
+
+available_schedulers - STRING
+	Shows the available schedulers choices that are registered. More packet
+	schedulers may be available, but not loaded.

-- 
2.43.0


