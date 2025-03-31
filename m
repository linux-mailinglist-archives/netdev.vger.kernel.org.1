Return-Path: <netdev+bounces-178417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21173A76F70
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 22:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EFA73A3D26
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 20:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341EF219E93;
	Mon, 31 Mar 2025 20:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="EpCA6Ff/"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9451B81DC;
	Mon, 31 Mar 2025 20:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743453493; cv=none; b=g4tEX5b38zK0RoRTJHoI5nxhFA3mNEaYT5/tKibb3DWhOfO9TBSFuDZ2CQiEahfzzaFArtBHAG87KEMTXl0+T4ayuqxA7k/WuXKY+AcuqAHrW74PWZpkSgyS0yXRt3qnCjEZccjfIMrjVS0mqSgHtJrepLUsUbL91JZ14iwOPqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743453493; c=relaxed/simple;
	bh=faEQpI/kUgavcUfM/vKfrbWIaIoBZu+s1HOkg+FvUJ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dIXxra7JmmDXIK9F79TwfNHqF93NJOVllpt2lqCfRzoS3Rln6+Nn9cULyg1gtYacEXSYNSKVkPaEomiaq2N6Uj3UlqfbDLIX9Lo6gnrQMcoblKQhgPtgbTOGRGwpLQzxL0YldhULC4cNkIkP+f2mJrPOQzCo1PwEwcLl4DnoFHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=EpCA6Ff/; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1743453483; x=1744058283; i=wahrenst@gmx.net;
	bh=faEQpI/kUgavcUfM/vKfrbWIaIoBZu+s1HOkg+FvUJ4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=EpCA6Ff/wlIu7BGOO2MmF1hoJQSuZYVogRNJzT03srpJnYSjPVyXMFfcUSLjuTx9
	 fYfMXe1N4mZIkeTKUS5wZiinm/WuPw6LfTfGPEbKs9SjDrSPvwF1UJpUIcmgPQAEU
	 ZLive1qn3BaceoPtfMLJbvJsUZKWgG3m3sHwBjNb3p6Izcyx2Di6u1YpzncBQLmcw
	 /S0OGs8N9qB0qfgRMj557BV3k2yKMTkd/QpBf4gOp8EHFyrYS7FW8mlZQPCSVeBVb
	 CCtHxi6JZJyhINYVS9ZUKegJ5+yCYsdOIiiiLvA2kRZu2z+sxdz4tfJGXd4A7zUJx
	 eRRfcu9gC59r8O85GA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.107] ([37.4.251.153]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MKKZ3-1tgIXU0Dfj-00VL4h; Mon, 31
 Mar 2025 22:38:03 +0200
Message-ID: <ec703b87-91a4-4ed0-a604-aceb90769ab0@gmx.net>
Date: Mon, 31 Mar 2025 22:38:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] net: mtip: Add support for MTIP imx287 L2 switch
 driver
To: Lukasz Majewski <lukma@denx.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 davem@davemloft.net, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
References: <20250331103116.2223899-1-lukma@denx.de>
 <20250331101036.68afd26a@kernel.org> <20250331211125.79badeaf@wsk>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
Autocrypt: addr=wahrenst@gmx.net; keydata=
 xjMEZ1dOJBYJKwYBBAHaRw8BAQdA7H2MMG3q8FV7kAPko5vOAeaa4UA1I0hMgga1j5iYTTvN
 IFN0ZWZhbiBXYWhyZW4gPHdhaHJlbnN0QGdteC5uZXQ+wo8EExYIADcWIQT3FXg+ApsOhPDN
 NNFuwvLLwiAwigUCZ1dOJAUJB4TOAAIbAwQLCQgHBRUICQoLBRYCAwEAAAoJEG7C8svCIDCK
 JQ4BAP4Y9uuHAxbAhHSQf6UZ+hl5BDznsZVBJvH8cZe2dSZ6AQCNgoc1Lxw1tvPscuC1Jd1C
 TZomrGfQI47OiiJ3vGktBc44BGdXTiQSCisGAQQBl1UBBQEBB0B5M0B2E2XxySUQhU6emMYx
 f5QR/BrEK0hs3bLT6Hb9WgMBCAfCfgQYFggAJhYhBPcVeD4Cmw6E8M000W7C8svCIDCKBQJn
 V04kBQkHhM4AAhsMAAoJEG7C8svCIDCKJxoA/i+kqD5bphZEucrJHw77ujnOQbiKY2rLb0pE
 aHMQoiECAQDVbj827W1Yai/0XEABIr8Ci6a+/qZ8Vz6MZzL5GJosAA==
In-Reply-To: <20250331211125.79badeaf@wsk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dgI0WJcveiwL0III6/r1XIyx88Q8VvQ7iW8NB+tR/kmiMduWoRb
 Ji0LlikLFSVasL7m71EUk16KPv4HwLoc2Eu6Adof+IkHGzekSDUAssU6Sx9XglUElKz+N+u
 d3r7l8lbxpS77l9yvcOPfUhkoShGvemK4EL3fi2GpG46aYxBjIORiG7bCXELzse9TiHgC3X
 CRrFIKUudSQeRBPhzxQJA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1vEJLmMJw3c=;RJVu6l0Wh7H4BJnIy1BRNgz2DcO
 L/e4Jo6mETB1+kVRE2JuwiJ5xYmblTOdufsKu6QxTGI4GKr1iC0TKwmlL2kVyRDzRc9I/7M8B
 Sj0aTA0765rxRER9Fden/jY50Dy8tCY0hYRIFz7pmIzXWWKoQYYDjIbXy1uUMJr0JcNZQqs0b
 C38LwIXhEgg2BMSXSNFp6TfABsiw66zVYQoMboxoCmzSak1G5kLIsW8k2sFAP4bGUJmb76arF
 6UlLO6g7J18mFcdIF5ZFsVZlmN9HysB0f6YEoLb7HZwQOovGbNncLnItzTegon5Jnkm5ekzQd
 t2Eaer/OO6A3oVe8zWLMUsbIChI0Ym8WIrByfc+h0MYe+ajab/HmNoD/TPPRN/BquiRW9zlxG
 Rjmd0c/2ewP2/9N4o/Y1J/z7wTvkNRTglA82EbS+sBJGiROqsysGdpQ8nXSag7pCMGVthIEed
 1ZOAgvFgEQi8YG2qdSZmWKQA8dF5lZRJc/NT3Xqgq7KL7t4rnQ6xE8pqzEw/TFiV/S40Jl3z7
 rWCmPMJPJIVmnvKThY67lT50cBFGTgXseFy2/a1OtEXRXWh7uHwtx8elDmrLGmnRGeC96utjx
 8nxHL7v2S4cQs/MUqfoP+USHJgsmaih7srDH/A6VtsxADW2tCZWq4ewurNeA9bNuNCziH1cTT
 fC9Yuv/4HMbEn1Tr+CEmWgDZ/Cdf8sRgnXkl9A5ABfxl3D3h52UIrCCz4DEO3zi1k5I/f4ge0
 WlvPIiHeX9E+wURPmu0pZaClrX0dF3sPUQFopeKbu0QTzdOXQyA8jVz/GJIlxbvMOESwyS+Ti
 CNFv/AImWUewgKk+SHXmGeiHk7bLM9DatIaPL7t5rGQZIdIvv5FhnufkgOLEMkZJ8YJ+NyG9c
 9/M2B7iL9og41dSo1PUvHYwcQZOPwZf2AZ8MgTpbDH5MqUPLbXpSZ7+LvpgjT3oxE1eXkPR6S
 gcWVU+didxq7p8S/zh26v1Qg1AVo8gy8v2To1HeJ2DrDUzT2UT84ZtvwTGbzzk3q0aKV+VlAn
 tYFRrfPHh0ut8B0+xUJRxBTgjoZ6TchgeJfUu8ICMkqJ3sUVI0E56cmPHM5xeD2QdLur5l1nT
 5c2kd2FcHbwBkm71g2/yAGgT18WIY3o1HLoxz7B9Y6EGvpLr/LYby7aZ9CCaZJwKpVY9+DW1A
 Tr3s8n+lt6zyMd6sBVDGT04IAi9jkd/Yzc4Jkv/k8a++SSSAiKrMasQr2nY/b6v9IlvbhwoY6
 waOF0HmIJNkQfaZdzzZtKHEMG5t+M3YHYEM2ryuzUzEmt3CuRdtzgPXM2BeLgP1aHl/VG8oyL
 XeqWX2GNVPBtjPBQ2UqKaSjFMuXPMyA0Y7jR5EA44/PvJxGcgK348HExOtnVSGVY2MLv2paNs
 yFcgxhRuFy+p8QcPb3yBAZ9nSaD9TLW6Fy34ps5taVLMCJ7aAnryTRqdJ0Ptjet8f+iVzBpuY
 gHSLuVnn054jRFfNgxmrcOhctpzQ=

Hi Lukasz,

Am 31.03.25 um 21:11 schrieb Lukasz Majewski:
> Hi Jakub,
>
>> On Mon, 31 Mar 2025 12:31:12 +0200 Lukasz Majewski wrote:
>>> This patch series adds support for More Than IP's L2 switch driver
>>> embedded in some NXP's SoCs. This one has been tested on imx287,
>>> but is also available in the vf610.
>> Lukasz, please post with RFC in the subject tags during the merge
>> window. As I already said net-next is closed.
> Ach, Ok.
>
> I hope, that we will finish all reviews till 07.04, so v4 would be the
> final version.
well i appreciate your work on this driver, but this is not how it's
going to work. No version of this patch series had a review time of a
week. It's about quality not about deadlines.

Regards

