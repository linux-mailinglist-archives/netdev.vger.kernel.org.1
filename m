Return-Path: <netdev+bounces-264901-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qBSMEe8sq2koagEAu9opvQ
	(envelope-from <netdev+bounces-264901-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 20:37:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CB85E2271ED
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 20:37:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C1F40301D963
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 19:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52903A0EB0;
	Fri,  6 Mar 2026 19:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="bI3daVns"
X-Original-To: netdev@vger.kernel.org
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33033374E46
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 19:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772825836; cv=none; b=UoRNEAytDp4Mg53gjDpGkrX41hW0d18roaJnsZudYhOX01gswQqMa1OeKjxphCEWvwyYbgcTEWraTg5qGJNaUuGV7bWnIMGysNdaCOPpjp5A8ACgF9Tohr2aOwSjTRbpsBWJjx7G80jTFxdlizVH0btYXr+qQ05X/Q/Qq3gcT+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772825836; c=relaxed/simple;
	bh=Wwf/rlX3fcPNX7opmKjPBceQ7Qog+/0/LSi+9Fr9rJo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qptL9+/MR0oO0yBLfG43ee5rDAuoz5PKTkWA2+r0m3hl0MkZhPN64+pFCrCkJWOtpbADIznFXD95q7+Im+Dg/r5EppxkN1qPETC69+HXziQs2QCYYUjbXIKMzqPowaohziqW8/THa0YsO4K1rTNeeZLq3Kp68rTsEvr2nf3KMfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=bI3daVns; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5007b.ext.cloudfilter.net ([10.0.29.167])
	by cmsmtp with ESMTPS
	id yWauvBWqLKXDJyaz4vpRFz; Fri, 06 Mar 2026 19:37:14 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id yayevsbPjV6WMyayev37pe; Fri, 06 Mar 2026 19:36:48 +0000
X-Authority-Analysis: v=2.4 cv=E//Npbdl c=1 sm=1 tr=0 ts=69ab2cea
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=k5Y5iPg+dmTXVWgYE/XtfQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=7T7KSl7uo7wA:10 a=pGLkceISAAAA:8
 a=VwQbUJbxAAAA:8 a=ODW9KA4OjjfVspghKLMA:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
 a=2aFnImwKRvkU0tJ3nQRT:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=s14wzuuHmz3UuRviyTrofkZdIBROu5zpnbLynCi7onI=; b=bI3daVnsoDPSVQtd5Z7tI2lRpp
	g/ww7yzBZgYzPumY8rslJs/0WNMuta6MZfJRv4y2Z9FgC5NO7xz67x5QS9HI0ms/EYlANsSbKT2p7
	nTEhiuTdw8NaAxPyBU753SBgB1soF0qZeYzMtPppnYTqwK4MiYrW0bGhYvt0d0unXssCWirbkkiaW
	nh8JcOdqToBaAKUbA4ZCqqeK9AznmgK0dUf7yHi6SXJWjThwTdWIU83IpkR8Xf8WCuHJFXXPwj5rm
	13xAH7Am+4kxOI11WeM0UH3ucE+BEJ7W847yR+ic0S3gA+pJep8JEI2RlWCAPN7yTQFUOASsQ5JYT
	PC6lQE7Q==;
Received: from [177.238.16.13] (port=47618 helo=[192.168.0.21])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.99.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1vyayb-00000001bKv-3mkP;
	Fri, 06 Mar 2026 13:36:47 -0600
Message-ID: <eb6c7f12-22d8-4384-b755-932fdfea5034@embeddedor.com>
Date: Fri, 6 Mar 2026 13:36:11 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: rocker: kzalloc + kcalloc to kzalloc_flex
To: Rosen Penev <rosenp@gmail.com>, netdev@vger.kernel.org
Cc: Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 open "list:KERNEL" HARDENING "(not" covered by other
 "areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
References: <20260306025449.12333-1-rosenp@gmail.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20260306025449.12333-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 177.238.16.13
X-Source-L: No
X-Exim-ID: 1vyayb-00000001bKv-3mkP
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.21]) [177.238.16.13]:47618
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 53
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfLbwWre5+KMfuS1qq7xc3o0KYDuAQoDyu7dmOVNACgM8KzGC8VXyCCVPN+YSMBS9t7OngLjimBvLb+iEJSYdtIE2ilGRWNHKTyQc7J5bLKFOuiU139LW
 iqPUR47idDzxq0IFDh7DPJduvALmBWQ17OlyDetGaQKPbG46+et/APtgaz3BjraFahsjqfyRPvQ4GB6E3ZylL91dylsTtNQZCYo=
X-Rspamd-Queue-Id: CB85E2271ED
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[embeddedor.com:s=default];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-264901-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_NA(0.00)[embeddedor.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	HAS_X_SOURCE(0.00)[];
	HAS_X_ANTIABUSE(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[gustavo@embeddedor.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[embeddedor.com:-];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_SPAM(0.00)[0.336];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,embeddedor.com:mid]
X-Rspamd-Action: no action



On 3/6/26 11:54, Rosen Penev wrote:
> Combining the allocations simplifies things, especially the free path.
> 
> Remove ofdpa_group_tbl_entry_free as a result. kfree is shorter.
> 
> Add __counted_by for extra runtime analysis.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Acked-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-Gustavo

> ---
>   drivers/net/ethernet/rocker/rocker_ofdpa.c | 31 +++++-----------------
>   1 file changed, 7 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/net/ethernet/rocker/rocker_ofdpa.c b/drivers/net/ethernet/rocker/rocker_ofdpa.c
> index 50ea5f9ef63a..66a8ae67c3ea 100644
> --- a/drivers/net/ethernet/rocker/rocker_ofdpa.c
> +++ b/drivers/net/ethernet/rocker/rocker_ofdpa.c
> @@ -104,7 +104,6 @@ struct ofdpa_group_tbl_entry {
>   	u32 cmd;
>   	u32 group_id; /* key */
>   	u16 group_count;
> -	u32 *group_ids;
>   	union {
>   		struct {
>   			u8 pop_vlan;
> @@ -123,6 +122,8 @@ struct ofdpa_group_tbl_entry {
>   			u32 group_id;
>   		} l3_unicast;
>   	};
> +
> +	u32 group_ids[] __counted_by(group_count);
>   };
>   
>   struct ofdpa_fdb_tbl_entry {
> @@ -1059,19 +1060,6 @@ ofdpa_group_tbl_find(const struct ofdpa *ofdpa,
>   	return NULL;
>   }
>   
> -static void ofdpa_group_tbl_entry_free(struct ofdpa_group_tbl_entry *entry)
> -{
> -	switch (ROCKER_GROUP_TYPE_GET(entry->group_id)) {
> -	case ROCKER_OF_DPA_GROUP_TYPE_L2_FLOOD:
> -	case ROCKER_OF_DPA_GROUP_TYPE_L2_MCAST:
> -		kfree(entry->group_ids);
> -		break;
> -	default:
> -		break;
> -	}
> -	kfree(entry);
> -}
> -
>   static int ofdpa_group_tbl_add(struct ofdpa_port *ofdpa_port, int flags,
>   			       struct ofdpa_group_tbl_entry *match)
>   {
> @@ -1085,7 +1073,7 @@ static int ofdpa_group_tbl_add(struct ofdpa_port *ofdpa_port, int flags,
>   
>   	if (found) {
>   		hash_del(&found->entry);
> -		ofdpa_group_tbl_entry_free(found);
> +		kfree(found);
>   		found = match;
>   		found->cmd = ROCKER_TLV_CMD_TYPE_OF_DPA_GROUP_MOD;
>   	} else {
> @@ -1122,14 +1110,14 @@ static int ofdpa_group_tbl_del(struct ofdpa_port *ofdpa_port, int flags,
>   
>   	spin_unlock_irqrestore(&ofdpa->group_tbl_lock, lock_flags);
>   
> -	ofdpa_group_tbl_entry_free(match);
> +	kfree(match);
>   
>   	if (found) {
>   		err = rocker_cmd_exec(ofdpa_port->rocker_port,
>   				      ofdpa_flags_nowait(flags),
>   				      ofdpa_cmd_group_tbl_del,
>   				      found, NULL, NULL);
> -		ofdpa_group_tbl_entry_free(found);
> +		kfree(found);
>   	}
>   
>   	return err;
> @@ -1166,18 +1154,13 @@ static int ofdpa_group_l2_fan_out(struct ofdpa_port *ofdpa_port,
>   {
>   	struct ofdpa_group_tbl_entry *entry;
>   
> -	entry = kzalloc_obj(*entry);
> +	entry = kzalloc_flex(*entry, group_ids, group_count);
>   	if (!entry)
>   		return -ENOMEM;
>   
> -	entry->group_id = group_id;
>   	entry->group_count = group_count;
> +	entry->group_id = group_id;
>   
> -	entry->group_ids = kcalloc(group_count, sizeof(u32), GFP_KERNEL);
> -	if (!entry->group_ids) {
> -		kfree(entry);
> -		return -ENOMEM;
> -	}
>   	memcpy(entry->group_ids, group_ids, group_count * sizeof(u32));
>   
>   	return ofdpa_group_tbl_do(ofdpa_port, flags, entry);


