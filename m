Return-Path: <netdev+bounces-150215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C25EA9E97C0
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 14:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35C41283B30
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 13:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221741BEF70;
	Mon,  9 Dec 2024 13:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="5oLRwrON"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A2C1A23AB
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 13:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733752055; cv=none; b=j+u12bvfyxR6Phbvc+g25K3TeBMStY8dM64T1/qB7mvIXbFAkO3QzAZJxCM3SjPQHISnjwI5t3g+p9MhckLtK3NtJbi4Ew0bc5RopOf6hmgblxUzcmXWyhxQszmNuFa1rcMihUl405dUlsdiFlpmn2fmStLBr754qF0OwmQFQTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733752055; c=relaxed/simple;
	bh=buWA/Rt11YUzIdXYFe5tZNIknGECsO0xRl3MuIYNkHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hG3XjQQws9iJSXlmb9rtv02s2avDNsjZbcBDlPAC/pt2KS3RcivQmZGU4JRD10HMKLKDwLY9KkrqlvQR8VwfgIB0xlPIhlJu7jzc/mVJ50cHQ+6OFNwNQdZp4YH3PQ3hUJxqPxjLbRJK8H2UvzOdaRNR96apz/SQxZg1QTOb4Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=5oLRwrON; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=2Z4oKFPcJEVWOAYs/Ig3hJD+BqIGnKDqJ44esXhRlq0=; b=5oLRwrONt1ziCitjxy7kOZWaxp
	JQyQmgYyoZ6WOrvgh0IiaKMUt6deud9TgC/HcROSuUWQzAa2pPmbVxHwzSORvPbykkrn+E+FCy5Hd
	7vm0PkIpu3M6cFnDNI3iJBFc1yotVOoH2Xyw8pU6HQqkm4jBLw/9hbhR/JhPfK1QAiWc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tKe6k-00Fftm-DA; Mon, 09 Dec 2024 14:47:30 +0100
Date: Mon, 9 Dec 2024 14:47:30 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Tian Xin <tianx@yunsilicon.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, weihg@yunsilicon.com
Subject: Re: [PATCH 09/16] net-next/yunsilicon: Init net device
Message-ID: <902c3782-b562-457c-a610-91e4e53e2a19@lunn.ch>
References: <20241209071101.3392590-10-tianx@yunsilicon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209071101.3392590-10-tianx@yunsilicon.com>

> +#define SW_MIN_MTU		64
> +#define SW_DEFAULT_MTU		1500
> +#define SW_MAX_MTU		9600

There are standard #defines for these. Please use them.

> +#define XSC_ETH_HW_MTU_SEND	9800		/*need to obtain from hardware*/
> +#define XSC_ETH_HW_MTU_RECV	9800		/*need to obtain from hardware*/
> +#define XSC_SW2HW_MTU(mtu)	((mtu) + 14 + 4)
> +#define XSC_SW2HW_FRAG_SIZE(mtu)	((mtu) + 14 + 8 + 4 + XSC_PPH_HEAD_LEN)
> +#define XSC_SW2HW_RX_PKT_LEN(mtu)	((mtu) + 14 + 256)

Please try to replace these magic numbers with #defines. Is 14 the
Ethernet header?  ETH_HLEN? 

	Andrew

