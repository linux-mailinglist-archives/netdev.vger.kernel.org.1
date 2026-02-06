Return-Path: <netdev+bounces-257611-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SPmbE70Whmk1JgQAu9opvQ
	(envelope-from <netdev+bounces-257611-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 17:28:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5312100427
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 17:28:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CCF2330071F4
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 16:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F039D32D0D0;
	Fri,  6 Feb 2026 16:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ir0rXcpH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="33m1iJtR";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ir0rXcpH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="33m1iJtR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F86D32C949
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 16:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770395282; cv=none; b=diJzokUPy/vhcxC8zpp/BHCRSXcsB+eg4IzDawSJT9FpgC9QjG5s/4/25wIVpR/bZF+0hjJRj0bg7UwdaYIgCDC0/phHdGiR32wh3m0nglr5WyXRfWUe0YlA/D/6pQ1+W3y/fYN8ZyMgH4k4a90xVap7ae+RniC9IyP2kS/bW2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770395282; c=relaxed/simple;
	bh=/AiB35Gjy3wlT2sEYVOPPJv9l3gTfwobPX24vwL6p0U=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=uiUTNcD3v7XuFmzMF6NL9WSeD+pARQkODD+j/9yceuyiVED/lL/a1bIvEAs7Q/rpvHmg3DlTL2Ipapp9VcrAmK1zJpmTVA2yz5gkAkn6LbWNx5kmSlNU5CjQZnaTMSogP8dGaaamn2nXib7xHDro4UuIogOwwTfrv0rhXK3dR4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ir0rXcpH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=33m1iJtR; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ir0rXcpH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=33m1iJtR; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A96D25BCC2;
	Fri,  6 Feb 2026 16:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770395280; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k4qA1Ny04PNgcQU9wnD/bgUUvMWrn4w68J5Yz+7Pguc=;
	b=ir0rXcpHqf2xVjIIu+rCNDBINYTlynqlJWUxlURwbCNxkZjZrwzX/o67hBvhs7GQvQxsSN
	jEcVmNDg3Ro1cinfDyNB9R2UDhq22DZkBZJyu2nhroN6T4r9z3FFKosf8TQGbVegcsHwXe
	5w/9EySaenjPFQOfF4DWArcLCkof1PE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770395280;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k4qA1Ny04PNgcQU9wnD/bgUUvMWrn4w68J5Yz+7Pguc=;
	b=33m1iJtRxi6OPHgs7tUen8+b3QEqDC9IqkeQ+pdAmc68rXQpnRtFYUyGlaOpzCys/S3g+x
	LDswdmQDjTvvpZAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ir0rXcpH;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=33m1iJtR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770395280; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k4qA1Ny04PNgcQU9wnD/bgUUvMWrn4w68J5Yz+7Pguc=;
	b=ir0rXcpHqf2xVjIIu+rCNDBINYTlynqlJWUxlURwbCNxkZjZrwzX/o67hBvhs7GQvQxsSN
	jEcVmNDg3Ro1cinfDyNB9R2UDhq22DZkBZJyu2nhroN6T4r9z3FFKosf8TQGbVegcsHwXe
	5w/9EySaenjPFQOfF4DWArcLCkof1PE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770395280;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k4qA1Ny04PNgcQU9wnD/bgUUvMWrn4w68J5Yz+7Pguc=;
	b=33m1iJtRxi6OPHgs7tUen8+b3QEqDC9IqkeQ+pdAmc68rXQpnRtFYUyGlaOpzCys/S3g+x
	LDswdmQDjTvvpZAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D4BAA3EA63;
	Fri,  6 Feb 2026 16:27:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LxkPMY8WhmkuSgAAD6G6ig
	(envelope-from <fmancera@suse.de>); Fri, 06 Feb 2026 16:27:59 +0000
Message-ID: <1649583d-71c2-425e-a2df-685d5f6dc67d@suse.de>
Date: Fri, 6 Feb 2026 17:27:48 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next] inet: add ip_retry_random_port sysctl to
 reduce sequential port retries
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, corbet@lwn.net, ncardwell@google.com,
 kuniyu@google.com, dsahern@kernel.org, idosch@nvidia.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Thorsten Toepper <thorsten.toepper@sap.com>
References: <20260203175422.4620-1-fmancera@suse.de>
 <CANn89i+UUWx5OhPnJnDhiCfr53BPTAGedBucgqYwyfqkidf_Cg@mail.gmail.com>
 <8d94faf9-2fb6-483d-9767-bd665c4a4b9a@suse.de>
Content-Language: en-US
In-Reply-To: <8d94faf9-2fb6-483d-9767-bd665c4a4b9a@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-257611-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sap.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E5312100427
X-Rspamd-Action: no action

On 2/4/26 6:29 PM, Fernando Fernandez Mancera wrote:
> On 2/4/26 5:49 PM, Eric Dumazet wrote:
>> On Tue, Feb 3, 2026 at 6:54 PM Fernando Fernandez Mancera
>> <fmancera@suse.de> wrote:
>>>
>>> With the current port selection algorithm, ports after a reserved port
>>> or long time used port are used more often than others. This combines
>>> with cloud environments blocking connections between the application
>>> server and the database server if there was a previous connection with
>>> the same source port. This leads to connectivity problems between
>>> applications on cloud environments.
>>>
>>> The situation is that a source tuple is usable again after being closed
>>> for a maximum lifetime segment of two minutes while in the firewall it's
>>> still noted as existing for 60 minutes or longer. So in case that the
>>> port is reused for the same target tuple before the firewall cleans up,
>>> the connection will fail due to firewall interference which itself will
>>> reset the activity timeout in its own table. We understand the real
>>> issue here is that these firewalls cannot cope with standards-compliant
>>> port reuse. But this is a workaround for such situations and an
>>> improvement on the distribution of ports selected.
>>>
>>> The proposed solution is instead of incrementing the port number,
>>> performing a re-selection of a new random port within the remaining
>>> range. This solution is configured via sysctl new option
>>> "net.ipv4.ip_retry_random_port".
>>>
>>> The test run consists of two processes, a client and a server, and loops
>>> connect to the server sending some bytes back. The results we got are
>>> promising:
>>>
>>> Executed test: Current algorithm
>>> ephemeral port range: 9000-65499
>>> simulated selections: 10000000
>>> retries during simulation: 14197718
>>> longest retry sequence: 5202
>>>
>>> Executed test: Proposed modified algorithm
>>> ephemeral port range: 9000-65499
>>> simulated selections: 10000000
>>> retries during simulation: 3976671
>>> longest retry sequence: 12
>>>
>>> In addition, on graphs generated we can observe that the distribution of
>>> source ports is more even with the proposed patch.
>>>
>>> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
>>> Tested-by: Thorsten Toepper <thorsten.toepper@sap.com>
>>> ---
>>>   .../networking/net_cachelines/netns_ipv4_sysctl.rst        | 1 +
>>>   include/net/netns/ipv4.h                                   | 1 +
>>>   net/ipv4/inet_hashtables.c                                 | 7 ++++++-
>>>   net/ipv4/sysctl_net_ipv4.c                                 | 7 +++++++
>>>   4 files changed, 15 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/networking/net_cachelines/ 
>>> netns_ipv4_sysctl.rst b/Documentation/networking/net_cachelines/ 
>>> netns_ipv4_sysctl.rst
>>> index beaf1880a19b..c4041fdca01e 100644
>>> --- a/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst
>>> +++ b/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst
>>> @@ -47,6 +47,7 @@ u8                              sysctl_tcp_ecn
>>>   u8                              sysctl_tcp_ecn_fallback
>>>   u8                              
>>> sysctl_ip_default_ttl                                                                ip4_dst_hoplimit/ip_select_ttl
>>>   u8                              sysctl_ip_no_pmtu_disc
>>> +u8                              sysctl_ip_retry_random_port
>>>   u8                              
>>> sysctl_ip_fwd_use_pmtu                       
>>> read_mostly                             ip_dst_mtu_maybe_forward/ 
>>> ip_skb_dst_mtu
>>>   u8                              
>>> sysctl_ip_fwd_update_priority                                                        ip_forward
>>>   u8                              sysctl_ip_nonlocal_bind
>>> diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
>>> index 2dbd46fc4734..d04b07e7c935 100644
>>> --- a/include/net/netns/ipv4.h
>>> +++ b/include/net/netns/ipv4.h
>>> @@ -156,6 +156,7 @@ struct netns_ipv4 {
>>>
>>>          u8 sysctl_ip_default_ttl;
>>>          u8 sysctl_ip_no_pmtu_disc;
>>> +       u8 sysctl_ip_retry_random_port;
>>>          u8 sysctl_ip_fwd_update_priority;
>>>          u8 sysctl_ip_nonlocal_bind;
>>>          u8 sysctl_ip_autobind_reuse;
>>> diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
>>> index f5826ec4bcaa..f1c79a7d3fd3 100644
>>> --- a/net/ipv4/inet_hashtables.c
>>> +++ b/net/ipv4/inet_hashtables.c
>>> @@ -1088,8 +1088,13 @@ int __inet_hash_connect(struct 
>>> inet_timewait_death_row *death_row,
>>>          for (i = 0; i < remaining; i += step, port += step) {
>>>                  if (unlikely(port >= high))
>>>                          port -= remaining;
>>> -               if (inet_is_local_reserved_port(net, port))
>>> +               if (inet_is_local_reserved_port(net, port)) {
>>> +                       if (net->ipv4.sysctl_ip_retry_random_port) {
>>> +                               port = low + 
>>> get_random_u32_below(remaining);
>>> +                               port = ((port & 1) == step) ? port : 
>>> (port - 1);
>>> +                       }
>>
>> What happens when almost  all ephemeral ports are in use, and
>> hundreds of ports are reserved ?
>>
>> Choosing a random value each time we meet a reserved port is going to
>> be quite expensive,
>> and we might return an error from this function even if there are many
>> available ports.
>>
>> Perhaps randomly select @step one time at the beginning of this
>> function so that  @step/2 and @remaining/2
>> are relatively prime numbers.
>>
> 
> That actually makes sense. It would ensure all ports are visited before 
> returning an error. Let me test this out.
> 

It makes sense. I have tested this approach and we got a more even 
distribution of source ports when having thousands of reserved ports. No 
difference at all when not using reserved ports.

Please, you can find the distribution graph with the current algorithm 
[1] and with the random step algorithm [2].

While I understand that this approach is introducing a call to 
get_random_u32_below() on every connect, I am wondering if it makes 
sense to replace the existing algorithm with this variant. What do you 
think?

Please, notice the implementation below. I plan to send an official v1 
once net-next is open. In addition, I am rewriting the commit message as 
I find the current one confusing.

[1] https://0xffsoftware.com/port_graph_current_alg.html

[2] https://0xffsoftware.com/port_graph_random_step_alg.html

Thanks,
Fernando.

diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index f5826ec4bcaa..10ecad190bae 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -16,6 +16,7 @@
  #include <linux/wait.h>
  #include <linux/vmalloc.h>
  #include <linux/memblock.h>
+#include <linux/gcd.h>

  #include <net/addrconf.h>
  #include <net/inet_connection_sock.h>
@@ -1046,11 +1047,11 @@ int __inet_hash_connect(struct 
inet_timewait_death_row *death_row,
  	struct net *net = sock_net(sk);
  	struct inet_bind2_bucket *tb2;
  	struct inet_bind_bucket *tb;
+	int step, scan_step, l3mdev;
  	bool tb_created = false;
  	u32 remaining, offset;
  	int ret, i, low, high;
  	bool local_ports;
-	int step, l3mdev;
  	u32 index;

  	if (port) {
@@ -1065,6 +1066,7 @@ int __inet_hash_connect(struct 
inet_timewait_death_row *death_row,

  	local_ports = inet_sk_get_local_port_range(sk, &low, &high);
  	step = local_ports ? 1 : 2;
+	scan_step = step;

  	high++; /* [32768, 60999] -> [32768, 61000[ */
  	remaining = high - low;
@@ -1083,9 +1085,20 @@ int __inet_hash_connect(struct 
inet_timewait_death_row *death_row,
  	 */
  	if (!local_ports)
  		offset &= ~1U;
+	if (net->ipv4.sysctl_ip_retry_random_port) {
+		u32 range = (step == 1) ? remaining : (remaining / 2);
+
+		scan_step = 1 + get_random_u32_below(range - 1);
+		while (gcd(scan_step, range) != 1) {
+			scan_step++;
+			if (unlikely(scan_step >= range))
+				scan_step = 1;
+		}
+		scan_step *= step;
+	}
  other_parity_scan:
  	port = low + offset;
-	for (i = 0; i < remaining; i += step, port += step) {
+	for (i = 0; i < remaining; i += step, port += scan_step) {
  		if (unlikely(port >= high))
  			port -= remaining;
  		if (inet_is_local_reserved_port(net, port))


> Thank you Eric,
> Fernando.
> 


