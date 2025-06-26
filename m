Return-Path: <netdev+bounces-201456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 883B6AE97E8
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 10:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E8F81C40BF2
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 08:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9261E280309;
	Thu, 26 Jun 2025 08:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dZSSc3lC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6188C27EFFE;
	Thu, 26 Jun 2025 08:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750925627; cv=none; b=FTjV4f8F3oTKzwF1m/kwX1HgRMR8Mbnk6P40400krtlJ8hgplBUdS3LnCY8Lv7DZvAqOpbBRCT6Q4CRtV3UFzJKVj8bHGaqQ9RzFkqOsGwCo+oH9uVeX3zv8PcA8Zh7GBbhiJKl9hpkv3ecQI3czs+mxSKk7KZRpRNG1pvOk0kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750925627; c=relaxed/simple;
	bh=X4Z02Ix5q9iOywebPzf+auB7H7wMBOxaBbJ6xul2TEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=adhCPSms0fKpnwoYd+VqORc+PgnX+yVFoK1l+1IHY7lZTWWdjvtl+Lg18znh7rqeJGo3udRbYV4bPfrOHixPp601qig5unIgx9tOOj6kjuf7vKdXPgTJVhrEIFBQhn2lOTe656VSaOLHEaD0ScNL9wqkWA+789e0VIlAjY87dOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dZSSc3lC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC25DC4CEEB;
	Thu, 26 Jun 2025 08:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750925626;
	bh=X4Z02Ix5q9iOywebPzf+auB7H7wMBOxaBbJ6xul2TEQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dZSSc3lCHhZXhuA2md7b515cucg4Swx55ngDIM3p8xWzDXuIJYHo9QrQpY+Qq0r3J
	 rKIcqHBIu05SVf7Gyqg05fyvjxPP13sN/rot3n7975NE34Pop39+Pj2GC7rK8pWIWD
	 lFs0hArYMFEQEoukuMxOtId0OatSuvE9+kBCJQSnVLXWI3g92yIA8ITKEwg84KFzTT
	 jjJ+Dp2Rj58wBvHXLNARlU280PCJZ8LWZON2u8NhEDKHTR+bOB7PeCev8T6UEglJ3/
	 jqf64eczb2aZs6d/y+a7lDqa8awAbZOnUB6yuJwkLAgU/PqNsQbIkLpgq+pULDE7cQ
	 TsoQGW1RuI46w==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uUhjT-00000004sw2-23mC;
	Thu, 26 Jun 2025 10:13:19 +0200
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
	"Randy Dunlap" <rdunlap@infradead.org>,
	"Ruben Wauters" <rubenru09@aol.com>,
	"Shuah Khan" <skhan@linuxfoundation.org>,
	joel@joelfernandes.org,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	lkmm@lists.linux.dev,
	netdev@vger.kernel.org,
	peterz@infradead.org,
	stern@rowland.harvard.edu
Subject: [PATCH v8 10/13] MAINTAINERS: add netlink_yml_parser.py to linux-doc
Date: Thu, 26 Jun 2025 10:13:06 +0200
Message-ID: <a8688cae5edb21b9ebbc508d628c62989a786fb7.1750925410.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750925410.git.mchehab+huawei@kernel.org>
References: <cover.1750925410.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

The documentation build depends on the parsing code
at ynl_gen_rst.py. Ensure that changes to it will be c/c
to linux-doc ML and maintainers by adding an entry for
it. This way, if a change there would affect the build,
or the minimal version required for Python, doc developers
may know in advance.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Breno Leitao <leitao@debian.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a92290fffa16..ffe3afdad157 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7202,6 +7202,7 @@ F:	scripts/get_abi.py
 F:	scripts/kernel-doc*
 F:	scripts/lib/abi/*
 F:	scripts/lib/kdoc/*
+F:	tools/net/ynl/pyynl/lib/doc_generator.py
 F:	scripts/sphinx-pre-install
 X:	Documentation/ABI/
 X:	Documentation/admin-guide/media/
-- 
2.49.0


