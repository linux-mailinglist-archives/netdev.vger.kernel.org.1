Return-Path: <netdev+bounces-153904-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0DB59FA048
	for <lists+netdev@lfdr.de>; Sat, 21 Dec 2024 12:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95EC318873AF
	for <lists+netdev@lfdr.de>; Sat, 21 Dec 2024 11:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523771F37B2;
	Sat, 21 Dec 2024 11:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wu12UgOI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260613F9D2;
	Sat, 21 Dec 2024 11:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734779364; cv=none; b=hwaPD99vf3i5R1O2w+MoyHo8eh1xkqK9uZBC/x+4A33cz9oB7nIJ1jYLf7quhiQpzP++UKmWfmqdnb8ELvTEw0EsoFnjJ+jc+xJW6ugq4W7tqY9oIRX40SBvrD3PoOpornwUVjyeRhAJhsLrrnbf+M+/EwKXOPt7JwlNeT1yzxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734779364; c=relaxed/simple;
	bh=u3fwubOZfC6AniriBqkgTG5ia0NGJOwaok4Fu2Da9Kk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tBG6p7KFAJ72ybNyUlDxUj1bKfGAT3YNUxm12Z4FMyVoQJF88XAe0QR1wWrvs61bZfEA6hwzL72xtCnS4MOaj+LzRLk1a6BK2LQ+okI9k7r3bOZrcLbLf2lYxpQfKx2kEIR6WsOfKJBbn5tLVWX+KkHgEapDLaAohc66TvRUXfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wu12UgOI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27A70C4CECE;
	Sat, 21 Dec 2024 11:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734779363;
	bh=u3fwubOZfC6AniriBqkgTG5ia0NGJOwaok4Fu2Da9Kk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Wu12UgOI/BMuJWR+6lbah2ouD2DajxpP9LrLpV3xoPA9pym7fRLa7OD5LVVzoOg62
	 LsrZyi246MZHE1HQ01a0PjYML3X02tWdVlzPy5vyVKZ2E0la4x/4/oGuCrg9GmMjoD
	 Wk7s/zfk/osQA1tJUGTdm4OoupCmZ+kwUJUtaM7ghOCwL75XV3ZmIFmmoYKgwzsBPs
	 XAfB4ocimTi61582kf5WbFcd/hHrDe32DWioaNhyKLi+RVQPoCkOxL0XjbyPnvR11O
	 cvkj0e4KmKI1nfHgay4F5i0mAzqd50mMt8fRPkm55vThSi9So/MHggLBHz5ZvxFUT4
	 0Ru37sNShjXEA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 21 Dec 2024 12:09:14 +0100
Subject: [PATCH net v2 1/3] netlink: specs: mptcp: add missing
 'server-side' attr
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241221-net-mptcp-netlink-specs-pm-doc-fixes-v2-1-e54f2db3f844@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3051; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=u3fwubOZfC6AniriBqkgTG5ia0NGJOwaok4Fu2Da9Kk=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnZqHdqREl4qhDmc6aYeWMI7KCjCt2d2FyEvg5P
 S+vvFno06WJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ2ah3QAKCRD2t4JPQmmg
 c/7DEAC1FCDxSwrO3oGm5aqP8MQbACSjK7y92E0pYkHtfVIgVrA4sd5OPTNlO0sVc40TiXDKdGD
 lgLaY4plVBM1lRpjjnAFr8dKCJqLEyfvgm2uckhAG84rDwsy12OgMQHkbIzT0aW5GRVeMgB7F1g
 qz1MKznDhl6/SvzxPqJsgt0c/wp4P/PeMiOv4RrYSFnVwb+DLuBS1APb8pMPHKLXxnqnajbLRv8
 dix3xJh4YbDFiPL8SRa2f+Jz5wfYqIPjh0/Qf/Tv4LJgAP/2lm9WptRJmmYpm4W79lBp7bLGBxE
 cbLj1V+E7uhJvf1Peo8f3fdsg5DKeSvc8UoEQ5h67kTyLriuV0a/O0mAKHq9OBd/BwwGm7P4ugg
 O3p05xhDsB6cJvEi4PJ2u2lOVniGfw1Jm74orvNrnTsKV7x8KvU0baGGZSp9wuXbt5SCD77npoz
 TLhD8eU6uUZ8coCQidXkPyUUhMh4sByJU47ztTvQFhUPjPsvgMCKHutsxoNMUYxaLhUKeWRhroM
 kBmvyNhk6Jq8L/is+ilMlWrHTcT4dnJq0fFnaQ4KG9H8eFIbU0b50wYiEHW++9T9UQo9t3h2QKx
 8gUq+/kcOCkBoXv+kprV98yXjqtvlOWJ3SD+1Ob+6KtcuAPfv/SpD4eXl69spXDQkr6TbxNLirO
 2xJW8tbOnEUf1XA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This attribute is added with the 'created' and 'established' events, but
the documentation didn't mention it.

The documentation in the UAPI header has been auto-generated by:

  ./tools/net/ynl/ynl-regen.sh

Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
  - v2: Regen YNL doc + remove Fixes tag (Jakub).
---
 Documentation/netlink/specs/mptcp_pm.yaml |  6 ++++--
 include/uapi/linux/mptcp_pm.h             | 11 ++++++-----
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/Documentation/netlink/specs/mptcp_pm.yaml b/Documentation/netlink/specs/mptcp_pm.yaml
index dc190bf838fec6add28b61e5e2cac8dee601b012..fc0603f51665a6260fb4dc78bc641c4175a8577e 100644
--- a/Documentation/netlink/specs/mptcp_pm.yaml
+++ b/Documentation/netlink/specs/mptcp_pm.yaml
@@ -23,7 +23,8 @@ definitions:
      -
       name: created
       doc:
-        token, family, saddr4 | saddr6, daddr4 | daddr6, sport, dport
+        token, family, saddr4 | saddr6, daddr4 | daddr6, sport, dport,
+        server-side
         A new MPTCP connection has been created. It is the good time to
         allocate memory and send ADD_ADDR if needed. Depending on the
         traffic-patterns it can take a long time until the
@@ -31,7 +32,8 @@ definitions:
      -
       name: established
       doc:
-        token, family, saddr4 | saddr6, daddr4 | daddr6, sport, dport
+        token, family, saddr4 | saddr6, daddr4 | daddr6, sport, dport,
+        server-side
         A MPTCP connection is established (can start new subflows).
      -
       name: closed
diff --git a/include/uapi/linux/mptcp_pm.h b/include/uapi/linux/mptcp_pm.h
index 50589e5dd6a38a3b4158e2e4092a9b3442b8fe96..b34fd95b6f841529a8c4e8feca20450cb92f8bfc 100644
--- a/include/uapi/linux/mptcp_pm.h
+++ b/include/uapi/linux/mptcp_pm.h
@@ -13,12 +13,13 @@
  * enum mptcp_event_type
  * @MPTCP_EVENT_UNSPEC: unused event
  * @MPTCP_EVENT_CREATED: token, family, saddr4 | saddr6, daddr4 | daddr6,
- *   sport, dport A new MPTCP connection has been created. It is the good time
- *   to allocate memory and send ADD_ADDR if needed. Depending on the
- *   traffic-patterns it can take a long time until the MPTCP_EVENT_ESTABLISHED
- *   is sent.
+ *   sport, dport, server-side A new MPTCP connection has been created. It is
+ *   the good time to allocate memory and send ADD_ADDR if needed. Depending on
+ *   the traffic-patterns it can take a long time until the
+ *   MPTCP_EVENT_ESTABLISHED is sent.
  * @MPTCP_EVENT_ESTABLISHED: token, family, saddr4 | saddr6, daddr4 | daddr6,
- *   sport, dport A MPTCP connection is established (can start new subflows).
+ *   sport, dport, server-side A MPTCP connection is established (can start new
+ *   subflows).
  * @MPTCP_EVENT_CLOSED: token A MPTCP connection has stopped.
  * @MPTCP_EVENT_ANNOUNCED: token, rem_id, family, daddr4 | daddr6 [, dport] A
  *   new address has been announced by the peer.

-- 
2.47.1


