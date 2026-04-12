Return-Path: <netdev+bounces-277880-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wF0VO6Tz22mcJQkAu9opvQ
	(envelope-from <netdev+bounces-277880-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 21:33:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 699803E5BB9
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 21:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6F536300C24B
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 19:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD3930ACEE;
	Sun, 12 Apr 2026 19:33:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630F2145A05
	for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 19:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776022432; cv=none; b=QHSwVfRHA31guevvIN/2DRtbUZ2eqsXjPyKvYgX0ULgEG0aRjhQiN0OsfaThr8OuTrK9LfOQX4NVVKdbPx41YFm7xE/FzCrdsngmBA+tgAdylkwNyhhw0WhEfz7pAqa4ooOalAooxb2FYw3MFK64QekW/opca2z4z78s1eOXcaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776022432; c=relaxed/simple;
	bh=yDEDPpqbM8Z/77b4gycFn6AmEXqfwzWqDYAvlnB1XV8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NN/0OjGzlb4/pmG53rjXddK/XiLs3K2fw15av0qNts/YvpzWK8l+h320PMMbrPT9DDE3OBCzzzktypfJkHQQKvPH4+wuuFvmUFCZXG/AWOAOWyPJOaERcNLMM33a4TMsrKVl8icsrY126qO+6v58fFnJKkD2y9S/qoThjLAHHAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-488aa77a06eso63258195e9.0
        for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 12:33:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776022430; x=1776627230;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:cc:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KOTLejNEPbpQVFeQ6ITPzs9RBbS8BIcDxgD7TT9dNbk=;
        b=MnhARnQONh5ldrFtpBv32HZGFPN28AjTh2SXuFiOX5S1lC+5r1g6hce0B1en6IAZz6
         as6PfXOg+ERykYP4L02PjJkzhIQqAxBzR8hqOnrhOZH42RNaLAt6fAgsZJlhEYj6V34E
         Qrc13+CQFRfHUOvH3+vpd3wugEAnIe/0Ib8cAKRBZnrn7oxqk7+zKbKefkD62ZR0/EB8
         KFYcjWheg7R6BHD9rliBXsPhLQSpy2NGfJNkoZniPJ2e/83zKAOHJbFi6L3SHmiGceU9
         8AyMO0b6jiZ+9DfedO48KllylG9fr+sjqJEfYiYWAHT4zdA2rzBiv2zITCNQYkbeT/eq
         6Oxg==
X-Forwarded-Encrypted: i=1; AJvYcCUKiD5iC39qEi2r5IcN4XiJRjVzyMuNAQ9mAtIFib+vP5h9ti+Y+ga8lQUuKrJe+8o/LYOR8rk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2rLfiqvpE7D35k2xUPg3sWa3Q2iuicxfJKsCIf7HRomU1PzLY
	DbW/i/+m9bWvbgqeglXNJO4za7mOOwNQ+FH5WthKdy2mXyMEkdmyRiVM
X-Gm-Gg: AeBDievrMXnVXoePLtpFaDtmQKeMAlMj0AXrGLLXv+phouW1GH+zCzDwnzkz82GTRnY
	gnN72nGdU2EBWNwXQHBisViQfYw+tIRoHpHO0Aun+3TO/cDV9C0fCxoqrfbrkMErN0lFcI9W7qi
	mvQfi/Vn6IKhHd76TSoWpVyFuyhBgJKoBqqSOTWLBvx6RGsg4eeRjwDUGXf2Od7b/7NA9FRXW7/
	2vUP5/aLh749clEeaP9e7CmvOqOcQVVYnG8du6cCbGbLF92cTWHXFU85egn0vUJrqAX6nph9x6r
	aYLUpzOVzvWz1l5f4DrgBh89R9kLvZA+lcXl/09PW1rGzVodGMi9/NIGb7Z/qw3e+rFpR4mbUam
	xY5LEYSfW0sTsHzQkSc+1snRqArdpugz4nMs1pSwL7CfvMaH2+ryy3339b0mypKH97EnwIcwbbm
	z37E8/kIR+Q/C1NKlONuc9M8w//dtWT9/M5ESL/1Ic9N2MjtHRqR/x34pwaFdPYlHW9A==
X-Received: by 2002:a05:600c:5298:b0:485:3ee1:eba5 with SMTP id 5b1f17b1804b1-488d68820abmr157126835e9.27.1776022429533;
        Sun, 12 Apr 2026 12:33:49 -0700 (PDT)
Received: from [192.168.88.241] (37-48-40-237.nat.epc.tmcz.cz. [37.48.40.237])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d5b56d1asm232309975e9.15.2026.04.12.12.33.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Apr 2026 12:33:49 -0700 (PDT)
Message-ID: <a1abcb71-afcc-44f6-b3f9-3e315e2c95c9@ovn.org>
Date: Sun, 12 Apr 2026 21:33:47 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: i.maximets@ovn.org, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Flavio Leitner <fbl@sysclose.org>, Mark Gray <mark.d.gray@redhat.com>,
 netdev@vger.kernel.org, Xiang Mei <xmei5@asu.edu>,
 sunichi <sunyiqixm@gmail.com>, ovs dev <dev@openvswitch.org>
Subject: Re: [PATCH v2 net] openvswitch: fix vport netlink reply size for
 large upcall PID arrays
To: Weiming Shi <bestswngs@gmail.com>, Aaron Conole <aconole@redhat.com>,
 Eelco Chaudron <echaudro@redhat.com>
References: <v1-message-id> <20260411141448.1479933-3-bestswngs@gmail.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <20260411141448.1479933-3-bestswngs@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[ovn.org,davemloft.net,google.com,kernel.org,redhat.com,sysclose.org,vger.kernel.org,asu.edu,gmail.com,openvswitch.org];
	TAGGED_FROM(0.00)[bounces-277880-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[ovn.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[i.maximets@ovn.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.986];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ovn.org:mid]
X-Rspamd-Queue-Id: 699803E5BB9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/11/26 4:14 PM, Weiming Shi wrote:
> The vport netlink reply helpers allocate a fixed-size skb with
> nlmsg_new(NLMSG_DEFAULT_SIZE, ...) but serialize the full upcall PID
> array via ovs_vport_get_upcall_portids(). Since
> ovs_vport_set_upcall_portids() accepts any non-zero multiple of
> sizeof(u32) with no upper bound, a CAP_NET_ADMIN user can install a PID
> array large enough to overflow the reply buffer. On systems with
> unprivileged user namespaces enabled (e.g., Ubuntu default), this is
> reachable via unshare -Urn since all OVS vport genl operations use
> GENL_UNS_ADMIN_PERM.
> 
> When the subsequent nla_put() fails with -EMSGSIZE, five BUG_ON(err < 0)
> sites fire and panic the kernel:
> 
>  kernel BUG at net/openvswitch/datapath.c:2414!
>  Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
>  CPU: 1 UID: 0 PID: 65 Comm: poc Not tainted 7.0.0-rc7-00195-geb216e422044 #1
>  RIP: 0010:ovs_vport_cmd_set+0x34c/0x400
>  Call Trace:
>   <TASK>
>   genl_family_rcv_msg_doit (net/netlink/genetlink.c:1116)
>   genl_rcv_msg (net/netlink/genetlink.c:1194)
>   netlink_rcv_skb (net/netlink/af_netlink.c:2550)
>   genl_rcv (net/netlink/genetlink.c:1219)
>   netlink_unicast (net/netlink/af_netlink.c:1344)
>   netlink_sendmsg (net/netlink/af_netlink.c:1894)
>   __sys_sendto (net/socket.c:2206)
>   __x64_sys_sendto (net/socket.c:2209)
>   do_syscall_64 (arch/x86/entry/syscall_64.c:63)
>   entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
>   </TASK>
>  Kernel panic - not syncing: Fatal exception
> 
> Fix this by dynamically sizing the reply skb to account for the actual
> PID array length, and replace the BUG_ON() calls with graceful error
> returns.

Hi, Weiming.  Thanks for working on this!  The earlier attempt to fix this
problem was here:
  https://lore.kernel.org/netdev/20260323071435.1945543-1-sunyiqixm@gmail.com/
CC: sunichi, maybe you can cooperate on the fix somehow.

A few problems with the solution here:

- You're locking to count the number of pids, then unlocking and then
  re-locking to fill the output.  This is racy and may still cause the
  inability to put all the data into allocated space, since the number can
  theoretically change.

- Failing the del command is very unfriendly to the userspace and also it
  becomes impossible for the user to delete the port without clearing the
  upcall pids first, which they will not know to do.

- Failing the new command as done in this change is very confusing as the
  port is actually created while the user gets the error.

- NLMSG_DEFAULT_SIZE + portids_size is not the actual size of the message,
  nothing in the code guarantees that the rest fits into NLMSG_DEFAULT_SIZE.

- The number of pids being unbounded is a problem in itself.

So, we need to approach this issue differently.  As I suggested in the thread
linked above, we should limit the maximum number of the pid to the number of
CPUs, as it is done for the per-cpu dispatch socket array.  There is no point
in more sockets than CPUs and the userspace never creates that many.  This way
we can:
- Fail the attempts to set up more pids than CPUs in the first place.
- Know beforehand the maximum size to allocate - no need to check the actual
  number and re-lock.  Create a function similar to ovs_dp_cmd_msg_size()
  to allocate based on what can be included in the worst case, which shouldn't
  be a lot.

And all the BUG_ON() calls must remain BUG_ON()s as it is a bug if we're not
counting correctly.

> Fixes: b83d23a2a38b ("openvswitch: Introduce per-cpu upcall dispatch")

This is not the right commit.  The change you're making has nothing to do with
the per-cpu dispatch.  The actual commit you're looking for is much older:
  5cd667b0a456 ("openvswitch: Allow each vport to have an array of 'port_id's.")

Couple more notes:

- Wait at least 24 hours between versions.  Otherwise, people have no enough
  time to look at your patch.

- Please, CC all maintainers including the ovs-dev list.  It is moderated for
  new senders (the only reliable way to keep it out of spam) but we approve
  fast, so your next emails should go right through.

Best regards, Ilya Maximets.

