Return-Path: <netdev+bounces-274282-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sFfAKP2vzWmifwYAu9opvQ
	(envelope-from <netdev+bounces-274282-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 01:53:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A1EA3381CEE
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 01:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 860D53019E1A
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 23:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63F63DCDA1;
	Wed,  1 Apr 2026 23:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="H9E6AoG8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jf5RWZ9m";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QFlSTNms";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="r8rj9A8N"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1C33CEBA6
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 23:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775087607; cv=none; b=QKomJGTsf6vsEctd1aKpxJFfvglfjQ/AYMfzpL7kOqlACo4l1Jqm+5oUiGeAlrniGgjZsEfRa37AG98PVXju8XDsnxtVz7R3Iv8ufC31DGtMjzq+EQvaQ2A9NyaycU8uGmK+HutHHYz2haGxx7IWabgzbL0MpGs/5itvgz7lDW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775087607; c=relaxed/simple;
	bh=dLawc9XkefB8NgQCmjH1g0c3gVOn/tn05tJgKc4B2s8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n16A3rKxvoqIjama7aqGyrn4aIYFV4ZdlokC6NIoGkJS3UOLOTRZYv9YVOz6WezAcis2lM4bJPVCWua1urz8aUDz+vgiLcB+RCThPXy6D3KsltpZ7ecmw5OqQrF7SW6yrkk2eGiYlabM1lX1+urdtbbHv5luF4SpOOTs+zrWEI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=H9E6AoG8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jf5RWZ9m; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QFlSTNms; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=r8rj9A8N; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DC7715BCE5;
	Wed,  1 Apr 2026 23:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775087604; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Rc0hw02/Pylcj87uUVQtqP6cxfF0CkudwVTRA0jLtI=;
	b=H9E6AoG8gGmkkiQ+o6aUI3+dd5Z3Dfx/lHpOfYfWj7H+wqiHUxh0bYO/IEXHZwCAniDsE8
	u0CVSJZsASTUh30Lv23FYdOdyGs4qFpiTbyX5nfAKok/bAsRuBM1KUx5dhytDtV5Gb8Hb6
	17qgXdJ9/RSNGmkjxO2Br4PHVLiSM0s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775087604;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Rc0hw02/Pylcj87uUVQtqP6cxfF0CkudwVTRA0jLtI=;
	b=jf5RWZ9meXF9zMNZSXdAtxfWOi9kbxk9RvWdkGzQ4IgSiYGOiB9c7SIf7nYZyJCxcEWQr0
	s3qsZKabHhmg9/AQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775087603; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Rc0hw02/Pylcj87uUVQtqP6cxfF0CkudwVTRA0jLtI=;
	b=QFlSTNmsHoK6/WigOcItZj6ACZjKdZbdYpLHHigYj8euA3F3vWpQX2Htp6B3416i805XqH
	0gXMpUVO1+nPYK4hdVC64x+OmJbqsCwRpgfm8SxvyvC+RFb8sZyaByklUMIsHvUl37/MzQ
	OHGJYc2vZ0jTfkWpUP7EVMC7jHJ+GpM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775087603;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Rc0hw02/Pylcj87uUVQtqP6cxfF0CkudwVTRA0jLtI=;
	b=r8rj9A8NNLUGlFLEw8JIUBSVc5CNuyFAKbsa95/5RJ6Z+4EOjJxrOxnPcNi8Nzwq41gpag
	fwRNHDYXrF7okDAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 616D74A0B0;
	Wed,  1 Apr 2026 23:53:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zwtDFPOvzWmvMgAAD6G6ig
	(envelope-from <fmancera@suse.de>); Wed, 01 Apr 2026 23:53:23 +0000
Message-ID: <4cce92eb-61a0-4869-8a30-b86d65e8a675@suse.de>
Date: Thu, 2 Apr 2026 01:53:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 1/2] net: hsr: require valid EOT supervision
 TLV
To: Luka Gejak <luka.gejak@linux.dev>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, fmaurer@redhat.com, horms@kernel.org
References: <20260401092324.52266-1-luka.gejak@linux.dev>
 <20260401092324.52266-2-luka.gejak@linux.dev>
 <2d94a1a6-e6c5-427c-b10f-63377cb10407@suse.de>
 <DHHZ8POWJINS.1CRKQT33EM1WW@linux.dev>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <DHHZ8POWJINS.1CRKQT33EM1WW@linux.dev>
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
	TAGGED_FROM(0.00)[bounces-274282-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.dev:email]
X-Rspamd-Queue-Id: A1EA3381CEE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/1/26 6:59 PM, Luka Gejak wrote:
> On Wed Apr 1, 2026 at 4:47 PM CEST, Fernando Fernandez Mancera wrote:
>> On 4/1/26 11:23 AM, luka.gejak@linux.dev wrote:
>>> From: Luka Gejak <luka.gejak@linux.dev>
>>>
>>> Supervision frames are only valid if terminated with a zero-length EOT
>>> TLV. The current check fails to reject non-EOT entries as the terminal
>>> TLV, potentially allowing malformed supervision traffic.
>>>
>>> Fix this by strictly requiring the terminal TLV to be HSR_TLV_EOT
>>> with a length of zero.
>>>
>>> Reviewed-by: Felix Maurer <fmaurer@redhat.com>
>>> Signed-off-by: Luka Gejak <luka.gejak@linux.dev>
>>> ---
>>>    net/hsr/hsr_forward.c | 41 ++++++++++++++++++++++-------------------
>>>    1 file changed, 22 insertions(+), 19 deletions(-)
>>>
>>> diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
>>> index 0aca859c88cb..17b705235c4a 100644
>>> --- a/net/hsr/hsr_forward.c
>>> +++ b/net/hsr/hsr_forward.c
>>> @@ -82,39 +82,42 @@ static bool is_supervision_frame(struct hsr_priv *hsr, struct sk_buff *skb)
>>>    	    hsr_sup_tag->tlv.HSR_TLV_length != sizeof(struct hsr_sup_payload))
>>>    		return false;
>>>    
>>> -	/* Get next tlv */
>>> +	/* Advance past the first TLV payload to reach next TLV header */
>>>    	total_length += hsr_sup_tag->tlv.HSR_TLV_length;
>>> -	if (!pskb_may_pull(skb, total_length))
>>> +	/* Linearize next TLV header before access */
>>> +	if (!pskb_may_pull(skb, total_length + sizeof(struct hsr_sup_tlv)))
>>>    		return false;
>>>    	skb_pull(skb, total_length);
>>>    	hsr_sup_tlv = (struct hsr_sup_tlv *)skb->data;
>>>    	skb_push(skb, total_length);
>>>    
>>> -	/* if this is a redbox supervision frame we need to verify
>>> -	 * that more data is available
>>> +	/* Walk through TLVs to find end-of-TLV marker, skipping any unknown
>>> +	 * extension TLVs to maintain forward compatibility.
>>>    	 */
>>> -	if (hsr_sup_tlv->HSR_TLV_type == PRP_TLV_REDBOX_MAC) {
>>> -		/* tlv length must be a length of a mac address */
>>> -		if (hsr_sup_tlv->HSR_TLV_length != sizeof(struct hsr_sup_payload))
>>> -			return false;
>>> +	for (;;) {
>>> +		if (hsr_sup_tlv->HSR_TLV_type == HSR_TLV_EOT &&
>>> +		    hsr_sup_tlv->HSR_TLV_length == 0)
>>> +			return true;
>>>    
>>
>> I do not follow this approach, why a loop? From IEC 62439-3, I do not
>> understand that supervision frames could have multiple
>> PRP_TLV_REDBOX_MAC TLVs. The current code handles the TLVs correctly.
>>
>> Which makes me wonder, how are you testing this? Do you have some
>> hardware with HSR/PRP support that is sending these frames? If so, which
>> one? Are you testing this using a HSR/PRP environment with purely Linux
>> devices?
>>
>> Thanks,
>> Fernando.
>>
>>> -		/* make sure another tlv follows */
>>> -		total_length += sizeof(struct hsr_sup_tlv) + hsr_sup_tlv->HSR_TLV_length;
>>> -		if (!pskb_may_pull(skb, total_length))
>>> +		/* Validate known TLV types */
>>> +		if (hsr_sup_tlv->HSR_TLV_type == PRP_TLV_REDBOX_MAC) {
>>> +			if (hsr_sup_tlv->HSR_TLV_length !=
>>> +			    sizeof(struct hsr_sup_payload))
>>> +				return false;
>>> +		}
>>> +
>>> +		/* Advance past current TLV: header + payload */
>>> +		total_length += sizeof(struct hsr_sup_tlv) +
>>> +				hsr_sup_tlv->HSR_TLV_length;
>>> +		/* Linearize next TLV header before access */
>>> +		if (!pskb_may_pull(skb,
>>> +				   total_length + sizeof(struct hsr_sup_tlv)))
>>>    			return false;
>>>    
>>> -		/* get next tlv */
>>>    		skb_pull(skb, total_length);
>>>    		hsr_sup_tlv = (struct hsr_sup_tlv *)skb->data;
>>>    		skb_push(skb, total_length);
>>>    	}
> 
> Hi Fernando,
> 
> You are right that IEC 62439-3 does not specify multiple
> PRP_TLV_REDBOX_MAC TLVs. My intention with the loop was not to handle
> multiple RedBox MACs, but rather to make the parser robust against
> unknown TLV types. If a future revision of the standard or a vendor
> extension introduces a new TLV, the loop allows the kernel to safely
> skip over unrecognized TLVs by reading their length, ensuring it can
> still validate the HSR_TLV_EOT marker at the end.
>

AFAIU, the TLVs must be in the right order. I don't know, it doesn't 
sound very convincing to me that we are anticipating to new TLVs. 
HSR/PRP isn't a very active protocol and it has few users in Kernel 
probably compare to other protocols because it is used in a very 
specific industry domain.

If a new revision of the protocol specs is released we can always update 
our implementation.

Anyway, since Felix reviewed the initial patch let's wait for his review.

> However, if the preference for the HSR subsystem is strict adherence to
> only currently defined TLVs over forward compatibility, I completely
> understand.
> 
> Furthermore, I am testing this using a purely Linux environment by
> using a virtual HSR environment on Arch Linux. I set up two network
> namespaces connected via veth pairs and instantiated HSR interfaces.
> 
> The nodes successfully synchronized and maintained the connection. I
> confirmed this by observing the expected duplicate packets (DUP!)
> during ping tests between namespaces and by verifying that supervision
> frames were correctly parsed, allowing the nodes to populate their
> remote node tables.
> 
> Let me know if you'd prefer I drop the loop for v5.
> Best regards,
> Luka Gejak
> 


