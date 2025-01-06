Return-Path: <netdev+bounces-155587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C9F1A031BE
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 22:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20B4B1620BB
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 21:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879C51E0B66;
	Mon,  6 Jan 2025 21:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="Li8hpYi7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FHFXWjrh"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB821E0B99
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 21:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736197294; cv=none; b=gI8HnmE64AMX/7b04sZlJTFE7qCdeRIVmJG7YH/lT19CRTMjumEzQaNu+3LaNeNL70tOch9wiHtQeBymytthKa7qlvY1jxK4FzK0hk6c5xjCgr0lZ82HW+ccgmkyawmgPyvrAXD43eOy1p8TGZq4s35Sh5OiFRN5msVzcduykTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736197294; c=relaxed/simple;
	bh=ZMKzx/11r3WL7nSKCHsJMKVWZZdtlJUayZ7/MroPN1M=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=aS76qZoxUALOj7sJPwfUsAOcwwB4tEE1CaHsJAS5J33NEIcTCQtMSmd64Enf91UMQlROA8Wt8ue4l/dNYYEay/e6Natn7hRY6dKp+4TbXKvK78RuXUI3V3y8BX3IECHDwzMT6PNN4rv2UGUfqw+StozyakFMqwaVOfBhbejswew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=Li8hpYi7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FHFXWjrh; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B57ED25401D2;
	Mon,  6 Jan 2025 16:01:30 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 06 Jan 2025 16:01:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-type:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1736197290; x=
	1736283690; bh=bLrF6iq9CWbtwGmCzUP9kwysuaIUpRCQXh509SDjvfQ=; b=L
	i8hpYi7AAgDOqODxFvg7jCPbZ3O7Q8Aad7ayMsw5CwmwJLKISLajTUS+i9nPbSa9
	g8vW39OZsYzJ5j7Dhsb+oDAT4id44A3MsV6BuDTlDvf779YgpClKVYxQSzH7otph
	tn+R6rLI4gKxG/yq4iZoW+7pQy39lQlsDjhBwcb7+WM6AZ4+tLUeaFmE2h9Jsrz+
	NrHQGkkiZ8qGaRy5nmEYaa5859ren+hJcKZl3mTPix9H5uHsXZ0WyU1Tg36SnfSc
	6WyDAa7x0sw0asWgci1lQgUwcHa2VvPRIW3XDOzHC0QUe69hZJLqOTIjrNDnU2KM
	qn4oh73gLiNHHD+PE4V2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1736197290; x=1736283690; bh=b
	LrF6iq9CWbtwGmCzUP9kwysuaIUpRCQXh509SDjvfQ=; b=FHFXWjrhmah0TjKVB
	k/ZjdVFcC4kQe3DzRzsUnQHJwdMo7T2HQ/rtDEqhB/4uPZlyjE+vQuXSizd1HXtL
	jUbqmsFSKOeAzPF8cr92wTmmw9Mh9yHVPqiBBxGoFScg5PdquNCyHswNHGLlGROp
	+i1qzAt6V0c59vndB0+poqNG0nOHglaIt6M2scn/FBEVg7EtIA46+8qct5isMWpr
	BZ1aotpOCByDAGI1/+noFKmo1MDkKFNyyztmhwEVqG1B9CclsU1/2rd+DgkvlOIB
	uerVfJ7WwvqLl7uLQw4xHoQlseg5dqkSCMtdpPCq8Le2Pkbei3wtk01TgisX/wtm
	DJwXg==
X-ME-Sender: <xms:qkR8Z3e9Y3vZwOt6W0VmqDDhsi4SWxyHEJhKMxfqR_bi5jpobkAhIw>
    <xme:qkR8Z9OxWklBKoZo-3LeQw3_6PbZcrVJ_uKDmqt-jjZskxBQ1NNADI3NGC0WLtilh
    JOAsTxN8zXNun4svpo>
X-ME-Received: <xmr:qkR8ZwihRZdZWPyxQeaX5G4htT17eFV9UPE9quM7eSr34rE_x0ARubBi3D7-M6pWGLi3Mw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegtddgudeggecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fujghfofggtgffkfesthdtredtredtvdenucfhrhhomheplfgrhicugghoshgsuhhrghhh
    uceojhhvsehjvhhoshgsuhhrghhhrdhnvghtqeenucggtffrrghtthgvrhhnpeejvdfghf
    etvedvudefvdejgeelteevkeevgedthfdukeevieejueehkeegffejudenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjvhesjhhvohhssghurh
    hghhdrnhgvthdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtoheprhgriihorhessghlrggtkhifrghllhdrohhrghdprhgtphhtthhopegurghvvg
    hmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohho
    ghhlvgdrtghomhdprhgtphhtthhopegrnhguhiesghhrvgihhhhouhhsvgdrnhgvthdprh
    gtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnughrvgif
    odhnvghtuggvvheslhhunhhnrdgthhdprhgtphhtthhopehprggsvghnihesrhgvughhrg
    htrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:qkR8Z48slp8w36nt43s8YzjlCruGC025o6drDRw3TtmQmu3zAKr5Jg>
    <xmx:qkR8Zzs3ETEpYsli02lTiuGfzSQrpay_qL4KfNQ51Lh5qPALqGYZvQ>
    <xmx:qkR8Z3EiPvEYUFUaMSYyAqokz7HGbEmGKJi3z7VVKedkOVQe7HSmRw>
    <xmx:qkR8Z6PBL7t5UDRxa5t_MOyx02gHVRqhqItZK11VgubXYCdjlUVBpg>
    <xmx:qkR8Z5DbPiNZcKddItNbd08jerAq_LKZsZY8ZD9bNjuQazqqAOzCIlWP>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jan 2025 16:01:29 -0500 (EST)
Received: by famine.localdomain (Postfix, from userid 1000)
	id AC4899FCAE; Mon,  6 Jan 2025 13:01:28 -0800 (PST)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id AB5569FC8D;
	Mon,  6 Jan 2025 13:01:28 -0800 (PST)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Nikolay Aleksandrov <razor@blackwall.org>
cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
    netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
    andrew+netdev@lunn.ch, andy@greyhouse.net
Subject: Re: [PATCH net 3/8] MAINTAINERS: remove Andy Gospodarek from bonding
In-reply-to: <2fda5a09-64da-40a4-a986-070fe512345c@blackwall.org>
References: <20250106165404.1832481-1-kuba@kernel.org>
 <20250106165404.1832481-4-kuba@kernel.org>
 <2fda5a09-64da-40a4-a986-070fe512345c@blackwall.org>
Comments: In-reply-to Nikolay Aleksandrov <razor@blackwall.org>
   message dated "Mon, 06 Jan 2025 22:53:47 +0200."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2982752.1736197288.1@famine>
Date: Mon, 06 Jan 2025 13:01:28 -0800
Message-ID: <2982753.1736197288@famine>

Nikolay Aleksandrov <razor@blackwall.org> wrote:

>On 1/6/25 18:53, Jakub Kicinski wrote:
>> Andy does not participate much in bonding reviews.
>> 
>> gitdm missingmaint says:
>> 
>> Subsystem BONDING DRIVER
>>   Changes 149 / 336 (44%)
>>   Last activity: 2024-09-05
>>   Jay Vosburgh <jv@jvosburgh.net>:
>>     Tags 68db604e16d5 2024-09-05 00:00:00 8
>>   Andy Gospodarek <andy@greyhouse.net>:
>>   Top reviewers:
>>     [65]: jay.vosburgh@canonical.com
>>     [23]: liuhangbin@gmail.com
>>     [16]: razor@blackwall.org
>>   INACTIVE MAINTAINER Andy Gospodarek <andy@greyhouse.net>
>> 
>> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>> ---
>> CC: jv@jvosburgh.net
>> CC: andy@greyhouse.net
>> ---
>>  MAINTAINERS | 1 -
>>  1 file changed, 1 deletion(-)
>> 
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 91b72e8d8661..7f22da12284c 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -4065,7 +4065,6 @@ F:	net/bluetooth/
>>  
>>  BONDING DRIVER
>>  M:	Jay Vosburgh <jv@jvosburgh.net>
>> -M:	Andy Gospodarek <andy@greyhouse.net>
>>  L:	netdev@vger.kernel.org
>>  S:	Maintained
>>  F:	Documentation/networking/bonding.rst
>
>I think Andy should be moved to CREDITS, he has been a bonding
>maintainer for a very long time and has contributed to it a lot.

	Agreed.

	-J

---
	-Jay Vosburgh, jv@jvosburgh.net

