Return-Path: <netdev+bounces-145147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC03F9CD59B
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 03:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A339228322D
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 02:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF29B13B5B6;
	Fri, 15 Nov 2024 02:47:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E979028EF;
	Fri, 15 Nov 2024 02:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731638863; cv=none; b=ewwxzy51SrLjAYnUF3cq6vcT49tgr1CAlkiDR3V+x5+COj3jzcYI/lta8ZXL1qumjt7wBMor9N5h9CmwjnMkejUhDFkOnTTNg47EyczN7YMKKHt2awnqYJWQ3YiaMTMyuAzqB8fttT3rUybpDWUc7Y2ICPTt4TachJfSnm9sxNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731638863; c=relaxed/simple;
	bh=NaxE2YI/enKQyoFr4DQ+jtowLmbyJXGm9XqdEN8ifu0=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=K52tnZ/N0mfex2sGlcqSy72XwAXQZohKZucoK1rmdrFwK++ctgXMafTDmIxJXloFcKm5Cs6T6ZbIcn/YDCDeLq9n12/mXEnXU9PSWv4vMenEi2nY624eqkRL6xqK3SmxnBTKXn3gzDOocpacSjG1QlHYRrVlinaJ5LlYEuwTPxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4XqLzD3dp4z52SFv;
	Fri, 15 Nov 2024 10:47:36 +0800 (CST)
Received: from njb2app07.zte.com.cn ([10.55.22.95])
	by mse-fl2.zte.com.cn with SMTP id 4AF2lUiE097838;
	Fri, 15 Nov 2024 10:47:30 +0800 (+08)
	(envelope-from jiang.kun2@zte.com.cn)
Received: from mapi (njb2app07[null])
	by mapi (Zmail) with MAPI id mid204;
	Fri, 15 Nov 2024 10:47:31 +0800 (CST)
Date: Fri, 15 Nov 2024 10:47:31 +0800 (CST)
X-Zmail-TransId: 2aff6736b64336f-6cfab
X-Mailer: Zmail v1.0
Message-ID: <20241115104731435HuFjZOmkaqumuFhB7mrwe@zte.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <jiang.kun2@zte.com.cn>
To: <horms@kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <corbet@lwn.net>,
        <jmaloy@redhat.com>, <lucien.xin@gmail.com>, <netdev@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Cc: <tu.qiang35@zte.com.cn>, <jiang.kun2@zte.com.cn>, <xu.xin16@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHQgdjJdIERvY3VtZW50YXRpb246IHRpcGM6IGZpeCBmb3JtYXR0aW5nIGlzc3VlIGluIHRpcGMucnN0?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 4AF2lUiE097838
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6736B648.000/4XqLzD3dp4z52SFv

From: tuqiang <tu.qiang35@zte.com.cn>
The hyphen is removed to have the same style as the others.

Fixes: 09ef17863f37 ("Documentation: add more details in tipc.rst")
Signed-off-by: tuqiang <tu.qiang35@zte.com.cn>
Signed-off-by: Jiang Kun <jiang.kun2@zte.com.cn>
Reviewed-by: Simon Horman <horms@kernel.org>
Cc: xu xin <xu.xin16@zte.com.cn>
Cc: David S. Miller <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Jon Maloy <jmaloy@redhat.com>
Cc: Xin Long <lucien.xin@gmail.com>
---
v1->v2:
typo in the subject ticp -> tipc
https://lore.kernel.org/all/20241114182129.0b24d293@kernel.org/

 Documentation/networking/tipc.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/networking/tipc.rst b/Documentation/networking/tipc.rst
index ab63d298cca2..9b375b9b9981 100644
--- a/Documentation/networking/tipc.rst
+++ b/Documentation/networking/tipc.rst
@@ -112,7 +112,7 @@ More Information

 - How to contribute to TIPC:

-- http://tipc.io/contacts.html
+  http://tipc.io/contacts.html

 - More details about TIPC specification:

-- 
2.18.4

