Return-Path: <netdev+bounces-303906-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id A3JqAraxRWorEAsAu9opvQ
	(envelope-from <netdev+bounces-303906-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 02:32:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B646F2A20
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 02:32:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=multikernel-io.20251104.gappssmtp.com header.s=20251104 header.b=h1OAPnv5;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303906-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-303906-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CF9DD301FFF1
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 00:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC56A1DED42;
	Thu,  2 Jul 2026 00:32:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0472431E53
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 00:32:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782952371; cv=none; b=los3xUunwhGKb9ozMqFycnqmntro2pHS/Jrdo9LPB8Np6r5EfIMGAAI/OAAQUwkZqjRnQyuYTKb6n92bN7l5mL19/lE+ubMANs4+YCk14I6TJ/FgJHaO6J8UnBb6/bPlbuHk4/NVgH8IzQvbE0wzKTBm+M/ltnmoqa96KKVkq6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782952371; c=relaxed/simple;
	bh=ZBTgJRyElLAV59IGOck7+OH6JWbiBqiaTdW/BhDr0d4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bCf4QfF2mDtfmP4MaGpQPjSU1G5LBhytMMRBhG4DcnpD9nq+5FNXBZKDc+Om/VYyBhdkJoeI18ZGJONfgOVq6lrv+/LjsaC3JE57gql3G5zLeEoiTBfeKJ7UdSGgyQ9CQeRkm+clF1Fy/aRWmd6BLsSvKAPFNNAxsF49HOpoKnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=multikernel.io; spf=pass smtp.mailfrom=multikernel.io; dkim=pass (2048-bit key) header.d=multikernel-io.20251104.gappssmtp.com header.i=@multikernel-io.20251104.gappssmtp.com header.b=h1OAPnv5; arc=none smtp.client-ip=209.85.210.178
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8478cc93299so851223b3a.2
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 17:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=multikernel-io.20251104.gappssmtp.com; s=20251104; t=1782952370; x=1783557170; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=plRvvCAVCrtrhVtrKnejJX+wc0oLNwNwI+sUKQl+JQk=;
        b=h1OAPnv5+SVOwqZlquwgXVQDeshQDv2zfkJxmERm9agFMyXgzj79QUTvKrZ9w1EMNx
         KtDMNnIPquaagubDieUYiihQ79BHJNoPIrCZf89Su1ILznulLJX9rArCILHrK0wwZurh
         j7BHs+YaNRFHrcMPMD8sGyC8xae0xMZzHozDUzfJnfs0b2f818lmV4z59x+dzWHAqXpV
         ZcgJTWrP5LDqfbVxZqNm0qT9u02J10AhCZowFCk3Reqd7IstZhaDdFPXghTQQVgtj792
         vFVcLjkWL/izemgZV2tGEkNn2qMV2XsTCEXHxzlDowYLeTHYgQl06vXmysvzw+UUiSxU
         aaHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782952370; x=1783557170;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=plRvvCAVCrtrhVtrKnejJX+wc0oLNwNwI+sUKQl+JQk=;
        b=aOugeCcjmtIrm2PCUUjMcHSuM9CWG85rVTuH5aYTGNSAQjGhWGE27T7uR8c++Avj1z
         4zJs+TBuKm0lOw3jg5Oqoarxvrl5d1nfTdBMH5OQTtvNokwKPKiwo80sIgISe44q6qNB
         s4D6f8vri3HJuIPBIQmIDELHLzhZrfVPeGsOLRD6Ijag32VVURbP4LlxgYtTWzlXLFpG
         nNRtcRFKd5UFigo5XwF8y7mISk0FEl2G/MNY89KZn43Xh/7HOsxkFWudaCT1/sGRY+bi
         EulHrWlscmgQZ125WRQfYKnpiSH4qDhjRLCPcgyscDIWX4UzwADX7UgmA1rzX49w2uEY
         gfgg==
X-Forwarded-Encrypted: i=1; AFNElJ80r92aDsOuSOMr0B2oXOe9slxOQ4HsPMw8In7NA8ilzP9bVE0v3ZyUVnly1PO3G3gN0NDFaCo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZOEftdN3Mw1My8Jx2VLduVy88knObCP5asVEhLN7cx4wKu8Qe
	pQruXCauwnbBnd1zWnNW80NhuiejeYDeU4glt6SpqtRYlTaASHDDWNjtcVLnuYoCYik=
X-Gm-Gg: AfdE7cnTGOtHNM3MaGAaYKvtTmel4gXKyKRSKu2/BDHl/yvOQ9M4EL0/gWmmza7PObe
	DFuI+/wlme39yG/CkEsCULaxIKhlPO+nqCi77STKKjcH6s07+vn1F/KvDBXPnHnwX9xTp6k2HD7
	F3Qx2QvVcK7hhvfPFWMonWse5BQutn+qt0Wj+BNRt4Q9zuA0uqRN/o7D6G17JuDvR/RrVTrh6Nj
	LrS29045aRxr+aFtWgF/rY14RYQL/zJgSwn5qS4NgzEuP1Q6atPKPqX1iw9se8TLwxfPP8IEDq4
	s5Ga+Cl0rIS9TZGhvdjLpq0qS5izKklkmmG/nBn6RtJFN8TVw/LCrErDfY+nxzYcU1x/QnX3ytc
	wuVM3yJW7xHvtQ4KK/K897iGBZx5kxrqdAzDbdmm8l4lobz6CcTw+N9dGYLT9vZPaGjfK5GEHcl
	mst+kXKO1dlSiXCsqRVTamJJhyeddPVTMW1AA4pS4dyjg=
X-Received: by 2002:a05:6a21:50c:b0:3bf:d1f9:b1df with SMTP id adf61e73a8af0-3bfed4c4cfbmr4014145637.54.1782952369783;
        Wed, 01 Jul 2026 17:32:49 -0700 (PDT)
Received: from localhost ([129.210.115.107])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0bbdc4eesm2793830eec.24.2026.07.01.17.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 17:32:48 -0700 (PDT)
Date: Wed, 1 Jul 2026 17:32:46 -0700
From: Cong Wang <cwang@multikernel.io>
To: John Ericson <mail@johnericson.me>
Cc: Li Chen <me@linux.beauty>, Andy Lutomirski <luto@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, network dev <netdev@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC] connectat()/bindat() or an alternative design
Message-ID: <akWxrjOl4Up02Bvq@pop-os.localdomain>
References: <b1af80fc-a57c-408d-bdfe-fa6bae26eaca@app.fastmail.com>
 <aicbyQIC2qEveNd-@pop-os.localdomain>
 <455281ec-3ee1-4f27-989b-c239f0690d8b@app.fastmail.com>
 <aixU_RccxS_BKhgX@pop-os.localdomain>
 <66eb8227-85b6-4684-a4fa-e3e17ac2fa45@app.fastmail.com>
 <e396ce86-ec84-4189-9da2-98af7cfa6c41@app.fastmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e396ce86-ec84-4189-9da2-98af7cfa6c41@app.fastmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[multikernel-io.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303906-lists,netdev=lfdr.de];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mail@johnericson.me,m:me@linux.beauty,m:luto@kernel.org,m:brauner@kernel.org,m:axboe@kernel.dk,m:netdev@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[multikernel-io.20251104.gappssmtp.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[multikernel.io];
	FORGED_SENDER(0.00)[cwang@multikernel.io,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cwang@multikernel.io,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,multikernel-io.20251104.gappssmtp.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 60B646F2A20

On Tue, Jun 30, 2026 at 04:22:25PM -0400, John Ericson wrote:
> I'm bumping this and adding new recipients again in light of the
> discussion happening elsewhere in
> <https://lore.kernel.org/all/a49ce818-f38d-41b0-bbf7-80b8aad998b1@app.fastmail.com/>.
> I don't want to count my chickens before they are hatched, but it is
> looking to me like a consensus in that thread is building around the
> ability to opt into intentionally empty/unusable root and working
> directories (at least with nullfs, maybe but less likely with other
> mechanisms instead).
> 
> That new functionality concretizes the motivation for what I am
> proposing in this thread: in such a world, there is little to no point
> binding listening sockets in the file system, because the containing
> directory would have to be conveyed by file descriptor anyways --- might
> as well just directly convey the socket to connect to by file
> descriptor. Likewise, abstract sockets are not appealing, because the
> abstract socket namespace is either too coarse-grained (leaking info in
> the same way root/cwd would), or too cumbersome to keep it from leaking.
> 
> To recap (with some slight changes, like renames), my latest proposal (a
> new version, not either of the two variations in the original email) is
> new syscalls `bind_unix_anon` and `connectat`, supporting a workflow
> like this:
> 
>     /* server */
>     int lfd = socket(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0);
>     int addrfd = bind_unix_anon(
>             lfd,
>             /*flags, for the future*/0);
>     listen(lfd, 64);
> 
>     /* client, handed `addrfd` */
>     int cfd = socket(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0);
>     connectat(addrfd, cfd, AT_EMPTY_PATH);
> 
> Or, more radically, `bind_unix_anon` and `connectat` could let one skip
> the initial `socket` calls by returning those new sockets directly:

Hm? Why not just setsockopt()? Something like:

struct unix_lookup_ctx {
    int dirfd;
    __u64 resolve_flags;   /* RESOLVE_BENEATH, RESOLVE_NO_SYMLINKS, etc. */
    __u64 op_flags;        /* maybe future */
};

setsockopt(fd, SOL_UNIX, UNIX_NEXT_LOOKUP,
           &ctx, sizeof(ctx));

bind(fd, (struct sockaddr *)&addr, addrlen);
/* or connect(fd, ...) */


Zero new syscall is needed.

Regards,
Cong

