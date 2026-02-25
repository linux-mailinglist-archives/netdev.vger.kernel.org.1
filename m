Return-Path: <netdev+bounces-261026-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UPubMYUln2mPZAQAu9opvQ
	(envelope-from <netdev+bounces-261026-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 17:38:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB2919AC73
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 17:38:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 91A33312F738
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 16:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1504C3D9025;
	Wed, 25 Feb 2026 16:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GB3MmvVo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CSSh2uNR";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vyz4qXr3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zqzFWHgG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48353D6692
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 16:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772037233; cv=none; b=kdnRJZ3pcGtJ/8l+6NdWZPAgkHRNCjf1GBaTyTcGrtDMk+fDFboFvLm4zzAFnP7f9RYjo+cfW0yt4Z1DIEFKoV1fxE4Mf/CLii9HbKyX1KbE8XwvWRnkaBmp2RzZNv0iQMHiS/epDq7DQdhYgCEWWbjKWMN0E1jHmA2b/wiOGtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772037233; c=relaxed/simple;
	bh=K/NDXBr0zyL7RRiunPhYVhKshSa7Kn0DNOK99ojQV/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KRfj/N3j+aIbMT+fRB6VEWfVE2Twg0dbEDIZleL2goo1GQiECCPsVGsVAPGHir5Z/7j833KhvfpevJLHOsSQgqdwiB0ohygM+YV8AH8Ag7RC+jnH6eYI1QanxsYFliRFqBUcFiYTLbvGg9ywMBjeUa6PLfoH3lCfR7edR3dDhqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GB3MmvVo; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CSSh2uNR; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vyz4qXr3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zqzFWHgG; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D90895CDF3;
	Wed, 25 Feb 2026 16:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772037230; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NTH9hBUsopkauaPajBrrc51TTiXKw9PQsBJjj5DxNcI=;
	b=GB3MmvVo3BfdFkj6pD8Jmk9Irryhla28tfGuDLTm7eVLb0vkOR0JOLpeuonjqBo5hOcByC
	ThwwBpmZRBA+Pmi2iJqsjUcKbf4pB5WSWKA/Gz8wHhkHorsR6kJDIfNmdjv0HY64bIWhbj
	srUC6FtO/s/XFTlsFWafmwx8C5LJwxk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772037230;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NTH9hBUsopkauaPajBrrc51TTiXKw9PQsBJjj5DxNcI=;
	b=CSSh2uNRFlSF9DHxbpPB0APSAo1WfAEmwvqDueN8dlGo8A/gQLtplfawdxHC40Wdb6O75u
	KbNQyM5EifYZlAAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=vyz4qXr3;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=zqzFWHgG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772037229; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NTH9hBUsopkauaPajBrrc51TTiXKw9PQsBJjj5DxNcI=;
	b=vyz4qXr3c1714pOOtpJOUiXG+wdSly3SOo/gYD57WsQj1HdTgFUJuym6ywnlkzkEW46SI9
	xsfPWa1SelzVUmQZ4YC7SrRDbfrHwSTI90watYSxV6VPu+qfzW2UdcnBu/UA3KjYys9dXW
	rgi7L1PnVMh9OZD0YvKFVuY0bBTyGY4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772037229;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NTH9hBUsopkauaPajBrrc51TTiXKw9PQsBJjj5DxNcI=;
	b=zqzFWHgGPEQr92F4WJMG32qYDgv465LiSmj20pawT6hLQ1QmWguJeT5agzgG9C6stXB3Uy
	03Tekkr7WNV9CSAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3987A3EA65;
	Wed, 25 Feb 2026 16:33:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6IvhCm0kn2l3XQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Wed, 25 Feb 2026 16:33:49 +0000
Message-ID: <7604bbac-f0d4-4143-bb08-261042ad89a7@suse.de>
Date: Wed, 25 Feb 2026 17:33:37 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 2/2] net/rds: Delegate fan-out to a background
 worker
To: Allison Henderson <achender@kernel.org>, netdev@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org, pabeni@redhat.com, edumazet@google.com,
 rds-devel@oss.oracle.com, kuba@kernel.org, horms@kernel.org,
 linux-rdma@vger.kernel.org, allison.henderson@oracle.com
References: <20260223221918.2750209-1-achender@kernel.org>
 <20260223221918.2750209-3-achender@kernel.org>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260223221918.2750209-3-achender@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261026-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.de:mid,suse.de:dkim]
X-Rspamd-Queue-Id: 4DB2919AC73
X-Rspamd-Action: no action

On 2/23/26 11:19 PM, Allison Henderson wrote:
> From: Gerd Rausch <gerd.rausch@oracle.com>
> 
> Delegate fan-out to a background worker in order to allow
> kernel_getpeername() to acquire a lock on the socket.
> 
> This has become necessary since the introduction of
> commit "9dfc685e0262d ("inet: remove races in inet{6}_getname()")
> 
> The socket is already locked in the context that
> "kernel_getpeername" used to get called by either
> rds_tcp_recv_path" or "tcp_v{4,6}_rcv",
> and therefore causing a deadlock.
> 
> Luckily, the fan-out need not happen in-context nor fast,
> so we can easily just do the same in a background worker.
> 
> Also, while we're doing this, we get rid of the unused
> struct members "t_conn_w", "t_send_w", "t_down_w" & "t_recv_w".
> 
> The fan-out work and the shutdown worker (cp_down_w) are both
> queued on the same ordered workqueue (cp0->cp_wq), so they
> cannot execute concurrently.  We only need cancel_work_sync()
> in rds_tcp_conn_free() and rds_tcp_conn_path_connect() because
> those run from outside the ordered workqueue.
> 
> Signed-off-by: Gerd Rausch <gerd.rausch@oracle.com>
> Signed-off-by: Allison Henderson <achender@kernel.org>
> ---
>   net/rds/tcp.c         |  3 +++
>   net/rds/tcp.h         |  7 ++----
>   net/rds/tcp_connect.c |  2 ++
>   net/rds/tcp_listen.c  | 54 +++++++++++++++++++++++++++++++------------
>   4 files changed, 46 insertions(+), 20 deletions(-)
> 

Isn't this change kind of dangerous since 021fd0f87004 ("net/rds: fix 
recursive lock in rds_tcp_conn_slots_available") [1]?. Why is 
kernel_getpeername() needed as only the peer source port is required for 
the operation?

Thanks,
Fernando.

