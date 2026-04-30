Return-Path: <netdev+bounces-282980-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UPyAMlCv82k/6AEAu9opvQ
	(envelope-from <netdev+bounces-282980-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 21:36:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4B34A76B8
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 21:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 12D603038BB3
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 19:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EAE737A485;
	Thu, 30 Apr 2026 19:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="6NErsiJe"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D5937A4B9
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 19:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777577779; cv=none; b=H7W/JvxhS+z+O3rQrjANz0dXZptRyslskkPm4RXXQHA94FCxGV+GCGTBaJ85g/cGPv56UHOmC5nvBL54hOq21Yccnabr4znWUyHkO0km5zArOaG0421rlTrU5pYB6q5xTASVYC+AKMxEFEiApl8/kmUjHH3qvo0EQ2UucQI/tv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777577779; c=relaxed/simple;
	bh=JC4zp1NQYDnyouMDEkBYIyDzFk/AaWaTUDXhimv7DJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RcEEj4cxIJDFk7m1WWT1dwPLqTmUTVSw8dutJRFCoscoFp1OPpAusOyTrlvp22YwPR2GiPY8BG6P268W19C0iPf1CjLWU8B2UOQ7jS//elYi27tKlTXXuC399t4cgAJPrEGLnqsGf5fVIovdsZqP1ED9SQQw6QfDCFmAv10QRXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=6NErsiJe; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=TcB6knVeRbdJ2RVbYiHhNB2Ipa7/trwSwf5/U6kBm1s=; b=6NErsiJe+B/6i+3xOX/Tk47094
	rVoNVFVdNjE43NVeYVmCQlY0LR5YLTbKW07MnC/uEbc4r1RypnG12043APIRsBMEom7+1O3dvVjy3
	DvLRfgueE/qoO5gOxE4Kv8r1YXBARaHwljNoso5l6XeMGERPEHr9LNlpdfg0ycutmihk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wIXBH-000jO8-EU; Thu, 30 Apr 2026 21:36:15 +0200
Date: Thu, 30 Apr 2026 21:36:15 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Junyang Han <han.junyang@zte.com.cn>
Cc: andrew+netdev@lunn.ch, netdev@vger.kernel.org,
	vadim.fedorenko@linux.dev, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, ran.ming@zte.com.cn,
	han.chengfei@zte.com.cn, zhang.yanze@zte.com.cn
Subject: Re: [PATCH net-next v3 2/3] net/ethernet/zte/dinghai: add logging
 infrastructure
Message-ID: <acca6752-9d18-44ae-be9e-844327419ee8@lunn.ch>
References: <20260430151138.2813381-1-han.junyang@zte.com.cn>
 <20260430151138.2813381-3-han.junyang@zte.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430151138.2813381-3-han.junyang@zte.com.cn>
X-Rspamd-Queue-Id: 1E4B34A76B8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282980-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:dkim,lunn.ch:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

>      ret = pci_enable_device(dev->pdev);
> -    if (ret)
> +    if (ret) {
> +        LOG_ERR(dev, "pci_enable_device failed: %d\n", ret);

I asked that your use dev_err().

  Andrew

