Return-Path: <netdev+bounces-270194-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNtnDCtpvmn1OwMAu9opvQ
	(envelope-from <netdev+bounces-270194-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 10:47:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4512E47E2
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 10:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 415F63011BF9
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 09:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D521813B7A3;
	Sat, 21 Mar 2026 09:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jhPIAyrw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f68.google.com (mail-dl1-f68.google.com [74.125.82.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855C82AE68
	for <netdev@vger.kernel.org>; Sat, 21 Mar 2026 09:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774086440; cv=pass; b=n5mbsB2c4N4KaLx8A4AosJplV+7i2zk+H48ax7B8qjMKuFSiKNyRirq4Ue2a4DZBMIOBE2cMFr2ZMR/CgancAftdhVe+6I0jIKlQQb3PNUu3miCr4u0KURytk4O+xi6gEc2q8gfxXibhEweVeKlsEVmS/TQ8Odg4ULyMXTyiS14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774086440; c=relaxed/simple;
	bh=95iDC6H0AoCikkUbzaxHTuTGx0pagb+D8Ao5d8tBqdY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=caJ0ix52stXs7a+5jTjQidXEDjhyYxqAzvowIzcjbV4teRUmFWrXJJS3O/qVpxEnzTc4KQdkprt9r+HTzwwCIoo1wJ2LguARVyd6VUEMfKQwzFgQHl0M0VxNr15s1V+4zzYdrcvj6OAT+cEgxV9zYmIVyzIB4ji8duwLVp7N9vM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jhPIAyrw; arc=pass smtp.client-ip=74.125.82.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f68.google.com with SMTP id a92af1059eb24-12732165d1eso3587886c88.1
        for <netdev@vger.kernel.org>; Sat, 21 Mar 2026 02:47:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774086438; cv=none;
        d=google.com; s=arc-20240605;
        b=DobX+yvkmkj3hp+j6aJp2MJ28o2eT4kh/o3eLNCca2IclZKwWjP57UW2w9OmZZmBBq
         rv5ioEiGMQd+CWPI8bt/ZdmBO4YLUVhwJdjkcNG7tpxP1ArVBmeLt2Jv1+TO62lYr2oN
         EIoPkd85BM0GLhnsYjVnhBSkhRaKjd6YwTQYJN4+8e2Rx3O15KsLG3jQCPbePMv+FymO
         nEKQApta7k8pDvkZtNe/YP4kFlEe9RUIflFNnFbhiFKkiHdrXEztNU75nBKm5kMCy5R+
         MTlnxHxzTV+U2RVJ1+JBpGKYvR9Ulnwu8TDMVQHH68l/yg+CODz+XFt1juOWP65IBoU3
         se4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bqLylR6IlCqnKpYltnRQ4IVwuhnGMdmOKDd4E5TdtaI=;
        fh=4Pr+U9cpcfzXtHs07XcSBQqmLf9CYIIxg5x8qiM9C+Y=;
        b=ByvzKFAzv0TCrmE2C+FYven/LrvGoG3IE+GBotjKEEEbRxr/dtGqsHRjCVkW298WTf
         46Zk5P7znMjB1v7HcHZn5JzBjVc2LFRjQgmphnVg1PXFzOlELQ0t4nJVVPJjaFtUJYqr
         PAFJgrCnkwleBXByFSZNSl/pyQ8vVDFhDq5CiZN38cDqKsgGK12+vN9bhb+AqtDVirNU
         MNFI0PjCzoipKF/rJ0hEcsyTGd91Niw8xURRR4RCczcmHv4EM0wW1IDiyr7p5YIM0j3o
         r3X31F5B6yJfn4q5obms/OY0tGSh5mz4gKU0zppK4fJIeuXlWSj0bVTtue5Em1eerFlq
         2Q0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774086438; x=1774691238; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bqLylR6IlCqnKpYltnRQ4IVwuhnGMdmOKDd4E5TdtaI=;
        b=jhPIAyrwah5wOMXca4/CM0XVN7/UWcaSkxC+JEplr2KMF69Z16GaCEVdNWkGe75VZ8
         p+dAbxB5stX6TS4CqkMgSD7zbA+NsTshOFzlVnhQSzVDs8ynVzcxK7PDhBvmj+/YkRKV
         8/vlIE6DleQmKAhEbUZH35+l/Dd2qMPRgjieqvkDxRyJno6KiB0Tksu4jp8RyBBUT2Q8
         4hee9sQO+qIPlTNXMutuSGoRG0UZgZjV7k5J9oaxt+7BIviDMkjKtXx3ToSwJTI8J8az
         aBQjHLn5ZLvqXQDpSKOahUoaG5YxwuQTmeET/+GWM35zfvr+lbxyQ28wDQjlmO+V72lF
         nWwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774086438; x=1774691238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bqLylR6IlCqnKpYltnRQ4IVwuhnGMdmOKDd4E5TdtaI=;
        b=f30g8uEbdndn3lbe7kuW+aSkjAoTnduHO8LvUGYNi06WXcGIHbaD1Js9YBZhcu5Z8o
         6hQ1NqoXxPUilHBMeb0bk4/tgd7PlRK4ZV6fhqmQAboIrgyk6uYxycqDyu9GHPmH3H3D
         WLWmgphZwW5SCDlQ3iacTYGqcVLi57jvgPwnAHusQ8RLogtd+p4zU3HeYhVnCwNGb6TU
         8M6C/Wa8cnNZPxL5/J685mpHZc1RlVOdZqBEuXxB92mA4PU9M49WlI6I8Ndm+sp1dN/Y
         AcmYZ8XepjtMWhTryHjOj4fkhgr3Ac3fCDoSvGFtR+9WzaFlJbpIQ0HQXXMEu6BL8QaY
         l11A==
X-Forwarded-Encrypted: i=1; AJvYcCUNVPqjfBA0lpH1uP5c4p5lQCyvWM+Cm3i8WNDXJ9RqHLQU6IHkQcjBB8SpMiOSSRkcHtdniAc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3cs0vvsKUz9X1GewwKJGyL+mSPtx8GkOFMC8e43p6ouSOuwNz
	m0KAZZ/CZ3oGdOkgH/ReyCvO0DMJgo499Zr6gNNjH3TJhR591bOf+fRcVdZXgOtJMtHL/jE8wAO
	LYMVAXf3Up2fkYxgEqXf7QtI+Cq2Pkns=
X-Gm-Gg: ATEYQzwy4Nvx/zJfWIf5B8Y2rlbtcSSb2Y6m9Mwq2cy2AB1xJBBn5AMLkc8y3mEQm3O
	awI1AnP3kvf4BYmC2BPxwmZvORjxMyXgGc4jwbnY2nY44SQU8gq1kmSBw4jY22A+h6/OFWNu+7Y
	SB7WdJ25rIPCJFdLkyQaMx8MOzrDeifPp46HGn5kJ/Jc7i1dGOyqRgCgQyVJrSopv7f1Uw+h/xB
	YNMsnv7N+RG1MTYUQsetWEbqEjzxmaNffljhroITR/qLKzKFfFh5GMGuBvoQpFrz3jyJC+ye9c4
	jUnBZNdPtA==
X-Received: by 2002:a05:7022:e1e:b0:122:2f4:b285 with SMTP id
 a92af1059eb24-12a726a2f3cmr2407224c88.25.1774086438437; Sat, 21 Mar 2026
 02:47:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260321033027.4044119-1-v3rdant.xiang@gmail.com> <8509360a-21b8-4d28-8999-67a82796b8b6@163.com>
In-Reply-To: <8509360a-21b8-4d28-8999-67a82796b8b6@163.com>
From: xw x <v3rdant.xiang@gmail.com>
Date: Sat, 21 Mar 2026 17:47:07 +0800
X-Gm-Features: AaiRm51BJUsb9vSq5fQL5tOvWxU-g7njsfjnbWbkO5bMaTxSP2Hxj_pxSq6ofhc
Message-ID: <CAFFJMPyDpKwW9O127JkS1B3bgGGzWPpiw5MqFEbGB6Qpq0nsVQ@mail.gmail.com>
Subject: Re: [PATCH] tls: reject attaching TLS to sockets already in sockmap
To: Jiayuan Chen <mrpre@163.com>
Cc: kuba@kernel.org, jakub@cloudflare.com, sd@queasysnail.net, 
	davem@davemloft.net, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270194-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[163.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[v3rdantxiang@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8F4512E47E2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Jiayuan,

I apologize. I fixed it this way because during my exploitation, I
discovered that sk_psock_init checks for the existence of ULP in sk,
which led me to believe that disabling sk with TLS from being added to
sockmap was expected behavior, and I thought this fix might have the
least impact.

In fact, the other patch which I believe is a more fundamental
solution, is similar to CVE-2025-37756. In
`tls_strp_load_anchor_with_queue`,
`skb_shinfo(strp->anchor)->frag_list =3D first` acquires a reference to
an skb but doesn't own it. This causes a  dangling pointer when other
kernel components not specifically adapted to TLS (tcp_disconnect in
CVE-2025-37756 and bpt in that vuln) release TLS skbs.

I will try to add my test program to
tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c so that you can
test it and understand the root cause.

Thanks,
Xingwang




On Sat, Mar 21, 2026 at 5:02=E2=80=AFPM Jiayuan Chen <mrpre@163.com> wrote:
>
>
> On 3/21/26 11:30 AM, Xingwang Xiang wrote:
> > When a socket is first inserted into a sockmap with a verdict program,
> > then TLS is enabled on that socket, the TLS strparser's saved_data_read=
y
> > callback becomes sk_psock_verdict_data_ready(). This function calls
> > tcp_read_skb() which drains ALL skbs from sk_receive_queue without
> > updating tp->copied_seq when the BPF verdict is SK_PASS. This leaves
> > tcp_inq() returning stale values, causing the TLS strparser to think
> > data exists in the receive queue when it doesn't.
> >
> > The result is a WARN_ON_ONCE(!first) in tls_strp_load_anchor_with_queue=
()
> > when tcp_recv_skb() returns NULL, and Use-After-Free when
> > the strparser's frag_list points to skbs that have been unlinked and
> > are now owned by the sockmap subsystem.
> >
> > While sk_psock_init() correctly checks inet_csk_has_ulp() to prevent
> > inserting TLS sockets into sockmaps (blocking "forward order"), tls_ini=
t()
> > does not check for an existing psock, allowing "reverse order" setup.
> >
> > Fix this by adding a check in tls_init() to reject sockets that already
> > have a psock attached (i.e., are in a sockmap). This mirrors the
>
>
> Hi Xingwang,
>
> Thanks for the patch and the detailed analysis of the problem.
>
> However, TLS is designed to work together with sockmap =E2=80=94 the TLS
> send/receive paths
> (tls_sw_sendmsg, tls_sw_recvmsg) extensively use sk_psock_get() to
> cooperate with
> sockmap for verdict and redirection. Rejecting sockets that already have
> a psock
> would break this intended usage.
>
> Also, could you try running the sockmap_ktls selftest
> (tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c) after applying
> your patch?
>
> I believe it will fail, since that selftest specifically exercises TLS +
> sockmap
> combined functionality.
>
> That said, the bug you described is real and worth investigating. It
> would be very
> helpful if you could add a reproducer for your scenario as a new test
> case in
> sockmap_ktls.c. That would help us better understand the root cause and
> find a
> proper fix that addresses the issue without breaking the TLS + sockmap
> integration.
>
> Also, pls use [PATCH net v?] or [PATCH bpf v?] (if you think it is
> related to bpf/sockmap).
>
>
> Thanks,
> Jiayuan
>
>

