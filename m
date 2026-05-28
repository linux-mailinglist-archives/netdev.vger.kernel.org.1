Return-Path: <netdev+bounces-292688-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +FMYKGM7GGo1hggAu9opvQ
	(envelope-from <netdev+bounces-292688-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 14:56:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7E25F2572
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 14:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0BE183130040
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 12:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2701F3F0A88;
	Thu, 28 May 2026 12:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hrhiELhQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B853F0759
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 12:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779972583; cv=pass; b=RJKNtXrakYl8SnIKaI4ws44DSCqtkrZzaQLWmml/l4XcBP2kLtYEciQeaZGHBqJXj9SMisFMDKJKT0dGHEM445eHQW6K/UTxGnZ0+L9FYZGbNlEz2eeQuQZYwQsszyRi7MeUhnc5jD8ns7c2YWVePMbqPLHtJQ4RQzNMSoHPWfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779972583; c=relaxed/simple;
	bh=O1leBfAjhLl+B296quJwQjTQO/EbHkB/vXIeJe35+OU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qZI2t3YT1ceXkG26KoewKMcnxc2WlN5Y53Zw9P/XF+JBDX2D1YstXNqH23mmyq3w7PvHqMkZMAwky9O/JhgCOm1E1ifAqqPvuvNf7HQDtEdjEGIbnGcvFM0R2MtKLZBgFyK7xB9J17rQAhwMDfjdO8DBgieWv1Iqz5OyL9BBl+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hrhiELhQ; arc=pass smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7c7fc722b50so102257577b3.2
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 05:49:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779972579; cv=none;
        d=google.com; s=arc-20240605;
        b=h2ugROuUtkoRUPr6JFqRObUrrODuAnrEEFTbPl4NIfckhYxkm0JYK6JG0hohQRlv/o
         PisQFPKmXqSlG8HmwIWBr5mXZlIEB//K+Y0s7o3b6ZMXDEjLUTtoqYIroPSe6+OiGrbB
         7Ta/dFAvw+a0q+VZBfqzJ8RCUJqpFT4F8x/nvEPxNUM66Tpof38tMQYEs8QyFDmIecR4
         7JsRyYeZwzE8qcSbM+uvzce1igKMhVKkq18+Eq+QxPiijML6S3KKVylroDZ6KS1oOpC5
         sVx75D0nWK4XdgjSIeHGikz9RrXnxgPRHV3JJxtgDLFXoz+RClHMuOWcQk1k5dna/F11
         ULaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+6REFe2jdBaVPIX3Z2aJKta6DVmaqsM4BMxZnOJa2yY=;
        fh=R8QtRpKQBOI+yXye6KPgpNMHz1MUuJr3Ll0jcVALaBU=;
        b=HnuckUNmY1Df0L0pJKNdjGxt89LFiTiSrNW76TlvW/fLokUeD5PRRHnplTRTNxjtr4
         Vj+/cqfFCcNWXmXzhqrpB2vSBQo/KfxvrDfUYETwgJ5QaGu7WUpb9E6HUbpVIwOshLNa
         kYQUBOR+F8hqyEh4CNmzj3UsV7vmIFh5lfi4EUDj4Smlcz9+soXJftiPFQh3FOe5Y9mP
         xHBXqEGx+EuskRSIZhxSppC9Hr/zjusWn2G6yFO/8eOasutcv7hwVk/mPpXY0UeNVmZj
         C98KVtyMkF87oPKvXnRKxd7ym5vsy4E3XHRERE6qqFh+nQGPATkJVPg2f0YZg36vPFiR
         Bd5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779972579; x=1780577379; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+6REFe2jdBaVPIX3Z2aJKta6DVmaqsM4BMxZnOJa2yY=;
        b=hrhiELhQMWGMmPu1lCUrvB1VMTbqARmdASbAuWJ+TU6uV0Yp//suIOvWeOUNQ8Vg9Q
         KaXI2++5yq3/m4bf0QToPWgBQV9sPFLoYyivg71N/z3gP3ltbPa8nVvoJVDlS9RyCu/N
         LLc0LCEaxCIGf9bXcENPz62WKo5bxGd1tNY94TBZVr5/prNLMq1zOd0GlgeOjc6eB0fh
         ZaO0f8tbavQHGYPWGg7BXtVEJutlYhSZTTKHe8wJxb0Gc9TpLp+f74T15CwBALR8mmW4
         cKAOl/9NVkQ1boJqoBLTtkcF619wSprJxUMmh5cQCr9bDaYJDJ1pbvyoQcjQxBB705va
         jvbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779972579; x=1780577379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+6REFe2jdBaVPIX3Z2aJKta6DVmaqsM4BMxZnOJa2yY=;
        b=NKSIsYVKj6aakYpw9rOSURjnKz8/mZWq/mhAD8vYt3SiT4F/deQNZzhi2PvwfZTzu0
         fSlmrc+1sj4oYYxSYnE7VxsogJqBxCE8fp14EDmTJkCBVT+efgrTP92ZF5X+aL1ejstS
         ld+pvU19tRvXO+xG5MWooiYq2jKrrKSlXAiFEiW/XQIHF1d+QHNX/PBK4FRD0tP1rBmw
         /O4Tv+egRtI2oG4/GRBeMbGVi5jQdgKuBuSbFMvOBBA5yW6LypGI5Mw1IGRxV4RKoOgw
         /a8+rFpHBt19IaBezHm4tnNKTgsjpsqBViR3N+RHOMxDBYdJnJirjPcE044BscjyYbMU
         TLmg==
X-Forwarded-Encrypted: i=1; AFNElJ88PVSjsX6d3O13ViW/tOSy8UxRtjSHCHy2BrXjygJfVrtvnJDwvJVM0NkX1qNhz/IUJSi6nVA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIpicmEhm4S+axTA55ce08Gmmd8mCOIX/ulmt22HQHPO9Qb7Q4
	JUU5S4VgueayeRMKiO9w2u7cXVYb061PRWRnq2aVzpAfnt5TlcPbSZjF3V7yHFa9cbHCELjAapk
	TEyYdMLVawrby06BWkpULVWZRdCdYUBw=
X-Gm-Gg: Acq92OHwAbyrct2a7iR84heanvX95VrpHldfxPfLEIayHEecUK717tS7cdB3QcL0Sui
	HAaWPBuEOyQml6uTBHS0gwpprEeGIiX4MVxCnvyY6evSHMt6qy9fcVJNRozVnHA/Qju/fSD6/Er
	D54qu+2MKiiF9aCh50l8mD4GvZTHy0vpH72HRuUt7r186G9WeBOBZzL8hHqXzeSJB39EZvwM/U4
	noZNyZYO2LW9DHTluzY9A/yhr1qh9C+05dYhQjLi6mN4tLHj0vGc2Z8bEPA7Mg+DSgb29QYOMTS
	BiwX8zQL4vXgw8YHYKzpOlTyvvlkk4iIEaUybL40Decw/C+tZvah9b1MkgbIkRCda7JtnCEDmRI
	9W0d7ktotJGUv+78=
X-Received: by 2002:a05:690c:6c87:b0:7cf:c382:c70e with SMTP id
 00721157ae682-7d330cd5cc8mr294744517b3.0.1779972579187; Thu, 28 May 2026
 05:49:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260527211246.371451-1-luiz.dentz@gmail.com> <20260527192430.1b490571@kernel.org>
In-Reply-To: <20260527192430.1b490571@kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 28 May 2026 08:49:28 -0400
X-Gm-Features: AVHnY4IsTfqqjVFEkEIh-kXmxc2mA-_lWLHMnywwxXXJ6FcFD18NpOg6IgHAeuY
Message-ID: <CABBYNZ+wWpHZ6v-T+Ov8fiC4q4prDp54DFQcOWOnf6iBzKxXmQ@mail.gmail.com>
Subject: Re: [GIT PULL] bluetooth 2026-05-27
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292688-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizdentz@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 1C7E25F2572
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Jakub

Yeah, I'm still rebasing. Will amend that commit to add the missing sign-of=
f.

--=20
Luiz Augusto von Dentz

On Wed, May 27, 2026 at 10:24=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Wed, 27 May 2026 17:12:46 -0400 Luiz Augusto von Dentz wrote:
> > The following changes since commit ab1513597c6cf17cd1ad2a21e3b045421b48=
e022:
> >
> >   Bluetooth: fix UAF in l2cap_sock_cleanup_listen() vs l2cap_conn_del()=
 (2026-05-20 16:35:47 -0400)
> >
> > are available in the Git repository at:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git=
 tags/for-net-2026-05-27
> >
> > for you to fetch changes up to df35e8e0c8c4160c881bb673e3c7ee010824fbd5=
:
> >
> >   Bluetooth: hci_sync: Reset device counters in hci_dev_close_sync() (2=
026-05-27 16:44:02 -0400)
>
> Are you still rebasing? Or did Linus convince you not to? :)
> Looks like we are missing your sign-off on:
>
> Commit c3d01980c64a ("Bluetooth: l2cap: clear chan->ident on ECRED reconf=
iguration success")
>         committer Signed-off-by missing
>         author email:    kipreyyy@gmail.com
>         committer email: luiz.von.dentz@intel.com
>         Signed-off-by: Zhenghang Xiao <kipreyyy@gmail.com>
>
> If you're planning to no longer rebase your tress - don't worry about
> it. It's not a deal breaker. If you are rebasing anyway - could you
> amend?



--=20
Luiz Augusto von Dentz

