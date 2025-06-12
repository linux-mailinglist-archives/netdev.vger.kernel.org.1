Return-Path: <netdev+bounces-196909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A6DAD6DDC
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 12:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0BED1748F8
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 10:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34366248F63;
	Thu, 12 Jun 2025 10:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ujSnLxIC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A9D239E8F;
	Thu, 12 Jun 2025 10:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749724344; cv=none; b=eVP7s2P+2lrhzkKqBnqh8nLcqNOgj2Dwh2O+zVM0l1gP12bbcEFBThxlBmco33T5CpJlEUOwEKHfVJyD+RamNOJW3TLoPtURvoImtCNZOGvAWmi9MDOW9GceC630j78pJSbjv9X6OoXPFLV+fFbc5dKWtDq58sbsKkx4znRCwnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749724344; c=relaxed/simple;
	bh=FsS6lOMAqt6O4kSiWFDk/a19S4XMRpll04UTzLeJcwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UJlaePbfY0kSMLaYSnDlSUW6XakcJaBn4f7aVAJFYW1zZ6u0d6fGcqnkLlH3Wh1zo2cwtiFNCt3GGkqBYOX80vkdXCJp/vpoABaIX2g/g6L7YD+UcMWFVty+1O6wQRjrVixZCEyZQZndFzhs0dTJy1kj0LaLJSPXXGadGQBFvb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ujSnLxIC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64C7CC4CEF1;
	Thu, 12 Jun 2025 10:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749724344;
	bh=FsS6lOMAqt6O4kSiWFDk/a19S4XMRpll04UTzLeJcwU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ujSnLxICL70uRitMOPt/pnPTa/kFVygsYa0jIvSAG9tlCqpWPSwjmVNxSYp0tpcOB
	 a5kbJR4AymcTNl/x84W+ouVtaF3Xw4qUAAaBnv7Ck3pfNgIz1gKBiP+ZHBwequMRrY
	 G7CaHwLKENVKceJ+GkAO4e0FwAi90fNgdBW5dCAaz+GpaM3wfguIg/n6hdMJ5BrRp2
	 D9OceGstlxS9o4h8WueMjv8vJA1IGgrs9MslYE4NXiyPR2t3GVkRiNuoOVljXWmVeb
	 4p4qEQ5l2fzCm9igqYue45sO7y+kj8GR01XW/0VgxvAxBSOZ5R7nbm5+p7dkKc99Wo
	 ak8+WA+tiYX2A==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uPfEM-00000004yvo-2h1n;
	Thu, 12 Jun 2025 12:32:22 +0200
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
Subject: [PATCH v2 12/12] docs: conf.py: don't handle yaml files outside Netlink specs
Date: Thu, 12 Jun 2025 12:32:04 +0200
Message-ID: <d4b8d090ce728fce9ff06557565409539a8b936b.1749723671.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1749723671.git.mchehab+huawei@kernel.org>
References: <cover.1749723671.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

The parser_yaml extension already has a logic to prevent
handing all yaml documents. However, if we don't also exclude
the patterns at conf.py, the build time would increase a lot,
and warnings like those would be generated:

    Documentation/netlink/genetlink.yaml: WARNING: o documento não está incluído em nenhum toctree
    Documentation/netlink/genetlink-c.yaml: WARNING: o documento não está incluído em nenhum toctree
    Documentation/netlink/genetlink-legacy.yaml: WARNING: o documento não está incluído em nenhum toctree
    Documentation/netlink/index.rst: WARNING: o documento não está incluído em nenhum toctree
    Documentation/netlink/netlink-raw.yaml: WARNING: o documento não está incluído em nenhum toctree

Add some exclusion rules to prevent that.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/conf.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/conf.py b/Documentation/conf.py
index add6ce78dd80..b8668bcaf090 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -222,7 +222,11 @@ language = 'en'
 
 # List of patterns, relative to source directory, that match files and
 # directories to ignore when looking for source files.
-exclude_patterns = ['output']
+exclude_patterns = [
+	'output',
+	'devicetree/bindings/**.yaml',
+	'netlink/*.yaml',
+]
 
 # The reST default role (used for this markup: `text`) to use for all
 # documents.
-- 
2.49.0


