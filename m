Return-Path: <netdev+bounces-227801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6295DBB78DB
	for <lists+netdev@lfdr.de>; Fri, 03 Oct 2025 18:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F21FC4ECB1F
	for <lists+netdev@lfdr.de>; Fri,  3 Oct 2025 16:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7DB238C0A;
	Fri,  3 Oct 2025 16:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="tQHxs4Kd"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83353274B59;
	Fri,  3 Oct 2025 16:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759509138; cv=none; b=jZcmXgVMIwsQ3pj0FR7PVwvv6ISh4rI62hqX8hkB8AYmCtlr+ma9KQ0+EIXyVJJslDBJdd3hdkW5DEo6hEADDN0gQMZlFXqUYjoz433fPQwoLSdNg2UXWgOfCiNckkt8pM4g4gmO2/vucDnwcpFAsPqm7hEYfrBXxSNFl3QxtxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759509138; c=relaxed/simple;
	bh=yAR10OIPN+DTvGbJQsaMkX4gzSxmUi1IfJPpGjjCZCY=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=FxcjMAh+fELtZ7Z1lfaCKSJITDSSUJp3VzeAlXc0uxn4CihsJxytVWenMpmL65vq81+Kbnpbd8HLONUKePakGe609+nusIHzyqJn60upFO+yto/NleaCTv5lRF2lA+QXi+v9CiLu0FqQEV98zTC4RX9XE2UImUzLv/IfO4icSdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=tQHxs4Kd; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1759509133; x=1760113933; i=markus.elfring@web.de;
	bh=yAR10OIPN+DTvGbJQsaMkX4gzSxmUi1IfJPpGjjCZCY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=tQHxs4Kdk+nlU9FYS0vwesiz30FgUbpgExIw6XJZnh7ZHpvRsaJ6CHJoT2woP1fv
	 B/zWyZbYT0Pm5DSyZGe4Qur7pbD5tkTAYyS+wK/mreIQqEeikWk4C43PbTX+Zqmtv
	 peNe7ikEIV/a9zGxzwSz31Ya4U/k+0DQZg36DUjJktEVakg28Ph6qouJT9UqCvjWX
	 3rHBWrC/il9lrzoBjhaBDXLmwsOLVofHyCaGPmYUJTm01MF1AEBDDX18OS5aQY9Rl
	 t88bPHmsWnbzwYNe6iz41n0Er4gM8sFdeBkXweNLIMGC58s9FR0Jv0r7s8yB5QAeL
	 yl7sdSpNdnymkzwnuQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.196]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MOm0r-1ueVPe1CTn-00UBAU; Fri, 03
 Oct 2025 18:32:13 +0200
Message-ID: <77f2a45b-1693-4106-8adb-304e0e818d82@web.de>
Date: Fri, 3 Oct 2025 18:32:09 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Erick Karanja <karanja99erick@gmail.com>, netdev@vger.kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 David Hunter <david.hunter.linux@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Shuah Khan <skhan@linuxfoundation.org>, Simon Horman <horms@kernel.org>
References: <20251002174617.960521-1-karanja99erick@gmail.com>
Subject: Re: [PATCH] net: fsl_pq_mdio: Fix device node reference leak in
 fsl_pq_mdio_probe
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20251002174617.960521-1-karanja99erick@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:8W/6qW33cw+tr6rspLzq0qyhdNS6PMNpOaUXr5sL5jZUG7xARm+
 8bv2tD70HNQ/cjsZfd7mEcksa9LQQrJe1OBHsWh3Hy8LePCxs0wr98qy7cdrU3sW+v403p3
 6dDvNH/m8qTY62jVZr6ILq0wth9jfFwUSfsxjuMcZrZvuoyMV5X0EYzGW4eMlpV1mXs7dGX
 zyiaeaoOxX3nl0bZKac9g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:lZS0kOcIC4M=;ZaCY+IG5nEBWbT/Uy8aBoxw62OC
 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
 2tiZg==

> Add missing of_node_put call to release device node tbi obtained
> via for_each_child_of_node.

Will it become helpful to append parentheses to function names?

Regards,
Markus

