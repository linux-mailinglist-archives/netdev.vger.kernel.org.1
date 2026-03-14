Return-Path: <netdev+bounces-267767-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aMhOEvmJtWmO1gAAu9opvQ
	(envelope-from <netdev+bounces-267767-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 17:16:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4242B28DD79
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 17:16:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5EEF7300382E
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 16:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC9B1FB1;
	Sat, 14 Mar 2026 16:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g1DTTNMC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5C640DFAF
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 16:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773505012; cv=none; b=NV+9QphTeabdL0k/0FG/Knis29cYndU8vV8z7KhOhyFlx7gOI4y9HAVeifijpMQ/e+stzzQAqrhoHEw8g+kTBj9Gze3bKKYmuOAc6hMwfzr4TayYOmwF07AnOnsYc8UIaoAj/FSCQV+De1F+fayalLiCJQ5kTsdr2Hwbu28MY7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773505012; c=relaxed/simple;
	bh=q5bg5eM2OLKGIm8UcvKZIp3I/4CcsOCzuMw5COXcpwU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IWp1VFU98Ktt+SMQT2df2IfJhbmcznREbCSe0KXTCo7+F+/hbu1S5Ft3p9Xtzhc9iIA+SOZX5sNUkRn8DzjGGt1exeN0vZCVyOlP5BoA0HsAXRpKFeSrNeSh4f9aFbNn+gKkqCDcdiSWjhBsrHXH2WTRrRYMBWTtuWjYCVeeZKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g1DTTNMC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C93FC116C6;
	Sat, 14 Mar 2026 16:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773505011;
	bh=q5bg5eM2OLKGIm8UcvKZIp3I/4CcsOCzuMw5COXcpwU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=g1DTTNMCb6YPTtpiCaG/vRRGYBMsOBvTlSO90GYxg3MSonwVpYB07mlmDdvTtPcXK
	 hc3GX84Kbibfq044Y21k/4XZQ3o7q3EB+AlzpI0PeXrl7l6Fcu1oxj2gh+/nAOjntq
	 r4SimN5D8Pw/NquqWjQ/HfpMHpB53qv3oZ0R1MVrZMiEIijFOH0UIRRPKH4UqiS+oD
	 LM36GIr1NxArzrfKWihOlDoWYo73voQpi3/FpOjR4s5k1po3I0DcLxwIq+SbhLV7WU
	 Inoa78tjlv7Ix8k8bBjUwJRpCB2gtj8pg2jogpmsQM7GLN0g+zKI6YxqZ3PaC2ROlS
	 VqGLx/Qcsbo1Q==
Message-ID: <41885d77-2509-445c-af01-0b1e556703ec@kernel.org>
Date: Sat, 14 Mar 2026 10:16:50 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4] ipv4: bump rt_genid when a relevant devconf value
 changes through netlink
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>,
 Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, tgraf@infradead.org, horms@kernel.org,
 pabeni@redhat.com, edumazet@google.com, davem@davemloft.net
References: <20260313144555.4956-1-fmancera@suse.de>
 <1644761b-4960-431f-bf3d-5593007212fc@kernel.org>
 <633f5de1-daeb-48ac-aba1-92b3c3ccf5c8@suse.de>
 <20260314090614.116f38cc@kernel.org>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260314090614.116f38cc@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267767-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4242B28DD79
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/14/26 10:06 AM, Jakub Kicinski wrote:
> On Fri, 13 Mar 2026 16:13:20 +0100 Fernando Fernandez Mancera wrote:
>>> Also, you are flushing the cache for more values than sysfs does.  
>>
>> I don't think so. The problem is that the handling of sysctl is 
>> scattered in several places.
>>
>> IPV4_DEVCONF_FORWARDING is flushed at devinet_sysctl_forward().
>>
>> IPV4_DEVCONF_NOXFRM, IPV4_DEVCONF_NOPOLICY, 
>> IPV4_DEVCONF_PROMOTE_SECONDARIES, IPV4_DEVCONF_ROUTE_LOCALNET, and 
>> IPV4_DEVCONF_DROP_UNICAST_IN_L2_MULTICAST are flushed at 
>> ipv4_doint_and_flush() used by macro DEVINET_SYSCTL_FLUSHING_ENTRY.
>>
>> Finally, IPV4_DEVCONF_BC_FORWARDING and IPV4_DEVCONF_ACCEPT_LOCAL are 
>> flushed at devinet_conf_proc().
>>
>> Yes, I know, the fact that they are scattered around is quite confusing. 
>> This could be all unified in a single place but that would be too much 
>> for net tree IMHO.
>>
>> Please let me know if I am missing something.
> 
> I think David means that for some knobs procfs only flushes when value
> changes "in one direct", eg
> 
>                 if (i == IPV4_DEVCONF_ACCEPT_LOCAL - 1 ||                       
>                     i == IPV4_DEVCONF_ROUTE_LOCALNET - 1)                       
>                         if ((new_value == 0) && (old_value != 0))               
>                                 rt_cache_flush(net);       
> 
> which means only flush on the 1 -> 0 transition.

logic subtleties like this example is why I was asking about a proper
refactor.

since this bug has been around for years, why worry about a patch for
-net and the back propagation to stable releases that will follow?

