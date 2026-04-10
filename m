Return-Path: <netdev+bounces-277337-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mD+RACHe2GnHjAgAu9opvQ
	(envelope-from <netdev+bounces-277337-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 13:25:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 389693D6217
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 13:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA664300421A
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 11:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68CC639D6DA;
	Fri, 10 Apr 2026 11:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CKWsDgtd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pvzj8iCe";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CKWsDgtd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pvzj8iCe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3F339B955
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 11:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775819978; cv=none; b=XxAIOHlXfTEMj3mUSx4qi7aaN3eqLUCs12Hf5UC5Fxe/iJ/AneEWo9bd2QYw5wd7mJXfV+yiObHMGvAYL2GX15DMTFWat2NFYqitGGHoFj2x8YjgwthRevYMnmICdEKSqObrWw9lMfAAnesr+rx4qEO3BXgYYHRQtpK5Jky8aYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775819978; c=relaxed/simple;
	bh=ukG5LB3feRHiniCPbqwIlVVeD3wnrBAiYT6Vqp1awdQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=NJPxaUs85GlvrSjX9gfbRkqBRaxaxhO4EozKQdBjkm3vGuYiKy5KHbCZFM7QuvCPBzgxLyKjBcxww/25vvG73B0olsC33uJrifAUJvjBQ0ZFoqijDhHd2KW2qSniKnvKkFIWi0O+iv6RcQX53wMniGn+woYb3D36e7sa975gnys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CKWsDgtd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pvzj8iCe; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CKWsDgtd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pvzj8iCe; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 029AA5BD4B;
	Fri, 10 Apr 2026 11:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775819975; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DH67o0RFE28wRLIPOFTPMyFR6JG50Aqr5JJumpkoe+0=;
	b=CKWsDgtdfhncqkfmO1HahPU5qI0ceqcUgkUgZAL5RGeBukovxpprw6NZ9HZQ3rtD4y2vmB
	luYDdKk/P+vkuk1erMsmiWQokyHxXJ3VAjjfBQFN6A0t+HniW5bkTT7I4iDXCrrRsMByJ+
	GiIk/Lazx3u1aDVuP8qTc5ZdNcbp2xo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775819975;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DH67o0RFE28wRLIPOFTPMyFR6JG50Aqr5JJumpkoe+0=;
	b=pvzj8iCeJvgTwpTYa/fnnaUGFauOBAgO2UcDeBEItGLTMByKwcRENd5sl+U9lTRBp/ucDH
	hzoUdmOUCABJK9CQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=CKWsDgtd;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=pvzj8iCe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775819975; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DH67o0RFE28wRLIPOFTPMyFR6JG50Aqr5JJumpkoe+0=;
	b=CKWsDgtdfhncqkfmO1HahPU5qI0ceqcUgkUgZAL5RGeBukovxpprw6NZ9HZQ3rtD4y2vmB
	luYDdKk/P+vkuk1erMsmiWQokyHxXJ3VAjjfBQFN6A0t+HniW5bkTT7I4iDXCrrRsMByJ+
	GiIk/Lazx3u1aDVuP8qTc5ZdNcbp2xo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775819975;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DH67o0RFE28wRLIPOFTPMyFR6JG50Aqr5JJumpkoe+0=;
	b=pvzj8iCeJvgTwpTYa/fnnaUGFauOBAgO2UcDeBEItGLTMByKwcRENd5sl+U9lTRBp/ucDH
	hzoUdmOUCABJK9CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8ABB74A0B2;
	Fri, 10 Apr 2026 11:19:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id F8M2Hsbc2GmILAAAD6G6ig
	(envelope-from <fmancera@suse.de>); Fri, 10 Apr 2026 11:19:34 +0000
Message-ID: <76a3d1de-fca2-432e-a4e4-5fcfde98eeca@suse.de>
Date: Fri, 10 Apr 2026 13:19:25 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] ipv4: icmp: fix null-ptr-deref in icmp_build_probe()
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: Dan Carpenter <error27@gmail.com>, Yiqi Sun <sunyiqixm@gmail.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
References: <adjOCdCW1EpPl8lf@stanley.mountain>
 <00cba68f-2e37-4ad9-872b-cc41a113de00@suse.de>
Content-Language: en-US
In-Reply-To: <00cba68f-2e37-4ad9-872b-cc41a113de00@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277337-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[suse.de:+];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.de:dkim,suse.de:mid]
X-Rspamd-Queue-Id: 389693D6217
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/10/26 12:51 PM, Fernando Fernandez Mancera wrote:
> On 4/10/26 12:16 PM, Dan Carpenter wrote:
>> Hello Yiqi Sun,
>>
>> Commit fde29fd93493 ("ipv4: icmp: fix null-ptr-deref in
>> icmp_build_probe()") from Apr 2, 2026 (linux-next), leads to the
>> following Smatch static checker warning:
>>
>>     net/ipv4/icmp.c:1351 icmp_build_probe()
>>     warn: 'dev' is not an error pointer
>>
>> net/ipv4/icmp.c
>>      1341 #if IS_ENABLED(CONFIG_IPV6)
>>      1342                 case ICMP_AFI_IP6:
>>      1343                         if (iio- 
>> >ident.addr.ctype3_hdr.addrlen != sizeof(struct in6_addr))
>>      1344                                 goto send_mal_query;
>>      1345                         dev = ipv6_dev_find(net, &iio- 
>> >ident.addr.ip_addr.ipv6_addr, dev);
>>      1346
>>      1347                         /*
>>      1348                          * If IPv6 identifier lookup is 
>> unavailable, silently
>>      1349                          * discard the request instead of 
>> misreporting NO_IF.
>>      1350                          */
>> --> 1351                         if (IS_ERR(dev))
>>      1352                                 return false;
>>
>> It looks like there were two patches that went in around the same
>> time.  Commit fde29fd93493 ("ipv4: icmp: fix null-ptr-deref in
>> icmp_build_probe()") updated the checking for
>> ipv6_stub->ipv6_dev_find() but d98adfbdd5c0 ("ipv4: drop ipv6_stub usage
>> and use direct function calls") changed it to not return error pointers.
>>
>> This IS_ERR() check can be removed.
>>
> 
> Yes, I thought it was going to happen during merging but I guess it 
> makes sense to do it on a separate patch.
> 

Actually, I believe this has been handled during the net merge with 
net-next.

https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=b6e39e48469e37057fce27a1b87cf6d3e456aa42

It should reach linux-next, so all good.

Thanks,
Fernando.

