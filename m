Return-Path: <netdev+bounces-146920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA339D6C42
	for <lists+netdev@lfdr.de>; Sun, 24 Nov 2024 00:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 779D4B21284
	for <lists+netdev@lfdr.de>; Sat, 23 Nov 2024 23:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818CC198E7B;
	Sat, 23 Nov 2024 23:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pen.gy header.i=@pen.gy header.b="W2gT9Kr6"
X-Original-To: netdev@vger.kernel.org
Received: from ci74p00im-qukt09081702.me.com (ci74p00im-qukt09081702.me.com [17.57.156.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE032309A9
	for <netdev@vger.kernel.org>; Sat, 23 Nov 2024 23:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.57.156.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732405737; cv=none; b=AUP35Orrs7dOw3jUUTAkZydv9NPkQ8Vs6jkMWa4nNNhgU6DUJXCLQ54QPfJzVoBNvNCr7il71zpFCPxRh6d+4FQypX0QJc0+MNx04H2Pv+uckl0nktJiAsq1QUxE8FKCLVCEHnU1P756oFstdXVgp1BzCqLEa1h5BwG+H/gM9wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732405737; c=relaxed/simple;
	bh=vSQV+/6AcGbpdVdJuogQvs9SKIfTiqWVXooVwop6kls=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:Content-Type; b=FPaDEvPB4n2gEcfwL65fotZ2rg4tMWNo606YeekweCZ7HKNnoSVd+W7ckNQaTQQUCF0CyVcu8tZuIJx4VW5NGCRsrMxSiMS1xXBXZQl3MFDEAxS0IbW+YSLrijDKDp+I5BXKf7fkQC2Eubtfos/JoXm/+M+14O2uu7pvADIHCh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pen.gy; spf=pass smtp.mailfrom=pen.gy; dkim=pass (2048-bit key) header.d=pen.gy header.i=@pen.gy header.b=W2gT9Kr6; arc=none smtp.client-ip=17.57.156.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pen.gy
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pen.gy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pen.gy; s=sig1;
	t=1732405734; bh=jJm8KXrM77W3wmhhCk4DVMm0FGYOcYIEqdy+y350Cwc=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type:
	 x-icloud-hme;
	b=W2gT9Kr6jAHZpAvXOXfPtFUxx5Cgb3Qyg5CNl3YT5pEdP/zELR/XLAJOt3fbtybVG
	 Fm9x2ZSlzrV/qd3g7AdBLK+Zs3U1/R0hrc92HB5MYrZPW5z7jQN7Qjn3MzgiN+2wTB
	 6feZYsH8FdjWwEck4+ahNS1H1Yw+wEaNJZOo7zHA7Dfyon6YHs/e/6pJH1vjJ9sOPp
	 x19CV9EedyZypANwEhNRfKuywPCMvRpILYKdcRIHpH/+XIkuLY8Kp5N2e/+wk5sUzy
	 1FUUT32tvzoAfFjXrub1mlqW3tYV70Tfi1zRsMOn33ccTNnQ6d+5UsOu/YuEcNnVE3
	 dBxCElxAuhyBA==
Received: from [192.168.40.217] (ci77p00im-dlb-asmtp-mailmevip.me.com [17.57.156.26])
	by ci74p00im-qukt09081702.me.com (Postfix) with ESMTPSA id A21A63BC05A7;
	Sat, 23 Nov 2024 23:48:51 +0000 (UTC)
Message-ID: <b815626a-6190-4746-824f-089952b733ba@pen.gy>
Date: Sun, 24 Nov 2024 00:48:48 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
To: Paolo Abeni <pabeni@redhat.com>
Cc: Georgi Valkov <gvalkov@gmail.com>, Simon Horman <horms@kernel.org>,
 Oliver Neukum <oneukum@suse.com>, netdev@vger.kernel.org,
 linux-usb@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
References: <20240912211817.1707844-1-forst@pen.gy>
 <vSvb6XcNhy1ZYogJpYDvryDWNVzCeaJlQ9vxV62ypbgpPPpEjdIxBnqHOM4j-Jxl3MSfkc94xRCv0808FN5cLA==@protonmail.internalid>
 <fa3b39c4-8509-49ca-91cf-1536059b79d5@redhat.com>
Content-Language: en-GB
From: Foster Snowhill <forst@pen.gy>
Autocrypt: addr=forst@pen.gy; keydata=
 xjMEYB86GRYJKwYBBAHaRw8BAQdAx9dMHkOUP+X9nop8IPJ1RNiEzf20Tw4HQCV4bFSITB7N
 G2ZvcnN0QHBlbi5neSA8Zm9yc3RAcGVuLmd5PsKPBBAWCgAgBQJgHzoZBgsJBwgDAgQVCAoC
 BBYCAQACGQECGwMCHgEAIQkQfZTG0T8MQtgWIQTYzKaDAhzR7WvpGD59lMbRPwxC2EQWAP9M
 XyO82yS1VO/DWKLlwOH4I87JE1wyUoNuYSLdATuWvwD8DRbeVIaCiSPZtnwDKmqMLC5sAddw
 1kDc4FtMJ5R88w7OOARgHzoZEgorBgEEAZdVAQUBAQdARX7DpC/YwQVQLTUGBaN0QuMwx9/W
 0WFYWmLGrrm6CioDAQgHwngEGBYIAAkFAmAfOhkCGwwAIQkQfZTG0T8MQtgWIQTYzKaDAhzR
 7WvpGD59lMbRPwxC2BqxAQDWMSnhYyJTji9Twic7n+vnady9mQIy3hdB8Dy1yDj0MgEA0DZf
 OsjaMQ1hmGPmss4e3lOGsmfmJ49io6ornUzJTQ0=
Subject: Re: [PATCH net-next v2] usbnet: ipheth: prevent OoB reads of NDP16
In-Reply-To: <fa3b39c4-8509-49ca-91cf-1536059b79d5@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: CVgHIaUydYtUd1W2rZnQaiCkE8TrpBgk
X-Proofpoint-ORIG-GUID: CVgHIaUydYtUd1W2rZnQaiCkE8TrpBgk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-23_19,2024-11-21_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=432 suspectscore=0
 phishscore=0 spamscore=0 bulkscore=0 malwarescore=0 adultscore=0
 mlxscore=0 clxscore=1030 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2411230197

Hello Paolo,

Apologies for the delay. Very much appreciate the feedback! I've actually
been working on and off on v3 based on your suggestions since I got your
e-mail, but I wasn't happy with how I initially split the changes, put it
in the drawer, blinked my eyes once and two months have passed, oops.

On 2024-09-19 10:05, Paolo Abeni wrote:
> This indeed looks like a fix. I suggest to post it for the net tree
> including a suitable fixes tag.

Ack, will submit v3 shortly for the net tree.

> Additionally since it looks like the patch addressed several issues, it
> would be probably better to split it in a small series, each patch
> addressing a single issue - and each patch with it's own fixed tag.

Agreed, v3 will be split into smaller atomic changes to the best of
my ability.

Thank you!

-- 
Best regards,
Foster

