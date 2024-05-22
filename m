Return-Path: <netdev+bounces-97628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1FCC8CC72C
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 21:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AFE9281DD8
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 19:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72AE1474DB;
	Wed, 22 May 2024 19:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gedalya.net header.i=@gedalya.net header.b="XCaoXie6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-in-1.gedalya.net (mail.gedalya.net [170.39.119.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447E11474A8
	for <netdev@vger.kernel.org>; Wed, 22 May 2024 19:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.39.119.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716406101; cv=none; b=okfTX5Wjx7JxnbuWNuRTIoi3HFoK+IZveWuLfVdBeAOY5YgIIhMzwzQl+Q3XgC7dEyprc3fYA5XhRe9Ctdr7x4rcvs/qmeMWwe6pUsgNVW/I54hwVXIFYEe7xMEzDuDJ3OrRCE1UqHa4xpwswlB+1TlQbuHQwNbwJQW1ksRxNSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716406101; c=relaxed/simple;
	bh=opJTvGq19lAFyU2IHk6MWmI5qpj66eZOhCSX2q1kEqk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=DQPNmenLLIUPBgJbW2KihNw7Zp9RIetr1OpjN4vNbxQ95zlo2/AJwVBUpgNd+lBwYSTO2ZG3gMkkXzyhmpONrSQBy8eNInqXTi59fXUcz6CR0QGCOnhDb4mZLjR2HPpm/g7OZxvkCtZq7hJdPHSyEH31ItzClR605hdEKpeiusY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gedalya.net; spf=pass smtp.mailfrom=gedalya.net; dkim=pass (2048-bit key) header.d=gedalya.net header.i=@gedalya.net header.b=XCaoXie6; arc=none smtp.client-ip=170.39.119.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gedalya.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gedalya.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gedalya.net
	; s=rsa1; h=Content-Transfer-Encoding:Content-Type:To:Subject:From:
	MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description; bh=SD3AY3pHqegeUFWWXRlamfFk6oKEs2aCpeanHGHWZwA=; b=XCaoX
	ie6D17Vtj/7C4kAtoXbIeeD9vJJekqnzNZHyFHTIMFHmUqmEaRtmBUr/wrwEHf/zKDquC/JzB6SRl
	UjIJtv3a9NSKgZ1WZccdEDpmGjoeRm69alP2YlxlAuYWq31ffAAPre/HazXcDrX8rqD801RF/iXGx
	VIvcFZo9Lf7PiCyJ8En9QK8qjgkEA6dzX2DrMEGIT6Sfc0Oz2NClicgXVsiX+AVgRqsb63ceqFfZo
	8foBEiRQ6fPubtBw2QrdB8JP2Hkt6xIl9WjXcu11BJfrCYcj6wOcxqCseiY00rjadBWtI2lAxP1OZ
	a86q1YcJLKvWwWOxzTUyF+mTUDHhg==;
Received: from [192.168.9.10]
	by smtp-in-1.gedalya.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <gedalya@gedalya.net>)
	id 1s9rdK-000edG-2g
	for netdev@vger.kernel.org;
	Wed, 22 May 2024 19:28:19 +0000
Message-ID: <01a20e83-c05e-4006-b64c-3edd34508296@gedalya.net>
Date: Thu, 23 May 2024 03:28:16 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Gedalya Nie <gedalya@gedalya.net>
Subject: [PATCH] iproute2: color: default to dark background
Content-Language: en-US
To: netdev@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Signed-off-by: Gedalya Nie <gedalya@gedalya.net>
---
lib/color.c | 8 ++++----
1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/color.c b/lib/color.c
index cd0f9f75..6692f9c1 100644
--- a/lib/color.c
+++ b/lib/color.c
@@ -72,7 +72,7 @@ static enum color attr_colors_dark[] = {
C_CLEAR
};
-static int is_dark_bg;
+static int is_dark_bg = 1;
static int color_is_enabled;
static void enable_color(void)
@@ -127,11 +127,11 @@ static void set_color_palette(void)
* COLORFGBG environment variable usually contains either two or three
* values separated by semicolons; we want the last value in either case.
* If this value is 0-6 or 8, background is dark.
+ * If it is 7, 9 or greater, background is light.
*/
if (p && (p = strrchr(p, ';')) != NULL
- && ((p[1] >= '0' && p[1] <= '6') || p[1] == '8')
- && p[2] == '\0')
- is_dark_bg = 1;
+ && (p[1] == '7' || p[1] == '9' || p[2] != '\0'))
+ is_dark_bg = 0;
}
__attribute__((format(printf, 3, 4)))

-- 
2.43.0


