Return-Path: <netdev+bounces-156516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 634A8A06BF2
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 04:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A42D18826C8
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 03:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0E738DE9;
	Thu,  9 Jan 2025 03:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hv8hd5UW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A406BF510
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 03:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736392611; cv=none; b=f1ac005b8wGNbkS0vG3BzLPuqKcazg4fDGCQhkAQ1gqdryKrYBQq5keaXlNFRt15ankNdD/gqeA5e/GeP/aEgiK0VkkTLtioKhDPA4A/MOK91qyCU+N/QWec3wXqvqvZez4tVjgsSuEu1XU3KCc2EzgrjPMA5Sa7CZGZqXyae+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736392611; c=relaxed/simple;
	bh=GpgmU3rWVNsSlIZPrHTEjKt7o/HJygC8cR3nCKe0Kok=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J1m0tL10RXPzEehysfxU4UAzGbM384H0oadIh4A43mSaN8E6jjYc8Li/3ooLmr/6SvNyKpUmRzCVV1n/NKYp+Eb+aLfT7Kpq2IYUhCmEVaCW23ZIdLMrtTf8I0BbhUaRm8JY0i26Wfj6f80V3rgvHFSICjS9aQf5m2t6y7kH8E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hv8hd5UW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB273C4CED3;
	Thu,  9 Jan 2025 03:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736392611;
	bh=GpgmU3rWVNsSlIZPrHTEjKt7o/HJygC8cR3nCKe0Kok=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Hv8hd5UWMTCovBFmCtJcIF3/sN1L3afJbmYtlP0C6BEA5q5JNmR3ATaHrBkCKfaxr
	 eQ8NSvK36SricSgCO7lYPWTao3ZtboU5w8JIz8JzNZnCzd+ihEUrf/0CoeBTOZ+BF5
	 ahtxTgzK5BVtDICsvEv7c4QRfECOALe9Ja0h6yxOvEWz2VLDgV6QyqvE176X+bBzly
	 5fo6ISL/NCh25fGrLXFSntDlpLkdx9Me8x7RAcFEuGYpRglVliHob/9arUA+MdYe7Q
	 7RVga5sX1YPkzRj+UWOZMMCZOCjbHcxsLuOU/UiKbAWSJaFQ8BABY/C6/Ucb5xM/Q8
	 oADfnFfwVfv2w==
Date: Wed, 8 Jan 2025 19:16:49 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ivan Mikhaylov <fr0st61te@gmail.com>
Cc: Paul Fertser <fercerpav@gmail.com>, davem@davemloft.net,
 netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, Potin Lai 
 <potin.lai@quantatw.com>, Potin Lai <potin.lai.pt@gmail.com>,
 sam@mendozajonas.com
Subject: Re: [PATCH net v2] Revert "net/ncsi: change from
 ndo_set_mac_address to dev_set_mac_address"
Message-ID: <20250108191649.359d4cd7@kernel.org>
In-Reply-To: <0ecf17dd64e3f492087fea9e9e5213424fc1ce53.camel@gmail.com>
References: <20250108192346.2646627-1-kuba@kernel.org>
	<Z37eu/758pzGSGzO@home.paul.comp>
	<0ecf17dd64e3f492087fea9e9e5213424fc1ce53.camel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 09 Jan 2025 00:48:07 +0300 Ivan Mikhaylov wrote:
> Common case is 1 NCSI interface for server, we tested on this one and
> works fine for us and that's the reason why we didn't catch that
> situation. Nowadays some new servers has more than one NCSI interface.
> Probably we missed that is softirq context which is obviously not a
> place for rtnl_lock/unlock. Is there any other solution about except
> delaying dev_set_mac_address in work queue? Or any suggestions about
> how to deal with that in a proper way?

Nothing obvious comes to mind, unfortunately.
But the workqueue shouldn't be too bad.

