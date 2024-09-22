Return-Path: <netdev+bounces-129181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB2397E243
	for <lists+netdev@lfdr.de>; Sun, 22 Sep 2024 17:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A51AF28116C
	for <lists+netdev@lfdr.de>; Sun, 22 Sep 2024 15:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9229AC2E3;
	Sun, 22 Sep 2024 15:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2Bbqu26y"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEA38827
	for <netdev@vger.kernel.org>; Sun, 22 Sep 2024 15:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727018413; cv=none; b=cdSRLjTV9ygtmArvnqFk0qojL2CYtuS3fz//n+GwQWxtdFDcRnk9iAkZpZIFsOfhEx3dFWJ1QCl/DQGXq0n/q8yT1B/z7SGOdF2cXA2fVoC84k/BVpb/9wslROGwInNSsgXFGtVQpcS1ceVaABgkUSqR++8WcM7xWvQJNXwa5ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727018413; c=relaxed/simple;
	bh=o0ScQZIUUxsECSf/U2/M+/A3lwmk2RKZBJj4Nb/C0kg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AmmlnUETMO0OTdpsUDHJ4e96tKgx60d9I86NLZJJxbk4vek9IR5FZqH6D07OJPXfYiKg6SN2CV2LBkFJSZ6udWEZ6CFt8/DB6qV/pBQUq2r9Z0nC6h3G1aslzeWeU2UrItZ+2SMI/dmQ7Z2UTZOw0QrckW6dslzeP3epQYwAw80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2Bbqu26y; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=RKPNUg1AKoEdIsIj8OWswVbGOXQJ8EVP6rMw6ECb8Q8=; b=2Bbqu26ypx7mXelVBExInNt8mg
	nPZJcWw+fXwwd31P0I2PptwZL0ivNvZMMbsTtDoRLJpXGH2o3zC2mfolRtTnMSDeN4IC+OzfN4QIO
	HyWrvDSzYiBiE/iLQpOkEqZ2VnCIhgYrOw84+qLbVFhpuAEw5B47mmO28aTGU07sP4lw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ssONV-0084B0-TV; Sun, 22 Sep 2024 17:20:01 +0200
Date: Sun, 22 Sep 2024 17:20:01 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Shenghao Yang <me@shenghaoyang.info>
Cc: netdev@vger.kernel.org, f.fainelli@gmail.com, olteanv@gmail.com,
	pavana.sharma@digi.com, ashkan.boldaji@digi.com, kabel@kernel.org
Subject: Re: [RFC PATCH] net: dsa: mv88e6xxx: correct CC scale factor for
 88E6393X
Message-ID: <d02afff9-7df1-4b68-95a9-f19f2d1d639a@lunn.ch>
References: <b940ddf9-745f-4f2a-a29e-d6efe64de9a8@shenghaoyang.info>
 <d6622575-bf1b-445a-b08f-2739e3642aae@lunn.ch>
 <890714d7-bc6a-45b2-854b-d1b431f8a0eb@shenghaoyang.info>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <890714d7-bc6a-45b2-854b-d1b431f8a0eb@shenghaoyang.info>

> Would you happen to know if that register is valid for all the
> families currently supported? 

6352 has it, 6320 also has it. So it seems to be common to all
implementations.

> If that sounds reasonable I'll send them for net - would you also be
> okay with a Suggested-By?

Yes, that is fine.

	Andrew

