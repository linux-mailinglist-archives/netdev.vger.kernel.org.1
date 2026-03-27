Return-Path: <netdev+bounces-272365-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +FU3B8L+xWktFAUAu9opvQ
	(envelope-from <netdev+bounces-272365-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 04:51:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF8D33EECB
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 04:51:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2EE593034DCF
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 03:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC65371CE7;
	Fri, 27 Mar 2026 03:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uzmu8Yux"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2841E3DED
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 03:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774583487; cv=pass; b=ri4NA+Ic56bGYX3p5NO/b+wFRUjdXABrBUYJJ3WAUPjzFCZw2qCAirX4qCshfL2XPT+s5xF9LfT8ARRKeZdwXobTwYk6oyjczIZA77KXMgZB5UfBrXGUtP2dwl5wihhtVslIh2Ec566chivlMwSmEPYQ0shwMNGzsQVZuL9FPos=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774583487; c=relaxed/simple;
	bh=2u5sdPl9Al1Mg+WPikE1jSivBnkO8E00gOIBYILnTEw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E6W6koqN9iotD78GJ61LKyIvQqCmlVAN0tddzl8xhV4gzYfJlBokjuZzMI7lQAVeBykBtOK1UfrZdhJ+MsZVUxAV0So472l2NJvkckhiJnamugdPhnblNhrWNIZAyxPXWub9vZDqf0d7xNFgqn9v0YAFamLQF321FeF2KFsE4/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uzmu8Yux; arc=pass smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-89a0ecbc713so19629516d6.1
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 20:51:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774583485; cv=none;
        d=google.com; s=arc-20240605;
        b=U0Cn7koVu5PBBJBafcepGESBj0aJ6C3sGCyQaiEtzHWkdtUZL+0SQA1MKTaC8P3Sl5
         YO5X2pvPmiDFRuO0FqIV27X5w8qKjEYEsvACtnoOMbqtmkGvIldBPaWmVop5Tpd4pMde
         81mR26NbRB8USY86Kg0HJjsqVar4DYXONSWiLheyqA0WSs1EfymL7/4EGgg+o39fOUyG
         462QmxGX4wTJoFxezA+CItHztX/fKdhhMNQDbBiAj5yDgm9cV5wti83MPH0Z5sUqkjH3
         dLEy1ASP0Pahk4VViYFD3qSGWLL6VXeFP2QAkbFvS+KM3zTemG3M6xYr8KI7VHePd+5x
         ptGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NdhzAgqBama4+V2AmtAH4a2aewu57kBSWgC5MYBNZb4=;
        fh=73w22oeC6O8mC8KQwxZF1JqQXVdIyvDd9N2zaCMZtnY=;
        b=Lu9b4vMhBtkzWkqoq4FtDVreaIVafVz5ujaQe8LNCWDIcsFobo9ecKvYjr7+foSPC8
         rIkikxXHNMBxfCCCrDT4wqBiS1Z88eVYDY2NvC/UspQebzjbJ0h7o7pBV74TKjPf9rLZ
         qqEVUgYZAG3V3EK2PE9K1n7AVEZ8VDBEON1XBSMw7Y5AV6vIQBYdWUYEBQBmkJNKfBaf
         umD6lIkslSBUdriVMe9sAcCEF8LXhgaXtC81CoVeHIcHT7qx93kNiyVd9hNfTDYDnumK
         ZIRCFiq7OYERDvPYvfo3nVun9LUKmc37XgZ/+FUuUOm1r6EvRq72DwvFfFXGfr3l1HPf
         xlsw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774583485; x=1775188285; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NdhzAgqBama4+V2AmtAH4a2aewu57kBSWgC5MYBNZb4=;
        b=uzmu8Yux1gWK7FuKFa5ux82LtQZwpajl0x3Wc3/D8XqiSnUnD52VBur5fADzROILoO
         lgFo1quNP+eTMGgm9NgfHnnniCSBy5rGfKKeOmf2PJjBHROmDXFzc6gXHXlhRGJhGaEO
         yvlYm/fCQuMDcYcdxiZxKJDE9gevHk7n7C87gLVNlbpCmETb55vIZ/XtdBW+zJal69l9
         ZbsiZ/tpBIVGqygrIV9xeyxbsWUPulxbezzOV/W/Jifx5K7MtsqrswfGLRwHFFtAEKmu
         f48VcwYKtstpItl5oevipK7aDaXFHYCge9p3ac/TL9fqPqQARE2rcZP8fa0FLuAq7SQX
         xFPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774583485; x=1775188285;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NdhzAgqBama4+V2AmtAH4a2aewu57kBSWgC5MYBNZb4=;
        b=PKH0dNXlB4XnApnf9/t387xJYS2Z13pqxZDqUb8by80DEYL86ZI3bkZ0efZvZj0QRn
         itY2smRu/hT3+/VuRBxvpvMR0CfOicuNLWgqnHkB3uJDMpZNnXvwp4XGLSkjlSp8u84A
         J6GgSz4ApY1XO/IIo9iDpWWoHlYWBZfjgxKMUEo6t2yed8Zk7lKy5uBHpsv3LLBMheHC
         LqfxRxn0jtV0VZUkYhPWrY4WGNwNOvWK6FVmG58Rai45ZO3Tx7Ax/HfDCKXuX/cU7pHQ
         O+g73zYtoeNg6eZrRetxZWkUqXykQnkbaJh1PF0/LSjHNx9+qLJ0+SwitxrJzjVBFkj+
         wTOw==
X-Forwarded-Encrypted: i=1; AJvYcCXE9RvLjJawn2AIivTLB1I3BdYGdDmayiGcOZqMDxlQWGW0RarRaxC7hkAXrs9vOkYvxRJRvpg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxme5+pVFTKRUo6WX5AWYu5iQfwjS0K+DdO2gxYY4mNAa/8hEu/
	Uevh8cEfquFLrdoq3rUgby/NJgnRyeiL9jPweUB+QD/90ZwAOwJd5Nv9Tw8PgSJVzQ8gdB+ITpt
	PKkPJtDwqG5maZYoRrlslxjLss0eRmwX+EuDVeQuH
X-Gm-Gg: ATEYQzxsZNCH4CrpQiHneFPF9DbA68YFETKwECN1uIhPi9JlrFOB5FFJsKJHt1/7fMJ
	o4RrRtBUShG3rocI9h5tdhHzIJc/XcOvcwkusX9waB0aLCr/X7B9Tj0cXlk04kZqoroJHJiaAoT
	BN5JalGj7xThE0vvuPoaCSs4OOOnC4Zo3b2yG8rzTr0suKiGtZNK3qjybBlU0ath5lct6Pq2cTh
	Va6KFGkypTulS/Rxo46F39TX6PQEF6eBznd/R/5c3n+t7xu7SKlIahoms4ehn6jnoZX2RQxNZ51
	EUU0Og==
X-Received: by 2002:a05:6214:5081:b0:89c:bd10:a7ba with SMTP id
 6a1803df08f44-89ce8fdf12dmr12571796d6.6.1774583484596; Thu, 26 Mar 2026
 20:51:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324073750.1500328-1-edumazet@google.com> <ac86fb62-d036-47af-b8ed-9d1f4ba2a835@yeah.net>
In-Reply-To: <ac86fb62-d036-47af-b8ed-9d1f4ba2a835@yeah.net>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 26 Mar 2026 20:51:13 -0700
X-Gm-Features: AQROBzDNGqYVX9qBRWygpDhgkz9sT7mNYstbD6tKGpT4em0DKl5rMG4t1tQlVnI
Message-ID: <CANn89iL1cex3LK824Wke0URGqRv+fD16vUdM0y=dvdPgPqgdhA@mail.gmail.com>
Subject: Re: [PATCH net-next] net/dst: improve dst_ops refcounting with
 per-dst bit
To: xietangxin <xietangxin@yeah.net>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272365-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[yeah.net];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]
X-Rspamd-Queue-Id: 8BF8D33EECB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 24, 2026 at 8:42=E2=80=AFPM xietangxin <xietangxin@yeah.net> wr=
ote:
>

> Hi Eric,
>
> I tested your patch with my reproduction script, but the UAF still occurs
> with a warning in dst_entries_destroy() just before the crash.
>
> The reason is that for IPv6, dst_entries on the rt6_uncached_list are
> handled by rt6_uncached_list_flush_dev() during netns destruction,
> which bypasses dst_dev_put().
>
> I tested add changes like dst_dev_put() inside rt6_uncached_list_flush_de=
v(),
> the UAF is gone and the dst_entries_destroy warning no longer appears.


Could you share  the incremental patch you added on top of mine ?

Thanks.

