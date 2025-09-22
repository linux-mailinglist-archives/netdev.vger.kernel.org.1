Return-Path: <netdev+bounces-225287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD37B91E2A
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 17:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CED02A2D64
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 15:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0680E2E03F3;
	Mon, 22 Sep 2025 15:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="R2tPGMv8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L78zsXHV"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EAF2DFF04;
	Mon, 22 Sep 2025 15:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758554478; cv=none; b=BLOWSftAorFSG1fqVj4efQOaIfQyQJ1n6lG1rJpaCYYhKjJp4lvviT51QJP1EXnT0aFih5BCp7DuQ+iu5Bj8UKmsC1FvLsuHY75XAMxyTmp1sQwxg9iumUoNWmdQVNeverUWuh7bqp5GokURREasltnKxptA9/5EvqqUvxSj9PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758554478; c=relaxed/simple;
	bh=YLRGMaKJEGRBu417qctrK+7kZvPXslGrB5nA02ql9jc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DuZecap+U+FuoErdw0oH76q53hpnQ6yQVeDfYFpVq71yQyZfkTSPO+rWLgqQrNMSUq0gVLlT5H7hiUnTmw1CRTPcI0URnRHYXlLO7rGR53gGFlZ9jS+A+B1Tl1WfqOdPNYTb6myR38HvZABAz0kzrTJg96pL8hjsZ47dS6umYwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=R2tPGMv8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L78zsXHV; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 33FDE1400029;
	Mon, 22 Sep 2025 11:21:14 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 22 Sep 2025 11:21:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1758554474; x=
	1758640874; bh=LOCqdFL4WWIYlFONxqeTYa9PGa7VDH7WRH97rsSp3cU=; b=R
	2tPGMv8gzsZRntDTz11bl1fbCr4LDLsmzghIXFMx3Hn1K71J+FmDW8L6tetaVn2w
	0AV0ZmyUUWQtuKnrWhnFQj7yjSeuZrWYtCd2s2chhnx02S5o3wRuWXRmlpaYRbNs
	wAHcKYVtXBNciAke67nJwMr+3GMX7jK+92SuPH/UAOuqD0WuSAfJ1ZOfuUnHYjbz
	OZeyZkDrDoVPiWvyyhsZobMcczCOfunljQV4uc2P5RgqzVgVZaZQUsjXk2nK8kuu
	UpJzyT2eWZ4vxqa26C5qnPQMixp2tqkd7VgwWh63jAO2edI+IcIZ65Y274HK2ZZW
	WfNqrW/yCc4vLys6GP2Eg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758554474; x=1758640874; bh=LOCqdFL4WWIYlFONxqeTYa9PGa7VDH7WRH9
	7rsSp3cU=; b=L78zsXHVo26Ryl5UDQk+DYkTnAguTXFkoKz0GRCvH7qtSolG8bn
	v0TBy+xncQqtie2/Ey5E4OWEw33A0NEn6eHDos/CVEBNIfQtBCBQ8cJQ7oQyhKi8
	/i6m9iUfk9qfsRiIq4f+QBMfg2cqqnsvZ9mR55nm7u6+KSe7j62puCis/Ogw71rQ
	0WCuvOkF9pUPJVQYOBs0g2JnbsjUawJfRgk9FN0CRbaMflUIke91qELXbXGracyV
	v9DwVYCfoDRrd/D7xw5FlIC91BwtGVOic5u7yv+ey0qOCGqfdJPd0HjFUa59FipU
	QOLCsoSh4FCBea7Si66ONt4V7VoryvX04zA==
X-ME-Sender: <xms:aWnRaMqL-a8_ePWNPvc75Lp8Agd4nCwI8q_jcG4rigzRtiWPs1MXEw>
    <xme:aWnRaIp4EgThwIEgQngxeuPBr_CDqlgyVjk6zpxLI2p2YjsIx5Uw-RY5mKNxdmu5Z
    J3uNOwAkaEOrU10_tq8arhn7rZp2O0FHBxXqgvxYBTxz1-b3NlnhXxv>
X-ME-Received: <xmr:aWnRaMC3IbNnOK9cQ_8IvvQyRNrnwfYgEYWkGFcfF8Upaw-VR93VBYlmrr5E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehkedvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttdejnecuhfhrohhmpefurggsrhhinhgr
    ucffuhgsrhhotggruceoshgusehquhgvrghshihsnhgrihhlrdhnvghtqeenucggtffrrg
    htthgvrhhnpeeuhffhfffgfffhfeeuiedugedtfefhkeegteehgeehieffgfeuvdeuffef
    gfduffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgspghrtghpthhtohepuddtpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehguhhsthgrvhhorghrsheskhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepjhhohhhnrdhfrghsthgrsggvnhgusehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghvvg
    hmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohho
    ghhlvgdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtg
    hpthhtohephhhorhhmsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvthguvghv
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvg
    hlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:aWnRaGvN4zeWXQN3OE2B8jqXQl8mTbmmwGZkQ17ngP327ejf4rxA3g>
    <xmx:aWnRaLJaqyiyPMX7M0RqsyJ5Q8jI2DlJcPg2d4spRy3p2-Ac8GZN9w>
    <xmx:aWnRaNYPAp-VgeuiSRytKizrw_vj-1oGYyACgbdTFP_iMDoWR3Dgxw>
    <xmx:aWnRaNBFsbIG4VV_UIA2WqR-kNAcwydRREiHrhqpKqKuB9L0kF2s8w>
    <xmx:amnRaJkan2ubi54gS-FgsbxmSBAIeBgTPwgDfdFdOARz3QRex7QNBZea>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Sep 2025 11:21:13 -0400 (EDT)
Date: Mon, 22 Sep 2025 17:21:11 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] tls: Avoid -Wflex-array-member-not-at-end warning
Message-ID: <aNFpZ4zg5WIG6Rl6@krikkit>
References: <aNFfmBLEoDSBSLJe@kspp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aNFfmBLEoDSBSLJe@kspp>

2025-09-22, 16:39:20 +0200, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> Use the new TRAILING_OVERLAP() helper to fix the following warning:
> 
> net/tls/tls.h:131:29: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> This helper creates a union between a flexible-array member (FAM)
> and a set of members that would otherwise follow it. This overlays
> the trailing members onto the FAM while preserving the original
> memory layout.

Do we need to keep aead_req_ctx in tls_rec? It doesn't seem to be
used, and I don't see it ever being used since it was introduced in
commit a42055e8d2c3 ("net/tls: Add support for async encryption of
records for performance").

-- 
Sabrina

