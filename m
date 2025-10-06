Return-Path: <netdev+bounces-227990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58EFEBBEAA9
	for <lists+netdev@lfdr.de>; Mon, 06 Oct 2025 18:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C68473B77D6
	for <lists+netdev@lfdr.de>; Mon,  6 Oct 2025 16:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D737E2DC767;
	Mon,  6 Oct 2025 16:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="B9BKerpi"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369AA13E41A;
	Mon,  6 Oct 2025 16:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759768444; cv=none; b=p99jjvl2GZwpghPRT8t7Wxz592JtqyRhsjsaUcIAKtt77a7SAmNfPJdlnnG9nDLPz1MUVzT2/HTaZOek8KGUs/wXXp4psCYk62rhgKnEMXFRmtDSD6A2Vf7O7eIaqy9xGU6kmT1qH23ofDwkjLPMwuxtN11jwz3P813z6XxbdYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759768444; c=relaxed/simple;
	bh=d9U3GueBLtsdYr3lK9yZSBIxV6nB5Z/kZGKmJo0y290=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VaisJXi3wsehn521WL59rG0r9EqBwiTFzMXvyQ1Ix5d8RxmtC/O3Dg1RrB4AG0O8CiYyK+fwL7xl1s7SqvYmFfVTU+VZ/JhDiw+XCfhOk+IiL0AZSKwFqHj4+IvzGBTjUpYvBaevBGyEPHPVN+ytjTnF/qAgNHZKcmWZ1Q9r3SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=B9BKerpi; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=NjOWEMT4jOc/88MnOLiFa2C7VKCnp395uXbYsA59V4g=; b=B9BKerpi1pLL3wplqKRYWaUEn2
	HJANzseZG7fpK5PxyZmD/83TxeRrcCILmSPKokoGXIIH6cM2u2ib8vIsL6kHhZ6aiKc+SI35zkTGM
	HzWZEJMV81rekAt24HT30cdEPq920UfVQKicBEDp16S/OQhu9GtMs2wIrr/bPijDuz0I=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1v5o9n-00AJDu-Pb; Mon, 06 Oct 2025 18:33:51 +0200
Date: Mon, 6 Oct 2025 18:33:51 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: yicongsrfy@163.com
Cc: oneukum@suse.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, linux-usb@vger.kernel.org,
	marcan@marcan.st, netdev@vger.kernel.org, pabeni@redhat.com,
	yicong@kylinos.cn
Subject: Re: [PATCH v4 1/3] Revert "net: usb: ax88179_178a: Bind only to
 vendor-specific interface"
Message-ID: <3c574f17-cd51-4897-9162-0fd4efb15383@lunn.ch>
References: <5a3b2616-fcfd-483a-81a4-34dd3493a97c@suse.com>
 <20250930080709.3408463-1-yicongsrfy@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250930080709.3408463-1-yicongsrfy@163.com>

On Tue, Sep 30, 2025 at 04:07:07PM +0800, yicongsrfy@163.com wrote:
> From: Yi Cong <yicong@kylinos.cn>
> 
> This reverts commit c67cc4315a8e605ec875bd3a1210a549e3562ddc.
> 
> Currently, in the Linux kernel, USB NIC with ASIX chips use the cdc_ncm
> driver. However, this driver lacks functionality and performs worse than
> the vendor's proprietary driver. In my testing, I have identified the
> following issues:
> 
> 1. The cdc_ncm driver does not support changing the link speed via
>    ethtool because the corresponding callback function is set to NULL.
> 2. The CDC protocol does not support retrieving the network duplex status.
> 3. In TCP_RR and UDP_RR tests, the performance of the cdc_ncm driver
>    is significantly lower than that of the vendor's driver:
> Average of three netperf runs: `netperf -t {TCP/UDP_RR} -H serverIP -l 120`
> - cdc_ncm.ko: TCP_RR: 740, UDP_RR: 750
> - ax88179_178a.ko: TCP_RR: 8900, UDP_RR: 9200
> 
> Issues related to the vendor's driver ax88179_178a.ko will be addressed
> in the next patch.

It looks like there was a lot of discussion somewhere else, because
this patchset jumps from v1 to v4. Please don't change the email
distribution like this.

Also, please start a new thread for each version of the patchset.

      Andrew

