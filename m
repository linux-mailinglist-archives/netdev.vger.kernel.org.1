Return-Path: <netdev+bounces-270510-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SDOfAxQwwWnERQQAu9opvQ
	(envelope-from <netdev+bounces-270510-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 13:20:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A112F1D07
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 13:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6D80E300E6B5
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 12:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E1439DBD7;
	Mon, 23 Mar 2026 12:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qEQ+c+Ty";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0eCCU+gg";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qEQ+c+Ty";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0eCCU+gg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FD039D6EF
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 12:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774268406; cv=none; b=VktR6MDfJ+o282O/OTSGwWgOtu+IlixxgSyDM+3ET45m5i03d4q3GCqhDBwwnM4JUOJ66AnFb+KeoRADarPdJfA2CvuMJtc0VjIjCsZiVkmPNu89w4nV+Jhg+RQaNNpn1BuNTeJzE571cJtS+f+41sOZsPWjGkMtFDYCMWdkYEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774268406; c=relaxed/simple;
	bh=DTJU6mfOY7VUa3VHCWo22zGLnc7oPJMLFXk1+yPJWDc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UxmEM6wTB0fBYgOZHmwlZd8Kk95vnVkgoDZCTfCHLxewR2xcF7bPQ/yHjZD3nwM6r2pdQBUeCmlD2H0UBMOBiHnl+U9z2W4MRbktkdMtmBT4Slkr1AaCofd9gQIMuJouA/C+jmAIYSBA9+ipv6L6glOEQ+SDP91fHekq1RWPm6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qEQ+c+Ty; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0eCCU+gg; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qEQ+c+Ty; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0eCCU+gg; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F3AD45C005;
	Mon, 23 Mar 2026 12:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774268403; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=He1UdXahEe/Uy2+KBTuGLFJLSZm8cId7WUyPKqV7vIE=;
	b=qEQ+c+TyiqlMLGkWMelC9d8rk0Cw0dXaANFdO5x5ZiSuj9QkBVIUb/+oXkiyV7/z4DGARV
	3JEJFHMOxzvOrH7UgoKtuC5PkvFFUZ6WxX5LqeXITsZBQoq7fGxiSpi5Nfyx/M0KYbVuHw
	XlzagtYmSaegWMT2xr+iFqQhGgRiVn0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774268403;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=He1UdXahEe/Uy2+KBTuGLFJLSZm8cId7WUyPKqV7vIE=;
	b=0eCCU+gg9W8RsQG803a765JbeEt7Lk9XAebkKGcbKGKuyEYhB9NASRZjBgPV8lxRH+7JE2
	9Q54Vrv5Z48ExrCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774268403; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=He1UdXahEe/Uy2+KBTuGLFJLSZm8cId7WUyPKqV7vIE=;
	b=qEQ+c+TyiqlMLGkWMelC9d8rk0Cw0dXaANFdO5x5ZiSuj9QkBVIUb/+oXkiyV7/z4DGARV
	3JEJFHMOxzvOrH7UgoKtuC5PkvFFUZ6WxX5LqeXITsZBQoq7fGxiSpi5Nfyx/M0KYbVuHw
	XlzagtYmSaegWMT2xr+iFqQhGgRiVn0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774268403;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=He1UdXahEe/Uy2+KBTuGLFJLSZm8cId7WUyPKqV7vIE=;
	b=0eCCU+gg9W8RsQG803a765JbeEt7Lk9XAebkKGcbKGKuyEYhB9NASRZjBgPV8lxRH+7JE2
	9Q54Vrv5Z48ExrCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5DBB243888;
	Mon, 23 Mar 2026 12:20:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Q2K8E/IvwWk+FQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Mon, 23 Mar 2026 12:20:02 +0000
Message-ID: <8c136575-e23e-4cc2-a455-f1ba1abde2d5@suse.de>
Date: Mon, 23 Mar 2026 13:19:56 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/11 net-next v4] Convert CONFIG_IPV6 to built-in and
 remove stubs
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org,
 rbm@suse.com, linux-kernel@vger.kernel.org
References: <20260320185649.5411-1-fmancera@suse.de>
 <20260322172702.GA121169@shredder>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260322172702.GA121169@shredder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270510-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E5A112F1D07
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/22/26 6:27 PM, Ido Schimmel wrote:
> On Fri, Mar 20, 2026 at 07:55:52PM +0100, Fernando Fernandez Mancera wrote:
>> Changes:
>>    v4:
>>      Patch 2: new patch introduced on this revision
>>      Patch 3: drop some IS_BUILTIN(IPV6) on files compiled only when IPV6=y
>>      Patch 5: introduce ipv6_mod_enabled() checks on fib6_nh_init(), ip6_dst_lookup_flow() and ip6_fragment() to avoid crash when ipv6.disable=1 during boot
>>      Patch 6: use &nd_tbl on code guarded by IS_ENABLED(CONFIG_IPV6)
> 
> The IPv6 code is still using ipv6_get_nd_tbl() for some reason. If you
> remove it from there (it's not needed), then we are only left with
> handful of users that can be converted to use '&nd_tbl' when IPv6 is
> enabled. Something like the patch below.
> 
Hi Ido, the main reason why ipv6_get_nd_tbl() is used on IPv6 code is 
due to inlined functions. __ipv6_neigh_lookup_noref() is used in several 
places not guarded by IS_ENABLED(CONFIG_IPV6) preprocessor directive. 
That leads to undefined references when compiling with CONFIG_IPV6=n.

ld: vmlinux.o: in function `bpf_ipv4_fib_lookup':
filter.c:(.text+0x322b9dc): undefined reference to `nd_tbl'
ld: filter.c:(.text+0x322b9fb): undefined reference to `nd_tbl'
ld: filter.c:(.text+0x322ce1a): undefined reference to `nd_tbl'
ld: vmlinux.o: in function `ipv4_confirm_neigh':
route.c:(.text+0x345ade7): undefined reference to `nd_tbl'
ld: route.c:(.text+0x345ae06): undefined reference to `nd_tbl'
ld: vmlinux.o:route.c:(.text+0x345b74f): more undefined references to 
`nd_tbl' follow

I think that using ipv6_get_nd_tbl() is cleaner than guarding the usage 
of nd_tbl inside the function itself. In addition, I do not think we 
need to guard every __ipv6_neigh_lookup_noref_stub() instance we are 
dropping/replacing because that code should never be reached with 
ipv6.disabled=1 or CONFIG_IPV6=n, otherwise it would crash. That means 
it should be safe to use ipv6_get_nd_tbl() there.

What do you think Ido? I can still drop ipv6_get_nd_tbl() but it will 
require some IS_ENABLED(IPV6) preprocessor checks.

Thanks,
Fernando

