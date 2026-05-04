Return-Path: <netdev+bounces-283913-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFg7Nj63+Gn1zAIAu9opvQ
	(envelope-from <netdev+bounces-283913-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 17:11:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86FF64C07DB
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 17:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B5FF3055DE7
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 15:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0F43DFC8E;
	Mon,  4 May 2026 15:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NQgXsUy1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="itUItP3u";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NQgXsUy1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="itUItP3u"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59743D5254
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 15:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777907334; cv=none; b=cQbN+mBh3NzBY4g+BV7gYhSKHORL38juV03lRInVRyA3HmYicKgT7S9D0hfnpYB0EDv3KATMuGU7XtIRkuXMg0uTKkoMk8VElPKyNBMAoO/Oy/cRgs/4+yc9r3h+8+lpLTnO3eE3NLmwWl31j8mA/y63upHWQLyi9MWQjBAhFwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777907334; c=relaxed/simple;
	bh=Ea5omULVnzdaSjNy5tojSHOvj5WfXMMZWBGEsxlHK2w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j6NFjSKUgZUfur+KZV9DkHv5LwhAOy5o9E1ciwZhNipVCehDiwJmQbb7I/yDxHmVxfKiZpDXPioAbU9Tq0bTBsweaP4RDM6jvJDosCGEQxmpcJP0IgWmjDtzjqYey0+oosF3hv+UokTFfIhwutHesgmnvln4GeYSv9yQJA86dx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NQgXsUy1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=itUItP3u; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NQgXsUy1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=itUItP3u; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 127D15C776;
	Mon,  4 May 2026 15:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777907330; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lek3YVoWv/e5/EeAqCEpXt+87ZWsgHySNiTH6wyzoBU=;
	b=NQgXsUy1PRMgynFaRG7/cG4QwRTzTywCAc/Sf6dRYem+3tLrBeVkSLIZKie/YrxXY1ebN1
	nqzTnXe+BsgbybBnBxURmgsWSLKyu4T5CgPkZRfFrwNdZlOiJ26/nk61T0oi1/heEaH41o
	+W6WJ1OlDW1wSNkdJN2Gq+T6K3dXiUg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777907330;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lek3YVoWv/e5/EeAqCEpXt+87ZWsgHySNiTH6wyzoBU=;
	b=itUItP3ufWRswEPeNbGEbc0GaWfv2c7i3UN4RESyHhd9GklNy3ifQhV5B4dJJk/b/TNAha
	hi9/NRRDYJY7+UCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777907330; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lek3YVoWv/e5/EeAqCEpXt+87ZWsgHySNiTH6wyzoBU=;
	b=NQgXsUy1PRMgynFaRG7/cG4QwRTzTywCAc/Sf6dRYem+3tLrBeVkSLIZKie/YrxXY1ebN1
	nqzTnXe+BsgbybBnBxURmgsWSLKyu4T5CgPkZRfFrwNdZlOiJ26/nk61T0oi1/heEaH41o
	+W6WJ1OlDW1wSNkdJN2Gq+T6K3dXiUg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777907330;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lek3YVoWv/e5/EeAqCEpXt+87ZWsgHySNiTH6wyzoBU=;
	b=itUItP3ufWRswEPeNbGEbc0GaWfv2c7i3UN4RESyHhd9GklNy3ifQhV5B4dJJk/b/TNAha
	hi9/NRRDYJY7+UCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 88DC1593A3;
	Mon,  4 May 2026 15:08:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uICQHoG2+GmNAgAAD6G6ig
	(envelope-from <fmancera@suse.de>); Mon, 04 May 2026 15:08:49 +0000
Message-ID: <1cc469cf-b337-4c4d-8bbf-ff65ab10f4ed@suse.de>
Date: Mon, 4 May 2026 17:08:49 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3 net-next v3] selftests: net: add test for IPv4 devconf
 netlink notifications
To: netdev@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org, horms@kernel.org, pabeni@redhat.com,
 kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
 idosch@nvidia.com, dsahern@kernel.org
References: <20260504123143.6284-1-fmancera@suse.de>
 <20260504123143.6284-3-fmancera@suse.de>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260504123143.6284-3-fmancera@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 
X-Rspamd-Queue-Id: 86FF64C07DB
X-Rspamd-Action: no action
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_FROM(0.00)[bounces-283913-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid]

On 5/4/26 2:31 PM, Fernando Fernandez Mancera wrote:
> Introduce a new test, `ipv4_devconf_notify`, to verify that the kernel
> sends the appropriate netlink notifications when IPv4 devconf parameters
> are modified.
> 
> Since YNL currently has a bug where it declares an array of u32 values
> instead of the nested attributes expected by the kernel for devconf set
> operations, a temporary hack (`patched_add_attr`) is included to
> pack the netlink attributes correctly.
> 
> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
> ---
> v3: added this patch to the series as requested by Paolo.
> ---

I just learnt about ruff. There are two new warnings. I will repost 
fixing them.

Sorry for the noise.

---
pw-bot: cr

