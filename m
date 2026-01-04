Return-Path: <netdev+bounces-246736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 202E6CF0C45
	for <lists+netdev@lfdr.de>; Sun, 04 Jan 2026 09:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6231E3000E8E
	for <lists+netdev@lfdr.de>; Sun,  4 Jan 2026 08:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9B925F798;
	Sun,  4 Jan 2026 08:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JL0TMxFU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080A81FB1
	for <netdev@vger.kernel.org>; Sun,  4 Jan 2026 08:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767516236; cv=none; b=DYj6ZzsQ+H156LXroszob4RT2HrQIL1jfoXBnh3tnRUqJGNnjAxkmOJbFRSjzsEKBruzfvvmSH2bmfnOvoSZ/PEItonyBq2jDHZM1FLFk9zUPmHcfVetCHlrlmqrwnyZ1q2KLlp5HGNpFO62qoUUndxdv9Idxql12/ZFTWTG2/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767516236; c=relaxed/simple;
	bh=ayMpmyy6fiLdWK0tWRM7c1amKgrb5HcSXnS0IaNXwB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vs4EAyottnAzIAXT3MeQQg9ZUKbrY6ggqrvvs6wHMTUwkbOk3Yq7gUzJl0RNSYjGxvb0gujONbcUMDDg7QB1iZBXjWn6/cYtduWY4D4ZvnOV1qnEbF+3CIBHiz1rOKqlfW7kdFlRMccRIl863i42CG7jVdTYyL9PjPf9RVrO5Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JL0TMxFU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E856C4CEF7;
	Sun,  4 Jan 2026 08:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767516235;
	bh=ayMpmyy6fiLdWK0tWRM7c1amKgrb5HcSXnS0IaNXwB0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JL0TMxFUAKHSH61kqyOTtqRWBoaWrEBLrptuXbetQ3ZtXGGsEDmnmOpmu5W8Lm1UT
	 34wkWGwy8cB+mQXMtNcWyD+Q8KSng/Cd08Mvbf8i8Em76Pp63bzOBNn3YAwTTpZK4T
	 FdseVX3sLWXGW3lLdDPfMt/p5AUIRPbb7o1gZt8I=
Date: Sun, 4 Jan 2026 09:43:52 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Yunshui Jiang <jiangyunshui@kylinos.cn>
Cc: sashal@kernel.org, arvid.brodin@alten.se, netdev@vger.kernel.org,
	syzbot <syzkaller@googlegroups.com>
Subject: Re: [PATCH] net: hsr: avoid possible NULL deref in skb_clone()
Message-ID: <2026010424-calcium-flavoring-6fb6@gregkh>
References: <20260104071922.2712346-1-jiangyunshui@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260104071922.2712346-1-jiangyunshui@kylinos.cn>

On Sun, Jan 04, 2026 at 03:19:22PM +0800, Yunshui Jiang wrote:
> From: jiangyunshui <jiangyunshui@kylinos.cn>

Not the full name?  ANd you didn't write this, Eric did :(

confused,

greg k-h

