Return-Path: <netdev+bounces-256411-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aISrNRk5gmmVQgMAu9opvQ
	(envelope-from <netdev+bounces-256411-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 19:06:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F19EADD4F3
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 19:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3510E300EBD0
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 18:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2920939A7E0;
	Tue,  3 Feb 2026 18:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XITsHILt";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DFQSSxxq";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XITsHILt";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DFQSSxxq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C69214A97
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 18:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770141771; cv=none; b=RVguLafX55hOBWIACz1lo7TJRh31qetlvURo09qvwahyHL6UY7lIbZomS7fZR7nAX8z1bClYMP9K9ni+Cv0Z56vILAzqiaEhihQcqkLGQXWaeQHn2vPQf2TJNjd3KKLnPTnqf4ZdOgLF9aHQNTx3yKBb0wRNj01CcTooLCaAcV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770141771; c=relaxed/simple;
	bh=S5CpUK9YegmU8s0FDZu9mTD+GXNLfMVJCoCqy8pXF2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hT9KuH4JmFpV6VnEkMG2xXKmnn/gec8e/NvC4M1VXUsFWmbHNwGUw3Lr/el0tRTtvouQfHRVhK0ZdUd8b7+VpnkExO/ee9LVT7kUd0nMTSMMtiZ4hecS8JkyWV0M21eI+05VEX2WcMGD5bNSJo2aQDyBq5CW3bSd0o50nuSyA54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XITsHILt; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DFQSSxxq; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XITsHILt; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DFQSSxxq; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 48D083E6C3;
	Tue,  3 Feb 2026 18:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770141768; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bvpifnAHbAc/4eZdIwXkQqPPTY48IZP4sfnWPh0379I=;
	b=XITsHILtHIxTiw1sshuZNydcdcLutSq808+WE6HjNZL1qCHFquTaAhoGzUBik+W40qJpkj
	4/xPP7Hs6wQ20TvbFvXtMBDqj7P+FzCO6J/GyASUwbDR0bjBwEz1Wtaw++xamh7fLlPUJJ
	uqlTECYs4t0wbuaytHpxdcZk75jPVoQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770141768;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bvpifnAHbAc/4eZdIwXkQqPPTY48IZP4sfnWPh0379I=;
	b=DFQSSxxqHrH8kGWyzj/RVkC77xn54ckcbuHjyUUrkp6hL8WJJS93H3cBCI2J5E+pznAh6i
	LD5ewP7km8odvECw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=XITsHILt;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=DFQSSxxq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770141768; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bvpifnAHbAc/4eZdIwXkQqPPTY48IZP4sfnWPh0379I=;
	b=XITsHILtHIxTiw1sshuZNydcdcLutSq808+WE6HjNZL1qCHFquTaAhoGzUBik+W40qJpkj
	4/xPP7Hs6wQ20TvbFvXtMBDqj7P+FzCO6J/GyASUwbDR0bjBwEz1Wtaw++xamh7fLlPUJJ
	uqlTECYs4t0wbuaytHpxdcZk75jPVoQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770141768;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bvpifnAHbAc/4eZdIwXkQqPPTY48IZP4sfnWPh0379I=;
	b=DFQSSxxqHrH8kGWyzj/RVkC77xn54ckcbuHjyUUrkp6hL8WJJS93H3cBCI2J5E+pznAh6i
	LD5ewP7km8odvECw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6ECF63EA62;
	Tue,  3 Feb 2026 18:02:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id I0eVF0c4gmlbdAAAD6G6ig
	(envelope-from <fmancera@suse.de>); Tue, 03 Feb 2026 18:02:47 +0000
Message-ID: <b20965f7-e251-4793-951e-f211d179dbba@suse.de>
Date: Tue, 3 Feb 2026 19:02:36 +0100
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
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-256411-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sap.com:email,suse.de:email,suse.de:dkim,suse.de:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F19EADD4F3
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

I just noticed I didn't add the following diffs to the patch. Please 
keep them on mind and sorry for the inconvenience.

diff --git a/Documentation/networking/ip-sysctl.rst 
b/Documentation/networking/ip-sysctl.rst
index bc9a01606daf..e6ae9400332c 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -1610,6 +1610,17 @@ ip_local_reserved_ports - list of comma separated 
ranges

  	Default: Empty

+ip_retry_random_port - BOOLEAN
+        Randomize the selection of a new port if a reserved port is hit 
during
+        automatic port selection instead of incrementing the port number.
+
+        Possible values:
+
+        - 0 (disabled)
+        - 1 (enabled)
+
+        Default: 0 (disabled)
+
  ip_unprivileged_port_start - INTEGER
  	This is a per-namespace sysctl.  It defines the first
  	unprivileged port in the network namespace.  Privileged ports
diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index 5eade7d9e4a2..32ca260701ba 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -828,6 +828,8 @@ static struct ctl_table ipv4_net_table[] = {
  		.data		= &init_net.ipv4.sysctl_ip_retry_random_port,
  		.mode		= 0644,
  		.proc_handler	= proc_dou8vec_minmax,
+		.extra1         = SYSCTL_ZERO,
+		.extra2         = SYSCTL_ONE,
  	},
  	{
  		.procname	= "ip_local_reserved_ports",

