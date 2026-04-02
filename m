Return-Path: <netdev+bounces-274512-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iIPTNBFdzmnvnAYAu9opvQ
	(envelope-from <netdev+bounces-274512-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 14:12:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D014F388E22
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 14:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A421E3008D06
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 12:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7277E3CF032;
	Thu,  2 Apr 2026 12:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VXYUFk+C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E765437107B
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 12:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775131476; cv=pass; b=GEMZEctkuU+4qyIl7zhIdaL24WOOmZ9cEN+/S0x42Lt1mKucbv4ilT0gAZKLapTrNl1t2VRCTWoABCdUsrZPi9KTSeuetKBbAZxdNwvcM8Uoe6EWwsTqdudJHJzRer7hTek5eXVXMc4VJ9NvjqMni/08zjWm2gJ+b3px/nnfd+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775131476; c=relaxed/simple;
	bh=zKWFrITeul/qgtQWiLbC+mauwtMzdzB7O/5xgYGl/5U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gvCwLA6zmru6wTSLfbXo73Lwt266Y9cESHF5lGVApVjqFbFzIGxDHU8odtx72V+gdl3VxkuOG+hI3ZHQsUDALmsFVC6O17w3dw9kbE3kH+X69c5K6jvg8SPb//eUxBPM3pltsUeLU8GWpFK8TmQs0vyNDfESMkUbElWsxfyyYeM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VXYUFk+C; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7a2b6adbfa6so8326607b3.0
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 05:04:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775131474; cv=none;
        d=google.com; s=arc-20240605;
        b=JUHws9E9tvxI/r3rrEy9nNDFTpzfdm6eRpPusgq76ddBtp6GciRiGDiSfQwPrGhCly
         +0+U1Suegfd3XRB7Fz2ocr7/+5kgPbDJ7xzgY0cmADEkN2k7hEi9UadS/4Xhx53B3bsA
         jE2eejnVt352AzGJ/FqKk7uwSZm1lHVlMf7niH+llUOrIECV/D+3Nh+gxRhzf4s8UKA5
         vCX/CBIOv3JditsopxD8XktP7dovkei2ejneECG4thftNLqRdEypxrmaYrGuLCuEi1hZ
         BNZhNJQ7TWq9H4/PCPuLfjgPxHeH7HR82fO8RfS23bh0gvklnz2C3LDUAfS4OxX97FLB
         HkJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zKWFrITeul/qgtQWiLbC+mauwtMzdzB7O/5xgYGl/5U=;
        fh=9FypkDpXw3/dFI++C9RjPYKxuWVFQ08aiN3KB2IuUSE=;
        b=NQWXDcJ/6H9PL4eX+otXyG7yJI0Q26ZZMirhFBbPRL0W7B/2qrVZtQu/9FLhahQR2V
         AngGFubL/wWqCBGFxchQ7WrABNGPGuiuKpqBnu8S20Eb6e++VTeGvURl8adVfoNtUqrw
         mmSJp/eviO3CNLoLD7JSGPqRwEuxHRfcoyrj+0AzbpyseBspXNqUJf2OTpqNHrx/K0mz
         SuIKmG1ilSFabxtxKuWjDpEKAHymySyfZ/+lM/hvfOoQFgyFmzNZYCz10xWTU80+HJ5v
         ZyBSDnYMbZgMxo6oJOzoZ8VlRQfLWgWdnkr+OgsaGGbbyJH9he6KcIc6cTQBrJs9gU+m
         13vQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775131474; x=1775736274; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zKWFrITeul/qgtQWiLbC+mauwtMzdzB7O/5xgYGl/5U=;
        b=VXYUFk+CoDu8M8EaV3fM67tURl8pgvESG6Ln4kfzswHkFKtmFf2y9WIaLYryLL6rT6
         frQDoznSMtQy/JVUQr4Mterw+FbRoNPv0VaTkcxppimirTEbThZfjME1/DG3KBfnpsY9
         OZvshLk4OLJn589ecHkqFLSFic4YDbapAe8iMLCzhfU1qfR3y9ILZgOEEhoRXgWAmnNJ
         DCywUDKILlkXZZLGZ3Hi6t97Ye1GKZJLTkHY7ijgxcUfJToq9xwFzRsGRuaqfJfakMtq
         VNFEDW0OS9KYfWYQE/o5svSRvxh4z0S7etR2mnQkIM2h15jUtHaFJMwmt8s9MuxAMZof
         Duew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775131474; x=1775736274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zKWFrITeul/qgtQWiLbC+mauwtMzdzB7O/5xgYGl/5U=;
        b=e2oq1+u9FVNinCxsKNivaPN+1nAQTZXAqZbG1sgrhIKnkDeHDnnb1EsNmNwaUbiQWK
         Wy7LkpwQkfmhZWE1cVFEHBtEgDRoFONGoF1iwOuJMb7xkODBSs6FD2IdDMPDSXCJMxMT
         AXTqUCqZTxj7FRPuIpl9N+lQTfQNOaeqhfMuRZqkkYB8d05JVCBr21nrXummw6NofzhM
         HLwCEZ7ci4y5rUL0ViIDOlJSZKNH5NWNVzOL2gW8cocZ8bwPhGRyEhk6OU5tC0LX65/1
         ombsazESmiUVkmzors8RaDzo1pdi8/gXqfm9yBXWcLuNA0rFaNQzP6cf2ZgXnlSy/oP3
         mLyg==
X-Forwarded-Encrypted: i=1; AJvYcCWf2i7Fwp4jktgjfz4kkF4cLgMnFcp71xpnsmtLcfaRn0KGzAiAQ9oMVEKEbmmfrk5HSLWDdmw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQiXvGIKwx0BBMQ3UJy5sZWrbXoP4RpHOvwxLlLDYox1y6Nbw/
	iV9nGRjGUUfHJEo7wGof2XAPAjW2RM56ux9UvcvhxNMMKeKxJ6CKtIhd6M1bZnxihqW8qk8qwW2
	tx3yKMNEKk6/vDSstuUoNdyRLSsjcVQk=
X-Gm-Gg: AeBDiese2cmLq5g1nKP6Ki96AtgWg73rF1LjojAUdnW4u6ARD86MiwKpr/UbiY3yzwE
	4oipOsC/Fz/E6UAmtjGZdZEYwdAdBLMLwRiQFeZyYEBgu/xjnRtGC9jJyR1POvWYMtgRNlD5cC4
	TN616mPg7RqiQZmt2iLdG7rOFkLc2iPlQzqrvG12hxGzh3qc+DsykzX9UIuJT0W6oJGYNLk+DkI
	332tsJJKQ59X3O19UFTFsfK2Fyt5PLOf5Lv0Yp5OWi7+jN1MFC/GdT39mdC9wzJF8MbtmD8wJn8
	tXnhod4sdSRLbO1MfG8ovxJiuZa2CzmjT8w2
X-Received: by 2002:a05:690c:4b0f:b0:799:182:17d1 with SMTP id
 00721157ae682-7a212d172a8mr79902757b3.45.1775131474012; Thu, 02 Apr 2026
 05:04:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260330035604.133073-1-dqfext@gmail.com> <20260401081030.29b050d5@kernel.org>
 <CALW65jahWApDnVmFReW+Y3HDxBEmCwzsT1oyh03SW7X5ry6PzA@mail.gmail.com>
 <20260401175621.549c492e@kernel.org> <CALW65jaTbaosbO8ypKZ6G37HxuxXabeTaP_Fhq72xTovmDj+8g@mail.gmail.com>
 <50ae3c69-2c4e-499f-a46a-cbd207ff5f09@redhat.com> <CALW65ja1FV-OcqSazgKZhQhKf3oqr=kcGxyGkOGbhurGLOJ0-w@mail.gmail.com>
 <cb43761b-d414-4878-bf41-4ef6c988f881@redhat.com>
In-Reply-To: <cb43761b-d414-4878-bf41-4ef6c988f881@redhat.com>
From: Qingfang Deng <dqfext@gmail.com>
Date: Thu, 2 Apr 2026 20:04:23 +0800
X-Gm-Features: AQROBzBt3iwuFhkn47HugLmDXoXDBifovZc4o_ihC5WPjxUjy9gSLkKhZ_qqgHg
Message-ID: <CALW65jZszAVHNSYgo9Fav8J-Ph9dXzR34CYr1-Ar776mOy4Lbw@mail.gmail.com>
Subject: Re: [PATCH net-next v7] selftests: net: add tests for PPP
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Dianne Skoll <dianne@skoll.ca>, Shuah Khan <shuah@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Simon Horman <horms@kernel.org>, Felix Maurer <fmaurer@redhat.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-ppp@vger.kernel.org, 
	netdev@vger.kernel.org, Paul Mackerras <paulus@ozlabs.org>, Jaco Kroon <jaco@uls.co.za>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-274512-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dqfext@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: D014F388E22
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 2, 2026 at 7:17=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On 4/2/26 12:13 PM, Qingfang Deng wrote:
>
> > What distro do you run CI tests on? On Ubuntu 24.04, "rp-pppoe.so" is
> > a symlink to "pppoe.so" in apt package "ppp". Maybe an additional
> > package is required for the distro you use, or I may work around that
> > by manually creating the symlink.
>
> It's fedora 43 with ppp and pppoe installed.
>
> ppp provides pppoe.so, and AFAICS nothink provides rp-pppoe.so, and the
> pppoe-server is looking for a non existing /etc/ppp/plugins/rp-pppoe.so
> plugin.
>
> Before I mess with the nipa testbed, could you please double check that
>
> ln -n /usr/lib64/pppd/2.5.1/pppoe.so /etc/ppp/plugins/rp-pppoe.so
>
> should solve?

Hard links will also work.
Alternatively, if your rp-pppoe version is 4.0, you can use the new
option `-g` to specify the full path of the pppoe.so plugin.

Regards,
Qingfang

