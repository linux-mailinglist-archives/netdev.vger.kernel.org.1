Return-Path: <netdev+bounces-205889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C233B00B33
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 20:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 121AB4E4F55
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 18:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0C223505E;
	Thu, 10 Jul 2025 18:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BR45fP1r"
X-Original-To: netdev@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3221DDD1
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 18:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752171450; cv=none; b=hizUwLe3h9NGRjy6NhCHiWIVPcgfeLsxSMt+eD3LoCd8QYF/A3d9v7imWdA+L3dXlqkSwFe5lFUERkC4pSEfSCO+dFd6+6Xyr9zqeBx9RsPgo5QQe0YjzyZzdhr/EmjAtTZ4d/CGlX8CLwr1jF/zp1moRQ+E27OC0TDOiO1uE6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752171450; c=relaxed/simple;
	bh=G6rN5cJngjk44IjxL+fnnP/W7Y7dKU0bkGwr0oO8Lq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t+HhRjP5dvBdLTMGEtjqMFJphpKbIaB5Y2Itjn+AJLol4DKSLn+1WuJauDx3klIlJiA3uI9GTTnZxe+okdEGz4UxX2nZxDk6y5V0787LGSHs/iZA6qPy7Kac+wsNGDCeFgXg5QoElZ/2t1J7ELwtKcJ5V0BK87/Y4j7RQnmOmAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BR45fP1r; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <04583ed9-0997-4a54-a255-540837f1dff8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752171441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DgUwdot/5xK2anv7iC+LnotvvGbJx7t4Nr8KmHPe5nA=;
	b=BR45fP1r4jAdDaMh2Q8wsEHiwRTmxm3jCYYQz4qZCmrdwV1GivcdP8bN+2I/SB9OQCBVki
	qscCaLYRHn1LBEFxQ+yjZYwVKDx/Hpx6AWK9xcvYjyCrQycDQ/nJU8DH9550J+4htm89TP
	ZJqs2K2WL+qSl0hR1TV7SpXVCAJrSgU=
Date: Thu, 10 Jul 2025 14:17:18 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] net: phy: Don't register LEDs for genphy
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
 "David S . Miller" <davem@davemloft.net>,
 Florian Fainelli <f.fainelli@gmail.com>, Eric Dumazet <edumazet@google.com>,
 Christian Marangi <ansuelsmth@gmail.com>
References: <20250707195803.666097-1-sean.anderson@linux.dev>
 <20250707163219.64c99f4d@kernel.org>
 <3aae1c17-2ce8-4229-a397-a8a25cc58fe9@linux.dev>
 <1019ee40-e7df-43a9-ae3f-ad3172e5bf3e@linux.dev>
 <20250710105254.071c2af4@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20250710105254.071c2af4@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/10/25 13:52, Jakub Kicinski wrote:
> On Thu, 10 Jul 2025 13:40:33 -0400 Sean Anderson wrote:
>> I see this is marked "Changes Requested" in patchwork. However, I don't
>> believe that I need to change anything until the above commit is merged
>> into net/main. Will you be merging that commit? Or should I just resend
>> without changes?
> 
> The patch must build when posted. If it didn't you need to repost.

It builds on net/main. Which is what I posted for. The CI applied it to net-next/main.

--Sean

