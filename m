Return-Path: <netdev+bounces-221663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA7EB5176F
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 14:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01C9B544558
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 12:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54DCE31C591;
	Wed, 10 Sep 2025 12:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SJvNoHxO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CA2268C40;
	Wed, 10 Sep 2025 12:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757509060; cv=none; b=QQ3jdqBYs1Z1CRjh6RPBzFzjFCaje4Jbv6E/BbQ3S6n5G42XoAcEZKL8lF2MWaUB3VdnaxsEfFKqiIcCqzrSonQKcnVM+TKTJEgwj0YnMtujDqnQ76JHMpV3SWsuFnq6xhncxj2+ICIAS7/Tt10GqfTgov/k9cLHmn//bmbvHQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757509060; c=relaxed/simple;
	bh=1IJBsOCxQ1L3077p7oe87GW8Hq3crtK2WhBTwePnDD8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=oqHVoMDHr+OC//iD/LTer48D00jpiZZrqboh7T86GgXfOcFxfzwvHX+IVSXHq8TONpRzlU46FHiXKATzEY5qon7snRSlvgGJCTz9maMUdKBUXQBYWj2DOIxSjkyVXtcVE2xcHcoysnLW3dXNo/MFMpt5OU+z75v/15HQ0Y1PGBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SJvNoHxO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92992C4CEF0;
	Wed, 10 Sep 2025 12:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757509059;
	bh=1IJBsOCxQ1L3077p7oe87GW8Hq3crtK2WhBTwePnDD8=;
	h=From:Date:Subject:To:Cc:From;
	b=SJvNoHxOhjX5B6rLHD9g8vtU0mMxXxuywr4RlJtexJ+W4ho08JwKv7sZV7Bv7Z/nM
	 OtVbEYaOe5W8zF9BvPJxo5fQ23rD5CPy84EivNqRDwd2wWHtL2L6lq3oiemKKH3VLw
	 CQAhqzVqVcQdvfVDrstjgcWEcFUOSoPx/iFqkG++UuWP8OowVRotNlPOecmsWyYqgs
	 Twp8jSqa6FAQ7Bnl1G3AA5bkaPoSNpzVLRillqQ+qFIbbnlwsI7G/IUgMuu5oZtG6l
	 nN2nm3tC1rwttCdz+cYC8LrfSsx2MLXTiAmoH493Ux/UOdlk3f2iz4dPegZaUMTip6
	 Lx4Ca38rjDDkQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 10 Sep 2025 14:55:40 +0200
Subject: [PATCH net-next] tools: ynl: rst: display attribute-set doc
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-net-next-ynl-attr-doc-rst-v1-1-0bbc77816174@kernel.org>
X-B4-Tracking: v=1; b=H4sIAEt1wWgC/zWMywqDMBAAf0X27EISTaD9FfHgY9sulCibRRTJv
 xsED3OYw8wJiYQpwbs6QWjjxEssYusKpt8Qv4Q8FwdnnDcvazCSFnbFI/5xUBWclwklKY7B+sa
 FpnWth9KvQh/e73cHTwZ9zhcuA1+3dQAAAA==
X-Change-ID: 20250910-net-next-ynl-attr-doc-rst-b61532634245
To: Jonathan Corbet <corbet@lwn.net>, 
 Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: linux-doc@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1737; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=1IJBsOCxQ1L3077p7oe87GW8Hq3crtK2WhBTwePnDD8=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDIOlh6sXGgqHbTr4MGDRZ/fxHb7BnpUNEyal3G16GySm
 P5c00mrOkpZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACYiNpnhn/JD/tQNIquvzTfg
 t5wiV5FfXbm07FPqo/AE9d4jv63SlBn+SqrGMX0OELrsqzorpn/f3RsdbHPjiqeW8cfblVttWXK
 cHwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Some attribute-set have a documentation (doc:), but it was not displayed
in the RST / HTML version. Such field can be found in ethtool, netdev,
tcp_metrics and team YAML files.

Only the 'name' and 'attributes' fields from an 'attribute-set' section
were parsed. Now the content of the 'doc' field, if available, is added
as a new paragraph before listing each attribute. This is similar to
what is done when parsing the 'operations'.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Note: this patch can be applied without conflicts on top of net-next and
docs-next. To be honest, it is not clear to me who is responsible for
applying it :)
---
 tools/net/ynl/pyynl/lib/doc_generator.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/net/ynl/pyynl/lib/doc_generator.py b/tools/net/ynl/pyynl/lib/doc_generator.py
index 403abf1a2edaac6936d0e9db0623cd3e07aaad8e..3a16b8eb01ca0cf61a5983d3bd6a866e04c75844 100644
--- a/tools/net/ynl/pyynl/lib/doc_generator.py
+++ b/tools/net/ynl/pyynl/lib/doc_generator.py
@@ -289,6 +289,10 @@ class YnlDocGenerator:
         for entry in entries:
             lines.append(self.fmt.rst_section(namespace, 'attribute-set',
                                               entry["name"]))
+
+            if "doc" in entry:
+                lines.append(self.fmt.rst_paragraph(entry["doc"], 0) + "\n")
+
             for attr in entry["attributes"]:
                 if LINE_STR in attr:
                     lines.append(self.fmt.rst_lineno(attr[LINE_STR]))

---
base-commit: deb105f49879dd50d595f7f55207d6e74dec34e6
change-id: 20250910-net-next-ynl-attr-doc-rst-b61532634245

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


