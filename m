Return-Path: <netdev+bounces-176501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C41A6A932
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 15:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF666189DB3D
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 14:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450F01DF25C;
	Thu, 20 Mar 2025 14:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="H6+jpIUM"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00A23594B
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 14:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742482135; cv=none; b=bZGKwF4TsWrYujnexDjfTcHdG9PeYytUE74uXXChoCWs4MeNsIAHSr3RR8CdLTw1o5bSANNp6rjw7bsM4CnmY+f+IZKn/zoyyPDW2C6etXs/RxNrE9mA1KKL9dlCkZ1Yu0ptP6lcNFM9HCE65ckOiJs4I8DzVWiv/Z1fpFVUb1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742482135; c=relaxed/simple;
	bh=+4kPbbjvV6rDXsDSzMzTyp2Sh0b64f/AhsG5op57k/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R4PIm3UOYkiqAt8WrlT27U1eUXqqv+fb1LuLvvsgAa6Jo6fnTLnQuP1tb0Dlo4ViZ/1RQ1xX2TPzLPh2iRFV+Oz1UVXsFfjwXbRhj95i0HYlN4bfey9fn3kOQLq9abZ7xaJ2LM0SSCN15Aqh+WDILL4tAz1HuXYVUk0G1Bzsc6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=H6+jpIUM; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=pMbFCcPtCjAfomdlcgLmFe4GD9FK21pPCdV92hW/w98=; b=H6+jpIUMaERhVNQWljoqCxX7HB
	JyO6C/GTl6D4qaeSZnyORP8v56K2GcAg0wi2/oVu6G/lstTSvkWv1rvMu1i/KFGaq/BN7JlZF8U9u
	lTlLLbrC1qDHH8nHhyIDBewWYXeLDoXf5c6h89X8VOGRq4L9oOsWzzZBzgASDo18Dk/M=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tvHCV-006UG2-8Y; Thu, 20 Mar 2025 15:48:51 +0100
Date: Thu, 20 Mar 2025 15:48:51 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Kamil Zaripov <zaripov-kamil@avride.ai>
Cc: netdev@vger.kernel.org
Subject: Re: bnxt_en: Incorrect tx timestamp report
Message-ID: <6c63cb1a-ba98-47d8-a06a-e8bacf32f45a@lunn.ch>
References: <DE1DD9A1-3BB2-4AFB-AE3B-9389D3054875@avride.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DE1DD9A1-3BB2-4AFB-AE3B-9389D3054875@avride.ai>

> 2. Is there a method available to read the complete 64-bit PHC
> counter to mitigate the observed problem of 2^48-nanosecond time
> jumps?

The usual workaround is to read the upper part, the lower part, and
the upper part again. If you get two different values for the upper
part, do it all again, until you get consistent values.

Look around other PTP drivers, there is probably code you can
copy/paste.

	Andrew

