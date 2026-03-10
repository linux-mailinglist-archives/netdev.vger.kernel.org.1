Return-Path: <netdev+bounces-266313-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHsdCSR5sGnLjgIAu9opvQ
	(envelope-from <netdev+bounces-266313-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 21:03:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E520257509
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 21:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6EBCE3036D5A
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 20:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E3C3E8699;
	Tue, 10 Mar 2026 20:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AesxHHdH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF5A3E8693;
	Tue, 10 Mar 2026 20:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773172965; cv=none; b=nSZFPXzXk5xOd6O6rFw+/bp02LkD3T7SJh94eeJOunZQvAJl+dBOQiNfhzZ/OxATyVdx74OOCEQWZbiBZdIaeFg/6lCoMpyRanhyfF5ErIf/9isB3+OWGXbuLVxNeMwmaNpVTAu6dnoeP4NMei11YVxrWYiTycfGmau/8R3Q5co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773172965; c=relaxed/simple;
	bh=vHd0VEFZ+Pg8KfcMbMmBXHtIfaZNvkk4N1vOcpruSJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=td6rbiVNC04vDg76LaaTx+drjKO/RppaLnqMiyYDpJP9ZMvwvrBmBwCZ17yFgNDeg4C0hch3aMAIdNhhvUm4D0FXLppyHT42e7hsEQv2jJ7UQNhshZ75Bt7Nj/aiaAP2771LxonhRDry/cHHpj/FIjK5BVIe+pux1KBFkoRYjNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AesxHHdH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D70FFC19423;
	Tue, 10 Mar 2026 20:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773172964;
	bh=vHd0VEFZ+Pg8KfcMbMmBXHtIfaZNvkk4N1vOcpruSJw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AesxHHdH7pt9am+/onq+fA1Ro9jP5fy3kMVzraQ9SItXhOT/ryvmJnnjNnVzIoD2Z
	 0cHOvJGluH9vQwCgua2URdqC2QHpSIpAhz/ZWgPU8n7UaapUEfH5eDopvJ7pCp76NJ
	 +rBLkLJaAw9fFlM/m9pKTetRUZX2tM2jZHe3oD/Ub3JaoSDIkdmrHI/B72WFwtY6x+
	 smlJ9gGhJq5x8SsMzOyILzJj16Woe4VQ+TE7qrztrYLJi7Gne7A4ZU9iQmcsGIGcKh
	 einNfqRjS7Zs/74yHGMpRTco7qsx1foQMwM3Hk5kHjh9gUfPXPKDOm1ikkZJIPreuG
	 tBcCEvr5cjNfg==
Message-ID: <411bcf03-5993-478d-9809-3e04567ff09a@kernel.org>
Date: Tue, 10 Mar 2026 21:02:40 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10 net-next] Convert CONFIG_IPV6 to built-in and remove
 stubs
To: Jakub Kicinski <kuba@kernel.org>
Cc: Fernando Fernandez Mancera <fmancera@suse.de>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org
References: <20260309022013.5199-1-fmancera@suse.de>
 <48ccec3f-dbc8-45c8-afda-e4f7e8f150d6@kernel.org>
 <f4598201-2115-43e3-9da8-22583ae67db2@kernel.org>
 <20260309161826.46074d55@kernel.org>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20260309161826.46074d55@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 7E520257509
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266313-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 10/03/2026 00:18, Jakub Kicinski wrote:
> On Mon, 9 Mar 2026 11:26:08 +0100 Krzysztof Kozlowski wrote:
>> Heh, I just checked, that's 6 MB module on arm64 which apparently you
>> want to put into the kernel!
> 
> Pretty sure you get 6MB because you have DEBUG_INFO enabled?

Yeah, that was defconfig with KASAN, not full debug info. defconfig
comes with deduced debug info.  In one of other email threads I
corrected that actual size on distro kernel is much smaller, e.g.
200-400 kB depending on arch or distro settings.

> IMO "I have full debug info but I care about kernel size" is
> internally inconsistent.

My argument is that many of arm64 devices I work with have fixed
partition sizes, come with their own bootloader which uses separate
fixed-size boot partition. I still want to be able to load arm64
defconfig into that boot partition. If it does not fit, I need to tweak
defconfig, e.g. disable some options.

I find it valid usecase and I was disagreeing here with that cloud-only
or big-machines-only approach.

> 
> Here is the top line of bloatometer without debug info:
> 
>   add/remove: 1769/7 grow/shrink: 86/0 up/down: 374521/-228 (374293)
> 
> The vmlinux increases by 200kB with IPv6 built in.
> Not a very dramatic increase.
> 
> Please note that opening any dual-stack socket will cause the IPv6
> module to get loaded. And opening a dual-stack socket will fail if 
> IPv6 is blacklisted. So I find it quite hard to believe that other
> that deeply embedded systems with custom configs there are systems
> out there which don't end up with IPv6 loaded. Whether they have 
> a single IPv6 address configured or not.

Yes, Ubuntu for that reasons does not have it even as module.

This should be used as *the* argument for these changes.

> 
> And if we stop supporting =m we can actually turn a bunch of indirect
> calls into static inlines so in practice the memory use on real system
> will be lower! 
> 
> Please be reasonable, this is objectively the right move.

I am very reasonable, just need to hear reasons. Just to remind - none
of the machines I have, none of the routers, none of the mobile phones
on 4G and 5G receive IPv6 so they don't actually need it. Not having
IPv6 built-in is therefore a valid use case.

Best regards,
Krzysztof

