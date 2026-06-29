Return-Path: <netdev+bounces-302568-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UIlwOHFRQmra4gkAu9opvQ
	(envelope-from <netdev+bounces-302568-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 13:05:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 37BAF6D92AD
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 13:05:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Z5tO1hUW;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302568-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302568-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 242EE300D45E
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 11:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D57136827E;
	Mon, 29 Jun 2026 11:01:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2C23655E0
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 11:01:11 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782730872; cv=pass; b=keBDM+2Z3nTv5cr4sB9DSX9ajyXlhFnZWWJIK0XqT/H0ilZExpOSbOE3kfR9YZ2jHhATz1/K1rs23pID4pXDiC87+sGJ2mBaHNHQ+VI2H7ZuaPITPvPVxo9O2UwkkhhUDMi0bGvyZBfaw7ya2Ll+JZXQuyAs8O3vmNXzs4rFXvI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782730872; c=relaxed/simple;
	bh=mnjAikTk0vv4dO5nL8VUxxfpJVPjQ++bk5iE6002ruc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VGzx0wRUOdGjjAyLVASLIkIJCMgwhD/9EhSzOJKBOCspFBdDCcue6LoJCoaQ7ipaB4phbPPE3T+PwpUdiNy+h4nU8pcpiFLboK+Geob8Glm59wcloPWjkaIR2ImrSb1Rtkfyf5etFkiJ2hPp5FwcWEsbFaDxv8uYgiPcjUEUKdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z5tO1hUW; arc=pass smtp.client-ip=74.125.224.48
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-664d7863920so739164d50.0
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 04:01:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782730870; cv=none;
        d=google.com; s=arc-20260327;
        b=Ic0C9iUZJ+FZ/sGLQnZd+kwQLJrx99Il2ZDzYeAVPlzY/54QV0OWrhvrDwlzuiqDNT
         H7kDmG0+MVPQ3LjR1tVvMrQgnWva8VprT19GjGUbgoRUMTyj8af+oOF/gOEDzHwpjo2C
         pB5NcKMWMAcC/Nl4uVPFPRPeRJTekLqWAym+Sf7QveQE8M4N7CJfV4yx69OfRzlqRNga
         t0fxQs+HqH2PVvgB+ZKDlp7KvPtCckQqMmh2rfnFIQw47yvUzqwnpmRpfRPqBcOadvRA
         S1jGVXwyprquE7FXNn93EpEsjJcxSCDc1OrWdBFvG4VcgKrRzyJRThsQYmAIh08oqm0/
         nH4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wrWH5ScwQ0Ic395xhzkFoF+xIvoGXKTlXaVtM87Ug6o=;
        fh=JqBcJ8zlqqW1ID4d6Er66hGY90ThDNEIT+r5EDaRhgI=;
        b=adjEgN0B2Bqk5dH+B9kkDW/qijcN8XPKfz9/GwBx+i1TdWZS5Gj2a16LS4RRp1dST0
         d1/gTwXv8NyWnqPYHsq67lqsbd0lwjKodWKBv4Uj9Pof+wjY7oqx5Lt+1HSXprCSSsAJ
         ISXXXrnI3/1KfwAvGPLs4jn0j0Z4Nja1VhHGnbqbgyZ5au9XbnTHdYlEx5rSW2wTvooX
         Tr7VavQ9PibL/pM8v1eVa97G18wMcnH8CZlKKPUUvQgdh6wbs4ihgQMkBIfovXXl9nWY
         9OOZfMCVrkDzjl3yhK3ty5hbv9W0bL+aX0TaOPhvdatKV5OtGNO8ijObr+Ccy/SA5dhx
         UpXA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782730870; x=1783335670; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wrWH5ScwQ0Ic395xhzkFoF+xIvoGXKTlXaVtM87Ug6o=;
        b=Z5tO1hUWYCd5yLRhwLBU8xVkmwwS/ECEqx//OfDV6x7lHePbCnmyKsswkTStcyU/iy
         up7A7L8/atR/Ck4EQPMaRUMmvbjYScot17wow4INztB/aRlI+cURWXlvusj7X4huBMn4
         Qv5KSFhV5kQVv1TVxMv6/52cCJ5n9f0qVpTs1GUec9LOr0dI5Ck9cZlH3DeEdY/s5RYd
         K3QzsshkiVYpac/N655sm5V0tWI9w0cW8AynwHm54VZde9WijF3ZtuefqYqOqISwRRHC
         Do3n79JdXVGbF284QyexI7YajMwhhdv49VBVtDUrv1LOhw/t+/pXgmEL4nuTlYXCLbOf
         k3ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782730870; x=1783335670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wrWH5ScwQ0Ic395xhzkFoF+xIvoGXKTlXaVtM87Ug6o=;
        b=qamDAzbp8L+S+4Y+2FkV0Dza3kmGtJmbnZHtRCzac4P2DxRn1uqHp/WZCuy3NAsLNH
         TIxIKBp1rOKdAgRIp/CNVSC4y3GYQ/BYYSTZja238QQ+VkjWDnrKkPGR81Juo6vcAVzc
         2qre/10rU43RT7Og1yJpsqP22Opj3NQ9pg0CyLK0wjVE+cCkE/AcWoiOHktCtlK5YoIA
         m5Ig1SArA/Debm0Qy5oSPKWyWISHHjXPcrXUDEizqNJmFaIbu73pYZnY2GG7z8hYdOCp
         DVr7d/zPC/CJsuCDYBUH27q3v/aotr5PLsqz0ZhGjyf1B2IP7maZiDB+bHx0vSSDCETQ
         cXoA==
X-Forwarded-Encrypted: i=1; AHgh+RoFKhe1kUiqb/s1hmmzXkGk5Y+/Bp0Lzgor1a2CAOwNoCBXMOEvnffDdK/0WOL78vYyP67yu+o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKY7d95wyh5Ti5cMAFw8q83plCHJfLDwn4pZlLmratmnRRTWPN
	C0ZkvN8s4+zOu41UT6ZY5Jyp85HU+y36wU81wZCFFlpozecSR1/BY9PZXoaXJLy7b9OakIJGkAs
	W/pCtFiVvsq9B3eRam/Owgoj5UFeLqLcOkh3bJYc=
X-Gm-Gg: AfdE7ckzNXY4LMlOhQmpKD7NrGfpbvZsiRjgkgFQuyMOCjmZz8E+mavIRDrceVr6Ynj
	ZTRQddXWnKfvLYzMsbM5S4ranobnEtZp/yM/FgY63lFWpQk9RL+cfbJ1H/xcpE7NvgrE+PsOGSp
	TwAZgJ8lc5J8yIfFH4bkcvpE3E1LMxL4KyFEFwipUA/EzfUVGUM0qeP0qd8W1/CVwt4+M3FcTWy
	g2xHvshsYiGNmA1fAwsCHRhFfim6y2LqX2wAHCnIs29D8RDBmeiXivEI67WE3iYDAEbWn08jCJb
	oVHaDvf1gKoBX6nrmYeAy9W2Eg==
X-Received: by 2002:a05:690e:13c9:b0:664:c1a2:36ed with SMTP id
 956f58d0204a3-664c1a23e05mr6439084d50.63.1782730870031; Mon, 29 Jun 2026
 04:01:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260617215725.1116295-1-michael.bommarito@gmail.com> <3ad5bba8-18b9-48a6-94e0-99d958f23984@redhat.com>
In-Reply-To: <3ad5bba8-18b9-48a6-94e0-99d958f23984@redhat.com>
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Mon, 29 Jun 2026 07:00:56 -0400
X-Gm-Features: AVVi8CebS_wHEonSTuO6wt_iy1ve7dsxgWilTCtlVWkEeNvzRN3DOJlfDOphaVo
Message-ID: <CAJJ9bXw4Xz=Y8Jt1KxSTA-0EOfKU829zGF7nJcfwWPQjh4ZGyg@mail.gmail.com>
Subject: Re: [PATCH] mptcp: only honor zero-length DATA_FIN when a mapping is present
To: Paolo Abeni <pabeni@redhat.com>
Cc: Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, mptcp@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-302568-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pabeni@redhat.com,m:matttbe@kernel.org,m:martineau@kernel.org,m:geliang@kernel.org,m:edumazet@google.com,m:kuba@kernel.org,m:mptcp@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[michaelbommarito@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 37BAF6D92AD

On Mon, Jun 29, 2026 at 5:50=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
> Isn't this fixed by commit 5e939544f9d2 ("mptcp: fix uninit-value in
> mptcp_established_options") ?

I did the reproduction ~10 days ago on linus's latest, so definitely
still reproducing.  I think 5e939544f9d2 was on the TX side and this
is about the RX option path, so they don't overlap on flows either.

Thanks,
Mike

