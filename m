Return-Path: <netdev+bounces-197462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9395AD8B23
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 13:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 611A33A9D3C
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 11:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB35A2EBDDD;
	Fri, 13 Jun 2025 11:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tMFGL2LM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8972C2E7F36;
	Fri, 13 Jun 2025 11:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749814967; cv=none; b=oQ8D+JwpeBJcbdURAx888kmdrAOfEwZLyDC7mw7RE+eDaCPzJcO4/r74dc2ycDXwv6paiYdJcztiG081Cjb0fCWvnc23X/0u3bhW8iT1b+gSjn1iVRRPiyyBrRDAKjFgzs2GXbOpXAw9yV9Y6kvIsrf+ztIStWLeibk+zGxTi/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749814967; c=relaxed/simple;
	bh=qdx5eLFhJs3mwB2br6zWhdyUu0aQq9T5BmAjQqI3pSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BCMOihGies2BUU/SdMqFvtqxEoLnt0rQ5yP/Sol9G9c3vPVat4MLgi+Oasftj1+DNRiJHJfvPuA1HtDyYvmjBfdjPV+fILFUYydnWJq7hagQwJBVMmpURmrqZPxAQhRrZkI5IUGIGFd+FCcBpaAcdalobttGqwX1ERcngIFL9bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tMFGL2LM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EA28C4CEE3;
	Fri, 13 Jun 2025 11:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749814967;
	bh=qdx5eLFhJs3mwB2br6zWhdyUu0aQq9T5BmAjQqI3pSk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tMFGL2LMp6jcV5y3OjWE1cneuwdj/V41scMM0iuDv5YGDEbEw0TEbmpgLm9ihPPzr
	 QuL3oTW6HiBiU5Gn8A17+/gDWwFj/1+uSGc3N/NfMvuWht2VkizyXieWpsFwULRlLM
	 13Z+fTR4+4L1BEuQHrU4uVhCw1C4Ly3r4nXB97r1O+y7HzI7zjc3Xw0jxXC5cPYUS1
	 wpUuSmYwJXIm5Tn1aA2B5RC1DFJV1GaPh3e9TaRpyJz2gIH7eQKCnKDXAVRvG8bIYC
	 Tzbq/0ymJ6REa32YPq+ItHq2iA6hec4XPG3ZPYDJ00hRRE0OWyuSHtXD0HMvt1uuot
	 pfzocEgnH4FQg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uQ2o1-00000005dFe-1WGD;
	Fri, 13 Jun 2025 13:42:45 +0200
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
Subject: [PATCH v3 15/16] MAINTAINERS: add maintainers for netlink_yml_parser.py
Date: Fri, 13 Jun 2025 13:42:36 +0200
Message-ID: <6de10a419ab9740030f9508e6e913639953cc656.1749812870.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1749812870.git.mchehab+huawei@kernel.org>
References: <cover.1749812870.git.mchehab+huawei@kernel.org>
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


