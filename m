Return-Path: <netdev+bounces-277325-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yAVdES/Q2GngiQgAu9opvQ
	(envelope-from <netdev+bounces-277325-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 12:25:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B39CD3D5A59
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 12:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 45ABA30038F1
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 10:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187C437A4B9;
	Fri, 10 Apr 2026 10:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tMqOunTc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5C937C92E
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 10:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775816217; cv=none; b=T7IdBmufppbutg/DItPmFViKqxgLof++vogA9ZM5h+89DkLfKVtblV0pT2pWV8cFcLtnwM7d7oBq99aOF/JnGhy8RIOc85V0qMIWpxWXkFD+/3rITV+g54gLbcztb78buXCJR9laJvYhKrzYVRgw0O0cSuRioO7zSGyI8QngLHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775816217; c=relaxed/simple;
	bh=fuk6qNyCmgMZlA5RHX/rS5hn/FQZ7HEg91OJs5ukSHg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lbjzuUrgTyW1xNXsYMA+lEHfqVI1+RRBM7ni/5ngyIUMv5VUL4ltIlTcYxcZ62ANZCRGCXuhm19oappBC/ToBE7H+CvuTf5Z4FpjHa80LB8J61919/2zb00Smr94I0T0R3zdjsIhWmugYovc+iqziKwTWzKczWmEwNz6EJQVEa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tMqOunTc; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43d01d6b50cso1853402f8f.1
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 03:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775816214; x=1776421014; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DfD9YHLFclioPj5l69dZ4W8ACXiR28AggmGdPC5XxUk=;
        b=tMqOunTczOSp08m1cLoYnDx0zE3AOVTm4Rafk2LQ2PeiO36RVfxAd5x2Qvi6qKg8+o
         Eh20MM2z+tJYWjAeQuMZJeHopDe4xmTYeufPTRwqAa7pqpq/zRreMHNy9JjrbjucMuLT
         wX6V2nqAV9rxI+sIzfTXJcfiKUnrza5rPedghGn63/El0jVJCkCgKGGmPo7iETVaYZ7l
         Z8m+oRLU8/bYtulxwkkjwQJoc3e/WklwM/31x09YdVMg4XwxstIS7JNFW49DgIHwN0ok
         0o5QZqNzRo9gz5djdYmwUvQpzEH6ouT8EmuOb5VtsAHi4YZ2vxUwI7KsaRcVHqqUUQQj
         aivg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775816214; x=1776421014;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DfD9YHLFclioPj5l69dZ4W8ACXiR28AggmGdPC5XxUk=;
        b=Fq8eqABq1jdjVGQx/VpIdc1Pe5wtcoignCnr+Fe/a0EXOoVKtrzahmI76wkuV5Vpvf
         l+3vfdt4tUtCh97JIGKf6+M1+jUkruGNzya2+6Lwm3aGNysFARj5efpXZq+I6Kf2rc0O
         A82AZd8uzlXIR8/KF1KeOSAbl+Sou8d+zlnPlO3XhCCJCseG89x0gYd6G0tdrceV62NS
         YaHeQ58xn56cQglzW0BahgUxJNrjRNk2cHGSplUU+e4+XETc664Zl3aL6N/zNdAmV25C
         U39YnADUmQM+D4fXjCmHqfsCUnnHBjZAuFEuxBrwrEz1WRa4NX6zEItI11DV5q3rqyFs
         2Iug==
X-Forwarded-Encrypted: i=1; AJvYcCVH0S2kobYnuMPs1VK/wqVnRnGqm2pEybgjOe0L8iiOISswsRCPpZF2d40AE2V9V828j/VW+u8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5xDAkNGQ9Ckt9IjVVInCDOprBzkwjARus9scWKPEOaCkhZxO6
	4nHan3xI0FMthpHfl+vH09KgVX1bZ9dGfiEtzpFxemGTjX4+j5H8qMVfeO9UPRdY
X-Gm-Gg: AeBDieuY/WaUUWrQh4Pxjb2UbK7FkeUFCN070mH7yGLMq6/nrSy+Q5knVk6a5mzJHRE
	Ede3LhDAjb1rU3mzqCkOUQAlabecnuqdmd8i5OHTGh7CCp72LowwH46yBl2xSy1j2qIetwMPZ/N
	FA/Uz9FxAFsoFaBGT0pmQ+fqS/MMZEScLLSByKnZuftQUdlhYaW9fHrlZDVhsQ8pgYlSbz9rB4S
	2RUt8TXS+JYtfsTZpIb0bd3nFX8QBDvoVAWcrEhBuUReEBBUHeo4P058GZ6sYSd4LZfBM4+LwCV
	uGTkSwNiuQNIuVmdTWUNyDK61o65fDYm6jRJKECVSOvh9NXQSS7MdgYmBS6AZ9Hqz7+OWcTdrrQ
	UYPIzCBmiIc6ELIY8JprDQ7dy6w6tvowqvpupvmaquL/y35sLp5c2R6hCbZPD4VsAsS8BFKrmXT
	ngXrStte7Bf9x0Ai/6Wxk=
X-Received: by 2002:a05:6000:4284:b0:43b:9c02:50ca with SMTP id ffacd0b85a97d-43d64286bb3mr3946797f8f.4.1775816213540;
        Fri, 10 Apr 2026 03:16:53 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63deb904sm6848506f8f.9.2026.04.10.03.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 03:16:52 -0700 (PDT)
Date: Fri, 10 Apr 2026 13:16:49 +0300
From: Dan Carpenter <error27@gmail.com>
To: Jiayuan Chen <jiayuan.chen@shopee.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Subject: [bug report] xfrm: fix ip_rt_bug race in icmp_route_lookup reverse
 path
Message-ID: <adjOEUXsHTZoB43e@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277325-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[error27@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,stanley.mountain:mid]
X-Rspamd-Queue-Id: B39CD3D5A59
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello Jiayuan Chen,

Commit 81b84de32bb2 ("xfrm: fix ip_rt_bug race in icmp_route_lookup
reverse path") from Feb 6, 2026 (linux-next), leads to the following
Smatch static checker warning:

	net/ipv4/icmp.c:587 icmp_route_lookup()
	error: we previously assumed 'rt2' could be null (see line 576)

net/ipv4/icmp.c
    491 static struct rtable *icmp_route_lookup(struct net *net, struct flowi4 *fl4,
    492                                         struct sk_buff *skb_in,
    493                                         const struct iphdr *iph, __be32 saddr,
    494                                         dscp_t dscp, u32 mark, int type,
    495                                         int code, struct icmp_bxm *param)
    496 {
    497         struct net_device *route_lookup_dev;
    498         struct dst_entry *dst, *dst2;
    499         struct rtable *rt, *rt2;
    500         struct flowi4 fl4_dec;
    501         int err;
    502 
    503         memset(fl4, 0, sizeof(*fl4));
    504         fl4->daddr = (param->replyopts.opt.srr ?
    505                       param->replyopts.opt.faddr : iph->saddr);
    506         fl4->saddr = saddr;
    507         fl4->flowi4_mark = mark;
    508         fl4->flowi4_uid = sock_net_uid(net, NULL);
    509         fl4->flowi4_dscp = dscp;
    510         fl4->flowi4_proto = IPPROTO_ICMP;
    511         fl4->fl4_icmp_type = type;
    512         fl4->fl4_icmp_code = code;
    513         route_lookup_dev = icmp_get_route_lookup_dev(skb_in);
    514         fl4->flowi4_oif = l3mdev_master_ifindex(route_lookup_dev);
    515 
    516         security_skb_classify_flow(skb_in, flowi4_to_flowi_common(fl4));
    517         rt = ip_route_output_key_hash(net, fl4, skb_in);
    518         if (IS_ERR(rt))
    519                 return rt;
    520 
    521         /* No need to clone since we're just using its address. */
    522         rt2 = rt;
    523 
    524         dst = xfrm_lookup(net, &rt->dst,
    525                           flowi4_to_flowi(fl4), NULL, 0);
    526         rt = dst_rtable(dst);
    527         if (!IS_ERR(dst)) {
    528                 if (rt != rt2)
    529                         return rt;
    530                 if (inet_addr_type_dev_table(net, route_lookup_dev,
    531                                              fl4->daddr) == RTN_LOCAL)
    532                         return rt;
    533         } else if (PTR_ERR(dst) == -EPERM) {
    534                 rt = NULL;
    535         } else {
    536                 return rt;
    537         }
    538         err = xfrm_decode_session_reverse(net, skb_in, flowi4_to_flowi(&fl4_dec), AF_INET);
    539         if (err)
    540                 goto relookup_failed;
    541 
    542         if (inet_addr_type_dev_table(net, route_lookup_dev,
    543                                      fl4_dec.saddr) == RTN_LOCAL) {
    544                 rt2 = __ip_route_output_key(net, &fl4_dec);
    545                 if (IS_ERR(rt2))
    546                         err = PTR_ERR(rt2);
    547         } else {
    548                 struct flowi4 fl4_2 = {};
    549                 unsigned long orefdst;
    550 
    551                 fl4_2.daddr = fl4_dec.saddr;
    552                 rt2 = ip_route_output_key(net, &fl4_2);
    553                 if (IS_ERR(rt2)) {
    554                         err = PTR_ERR(rt2);
    555                         goto relookup_failed;
    556                 }
    557                 /* Ugh! */
    558                 orefdst = skb_dstref_steal(skb_in);
    559                 err = ip_route_input(skb_in, fl4_dec.daddr, fl4_dec.saddr,
    560                                      dscp, rt2->dst.dev) ? -EINVAL : 0;
    561 
    562                 dst_release(&rt2->dst);
    563                 rt2 = skb_rtable(skb_in);
    564                 /* steal dst entry from skb_in, don't drop refcnt */
    565                 skb_dstref_steal(skb_in);
    566                 skb_dstref_restore(skb_in, orefdst);
    567 
    568                 /*
    569                  * At this point, fl4_dec.daddr should NOT be local (we
    570                  * checked fl4_dec.saddr above). However, a race condition
    571                  * may occur if the address is added to the interface
    572                  * concurrently. In that case, ip_route_input() returns a
    573                  * LOCAL route with dst.output=ip_rt_bug, which must not
    574                  * be used for output.
    575                  */
    576                 if (!err && rt2 && rt2->rt_type == RTN_LOCAL) {
                                    ^^^
Can rt2 really be NULL here?

    577                         net_warn_ratelimited("detected local route for %pI4 during ICMP sending, src %pI4\n",
    578                                              &fl4_dec.daddr, &fl4_dec.saddr);
    579                         dst_release(&rt2->dst);
    580                         err = -EINVAL;
    581                 }
    582         }
    583 
    584         if (err)
    585                 goto relookup_failed;
    586 
--> 587         dst2 = xfrm_lookup(net, &rt2->dst, flowi4_to_flowi(&fl4_dec), NULL,
                                        ^^^^^^^^^
Because, if so, then we are screwed here.


    588                            XFRM_LOOKUP_ICMP);
    589         rt2 = dst_rtable(dst2);
    590         if (!IS_ERR(dst2)) {
    591                 dst_release(&rt->dst);
    592                 rt = rt2;
    593         } else if (PTR_ERR(dst2) == -EPERM) {
    594                 if (rt)
    595                         dst_release(&rt->dst);
    596                 return rt2;
    597         } else {
    598                 err = PTR_ERR(dst2);
    599                 goto relookup_failed;
    600         }
    601         return rt;
    602 
    603 relookup_failed:
    604         if (rt)
    605                 return rt;
    606         return ERR_PTR(err);
    607 }

This email is a free service from the Smatch-CI project [smatch.sf.net].

regards,
dan carpenter

