Return-Path: <netdev+bounces-257578-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aH0iERIHhmkRJQQAu9opvQ
	(envelope-from <netdev+bounces-257578-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 16:21:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E208FFAE5
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 16:21:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 139173002D23
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 15:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3BE366079;
	Fri,  6 Feb 2026 15:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C8JPupPL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD4826ED40;
	Fri,  6 Feb 2026 15:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770391304; cv=none; b=pFDt8JpbFuZIoLj6lBw2a7B+eLt7w3gYedH8RHDrt9I6PPd33PA+IsiavgjqES2XF6npPcIPWqyi/N1fL1caYfH10S6lFLnoNvsOouYxzqXDKF+8mzhKZ8zRH6+/YAjJ+yn55EqLpy777NNb3TA6cTaW1b4CqamrJpcGZYVNKVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770391304; c=relaxed/simple;
	bh=TUuctS5iACsWdKHAPpxd3q5N9pvKwPqGOSSMlfwtrP0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UB/qLNLU2tXnc/z0zRu+Qt9cW8Alp+WwUf2XpnZECixBtuNdYJDg03uvBZc2n2UA2e96q1hgtlnrgDDJJNtF4fUNjbVhTIrFl45dqCvvCB2HkFRTzLYmgLbQgQM/cwoBmkKfiQqsSMn2JkQcNW0WKQONCdYn6nhUQ1Kxupczh1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C8JPupPL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD56CC116C6;
	Fri,  6 Feb 2026 15:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770391303;
	bh=TUuctS5iACsWdKHAPpxd3q5N9pvKwPqGOSSMlfwtrP0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=C8JPupPLdctogUO0DG858/BnV3dU9UDerbef9V4Xq7nfzNFRYIaMI2j0cpINidzzv
	 Pk1RnIuh/2ALunTiE3vSe1I3LUK+PvjGM+UBwi4k45RXRUbcrDQ9ewTFIUFEsMyOnB
	 JJ2MG+aaUWp3NkY03nCG4AQ8xjU4DbtOBGleDNnCebGA/x0KMTsXJiDmyzt0nn5Tx6
	 vQv33Lvu84QRplRhLE9XeQoM1TfTv7npUj2/+Pb8MC38mdufCZKSjCQ9qNzQtkZzez
	 VzxOO2/TyrBq2NWzbhJ5walzS9N21AS6nykFUkxp9vkvUzgMzTs1mZqf7owwxM/3tE
	 e3zwQfM/xxfJQ==
Message-ID: <007e93e8-ab52-45b3-8e06-107f1b02af0c@kernel.org>
Date: Fri, 6 Feb 2026 16:21:38 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next RFC v1 0/3] net: sched: refactor qdisc drop
 reasons into dedicated tracepoint
To: Antoine Tenart <atenart@redhat.com>
Cc: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <eric.dumazet@gmail.com>,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>, bpf@vger.kernel.org, horms@kernel.org,
 jiri@resnulli.us, edumazet@google.com, xiyou.wangcong@gmail.com,
 jhs@mojatatu.com, carges@cloudflare.com, kernel-team@cloudflare.com
References: <177022452988.1827734.5121740962985640333.stgit@firesoul>
 <20260204190417.110f5498@kernel.org>
 <2e1eb11c-cd47-4772-baff-45d43d4fa539@kernel.org> <877bsr1l1h.fsf@toke.dk>
 <CADCXZ1yMkZbRd7ioGw5QQ61OdmYp6misUDoj-s-g7wuoiCHKbg@mail.gmail.com>
 <87v7gbz1ru.fsf@toke.dk>
 <CADCXZ1z-gg_VsN4kjf325HvWRxL1irhUC76B_erggm5+A7qQ7g@mail.gmail.com>
 <41da26a6-4024-461f-8254-ac5dcf231397@kernel.org>
 <CADCXZ1wMxCN3B-c+x4SgqC7H-Wap=e_sJ_hu-2B+96b=ip9OVQ@mail.gmail.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <CADCXZ1wMxCN3B-c+x4SgqC7H-Wap=e_sJ_hu-2B+96b=ip9OVQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257578-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,kernel.org,gmail.com,vger.kernel.org,davemloft.net,resnulli.us,google.com,mojatatu.com,cloudflare.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hawk@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4E208FFAE5
X-Rspamd-Action: no action



On 06/02/2026 16.04, Antoine Tenart wrote:
> On Fri, Feb 06, 2026 at 03:41:23PM +0100, Jesper Dangaard Brouer wrote:
>> On 05/02/2026 17.24, Antoine Tenart wrote:
>>
>> Can you point me at the OVS userspace code that consume these subsys
>> drop_reason's?
> 
> I think this was mostly added for debugging utilities and not consumed
> by OvS directly but I don't know the OvS userspace code tbf. Anything
> you're looking for specifically?
> 

I'm just trying to making sure that I/we don't break any userspace code.

Yes, looks like debugging tools are the consumer. E.g. The Red Hat
NetObserv[1] tool mentions OVS decoding drop reason.

[1] 
https://www.redhat.com/en/blog/network-observability-real-time-per-flow-packets-drop

--Jesper

