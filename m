Return-Path: <netdev+bounces-300351-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id H9GRFZepM2o+EwYAu9opvQ
	(envelope-from <netdev+bounces-300351-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 10:17:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DEBAA69E623
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 10:17:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Ta7HdCzr;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300351-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300351-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 599BA3014176
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 08:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819562DB788;
	Thu, 18 Jun 2026 08:17:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361DB2C236B
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 08:17:21 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781770643; cv=pass; b=gkLepgfek0sZiqZcFBBLbCriw2t6Ukc98/BYCmz7y5GU3qtuPBjw3YCK7NQT4Xb80t3IRaUrPm5pXs8CfKkemM9jxtyFXIXW2vCvfNbq5bqAEAjGBkF3vV+1PCI6sYmO8c6G/O2IJrSFQaffQV5oMqHY9il3wQRyzB/0o/WYLgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781770643; c=relaxed/simple;
	bh=92dHqPbQWC8cy1JTOt2cJGiKdgiKwvLw58yvC9vnAdw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=EbL6oORezpeqY7DBDT0E5Roon/y7FbuBAlI2Lfh5jRDHX3p7nuB21m6BxLFY5tzAUig3ui9o2SNc3VWnlxwVmq0c+ZYJy3EQLLinsUGLmz5f7QcBMphshhar7eHfxmieL67HKrppwyJU4Sm6B3490sRef2fuHN81hcVU0ocyzK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ta7HdCzr; arc=pass smtp.client-ip=209.85.217.42
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-726840fb461so177943137.0
        for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 01:17:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781770641; cv=none;
        d=google.com; s=arc-20240605;
        b=eQR8K/JJ50IHqqQnosm9kM0nongOtVAA6T5nKgV5Ovc1pWJiEV67y6XKebox5sIIx1
         su4LB4ZMBW/4JsrLVC4GV0GVZQdTQmLFw6HvbsVBmzZi8ohQ5BpIiZTYgnMOEfbdyhz1
         friLT4lE3Ngk+s22VgKYa+vYuzPxoxNSx6I0CpT15Osw09RZXZxDRV3wHVvFCp91w22Q
         Ew/vbhbUnFU6rxQ9vqEM8dpQu286G1iN7tRWBL18FEZPgd2MNLML7taVbcyR5tdbboq4
         6xL/zJ/LumxGvGF72J8DMQJD1wIzBIJFjJSY3Z8uWF1+I9MOrNZpXuXPwtXKUxvJxpLs
         hx+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=lYAYEdq9vWBAIEZK7smUIn8a6mPDxxZ0U8DGdNWY6W0=;
        fh=/+FEwGs4q4BmeKGnwr32KkoFGr+QKcmmFp6nW7eEuuM=;
        b=fl8ej3Zy9yfmTSeGZJjkx9YDZi78m23mjFwW2uYYp2ViPrYAdYykuCdwtoTbLtpK3Z
         vy9Cyk22t1I8saA/RvpwUYMHxv2r0GeFYrx83ItYseTWIzaYjLswBrUeVr9B7WvQ3H4K
         XlV2uKzIkJkdeAHXj9IVh+29vVQufyS88wg28OHjhG+rfbpYd8AkbxNCUGmpA7+qOuWB
         W7Xx1aZj3Hfk+Qnw5BvYaSllwyOR5S20NV4dP2ccNsG3fNYN04WIrxk2268q6cnoEJt/
         H9Jpj8gTKfTsE1tsaRq1kv7kwRvUo0LLs4pQ9WpALyRiXThvrz7F172iuOzHmVPqc+ld
         tQeg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781770641; x=1782375441; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lYAYEdq9vWBAIEZK7smUIn8a6mPDxxZ0U8DGdNWY6W0=;
        b=Ta7HdCzrCAgXlxWUMq0eLpfHEzgmxdise/RxGfOmxEGqCV5ZopqkkIAGyFNKikHxQ1
         ZRfsdM5cBDXi9qpgedezR/YBqWKzfv9XWhR2GRx8sU8GuqHysCkTweTbVdCONOjIDEv5
         Rs6fC0fdxmIuAgA8MRxTEXLdf19yQ/wb69aX0mSaK37CURxVcf580uqPicspCUyu+5/8
         DVoxpZhpLJXDvnpIKocF++g+OfRGA/0AHJdwRmuDmhz8+XhGHCN/nqr9s2RhGMWiblHN
         nFLpDTNS8KtQVngm3CDFveDoosKEqjdWoBRsuYa/F3Zfx9POJxCI3JpAySIGWepVFyUh
         FFJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781770641; x=1782375441;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lYAYEdq9vWBAIEZK7smUIn8a6mPDxxZ0U8DGdNWY6W0=;
        b=LA0oE1p/EeKP93dynjOTuCw8fz8khIDufVIOFbQDmplGgGRrDN3VsfKtFopHvLfAG1
         O5lYp73cdadzleOsPYuwsi8mLl6H03OI2+Xw5HmVJGrGCgF0D3337uUMMK/wmS6yiRu2
         fSw8IQDG29P4a3qCh/JYLf37DCXw8C2NOoSMEO/9r4e7u2ecjNrN7y/fDH9fLhZ8Ecov
         dIuhiRtYrgfR/3cf39di8KqL6NwW3ecNBPSpNWJ+U8T13oD14jXPTtBlU9zVMJT5QhRO
         WQJyt8Q5w3EhElgSlHQIIA3DD1cbUS4PVQVF5mtWNdDi39Eg7J2ZXJ003wDmxmtIKMDZ
         ZHog==
X-Gm-Message-State: AOJu0YxN3OraURIJ2zm7vIYhAbWQzeB/q8DfBsJLrSX0O85nPr6uGnjR
	Xlz8745166Ca/cOrjRw4MGAeaY7XM9/t853EA45il/88jM6Lp9kMyA5/5g9frStzDJP/SMUma75
	I2tNrpTQZjZuElrlPwBRs3D8O6zD/JrEoW2ow
X-Gm-Gg: AfdE7ckedt6voB73llmgsSIPYvzIu9Qlm2eEp0sIsWZC4A8mlo4F1jKlP3Xom3ZPlNF
	wTdRNT0N+Ml8dGwG9C97h6mG2P05G3yFKi5fgJr59moXYNCq2jeo6aGHZwCO04C3NOVHj254dzv
	Dux2YN7ujpeNjVpj/iU3kwiFTCirV5h5CkBaHPs2Nv8cYamo1RpdCRjgjXrwcuBQ00oMU9i0j++
	u1lUYvJTOQtOhmZGkjrutC24BCajpUbt75GUeTOdlVBX2W1z7PPkN8L3Gs4vl8GMC2j06eAJg==
X-Received: by 2002:a05:6102:1607:b0:639:3b08:d64c with SMTP id
 ada2fe7eead31-729294dbd29mr307266137.13.1781770640948; Thu, 18 Jun 2026
 01:17:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Vimal Agrawal <avimalin@gmail.com>
Date: Thu, 18 Jun 2026 13:47:09 +0530
X-Gm-Features: AVVi8CfMP8rMxQL0XcLqLoXczWFbvQxyECbTwafIL9yz3cgDeVOm4e8A1pZk9B0
Message-ID: <CALkUMdSCpx_ywYCx_ePLdm6yioO1nQWx7sSM=AEgsq0kywHxTw@mail.gmail.com>
Subject: neigh: poor scalability of forced GC when neighbour count exceeds gc_thresh3
To: netdev@vger.kernel.org
Cc: David Ahern <dsahern@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	Vimal Agrawal <vimal.agrawal@sophos.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-300351-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:dsahern@gmail.com,m:kuba@kernel.org,m:vimal.agrawal@sophos.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[avimalin@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,sophos.com];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[avimalin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DEBAA69E623

While investigating a soft lockup observed during neighbour table
growth, I noticed that neighbour allocation latency increases
significantly once the number of entries exceeds gc_thresh3.

Test setup:
net.ipv6.neigh.default.gc_thresh1 = 16384
net.ipv6.neigh.default.gc_thresh2 = 32768
net.ipv6.neigh.default.gc_thresh3 = 32768

I created approximately 50,000 reachable neighbour entries and
measured time spent in __neigh_create(). Once the table size exceeds
gc_thresh3, neighbour creation latency increases dramatically (in my
testing, individual allocations can take >16 ms). Profiling shows that
most of the time is spent waiting on tbl->lock, typically held by
neigh_forced_gc().

The relevant path is:
static int neigh_forced_gc(struct neigh_table *tbl)
{
        ...
        write_lock_bh(&tbl->lock);
        list_for_each_entry_safe(n, tmp, &tbl->gc_list, gc_list) {
                if (refcount_read(&n->refcnt) == 1) {
                        ...
In my workload, most entries are active/reachable and have refcnt > 1,
so the GC walk scans a large portion of the neighbour table without
reclaiming entries. As a result, the lock can be held for a long
period while traversing the GC list.

Another observation is that once gc_thresh3 is exceeded, every new
neighbour allocation attempts a forced GC:
entries = atomic_inc_return(&tbl->gc_entries) - 1;

if (entries >= gc_thresh3 ||
    (entries >= READ_ONCE(tbl->gc_thresh2) &&
     time_after(now, READ_ONCE(tbl->last_flush) + 5 * HZ))) {
        if (!neigh_forced_gc(tbl) && entries >= gc_thresh3) {
                ...
Unlike the gc_thresh2 case, there is no rate limiting once the table
is already above gc_thresh3. Under sustained neighbour creation this
results in repeated full GC scans, further increasing contention on
tbl->lock.

Has this scalability issue been discussed previously, or is there a
reason why forced GC above gc_thresh3 is intentionally not
rate-limited?
I would be interested in feedback before working on a patch.


Thanks,
Vimal Agrawal

