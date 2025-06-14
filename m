Return-Path: <netdev+bounces-197741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D03AD9B97
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 10:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE7573B1674
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 08:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407952C08A4;
	Sat, 14 Jun 2025 08:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kVadhsiF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F01A2980AC;
	Sat, 14 Jun 2025 08:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749891378; cv=none; b=ii2h5k8cgfi5iFmcp/2n3njJsaZw1+H1bcd4c+vPl0rO+3Ua/76aCpnLZkguah8HunA/T+apwIhIHt9+TDsC3EQG9MOltfl8+wXNSg8EeOBsFrTI/HC1aP1zcYsGk/JoaE64I4OYAvr08SsQNFR0sVSwFAFunIc/2R8JZH12WYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749891378; c=relaxed/simple;
	bh=+6rtudJ73X+4ufoIvZc3v82fZGF4QvbxcviFruS5je8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BO218lETKnonlHkapNyY+a6MxDysHSM31I+Qwx0tBQTvCEwSpr9v1bsGehqlmr2TwiP22r/O/yVvfS9RHsHLGsoWfq+4yok0CemfBBoJ8pqt7SEsgJ5Wo2Q0sLf7/J3RrL+zOB0XEl4lmKJXdzKgtAKNEg+1Qsekgvqt42jSXpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kVadhsiF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41AA2C4CEFC;
	Sat, 14 Jun 2025 08:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749891378;
	bh=+6rtudJ73X+4ufoIvZc3v82fZGF4QvbxcviFruS5je8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kVadhsiFfw1MukiWOx/QmX9YxGaDXTanMWwIAtUR7A1moktENrB55UduqSiOGrpt3
	 bkmb2l1YKkJpqKC4KTUrFqr/cLfMhgKBiUYXgGteilOC/LAr3BA9+2pxP36LZfpRv3
	 pwfHUWbBHo19ig60DM05UFsVok0cE1SshPyi57ORIMkoCmr/2HVBj28ScfEK8VT/F4
	 rEfRXarDKsxqZ+7f8VOKybJB092lMV5NLccTW0ghJJLUzx+Yn1njsxQfKWfTkc0vat
	 ER7BqIoootq6YyA+PYCNijJAGynwgFRHKaophMGth764KftTL+zbZFK8xn4BOj5N1g
	 uyEbeFjDnKpOA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uQMgS-000000064bG-1zCZ;
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
Subject: [PATCH v4 10/14] docs: conf.py: don't handle yaml files outside Netlink specs
Date: Sat, 14 Jun 2025 10:56:04 +0200
Message-ID: <de859cadec9d31d33ba484ebb738dc73ebaa720e.1749891128.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1749891128.git.mchehab+huawei@kernel.org>
References: <cover.1749891128.git.mchehab+huawei@kernel.org>
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
 Documentation/conf.py | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/Documentation/conf.py b/Documentation/conf.py
index add6ce78dd80..62a51ac64b95 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -221,8 +221,16 @@ language = 'en'
 #today_fmt = '%B %d, %Y'
 
 # List of patterns, relative to source directory, that match files and
-# directories to ignore when looking for source files.
-exclude_patterns = ['output']
+# directories.
+include_patterns = [
+	'**.rst',
+	'netlink/specs/*.yaml',
+]
+
+# patterns to ignore when looking for source files.
+exclude_patterns = [
+	'output',
+]
 
 # The reST default role (used for this markup: `text`) to use for all
 # documents.
-- 
2.49.0


