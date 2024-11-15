Return-Path: <netdev+bounces-145213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFEDD9CDB4A
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 10:16:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77B781F2226E
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 09:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE3018F2C1;
	Fri, 15 Nov 2024 09:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="nYx/xMnS"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDDF18E023;
	Fri, 15 Nov 2024 09:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731662177; cv=none; b=rqxhdtb0w1+PWClbVjYeXCYuhuA5r1GoYGlq+iZB4E0J4h3QoShTf9PPNt0sZuLkkLb3oY7L22wtyU2puHvjOn5MxNEYA+GsdkWTG6P7wHineP9NMuUs14pFflRk9xVqyQU0DwBDqn6Mkyc2oHMq2sPRT9aSP6VPTJoYyPKi8bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731662177; c=relaxed/simple;
	bh=mnLqYpfwXtTq4fXllzCQ+RGjySFJ4lzVvQWl4EZjpfc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n5j7daEaTy04cG4kVcAl36ECjNWoWWd0Vm96r0tyAdnunMKJc5EBEBP2qeaLES8niULaQ0kMayJaM8JAB50wRvzi6UaNs/S8NvMgdGyjI3w1bKnNoLOw1PMJKwWZMMO8Yi53ZmiAlRpZIxT775acIsJfewaE+eFPDVCS1FJh5gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=nYx/xMnS; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1731662130; x=1732266930; i=markus.elfring@web.de;
	bh=E+Icr/aX3ElCH1MMRCRUs3gMV8SMIiG9vSLedfc9yu0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=nYx/xMnSvPSPoDWsDSuuiCjnlk6K6hYB7SF+Ps56ywpnLjH7N/mmvL/vaOHQjMje
	 kk6RQCd0bkoyXEUhy5fhzZh9ojCLXuUxFw6Kx8v0rgxO9mJMkzaMfHsAo6IIzAgt/
	 p4xTOC8E1QAe4PnwH4n1mp/qUz/GdlO7bTqPX1OZZSEkUlgEwGGINWuktEGuMdZBg
	 ZePGZGyasax0MRhVtceIZ5n0FO/KxUcQcrcSEXcVVMWKVXfmrWJQ3bVgRSxMpQm9m
	 SDClsjJS6t1uvBSRUDNpiEl3iE6WpTiFr35lYE2/zx5yaNPBQoLnQqNAuxW+Sd+i/
	 TfOv8JIlb/SFN48xPA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MZSBQ-1tEie42w6g-00PhiA; Fri, 15
 Nov 2024 10:15:30 +0100
Message-ID: <80f19f8c-b520-494d-b087-407f1455e6ca@web.de>
Date: Fri, 15 Nov 2024 10:15:20 +0100
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
 <7f5b2359-c549-4de2-b4c3-977e66a1c1fa@web.de>
 <a33a3a58-ae24-464e-874b-bb924fa32f69@gmail.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <a33a3a58-ae24-464e-874b-bb924fa32f69@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KL8Rx4sT1ddO0a31FlJ6HMHi7uh2c54kv64cutPxW/Rc/ecJIGf
 XfyT93xnL598M6HsPez6jdluGaVbyK9tQil+bRpf2we735HPX/ahPortF16pyatDOU74fCd
 por3m1KVu7p8TgJi/mb+S84DplamYC0v4B7nFv2GRgJ63laeO3/RpWi94CLchSIeWdQxmQ1
 /U9Fgjfv7ykrouDtfHf7g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ThLgTY+wA8g=;et2047jeaIxfbwB36BT8uilVD6q
 AgVaeWRWGaTjQwE39vonXPSAItyvVIzXkzDdJ4eDxDCFvr/duo9Z/l3LFIzrD70pg/ECiwbCD
 qCcO+5I/xh/OhahOokoEJ/bZCoQJq+cmEq7FVBWxqExSXNhl1fRZjtwQY6kZu7WTiIFblpj9+
 yqZgl1P6FpIo9TEQ/j1fKzCEbvPcAQxYGl+HwciXZ17a4iQZF5EQBg4aFQxXEMOzq1tCkueXD
 orpE9N+83GSlUc/3FcXYvgnYT+ssFsLBLVO89aqZ91cRriClIDNWQwOwnZ3qI9YyNABxvPUDJ
 bWuciINJ/IkxhBuK9oYu/TaptD3YPyILlWtnd/3jKe32LTb8EVvPZjggCXb8fxxCA3mTT2n3l
 om1+riXNNUk+aQ9II3LGPfV7m7p8p2fElwWv3oKKInDIpZDl0A9Q9zjPPrn5l6avEw/8FSVE6
 MFhMlH3co3JMVXLPVpLQdVlIt/r+2xAnjRv1ni2RIiMtCbd4pEPVJVEd3QzB094wMhnG+2IWj
 EBAs5i24bCOgF3UU4kr3iZpE9THgm3Ic58VuXmyARqKuhL3hYQfBfZcPxEA2tuaAVivowFEbP
 GvvVjmo6KEB7QHJfbFusZ/dbHPCvwd7uTbhdrPF00LIbwg8L3B/E1EAa6u0PtJ/0IbX5NcM5G
 HXX1rxRKnfevjBs/Qy+UA9FR4iYA1M8cgnJtFN0aYdZXakoCgsbFKaAY+lt1ddeoBXR2KpQLa
 Co1Z8P0mKSVzmy3aHBjnchsSwqBqUAzOpGTekn1heaPb3xEUXm8jG2T/L7CeEwh41hPU26A82
 eBi+Oueu10crXAVHEUyfxEoZJdrjdyaipXYiuHI8KT93aTT5FbmwH2kZIH35P7N/JNQ3nmOpo
 3xBCLt8eOQ4ZXBFCx1/BgXnOV0vep83E2MGwYiFxvcRQja7i0V4X9mv28

=E2=80=A6
>   chcr_ktls_cpl_act_open_rpl()   //641
=E2=80=A6
>   chcr_ktls_dev_add()  //412=E2=80=A6

* How do you think about to improve your change description another bit?

* Why do you try to refer to two different function implementations here?

* Will further adjustment possibilities become interesting?


Regards,
Markus

