Return-Path: <netdev+bounces-242918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F28C965B4
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 10:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 22D5D4E05C8
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 09:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4072E3B0D;
	Mon,  1 Dec 2025 09:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="g4hdLCiL"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AB42BE02B
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 09:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764580887; cv=none; b=ncwN61BESuxmb0XD1M7dl46HC1ZNUdXZVqp/00226xg2NiQsWvQPvVjTAfP4AHksKO689ZdHXNFDp1s7qcvj10YdIkMmlhlzrntYZiKZcr92RAuN49f1300J9WlhoPl8w7rAVbHevXu8iIaMxw9WLLr9ujGqHZ5WdGlv7dRhQZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764580887; c=relaxed/simple;
	bh=CTVy3s/Xt0eylaFoqObBDMUaU4xkriYRcRfCbi41sy4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SgmQMh91USVOHPDJaNSmU0gIPspXUtkDHtAPeSPBHdatOM9MtiRQ9EzxC/rMJOda6gpDBgIrZi4Xo/oJD6k9d1qcqwd/InT77+O1+n5dsQRXzPbvn+vTrb1Wni4oPP9ZivksTNWqdtj9ozS/ktNjsx7dsj9zCmGx+XI37njMoIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=g4hdLCiL; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 5535520518;
	Mon,  1 Dec 2025 10:21:23 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KAKbp6wgWgPv; Mon,  1 Dec 2025 10:21:22 +0100 (CET)
Received: from EXCH-01.secunet.de (unknown [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id CAADF2050A;
	Mon,  1 Dec 2025 10:21:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com CAADF2050A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1764580882;
	bh=6PLAA5NNOLaIMgHJUEUQKxKjfjO5R+TA0N8seXJUBjc=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=g4hdLCiLm7wk04DFP3a2of2kZxLBC+wYbPk2aqjKJj7JH7m2gNn4MYrgdNfUtlNQZ
	 WEeu4Qyeb3oLxB6IPDDNmwIhJdlT99yjrL6USJywunrsRVzFYtARyceMVPJgZOqG3a
	 ZK/YmOC+0EGF9HShVD84rU1SLqMeXamgv5VxCOMHdMqG+Vu8TQ0LXOtPWpIU2nVf6A
	 5HBqQzTQhFG8t5sH77vyLt2fZM8PKkeaObrzFBEUEWgY3VrGH6eZWQ24cEHVkiRLRT
	 +EfFF7VAus6I5UUDTpee1BsKZMBnU4puymhUSxInADf493kgo/2xW6IQuggrl+DDsk
	 qMTSszkE3/Sxg==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 1 Dec
 2025 10:21:22 +0100
Received: (nullmailer pid 1138057 invoked by uid 1000);
	Mon, 01 Dec 2025 09:21:21 -0000
Date: Mon, 1 Dec 2025 10:21:21 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Antony Antony <antony.antony@secunet.com>
CC: Herbert Xu <herbert@gondor.apana.org.au>, <netdev@vger.kernel.org>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<devel@linux-ipsec.org>
Subject: Re: [PATCH RFC ipsec-next 1/5] xfrm: migrate encap should be set in
 migrate call
Message-ID: <aS1eEWq2aFHWV5sH@secunet.com>
References: <cover.1764061158.git.antony.antony@secunet.com>
 <d587781b6703af40a717d3278fad4bc37c1e91ac.1764061159.git.antony.antony@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d587781b6703af40a717d3278fad4bc37c1e91ac.1764061159.git.antony.antony@secunet.com>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 EXCH-01.secunet.de (10.32.0.171)

On Tue, Nov 25, 2025 at 10:29:08AM +0100, Antony Antony wrote:
> The existing code does not allow migration from UDP encapsulation to
> non-encapsulation (ESP). This is useful when migrating from behind a
> NAT to no NAT, or from IPv4 with NAT to IPv6 without NAT.
> 
> With this fix, while migrating state, the existing encap will be copied
> only if the migrate call includes the encap attribute.
> 
> Which fixes tag should I add?
> Fixes: 80c9abaabf42 ("[XFRM]: Extension for dynamic update of endpoint address(es)") ?
> or
> Fixes: 4ab47d47af20 ("xfrm: extend MIGRATE with UDP encapsulation port") ?

If this is a fix, it should go to the ipsec tree, not to
ipsec-next. But is this really a fix? Do we want to have
that backported? It changes the behaviour when the original
state used encapsulation.


