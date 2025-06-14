Return-Path: <netdev+bounces-197749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD2EAD9B98
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 10:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 477EC3B88DB
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 08:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66BBE2C08C0;
	Sat, 14 Jun 2025 08:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fRRe4bib"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC295298275;
	Sat, 14 Jun 2025 08:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749891378; cv=none; b=Ze507UYmq8CCtPBC/plKBtp5QmhhDCp5ax+QBhUIfGM7Fp4bLlcJVIL5RFWpQE8HhohQj2Kf9OsVCnGb/xbo6udoMwdIxGGwtYZiArj152GoWo2VISXcmPX5W1Myb7RyN4xe0pse0Kx5O8Rr4MA+cjzVB33DrxcQ9dA9+pE5wXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749891378; c=relaxed/simple;
	bh=qdx5eLFhJs3mwB2br6zWhdyUu0aQq9T5BmAjQqI3pSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T5TifL6uuVG8cjsfOqX2rUDUNrxMgrERQE/VxcV4T9uuKreLPoVBCKOmm4DZhFbWE/EEwk3H9I2d+pOIoCcI84bYtjxpkQ/8LOFlxpFFf2dqL8d8ujLoMTEZ+2HXhcm+shZrVrCoYoxhg2gQByiDnyxT8AGeQdO0aG9/Z4O3ZMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fRRe4bib; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BCEBC4CEFF;
	Sat, 14 Jun 2025 08:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749891378;
	bh=qdx5eLFhJs3mwB2br6zWhdyUu0aQq9T5BmAjQqI3pSk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fRRe4bibDS/u9thmwGwVWeIq4dGZQmcY2oPfPsgNovEavyhOqG4K4X+ETeimzMBMJ
	 3oWMiJV/KOsDPul2jDHGT3QRPP5pFGerBigdb+rlkbk6pOmHqP6pm3hfGaTUGcJQDO
	 ritD40S3MBMOQFsDzG4wG46AKF4dq7gkosgKvPNeABScGoX4/WM5eKXR/qc31WA4Fl
	 R4o/8Vp2hhZmvlcRGy8uqLaZssbzLVX2ZwFalitHpADQYBHq3tzFMgQUNFWoYJCaQI
	 gD8J/kVxtCMppRgFWmxYvWeLZdBqpKEOuETM2QewS7R3WVAjuh2ruznm7m7RDuINYF
	 Ul8r2JOeqbTZw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uQMgS-000000064bP-2T2X;
	Sat, 14 Jun 2025 10:56:16 +0200
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
	joel@joelfernandes.org,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	lkmm@lists.linux.dev,
	netdev@vger.kernel.org,
	peterz@infradead.org,
	stern@rowland.harvard.edu
Subject: [PATCH v4 12/14] MAINTAINERS: add maintainers for netlink_yml_parser.py
Date: Sat, 14 Jun 2025 10:56:06 +0200
Message-ID: <ba75692b90bf7aa512772ca775fde4c4688d7e03.1749891128.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1749891128.git.mchehab+huawei@kernel.org>
References: <cover.1749891128.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

The parsing code from tools/net/ynl/pyynl/ynl_gen_rst.py was moved
to scripts/lib/netlink_yml_parser.py. Its maintainership
is done by Netlink maintainers. Yet, as it is used by Sphinx
build system, add it also to linux-doc maintainers, as changes
there might affect documentation builds. So, linux-docs ML
should ideally be C/C on changes to it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a92290fffa16..2c0b13e5d8fc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7202,6 +7202,7 @@ F:	scripts/get_abi.py
 F:	scripts/kernel-doc*
 F:	scripts/lib/abi/*
 F:	scripts/lib/kdoc/*
+F:	scripts/lib/netlink_yml_parser.py
 F:	scripts/sphinx-pre-install
 X:	Documentation/ABI/
 X:	Documentation/admin-guide/media/
@@ -27314,6 +27315,7 @@ M:	Jakub Kicinski <kuba@kernel.org>
 F:	Documentation/netlink/
 F:	Documentation/userspace-api/netlink/intro-specs.rst
 F:	Documentation/userspace-api/netlink/specs.rst
+F:	scripts/lib/netlink_yml_parser.py
 F:	tools/net/ynl/
 
 YEALINK PHONE DRIVER
-- 
2.49.0


