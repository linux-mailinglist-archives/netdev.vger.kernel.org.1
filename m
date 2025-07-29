Return-Path: <netdev+bounces-210903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C3AB155F1
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 01:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECFFA3A981F
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 23:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A03285042;
	Tue, 29 Jul 2025 23:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nchip.com header.i=@nchip.com header.b="mgAKwUdM"
X-Original-To: netdev@vger.kernel.org
Received: from mail.nchip.com (mail.nchip.com [142.54.180.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8448C2AE66
	for <netdev@vger.kernel.org>; Tue, 29 Jul 2025 23:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=142.54.180.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753831577; cv=none; b=BzXm3zSkEZTmWp0RpFBfjM5NNjyxsTyzzFJMTy+K7/uVGYr7vY0ihi+0QfM8yxg0qPxhyYwI13pc80p8b2X6th3dN7OiLq/hxlLXPUzbIB8nRpmyQ9fdEG4SBrYBmh+7Typ1qFaCINtNtFP/0rDCtrbDt/tXbqi3D+/ONCcx8qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753831577; c=relaxed/simple;
	bh=8pVKF4ftFZcMGeOzG6JvAXJoDtR4Op4vQLxC7t1Z2fI=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=OS5Vy83rgHlwBV+2z2X/dxL//8hWGv8qSIQguaVCjVv7Gw5yqNHRa97gvQYfuPwpH94I79RF3rag2G0aWXJ4I3kuhVp1hELZL4jIUnXVVbhTE88v/Y9Vu0VnGdBe5aidSHnAIoO33IoJnbRitByFTG9ju+GEwbD9bhN6qXVknTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nchip.com; spf=pass smtp.mailfrom=nchip.com; dkim=pass (2048-bit key) header.d=nchip.com header.i=@nchip.com header.b=mgAKwUdM; arc=none smtp.client-ip=142.54.180.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nchip.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0F4D1FA00E7
	for <netdev@vger.kernel.org>; Tue, 29 Jul 2025 16:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nchip.com; s=dkim;
	t=1753831575; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:content-language;
	bh=E2FsirugV8lswUjTaRQj01unhh34/NLWKKSVMs8cl5Q=;
	b=mgAKwUdMbahpF4gC6VA6a28Mgct5h/XTApiTW08Ib0BQWFEkEVLeNEacaAa031KBCeh9d5
	eO+xmj1nVhd1YGF61v0IM6ABqjxTmsoNSlQyj7kEotEUAgAsfFbuZve3sIPTyWmofD/+7v
	AMAQjVK++8yNfAgSZyRo8LdgE0V8k5Nj9MMmXb8V4ev3Owp3g5nxd83U/eImBPSS1cvtym
	RuYrr+k8T8PpLjzY26hQE5A6k5d7PRR7fkPYbhe/0EDPqissirFYdsY135wGdAOExRewzT
	PJaHlrSvffk/0iYK8qs3jnYKhjS1bZYEjyTIjnxhFTW1vuUOIu/I/QS1VqtDcg==
Message-ID: <439babd9-2f47-4881-a541-5cb63b94aa57@nchip.com>
Date: Tue, 29 Jul 2025 19:26:12 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: netdev@vger.kernel.org
From: _ <j9@nchip.com>
Subject: no printk output in dmesg
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi

In "stmmac_main.c", in function "stmmac_dvr_probe", after probing is 
done and "ret = register_netdev(ndev);" is successfully executed I try this

netdev_info(priv->dev, "%s:%d", __func__, __LINE__);
netdev_alert(priv->dev, "%s:%d", __func__, __LINE__);
printk(KERN_ALERT "%s : %d", __func__, __LINE__);

But in kernel buffer there is no messages from these 3 function calls

Any suggestions how to make printing work and why these are skipped ?

