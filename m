Return-Path: <netdev+bounces-144868-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B0D9C8985
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 13:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B93D51F221C5
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 12:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3800A1F9EDF;
	Thu, 14 Nov 2024 12:07:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BC81F9EAE;
	Thu, 14 Nov 2024 12:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731586054; cv=none; b=nb3/t5MAAJA/ol7UW1P5HKKXd9FJLQiFOCSpx4hmxZyiRFpxdOZIbKeQq/vU96SvCqg1CUCMu8HlHWdoHktxE8MMmIMcZSq8bLiFctKLSrOfH2OkMqDF80Pr/LUvr1Jdn29/r0gaA3Qha0kseUEsjkkyG2iGXjOxmW8h4mPeMtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731586054; c=relaxed/simple;
	bh=LOd6GxO4tMJcV2o7TjI7n8wU2/+etepq1GwxCfsRtyc=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=pv57YEcPToZzgspW3bDJSaqn4S/GGAbuqylQlc3VIyT75KeI6nxTjMqSOgYRQ7CgQ7UCckihLXuZIPx+4Ly/A0YkwGwthJP88wC9FeY/DkOqtpdaWdUQ4Z2TuO1+cM/V+0Bh0gR3EIMtEVIKBZsP1VM20lRLlrxGwkXdDIajcm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4XpzRb5Bvxz50FXN;
	Thu, 14 Nov 2024 20:07:23 +0800 (CST)
Received: from njy2app02.zte.com.cn ([10.40.13.116])
	by mse-fl1.zte.com.cn with SMTP id 4AEC67Ud016915;
	Thu, 14 Nov 2024 20:06:07 +0800 (+08)
	(envelope-from jiang.kun2@zte.com.cn)
Received: from mapi (njb2app06[null])
	by mapi (Zmail) with MAPI id mid204;
	Thu, 14 Nov 2024 20:06:11 +0800 (CST)
Date: Thu, 14 Nov 2024 20:06:11 +0800 (CST)
X-Zmail-TransId: 2afe6735e7b3032-b8ad8
X-Mailer: Zmail v1.0
Message-ID: <20241114200611368_vpMExu265JwdZuArEo_D@zte.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <jiang.kun2@zte.com.cn>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <horms@kernel.org>, <corbet@lwn.net>,
        <jmaloy@redhat.com>, <lucien.xin@gmail.com>, <netdev@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Cc: <tu.qiang35@zte.com.cn>, <jiang.kun2@zte.com.cn>, <xu.xin16@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIERvY3VtZW50YXRpb246IHRpY3A6IGZpeCBmb3JtYXR0aW5nIGlzc3VlIGluIHRpcGMucnN0?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 4AEC67Ud016915
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6735E7FB.000/4XpzRb5Bvxz50FXN

From: tuqiang <tu.qiang35@zte.com.cn>

The hyphen is removed to have the same style as the others.

Fixes: 09ef17863f37 ("Documentation: add more details in tipc.rst")
Signed-off-by: tuqiang <tu.qiang35@zte.com.cn>
Signed-off-by: Jiang Kun <jiang.kun2@zte.com.cn>
Cc: xu xin <xu.xin16@zte.com.cn>
Cc: David S. Miller <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Jon Maloy <jmaloy@redhat.com>
Cc: Xin Long <lucien.xin@gmail.com>
---
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

