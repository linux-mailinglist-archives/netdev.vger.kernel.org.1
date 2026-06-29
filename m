Return-Path: <netdev+bounces-302562-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id c0vODE5MQmpP4QkAu9opvQ
	(envelope-from <netdev+bounces-302562-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 12:43:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 941E36D9053
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 12:43:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=ukxM9rDj;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302562-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-302562-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A05A8302444D
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 10:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AED13B9930;
	Mon, 29 Jun 2026 10:41:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A583B9DA5
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 10:41:55 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782729717; cv=pass; b=AQzIKIz9W71KywyuZmWJ3mCQ1Ou1B2rlVnQ16r2UvLTwC4JRqIf35jke/WmGrKpIaqN4Bs5TxLeJhRYBq9Uw2rV6UE4gL5BitaLV8PXY4VEI3rXd8DVilfXCTQF5cmJCSPqrMOmQGIOPLmZ2P0bb39Z+f5FcvOhwsAF4mvTyfhk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782729717; c=relaxed/simple;
	bh=0FBiBipT16mQs9LZoOktNnUARC2YQyhlKxhZLV4a1v8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kOZfu6T+/JtLDS4etzLfPeT3U0wAi5ZIt+EaYn6enHknWVEQzdoXWVzH0NQUIXOONf6X4CQaAvSx9eJLphpA6DDLnCXYzsZTd2q4cke/IfLGRWhHwXX6aGVQbZX8o4l9qhfZItJnVoreu9xQi8HP4oIC27/vWikYQ5t2tC4jYAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ukxM9rDj; arc=pass smtp.client-ip=209.85.160.180
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-519eced8cbeso47268911cf.3
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 03:41:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782729714; cv=none;
        d=google.com; s=arc-20260327;
        b=GAuMWUHqkn+XJ3z+xa59U0KbKQ4LQ4BXw6KgWVYsqsFmSMqurqz4Cm7b4rJ0dap1mm
         PiPWzMx6/BnFZzSReJgf7SKvSw/L9jrzFkadXQTxiT4TZIMIX2gmtL9dH+tk/Kqdse6Q
         rafnCcamvkWt64OZha6+ArnW44xGoja/8+iBtns9+04tg7p7nczD03mHGX7U3YfhNZDH
         t1LWe706vi+bcamhKd2hhf7G+ncT0Tc0ghJ5wEQ83g/EEtuN43tJF/udTJC6b72PqNZx
         iu4SN9J+82BhepVHze4FtIF3BLfM4LE3zA+lAmbhFbXwBVvVIbMrgoRPgDkg+dlb8lB4
         Rzlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=D76PPNwEmwb87VvZOBqguPRuoTXM00NBuCVdKJCBGcc=;
        fh=ArRK0yy0wbZmm/QWObkBgUrsS/Lfzdf5h0Z/ToFkx9s=;
        b=jI1EZQM1bSlE7ZmChSC1bFbvndBkgg4lzZtyqLfLPS6SgmHEdJ7srZkUj6wSTtG+wi
         uLKvFGg2wLiP2BHNm2jCVpk3rNU1p9LYO92x3ZPvS+vVwFzY/zAdDUzeSQGMQ9QpJ0Ym
         cSxc1gVDd380cYXl3h4jisifEMMDleUYX2ZbenmmYo6ZLeB+fMHzH2F97z5IoUTTnDLf
         fLAy0c7I55v04O9CrFyGin+oFz3QlKqx3jHVzGJ6d0pbzmeca5GHkifkCT84vrcyZ4qI
         zM40WA+43rHGnTCPJUdyDB19JywISXyQ5jf+hxclxMcfLliZ8YYz+AVe1NPIp4HpaAGy
         6zng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782729714; x=1783334514; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D76PPNwEmwb87VvZOBqguPRuoTXM00NBuCVdKJCBGcc=;
        b=ukxM9rDjBZyp0C6AuEMLd/5d7wKDmlsN2vJzCH5GJjHvxY2e1kO4JY1VXdKxJIVddk
         HZkTPTn1I9T2VQyzPcWmi/vhG9D7LpaqFzWoOfUYt4pUK9ig3rdea2zf+A4qIWGZ/ACU
         Xr8+5V71QUU4xLZqHtJI7ZqNDTRrcDkJ/M4ls9pPiaXHm2SkWMgMp5A//h2dEkYASi1m
         QoyTYbkcNRAJZFTw62J3UFFk95I/sHh5xTde/rEXFxf2DmZkCjzkbd//ljqnQa64t7Jf
         9Z/zVOZd+Oi3SHiWNDbad1HBp27G+yAHOnhZp9hUcjGkkoH3u4BKpGz+kVmxEF2dIfiI
         t0Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782729714; x=1783334514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D76PPNwEmwb87VvZOBqguPRuoTXM00NBuCVdKJCBGcc=;
        b=VdntD1YBkM+rT16aVBgmgdrAWec+fIfEyajguk5JXzYauoRLI3WvzSYLu6mmhG+FIE
         4pkFHFeaZivqwfLd9GDh0dioh4/ZYSHxiiQJA/AJY0B+gbC74bK6zHH71EAtc1y4gQUf
         +3E/oE4SY2aox5u+vJAGulky8Mh5kK2QjbT27TCxlfTCMROwNT4AV3uAP7uxvJyZ+FdE
         2xKsHuVKjCR52EYMXkBGilJBcA4xK55Ew4MlD/jY3CYhAREy+lbl/2V7AD4R7w/Coyhc
         pXWvVck0UPgwCMW3DTUdQzw4ur0JbDb7taj+nZKePOJ59n0qkAmmzQUOSidf0urj9XNu
         V0gg==
X-Gm-Message-State: AOJu0YztBFLkLDAWH1whavWfnf0GpJeiLKsSdQ0scq88LoFyQThGIHQf
	OtiXmRsQgC9BuiDnlcrnyu+YpUjbeKtpu0b+t3BjuXrlzgPt8Jb6IOT52MN/0Xfh+jgra/txOuW
	YUA+hMulyDmJE7/QK5PqB6vjlgpWjyi4P6wdDWVmA
X-Gm-Gg: AfdE7cnKXCLwilMOt+XB3wTGwRy3hLvcyUQCkV+cjbkblbpQfyHDOKIW8Rfmpr1RyZC
	ygmMkv6ITQ9CygP3BL/jNYjKJAsNGl+9KpeL4mRrnBmkegDaSC+t+I+wxTQ0ueWr7immyF8FqL4
	LyZG0vBrCzyUX03fvG89NLtDU1HUxWpJe2h20Z5dlFVCtIYP3sDlY3lwOhaExiRY492M4fRgCXG
	/4RyiOZQ+rL6iUJny9lFswvrBD8+OK/Wqcs8FiwSYg9TNsEA4MephFNCkWac3XYFbOIMogElHxS
	U9fyoLLZXsr9Z3yP6tM4MR/qs+jhw9e2iodZaQw7+3wR6jO9P/nH1EZEWdx2CgeUTyKutgyykwC
	N+AQv5Y0=
X-Received: by 2002:ac8:5a48:0:b0:50e:a1ab:67ea with SMTP id
 d75a77b69052e-51a72a50fe8mr220513971cf.40.1782729711618; Mon, 29 Jun 2026
 03:41:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1782641525.git.roxy520tt@gmail.com> <012fba43272abc560acfc0fa37ae22182a60b457.1782641525.git.roxy520tt@gmail.com>
In-Reply-To: <012fba43272abc560acfc0fa37ae22182a60b457.1782641525.git.roxy520tt@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 29 Jun 2026 03:41:39 -0700
X-Gm-Features: AVVi8Cdr1U-4DDBMLPk89xeLYBw1AkNx0ocgVi6DJFcCYySHjqIXlfBrMNrftTU
Message-ID: <CANn89i+sq29-PbxDrCdUJk405Bs0759wXLBNhpGqE7TNTEPraQ@mail.gmail.com>
Subject: Re: [PATCH net 1/1] tcp: Require init_net CAP_NET_ADMIN for tcp_child_ehash_entries
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: netdev@vger.kernel.org, davem@davemloft.net, pabeni@redhat.com, 
	horms@kernel.org, chia-yu.chang@nokia-bell-labs.com, ij@kernel.org, 
	idosch@nvidia.com, fmancera@suse.de, bronzed_45_vested@icloud.com, 
	yuuchihsu@gmail.com, kuniyu@google.com, yuantan098@gmail.com, 
	yifanwucs@gmail.com, tomapufckgml@gmail.com, bird@lzu.edu.cn, 
	roxy520tt@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-302562-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_RECIPIENTS(0.00)[m:n05ec@lzu.edu.cn,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:pabeni@redhat.com,m:horms@kernel.org,m:chia-yu.chang@nokia-bell-labs.com,m:ij@kernel.org,m:idosch@nvidia.com,m:fmancera@suse.de,m:bronzed_45_vested@icloud.com,m:yuuchihsu@gmail.com,m:kuniyu@google.com,m:yuantan098@gmail.com,m:yifanwucs@gmail.com,m:tomapufckgml@gmail.com,m:bird@lzu.edu.cn,m:roxy520tt@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,redhat.com,kernel.org,nokia-bell-labs.com,nvidia.com,suse.de,icloud.com,gmail.com,google.com,lzu.edu.cn];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,lzu.edu.cn:email,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 941E36D9053

On Sun, Jun 28, 2026 at 4:38=E2=80=AFAM Ren Wei <n05ec@lzu.edu.cn> wrote:
>
> From: Zhiling Zou <roxy520tt@gmail.com>
>
> tcp_child_ehash_entries controls the size of the private TCP established
> hash table allocated for subsequently created child network namespaces.
> The value is consumed during child netns creation by tcp_set_hashinfo()
> and passed to inet_pernet_hashinfo_alloc(), which can allocate a large
> per-netns ehash.
>
> The sysctl is writable in each network namespace, and net sysctl
> permissions allow a task with CAP_NET_ADMIN in the namespace's owning
> user namespace to write it.  An unprivileged user can therefore create a
> user and network namespace, set tcp_child_ehash_entries to its maximum
> value, and repeatedly create nested network namespaces to force large
> kernel allocations and exhaust host memory.
>
> Require CAP_NET_ADMIN in the initial user namespace before accepting
> writes to tcp_child_ehash_entries.  This keeps the tuning knob available
> to the host administrator while preventing unprivileged user namespaces
> from using it to drive host-wide memory consumption.

I do not think this patch is desirable.
It breaks nested container use cases.
A container runtime running inside a container (with namespace-local
CAP_NET_ADMIN but not global)
would no longer be able to tune tcp_child_ehash_entries for its own
nested child namespaces.

inet_pernet_hashinfo_alloc() uses GFP_KERNEL_ACCOUNT for a reason, I
suggest you start using memcg :)

Keep in mind the sysctl could be set (by root) in init_net for some
reason, so only memcg will protect against OOM.

