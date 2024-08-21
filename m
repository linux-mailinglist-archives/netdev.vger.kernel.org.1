Return-Path: <netdev+bounces-120657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06DC995A169
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 17:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A880F1F21486
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 15:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDA114831C;
	Wed, 21 Aug 2024 15:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DsKBEt77"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD39013633F
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 15:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724254223; cv=none; b=B9ZCQEtkxhwT0Am+t1JM0kS46pD533ctT8HxTxKD7BCt/pD3LgFgUWYvvOH4VWrNSAbvTDnnfSw4UoAF2Dn4WDzNp0sUCjx4QJ2P/CO6q0xV0M6Sp7h51wPimxsi4GPMn1du1XRdXUmkr62rYqz1eoLsUj6m7oTyw32RqYYJ5Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724254223; c=relaxed/simple;
	bh=sw2FS7YwNH0rj0UoCaN//L9VY4URvfHH/7jJP0AnO5c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=lg4zsg2ItEuAZejfAPOzdcX83+DbwurOVI131bgm40xToHsBnABxmVGIzoeanV8fUXBuk32pUfiDkeffZ51KiQiDBxBT80HB0VOxFnXkmVaamjq/tQ8aVlasEcXA/z13oh9FfznLMz9ZWPDVJBIcglyXPcUTHYy2k8XJ6GibNts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DsKBEt77; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D845C32781;
	Wed, 21 Aug 2024 15:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724254223;
	bh=sw2FS7YwNH0rj0UoCaN//L9VY4URvfHH/7jJP0AnO5c=;
	h=From:Date:Subject:To:Cc:From;
	b=DsKBEt77iEiqBlfg8dzZ9Hm5Dn98EBJcU1gtXUxHPHvAPBxlKOJ6j4gTcc4eSbsrv
	 DMzzX49izx4oWeDcQ8Wvw7w7Mg3/+5+fAH10a1P9+nGay1bkoKxjMzuJiU/2P//hop
	 dgZtir3dd2ieMFJMlRdCuKJs7p1FYOP1MEsOWqdOLT8DvI5fZF6kQd+pF9UqQAZUt1
	 L+L0YwjHoXubST4J0PtllW9AS5XFEsMfdznQ8LF6eF5Mi6OdA6smDyahCX7a8jkI0Y
	 ay1SoGsfR7MCVvvxjqC9oR+X/qrusuyUR+LXrfCIA/NUXsMsVx4pTWrjPy8ofrVx6o
	 GiSsUbBThAHXw==
From: Simon Horman <horms@kernel.org>
Date: Wed, 21 Aug 2024 16:30:13 +0100
Subject: [PATCH ipsec-next] xfrm: Correct spelling in xfrm.h
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240821-xfrm-spell-v1-1-b97e181f419d@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAQIxmYC/x3MywqDMBBG4VeRWXcgjuLtVUoXxf7RAY0hU0pAf
 HdDl9/inJMMSWE0VScl/NT0CAX1o6J5fYcFrJ9iEietG6Tm7NPOFrFtDDRj27tOZPRUgpjgNf9
 nT9JomDkgf+l1XTcYhohJaAAAAA==
To: Steffen Klassert <steffen.klassert@secunet.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
X-Mailer: b4 0.14.0

Correct spelling in xfrm.h.
As reported by codespell.

Signed-off-by: Simon Horman <horms@kernel.org>
---
 include/net/xfrm.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 54cef89f6c1e..f7244ac4fa08 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -79,7 +79,7 @@
    policy entry has list of up to XFRM_MAX_DEPTH transformations,
    described by templates xfrm_tmpl. Each template is resolved
    to a complete xfrm_state (see below) and we pack bundle of transformations
-   to a dst_entry returned to requestor.
+   to a dst_entry returned to requester.
 
    dst -. xfrm  .-> xfrm_state #1
     |---. child .-> dst -. xfrm .-> xfrm_state #2
@@ -1016,7 +1016,7 @@ void xfrm_dst_ifdown(struct dst_entry *dst, struct net_device *dev);
 
 struct xfrm_if_parms {
 	int link;		/* ifindex of underlying L2 interface */
-	u32 if_id;		/* interface identifyer */
+	u32 if_id;		/* interface identifier */
 	bool collect_md;
 };
 


