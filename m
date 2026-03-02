Return-Path: <netdev+bounces-262543-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6KtaFo09pWm36gUAu9opvQ
	(envelope-from <netdev+bounces-262543-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 08:34:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 010101D3FF1
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 08:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 651B2300B1B8
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 07:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C440383C94;
	Mon,  2 Mar 2026 07:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0B/ugf0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885F2383C9C
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 07:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772436874; cv=pass; b=FYfm0IhRxR1LOoEb21krRSuUJY13yynBxCbID2zbxVvPmqNWOkKbg5F9CqW2JUf3OHakj39mc9f7RWL0dGGKG3b6G07x3c9c/5nOGtdE9og4kB8TBTKTysGcAO2Z/7HY8uISPacGDnwJ0UeccjmofxJnbd3qVMve2SpmQGOsuXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772436874; c=relaxed/simple;
	bh=F8us0mYDe9VzqkuQSV6DKqQJfQZIy9UQUe8TBZBNxvw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P03kLHcgrSq13Vsome4cVyitu6vaNbgTuNiB1tuXBpV7f91732IU4wZFZnYZtJ3TuU/PX9MIP4MjTUwXfOWDcxdzYhfL9aIjt/ZndLUB+bbUjjUnd4nX7oSlykcYlqs3dZ45dq6fBBOAOGElmbJRblGAtJnDvA5Wr9dkw6pebhw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l0B/ugf0; arc=pass smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7986c7b8076so40264907b3.2
        for <netdev@vger.kernel.org>; Sun, 01 Mar 2026 23:34:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772436870; cv=none;
        d=google.com; s=arc-20240605;
        b=hn/vn4JI/xHDV/CHo3AtzYeNdMSYKzCdBXDTpD+ClEgzIKBQTo+4pulObmg/Wj4DwX
         /DSXqi/neAad8Lifr/BY8xIhigixsxjC5T008IG8tKSJZBdglTlCmDo6fcsx6VV3vYL7
         ITnHHa3epul0xIq4T99m6Iv2v3NafddymZNW1SQJ7CCliDdulZfJm2HTuiUa7tbTPlpZ
         atWpk3W6HmNK/9BS2SuRuR8Z9DPrLhOKAAAqvFQY1SoeQDCPMsS7RnxtieAMpJnDVcNw
         sfl4sOL9uTZr1un32KLaoSdivUYezWYzGrKgliud8cJgncDQ5waV/nhKeN5S4inWDNKT
         j8tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cYt48Jm/b28J/QibUPBjfmfCYTHIExaVQFXEe6zv+NE=;
        fh=a68ZF3eHWe+cWuaDP6J7KgNYj/+nujD0X9yn1XD7tao=;
        b=fHmCxOmCj7+5QKtZ6IxzSovPMXZ2zCPLXvHM8mVtXsKfVe9Ssre/pYnGlgQ+kbg7Nn
         7kQYzFvpujXSCCetIDIFN9MFcRoAMj11ZpwH6uc3829r86vKaE4f1RiIBNpsUgqk8H3Q
         NyPK3FlDrsD0HrG7EDttrVpT/OqJbuxpiIzdRtl37UcJF8m58GQy2EaHD4KA3JvmTEvM
         WXd9OA0BANb3O+X/iZssQhNprRQ4rYB6/6ZWkraa3rVXc4eX1lkqmchRHxvU+tPzNv1o
         kb3hZQ3bnMM4UJQtYkx6MYt8iQYkLmX2RNf6aBuPcm1Aq0U5B0ygBKwkiFfvahaofJNC
         +ioQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772436870; x=1773041670; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cYt48Jm/b28J/QibUPBjfmfCYTHIExaVQFXEe6zv+NE=;
        b=l0B/ugf0d5abhhOCC7WiGq0ThYiHO88puiDoNcIunmOTbqNIv+lniwblEQoBNalJNo
         EjuFVaeyALHhgvqjIHsQSao89C5/TX3B1+mvnETSulpzzASkdrwCco6EPBWi1TO0yaPI
         E6hW1LpRVRcva5V9iibPaUs6r7z1niXgaEpA+crSJO9IBQNU1pNkMFK6ZzhCvFP1IKeq
         kFCArIp0Mvmviq87Upc7YnsStHH/wh8vX583GG/hIosOf4R1RwNdxz/OrkpZ4gD5mNxd
         QjI3+ur+RiB8DBAajdPj2nxqFV1GbTZXDTsS2HSLEvT+8tnWZMdqNI5xGnLCLGR3IIWL
         SIaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772436870; x=1773041670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cYt48Jm/b28J/QibUPBjfmfCYTHIExaVQFXEe6zv+NE=;
        b=ill96lunK5UsxgSn83SNL8G7j4Kl+kGIDxmVnxqms7Ln74Z7RZbvLD4IjzErgEZ1/0
         NHj0vjP++pHdNXDJCpt3X9fs6ctprGJuekxkmVqrrnUHWZsQsbX7QvuYp5X5Noo9f0qU
         aUoZWHFe91iWYHhS6N1e11MM7HntMRGktD5SHme3M1MKXONJM4JN7eQF6hqBPP/ytsY7
         sIHSj2tjbS69qd21f4o6oNB5VY9dljSnTRMY8AenKWJmSUrdiEgG00Rwpy4XnRvv5A4B
         G3T42fuPBLptWTmFs1y6dZQfEI7kuLpeeGNIzYLETydOtZXPpOMFPoSLHaxqrHQOsSip
         sbrA==
X-Forwarded-Encrypted: i=1; AJvYcCUIS4iPY+ZJx+HZ1lOCybiT8t1LDXwm4eiLbQxGfLAlLtdXahIcp5BYbBU8JNZxhFJmIHrArqs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxQGmoQcUPhyG8qaPKapUM1fm9KwEa9p/da/UxhLLoe3QtSI/s
	5clYYiXvAGgxt/3qWTn0DRNusbGUAeY7GbsOJWKaXBTTiWtJxxRCsu9AirpjBrZXbiO7mK7ohsP
	iJ4VcTPbkRvuxbeEHoqg0BJEybMkh5bo=
X-Gm-Gg: ATEYQzwUjtF2runzxkv4tw/eH2IRM0S/WTIPrj+Vq/LuKrP9UVX0sh1UyhgLiM8Jppu
	vfyvmf77SdnK/7knP+k63gnKkqZ8lDZYr8VZvStH+HGEvXyOY0qPGIwwDPtcWGLEX9W7IV3/3p1
	29Re/qtH83QHHwv/rLw93EQSfd+WVtKpA7VmL1XcCXYF5/2t8r7lqbefgbhDq6UwTLw67qdQ9cO
	gkAYQRL9qf9PkRdwSLO1f9c1kIGqT93yjOkCjvT6Awee37gFrk+nqUB32O/+5rrl0NUdbNb9d9P
	+BlzMVtMKOrzvM8U
X-Received: by 2002:a05:690c:2612:b0:798:80e9:c291 with SMTP id
 00721157ae682-7988546fe77mr92953177b3.12.1772436870563; Sun, 01 Mar 2026
 23:34:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260228032317.146855-1-dqfext@gmail.com>
In-Reply-To: <20260228032317.146855-1-dqfext@gmail.com>
From: Qingfang Deng <dqfext@gmail.com>
Date: Mon, 2 Mar 2026 15:34:18 +0800
X-Gm-Features: AaiRm536FaUiui3FQJpBvApexR5qVl9Il56KFaQhAG5NQygfho07H9harzKka40
Message-ID: <CALW65jbAGUxsyNw229uHks92T3Vr1iuFs=hVeTB3N9awAuZVXg@mail.gmail.com>
Subject: Re: [PATCH net-next v4] net: pppoe: implement GRO/GSO support
To: linux-ppp@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262543-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dqfext@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 010101D3FF1
X-Rspamd-Action: no action

On Sat, Feb 28, 2026 at 11:23=E2=80=AFAM Qingfang Deng <dqfext@gmail.com> w=
rote:
> +       /* ignore packets with padding or invalid length */
> +       if (skb_gro_len(skb) !=3D be16_to_cpu(phdr->length) + hlen)

Both Claude (Netdev AI Review) and Gemini said `hlen` should be
replaced with `sizeof(*phdr)`. Is that correct?

