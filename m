Return-Path: <netdev+bounces-106774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32828917977
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 09:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3A4BB216A6
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 07:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0FB015885E;
	Wed, 26 Jun 2024 07:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ic71017j"
X-Original-To: netdev@vger.kernel.org
Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644EC45978;
	Wed, 26 Jun 2024 07:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719386246; cv=none; b=dPCWyKb9Ro8if95X93chfno4Cd1lfTUoUTnbzVNa84SzpbVnXFcl4UxaGfeIRzHzWbaH3HxXwZEexJb1VT8eMVb9ZTTH05zKhBszIX/EqCXuiXhsMECIdkDaPxjHS2rmljOqREHqs8Hlq+k6qeAy3kE+I+K4BhdHrmSIGG/Mtm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719386246; c=relaxed/simple;
	bh=slX3C+0Bef6qqZL0On4Xz5aQ+oRFmyozN0VUtg6Tr+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z/v/DzbgjWSHcz4pemy8BrLG61bkf5683sWTwhYAKWh5qy/4eQlZuEL39CjHkAiKmtaGxoXI/9fhZx4enF1Goy3eviFzN3zkZPUqIjbuMRArckThnbLEivp95FghaLG1KQTq9sP8p/XIMQL2sFYAJLqqk62/IZi905HbXSodUtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ic71017j; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 6FA2213804FA;
	Wed, 26 Jun 2024 03:17:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 26 Jun 2024 03:17:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1719386243; x=1719472643; bh=tB1lKHkoDfWpApHraCg6N2Afvql2
	WzgZ8zWKaRQKTRo=; b=Ic71017jYedXy+cvDqozGn2LRUhhiILzxTXQ3PTCltA+
	xElUvn+5kcLBdM4ugqo2C8ZuF4Ik6lyStNwpIDjxXyKNFtqucA54Rv8Fys4cBC+q
	Yf0rV4OA9afwYn+yu5DuO+n98tGmzgAce38FCo6B+Az/em2zZCWshos1WabZJMgx
	/uU4tSGNbSJKxbZ0KCOKJBUgisf2zi/ThpThNeNYO4/dBUneqIhV9LJy+DdcZ+Ne
	rV74VzYxn+4DtD6SVK87AIlZgxq2aDiOiw/yS9mo3E4mXse1GFAhHqQpTI2RxRDt
	QObFlicPbG1NevX9WfxRvrv6mL7U27xs6X2DTG7wxA==
X-ME-Sender: <xms:gsB7ZlKtEnoY0Br-g0h8wcPbH-MPaQyHysb-6sH8nM16_r336b9Bcw>
    <xme:gsB7ZhKUOe1_8KJ-OkpVJ2eCWK1KYZITQaNhbkZk4MO14irRBdUN4SeEIEaxdIquu
    2akQ4d73jOcQIw>
X-ME-Received: <xmr:gsB7ZtuPhNBXdHggeQyNPs-saSQFvDizyGbXcpnZZF7IuJJpAKfCR8SKD_ZC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrtddugdduudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepkfguohcu
    ufgthhhimhhmvghluceoihguohhstghhsehiughoshgthhdrohhrgheqnecuggftrfgrth
    htvghrnhepvddufeevkeehueegfedtvdevfefgudeifeduieefgfelkeehgeelgeejjeeg
    gefhnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepih
    guohhstghhsehiughoshgthhdrohhrgh
X-ME-Proxy: <xmx:gsB7ZmZud67JCHcms8XbBTFhnrMqDOq0rYhTECM87epTbtjaFoktJg>
    <xmx:gsB7ZsZpVQxlPToHI9IsTUjyQRcjFsqplJnQgn4Fmb7ExFdppP_v5A>
    <xmx:gsB7ZqCJ1LTGUDsM1nfeKwDDggK0SpOMZaMVdrGbQu9WxQOFYvCwzg>
    <xmx:gsB7ZqbqQQRz42VwmXzSs4rJc65K3mdM3_Hjq-Wi4276NJFprRLAuQ>
    <xmx:g8B7ZiwiAtxV1icm5ARRNU9qa2oiMnHo8redqKnAwBIa7meHCDs8G0uL>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Jun 2024 03:17:21 -0400 (EDT)
Date: Wed, 26 Jun 2024 10:17:15 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Adrian Moreno <amorenoz@redhat.com>
Cc: netdev@vger.kernel.org, aconole@redhat.com, echaudro@redhat.com,
	horms@kernel.org, i.maximets@ovn.org, dev@openvswitch.org,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 02/10] net: sched: act_sample: add action
 cookie to sample
Message-ID: <ZnvAe1TUvh5EebrK@shredder.mtl.com>
References: <20240625205204.3199050-1-amorenoz@redhat.com>
 <20240625205204.3199050-3-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625205204.3199050-3-amorenoz@redhat.com>

On Tue, Jun 25, 2024 at 10:51:45PM +0200, Adrian Moreno wrote:
> If the action has a user_cookie, pass it along to the sample so it can
> be easily identified.
> 
> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

