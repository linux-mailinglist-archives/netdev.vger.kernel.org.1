Return-Path: <netdev+bounces-154613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DAD49FECEF
	for <lists+netdev@lfdr.de>; Tue, 31 Dec 2024 06:12:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 329CD18828A4
	for <lists+netdev@lfdr.de>; Tue, 31 Dec 2024 05:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18AEA1552FC;
	Tue, 31 Dec 2024 05:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Zzrv5ZoK"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677FB7BAEC
	for <netdev@vger.kernel.org>; Tue, 31 Dec 2024 05:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735621963; cv=none; b=T7I7LqfaZtlWjEShAhazm44PttE53vFFgiVJ9MUThD/3u3cNALwswQUcFT4khkX/Ujpn3GLEyaEoLKnneCoO5t1pscKoGjCZCZHxCAiC+eteTVUEy12edQPKqE5pf6cellOwQeKhgFRzip5uTOgnLYKidcBXgJP+nBnrkyld4cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735621963; c=relaxed/simple;
	bh=OG+8rnVRHUnPJieyCGSaZN1vUkEAzxUgV2J11RnbZQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=npc9ZKcGYRkXczhwyn3pDjI5EK+szstZtX6Ur6VHEmFQ6VwOJVQORXKB+7F3czjNzXAPWg0eQT8BS5zh09kdcTs1IJmumQ2KGqo6cggCfisegyrEVE8CvAOo4Q2ZGvlzkRbTnpAg7u8+8IZfjyVGm8cwH/fQRthdAPKqbmBySxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Zzrv5ZoK; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Q0ZIqMZY0wfyN+F9VA4jUQEJ3LjOeicd4IrJiucmRS0=; b=Zzrv5ZoKtEzacxoDDge0BdnWBb
	iWbGLFZ/44brvY48hDidYaUd0DURpoU+6wiZgN3LLUECPmPm/LOZDe27oIp690qifHxti9geXxvAA
	mQ1B0cVFcuC+TxKFaHw5V5R9gGK3V4gaJv9BLFx8Rh/3jxN9RZ1N7ldkDexRjuAWon4M=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tSUYU-0008TI-4f; Tue, 31 Dec 2024 06:12:34 +0100
Date: Tue, 31 Dec 2024 06:12:34 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: weihonggang <weihg@yunsilicon.com>
Cc: Xin Tian <tianx@yunsilicon.com>, netdev@vger.kernel.org,
	andrew+netdev@lunn.ch, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, davem@davemloft.net,
	jeff.johnson@oss.qualcomm.com, przemyslaw.kitszel@intel.com,
	wanry@yunsilicon.com
Subject: Re: [PATCH v2 08/14] net-next/yunsilicon: Add ethernet interface
Message-ID: <45dfc294-76d8-4482-b857-4e3093ac829d@lunn.ch>
References: <20241230101513.3836531-1-tianx@yunsilicon.com>
 <20241230101528.3836531-9-tianx@yunsilicon.com>
 <9409fd96-6266-4d8a-b8e9-cc274777cd2c@lunn.ch>
 <98a2deaf-5403-4f85-a353-00bfe12f5b13@yunsilicon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98a2deaf-5403-4f85-a353-00bfe12f5b13@yunsilicon.com>

On Tue, Dec 31, 2024 at 12:13:23AM +0800, weihonggang wrote:
> Andrew, In another module(xsc_pci), we check xdev_netdev is NULL or not 
> to see whether network module(xsc_eth) is loaded. we do not care about 
> the real type,and we do not want to include the related header files in 
> other modules. so we use the void type.

Please don't top post.

If all you care about is if the module is loaded, turn it into a bool,
and set it true.

	Andrew

