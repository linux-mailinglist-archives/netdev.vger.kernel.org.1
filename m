Return-Path: <netdev+bounces-259609-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SH/3DqWfl2nc3AIAu9opvQ
	(envelope-from <netdev+bounces-259609-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 00:41:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA97163940
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 00:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3885302EEBE
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 23:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344B4314A90;
	Thu, 19 Feb 2026 23:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XR648izV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090893033C5
	for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 23:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771544463; cv=none; b=rct9a2JaaR0bOFxrSa16RcUHT7wvABpCRwew17ZraavqGdpNnYr0HpCOyDywW0ZEuwztvvgW44asTAOg6YXd1fHrNp0yT8UBKzqPbZANg928ZrDyYkwd0ivEEOLLEbSrOwyIxrfKtD/RP3ul1Hsms3qH/W9BIPIBvQNkTIj1r5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771544463; c=relaxed/simple;
	bh=PMAPfIQEj675IqbisUBERbNkWF6o3Hukzf5k9lachTI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tLYg+f3mTu7/4yaKiSlH8+LNEqVt9SaoCFkSQe7rkOJXExZyemw3Nj9fNe3FAHBwWUO4dS8RwDSPr8X7thZMcz8C0R5a8th6BlPrNQQpfDd5/CV8UEdc10JScMcpVEUeFoj2vMqH8q4Fn8GxxbjO2TDSHWD1TI7SjGkAj1J3fB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XR648izV; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-127423bea4bso882108c88.0
        for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 15:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771544461; x=1772149261; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BofRrJoOgRuo4uPqIcmQDyXymqEuxMsCR5jwllsdETk=;
        b=XR648izV8WEmMbhF0uwsDAJNxEfsxmXZZO9u2hBuJm30jg0odRdD8gBhMQRdVzNzx6
         n1olf8uf8Ff6MKEHg4uJjqC/a0qwvWC5MQ9hoOVK4MGY+TVfthghMkNTg2AQUq0PRlVu
         lblt/bkFQUv6DpwFkxN0u8mH9QjV3kU61oF6YZau+bafzHiIdIqR2PiAT2+g+un8+f0L
         plVYhri05juiB9HG2BZgWRVoJ91OBXbMGayXhPLSGEigX9NLPXWL/U3FLbxMxQiquG17
         o4kzLPbD9HD0gAtfhQ0NxBJxku7yp7deIH28+JXMbacW4lYn6LOz90iH9j1CvfXk9dvE
         9klA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771544461; x=1772149261;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BofRrJoOgRuo4uPqIcmQDyXymqEuxMsCR5jwllsdETk=;
        b=Bf4BqYgdd3oF+qolGcK9+UYPWrr6ouqO4dIRBpgu6rXbUXwDS9JpEaeHbxHTDU42pT
         rVgfY3U6ORhWwIpW8FFPw1Dq5ejOR+Gskl9AMo3boVyM2wGVEyjMgbw+cpsRtbGvi6H5
         trJXgF0iaOgpLvmCiGV6hwlyjD1cue/htSoER3G4HM7rxoQiggGK2GxJOZAuHgh/eibl
         58HgN+pMOoviHM3+90AQ05cufPbmDHq9L/gqAmdLRH8cBWUQyeYI++745JuGHSbL3v5x
         yQy/yHpehn8HDU7F3DoR33qJ/9/wgSqRIEPkD/4HfksjQyn7+lCMTs2Jvbbg6olHMb6X
         ksNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEFpBgtwkEkn/9klkfdfQEz3tQH+HBgxNgyO5tmv1HiIrCJoDt9uV407D7zyxgcUyyUoOEKCk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBEcba3gWnMeokkN3dyL165oMsHyTK0lS7+FUz4o9vzSYHPMmW
	UQUkZ7USi7McSfNJsb9S4wKlOgFCW5b69RkhAsx4qtsUruuF0OpMM2PA
X-Gm-Gg: AZuq6aKeclywZP3ofiGdw9iCbYXp5YuwM+2llVDONpBbw1nueT6J5btifhT9WmwM/1m
	931nCmm30Gx603zdkr6r13hYQf7BmyEokol/A6URjzqGiyM5Q5nNUN3+oTK6kzrc6HKSfhLTx6b
	05cYyJUq5c+LefNUkRl7nUa6JCbfU6DzKmg5oHqWnSl65wPRi6L8eNtNdDzDSgTkg9AGUAvVmXA
	LLxHD80TRynB7pxq61sc7lNGp88B4KRo5DaF7KHYPmTqw9vFjcjlCzYAXB/hYluTqrH1GZ3NV8h
	FR90pVFogxh2Dv+SgzOZg+QpRq6bwOym2Fuwv3gRyqnV2tzZtaRxdr+mLK5OAYuIo9ONNF6tx6Z
	141fMtkxrXVkED8YX6F1Vh5yvsqH4Pkkog8oPYeYDnKvgtJG/O2KqiUUyML7z0Q5at5esgTUf+D
	+KKS/DRQxe2BpgGwZdoOjGH2vF8cHSTR9shcpcT8vyS2sCLO0WBLpIESyiZLLo65QD
X-Received: by 2002:a05:7022:128c:b0:127:874:af0a with SMTP id a92af1059eb24-1273adb37a3mr11907088c88.5.1771544460948;
        Thu, 19 Feb 2026 15:41:00 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:9c24:8181:603e:7ad7])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12742c6dc70sm23105356c88.8.2026.02.19.15.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 15:41:00 -0800 (PST)
Date: Thu, 19 Feb 2026 15:40:57 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Simon Horman <horms@kernel.org>, 
	Zijun Hu <zijun.hu@oss.qualcomm.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net] net: wan: framer: fix potential UAF in
 framer_provider_simple_of_xlate()
Message-ID: <aZefB5f3EAkQQM1m@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259609-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitrytorokhov@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 9EA97163940
X-Rspamd-Action: no action

The implementation put_device()s located device and then uses
container_of() on the pointer. The device may disappear by that time,
resulting in UAF.

Fix the problem by keeping the reference to the framer device, and
avoid getting an extra reference to it in framer_get().

Fixes: dcacb364772e ("net: wan: framer: Simplify API framer_provider_simple_of_xlate() implementation")
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/net/wan/framer/framer-core.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/wan/framer/framer-core.c b/drivers/net/wan/framer/framer-core.c
index bf7ac7dd2804..397fabc3da4e 100644
--- a/drivers/net/wan/framer/framer-core.c
+++ b/drivers/net/wan/framer/framer-core.c
@@ -482,8 +482,6 @@ struct framer *framer_get(struct device *dev, const char *con_id)
 	if (IS_ERR(framer))
 		return framer;
 
-	get_device(&framer->dev);
-
 	if (!try_module_get(framer->ops->owner)) {
 		ret = -EPROBE_DEFER;
 		goto err_put_device;
@@ -749,7 +747,6 @@ struct framer *framer_provider_simple_of_xlate(struct device *dev,
 	if (!target_dev)
 		return ERR_PTR(-ENODEV);
 
-	put_device(target_dev);
 	return dev_to_framer(target_dev);
 }
 EXPORT_SYMBOL_GPL(framer_provider_simple_of_xlate);
-- 
2.53.0.345.g96ddfc5eaa-goog


-- 
Dmitry

