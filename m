Return-Path: <netdev+bounces-63933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E1C830386
	for <lists+netdev@lfdr.de>; Wed, 17 Jan 2024 11:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0495BB246FC
	for <lists+netdev@lfdr.de>; Wed, 17 Jan 2024 10:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1336F14ABC;
	Wed, 17 Jan 2024 10:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="pDQ2Ss0j"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F63414A8E
	for <netdev@vger.kernel.org>; Wed, 17 Jan 2024 10:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705487176; cv=none; b=YzM5Li5JMtzqn8+CVO/sV6ZV4NvPCJCFI+lwruHtz7prRDp6TqkpeC3pP2xyUpfK0R93+8QS+Ug3jF9CdXgROIdF3AxxPJTxMLs/AgWkoUZz3wBAPniGH2LxE/kzVDcGY0CCPplydOP7Cq4EdV4S3FmkpHJ7Hz6XOpQ8UkkiBPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705487176; c=relaxed/simple;
	bh=+KTds+GEaJqq6AhV6JjbTXIZ6Fyyr7D7+aNihDghOJc=;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-GND-Sasl; b=J7qqo26J8kI1+Db6Wo4C6RnDV/vAdlra9trzy80SqmYT0gGJSgux2feaVmEJqWLAD3wo+u37ry22FvKO3imi5JwFMXOU9jCpujFwQj5ciGdfDlDtVAlI6YGTuHyrossQthinzAHyTDzhh0HQIbnpfexzqAn9ZtJIl5DBJNKM01U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=pDQ2Ss0j; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id EA2A020012;
	Wed, 17 Jan 2024 10:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1705487166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+KTds+GEaJqq6AhV6JjbTXIZ6Fyyr7D7+aNihDghOJc=;
	b=pDQ2Ss0jelTiX1oayF+Ry5tzg+DuLo9touC2nq2eDAqieYGWYL5t3eWtdqJPzcgNo1Dn6C
	mIc0YrKRUKS+n1ERzlAzmWcCBVCNSzBYVvon6THsWwwKmvfe2IUaxTcAelF/w8DzUBsSE3
	Ye34zJjBSiO5ywGs9kWPwgT9m/lilt9L3zaLxmGz4yRIj7kGdygNOadMq3daJsSw2UbmgR
	LabXTnwrJ/GEjqGYVaEa+5TOu6sMxm5pxfmt3H9hTdT2IfbsrwPqdue5UzkXO5uRROgvXn
	QPxQhPCHJEiqDobr3PA6RpRZQytEkLsHdBw8nhkC9zRnzicxAqdQT4OjMyptww==
Message-ID: <9183aa21-6efb-4e90-96f8-bc1fedf5ceab@arinc9.com>
Date: Wed, 17 Jan 2024 13:25:58 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 0/8] net: dsa: realtek: variants to drivers,
 interfaces to a common module
Content-Language: en-US
To: Vladimir Oltean <olteanv@gmail.com>,
 Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: netdev@vger.kernel.org, linus.walleij@linaro.org, alsi@bang-olufsen.dk,
 andrew@lunn.ch, f.fainelli@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
References: <20231223005253.17891-1-luizluca@gmail.com>
 <20240115215432.o3mfcyyfhooxbvt5@skbuf>
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20240115215432.o3mfcyyfhooxbvt5@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 16.01.2024 00:54, Vladimir Oltean wrote:
> git format-patch --cover-letter generates a nice patch series overview
> with a diffstat and the commit titles, you should include it next time.

Thanks a lot for mentioning this. I didn't know this and now that I use it,
it helps a lot.

Arınç

