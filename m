Return-Path: <netdev+bounces-153905-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6A69FA04A
	for <lists+netdev@lfdr.de>; Sat, 21 Dec 2024 12:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 259BB1887EA5
	for <lists+netdev@lfdr.de>; Sat, 21 Dec 2024 11:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D6101F4E29;
	Sat, 21 Dec 2024 11:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xo9FxMpS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FFF1F2C57;
	Sat, 21 Dec 2024 11:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734779367; cv=none; b=FvTL7nB4wQm4GO2vmYyBv86WyW72fBAZ+TXTseHRV2k+B6pHxL0US9Y/wcwWc8FRQHrjXxS7sGrRA97EdPZqcet7H9qDeSvN44tl+rSgKOeB1p+E8kXYlCbrhplJCEb96+p/yjpn57e0f4aCQvJeD/FjKJVOz+NDpttk75CE2CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734779367; c=relaxed/simple;
	bh=ASr3/4DAVtVdPC5X9jokt3ABmYTkKfh8apzzBt0xxA8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=muiN8yXp0E5mLXHJpFzejPqyiCvtFg/XT1Dc7XhfWFhVkpEE2sFuHq/7eRN2Rlgsw4iJ6xSOP1Ck4LWOWkf2JdecF8valNcL39PH5D2YHGFOnkVOhxm5/tCDNl4NEBqCfLTB1Ul2t9J3Rf2Gtb73tL1Q3fxw2oaNtLd8irajupc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xo9FxMpS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 360B8C4CED4;
	Sat, 21 Dec 2024 11:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734779366;
	bh=ASr3/4DAVtVdPC5X9jokt3ABmYTkKfh8apzzBt0xxA8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Xo9FxMpScRsWJEK5BOzi6TpHq2Zww8QXOX2uovXmVj2U58yIB/ism0EEiGv/bgNQb
	 PBYWigd0x4zjoklSTF5gUZdKPFfn1mBhSaagrtbM+1Tqt3ivGyHCuaO6hNvSLFaJEm
	 eWHR+oTL3otmh0XALzOOq4Y8YXW2N+rGNs79hQFUuQrAVzt+0q1zAnAyazbKyM3MC9
	 PlzY3IU+JJbe3/XKiq2kZplvaanpmiI+k7OGpIbJ99jLTawT+2UBWSRYoJIprJu5wU
	 w4PwfA2Lq+c6hasQBnLEeM2EXHRIN8iuQiphFY3bYJaP4qi7L45G9QUxGx5j6s5pe0
	 53/P1TRP/vYww==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 21 Dec 2024 12:09:15 +0100
Subject: [PATCH net v2 2/3] netlink: specs: mptcp: clearly mention
 attributes
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241221-net-mptcp-netlink-specs-pm-doc-fixes-v2-2-e54f2db3f844@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8506; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=ASr3/4DAVtVdPC5X9jokt3ABmYTkKfh8apzzBt0xxA8=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnZqHdQ+84wXUPc9DjfOve0AARrk3mpq2LiDCqW
 mM0IOtZhyOJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ2ah3QAKCRD2t4JPQmmg
 c3CXEADQFiY6JfRNxpDQMFcNCe002FIaOjzuKtGAJkqgUSdxdyhwfGM90/keJ+e+6jetOywgN31
 7bsNdB8lk9kl9CJXg+0ntBGL7JgrO/9obsJY0j9LT/GKdBzPy2gzr/8tux9yQEjg+xOfhLnyPgC
 mCTZHqTt7fDsH/Nklmr7+rl5qNYJrBN6E99epjcQD5v7PnKa67kxB38jXN6/IhBGcjNUALUZEqW
 uX1KxRuJyjS50hCaHyT6g8amBebYsZlazek75n20Yg+E4yR8CX2YQd3OudIiy6KEnAD1VASt92u
 YKkAumXbTI/JoSy2PUwJHYK0TbPSzYLqZioxTU3SvTdMZ/xGJxss5/ccO+G9n9CHdbWI5ZmoJVw
 d4AEuJKWmFy5EfNhNg7n+T71i0V9aY1ncCiShIAK0/JvNe08xB0xHYyGEt9PcF/szaA9M4dgxL0
 b+OQBXEcKWwJ/bcAhwq5VW4y39lZi+SiseCswEx9T2/G2JI99GeS6jK1gPOeONCV1XYFDfDLGRO
 aVxsy++0i2DY0AXrOknP4LCnpKtdEa5JYBbipQgVlJyKKQt9KnimORGqlI6P32KcFd1vMvCWhWX
 TxP9bQ6AdfXFGGITbhrj7pBbZZQ+qtOQrzJQpGOD8orx4+yeFpb43V2Gum5J2vm6zZYgRNDQQkj
 82Ti3C7XkshMG4A==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The rendered version of the MPTCP events [1] looked strange, because the
whole content of the 'doc' was displayed in the same block.

It was then not clear that the first words, not even ended by a period,
were the attributes that are defined when such events are emitted. These
attributes have now been moved to the end, prefixed by 'Attributes:' and
ended with a period. Note that '>-' has been added after 'doc:' to allow
':' in the text below.

The documentation in the UAPI header has been auto-generated by:

  ./tools/net/ynl/ynl-regen.sh

Link: https://docs.kernel.org/networking/netlink_spec/mptcp_pm.html#event-type [1]
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
  - v2: Regen YNL doc + remove Fixes tag (Jakub).
---
 Documentation/netlink/specs/mptcp_pm.yaml | 50 ++++++++++++++---------------
 include/uapi/linux/mptcp_pm.h             | 53 ++++++++++++++++---------------
 2 files changed, 52 insertions(+), 51 deletions(-)

diff --git a/Documentation/netlink/specs/mptcp_pm.yaml b/Documentation/netlink/specs/mptcp_pm.yaml
index fc0603f51665a6260fb4dc78bc641c4175a8577e..59087a23056510dfb939b702e231b6e97ae042c7 100644
--- a/Documentation/netlink/specs/mptcp_pm.yaml
+++ b/Documentation/netlink/specs/mptcp_pm.yaml
@@ -22,67 +22,67 @@ definitions:
       doc: unused event
      -
       name: created
-      doc:
-        token, family, saddr4 | saddr6, daddr4 | daddr6, sport, dport,
-        server-side
+      doc: >-
         A new MPTCP connection has been created. It is the good time to
         allocate memory and send ADD_ADDR if needed. Depending on the
         traffic-patterns it can take a long time until the
         MPTCP_EVENT_ESTABLISHED is sent.
+        Attributes: token, family, saddr4 | saddr6, daddr4 | daddr6, sport,
+        dport, server-side.
      -
       name: established
-      doc:
-        token, family, saddr4 | saddr6, daddr4 | daddr6, sport, dport,
-        server-side
+      doc: >-
         A MPTCP connection is established (can start new subflows).
+        Attributes: token, family, saddr4 | saddr6, daddr4 | daddr6, sport,
+        dport, server-side.
      -
       name: closed
-      doc:
-        token
+      doc: >-
         A MPTCP connection has stopped.
+        Attribute: token.
      -
       name: announced
       value: 6
-      doc:
-        token, rem_id, family, daddr4 | daddr6 [, dport]
+      doc: >-
         A new address has been announced by the peer.
+        Attributes: token, rem_id, family, daddr4 | daddr6 [, dport].
      -
       name: removed
-      doc:
-        token, rem_id
+      doc: >-
         An address has been lost by the peer.
+        Attributes: token, rem_id.
      -
       name: sub-established
       value: 10
-      doc:
-        token, family, loc_id, rem_id, saddr4 | saddr6, daddr4 | daddr6, sport,
-        dport, backup, if_idx [, error]
+      doc: >-
         A new subflow has been established. 'error' should not be set.
+        Attributes: token, family, loc_id, rem_id, saddr4 | saddr6, daddr4 |
+        daddr6, sport, dport, backup, if_idx [, error].
      -
       name: sub-closed
-      doc:
-        token, family, loc_id, rem_id, saddr4 | saddr6, daddr4 | daddr6, sport,
-        dport, backup, if_idx [, error]
+      doc: >-
         A subflow has been closed. An error (copy of sk_err) could be set if an
         error has been detected for this subflow.
+        Attributes: token, family, loc_id, rem_id, saddr4 | saddr6, daddr4 |
+        daddr6, sport, dport, backup, if_idx [, error].
      -
       name: sub-priority
       value: 13
-      doc:
-        token, family, loc_id, rem_id, saddr4 | saddr6, daddr4 | daddr6, sport,
-        dport, backup, if_idx [, error]
+      doc: >-
         The priority of a subflow has changed. 'error' should not be set.
+        Attributes: token, family, loc_id, rem_id, saddr4 | saddr6, daddr4 |
+        daddr6, sport, dport, backup, if_idx [, error].
      -
       name: listener-created
       value: 15
-      doc:
-        family, sport, saddr4 | saddr6
+      doc: >-
         A new PM listener is created.
+        Attributes: family, sport, saddr4 | saddr6.
      -
       name: listener-closed
-      doc:
-        family, sport, saddr4 | saddr6
+      doc: >-
         A PM listener is closed.
+        Attributes: family, sport, saddr4 | saddr6.
 
 attribute-sets:
   -
diff --git a/include/uapi/linux/mptcp_pm.h b/include/uapi/linux/mptcp_pm.h
index b34fd95b6f841529a8c4e8feca20450cb92f8bfc..84fa8a21dfd022a266507371d67f0f00599d8429 100644
--- a/include/uapi/linux/mptcp_pm.h
+++ b/include/uapi/linux/mptcp_pm.h
@@ -12,32 +12,33 @@
 /**
  * enum mptcp_event_type
  * @MPTCP_EVENT_UNSPEC: unused event
- * @MPTCP_EVENT_CREATED: token, family, saddr4 | saddr6, daddr4 | daddr6,
- *   sport, dport, server-side A new MPTCP connection has been created. It is
- *   the good time to allocate memory and send ADD_ADDR if needed. Depending on
- *   the traffic-patterns it can take a long time until the
- *   MPTCP_EVENT_ESTABLISHED is sent.
- * @MPTCP_EVENT_ESTABLISHED: token, family, saddr4 | saddr6, daddr4 | daddr6,
- *   sport, dport, server-side A MPTCP connection is established (can start new
- *   subflows).
- * @MPTCP_EVENT_CLOSED: token A MPTCP connection has stopped.
- * @MPTCP_EVENT_ANNOUNCED: token, rem_id, family, daddr4 | daddr6 [, dport] A
- *   new address has been announced by the peer.
- * @MPTCP_EVENT_REMOVED: token, rem_id An address has been lost by the peer.
- * @MPTCP_EVENT_SUB_ESTABLISHED: token, family, loc_id, rem_id, saddr4 |
- *   saddr6, daddr4 | daddr6, sport, dport, backup, if_idx [, error] A new
- *   subflow has been established. 'error' should not be set.
- * @MPTCP_EVENT_SUB_CLOSED: token, family, loc_id, rem_id, saddr4 | saddr6,
- *   daddr4 | daddr6, sport, dport, backup, if_idx [, error] A subflow has been
- *   closed. An error (copy of sk_err) could be set if an error has been
- *   detected for this subflow.
- * @MPTCP_EVENT_SUB_PRIORITY: token, family, loc_id, rem_id, saddr4 | saddr6,
- *   daddr4 | daddr6, sport, dport, backup, if_idx [, error] The priority of a
- *   subflow has changed. 'error' should not be set.
- * @MPTCP_EVENT_LISTENER_CREATED: family, sport, saddr4 | saddr6 A new PM
- *   listener is created.
- * @MPTCP_EVENT_LISTENER_CLOSED: family, sport, saddr4 | saddr6 A PM listener
- *   is closed.
+ * @MPTCP_EVENT_CREATED: A new MPTCP connection has been created. It is the
+ *   good time to allocate memory and send ADD_ADDR if needed. Depending on the
+ *   traffic-patterns it can take a long time until the MPTCP_EVENT_ESTABLISHED
+ *   is sent. Attributes: token, family, saddr4 | saddr6, daddr4 | daddr6,
+ *   sport, dport, server-side.
+ * @MPTCP_EVENT_ESTABLISHED: A MPTCP connection is established (can start new
+ *   subflows). Attributes: token, family, saddr4 | saddr6, daddr4 | daddr6,
+ *   sport, dport, server-side.
+ * @MPTCP_EVENT_CLOSED: A MPTCP connection has stopped. Attribute: token.
+ * @MPTCP_EVENT_ANNOUNCED: A new address has been announced by the peer.
+ *   Attributes: token, rem_id, family, daddr4 | daddr6 [, dport].
+ * @MPTCP_EVENT_REMOVED: An address has been lost by the peer. Attributes:
+ *   token, rem_id.
+ * @MPTCP_EVENT_SUB_ESTABLISHED: A new subflow has been established. 'error'
+ *   should not be set. Attributes: token, family, loc_id, rem_id, saddr4 |
+ *   saddr6, daddr4 | daddr6, sport, dport, backup, if_idx [, error].
+ * @MPTCP_EVENT_SUB_CLOSED: A subflow has been closed. An error (copy of
+ *   sk_err) could be set if an error has been detected for this subflow.
+ *   Attributes: token, family, loc_id, rem_id, saddr4 | saddr6, daddr4 |
+ *   daddr6, sport, dport, backup, if_idx [, error].
+ * @MPTCP_EVENT_SUB_PRIORITY: The priority of a subflow has changed. 'error'
+ *   should not be set. Attributes: token, family, loc_id, rem_id, saddr4 |
+ *   saddr6, daddr4 | daddr6, sport, dport, backup, if_idx [, error].
+ * @MPTCP_EVENT_LISTENER_CREATED: A new PM listener is created. Attributes:
+ *   family, sport, saddr4 | saddr6.
+ * @MPTCP_EVENT_LISTENER_CLOSED: A PM listener is closed. Attributes: family,
+ *   sport, saddr4 | saddr6.
  */
 enum mptcp_event_type {
 	MPTCP_EVENT_UNSPEC,

-- 
2.47.1


