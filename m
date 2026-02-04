Return-Path: <netdev+bounces-256761-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOWBJj1zg2mFmwMAu9opvQ
	(envelope-from <netdev+bounces-256761-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 17:26:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD1BEA325
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 17:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9F3C8301BEDF
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 16:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86214279FD;
	Wed,  4 Feb 2026 16:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Iz4Bb9jH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="d8GX2OBO";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Iz4Bb9jH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="d8GX2OBO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6630942314B
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 16:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770222321; cv=none; b=lGrHr+amjKNtMv7W0xrOxVn//iRHat7XwLikJD/JRmhMF3ERybuJeE0f6jq7Gm3X8vWCrmaq3rPrFxQdO7RluYQl+wvBKh+z5UfQYTS7bLqvAf2CAeYL3JW40pbBiTGYpch1rnFvwbMxl5bXEsUVfUdeX4GIQKsTjnoTLmM6eOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770222321; c=relaxed/simple;
	bh=EQDGREbx2eOfIlZCyzYY3XBcflutsIBy47GxcemPVTk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iVhNFnqVkrbsrojUMNSsKBqvHn6DNZIBNHs3SLgN0ETapxNkY+gEiatQjGGde7HMWDVe86Yj3hjhMUIVIweLtIJh2XcWXdZJBt3Vz4hTL+XB1pjlxNlqfHLf+eS6m1u4Pvwi9uEo8scrvl97WBQFi4iJK38INSBiYP/eLhvjaNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Iz4Bb9jH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=d8GX2OBO; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Iz4Bb9jH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=d8GX2OBO; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8C1CD3E756;
	Wed,  4 Feb 2026 16:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770222319; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MNfdfWpxS7ez9doSrQNEseEA9yAII6UibWhm1hCdWfw=;
	b=Iz4Bb9jHRw+ctTk/qoKbyCOSU+foIH4y+zrlXkUo541/HfcsjOvTdypqpWlTBI3Djz8xGA
	OjwA5+/0hYkTuaaH0xTRQbBLoPEneHQaP81sTyySsoE0V/iLZx7FInXdFeVEaVOKYBphWX
	MUojMrl7LpadBz4Ioo8lxirjUdkY93c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770222319;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MNfdfWpxS7ez9doSrQNEseEA9yAII6UibWhm1hCdWfw=;
	b=d8GX2OBOWzM3Xav8arbsw4w+/7MYslKkJJI5xPd1iJguX1ylyDzFSm3xnWaNyOoARwjKs3
	xL/Zw/XyxbkQDvCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Iz4Bb9jH;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=d8GX2OBO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770222319; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MNfdfWpxS7ez9doSrQNEseEA9yAII6UibWhm1hCdWfw=;
	b=Iz4Bb9jHRw+ctTk/qoKbyCOSU+foIH4y+zrlXkUo541/HfcsjOvTdypqpWlTBI3Djz8xGA
	OjwA5+/0hYkTuaaH0xTRQbBLoPEneHQaP81sTyySsoE0V/iLZx7FInXdFeVEaVOKYBphWX
	MUojMrl7LpadBz4Ioo8lxirjUdkY93c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770222319;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MNfdfWpxS7ez9doSrQNEseEA9yAII6UibWhm1hCdWfw=;
	b=d8GX2OBOWzM3Xav8arbsw4w+/7MYslKkJJI5xPd1iJguX1ylyDzFSm3xnWaNyOoARwjKs3
	xL/Zw/XyxbkQDvCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ABFFF3EA63;
	Wed,  4 Feb 2026 16:25:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wlagJu5yg2mOHAAAD6G6ig
	(envelope-from <fmancera@suse.de>); Wed, 04 Feb 2026 16:25:18 +0000
Message-ID: <ad8dec4c-d3e0-46c6-a943-c7f3c786c802@suse.de>
Date: Wed, 4 Feb 2026 17:25:18 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next] inet: add ip_retry_random_port sysctl to
 reduce sequential port retries
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, corbet@lwn.net, ncardwell@google.com,
 kuniyu@google.com, dsahern@kernel.org, idosch@nvidia.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Thorsten Toepper <thorsten.toepper@sap.com>
References: <20260203175422.4620-1-fmancera@suse.de>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260203175422.4620-1-fmancera@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.51
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-256761-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid,sap.com:email]
X-Rspamd-Queue-Id: 0BD1BEA325
X-Rspamd-Action: no action

On 2/3/26 6:54 PM, Fernando Fernandez Mancera wrote:
> With the current port selection algorithm, ports after a reserved port
> or long time used port are used more often than others. This combines
> with cloud environments blocking connections between the application
> server and the database server if there was a previous connection with
> the same source port. This leads to connectivity problems between
> applications on cloud environments.
> 
> The situation is that a source tuple is usable again after being closed
> for a maximum lifetime segment of two minutes while in the firewall it's
> still noted as existing for 60 minutes or longer. So in case that the
> port is reused for the same target tuple before the firewall cleans up,
> the connection will fail due to firewall interference which itself will
> reset the activity timeout in its own table. We understand the real
> issue here is that these firewalls cannot cope with standards-compliant
> port reuse. But this is a workaround for such situations and an
> improvement on the distribution of ports selected.
> 
> The proposed solution is instead of incrementing the port number,
> performing a re-selection of a new random port within the remaining
> range. This solution is configured via sysctl new option
> "net.ipv4.ip_retry_random_port".
> 
> The test run consists of two processes, a client and a server, and loops
> connect to the server sending some bytes back. The results we got are
> promising:
> 
> Executed test: Current algorithm
> ephemeral port range: 9000-65499
> simulated selections: 10000000
> retries during simulation: 14197718
> longest retry sequence: 5202
> 
> Executed test: Proposed modified algorithm
> ephemeral port range: 9000-65499
> simulated selections: 10000000
> retries during simulation: 3976671
> longest retry sequence: 12
> 
> In addition, on graphs generated we can observe that the distribution of
> source ports is more even with the proposed patch.
> 
> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
> Tested-by: Thorsten Toepper <thorsten.toepper@sap.com>
> ---
>   .../networking/net_cachelines/netns_ipv4_sysctl.rst        | 1 +
>   include/net/netns/ipv4.h                                   | 1 +
>   net/ipv4/inet_hashtables.c                                 | 7 ++++++-
>   net/ipv4/sysctl_net_ipv4.c                                 | 7 +++++++
>   4 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst b/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst
> index beaf1880a19b..c4041fdca01e 100644
> --- a/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst
> +++ b/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst
> @@ -47,6 +47,7 @@ u8                              sysctl_tcp_ecn
>   u8                              sysctl_tcp_ecn_fallback
>   u8                              sysctl_ip_default_ttl                                                                ip4_dst_hoplimit/ip_select_ttl
>   u8                              sysctl_ip_no_pmtu_disc
> +u8                              sysctl_ip_retry_random_port
>   u8                              sysctl_ip_fwd_use_pmtu                       read_mostly                             ip_dst_mtu_maybe_forward/ip_skb_dst_mtu
>   u8                              sysctl_ip_fwd_update_priority                                                        ip_forward
>   u8                              sysctl_ip_nonlocal_bind
> diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
> index 2dbd46fc4734..d04b07e7c935 100644
> --- a/include/net/netns/ipv4.h
> +++ b/include/net/netns/ipv4.h
> @@ -156,6 +156,7 @@ struct netns_ipv4 {
>   
>   	u8 sysctl_ip_default_ttl;
>   	u8 sysctl_ip_no_pmtu_disc;
> +	u8 sysctl_ip_retry_random_port;
>   	u8 sysctl_ip_fwd_update_priority;
>   	u8 sysctl_ip_nonlocal_bind;
>   	u8 sysctl_ip_autobind_reuse;
> diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
> index f5826ec4bcaa..f1c79a7d3fd3 100644
> --- a/net/ipv4/inet_hashtables.c
> +++ b/net/ipv4/inet_hashtables.c
> @@ -1088,8 +1088,13 @@ int __inet_hash_connect(struct inet_timewait_death_row *death_row,
>   	for (i = 0; i < remaining; i += step, port += step) {
>   		if (unlikely(port >= high))
>   			port -= remaining;
> -		if (inet_is_local_reserved_port(net, port))
> +		if (inet_is_local_reserved_port(net, port)) {
> +			if (net->ipv4.sysctl_ip_retry_random_port) {
> +				port = low + get_random_u32_below(remaining);
> +				port = ((port & 1) == step) ? port : (port - 1);

The AI bot did a good observation 
(https://netdev-ai.bots.linux.dev/ai-review.html?id=c1544ebc-4c9d-45c5-bce9-784764102912). 
I think this would be better as it will keep the random scan within the 
same parity when needed.

diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index f1c79a7d3fd3..c9650079f9e5 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -1090,8 +1090,11 @@ int __inet_hash_connect(struct 
inet_timewait_death_row *death_row,
  			port -= remaining;
  		if (inet_is_local_reserved_port(net, port)) {
  			if (net->ipv4.sysctl_ip_retry_random_port) {
-				port = low + get_random_u32_below(remaining);
-				port = ((port & 1) == step) ? port : (port - 1);
+				u32 candidate = low + get_random_u32_below(remaining);
+
+				if (step == 2 && (candidate & 1) != (port & 1))
+					candidate++;
+				port = candidate;
  			}
  			continue;
  		}

> +			}
>   			continue;
> +		}
>   		head = &hinfo->bhash[inet_bhashfn(net, port,
>   						  hinfo->bhash_size)];
>   		rcu_read_lock();
> diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
> index a1a50a5c80dc..5eade7d9e4a2 100644
> --- a/net/ipv4/sysctl_net_ipv4.c
> +++ b/net/ipv4/sysctl_net_ipv4.c
> @@ -822,6 +822,13 @@ static struct ctl_table ipv4_net_table[] = {
>   		.mode		= 0644,
>   		.proc_handler	= ipv4_local_port_range,
>   	},
> +	{
> +		.procname	= "ip_retry_random_port",
> +		.maxlen		= sizeof(u8),
> +		.data		= &init_net.ipv4.sysctl_ip_retry_random_port,
> +		.mode		= 0644,
> +		.proc_handler	= proc_dou8vec_minmax,
> +	},
>   	{
>   		.procname	= "ip_local_reserved_ports",
>   		.data		= &init_net.ipv4.sysctl_local_reserved_ports,


