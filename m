Return-Path: <netdev+bounces-198468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C84C1ADC40F
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 10:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88C87178AFD
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 08:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481B12949FF;
	Tue, 17 Jun 2025 08:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a2fhPZq/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFB528F515;
	Tue, 17 Jun 2025 08:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750147352; cv=none; b=IS2LexmFX9vqdr0GVRnl/njieiPcR2YRmoAuA8/dR4WWf5NNWFW8x2DDRuWtBjkW/LwMdf1/K4tIxXtkcAg4uegEVIqrqK2ntxLrbNLHjim/drVgoj7FpRADIausiYlU6/5aITxrZcctqpD1Z7jXqLsxDabuWg/ee4Dpuk4sJ6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750147352; c=relaxed/simple;
	bh=X34UFnqM4G4i6Xk/mdPdXBpYZ9AY5zKFdIRSFm6AiUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oyluKixota0xWT4YcMbpMy6T29W1QMTj/V7JxtyU0B6i3eQwxYOD5isJ3SZ3K0wiVf2ED3U1MVRxgRCsNNTmI9eucLo4chyqt4axhvYD8D8mvQhlWFMlyDho/igSbgJuFOvUtXe0b5y4BamdxS2fhpcXlKTnN0xNtfI2SNhzltU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a2fhPZq/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEAEEC4CEF7;
	Tue, 17 Jun 2025 08:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750147352;
	bh=X34UFnqM4G4i6Xk/mdPdXBpYZ9AY5zKFdIRSFm6AiUI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a2fhPZq/bc7M9i1qhZ/hJFHT5g4IQsbvJPsxhThpAVMqMx9HAzL37UOAzYavJ4eQz
	 RNC9cXETr9u1SwyMjMEYTF4V6SiNGC54QrMBGYoeopVLq9LEvjZ+MYguAHuPks6Pqg
	 MMJTcOCA5IYX8M/vPhQRfuh1G29AsIgBVe7jHKnuvVPV+kyw3e+lO9jcKoH6SNI1wh
	 cE3EsGsWDMx1xgu0t08SuEisedzc42A6OKJjeBFPFsc1umpi8SvEYfBMgkkigY7LzF
	 uEN0TWSrkUXoVEsJfXeDmoaGaZ2FyKH3yvTzMRmVXeoWyW4tVabhr0QhVXWpxM6I1j
	 z7nxx7zcxfdYQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uRRH4-00000001vdI-0PPP;
	Tue, 17 Jun 2025 10:02:30 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Akira Yokosawa" <akiyks@gmail.com>,
	"Breno Leitao" <leitao@debian.org>,
	"David S. Miller" <davem@davemloft.net>,
	"Donald Hunter" <donald.hunter@gmail.com>,
	"Eric Dumazet" <edumazet@google.com>,
	"Ignacio Encinas Rubio" <ignacio@iencinas.com>,
	"Jan Stancek" <jstancek@redhat.com>,
	"Marco Elver" <elver@google.com>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	"Paolo Abeni" <pabeni@redhat.com>,
	"Ruben Wauters" <rubenru09@aol.com>,
	"Shuah Khan" <skhan@linuxfoundation.org>,
	Jakub Kicinski <mchehab+huawei@kernel.org>,
	Simon Horman <mchehab+huawei@kernel.org>,
	joel@joelfernandes.org,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	lkmm@lists.linux.dev,
	netdev@vger.kernel.org,
	peterz@infradead.org,
	stern@rowland.harvard.edu
Subject: [PATCH v5 08/15] docs: netlink: index.rst: add a netlink index file
Date: Tue, 17 Jun 2025 10:02:05 +0200
Message-ID: <4d8a16864767c1eb660cb905dbc935a3d0df8d9a.1750146719.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750146719.git.mchehab+huawei@kernel.org>
References: <cover.1750146719.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Instead of generating the index file, use glob to automatically
include all data from yaml.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/netlink/specs/index.rst | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 Documentation/netlink/specs/index.rst

diff --git a/Documentation/netlink/specs/index.rst b/Documentation/netlink/specs/index.rst
new file mode 100644
index 000000000000..7f7cf4a096f2
--- /dev/null
+++ b/Documentation/netlink/specs/index.rst
@@ -0,0 +1,13 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. _specs:
+
+=============================
+Netlink Family Specifications
+=============================
+
+.. toctree::
+   :maxdepth: 1
+   :glob:
+
+   *
-- 
2.49.0


