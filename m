Return-Path: <netdev+bounces-291925-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WNtbKq8HFmpNhAcAu9opvQ
	(envelope-from <netdev+bounces-291925-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 22:50:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CBA45DC762
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 22:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8C813022606
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 20:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F92F3BB12C;
	Tue, 26 May 2026 20:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="Rj0TPyz1"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222A626C3BD;
	Tue, 26 May 2026 20:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779828634; cv=none; b=l62os8h7raXqPCHhggfKzE+cf6PPZ0x8migiFIxA1+H+tmpFvUuwEnlk1wOyqElhHKVPXdW2gQNaL7XdDRwlQ7u4l7gfiwIVIGvLMaq8Ez/umNeUbaxneiNOUnH0/Mz9BfC9gxjbJPDwSGwLC3g40+ikK91f0iwkkd7E1o7LDl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779828634; c=relaxed/simple;
	bh=3MsbVQMRlkWyRmM+scobE8Chf8BwX3w2hipiqBeSQuE=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=tcHCawQ3etM7n0JwXKDjwgkdgpxqnBor9Wcoy++cb9AKFjNxbL5LpQ8s90nsDF1OegbNJOqFZBp3vemvupHJoWbh/Z5zEx25BgF8JMf0mYIdQA9wDDRJUfVAEHnoNdMu7OvFnK8psIFKAEpLmyMvbqhLNTQGBxQf3LMroKuscSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=Rj0TPyz1; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 82ECBA4B47;
	Tue, 26 May 2026 22:50:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1779828627; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=YxIv+z1i7BXKHKGu2iZTSaCZuD3KwsuMfvkF03U6b30=;
	b=Rj0TPyz16ddOVcu6NGLZel8fDz+TRyxwiP4+JhzkJZbzWYsOSGIZ+zObP76tXE4Vs5QK29
	HS9XbmZxA973Zhq+wp7AqhnIAoYUSw5bAJcNkOPsBlrhyMdCJ4AI86DDxYL1GqiA5zhMbj
	jHtb+DsScJyyz1kBTr1vd5LjhYu1PaFDH8sRCGCSUjkSfhmsKHXAu00wAVEjOKMLvrUlrg
	gB/SssvHnFNn5m20rHtdf0W3QOrCYChbZYYPwkskWplqnKrS9k0lrXnWrW7Eazy3wwCaEa
	rReEkauXZOLjZRN1nWhfLRZd30kQPfntTyLJN4DMIT60rpErwd06e/CZ64yv0A==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 26 May 2026 22:50:20 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc: Haren Myneni <haren@linux.ibm.com>, Rick Lindsley
 <ricklind@linux.ibm.com>, Nick Child <nnac123@linux.ibm.com>, Madhavan
 Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)"
 <chleroy@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Thomas Falcon
 <tlfalcon@linux.vnet.ibm.com>, Desnes Augusto Nunes do Rosario
 <desnesn@linux.vnet.ibm.com>, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ibmvnic: fix krealloc() memory leak
In-Reply-To: <20260526184105.18962-6-grandmaster@al2klimov.de>
References: <20260526184105.18962-1-grandmaster@al2klimov.de>
 <20260526184105.18962-6-grandmaster@al2klimov.de>
Message-ID: <fc74cefb2e0167514f1c3c0c3d6133ec@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291925-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[tipi-net.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux.ibm.com,ellerman.id.au,gmail.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,linux.vnet.ibm.com,vger.kernel.org,lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[al2klimov.de:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 0CBA45DC762
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Alex

You patch is missing the prefix with the target tree. Please have
a look at [1] for more details on the workflow.

On 26.5.2026 20:41, Alexander A. Klimov wrote:
> Don't just overwrite the original pointer passed to krealloc()
> with its return value without checking latter:
> 
>     MEM = krealloc(MEM, SZ, GFP);
> 
> If krealloc() returns NULL, that erases the pointer
> to the still allocated memory, hence leaks this memory.
> Instead, use a temporary variable, check it's not NULL
> and only then assign it to the original pointer:
> 
>     TMP = krealloc(MEM, SZ, GFP);
>     if (!TMP) return;
>     MEM = TMP;
> 
> Fixes: 4e6759be28e4 ("ibmvnic: Feature implementation of Vital Product 
> Data (VPD) for the ibmvnic driver")
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
> ---
>  drivers/net/ethernet/ibm/ibmvnic.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ibm/ibmvnic.c 
> b/drivers/net/ethernet/ibm/ibmvnic.c
> index 5a510eed335e..25d1d844ad19 100644
> --- a/drivers/net/ethernet/ibm/ibmvnic.c
> +++ b/drivers/net/ethernet/ibm/ibmvnic.c
> @@ -1761,8 +1761,9 @@ static int ibmvnic_get_vpd(struct ibmvnic_adapter 
> *adapter)
>  	union ibmvnic_crq crq;
>  	int len = 0;
>  	int rc;
> +	unsigned char *buff = adapter->vpd->buff;

Should be reverse x-mas tree (longest to shortest).

> 
> -	if (adapter->vpd->buff)
> +	if (buff)
>  		len = adapter->vpd->len;
> 
>  	mutex_lock(&adapter->fw_lock);
> @@ -1788,17 +1789,17 @@ static int ibmvnic_get_vpd(struct 
> ibmvnic_adapter *adapter)
>  	if (!adapter->vpd->len)
>  		return -ENODATA;
> 
> -	if (!adapter->vpd->buff)
> -		adapter->vpd->buff = kzalloc(adapter->vpd->len, GFP_KERNEL);
> +	if (!buff)
> +		buff = kzalloc(adapter->vpd->len, GFP_KERNEL);
>  	else if (adapter->vpd->len != len)
> -		adapter->vpd->buff =
> -			krealloc(adapter->vpd->buff,
> -				 adapter->vpd->len, GFP_KERNEL);
> +		buff = krealloc(buff,
> +				adapter->vpd->len, GFP_KERNEL);

Dead branch? The only caller, init_resources(), kzalloc()s a fresh vpd
right before, and resets run release_vpd_data() first, so vpd->buff is
always NULL here and kzalloc() above always wins. The leak can't 
trigger,
which makes the Fixes tag misleading.

> 
> -	if (!adapter->vpd->buff) {
> +	if (!buff) {
>  		dev_err(dev, "Could allocate VPD buffer\n");
>  		return -ENOMEM;
>  	}
> +	adapter->vpd->buff = buff;

If you keep it anyway: on failure the old buffer stays in vpd->buff 
while
vpd->len is already the new size, a mismatch the original avoided by
NULLing. kfree() it (krealloc() does not free on failure) and NULL 
before
-ENOMEM.

> 
>  	adapter->vpd->dma_addr =
>  		dma_map_single(dev, adapter->vpd->buff, adapter->vpd->len,

[1] https://docs.kernel.org/process/maintainer-netdev.html

Thanks,
Nicolai

