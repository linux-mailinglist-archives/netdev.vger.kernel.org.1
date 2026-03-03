Return-Path: <netdev+bounces-263339-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mH1QFxMZp2m+dgAAu9opvQ
	(envelope-from <netdev+bounces-263339-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 18:23:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B52C61F4943
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 18:23:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7EE25302F720
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 17:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A127C3537D6;
	Tue,  3 Mar 2026 17:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Q6eAugzz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zKH0MltG";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Q6eAugzz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zKH0MltG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E76F3537D3
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 17:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772558475; cv=none; b=YMjH3qfcixeydAJimVJqeOSUIXCE2G623UpJSHLkbChPp/SBjzNKGIf2qvNRKhELuoH6OJvD0Z5D0NBzxJITztyHvpm3x47L9ptBwL8YvK4T5HyKY/cU2/znWkzDbyuwCp5VEuLgwmjx/4MOeiK/arU4ylm6ClHGn7tVnNFmBuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772558475; c=relaxed/simple;
	bh=UgMVHhT7bJXcwtHBrRORGZbG5E41isnJfRjcvYRM1UI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oB8wIZso2g8jKgC9IWQkhJNY7j/rjJeRLmvC4MMeMYtdvNGM2lLSD0JzBK4UmhUg5AQrFIVw0Y51sj39QeB/wRrL/wSS0bs0eEiRC5M7mxte9PMfiQ4rHP1XkgJ9tdK4RxGgEyHDXlZpQx2c/s4VKltpZ2cfR20S9PlEgBJKkFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Q6eAugzz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zKH0MltG; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Q6eAugzz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zKH0MltG; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 68E0C5BE14;
	Tue,  3 Mar 2026 17:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772558472; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ckw4o+PBREtPUkXpxwPxb4i84vuQvXCd5PQCjVPS2nw=;
	b=Q6eAugzzx1zILpjuL4dqDH5T07BIiRQ8fPkEZsCPwA8vkNiErKauUciaQTWVl7VTFaDS1A
	kxbLt6iRU8nO3gJytsG1FHK4opkqGjdzVxdyyC/niz8Z0xOB2F4R+DdvzqCZBHtxQHQIOB
	h3Csr4OYrXDQXT7gI+14SoKPVaYYw5A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772558472;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ckw4o+PBREtPUkXpxwPxb4i84vuQvXCd5PQCjVPS2nw=;
	b=zKH0MltG6c8UctZHFxv14EjB/VVSPAG1rDkPv8tC8BI+jcYqybzg31oPLczgwOYsXI+z5g
	eXHMCFwOSLcv4IAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772558472; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ckw4o+PBREtPUkXpxwPxb4i84vuQvXCd5PQCjVPS2nw=;
	b=Q6eAugzzx1zILpjuL4dqDH5T07BIiRQ8fPkEZsCPwA8vkNiErKauUciaQTWVl7VTFaDS1A
	kxbLt6iRU8nO3gJytsG1FHK4opkqGjdzVxdyyC/niz8Z0xOB2F4R+DdvzqCZBHtxQHQIOB
	h3Csr4OYrXDQXT7gI+14SoKPVaYYw5A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772558472;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ckw4o+PBREtPUkXpxwPxb4i84vuQvXCd5PQCjVPS2nw=;
	b=zKH0MltG6c8UctZHFxv14EjB/VVSPAG1rDkPv8tC8BI+jcYqybzg31oPLczgwOYsXI+z5g
	eXHMCFwOSLcv4IAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D47EA3EA69;
	Tue,  3 Mar 2026 17:21:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9zr5MIcYp2mlRwAAD6G6ig
	(envelope-from <fmancera@suse.de>); Tue, 03 Mar 2026 17:21:11 +0000
Message-ID: <870fb7c8-e5a8-4cf9-a502-fccc90634bad@suse.de>
Date: Tue, 3 Mar 2026 18:21:11 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ipsec] xfrm: iptfs: fix skb_put() panic on non-linear skb
 during reassembly
To: netdev@vger.kernel.org
Cc: chopps@labn.net, horms@kernel.org, pabeni@redhat.com, kuba@kernel.org,
 edumazet@google.com, davem@davemloft.net, herbert@gondor.apana.org.au,
 steffen.klassert@secunet.com, Hao Long <me@imlonghao.com>
References: <20260303171029.4072-1-fmancera@suse.de>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260303171029.4072-1-fmancera@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: B52C61F4943
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
	TAGGED_FROM(0.00)[bounces-263339-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,imlonghao.com:email,suse.de:dkim,suse.de:email,suse.de:mid]
X-Rspamd-Action: no action

On 3/3/26 6:10 PM, Fernando Fernandez Mancera wrote:
> In iptfs_reassem_cont(), IP-TFS attempts to append data to the new inner
> packet 'newskb' that is being reassembled. First a zero-copy approach is
> tried if it succeeds then newskb becomes non-linear.
> 
> When a subsequent fragment in the same datagram does not meet the
> fast-path conditions, a memory copy is performed. It calls skb_put() to
> append the data and as newskb is non-linear it triggers
> SKB_LINEAR_ASSERT check.
> 
>   Oops: invalid opcode: 0000 [#1] SMP NOPTI
>   [...]
>   RIP: 0010:skb_put+0x3c/0x40
>   [...]
>   Call Trace:
>    <IRQ>
>    iptfs_reassem_cont+0x1ab/0x5e0 [xfrm_iptfs]
>    iptfs_input_ordered+0x2af/0x380 [xfrm_iptfs]
>    iptfs_input+0x122/0x3e0 [xfrm_iptfs]
>    xfrm_input+0x91e/0x1a50
>    xfrm4_esp_rcv+0x3a/0x110
>    ip_protocol_deliver_rcu+0x1d7/0x1f0
>    ip_local_deliver_finish+0xbe/0x1e0
>    __netif_receive_skb_core.constprop.0+0xb56/0x1120
>    __netif_receive_skb_list_core+0x133/0x2b0
>    netif_receive_skb_list_internal+0x1ff/0x3f0
>    napi_complete_done+0x81/0x220
>    virtnet_poll+0x9d6/0x116e [virtio_net]
>    __napi_poll.constprop.0+0x2b/0x270
>    net_rx_action+0x162/0x360
>    handle_softirqs+0xdc/0x510
>    __irq_exit_rcu+0xe7/0x110
>    irq_exit_rcu+0xe/0x20
>    common_interrupt+0x85/0xa0
>    </IRQ>
>    <TASK>
> 
> Fix this by checking if the skb is non-linear. If it is, linearize it by
> calling skb_linearize(). As the initial allocation of newskb originally
> reserved enough tailroom for the entire reassembled packet we do not
> need to check if we have enough tailroom or extend it.
> 
> Fixes: 075694765446 ("xfrm: iptfs: handle received fragmented inner packets")
> Reported-by: Hao Long <me@imlonghao.com>
> Closes: https://lore.kernel.org/netdev/DGRCO9SL0T5U.JTINSHJQ9KPK@imlonghao.com/
> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
> ---
>   net/xfrm/xfrm_iptfs.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
> index 050a82101ca5..4d1a84a6fc45 100644
> --- a/net/xfrm/xfrm_iptfs.c
> +++ b/net/xfrm/xfrm_iptfs.c
> @@ -901,6 +901,12 @@ static u32 iptfs_reassem_cont(struct xfrm_iptfs_data *xtfs, u64 seq,
>   	    iptfs_skb_can_add_frags(newskb, fragwalk, data, copylen)) {
>   		iptfs_skb_add_frags(newskb, fragwalk, data, copylen);
>   	} else {
> +		if (skb_is_nonlinear(newskb) && skb_linearize(newskb)) {

This will indeed require a V2. skb_linearize() is enough here as this is 
calling skb_is_nonlinear() inside it. *face-palm*

> +			XFRM_INC_STATS(xs_net(xtfs->x),
> +				       LINUX_MIB_XFRMINBUFFERERROR);
> +			goto abandon;
> +		}
> +
>   		/* copy fragment data into newskb */
>   		if (skb_copy_seq_read(st, data, skb_put(newskb, copylen),
>   				      copylen)) {


