Return-Path: <netdev+bounces-161236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 364F1A2023A
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 01:07:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B21577A2144
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 00:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D191014A08E;
	Tue, 28 Jan 2025 00:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i/GkfumJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7005B2EAE4;
	Tue, 28 Jan 2025 00:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738022797; cv=none; b=ADdvoWSiP5hoEZKqZJ7FdjwBlEWGMtWHKvY1R0dtCdH0N9CUz+8GQ536lBBiLwStvSVPiFdVSjugCnvy++HkSqAKCbHdFeAzjQjjYd+ADzsq2aAwNWbrj9Og+bMB7fyy3Yrxh60CKkkN5KBLma2jYAeCfSm8hS1tLlHMHZ2x1CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738022797; c=relaxed/simple;
	bh=mcoeXqisQ9cCp+d9XJhL6+xR7Bjlo3DbBhHTGHu6E1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mb/fBHiIn11oNChQoP4ONXrzQiIIdYy9kgXojCXa/+fkHGXpdCqfv+KaonmTv4ajvYZ7mZbtFEVrSKj/XdqJpifzCjmJi9DTYlCMDfEJxEv+lDFfyU9mmBlc7ZAogryI6LjZAmFe70LoaVzEWgM1cyf0KHNSSaHFs92t/MFeqbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i/GkfumJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34C85C2BC87;
	Tue, 28 Jan 2025 00:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738022796;
	bh=mcoeXqisQ9cCp+d9XJhL6+xR7Bjlo3DbBhHTGHu6E1M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i/GkfumJbBhJUTjl4JTzh/iy8mfn9/It3WkKIu3zIlKWvHu0EAtF6V0KNiHIp6yH+
	 Nl7g3XMYh8T3nAZDYNTH4IsWgzt3chE87YqXd9u+uF18FfHV35y8NvD8p6a4RbE+sy
	 3P+PnnEql66gkIKL5eGyr2s8R9MZenErrYRqiDBFrVt/BTZQiZPQlq4f7gUAQGt9Su
	 6QQlsVsVL+nWBVxAkWsloMmi14Efc7VQYDoPiq7r9NTXDpiMLlS+9mIG48m1OcT5tc
	 ERR8Y/O25a9SGMYM29Wzs5i9jD1k9509j8EMqpHiyXffA3pUqaF/8xbgsh/68tUDkc
	 FZas3WZRc/ePw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tcZ7i-0000000DRMW-1ubB;
	Tue, 28 Jan 2025 01:06:34 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <mchehab+huawei@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [RFC v2 33/38] docs: networking: Allow creating cross-references statistics ABI
Date: Tue, 28 Jan 2025 01:06:22 +0100
Message-ID: <cf7ac7aea937893d05874e2381e59274bf2e3fbf.1738020236.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1738020236.git.mchehab+huawei@kernel.org>
References: <cover.1738020236.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Now that Documentation/ABI is processed by automarkup, let it
generate cross-references for the corresponding ABI file.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/networking/statistics.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/networking/statistics.rst b/Documentation/networking/statistics.rst
index 75e017dfa825..518284e287b0 100644
--- a/Documentation/networking/statistics.rst
+++ b/Documentation/networking/statistics.rst
@@ -143,7 +143,7 @@ reading multiple stats as it internally performs a full dump of
 and reports only the stat corresponding to the accessed file.
 
 Sysfs files are documented in
-`Documentation/ABI/testing/sysfs-class-net-statistics`.
+Documentation/ABI/testing/sysfs-class-net-statistics.
 
 
 netlink
-- 
2.48.1


