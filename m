Return-Path: <netdev+bounces-232205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2706BC027A6
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 18:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61FBA3A9A09
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 16:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB32533509F;
	Thu, 23 Oct 2025 16:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IWvEJ/yF"
X-Original-To: netdev@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF53225F78F;
	Thu, 23 Oct 2025 16:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761237786; cv=none; b=pNQISvW8Joqu000NyaViuxGnuo7+0tvh1EhdnOoD1EORO7lPUPkQN3/NFDB8/0FnlhGTy/XQjEW9lPCCkw/2BPVDP4tBcGEMwmbCseHdKowqfOFu/z3j/4n7W+A4CvCGU9pXWm4ANdwZmADDCx1erQWk/CBKOIbVzLWvFSBgKEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761237786; c=relaxed/simple;
	bh=vW/R4oAoa6bwaldSmiwg8qvyvnlmurH/Wn2P6wAkCIA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C6hMy6X2N/y4jaVgHZu3GQGYSKTaJKsZf/HevzGAsK+2iGuN+0BwMcajy3X8t9GpPe7zjpWbLByS9+vvdHT9frAdeJrk9UAhDGhFozVbtRHxnz+lD9/GHWxc7Ql3lfLWw8SN5M5W32NFl9k3X5qw4UE3Oiuvy2zsDkhO/0vQSTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IWvEJ/yF; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=IRY2FjbeHDdDgTVzISAQCqDTP8DpvEw9s72ecDZ0g5s=; b=IWvEJ/yFn6O6hcWDJtPU8QgoL+
	akAWIWRagbZAm5ssLe/RoZSH3jCZNw4vZXTuzmyg6E9xbZM5RTUidV+vXvEBx65CprHt3kTjwQZCF
	pS6NzhZPRnSnHv5KM/Eccua9W/s0325HPqqyXi+wy2daViCpWJ40EgPbSaHkBni3uWCtxE4MbMgZg
	onfD6xEDO4Lsi8D3v4EpQTIvewWMhKSCQZy+qviNOVk3Mnc/p4OqM05Zd18swIaYdzZEyhJKGPgyU
	lcQtBPM85jxTiAsa+3EQwDZ3ZDZ81iko0Lcdmdp33wzSQ4NcUtZYyfct0c6Pcb1SQc8uc0o5mUvd6
	xABzhhcw==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vByOz-00000006w39-2YW4;
	Thu, 23 Oct 2025 16:43:01 +0000
Message-ID: <b77b8a60-2809-4849-8a6e-a391eacf050b@infradead.org>
Date: Thu, 23 Oct 2025 09:43:00 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] Documentation: ARCnet: Update obsolete
 contact info
To: Bagas Sanjaya <bagasdotme@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Documentation <linux-doc@vger.kernel.org>,
 Linux Networking <netdev@vger.kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Michael Grzeschik <m.grzeschik@pengutronix.de>,
 Avery Pennarun <apenwarr@worldvisions.ca>
References: <20251023025506.23779-1-bagasdotme@gmail.com>
 <295b96fd-4ece-4e11-be1c-9d92d93b94b7@infradead.org>
 <aPnqn6jDiJkZiUfR@archie.me>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <aPnqn6jDiJkZiUfR@archie.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/23/25 1:43 AM, Bagas Sanjaya wrote:
> On Wed, Oct 22, 2025 at 09:21:43PM -0700, Randy Dunlap wrote:
>> I'm wondering about one thing in arcnet-hardware.rst:
>>   it refers to www.arcnet.com.
>> Did you happen to try that web site?
>> Looks like it is something about AIoT.
> 
> And it's membership application form, though. (I'm on the err side to not
> enter my personal data there.)

Same here.

>> I found the ARCnet Trade Association at
>>   www.arcnet.cc
> 
> That's ARCNET Resource Center.

OK, the ATA is  https://arcnet.cc/abtata.htm

I suggest changing the link.  what do you think?

-- 
~Randy


