Return-Path: <netdev+bounces-229242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19966BD9B7E
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 15:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD96618961EC
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 13:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A3A314D1F;
	Tue, 14 Oct 2025 13:22:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6E8314D02;
	Tue, 14 Oct 2025 13:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760448136; cv=none; b=EBTkQZs9oTRTXsliwLNhfxbcqqjx2tYdjV7CU7YFA8/qk0Sg06SnNbZiYK1hMO+lqV/1ErS38uq9cWH+hzEXsDyAIhcV+6u3p/mV4Msp0tQN7XBCQL+D1TXeR4IYeGf9TNFIgl0AGsh1paimg2926CP1sRvgtakmCj+EOug4xzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760448136; c=relaxed/simple;
	bh=HCk0Oh4t9aGXWl2LWbP437LJVt1RFvHxvovvsEDgKPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UcV5BZ8Ujii/77cEsA8WmrZEvkKs4vI5zujqjwjAJH1cNTPraIDmb3DrukYQ3c0aWpQBnGYgOzgkJ4CZSjjfO2+QlpMRrXlvwH0SGq5fghwZvjvU3+KPQjysKKCNJNNEIaR/HgFGA0rp6AQtVQsz8wTV3eAM+aASp2gGC0Y6VAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 7CB0748536; Tue, 14 Oct 2025 13:22:12 +0000 (UTC)
X-Spam-Level: 
Received: from [IPV6:2a00:6020:47a3:e800:96c2:85f:dd97:a67d] (unknown [IPv6:2a00:6020:47a3:e800:96c2:85f:dd97:a67d])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 6A2CE48535;
	Tue, 14 Oct 2025 13:22:11 +0000 (UTC)
Message-ID: <4fcabfb2-9793-49be-bf60-bb8ac36f9e34@birger-koblitz.de>
Date: Tue, 14 Oct 2025 15:22:09 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net-next v2] ixgbe: Add 10G-BX support
To: Paul Menzel <pmenzel@molgen.mpg.de>, Andrew Lunn <andrew@lunn.ch>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251014-10gbx-v2-1-980c524111e7@birger-koblitz.de>
 <0c753725-fd6f-4f85-9371-f7342f86acff@lunn.ch>
 <77cfe8ef-57d4-4dee-b89d-3f5504653413@molgen.mpg.de>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <77cfe8ef-57d4-4dee-b89d-3f5504653413@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 14/10/2025 15:07, Paul Menzel wrote:
> Unfortunately I do not see the original patch on the mailing list *intel-wired-lan*, and lore.kernel.org also does not have it [1].
>
I have several emails from intel-wired-lan stating that "Your message to Intel-wired-lan awaits moderator approval" as I am not myself on that list.

Birger

