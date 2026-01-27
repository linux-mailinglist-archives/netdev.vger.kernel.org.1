Return-Path: <netdev+bounces-254000-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLQNG7kbeWmPvQEAu9opvQ
	(envelope-from <netdev+bounces-254000-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 21:10:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E4FB39A3E6
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 21:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 78A053058B87
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 20:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C2B322B74;
	Tue, 27 Jan 2026 20:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cWvWJBWj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04DB28489E;
	Tue, 27 Jan 2026 20:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769544599; cv=none; b=PxZrYOuAk5P/oXQrf/eukVKU1H+ullfQPVLyLUOhH4T5M/2vyFG7QMesxLL6e9Sxi6miUjxZ3f1FcqFjW7KgHYwCCD6fkzglNVVxM3YhY7+7DkMv+i+6IREkAeGg81RPfgSnj2s68ZwqllTndRzvuYd/VxICXQLJCrnuGXBzEKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769544599; c=relaxed/simple;
	bh=WJHgbRzk+nm2ozhgo4Pc1OQr2YTFqZyBdg7StnRy7CA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L1u2nVdegDFznd1+1N5dH/RGxP+31NW0DI2vJQmETiWG+aZK03+Rg1pna7EyzE07rDJcuttwLOmc0GVr6ykk+NncsakYMpVrVFDUdcYMUKC7ErXK7iIj5F3ut60wUjXzMjxAh9G5gwEzpqexetdttoUDg1Jdl/l7IC7XBUoMVxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cWvWJBWj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E833CC116C6;
	Tue, 27 Jan 2026 20:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769544599;
	bh=WJHgbRzk+nm2ozhgo4Pc1OQr2YTFqZyBdg7StnRy7CA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cWvWJBWjLej5U/XidMpk0CHSRUPbMf6CASETSQphNAImXnnzilNNG77yYQOHduz+C
	 VUpCUAVIRyQsykkwpBeMGD8bHXyTyOZ6saVt3e7DX2KglYbPHobVn5m/tUxH9d53WZ
	 QQUeSsNasg6ZUWyDuLJBkCWYdf+y+dULLxsVnc/ibOtjejr67uzvmQuegPGamT7CNQ
	 NEt4+NkB042+qSFIlnoN67TslSkuqaKMjkhbhxOHM0xubDHyRlwLt3EjP1jSMI/8Re
	 YwzNXvvzGc4Y8AFWokbJye0RjmbySohEbNqTscde4O0J+VjtUG51LomQWzR6dX0nkB
	 1A63wlBws4qrw==
Date: Tue, 27 Jan 2026 12:09:57 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: chia-yu.chang@nokia-bell-labs.com
Cc: pabeni@redhat.com, edumazet@google.com, parav@nvidia.com,
 linux-doc@vger.kernel.org, corbet@lwn.net, horms@kernel.org,
 dsahern@kernel.org, kuniyu@google.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com,
 stephen@networkplumber.org, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, andrew+netdev@lunn.ch, donald.hunter@gmail.com,
 ast@fiberby.net, liuhangbin@gmail.com, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, ij@kernel.org, ncardwell@google.com,
 koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com,
 ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
 cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
 vidhi_goel@apple.com
Subject: Re: [PATCH v11 net-next 10/15] tcp: accecn: unset ECT if receive or
 send ACE=0 in AccECN negotiaion
Message-ID: <20260127120957.76e52cc5@kernel.org>
In-Reply-To: <20260123100721.42451-11-chia-yu.chang@nokia-bell-labs.com>
References: <20260123100721.42451-1-chia-yu.chang@nokia-bell-labs.com>
	<20260123100721.42451-11-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[redhat.com,google.com,nvidia.com,vger.kernel.org,lwn.net,kernel.org,gmail.com,mojatatu.com,networkplumber.org,resnulli.us,davemloft.net,lunn.ch,fiberby.net,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-254000-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33]
X-Rspamd-Queue-Id: E4FB39A3E6
X-Rspamd-Action: no action

On Fri, 23 Jan 2026 11:07:16 +0100 chia-yu.chang@nokia-bell-labs.com
wrote:
> Based on specification:
>   https://tools.ietf.org/id/draft-ietf-tcpm-accurate-ecn-28.txt
> 
> Based on Section 3.1.5 of AccECN spec (RFC9768), a TCP Server in
> AccECN mode MUST NOT set ECT on any packet for the rest of the connection,
> if it has received or sent at least one valid SYN or Acceptable SYN/ACK
> with (AE,CWR,ECE) = (0,0,0) during the handshake.
> 
> In addition, a host in AccECN mode that is feeding back the IP-ECN
> field on a SYN or SYN/ACK MUST feed back the IP-ECN field on the
> latest valid SYN or acceptable SYN/ACK to arrive.

FWIW this series is marked as Changes Requested in patchwork. 
I don't think I did that, IDK why it's in that state :S
I see these warnings when I try to apply it:

Applying: selftests/net: packetdrill: add TCP Accurate ECN cases
.git/rebase-apply/patch:325: new blank line at EOF.
+
.git/rebase-apply/patch:1550: new blank line at EOF.
+
.git/rebase-apply/patch:1641: new blank line at EOF.
+
warning: 3 lines add whitespace errors.


Other than that the AI code review made the following comment,
I haven't investigated the expected behavior. Could you TAL?

> @@ -1103,6 +1104,8 @@ static void reqsk_timer_handler(struct timer_list *t)
>  	    (!resend ||
>  	     !tcp_rtx_synack(sk_listener, req) ||
>  	     inet_rsk(req)->acked)) {
> +		if (req->num_retrans > 1 && tcp_rsk(req)->accecn_ok)
> +			tcp_rsk(req)->accecn_fail_mode |= TCP_ACCECN_ACE_FAIL_SEND;

Note: This correctly sets the flag on tcp_rsk(req)->accecn_fail_mode,
which will be propagated to the child socket via tcp_ecn_openreq_child().

> diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c

[ ... ]

> @@ -481,6 +481,8 @@ static void tcp_ecn_openreq_child(struct sock *sk,
>  		tp->syn_ect_snt = treq->syn_ect_snt;
>  		tcp_accecn_third_ack(sk, skb, treq->syn_ect_snt);
>  		tp->saw_accecn_opt = treq->saw_accecn_opt;
> +		if (treq->accecn_fail_mode & TCP_ACCECN_ACE_FAIL_SEND)
> +			tcp_accecn_fail_mode_set(tp, TCP_ACCECN_ACE_FAIL_SEND);

This propagates TCP_ACCECN_ACE_FAIL_SEND from the request socket to the
child, but TCP_ACCECN_ACE_FAIL_RECV is not propagated here.

> @@ -749,16 +751,32 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
>  		 */
>  		if (!tcp_oow_rate_limited(sock_net(sk), skb,
>  					  LINUX_MIB_TCPACKSKIPPEDSYNRECV,
> -					  &tcp_rsk(req)->last_oow_ack_time) &&
> -
> -		    !tcp_rtx_synack(sk, req)) {
> -			unsigned long expires = jiffies;
> -
> -			expires += tcp_reqsk_timeout(req);
> -			if (!fastopen)
> -				mod_timer_pending(&req->rsk_timer, expires);
> -			else
> -				req->rsk_timer.expires = expires;
> +					  &tcp_rsk(req)->last_oow_ack_time)) {
> +			if (tcp_rsk(req)->accecn_ok) {
> +				u8 ect_rcv = TCP_SKB_CB(skb)->ip_dsfield &
> +					     INET_ECN_MASK;
> +
> +				tcp_rsk(req)->syn_ect_rcv = ect_rcv;
> +				if (tcp_accecn_ace(tcp_hdr(skb)) == 0x0) {
> +					u8 fail_mode = TCP_ACCECN_ACE_FAIL_RECV;
> +
> +					tcp_accecn_fail_mode_set(tcp_sk(sk),
> +								 fail_mode);

Should this be setting the flag on the request socket instead of the
listener socket? Here tcp_sk(sk) is the listener, but reqsk_timer_handler()
uses tcp_rsk(req)->accecn_fail_mode for the same purpose. The flag set
on the listener socket will not be propagated to the child socket, so
the child may incorrectly set ECT on outgoing packets even after receiving
a SYN with ACE=0.

For consistency with reqsk_timer_handler() and to ensure the flag reaches
the child socket, this might need to be:

    tcp_rsk(req)->accecn_fail_mode |= fail_mode;

> +				}
> +			}
> +			if (!tcp_rtx_synack(sk, req)) {
> +				unsigned long expires = jiffies;
> +
> +				tcp_accecn_ace_fail_send_set_retrans(req,
> +								     tcp_sk(sk));

Similar question here: tcp_accecn_ace_fail_send_set_retrans() sets the
flag on tcp_sk(sk) (the listener), while reqsk_timer_handler() sets it
on tcp_rsk(req). Is this intentional?

