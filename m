Return-Path: <netdev+bounces-153906-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF0F9FA04C
	for <lists+netdev@lfdr.de>; Sat, 21 Dec 2024 12:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8142B188AA35
	for <lists+netdev@lfdr.de>; Sat, 21 Dec 2024 11:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C961F7569;
	Sat, 21 Dec 2024 11:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jBF0Mt6R"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E211F6692;
	Sat, 21 Dec 2024 11:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734779370; cv=none; b=eX+xKWWPL96+BFkUz88Zr6lKpfl1sOIkOQ+ESjgdOhh9BDK9HGTxlt7Mi88JUbaQ3mnqXWclsdU67XwsiuZvyV1Zlo0dCb49Iq4ixGm+v4nfwkM55JAmVg6Fch6ugXDHVAAPWXBezOxotImdA8ZyXzH+q7p1vB1FyO44GYZ330I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734779370; c=relaxed/simple;
	bh=QRpkcpc59deBZi3zJVNk1kxfy0JxjlG1o513S2C1O8E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hgEzlGmnosyB5+Z46AzoMUOHVh6VIc6AEU9ig4FAvXYn/VZ03LQk9nabqevEgpxV31q0maXqwGZB0j9GbZX6n29P/xfgIhwtXYByX5J22htNDw5L7z3xugGvzZMZYp4Ltvo+MYsPadX/aZgu2KFwb41k7VyWL5wpAX2lqM4vpSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jBF0Mt6R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46CF4C4CED7;
	Sat, 21 Dec 2024 11:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734779369;
	bh=QRpkcpc59deBZi3zJVNk1kxfy0JxjlG1o513S2C1O8E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jBF0Mt6RHpOtbsuNIslqB7Re4DAOkEePF4SAbczB3O8J+Se9Q3X5y4lFR2XoBi/qR
	 HgPNRxlZZ8hlvSODJj0wXU81RfiQbwN+1bb1EDbsffTnnzV7+FFg76EhBldIivdNOy
	 bptLn0jN6qfu5ndqh5t3P1U9N4tq14a/4GfWtJ45MJtE6ghXBkHTaHFYXZkl7HHwZP
	 5mTGqUOrAPsS+/h/IS+gVAeZgG32V5SsDXYf3dznGd4pg6iKYoTpyUBSJkJb/xtGQF
	 hhVOUxwPwhKGp13DY+W9saQppqIuI6uoYUOrN/sQRVDmIEEGGUUPASOXBpdajJPLa/
	 /78KpLySrxqbA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 21 Dec 2024 12:09:16 +0100
Subject: [PATCH net v2 3/3] netlink: specs: mptcp: fix missing doc
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241221-net-mptcp-netlink-specs-pm-doc-fixes-v2-3-e54f2db3f844@kernel.org>
References: <20241221-net-mptcp-netlink-specs-pm-doc-fixes-v2-0-e54f2db3f844@kernel.org>
In-Reply-To: <20241221-net-mptcp-netlink-specs-pm-doc-fixes-v2-0-e54f2db3f844@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Davide Caratti <dcaratti@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2249; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=QRpkcpc59deBZi3zJVNk1kxfy0JxjlG1o513S2C1O8E=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnZqHde4aO63EFlbqwVijkoere635EuchTCPAXd
 O74THRvly+JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ2ah3QAKCRD2t4JPQmmg
 c7KKEACFnQCfH3qc6jrWpaeOZarnpXR+MIfJiMsm9h/7A1T6asAioINoC9XYwm1O+jVO7x2F1ps
 7HWJyzJ7W0H4kDAqJ89SyTml9U5n9QrzVluiccNWwJgZcJqIwH8Ws2cnbhK20PZvTBwSFOmeRF/
 J1M1HgxGbx1MVTSPYwO7SeGIOAjaDt0iJqd6vAQ+vkvDeFDtw1LPfsbub4nPDn4iJbC/TzkcV/J
 7vF3UWMfW639yPBMZQ7vZgMFS56q5E6J+LMNs/oAdlxfZpwa7jkXLlhhYpwcRrTvi6vTk0+DwXx
 sEsP831orvzPTW7zcoJ35MZipznKh2p1WvlKc3K4bk7xeLjsbKBvuCt4Wz7BzoBz6S2iqolPVZi
 t3NWbZJxEi1QP9tCv15kHMtQz0mpJ8yoG+yFXszXzbCMvPsoxzohmWfX5HJ31/yyIuu7nFKahiq
 YrpIbtYFx8ezu1DqjXMPDhzHkxtuMbGCtj2wiuY6kkaWwrSUn6gUEXxbaCFi3F6fFLgS1eIpcbR
 WNGZ/AgzHoSk2DokY2EKhLBVE0gksyfYthC6FsBjTcOtZ+Ae8wcDo5tYfcSOSL9Eh86caT7irOh
 /cOrszLfVo4zaKR5yWlAU4s7DVo53vEtuq0KYawoAXVN5y+agLOu1CrihGyGp76wq8BBCYlve1/
 PI6gbKvMfGZXGyA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Two operations didn't have a small description. It looks like something
that has been missed in the original commit introducing this file.

Replace the two "todo" by a small and simple description: Create/Destroy
subflow.

While at it, also uniform the capital letters, avoid double spaces, and
fix the "announce" event description: a new "address" has been
announced, not a new "subflow".

Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
  - v2: Removed Fixes tag (Jakub).
---
 Documentation/netlink/specs/mptcp_pm.yaml | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/netlink/specs/mptcp_pm.yaml b/Documentation/netlink/specs/mptcp_pm.yaml
index 59087a23056510dfb939b702e231b6e97ae042c7..dfd017780d2f942eefd6e5ab0f1edd3fba653172 100644
--- a/Documentation/netlink/specs/mptcp_pm.yaml
+++ b/Documentation/netlink/specs/mptcp_pm.yaml
@@ -308,8 +308,8 @@ operations:
          attributes:
            - addr
     -
-      name:  flush-addrs
-      doc: flush addresses
+      name: flush-addrs
+      doc: Flush addresses
       attribute-set: endpoint
       dont-validate: [ strict ]
       flags: [ uns-admin-perm ]
@@ -353,7 +353,7 @@ operations:
             - addr-remote
     -
       name: announce
-      doc: announce new sf
+      doc: Announce new address
       attribute-set: attr
       dont-validate: [ strict ]
       flags: [ uns-admin-perm ]
@@ -364,7 +364,7 @@ operations:
             - token
     -
       name: remove
-      doc: announce removal
+      doc: Announce removal
       attribute-set: attr
       dont-validate: [ strict ]
       flags: [ uns-admin-perm ]
@@ -375,7 +375,7 @@ operations:
            - loc-id
     -
       name: subflow-create
-      doc: todo
+      doc: Create subflow
       attribute-set: attr
       dont-validate: [ strict ]
       flags: [ uns-admin-perm ]
@@ -387,7 +387,7 @@ operations:
             - addr-remote
     -
       name: subflow-destroy
-      doc: todo
+      doc: Destroy subflow
       attribute-set: attr
       dont-validate: [ strict ]
       flags: [ uns-admin-perm ]

-- 
2.47.1


