Return-Path: <netdev+bounces-273991-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJLoBRLgzGm0XAYAu9opvQ
	(envelope-from <netdev+bounces-273991-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 11:06:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E41D3773F8
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 11:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1A00F307E5F8
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 09:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957C33B19C5;
	Wed,  1 Apr 2026 09:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UI/3bU2u"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3817F3AEF51
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 09:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775034005; cv=pass; b=UBu8uyI9n7yjA8d2orOt5dXJowWNRjGRq9fCgbMI96c2yJdBeo/MjB1aGZc37LHkZCrdP1cpd/wP38I2aK0et0ZiJI8E2ZiXJkyPMR4UQoTDOo9nxKN7EmxxwIntcRkkqnpQQqqJxpiTgqxVie9sGWRmm2i23+FSiUO3uVKXbGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775034005; c=relaxed/simple;
	bh=Y4tlxC4t2eDmDD0AGJDkyzsfUADdkuF+z9xAWJoAvHU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f+XbnCEE620LHIYancRpHjq5PSqliodtFN6CP+uniHyEGOmSvH4UkkJtJnG/V4AhXztjuM3nE37hILO7MU5BQyO9rhI79FzmHRo1OxpcTP+uBzCBk8vePcLzBecM38QTNdiT/EIuLUqajnL+YM5XbuiJWW63GIWTM6H/iH+mHUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UI/3bU2u; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-506251815a3so55849651cf.0
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 02:00:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775034003; cv=none;
        d=google.com; s=arc-20240605;
        b=itu7kwKe7M+JFBph7z8bX19Pti6D7sMlKGBxkPg77uqHeo45L+XqBW4pArZzxcgAzP
         trMHG127uqSKdsa7R6O02nbkQICl2eZnwtLAF2+oaJdVXDzdv+3qy5M8evXlZjjwgEzz
         dDc+Tlou7fkdRXZxLmufoacOKU42Vj40yyZ+AC4hU0LzRTvSrmVfQGzFfZ1rOxBMZhN4
         tuZs0Z54soThHG4mi9E48vMIudS+DgRJfhcZUSjRUwuJPQgds5+o9D+vrV+kNCqqoXvI
         p9thbjY5wj5j48FbCXTZ6atW6Dwf60YuNhhr7t9dPlT3xbSSKDQRQge9faNoNfxTbtZL
         L4wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=t3v7jCVnjjhYRt6tVrut9zYg8uOYVxilmLAwFseeoWk=;
        fh=e/EeZSWxhm5+WUCR/U52SpY7WEms5JcwYw4dGYu7bv4=;
        b=PROYkNjcBuBgb5otcYmbCb2YmyVHqjYK1D+rept+rrgXsP358EJ9+/RJylW3A1P2UB
         fMjn4GRXY+0M2D1afFXCx7tfpQCmuO5Yy2UazKE2QcxDeODs+ogJSDryMSz69JoHqp6E
         8oW2hoLnp6h82i2yfqsyBYBSZFCiLWSVSnH3kbr/01kwrKt2TIH88x7GiITrOXtTbPaU
         c5IKEhf+mIf2vHCjs66zmV+OXLWT+ElGJQ5Su36Ytq3pqLFdDThTV30xxBXPjkDDq27R
         x16Hgmc0kXI7DuhRkNHVJS/8ssDoxuYCKNKwg2C7xhF8AjssH0mE7J7AIAvW4ib0gjcH
         8EcA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775034003; x=1775638803; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t3v7jCVnjjhYRt6tVrut9zYg8uOYVxilmLAwFseeoWk=;
        b=UI/3bU2ul04ifiq2T+T7vguFdsao6iLdWlChCeWf8brEzxcEeSB6OB3YZj4p/hw0bt
         6dYFZY2zR/t/7bRh+PtXXbW+fH2ofDok9f8PKmudd/6ozUNhoDNeX3JQOGZkuvFHje8F
         g315yX+t9VNMMYsriOdcqGR6Chekv5u+PCbc3hhQFilmHZwxUCFIKJWilFmRPZU1PyR+
         d1j5MnKw3WWkZrfhk08Vl23ni7pvztTtVhI+oBJIfBU6fHRgFtAM6T7oVqFkdSjeBYCU
         tYTFVMCgAoDQYDIIOoZkqI6CxpGFgnxVa5wW69HQTtf6R5shaQ6xR0K7+VGW2LJbY9gz
         98Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775034003; x=1775638803;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t3v7jCVnjjhYRt6tVrut9zYg8uOYVxilmLAwFseeoWk=;
        b=rq6MZDuAQ8di413Qq2pYJDUs79dpIlkIYDYEbFsoEtHo3V9i6J87j49lbFSuLSgnl5
         nZ2KrUSyuFmlYKROUc8NMi13t1h33JwtU4eZ6h+X1jDdT7XW8+7LotaSxy67brsfHu4V
         zKTA0OjLh+0Kco4iOBs7XGVEEWhhHtzSZvsYc2XJ4adaAbOjRCtpAk5T2tYvhsPTmdoo
         +76n4/LW0x6NTAmUtj0DV7gR9oWjCGVcvNr5QyL1AS+M/D1ZRxVUqALuCgscRwhXFYHr
         bgSVi3NhG1AuAa5Zs12yfJ/VbSECzfeReT8ExfTMODHVgRODMftD+4WA5GUYbBezFp3D
         FC2w==
X-Gm-Message-State: AOJu0YyhlCnTeXQZIOCtsHnSxF2h1YpEYKC3a6bjg+g7IAZDOIzS/SWf
	HN5wq8qA6py+Ub5ZUXjuWuwc8SDXGdJfDjdTLjGb1TLSstQaJsqgxo1jvBKJAJEGIofKxb/P84M
	5oudAfkncNrWkHhrBVjA8jEziSglBvsu0eqefcVTR
X-Gm-Gg: ATEYQzwN8rZ+oQ4VyykHiFpnOb/KzGmPYQh5HSqFaACCTucnvtivBTvFyPUQhVX0JWe
	cWXUKzHdu98OSr8rYb1/PgN37qb8QM5wrO65lMfSooouVi6PPC7Y+sB22eSauBkfKveoAIcP7Tk
	FbUke3zu2AU+YSe7EmP0/h3YaaXNdtRHNavKETylAadhA7e3FyArBVsCoW+qKMFdQJhNb7iCh6N
	RFomfyniXgzDWKLTg+A6tZoMk6iOM9xtb4J5ZMevEE2owHgNvK9BGRLV7mWWdgenTjKhNVV9+nX
	S3C9Sw==
X-Received: by 2002:a05:622a:98d:b0:509:4d26:25df with SMTP id
 d75a77b69052e-50d3bd95a43mr36004121cf.66.1775034002527; Wed, 01 Apr 2026
 02:00:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401081741.4273-1-fmancera@suse.de> <20260401081741.4273-2-fmancera@suse.de>
In-Reply-To: <20260401081741.4273-2-fmancera@suse.de>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 1 Apr 2026 01:59:50 -0700
X-Gm-Features: AQROBzBNZygE-aubWzKJuOgJ4HWpFUEF3TO_WU8EPml_mkG4KlGSxtgqy3tLjOk
Message-ID: <CANn89iJUfVerrEbqkXt-ddSaMM-6ewiFN=awxXGEj4M+6onKRw@mail.gmail.com>
Subject: Re: [PATCH 2/2 net v2] ipv4: nexthop: allocate skb dynamically in rtm_get_nexthop()
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, idosch@nvidia.com, petrm@nvidia.com, 
	horms@kernel.org, pabeni@redhat.com, kuba@kernel.org, davem@davemloft.net, 
	dsahern@kernel.org, kees@kernel.org, Yiming Qian <yimingqian591@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,nvidia.com,kernel.org,redhat.com,davemloft.net,gmail.com];
	TAGGED_FROM(0.00)[bounces-273991-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6E41D3773F8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 1, 2026 at 1:17=E2=80=AFAM Fernando Fernandez Mancera
<fmancera@suse.de> wrote:
>
> When querying a nexthop object via RTM_GETNEXTHOP, the kernel currently
> allocates a fixed-size skb using NLMSG_GOODSIZE. While sufficient for
> single nexthops and small Equal-Cost Multi-Path groups, this fixed
> allocation fails for large nexthop groups like 512 nexthops.
>
> This results in the following warning splat:
>
>  WARNING: net/ipv4/nexthop.c:3395 at rtm_get_nexthop+0x176/0x1c0, CPU#20:=
 rep/4608
>  [...]
>  RIP: 0010:rtm_get_nexthop (net/ipv4/nexthop.c:3395)
>  [...]
>  Call Trace:
>   <TASK>
>   rtnetlink_rcv_msg (net/core/rtnetlink.c:6989)
>   netlink_rcv_skb (net/netlink/af_netlink.c:2550)
>   netlink_unicast (net/netlink/af_netlink.c:1319 net/netlink/af_netlink.c=
:1344)
>   netlink_sendmsg (net/netlink/af_netlink.c:1894)
>   ____sys_sendmsg (net/socket.c:721 net/socket.c:736 net/socket.c:2585)
>   ___sys_sendmsg (net/socket.c:2641)
>   __sys_sendmsg (net/socket.c:2671)
>   do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64=
.c:94)
>   entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
>   </TASK>
>
> Fix this by allocating the size dynamically using nh_nlmsg_size() and
> using nlmsg_new(), this is consistent with nexthop_notify() behavior. In
> addition, adjust nh_nlmsg_size_grp() so it calculates the size needed
> based on flags passed.
>
> This cannot be reproduced via iproute2 as the group size is currently
> limited and the command fails as follows:
>
> addattr_l ERROR: message exceeded bound of 1048
>
> Fixes: 430a049190de ("nexthop: Add support for nexthop groups")
> Reported-by: Yiming Qian <yimingqian591@gmail.com>
> Closes: https://lore.kernel.org/netdev/CAL_bE8Li2h4KO+AQFXW4S6Yb_u5X4oSKn=
kywW+LPFjuErhqELA@mail.gmail.com/
> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks !

