Return-Path: <netdev+bounces-256493-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gHv9JG6SgmmhWQMAu9opvQ
	(envelope-from <netdev+bounces-256493-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 01:27:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 38925E002C
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 01:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9B3AB3023822
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 00:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D2519D074;
	Wed,  4 Feb 2026 00:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tXhnvoK8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1081E1534EC
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 00:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770164843; cv=pass; b=ki36zJRsh4bYot9wb3JvF+ZZ1uWz0g0oIEGclHZU2CiNfsUJp7FV6ABQ/AchRbrqtrvQm6/iXYH9I8TQb5DFYtY+j68PhB9pzM59s1Ah8ISk2K6ToG7MN/qs47nVmmqYxZXVlJLcEMayRiFRwPsLGcj9vXLKQF1YSlknVFl/944=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770164843; c=relaxed/simple;
	bh=ZD0Zr8HfZ/3IYRvUttAJ2ZqASDbLu4YqoOpx4dniN3g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jLFma89ed4L6NU5edS++doWbo+2rWwcdOI0L/bGsJEM28TSwf4vHqY+cmQbCUdVDplj6D488QwHZ9ihZYMhB0jF9bt+yiig+8i8ABsdithpJcpzM/Ayg35/BRWL/E7QvegXuH0K3vlSd6S2ppmEkIfQi/4Ut7DUu4pVKnPjSIbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tXhnvoK8; arc=pass smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-124a95e592fso950276c88.0
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 16:27:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770164841; cv=none;
        d=google.com; s=arc-20240605;
        b=JvOC4diVLOxSEq+bbr1+DTGLlEMCxs3ZFei9q3OQuQbvQnDHC92+77iCC3bvnG4iwP
         HyaCzDt1zf65/yGjCg7Ejdzwpc/O5RrlnqL+AVrXK+GIRnTxK5XVmGs8Mr4rWAFnz34z
         LvI5kasD8aVvq6QGgSyrYAEUxPcxiShNrGxvag+ldnpSN3EZAawk8kOE/iVCZwcIKC6u
         nQNQJd03oAYzogGrN3Oy8nAXWz6Wvyh1NttSf/k7Qobgnq/8hpAuPJXqhE+W3Ibrs4K+
         5xSYuJA0mbJc+uqAw+ozdPtXyuH0B727R5CaHUsjP3v0E1cVc4UWnuH4PfJwmiwG8el/
         Ifaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ClaAy39x6L9OEw7WLRZ84VmmjdnI6bOMXk4Ds5EdeUg=;
        fh=a4pdOD53XyKeiAuVaWImMju4QWiRlNJpmdZgDSXH5AA=;
        b=HiUEyYMoAk0ZgB2UO5y+8rjsaaBObCvBG314XEy2o8Bjd/ZySltBr8Um3+TyWqgGGB
         RQEn4az9mIAcINtUA0nvqaEdo69HwC9bR5hkMDqnF7FFZzCXe27NRYwh1f9YXBfcfbFE
         93PvCFQ8/qM1hbzJakoVvqKBuJDg8ui+D+BldQMBhmCK8T8rLhUHtGbVcoh7EUD2/SCy
         QhsF4fc5WOUtscUERZ9stPaP930EmC/J7uSoS0px7GbbbokF5/8g2ooJLKdx7/PDxbLs
         YQyGJwrDxAs1cKqDj4wO9tj+IGOJzO74ie8duCA2wBCJ/BLJOVbOtPFbLv1jeh7R4Z1B
         nwvA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770164841; x=1770769641; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ClaAy39x6L9OEw7WLRZ84VmmjdnI6bOMXk4Ds5EdeUg=;
        b=tXhnvoK8LioZjkFPfg5kB08XUIB7p9sGXddkMOvKN2Birt1OfTgPoVJg/ykVvqhehD
         mXkBxIwRmiYuRUW0u3RmJPuX7iP9tFVcFRAPErmfnTeNS/ilq0f0plr/fIHylN/2Yuop
         Fa3MvStr0pUZRdsApxBGXS2rvwHKZ18F8XEgwX7o9ns0Wr2pm3MNuP/D5KmcjDVuQ8kR
         cv5sT1c0VaS8Xs/Vjq4af1ic+dCScP8oopJqjUobM+I0daXi/ziETIyH63HuH74fC8AV
         FdLFJ8KGAYiZCKWfhHRg5RLvEcrClcawyIuYo/erBbcrfHCAsruF4/INAcKDXRpc5eAP
         BdGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770164841; x=1770769641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ClaAy39x6L9OEw7WLRZ84VmmjdnI6bOMXk4Ds5EdeUg=;
        b=JmGK/4Kan/IHgk16CmA4g+TtoG/dM9r4Mf3NTwiau1YOlvh4UcrjPpJQTXnnZhV7rl
         5LyxMYcleY7b9c6vnvhSzzf2MPAKqCawwt7FVL3wDSZeRlAmafXeqstpvXm/5tQ94o+Z
         Y8XlGXNSu3VI4rHzBqUH5JIfOllHZk207gFuXBp38dAt3pQopK9j8sZdZVBfXUh84EdR
         WJCZ+70fZgpppFjkD5VSRV+Qammvpl4zIhF2SCqauiRJw+kz/tYcTAMkpdkE1IP5biPe
         12knWBfL+otPL62WonNQI/juQJdXiNcicOdfZfXVdMKo0f6VljKVLnUWWQ+KGg2zQmI0
         oyCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOFugw3MBTU63w3bIlZ8s3SgS6zWfT/ItdQf1PMPZ4zESscgpnHoqBrO8ZipmV13QwrqyLne0=@vger.kernel.org
X-Gm-Message-State: AOJu0YypFdaD9jq6mpvzD9kHUZvlrAepDMXDe8KpZZf/iABQfDD6Q5r1
	f9Fx8fQJnYnvc8wY3K0OBv5/LRan0egtdlwRjwSezo+HHUXG00B/azdZwGcHxofAnuSXukFwxqK
	h9FIkMbF7IJSEs8n0tOn4tDR5aD85B33p7eubjd4o
X-Gm-Gg: AZuq6aINFfhRV3WxhB6Tz5P+7WqhwM7/WozdATkEHM8HFZavjEK7cbwIG41KresC3Q1
	QIUWGIGYHVXif2yNWH/6SjQ0JYI0HZN3stYmy+dqDvCS2iJh1OZ4477QvV5+JkVurU2kmMUqL9d
	DJpFTFTml2AlsVcG/6VkH0od9F8Qxt1Qa+1loznWIxUIzohTmM7VAN5HYBWyOJVfJKradZGRbJd
	AvGNQsRiL7cqrHovjUwGLLLrgLx+aLDTbMcSnPaUBektiW6Rq2ZPFZ8+yCn2/U6uchuu6J9ZnoB
	1C8UWQ0sTWXyjnog2T1BvriaKZbJ1Q9YuEXmu5++vb2XmP7ht1ghD5OfZA==
X-Received: by 2002:a05:7022:4383:b0:11b:ca88:c503 with SMTP id
 a92af1059eb24-126f4771ec3mr659577c88.3.1770164840746; Tue, 03 Feb 2026
 16:27:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203045110.3499713-1-edumazet@google.com>
In-Reply-To: <20260203045110.3499713-1-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 3 Feb 2026 16:27:09 -0800
X-Gm-Features: AZwV_Qg-rdTkvRtK7WBW7djnh8sDgCEWcBNiptDEhidFTQilUpUWShg6mvPjDgE
Message-ID: <CAAVpQUAJ0uTtz0OjT+p7CYa6riTk9BfDGeD06HO=dXAH_7B0wg@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: move tcp_rbtree_insert() to tcp_output.c
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-256493-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vmlinux.new:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 38925E002C
X-Rspamd-Action: no action

On Mon, Feb 2, 2026 at 8:51=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> tcp_rbtree_insert() is primarily used from tcp_output.c
> In tcp_input.c, only (slow path) tcp_collapse() uses it.
>
> Move it to tcp_output.c to allow its (auto)inlining to improve
> TCP tx fast path.
>
> $ scripts/bloat-o-meter -t vmlinux.old vmlinux.new
> add/remove: 0/0 grow/shrink: 4/1 up/down: 445/-115 (330)
> Function                                     old     new   delta
> tcp_connect                                 4277    4478    +201
> tcp_event_new_data_sent                      162     248     +86
> tcp_send_synack                              780     862     +82
> tcp_fragment                                1185    1261     +76
> tcp_collapse                                1524    1409    -115
> Total: Before=3D24896043, After=3D24896373, chg +0.00%
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

