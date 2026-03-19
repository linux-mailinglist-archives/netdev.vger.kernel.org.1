Return-Path: <netdev+bounces-269356-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJ1iBeKzu2k8mgIAu9opvQ
	(envelope-from <netdev+bounces-269356-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 09:29:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 368232C7E08
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 09:29:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 55826300349E
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 08:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F0D3A5436;
	Thu, 19 Mar 2026 08:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xBx2GB6z";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="a6vxzze+";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xBx2GB6z";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="a6vxzze+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F88399019
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 08:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773908957; cv=none; b=nlChakrL1zTElnnOuu1Rf8KQgMY8JP0GT3XU5UHCfNP+6F4vprpEiu14//5D8QIS9Ssvtxxr35jbVcYDM6hLZ7p8+xU1IfDY0sQsNyNTaqMk4rtk08t3LEXUkiKMK9/vBU7Uoy0+Gr1gMdWdwcoyRpeIwaYrVb9OnEsoPZF3EUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773908957; c=relaxed/simple;
	bh=rjtySfE0vQ4hLAcMMs0sDl5xvT6Hsnklajs5j9ksf70=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IWVWduYpoGyBgt7fwfP03TrxqAtuNGfEHrETLd7D3zNvRFuksPFP3RS+z2PbGr+ctGEOBHnW6A+aJPaIRZjUn9I+iZ3HCHmwT0+cUCHzmSy6tHxUqg5LenmG66xyfx+FG/BPZshNbvqW1Gr75WlftS+/UbaS2RcmOfm1rYXFofs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xBx2GB6z; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=a6vxzze+; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xBx2GB6z; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=a6vxzze+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3DFF05BCFB;
	Thu, 19 Mar 2026 08:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773908954; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZhAVSciAVHU3GCZLFStRnxW/osGS6eJNyz9/cSmUt8g=;
	b=xBx2GB6zOBccLDbPHsizpfEwJ6xcgCqeskLsltB5g6GEvjt3/wJu0djgqu5NCVawRHuC0L
	eWKFqfVcHA2hxPQR9BfgYRHD7+bBN8iikWdl4F+KTeQxqHWKi3JZwYgWughhDuKPjmjFEr
	t2qQg9Z5yRRz6N/IH196NW3LT9k9GcI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773908954;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZhAVSciAVHU3GCZLFStRnxW/osGS6eJNyz9/cSmUt8g=;
	b=a6vxzze+61meAjURhIlR/wYyLjm1HpXDkwjXvf/4TjB+FtWC1gfX9tUmz57xg9LHAHnBFQ
	BZHeY51uZaF8IRCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773908954; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZhAVSciAVHU3GCZLFStRnxW/osGS6eJNyz9/cSmUt8g=;
	b=xBx2GB6zOBccLDbPHsizpfEwJ6xcgCqeskLsltB5g6GEvjt3/wJu0djgqu5NCVawRHuC0L
	eWKFqfVcHA2hxPQR9BfgYRHD7+bBN8iikWdl4F+KTeQxqHWKi3JZwYgWughhDuKPjmjFEr
	t2qQg9Z5yRRz6N/IH196NW3LT9k9GcI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773908954;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZhAVSciAVHU3GCZLFStRnxW/osGS6eJNyz9/cSmUt8g=;
	b=a6vxzze+61meAjURhIlR/wYyLjm1HpXDkwjXvf/4TjB+FtWC1gfX9tUmz57xg9LHAHnBFQ
	BZHeY51uZaF8IRCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8DCE84273B;
	Thu, 19 Mar 2026 08:29:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZlitH9mzu2npdgAAD6G6ig
	(envelope-from <fmancera@suse.de>); Thu, 19 Mar 2026 08:29:13 +0000
Message-ID: <66cfa9d9-760a-4ef0-8139-cd7f27115f09@suse.de>
Date: Thu, 19 Mar 2026 09:28:54 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10 net-next v3] Convert CONFIG_IPV6 to built-in and
 remove stubs
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org, rbm@suse.com,
 linux-kernel@vger.kernel.org
References: <20260317140141.5723-1-fmancera@suse.de>
 <20260317124904.552d57e4@kernel.org>
 <ea482a29-b9bd-4365-b771-2bc03bebad3c@suse.de>
 <20260318162134.5906d048@kernel.org> <20260318174812.2dafba4d@kernel.org>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260318174812.2dafba4d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269356-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.de:dkim,suse.de:mid]
X-Rspamd-Queue-Id: 368232C7E08
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/19/26 1:48 AM, Jakub Kicinski wrote:
> On Wed, 18 Mar 2026 16:21:34 -0700 Jakub Kicinski wrote:
>>> This is test is applying the series in top of bpf tree which has this
>>> commit
>>> https://github.com/kernel-patches/bpf/commit/972787479ee73006fddb5e59ab5c8e733810ff42
>>>
>>> AFAICS, net-next tree do not have it yet. I do not think I can do much
>>> about it for now. Will wait until they are merged and rebase in top of it.
>>
>> I see, hopefully trees converge tomorrow, else we can fix it when
>> merging.
> 
> Looking closer and talking to Alexei the fix is actually in bpf-next
> not in bpf. So let's just merge your code and we'll deal with the
> fallout. But please still look into the fowarding warnings, of course.
> 

Yes I already handled the forwarding warnings. I am surprised this 
wasn't spotted by the AI :/

Thanks,
Fernando.

