Return-Path: <netdev+bounces-289138-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJ40OjZOC2onFgUAu9opvQ
	(envelope-from <netdev+bounces-289138-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 19:36:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF68571AFD
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 19:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB763305129D
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 17:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5CE938945C;
	Mon, 18 May 2026 17:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gCw7nHV/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E533F5BE5
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 17:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779125604; cv=pass; b=XGFlf2h+UflicLMNOhVm7TEtdCjSU5289f0RFmEyDyACT5X1rjPI/k3US8P1KTkxu3OCmEeExeeOIfHwtw9iUPdCzKOiGdP9EZs2xX8r0e8YXYNfLbdBiaTrLr/W6FuusbrjajbdFDSg5LvDGCVYVMrLsLTiIoJTYLkKPnU+Qjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779125604; c=relaxed/simple;
	bh=LsTXmbjvYgS59kR0+//k+OpD4YfD3cLwvD1nVtqBRq4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GVggijPci5SIrFdkm42Q2cyXK0mY1hx6m9dXWEkbelJ/4AnvUfbAPigDg6wFP+9j7rza0UFyKD98fMnE7BaY5jTZkWl6+GDX9JRj6n427A4zRTfpqLgEKks+M7SIV5+cj/Gj70Gf+hHSevfI8znUMbN9mlBL9ZPwclNI8RP51Zg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gCw7nHV/; arc=pass smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48a7fe4f40bso31918985e9.0
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 10:33:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779125601; cv=none;
        d=google.com; s=arc-20240605;
        b=GgmZrY56k1DOxdmZomriPDj+fP8pWjML9hIRDhG4BiTn1kPU+ULuNnWP4R6vBJVIEh
         FuuULu7M/6gkKVCRSmxYpODyyyUUb4yy4v+X5t66Z1VSoFb1xl020xhKES7RsDqoGCQb
         e4c3EBr9K/XIpsuzhedEx9cKY2MFzvJMUr56Gvjf1vfT6hnVD6QQRVwy0nFywZW015dl
         cKkf67ZsIarOMVX/pwc1wnVyPa1iBZKeqK3mRB/oo4fgiP4Mi8SRrgThsCc6Mrfks4z2
         b3JzW8ndwrc1tkfNfqyxNxd4JTBviLFu3eQX1r18tkxe94tmkK5VPwgy964TJKKG6Xwn
         ehlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=rjaJpY0MkhhIhfyKnhPGyfPqWCIkOVqOIDgQ5xJDdC4=;
        fh=T4gNbCD/VIv/Fiiztd/tU4Pw7Vown5sTyLMdQ5uVM3k=;
        b=J6xcTbIS35JgWDWIB4/CIsAMF/rjodKmx6+jrYNddn6jPU+lnbYLoK3DldfWAR991N
         30gI7IfZkHxxDAWveOX8K348AgasUNgrbItkN6I0QdaTlbN8jmFnWWqvHy0L3Ly8OTF8
         mepxB2OvrHAV/X2XqfsbtVBz+81wrKKBOUSZHKQj1HsW3EtesqdNaFutnBb1NlLmZXu2
         ktzWuAafYlGS+s673D4BbGPpwZ7iA8WpCtzK0yLq+wuH59Kt5bUz6sNLbfqANQxt71jr
         HISAnHTHhSg/D3Oy17NzKiBv+mrLePgz4w8qlfRMtRiggoOZs1QVqjhRzhU53VprBY1B
         zRLg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779125601; x=1779730401; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rjaJpY0MkhhIhfyKnhPGyfPqWCIkOVqOIDgQ5xJDdC4=;
        b=gCw7nHV/SrpLXpjrtGT7ijQ45U2K4LGaLe9T0ol6f64h4wxTHnTjvJ8nLs7ZaM5V7V
         iZN5HMy55AkwGxFkPAW5uLUNxlIIlE89MiMpli8c/Wrhe2tsBRxpTqlcU5WDMZX+k+hJ
         6UEl6u5VEnRsZ13bPy+Y8BfnxrVCK/14NS60OfwEd3W+u2m8apYOJoCMuh8QgYwCj59Q
         wsmejvVrsgbIv3NBK7Y1naWM/17s8mfvKc20HlPhYBZo8dIW4fBNhG8E8tqIQCiB7Ljr
         IL7XP9PukV2UJ74XVI4rL/IefYfjflKvwG49yl+/fhNXtIj4I6tn/fkf4fzNUExGDi/A
         xWug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779125601; x=1779730401;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rjaJpY0MkhhIhfyKnhPGyfPqWCIkOVqOIDgQ5xJDdC4=;
        b=qDwPST3mDkvaafuQs/ElvC8Lu3qqG45KXjjlP59gVv2rpalQN3CxxTSkcMyvoH6EmM
         69BOpXMacGP/Ch3/oFTT5QzBd69zvPbUUMOlwQtxGZjmhnXYaGIRW8DblgjGMQFeTgCg
         dauZKSijyCHLnHDCxzGebMPsDgzxlNM+38ukhs0+uhgZeu6HwGGkvDaYTR5gKM60d1d4
         lpaneyz3DZUOzCLb5qt7Hkhvqo0953p2pV3XU7WVOTZbpfDf/YP9FsneVVBsRl6JyeJ9
         vmsKiq4JkrrQCH6+vdqv9DX5yGCL+77co0aDPZB7hZVBY3SUfJRCDVeFyZ3FQWSidEfE
         aKVw==
X-Forwarded-Encrypted: i=1; AFNElJ9dYIC4Nhp9kZ4roy9dpMjefiVObYahKE2WUEfd9ZLSHZkvtyXBfAvyjWCxH9z9BgnWOmxpCho=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOM6Fw2IjdutNwY396Uio++47PFEao2MhUBCW0qxPfTIEaOpdt
	SkY9ho0o4QNQKnBgZbX3vRa9HyMQDJTC8Ko5Ap/KV6wZNod6LFwtP1exQkYXBL0LzW2bmxReZNr
	zJYzSZ0HNCuSNbo9tkDSYGGqR4Uu15Pgdb+LEGpk=
X-Gm-Gg: Acq92OGSn/ORJLcaMlKpoi5GXdNWIfPk8Z/WpGlobJLkVQQnA2vYlD3F0sfR7+0NeT6
	ewNpMkpEWiOYE7ul5Rh+rQ6iZLCFRdry3gholxDOd0AUP3HEIOIJwL3EQ5ZTQ4pGV1pCkEdAN6p
	0jRH3kn91PEqhFYi7kQ6czQTA7475ZjbqEoXFqHoXjA6G5K/ZgLgXPj5TqVc1P5ppoAO4+eplY7
	eFNXUaipcz88/ndDFgHay1BIAqn6L0oX5sJTohNkduE0rvHi6pBgUjmZ2RYj4ed8CrNap0/N31F
	DsYATYiVTkId4c43TR4=
X-Received: by 2002:a05:600c:138f:b0:488:ae6c:42c6 with SMTP id
 5b1f17b1804b1-48ff4f4f44dmr173342185e9.14.1779125601353; Mon, 18 May 2026
 10:33:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513143904.2497520-1-maoyi.xie@ntu.edu.sg> <20260518101531.473574-2-horms@kernel.org>
In-Reply-To: <20260518101531.473574-2-horms@kernel.org>
From: Maoyi Xie <maoyixie.tju@gmail.com>
Date: Tue, 19 May 2026 01:33:09 +0800
X-Gm-Features: AVHnY4Ih3y5-5cQ8sTAJKBUKOLhhbW1c_MNepuEQbTw6xT_7_QZ0g98ywqm9uVI
Message-ID: <CAHPEe=GkDxnVxkOfO4KRt8Z8V46xVSYisN6QrAFA-yr_V5jB0A@mail.gmail.com>
Subject: Re: [PATCH net v4] rds: filter RDS_INFO_* getsockopt by caller's netns
To: Simon Horman <horms@kernel.org>
Cc: achender@kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, praveen.kakkolangara@aumovio.com, 
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com, 
	linux-kernel@vger.kernel.org, maoyi.xie@ntu.edu.sg
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-289138-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 5AF68571AFD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Simon,

Confirmed. net/rds/bind.c writes rs_bound_addr at lines 123,
138, and 160 without taking rds_sock_lock. The race is real,
and the len=0 path you described reaches the NULL iter->pages.

v5 caps the second pass at cnt in all four handlers
(rds_sock_info, rds6_sock_info, rds_tcp_tc_info,
rds6_tcp_tc_info):

    unsigned int copied = 0;
    list_for_each_entry(rs, &rds_sock_list, rs_item) {
        if (copied >= cnt)
            break;
        if (!net_eq(sock_net(rds_rs_to_sk(rs)), net))
            continue;
        if (!ipv6_addr_v4mapped(&rs->rs_bound_addr))
            continue;
        ...
        rds_info_copy(iter, &sinfo, sizeof(sinfo));
        copied++;
    }

Sent as v5 in a separate mail.

Thanks,
Maoyi Xie

