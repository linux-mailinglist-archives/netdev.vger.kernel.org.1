Return-Path: <netdev+bounces-276460-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OOQnEVFB1mkFCwgAu9opvQ
	(envelope-from <netdev+bounces-276460-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 13:51:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D349B3BB76F
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 13:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 37A343012BDD
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 11:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B293803F0;
	Wed,  8 Apr 2026 11:51:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F828335556
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 11:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775649101; cv=none; b=NifYTQh0vqd2H5jkm1C4mf1rL8Gvy0m8+WZn4MR9c4UBLUaGjSAXvOtgsQYm/IRjJZyZVhcciRvn6oG9avYBaVF7a/n23DvnNQC7aTjO96t1/BeVdUgPXVLFDp2479c4WhD/GMLoHeL/q3dGLB8HIy1kwBSTwlEvga1h9dLvM54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775649101; c=relaxed/simple;
	bh=To0GYwzn1VLVHtmsnwqTcdG/AMFRUzmu+3hkxMxuKUA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qaxwtlMGIgpTHwJtWiZyxyDpp1vyDjxO76/ND1kY8CHadnZ1BML2aQ/BQ20+mofvISNTeA9SzzowppJm9J+PPnojLKdwu2nCvsar+oo/dRvFIsUdHkKtZJuV/vRRjtqaeJrMgNQIlWI9mvVMC45EICkIhLz849STKBUyF9zQ/nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.229] (p5dc55707.dip0.t-ipconnect.de [93.197.87.7])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 95BCA4C2C37D4D;
	Wed, 08 Apr 2026 13:50:38 +0200 (CEST)
Message-ID: <3c7e8261-7528-431c-adb9-3b90124cef99@molgen.mpg.de>
Date: Wed, 8 Apr 2026 13:50:37 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next 0/2] i40e: implement per-queue
 stats
To: Paolo Abeni <pabeni@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org
References: <cover.1775648513.git.pabeni@redhat.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <cover.1775648513.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276460-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[mpg.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.osuosl.org,intel.com,lunn.ch,davemloft.net,google.com,kernel.org,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_SPAM(0.00)[0.262];
	R_DKIM_NA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pmenzel@molgen.mpg.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D349B3BB76F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Dear Paolo,


Thank you for your patches.

Am 08.04.26 um 13:43 schrieb Paolo Abeni:
> The i40e driver already collects some per queue statistics, but does
> not expose them to the user-space using the standard interface.
> 
> Implement the stat_ops callbacks and extends the already collected info

s/extends/extend/

> with basic GSO counters. Overall this allows passing the kernel NIC
> drivers TSO test cases.

It’d be great, if you added the commands to show the stats, and to run 
the test cases.

> Paolo Abeni (2):
>    i40e: implement basic per-queue stats
>    i40e: keep track of per queue gso counters.

No period needed at the end of the summary/title.

> 
>   drivers/net/ethernet/intel/i40e/i40e.h        |   9 ++
>   drivers/net/ethernet/intel/i40e/i40e_main.c   | 144 ++++++++++++++++++
>   drivers/net/ethernet/intel/i40e/i40e_txrx.c   |   8 +-
>   drivers/net/ethernet/intel/i40e/i40e_txrx.h   |   2 +
>   .../ethernet/intel/i40e/i40e_txrx_common.h    |   6 +-
>   drivers/net/ethernet/intel/i40e/i40e_xsk.c    |   2 +-
>   6 files changed, 168 insertions(+), 3 deletions(-)


Kind regards,

Paul

