Return-Path: <netdev+bounces-51518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A512B7FAFE2
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 03:08:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F40128161E
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 02:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647364A28;
	Tue, 28 Nov 2023 02:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nr0Mjr1J"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497F07F6
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 02:08:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99199C433C7;
	Tue, 28 Nov 2023 02:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701137317;
	bh=6mW8aaYKpMVFy1AgGolA13AD6oAJw1r4ofWOwO5n4qY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Nr0Mjr1JxgD9MAf2MmGFdKz09+Xh9Lzddp/NM+D8dTTCCjxM03QhE0fr6UcX26T66
	 G4C2VM7KK5VX2V8ADJ5tbXKPS83tP0dGBF48Q3uxs9OTZ/b+WnzlW3VgqcTTnDekqt
	 vTwdsPHto16UtT8RdiGOzKSmw/4ehJmxBkSonPezAhfzu2PszscYTdtiDm1lYeeg8R
	 oiuBELFyqQP8FQzB5H58hRn+/blyG/TzJkM4WZWgTcqBqRmgxNg5eoOtjat6pAR/T8
	 iSE1FvhKiSUxvM3cP/xDYJ51q5q2dtI/W4JPEPqEM7+oWbsd+kgBRcWo8uV6BOk498
	 ORH7topY7XGjA==
Date: Mon, 27 Nov 2023 18:08:35 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Florian Fainelli
 <florian.fainelli@broadcom.com>, Marek =?UTF-8?B?QmVow7pu?=
 <kabel@kernel.org>, netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 00/10] net: phylink: improve PHY validation
Message-ID: <20231127180835.7ad03e94@kernel.org>
In-Reply-To: <ZWCWn+uNkVLPaQhn@shell.armlinux.org.uk>
References: <ZWCWn+uNkVLPaQhn@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Nov 2023 12:27:11 +0000 Russell King (Oracle) wrote:
> One of the issues which has concerned me about the rate matching
> implenentation that we have is that phy_get_rate_matching() returns
> whether rate matching will be used for a particular interface, and we
> enquire only for one interface.

FTR this series got marked as Changes Requested in pw, but I don't see
any reason why, so reviving it (to immediately apply it):

pw-bot: under-review

