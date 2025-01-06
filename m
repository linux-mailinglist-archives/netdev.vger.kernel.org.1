Return-Path: <netdev+bounces-155308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 026E4A01CF4
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 02:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57FB81622B5
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 01:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6651798F;
	Mon,  6 Jan 2025 01:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="F4a8IpZX"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101BC29A5;
	Mon,  6 Jan 2025 01:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736125561; cv=none; b=FxEnA+OB5ON9WvN/9pXEZ8wgIl4VCOd2FLGvhHJnYV8BSvyCmI9D68OLtYlXcDYDssI5htNRaMimZ8wi25TRn56LPB2NyqWh23yn+oyLOKbGvd/Sk6IQK0fyVJbEEB+TocRu0EPRyb6nCM7Rvyfe/Wh36fiJZd72scqhacwDXQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736125561; c=relaxed/simple;
	bh=3blgBORgK4NdYFGTz9Ri+gK5/9gA5YNNqV7GzL4pbSE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c2cGdpskSpv/KYLHPdHdCjfIZefDDyebCh8QNkijOoJJ/q39GV6iAYZupe3olJ2ythmrTEtiH0UdizkF3j7nbF76zeS3+czR4vVU82k7mYU8831F38NYVhIRM4Q58E+twdx7V7b83oBuCajeddv+aJcQSrnmVXyozwMtPwM8hTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=F4a8IpZX; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1736125550;
	bh=3blgBORgK4NdYFGTz9Ri+gK5/9gA5YNNqV7GzL4pbSE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=F4a8IpZX7p3nob6WLeVLKhUtmdlFQTOJybkWf6EE3pUHKwdAPq4dJxaK8lk2rAmDX
	 d491pu/91cUSuzDIfR76OulTYLfVMGzS/WsKS+ZFDN6Rrs4qovgLl/sa/JuDHsVxSx
	 EY4gADlVeabD0QmiFjEXeoZzRQl8AhWbk9pCDfY/tC2kR8FnyLqf/UHNRcv3DK/B4U
	 z4+k5kh/527kBnbCG94F/hSHmXetW56jhYsmkRb7GbZ6+1VE4NNwk1UEGfsHFE0W7D
	 CP3AHmVqxRLXzfBEO1tFhnY/UwKkVzGnNd56lcWTNprIY1bP6Z9inlTjjF5/vEziR+
	 pt6F/UV0Lj02w==
Received: from [192.168.72.171] (210-10-213-150.per.static-ipl.aapt.com.au [210.10.213.150])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 15DF9707E6;
	Mon,  6 Jan 2025 09:05:48 +0800 (AWST)
Message-ID: <e4c5b40a906a560f9a333d8e9d7c556ad99d63fa.camel@codeconstruct.com.au>
Subject: Re: [PATCH v11 0/1] MCTP Over PCC Transport
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: admiyo@os.amperecomputing.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Matt Johnston
 <matt@codeconstruct.com.au>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>,  Sudeep Holla <sudeep.holla@arm.com>, Jonathan
 Cameron <Jonathan.Cameron@huawei.com>, Huisong Li <lihuisong@huawei.com>
Date: Mon, 06 Jan 2025 09:05:48 +0800
In-Reply-To: <20250104035430.625147-1-admiyo@os.amperecomputing.com>
References: <20250104035430.625147-1-admiyo@os.amperecomputing.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Adam,
> Changes in V11:
> - Switch Big Endian data types to machine local for PCC header

This seems suspicious; the concept of "machine local" may not be
consistent between channel endpoints (ie, system firmware and this
driver). Looking at DSP0292, and the PCC channel spec, it looks like
these should be explicitly little-endian, no?

The warnings you were seeing in v10 seemed to be an issue of direct
accesses to the __be32 types in struct mctp_pcc_hdr - ie., without
be32_to_cpu() accessors. If you keep the endian-annotated types (but
__le32 instead), and use the appropriate le32_to_cpu() accessors, that
should address those warnings, while keeping the driver endian-safe.

Cheers,


Jeremy


