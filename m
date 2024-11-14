Return-Path: <netdev+bounces-144894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8215F9C89F5
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 13:28:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BA561F248DE
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 12:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08B31F9EDB;
	Thu, 14 Nov 2024 12:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="FXT3lsz/"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90D81F9EDA;
	Thu, 14 Nov 2024 12:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731587221; cv=none; b=cVgSXt5Ij8gJ2v4EqpjJvIfx4birNSUyCw0wwda+TqPLyKDc7GuJ7MpIMn+oLm/gPGqbP+L5OwI2+vtoS5ZWOwtjTNlHrKTX2wQIgdY42SLrtQAtckTiv7WJFzqAWRsKQOZAJ9UTh4U++/KvMYMA6RKgV0S5MMvVU3amDzvWe58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731587221; c=relaxed/simple;
	bh=KqlIOx89Q/h1+1tvHJWgZpQWh11p9h3EP1DVFjwfdpg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K1+M2TrYLfzUhOjdpWMKBVxZNjYqZ8FPxHfZ8zy3AqRa9tkcGzI0KVFO4L2aKpYf3Cno5rRJ/8lQIjnWYhwxF0Yp9d1QskvwJxP+tY8ODFy2DuqmC7SHzQQN7sLpzb+2DQxpDPH7pDxod7jCRTy4t5zCGTOLmjlPF8aAy9wNct8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=FXT3lsz/; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1731587174; x=1732191974; i=markus.elfring@web.de;
	bh=KqlIOx89Q/h1+1tvHJWgZpQWh11p9h3EP1DVFjwfdpg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=FXT3lsz/e+HCOZRkWM/q10zhgO7gxb3KCAY3/JMs/EaCue+eLUv3myyQ9uMWlUiT
	 598nHhUzdo1CO1Azi6HpI87po4Kxg5pxc7PMgaTQMTS516vhYhsvipywccpy3piWs
	 aH9ufFkBrI2H28qJO665QAmugDzL46kzt4+kURvJFhVa8j6D3iZcF/KUSfiBSYBq9
	 sg1zi2TkwV/bYGSLgASbz0NBsJxlI5KqGAFmeA3I1La0PqUGfj15BtuD8Dq2lU65o
	 oqnhBPQWyZVgXBIEjca8mDNeMI6lkM+Sx3JkbI36HV6XOlIpLEomu1q2PTOQonDNw
	 ddYWVok+lb1Xuc731Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.88.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N3GgY-1tts4V3Ppy-00vcoH; Thu, 14
 Nov 2024 13:26:13 +0100
Message-ID: <7f5b2359-c549-4de2-b4c3-977e66a1c1fa@web.de>
Date: Thu, 14 Nov 2024 13:26:03 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: chcr_ktls: fix a possible null-pointer dereference in
 chcr_ktls_dev_add()
To: Tuo Li <islituo@gmail.com>, netdev@vger.kernel.org,
 Andrew Lunn <andrew@lunn.ch>, Ayush Sawal <ayush.sawal@chelsio.com>,
 "David S. Miller" <davem@davemloft.net>, Dragos Tatulea
 <dtatulea@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Jacob Keller <jacob.e.keller@intel.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Mina Almasry <almasrymina@google.com>,
 Simon Horman <horms@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Jia-Ju Bai <baijiaju1990@gmail.com>
References: <20241030132352.154488-1-islituo@gmail.com>
 <55a08c90-df62-41cd-8ab9-89dc8199fbfb@web.de>
 <1fcd2645-e280-4505-aa75-f5a6510b5940@gmail.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <1fcd2645-e280-4505-aa75-f5a6510b5940@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:mm3L9ob3uPy6LSLfWOFRo2GiRq1ElIKATbVt4U8R8ed8LI1ldnb
 55PjUzdTMl/3oeStXodsGvk0wJTGTm5/anMi11ghK6IwPByJVd0da8abq78W5XiJE348ST+
 /IqiAeJm/FpykncAT43PxSP10DxSf6Qrg9To9+ebTSuDhO/OYO7D3PjP18+c6xnxPCBnlVx
 C0A6hDDXewYn8k6R4GuIw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:hnw83Nteg4g=;GiDt/RZS1UTOAdYHeK+APYIeSOH
 z8hcaBbyz167+VCUjS5AZFtuujdJ1oQLioETME6liLcZiAJ8CDX5V9C+iFAZ/LBljRoja61UJ
 ++g6sOIzkHPxbLjKF0XoLddOuAqhkNZ2NMmMP1tyRgciZOOs1tqr/U5BQOhMyjGjJ6Oqzx1vL
 WCLEO2EaK2Tphtc6S1I/INcaWIircdJAbZDcP35wUQH/th83ibJortiJxT4rkrmtY22EkIu1p
 YIHMb/wha2gqAg+fMbJElXgrB2FGlStsCT1k9KYDz1v5okgMFC17ZS2xjcckwl4hYao/NGJ+E
 DR8ln+QNGuFT9exTl9DELry8ED8MZlUT+86fuVXAApPispqMPvr3VODA8Q+NDlTLe/8ySAEyV
 htJM7KS0F3X/Xiv25RZdHKgG7qSaYLBCpXSq6gPh0JmJNMY0+uQkk0i09ocDnP4WA4orQ2vxo
 2jNynj+NVSlXuvAdrvLFh644qIDFYGbXCIAeKtvWilbNd+yyGUMF7PMHvsQrTSCY+dKtpzmF2
 K1thbs4ufKKOq0dR0w3A2Xr39BaWwtckbwZuZr/VOFBuQigCH9Obro5PHpkR9Mw45x/eAIEro
 jZA4MpDhbdQ+WDnZKcOd2ZX/ARTGryQmhApVh9AeEVPzzxq5smzBhbPSTrxPk8+VOi3n+z8o5
 PzuwHxEN8rs4jABC+ysK4Z8cUcoNlJ31alvs/VxgIYHqcSNabIa0RbfuPW5LgNB2XDD7B/9Fs
 pwvH1u4ni19MD4XE2FaaOHTNsVUfrB9cYMtQ8l7DvZ8y3RAvmu3VTtHUGwz0SIKhqMyU+T8gt
 naaoJMpVpJMuAFX3/X0sBOUNrCfGOpWmB5HLUgpkePJI12KfCbNUmqw+XrUPmHldWLCzTEXXX
 p+iQCMFke1uiUxdNXVplnx00k95FbAyPSPhsOVd8/OzLU+RLqVe6Vwlvk

> We have run our tool on Linux 6.11, and the line numbers correspond to the
> code in that version.

Would you like to share any source code analysis results for more recent software versions?

Regards,
Markus

