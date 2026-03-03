Return-Path: <netdev+bounces-263172-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YCJDKyfUpmnHWgAAu9opvQ
	(envelope-from <netdev+bounces-263172-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 13:29:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE6F1EF6DD
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 13:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E46F300C918
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 12:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D608233D6D7;
	Tue,  3 Mar 2026 12:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dTGqJnJY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lhCDa+qh";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IpvS7NTU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dHYd82Jj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B36933B6EF
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 12:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772539552; cv=none; b=csmGgLQIc1I2gJLoQuJBk+T8YHsxp6xBNO0OUgf2imuR8x90jF9Cb/C7Zy8/2NasIVKoyVob120Q8PvRdNtX/MtuTll31uHug/gboXt4vZFadsnbwAvGSNH9abRbjFWENgsPOTWVFZNHFb+uy6cS7TKqT+3jwQjF2CVXp8vvZz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772539552; c=relaxed/simple;
	bh=LzB4seia9LdGGcAa3DsFTGS+YyXdLQgx0GX+m55i2VQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W/665l1CjP6uV7zc/Ce5SWm1pggijh+yIKDBkveLOnp/0Nb29PdKr994mqetDghXX+gkVSm2yu0a9N1LzvgW40XoY+3sWdRKZPCnRjqPzn1HGOT/p9SYgDtBE3z9Fs4LlLi089szBfKre+VZCwAO9O0MU6ms/2K2iLQv+Kn3eH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dTGqJnJY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lhCDa+qh; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IpvS7NTU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dHYd82Jj; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BA03C5BDFA;
	Tue,  3 Mar 2026 12:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772539549; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LjqFUY51oNYK56TkP49a+lLY4TvN/mDktgr3mnwu1m4=;
	b=dTGqJnJYw5Mz3Jd6tVBDPWAXMDU04wGU1hbrq6nt6Yn/MBNfqSKwoW0RmlOEpVDHflChOw
	Xs33JB1tvyhEbjT6xPkA9l3IEj2mGfiZlZiEPCkI2nGhkoHKa2eR/wtJ7vWDqysl9rhK4f
	TdgYUPLgpQDvAkDnfuD9UcEpTVG65Ds=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772539549;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LjqFUY51oNYK56TkP49a+lLY4TvN/mDktgr3mnwu1m4=;
	b=lhCDa+qhoTZ3yHSk+6LwcJi1uGLVx/FW+nI4CDplvtihxOqaB2udotNMGQ1pnMg0Bw2v0Y
	L6xxBomauZNKM7Ag==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=IpvS7NTU;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=dHYd82Jj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772539548; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LjqFUY51oNYK56TkP49a+lLY4TvN/mDktgr3mnwu1m4=;
	b=IpvS7NTUhnfEEdKPhhfIDYUsEvgwVqvdJ/QFa36fqisY16uj721+GBd9b4xLUJjcB+giRe
	AXZBJLjckTb7SnFmuh2hF2yMM5hd11v92R8IWBFis4CgMxhjzkKSL091ubcu5MPtLF1EN0
	oBBhego17BM6TYjrplPDdfA7Awflrec=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772539548;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LjqFUY51oNYK56TkP49a+lLY4TvN/mDktgr3mnwu1m4=;
	b=dHYd82JjJNp1dQxNLmloxooNkYrcxOvN04M7pYdkIg8/iu1jpDiHu/C9KPP8smvg/MsEwT
	5Q0UzYPqHbtrwvAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6181F3EA69;
	Tue,  3 Mar 2026 12:05:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 61+GFJzOpmmHdgAAD6G6ig
	(envelope-from <fmancera@suse.de>); Tue, 03 Mar 2026 12:05:48 +0000
Message-ID: <1076098b-af73-404f-a490-080dfaf59909@suse.de>
Date: Tue, 3 Mar 2026 13:05:39 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] Kernel Panic in iptfs_reassem_cont when handling large
 packets
To: Hao Long <me@imlonghao.com>, netdev <netdev@vger.kernel.org>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>
References: <DGRCO9SL0T5U.JTINSHJQ9KPK@imlonghao.com>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <DGRCO9SL0T5U.JTINSHJQ9KPK@imlonghao.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Rspamd-Queue-Id: 0FE6F1EF6DD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-263172-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.de:dkim,suse.de:mid]
X-Rspamd-Action: no action

On 3/1/26 10:49 AM, Hao Long wrote:
> Hello,
> 
> Recently I set up a strongSwan tunnel in AGGFRAG mode[1] in order to see
> how it fragments large packets.
> 
> Later I found out the receiver node will kernel panic when handling
> large packets, I tested in different distro and both panic.
> 
> Tested environment:
> - Arch Linux 6.18.13-arch1-1 strongswan-6.0.4-2
> - Arch Linux 7.0.0-rc1-1-mainline strongswan-6.0.4-2
> - NixOS 6.18.13 strongswan-6.0.4
> 
> Step to reproduce:
> 1. install strongSwan and create tunnel interface in vm1, see the
> attachment init_env.sh
> 2. do step1 in vm2, but remember to switch local_addrs and remote_addrs,
> also the ip assignment
> 3. run `ping -s 3333 10.0.1.2` in vm1, 10.0.1.2 is the ip from vm2
> 4. kernel panic in vm2
> 

I have reproduced this. I will send a patch a shortly so you can test it 
in your environment too.

Thanks,
Fernando.

> I'm not familiar in C programming and kernel developing, so sorry I can't
> provide a useful root case analyze and a fix.
> 
> Regards,
> Hao Long
> 
> [1] https://docs.strongswan.org/docs/latest/features/iptfs.html
> 


