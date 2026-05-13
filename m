Return-Path: <netdev+bounces-287460-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CBv5GkAtBGodFAIAu9opvQ
	(envelope-from <netdev+bounces-287460-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 09:50:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C0B52EFD4
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 09:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D0583019900
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 07:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B274D381B1F;
	Wed, 13 May 2026 07:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vbnkw2bx";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="T1vJne0+";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vbnkw2bx";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="T1vJne0+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E40367298
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 07:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778658546; cv=none; b=Wp/Kn+8pYZbkpJV+pqo01WDWm5H4UcEayvNxGFwfG4hGAHOPc7pCrHW4HLlDciwoYOU9ULTpetANejB7eToDMnLYFKYxrl9BsWFy8YyN0NNk7zoafbxQ+oQxk6pAuhpwBSxvqi8NjuTc9lbA14wW5eBENbYZpmzSHBYCCJFQLuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778658546; c=relaxed/simple;
	bh=ahIwPZcGi/ln6v9P0jZBLgxpI/H8uxX2WW99N93Qta8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=il4wxArao+jM1SZifxqz9svoS1xaPF/NeSj7XkeZaKOpDqAhya0God60TKUncSUqQcYn8nXgv3pk1x03iRFQaqJawI9N+8lmzlXXoWBLJ3h93teBTn1YclYh/HdDngOODsgNkAtcdgjYmfstJaYfQpITOpYLCEs5eVE6VNgOfx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vbnkw2bx; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=T1vJne0+; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vbnkw2bx; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=T1vJne0+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6A1845CE09;
	Wed, 13 May 2026 07:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778658538; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wMJMlMQPSuxwjvXvqHC6jABkQ92OmYGpsXRMnuaeH48=;
	b=vbnkw2bxbrN4J8Z3wkkmthUpiKzsJAobiHc130b4fI9M6vNXZvU3Ki93srxx7QIWLnLwqM
	Ad78KpiS2C+IgfovUXPBLlVKnsJsw222+KoZeX/ILRLGeLBjLzra9NLex9a7tP5CnAVkKK
	/oEzYuye4/0DhD7WuZ3K7CMrPmBdGEg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778658538;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wMJMlMQPSuxwjvXvqHC6jABkQ92OmYGpsXRMnuaeH48=;
	b=T1vJne0+MboSisp/EyZ7/gOsyoSNvdWD/fDtvJv1UqtRUwzdYQwGN3dFNxLUIXnACVkJcj
	sZqpN6AgQSPE+WDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778658538; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wMJMlMQPSuxwjvXvqHC6jABkQ92OmYGpsXRMnuaeH48=;
	b=vbnkw2bxbrN4J8Z3wkkmthUpiKzsJAobiHc130b4fI9M6vNXZvU3Ki93srxx7QIWLnLwqM
	Ad78KpiS2C+IgfovUXPBLlVKnsJsw222+KoZeX/ILRLGeLBjLzra9NLex9a7tP5CnAVkKK
	/oEzYuye4/0DhD7WuZ3K7CMrPmBdGEg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778658538;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wMJMlMQPSuxwjvXvqHC6jABkQ92OmYGpsXRMnuaeH48=;
	b=T1vJne0+MboSisp/EyZ7/gOsyoSNvdWD/fDtvJv1UqtRUwzdYQwGN3dFNxLUIXnACVkJcj
	sZqpN6AgQSPE+WDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D1CE1593A9;
	Wed, 13 May 2026 07:48:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id g71cMOksBGreBgAAD6G6ig
	(envelope-from <fmancera@suse.de>); Wed, 13 May 2026 07:48:57 +0000
Message-ID: <6a4daea6-928e-43a8-82dd-d669897330e0@suse.de>
Date: Wed, 13 May 2026 09:48:51 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2 net v4] ipv6: addrconf: fix temp address generation
 after prefix deprecation
To: Ido Schimmel <idosch@nvidia.com>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 horms@kernel.org, pabeni@redhat.com, edumazet@google.com,
 dsahern@kernel.org, davem@davemloft.net, =?UTF-8?Q?=C5=81ukasz_Stelmach?=
 <steelman@post.pl>
References: <20260511122645.6233-2-fmancera@suse.de>
 <20260512170117.0d7034f3@kernel.org> <20260513071722.GA334995@shredder>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260513071722.GA334995@shredder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 
X-Rspamd-Queue-Id: B7C0B52EFD4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287460-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.de:mid,suse.de:dkim]
X-Rspamd-Action: no action

On 5/13/26 9:17 AM, Ido Schimmel wrote:
> On Tue, May 12, 2026 at 05:01:17PM -0700, Jakub Kicinski wrote:
>> On Mon, 11 May 2026 14:26:45 +0200 Fernando Fernandez Mancera wrote:
>>> When a router temporarily deprecates an IPv6 prefix (either by sending a
>>> Router Advertisement with Preferred Lifetime = 0 or by letting the
>>> lifetime expire) and later restores it, the kernel permanently loses its
>>> ability to generate temporary privacy addresses (RFC 8981) for that
>>> prefix.
>>>
>>> This happens because the address worker attempts to generate a
>>> replacement temporary address when the current one nears expiration. As
>>> the base prefix is deprecated already, the generation fails after
>>> marking the temporary address as already having spawned a replacement
>>> (ifp->regen_count++).
>>>
>>> When the router eventually restores the prefix, the temporary address
>>> becomes active again. However, once it naturally expires, the address
>>> worker sees this temporary address already tried to generate one and
>>> skips the regeneration.
>>>
>>> Fix this by checking if all temporary addresses for a given prefix have
>>> already tried to spawn a replacement when processing a new RA. If so,
>>> spawn a new temporary address.
>>>
>>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>>
>> No feedback on the patch itself, but I wanted to check - Ido, do you
>> think this is worth handling as a fix? Sounds like this scenario never
>> worked.
> 
> No, I think we should target net-next. The scenario never worked and the
> fix has the potential to cause other issues.
> 

That is fine for me too.

> Fernando, please wait with the next version. I need some time to go over
> the Sashiko feedback.

Sure thing, no need to rush it.

Thanks Ido!

