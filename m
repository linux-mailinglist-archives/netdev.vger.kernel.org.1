Return-Path: <netdev+bounces-298783-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uzbJBCdhLGq2QAQAu9opvQ
	(envelope-from <netdev+bounces-298783-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 21:42:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 58BDB67C1E9
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 21:42:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=shfDh4E5;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298783-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298783-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8066A31CE796
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 19:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8D136CDE0;
	Fri, 12 Jun 2026 19:41:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58ED33D4F8
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 19:41:38 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781293299; cv=pass; b=PabIKl5xdSrm7iefBHy6qoxZwOwVyA7e2aVWBiMKV1jzW9gaGDUX4DnIUcnlt7HrR1NEspQhMwhIu2j9NoeYak6ZeyqP9vvxeGopKjTE8Ded0II29Ux+L4qqywuYX4sN4oUWFu9U6WWFAIs6gb7QV2BL7/3frEl4h7ajQQ7sWps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781293299; c=relaxed/simple;
	bh=8ZLOGvGFodYhD0qua0VuzQdoTndbnD664tOVgr1qn2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=olkpUZABD3/OOO1QYYbvWsGJ9U22t5Z5bmxoPM+RV6YrJn/1aXiPWJ9Tzc/WtmgDaSjjnjZKROKRZtcY1E+9C220dPfqYICG5NkKk4Eg//LUeBHYBiqSUHJsg9RTPqXM9nqPuzrPRDIUthM0z3hTTBaAaQd3IFSlzl/nVGxpLYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=shfDh4E5; arc=pass smtp.client-ip=209.85.210.174
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-842307473b5so1074284b3a.2
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 12:41:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781293298; cv=none;
        d=google.com; s=arc-20240605;
        b=GrTmjr62MsVMxxlQawcfN50d2cNf29apl7D5XEQvCPNmyWQBmwUlvt+NCSS5/gcB5O
         Dy9SxRygGyiEIVnCPq+KCZQ+w2saBNaXxT5dKnmGCuNUCSPSybAtI5/tI2ins7LCaUKw
         hp7uVvupqU4BQNXLO6mD86SLmey4r49RVaG7IKZGf/dKa4+gHZ69grzYTjBh8Pyps/Mj
         usF9/1UtmHVG+Ig1OswUnKlV7FBE6D/6YBCXp5UZYzWSOodwVw3LfadDMCZgN3RpS/kn
         ERZRQPRxb1SxUPHpnU61KqzO1ugu4qmUWP24FvyYi38r/dZ0TXJa5iUUE07NCyKXnF9+
         qDsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Rbi30ru7gSioJ7/e48J895iPmcFfwsVcpIndfODcrgQ=;
        fh=pqM/IHKozT5n/ugnyQLDk4/nPc4DMMAsaO459tHppXU=;
        b=cPSRCuW8QUTpnrQEuipI3umf/MOi03ZQt3WkLhZ0KDu0rbNKOZVTyKLtRUpOD2ushX
         N/JkmbDnaoxLuPs08xTqu+73QxEQ3apwnsDAbm8hueKiyZuIpFOgm+uDDJ1I1bS6pxsH
         QaNYTqwttU4LOHPVQVQCrDrsWiZE+eKQ+bGSuBiD0QZm1BaLSDhHvBMyN2HZpg+vOVoc
         i0dx3CN7ndBUb4M45FUrC8/xJXHcUKwzdGRmJPqbYB+cbjOl5G1v1qGvdmOuXuM+NrDU
         9eoTiedYiH8JQbGE+NvVBuNXXx7B718b14dTbWyCGD1NwO7EQAyaaMUnLAuXHYhlkXHZ
         Oksw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781293298; x=1781898098; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Rbi30ru7gSioJ7/e48J895iPmcFfwsVcpIndfODcrgQ=;
        b=shfDh4E5C1zufMfR1LU5U6amaDdkIGzntIK5JptXPmIXPyTZfMbVnUelrPu4jxQlU8
         aL6DLro/v59IYt5baaEe+0848jo2VilIMZK3oXL8DbvHvJjY8vl8Ioo6GIJKEMZ569ky
         5dTyCi/SrdvA7tFM3tMKK8I8uroh1b//lSilaCS8DjFwjc0Kp7/GXY49n5KK0OczfyyM
         DIMMdKJtR1UFEPDUByg0NfrgBepJq64rqVtaxMpe1jkqdNoJIu31JH1bksTsZaY4Za6O
         vzOFEyQw26JB35EcaMCkJl1n2qnLu7h2nFN8p6a96R+4ZejwfwkV3iGTzDSG5ZH7JL2a
         YEnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781293298; x=1781898098;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rbi30ru7gSioJ7/e48J895iPmcFfwsVcpIndfODcrgQ=;
        b=tSs+QydIwa88RllEv9QPsGIpNAkL3m3NI6gltyWksxjNmHwRU9hvUTeenF4ZtWvDRs
         3bPcBgMRaeDb5F5Uo2OeavysaMcUoAJ8SJEbLzwzYZ8Dfx9tcM9gb10bQuzRQM/7O+lP
         CslivpPycOFIZwXgTMCOR/eNq5ub2cfktjjpEvOhRk0lLgwdfB0O7JQ2UPFhzyTXUNW0
         Q2/SkCK5+JkarHUY53/ENqFAgj1GcPLyR8NyJ5W6EP9uabGnirpSFhAH9UOdJmgzMhzx
         o9TlhxAKPmurZceEFJBIwG8FNabcDFKcuexqDdaju70wTzxKsZz7RAs6JJ8YLfaTC2St
         Ko1w==
X-Gm-Message-State: AOJu0YwEO2Ayn5er7n9shWFJf4+5wgMnQvaicQGCsB8ri+1M1PUgA4IJ
	5qpACvrLEgMnSBd1Mzi5PHOJh2+/Sup4DPxyQHBP8dEhvWCwF92JXozAtx4yh5LFzNT548QX5kP
	dL4CATH5N5LSknSCtm28ZqgtzRJO9m2fWGz7NuVkvBQ==
X-Gm-Gg: Acq92OH+yyAu+4e36h8gOvz/i7217Qc/uU19WvJ+AMTtsrRzwn+H/oFmQXND64eeDeK
	wYpaMOncKpdXL7FBJGCcRcfpx+CVyuHpY1ykaQduQIYMbmZMVnty5hEYz4VU1s4CiwHQUNhtFli
	rKhAuWnE0u1rfcLNHoCXsegWH6ivOnrqRcH+ubksvBczCpe73SkFbWJW4/pJcZGxjxrScbzaCQK
	ehdv6zvFYEu6xMTjcymWDI6BqSIUE+5icUP05uPmnGRY13JEcNctJNQvkfTTFYnNY6CdRqHgFjz
	Ns9angyDPJhzjANQe7As2060ouhGl5p4dl2RX7EWsDwo8leb6CWBytQwHoPY7P2rc7/Jxj29Cz7
	crp4A+PmFMofKttnl
X-Received: by 2002:a05:6a00:18aa:b0:842:4387:34b7 with SMTP id
 d2e1a72fcca58-8434cd41f33mr4652675b3a.10.1781293298066; Fri, 12 Jun 2026
 12:41:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1780855296.git.lucien.xin@gmail.com> <e73d8f69b67fdeeec076fbe772ca465d7e1af4cb.1780855297.git.lucien.xin@gmail.com>
In-Reply-To: <e73d8f69b67fdeeec076fbe772ca465d7e1af4cb.1780855297.git.lucien.xin@gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Fri, 12 Jun 2026 15:41:26 -0400
X-Gm-Features: AVVi8CccjtCVNlXysoHMU93ce-8zqlj8T5zFjNLF2CVr-6fSHzwtKPVAgQLYHfw
Message-ID: <CADvbK_e7wpf=-C9h97b2JWUMQ6YkQLtVeTcxxCdQPaFTN+Litw@mail.gmail.com>
Subject: Re: [PATCH net-next v13 04/15] quic: provide family ops for address
 and protocol
To: network dev <netdev@vger.kernel.org>, quic@lists.linux.dev
Cc: davem@davemloft.net, kuba@kernel.org, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Metzmacher <metze@samba.org>, Moritz Buhl <mbuhl@openbsd.org>, Tyler Fanelli <tfanelli@redhat.com>, 
	Pengtao He <hepengtao@xiaomi.com>, Thomas Dreibholz <dreibh@simula.no>, linux-cifs@vger.kernel.org, 
	Steve French <smfrench@gmail.com>, Namjae Jeon <linkinjeon@kernel.org>, Tom Talpey <tom@talpey.com>, 
	kernel-tls-handshake@lists.linux.dev, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, Steve Dickson <steved@redhat.com>, Hannes Reinecke <hare@suse.de>, 
	Alexander Aring <aahringo@redhat.com>, David Howells <dhowells@redhat.com>, 
	Matthieu Baerts <matttbe@kernel.org>, John Ericson <mail@johnericson.me>, 
	Cong Wang <xiyou.wangcong@gmail.com>, "D . Wythe" <alibuda@linux.alibaba.com>, 
	Jason Baron <jbaron@akamai.com>, illiliti <illiliti@protonmail.com>, 
	Sabrina Dubroca <sd@queasysnail.net>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
	Daniel Stenberg <daniel@haxx.se>, Andy Gospodarek <andrew.gospodarek@broadcom.com>, 
	mef@scarletmail.rutgers.edu, paul@jakma.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:quic@lists.linux.dev,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:metze@samba.org,m:mbuhl@openbsd.org,m:tfanelli@redhat.com,m:hepengtao@xiaomi.com,m:dreibh@simula.no,m:linux-cifs@vger.kernel.org,m:smfrench@gmail.com,m:linkinjeon@kernel.org,m:tom@talpey.com,m:kernel-tls-handshake@lists.linux.dev,m:chuck.lever@oracle.com,m:jlayton@kernel.org,m:steved@redhat.com,m:hare@suse.de,m:aahringo@redhat.com,m:dhowells@redhat.com,m:matttbe@kernel.org,m:mail@johnericson.me,m:xiyou.wangcong@gmail.com,m:alibuda@linux.alibaba.com,m:jbaron@akamai.com,m:illiliti@protonmail.com,m:sd@queasysnail.net,m:marcelo.leitner@gmail.com,m:daniel@haxx.se,m:andrew.gospodarek@broadcom.com,m:mef@scarletmail.rutgers.edu,m:paul@jakma.org,m:xiyouwangcong@gmail.com,m:marceloleitner@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-298783-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[35];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,redhat.com,samba.org,openbsd.org,xiaomi.com,simula.no,vger.kernel.org,gmail.com,talpey.com,lists.linux.dev,oracle.com,suse.de,johnericson.me,linux.alibaba.com,akamai.com,protonmail.com,queasysnail.net,haxx.se,broadcom.com,scarletmail.rutgers.edu,jakma.org];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 58BDB67C1E9

[sashiko-claude]

> +static void quic_v4_lower_xmit(struct sock *sk, struct sk_buff *skb,
> +        struct flowi *fl)
> +{
> + struct quic_skb_cb *cb = QUIC_SKB_CB(skb);
> + u8 tos = (inet_sk(sk)->tos | cb->ecn), ttl;
> + struct flowi4 *fl4 = &fl->u.ip4;
> + struct dst_entry *dst;
> + __be16 df = 0;
> +
> + pr_debug("%s: skb: %p, len: %d, num: %llu, %pI4:%d -> %pI4:%d\n",
> + __func__, skb, skb->len, cb->number, &fl4->saddr,
> + ntohs(fl4->fl4_sport), &fl4->daddr, ntohs(fl4->fl4_dport));
Should cb->number use %lld here rather than %llu? Looking at struct
quic_skb_cb in net/quic/common.h:
    s64 number;  /* Parsed packet number, or the largest previously seen */
Since number is s64, a negative initial value (such as -1 for "largest
previously seen") would be printed as 18446744073709551615 with %llu, and
compilers with -Wformat-signedness flag the mismatch.
[ ... ]
> +static void quic_v6_lower_xmit(struct sock *sk, struct sk_buff *skb,
> +        struct flowi *fl)
> +{
> + struct quic_skb_cb *cb = QUIC_SKB_CB(skb);
> + u8 tc = (inet6_sk(sk)->tclass | cb->ecn), ttl;
> + struct flowi6 *fl6 = &fl->u.ip6;
> + struct dst_entry *dst;
> + __be32 label;
> +
> + pr_debug("%s: skb: %p, len: %d, num: %llu, %pI6c:%d -> %pI6c:%d\n",
> + __func__, skb, skb->len, cb->number, &fl6->saddr,
> + ntohs(fl6->fl6_sport), &fl6->daddr, ntohs(fl6->fl6_dport));
Same question about cb->number being printed with %llu while the field is
declared s64.

A minor one but legit, will fix it.

Thanks.

