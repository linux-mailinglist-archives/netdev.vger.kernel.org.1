Return-Path: <netdev+bounces-219574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8DEB42020
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 14:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22663166534
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 12:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56DAD2DCF62;
	Wed,  3 Sep 2025 12:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="UT5VzZrP"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36D82FDC43;
	Wed,  3 Sep 2025 12:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756904112; cv=none; b=rcwDaMX/XJYtvM8M+vLj+q10w5P6SUETpIgfNdjCgUyvQkzJiTKq/rofJxvqRbvXUauT8fhJNo+hnXdT/wbuSYiPYl7usZIYQeepWSBRKtAnaPTNTK5xKROB3keiYIn/z3bx2cIfu9Q9JIDooGV9I154Z6/YElsORulBmeiAz2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756904112; c=relaxed/simple;
	bh=ZiVq9zaL0ZcVmhlXrOoNRbemeu9qa4IdIqQUwysmueg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mbf3+sl7gmJdT51WZaihwyccp5dzhpEcg2TQL6LCe2Q6hzFBhKri2XqZLWQsEM5BQI1cWuHyuNBqW0oE3MEVY7Y3CwCfYori76oV2WVg2hAAHGzw/7Jp2kyfbZ61im2ZmpxDLxgR1u5RmcqIWpCUFG2hw/zQo2SmVcvlJTOMU78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=UT5VzZrP; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1756904097; x=1757508897; i=markus.elfring@web.de;
	bh=ZiVq9zaL0ZcVmhlXrOoNRbemeu9qa4IdIqQUwysmueg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=UT5VzZrP8ZKbQTqWePqHDFfvAkflUTqOqDY1O4mUr9dBBjERET2+DzsJ4zkQ2jms
	 L6qINJNOZOs88hYvNLe/p1XmBWbdU8imoVBFkB1NFqKiAamDSdP3AITVLDROaQGhb
	 7Zk2nRP8dh3nmkAZ9+lGI+JO43QQs4rVEBCig5F9WTtG+4l0ooyBXSQ/nWmeIYRqf
	 tk4wdnetlAEH6NO/GX50khiy9fO+6shHr4IfcDT0YWCBhu12o+O+9QZBuQnT3A9sO
	 NYXmRvbjh/Vb4CM/hzClOST1uSH2qOzzk0WkGuE27K3dlVw4nGRDJIhP2grewiMUu
	 tbGiwYXlbLcoQiistQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.225]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MoecP-1u5XtA2KMb-00gnNG; Wed, 03
 Sep 2025 14:54:57 +0200
Message-ID: <25810f13-567c-42e0-a45d-c42b39bdb690@web.de>
Date: Wed, 3 Sep 2025 14:54:53 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2] ovpn: use kmalloc_array() for array space allocation
To: chuguangqing@inspur.com, netdev@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Antonio Quartulli <antonio@openvpn.net>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Sabrina Dubroca <sd@queasysnail.net>, Simon Horman <horms@kernel.org>
References: <91b13729-7b5c-48a2-acb0-9f23822dcf3a@web.de>
 <20250903121710.69026-1-chuguangqing@inspur.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250903121710.69026-1-chuguangqing@inspur.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5Ut8k5sb7mX87kVfHfFliIbcZPib6yjnQ0ELMEdqETTdHD3LoHw
 /xu1g6WWqnvzzLWzeR/34+sq4Ys1qcYw9sb6wYPYN0lljG7ATncfiIgFhpec14yusf6x9IJ
 kc/LQMid8XAXAWreS5HEof3nHr5YPhWsKxFjJyruYBdT//Rsu9Bnpeko3N2NlZS3IbzhWfQ
 cp0m76+g6+PxwFno8n/6g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LMDMukEntaA=;XmqybdbgnhGo9sPQRuSfSRWN/VL
 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

> According to your suggestion, the format "Chu Guangqing" should be used.
=E2=80=A6

Would you like to acknowledge that your personal name is actually differen=
t from
the shown email identifier?


=E2=80=A6> The signature should not be changed frequently.

I imagine that some Linux contributors would appreciate an appropriate Dev=
eloper's Certificate of Origin.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.17-rc4#n436

Regards,
Markus

