Return-Path: <netdev+bounces-199336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F02DADFE11
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 08:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A4DB3B41FF
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 06:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0308625F963;
	Thu, 19 Jun 2025 06:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HKoyUQo4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58091248F57;
	Thu, 19 Jun 2025 06:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750315821; cv=none; b=Fv0c5hM3taG3fxysfKZ7iewVO6lVfPwei2mMZ2yJ6GuRm4ziV+ebtIwFzAPRdXcr9v6kYt+aR8kv36U2Op4XYdvGia5CrwULHCMnv/QkEkAuIXkCalGO7qWEXJOY5ZKcwhOELHilNzdpwm/F/S6o/39CNE1O4tDzh5VdnURmckk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750315821; c=relaxed/simple;
	bh=NWHr6s5MAHhaxWhvDkXosw3Qmf8A786TTZ4Xlu7HoGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MCyzEq9+yn2ov44giYcgDrr9koPmo1XwgWpmydnQ3DabNFvd/VTbaLYBhoLXO/VKNgsr0BxL5SLIApToIXAfUEOz9vJ8vxOZ/awZWbLR/KsGLRjJbgrAxmRIO/Daiue1ztWA+Svva9e7mzZ+QQZLDo9WfOi/RVsK9dI/1gooetw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HKoyUQo4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3394C113D0;
	Thu, 19 Jun 2025 06:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750315821;
	bh=NWHr6s5MAHhaxWhvDkXosw3Qmf8A786TTZ4Xlu7HoGk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HKoyUQo4Ffzqqd/6TNqqWE8CyBYPSsYR9yebXX8DrslA4TVnNXcl/YeuCiHHJP2gE
	 j5fzsu3JfTQ80Kxkyr7xF4FP7qSt8vDunBtc3/SxxYKGGAItx8EkXNvxNexs2ppebd
	 oM3x5p4AqwmYL/sGVIhzrz9hIyeuHmoFzfs0jSOrh54KkUty77ujQqS7KIkp0gUnEW
	 ZCQ+IAQkgg8BpStVcnEux/bAePfM4bFYhPSFovtbTmFSYfHCck3UzZkH4uPqlf0tpA
	 NYC5vFpZnrFnTxkT+cQiUtxBVMbnI/IKBizhvUq323nGWEAbDtKS1VF7JkoRtCwSnf
	 VaH47rOZj+0Mg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uS96J-00000003dHI-0e7s;
	Thu, 19 Jun 2025 08:50:19 +0200
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
Subject: [PATCH v7 12/17] MAINTAINERS: add netlink_yml_parser.py to linux-doc
Date: Thu, 19 Jun 2025 08:49:05 +0200
Message-ID: <4077605f84d7ba6423dcb5fda4e96ac950856f1d.1750315578.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750315578.git.mchehab+huawei@kernel.org>
References: <cover.1750315578.git.mchehab+huawei@kernel.org>
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
index a92290fffa16..caa3425e5755 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7202,6 +7202,7 @@ F:	scripts/get_abi.py
 F:	scripts/kernel-doc*
 F:	scripts/lib/abi/*
 F:	scripts/lib/kdoc/*
+F:	tools/net/ynl/pyynl/netlink_yml_parser.py
 F:	scripts/sphinx-pre-install
 X:	Documentation/ABI/
 X:	Documentation/admin-guide/media/
-- 
2.49.0


