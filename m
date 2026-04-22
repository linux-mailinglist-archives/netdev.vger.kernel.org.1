Return-Path: <netdev+bounces-280379-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPXTBcKm6GngOAIAu9opvQ
	(envelope-from <netdev+bounces-280379-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 12:45:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E8B444E67
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 12:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1D44F3002B6F
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 10:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D783CD8A6;
	Wed, 22 Apr 2026 10:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DYJMmGIb"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3E63C277B;
	Wed, 22 Apr 2026 10:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776854717; cv=none; b=Cc0XKRsU/AhLOGvPuZZ6VD+IacfXl8AC0tAW1adOxmJBCt5sgypZT+/HslKANY2fRoAcZVINPhRFNIi3nQO34FVjIPmXmqE4esmUjR0GCTyRvZn7cKPSC217Mzc/PFIi4bZyEZizHZ9D7TAmOfNThix4c6TGrE9BsMBnrP4y2Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776854717; c=relaxed/simple;
	bh=v2a5FraOdc2dV95xHacv/Tb64RjV51isslI60fgVfa8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=HvEwGNyJtT0PR1bbDrV8BW7ohatrCWJtX+g5jrbXxvOGKXVCWGCj9mdZe5Zu7GfJifica4ULYKNmiP5vs+v8bfhMrtBoNiu+PHLQWPFxGCTK6vak4gXKFOJDKU7UFTkVBmWujNw4dIGEMfuxN+wDT8IejFr31QnZLmH4xfQLkhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DYJMmGIb; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id BE2C5EC0530;
	Wed, 22 Apr 2026 06:45:14 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 22 Apr 2026 06:45:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776854714; x=1776941114; bh=w1yxN6tr6bpwlPeIBT7a54lyLgshzwZVuMM
	UiX19j+Q=; b=DYJMmGIb8/DvRW2kiyZTzLMHIA5ZQokWhy7ved5GrE78m5W5ogs
	9BRUeY8oQjJ92ZEcHy74UOGjxCNvfAm4X2AwdteWYvrD86wyGH9aUMZ/LEoyVk0c
	vA3WrZxez5maakt8UX2aWb2CzJCcDFBitu0E7zA7wKmWnOP9BNelNGO+Wqy5RhfW
	WxdTgFgWGI2wURMkW/ZKCO88FXEZbBeo4i9tJovF3u+7wL+igrZ2QfbuK5FwmI1V
	J3HhbsP/+HR83WZj+KqW1Ci4ZojxYQL9sV8+/xI7HMuk3Sr4BOJGvkek73CU7yoG
	7c8h1pesCQaADn/SXGiBCv3/8yefK6Hh9rw==
X-ME-Sender: <xms:uqboaQYUt3GrwH5PKAbXDWrqNA_OZo-mBrfRveHGfHreLnT0j3K0WQ>
    <xme:uqboaTi8d7v0T7AqKfxGzJ1LY5FNGpaggFX8XFRxuC3ZCXROq_gGj-0-JSYkM6bYf
    TYzjjzH5V1_QE5PuLx-8V6yr34N2Kv91IWzgWk1OAyPjUoVMbXvJ48>
X-ME-Received: <xmr:uqboaaeBTkInTvwOr9bomA97nt-t2RlNDYv1HQEdxLKtCTegeV6NRb1uALmJc4-SBOFs_8pFZzkM9E4GFF5HUnHmQBVjhuvDIQE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeigedtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefujgfkfhggtgesthdtredttddtvdenucfhrhhomhephfhinhhnucfvhhgr
    ihhnuceofhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgheqnecuggftrfgrthhtvg
    hrnhepleeuheelheekgfeuvedtveetjeekhfffkeeffffftdfgjeevkeegfedvueehueel
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepfhhthh
    grihhnsehlihhnuhigqdhmieekkhdrohhrghdpnhgspghrtghpthhtohepuddvpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtph
    htthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtohepuggr
    vhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesgh
    hoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohephhhorhhmsh
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghorhgsvghtsehlfihnrdhnvghtpdhr
    tghpthhtohepshhkhhgrnheslhhinhhugihfohhunhgurghtihhonhdrohhrgh
X-ME-Proxy: <xmx:uqboaam8R27j7I05wOpxBGdfax_tGr5NOqO_boruyzRKhM4Mq4elWQ>
    <xmx:uqboaXxLx15kLawTGEAdZb7MjAKn1Aq543hzQw7aACqtS9b9vPpLCg>
    <xmx:uqboaVwraux5KwsML9T4wAoxtaA7cV6mwHDbTLg8AtBRtbssn4l-Kg>
    <xmx:uqboafUo42Vl8CA-0fMCURUGA0jwsfYQSL7Nmjaw-BEI6tBPvaaNBw>
    <xmx:uqboaZRTBPY8uLTxwR9hrarQBFvAEdzPXyHcb5rtDA0_QQyfJDK-Reg6>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Apr 2026 06:45:12 -0400 (EDT)
Date: Wed, 22 Apr 2026 20:45:23 +1000 (AEST)
From: Finn Thain <fthain@linux-m68k.org>
To: Andrew Lunn <andrew@lunn.ch>
cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
    "David S. Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
    Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
    Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
    linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
    linux-doc@vger.kernel.org
Subject: Re: [PATCH net 00/18] Remove a number of ISA and PCMCIA Ethernet
 drivers
In-Reply-To: <20260421-v7-0-0-net-next-driver-removal-v1-v1-0-69517c689d1f@lunn.ch>
Message-ID: <17fae078-66bb-1d22-3b19-d5491a9fbb53@linux-m68k.org>
References: <20260421-v7-0-0-net-next-driver-removal-v1-v1-0-69517c689d1f@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-280379-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-m68k.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[messagingengine.com:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fthain@linux-m68k.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 13E8B444E67
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Tue, 21 Apr 2026, Andrew Lunn wrote:

> These old drivers have not been much of a Maintenance burden until 
> recently.

They are not much of a maintenance burden because they are small, mature 
and stable.

> Now there are more newbies using AI and fuzzers finding issues, 
> resulting in more work for Maintainers.

AI helps find issues but AI also helps resolve issues.

> Fixing these old drivers make little sense, if it is not clear they have 
> users.
> 

Removing these old drivers makes little sense, if the issues were only 
noticed by AI and not by actual users.

