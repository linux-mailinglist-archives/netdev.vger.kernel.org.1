Return-Path: <netdev+bounces-221426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 122BDB507B8
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 23:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3698F462C2E
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 21:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A60025FA29;
	Tue,  9 Sep 2025 21:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sYmtqgfi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EEE25FA0A;
	Tue,  9 Sep 2025 21:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757452098; cv=none; b=k9PtPpUsWnaZbNpmBm8odgaYdBSJV3Nf60jJ/iKP1RCAuCAm4nQB4qWWKptuGBHJ6muC9/GFrqvze+4YaL4U8tgB5Yr6+30DxmhfTlaWSZWDX6zTVUCZ74z0sGjhG71GqEf3MBpuQVKJ28JWA8HV5Ovj7rEGKToIMydyB0KwPEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757452098; c=relaxed/simple;
	bh=WCrbslA/wVt6AWsk9YPK/LBzEczDDuHyG75hWqD+ULk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RWlMIZ8eipqTaOfw8s9g0tGdw/emHKu2lfuUd7kVtTowfmiVQzJDg7BDAcHNCJN80XzbNfu/1GL+6bUXmq81FPyOMZiQ1ewGZ+A1QF9Jm8jN6RWKiqWpFUg/JGzqHOiXoJjDEHj4ZrfiV8BQtpetRzcjjgj+TzF4RUqZ1uStseQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sYmtqgfi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17A72C4CEF7;
	Tue,  9 Sep 2025 21:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757452097;
	bh=WCrbslA/wVt6AWsk9YPK/LBzEczDDuHyG75hWqD+ULk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sYmtqgfiDSOJo2Yh4DHQghjDWMuUvhhyCoOLxGuO3JRXd3vw2YuW962j28Uzduhec
	 kIpLp5gznRcw/MyIaFCQ9bhTaQkjzhmNV5xfZ7xISN8pg458hKN2P+RjT7I7QVXqZi
	 RNv11QJA1cz6B5IB2PQ532IPbvej2cSdkK/+e/twPB8mrlzpdLmazVphNtJUYhi4P2
	 qrKXPtPe53ssQ+tjOr5RGqnDGnQIy9IKYYaSXhDzlC2ot0IiJalJkxzghCZNAdZmTi
	 9RA7KpWlEQhNJL4Zkg8NBclBj6jMPSn5Ne1WHE71/TECveOiLIW/uIMGkpzYwQ33uv
	 +oSUXevlAL+nw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 09 Sep 2025 23:07:51 +0200
Subject: [PATCH net-next 5/8] tools: ynl: remove unused imports
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-net-next-ynl-ruff-v1-5-238c2bccdd99@kernel.org>
References: <20250909-net-next-ynl-ruff-v1-0-238c2bccdd99@kernel.org>
In-Reply-To: <20250909-net-next-ynl-ruff-v1-0-238c2bccdd99@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2923; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=WCrbslA/wVt6AWsk9YPK/LBzEczDDuHyG75hWqD+ULk=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDIOTDfacdK2WVZqec2utw++W1rWtZmcfNZVFF4mv3HD3
 jxvqfMHOkpZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACZy7jDD/6Ilcq0yyfmmTg/n
 WM83OSui+mPyoYOro4841Fqd9tl5wZ6R4eUlcwnDmU8e182ZYfBx47/9z3bO+juz4GZ012YZmXO
 S93gA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

These imports are not used according to Ruff, and can be safely removed.

This is linked to Ruff error F401 [1]:

  Unused imports add a performance overhead at runtime, and risk
  creating import cycles. They also increase the cognitive load of
  reading the code.

There is one exception with 'YnlDocGenerator' which is added in __all__:
it is used by ynl_gen_rst.py.

Link: https://docs.astral.sh/ruff/rules/unused-import/ [1]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/net/ynl/pyynl/ethtool.py      | 1 -
 tools/net/ynl/pyynl/lib/__init__.py | 2 +-
 tools/net/ynl/pyynl/lib/ynl.py      | 1 -
 tools/net/ynl/pyynl/ynl_gen_c.py    | 3 +--
 4 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/tools/net/ynl/pyynl/ethtool.py b/tools/net/ynl/pyynl/ethtool.py
index c1cd088c050cd52ee379ed4682fff856b9b3b3be..9b523cbb3568cc2a62109ff7f8373e95fd16db42 100755
--- a/tools/net/ynl/pyynl/ethtool.py
+++ b/tools/net/ynl/pyynl/ethtool.py
@@ -2,7 +2,6 @@
 # SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 
 import argparse
-import json
 import pathlib
 import pprint
 import sys
diff --git a/tools/net/ynl/pyynl/lib/__init__.py b/tools/net/ynl/pyynl/lib/__init__.py
index 5f266ebe45266e4d8b577f6d0dcc91db6e710179..ec9ea00071be90ce025dbee91c1c778a9170359f 100644
--- a/tools/net/ynl/pyynl/lib/__init__.py
+++ b/tools/net/ynl/pyynl/lib/__init__.py
@@ -8,4 +8,4 @@ from .doc_generator import YnlDocGenerator
 
 __all__ = ["SpecAttr", "SpecAttrSet", "SpecEnumEntry", "SpecEnumSet",
            "SpecFamily", "SpecOperation", "SpecSubMessage", "SpecSubMessageFormat",
-           "YnlFamily", "Netlink", "NlError"]
+           "YnlFamily", "Netlink", "NlError", "YnlDocGenerator"]
diff --git a/tools/net/ynl/pyynl/lib/ynl.py b/tools/net/ynl/pyynl/lib/ynl.py
index 15ddb0b1adb63f5853bf58579687d160a9c46860..da307fd1e9b0f5c54f39412d6b572557e83dbf86 100644
--- a/tools/net/ynl/pyynl/lib/ynl.py
+++ b/tools/net/ynl/pyynl/lib/ynl.py
@@ -9,7 +9,6 @@ import socket
 import struct
 from struct import Struct
 import sys
-import yaml
 import ipaddress
 import uuid
 import queue
diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index 8e95c5bb139921f38f374d2c652844c7f4e96a9b..5113cf1787f608125e23fa9033d9db81caf51f49 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -2,7 +2,6 @@
 # SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
 
 import argparse
-import collections
 import filecmp
 import pathlib
 import os
@@ -14,7 +13,7 @@ import yaml
 
 sys.path.append(pathlib.Path(__file__).resolve().parent.as_posix())
 from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, SpecEnumEntry
-from lib import SpecSubMessage, SpecSubMessageFormat
+from lib import SpecSubMessage
 
 
 def c_upper(name):

-- 
2.51.0


