Return-Path: <netdev+bounces-275997-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AO1RICIL1WlQzwcAu9opvQ
	(envelope-from <netdev+bounces-275997-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 15:48:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5ED3AF71D
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 15:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C07C30FD2BB
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 13:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604E23BA237;
	Tue,  7 Apr 2026 13:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="twrss0rC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nCP1aKHz";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="twrss0rC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nCP1aKHz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEDE3B9DA9
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 13:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775569045; cv=none; b=kIY8plkgyV/pWyzait1YoxlCWiJW9Xa+yA0EjFMCvHOTyX44/YWYQhMn74WLWvY4xWignaxjvm/i3Np7ZJ3YNuSDQ13BOQFEZGxdmRTCjXu4+9534GMnNBa6qVDF6IITMxREkSIXM7yIe4XRFhgcFdzNrjljqn2ZxdEsR6jUwDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775569045; c=relaxed/simple;
	bh=KN/dorCqDpCgbJbv9MByARZpWybjjuffk5SEcyCBF2k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BkWHSS+TjNLmvAoFw0wVAhOptM1J3P6Dy1dEpj5D51WwrY7OcKSgupbe2roOPKvbrBqOUHox73xomtt3Bh7bJDa9RZfdDQs1cLNkyMVIDySwgsKHmpKQTenn7iWI631X5WCDOLpoKFlsn9gz2CrKYX4Ztv62KOai1YIJjZ1uLZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=twrss0rC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nCP1aKHz; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=twrss0rC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nCP1aKHz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0FE365BD6C;
	Tue,  7 Apr 2026 13:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775569042; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=baED2cWw2KCUCxFd3JykN/toCiAn2SshVfG1NPWtzrc=;
	b=twrss0rCX0RLfLLtVqhiBZUFsnHLJuk1WQAYs1LUUSSnN/c063CpEl6SVx/Mwbt/O0zIq6
	Rnmt1c+v/6+LBLO3reYWfWOmrq4SQB4xYHLhwtPNGv8fQoud/o1BAXG1yhbiTInUl0Vgav
	gNjRDgmZk+thr05jnTiLSBKWSoKmfb0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775569042;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=baED2cWw2KCUCxFd3JykN/toCiAn2SshVfG1NPWtzrc=;
	b=nCP1aKHzNNSg/tsGp4InW/3JdkYq7NYEjvdp0Gwze3HNXa9DadWZIhftnTHpjmKjqkKKSK
	DiTHtgzK557z7tBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=twrss0rC;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=nCP1aKHz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775569042; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=baED2cWw2KCUCxFd3JykN/toCiAn2SshVfG1NPWtzrc=;
	b=twrss0rCX0RLfLLtVqhiBZUFsnHLJuk1WQAYs1LUUSSnN/c063CpEl6SVx/Mwbt/O0zIq6
	Rnmt1c+v/6+LBLO3reYWfWOmrq4SQB4xYHLhwtPNGv8fQoud/o1BAXG1yhbiTInUl0Vgav
	gNjRDgmZk+thr05jnTiLSBKWSoKmfb0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775569042;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=baED2cWw2KCUCxFd3JykN/toCiAn2SshVfG1NPWtzrc=;
	b=nCP1aKHzNNSg/tsGp4InW/3JdkYq7NYEjvdp0Gwze3HNXa9DadWZIhftnTHpjmKjqkKKSK
	DiTHtgzK557z7tBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 69D1B4A0B0;
	Tue,  7 Apr 2026 13:37:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cGnNFpEI1WkIWwAAD6G6ig
	(envelope-from <fmancera@suse.de>); Tue, 07 Apr 2026 13:37:21 +0000
Message-ID: <d38ea95d-98d2-42ab-aea0-3099ab05082d@suse.de>
Date: Tue, 7 Apr 2026 15:37:12 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: hsr: emit notification for PRP slave2
 changed hw addr on port deletion
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: acsjakub@amazon.de, liuhangbin@gmail.com, kees@kernel.org,
 horms@kernel.org, kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
 fmaurer@redhat.com, Luka Gejak <luka.gejak@linux.dev>
References: <20260403123928.4249-2-fmancera@suse.de>
 <756852a4-b589-4eeb-81bf-963fa2e71821@redhat.com>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <756852a4-b589-4eeb-81bf-963fa2e71821@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FREEMAIL_CC(0.00)[amazon.de,gmail.com,kernel.org,google.com,davemloft.net,redhat.com,linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275997-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,suse.de:mid,linux.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CF5ED3AF71D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/7/26 3:29 PM, Paolo Abeni wrote:
> On 4/3/26 2:39 PM, Fernando Fernandez Mancera wrote:
>> On PRP protocol, when deleting the port the MAC address change
>> notification was missing. In addition to that, make sure to only perform
>> the MAC address change on slave2 deletion and PRP protocol as the
>> operation isn't necessary for HSR nor slave1.
>>
>> Note that the eth_hw_addr_set() is correct on PRP context as the slaves
>> are either in promiscuous mode or forward offload enabled.
>>
>> Fixes: b65999e7238e ("net: hsr: sync hw addr of slave2 according to slave1 hw addr on PRP")
>> Reported-by: Luka Gejak <luka.gejak@linux.dev>
>> Closes: https://lore.kernel.org/netdev/DHFCZEM93FTT.1RWFBIE32K7OT@linux.dev/
>> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
>> ---
>> Note: routed through net-next tree as the next net tree as rc6 batch is
>> already out and I do not think this is worth to be included in a last
>> call batch. Anyway, if maintainer thinks it is, feel free to apply it to
>> net tree.
> 
> The general guidance is to avoid fixes tag for net-next patches that do
> not fix net-next specific code. In this case I assume you want the patch
> landing into stable right?
> 

Hi Paolo,

Noted. I wanted to reduce the number of patches on net tree given we are 
at the end of the development cycle. To be honest, the stable backport 
isn't that important here, this is a trivial fix that I doubt it was 
breaking anyone.

Maybe drop Fixes tag and get it into net-next then? Fine for me anyway, 
I trust your judgement on this.

Thanks,
Fernando.

> I think a net target would be better, please LMK.
> 
> /P
> 


