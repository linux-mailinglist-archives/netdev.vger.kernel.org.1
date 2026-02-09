Return-Path: <netdev+bounces-257893-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WNBaJzRZiWlk7QQAu9opvQ
	(envelope-from <netdev+bounces-257893-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 04:49:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01EF410B767
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 04:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0843300422A
	for <lists+netdev@lfdr.de>; Mon,  9 Feb 2026 03:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96CE1A724C;
	Mon,  9 Feb 2026 03:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ssx2RkzR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f66.google.com (mail-qv1-f66.google.com [209.85.219.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A548176FB1
	for <netdev@vger.kernel.org>; Mon,  9 Feb 2026 03:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770608945; cv=pass; b=IZhcMIpjMgQXcCiJwAEc+14E2qSUi2GDvUTjmjuIBdPxrjFeRmXSBzzadmGsQH/kGRpeVv5NY57kKnUtYt+A7MZqJ6a7U+bjw/m8WqxcuJJL/pdJu+04+CBDLSIOWtaIkFAJRYfDhJTOMX8Ubv8hGC51DqZHXMs8RDgbFMI9xd0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770608945; c=relaxed/simple;
	bh=RRiPaf2O1q4dO0a6BXUgDzNoua6513Iudp9AMeZCUkk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TOxzXrGbfeXHD0R1+rzBX9yJOU7kPpFiLDA09xplKCaDa8fi8CLgDEB9p1bmVBvoHo/VawgYJ9XWZJKNyxHj/7hR+4QACtCL3GjGwqW3dbAHraBcWrlU3gucaM1UDXAmzLT6nGTTbyV66Jaf++M8R1Od4ohY3DomuJ/2hDB+5+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ssx2RkzR; arc=pass smtp.client-ip=209.85.219.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f66.google.com with SMTP id 6a1803df08f44-894674a4c4aso42986786d6.3
        for <netdev@vger.kernel.org>; Sun, 08 Feb 2026 19:49:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770608944; cv=none;
        d=google.com; s=arc-20240605;
        b=FPKUwEBRqgHdnNCXAt/YNIg5TtXfwxg2iRxEiZiVL1ffiT8RCtWd+GlGzeB8D/YsS8
         mvy98W9+Nz/jLwQs7WDWtAISPpN8gW27HnDqeYTp4y5mjdcvbhrFOlUND3AJY4N2BLoO
         2rQER8VdNSM6aHgFBupA0/5VN/HCp8fgJ5DoDvqLMZCYX/ECzuMrtpSoNMgHRKpx9Vgm
         vvZtAkVjE1X1imOQw6JUqOd52k6wX+d10KmzjOk1hCWB5UxNc+LfWBBBuK1q3xbLxPcB
         2nZGHwQw462+hjaWdlFDG1iRJrtamxzJtxWtgqUX5/1mQgrDSYfCdNrOExmzsK+otlYn
         Vqzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RRiPaf2O1q4dO0a6BXUgDzNoua6513Iudp9AMeZCUkk=;
        fh=qJZK21Loqz0q1QQaM1/72+iIpgq3IsovaDi+jX9o12M=;
        b=W0DI52c11LwDKGkxVasW0pOwnw3DvtP3l8L7QUk7jZFD4QSWAcEpkmbF0KReDlS5C2
         K1D2KSrdqBFMPUd5sArPsl+X8K+YCzyafsjcOBuEPUNGnD5+QG9qWwQd8UHDX1Jgdn0S
         uQaO26TOI+JzR297UXroMDTL86I7qpvBv1GyjWVHJp0FieqH+NENfwxleoa8q3Rh5iEn
         OwsjRwg0NrwuqqQVyDKYwmhEvmKGsFVVyBbW8xgkS8o0SqD68gDeZLJFOat+Tp/7l/H3
         6DRU8GISk9tOqf6o8pmG7jUVEt1YwlE1y7ZE/uxprv0Zlajb38jffGsEEsQsVN/INi/2
         fSKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770608944; x=1771213744; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RRiPaf2O1q4dO0a6BXUgDzNoua6513Iudp9AMeZCUkk=;
        b=Ssx2RkzRsiY3nlC/bxLIquzBYmOhHPY8aOF/m75MEwC6RmY9uCRi6rAvLp0yF4QTow
         Ck5LltQ2EloEKTOlhFIdPH+WFfAchqVGq0x+VNXTKL+Pt7jsJkHmrJqc6rMObutNS2we
         k1VRLJPno3lHmLC6OJohrrIdm7xwr2EdrD9yLRDTBH2DLTJQIFf6OusARkRS+FtUjW2+
         R3pREuufuJXXWIl7Buuw4E6U6y8GhcbTSx0GNKMp0l74VosuIEXBTcJx+eHC61hgPmIy
         CCmL1I+8nXbEBCS3kyBCpJarsc7fFuktxdtlmnQSSq7wkAZxCDojOJqv3MVffbGz2/+q
         sdxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770608944; x=1771213744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RRiPaf2O1q4dO0a6BXUgDzNoua6513Iudp9AMeZCUkk=;
        b=Jg8YLWygFTyGo/wC53VdHVKjvLcXEev78nOrgcWO4TYjpCXMsMtNnHGJZ47o3/csY1
         XyrKu0C2tol3SX6Rs080HxR2MLyHR8Yp7EVYXmL3subVD6pN4SdAWqgdajRRgq3wBpj2
         U1aiKFT99pZIUJH5qYWb9KR9o+fbWyJFcG/F2qt7xWiXOJt6Ow7xRtRQpMQErPaFMIPP
         gRjpiYa0bZNFib1PwP5SHjlh3HYoxO5iG3FXf+SFH3jQqWRJnE03COQgufjhnPTrL/Zw
         qdnq3O4y5O2c4w9YkPampfxI8e8+kkdUGwGLWFdy5Vt8lG1BuBcQ95U8sQTi8bkEXKh/
         HmfQ==
X-Gm-Message-State: AOJu0YzYCBgWDxTTICmdZXMs0roGJczGmkRhxfSj6S0UvoLnN1uNIF5B
	xCRK79MUivEhuAMtreDTfgjhXqx+POVix3KaD/6F/w7skvsLlfjlfpmE0wUN0HFFjZY0kIXUWYF
	qK32g9vQ7SOt7ftthHC23NvhLKNZholGwAZb6
X-Gm-Gg: AZuq6aK3uuwN71ATmRsfGdmYt0QMbnNHylxnS8vfS4FSfShgc8Ng99jRpBlDnbKq1Jb
	z7Qbq8rkXjgwKWkRbAmg0hnrYRxNn/KEYtSNKXVipaV8UDNw/0CEIeLrogXZLGm1tknkwpG7ETb
	D8ncfu44pEtOU3kZuuhA1p0d6/WIVsyDkEBRSF+w8xOEFgtQZSOhAwurvbapWTYevPxOLEMWwoU
	TjHKSvNk3hBDvNX3serRAP71jQohTll6RNZq8rGA6ybwfswAXM+ps2G9+1XjPti+v2yyXZsJL51
	7tM1SENtUcBmcMapSKZA34hld+M7jDCvjyCtcDrSjUX0qOEMfk5AWWPZDw==
X-Received: by 2002:a05:6214:4017:b0:894:79f2:db00 with SMTP id
 6a1803df08f44-8953c83ae3cmr142911556d6.30.1770608944362; Sun, 08 Feb 2026
 19:49:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260209033604.60033-1-enelsonmoore@gmail.com>
In-Reply-To: <20260209033604.60033-1-enelsonmoore@gmail.com>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Sun, 8 Feb 2026 19:48:53 -0800
X-Gm-Features: AZwV_QiMyqaCZ1z7sypygnpfk0NtjIineZuOKrob3zt7Qib83pC2-dBknhHbi_M
Message-ID: <CADkSEUgW3WndYc0GO79fiedBaQ_QNzBU-bQj40xZYc9HN4K9MA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: arcnet: fix typos in comments
To: netdev@vger.kernel.org
Cc: Michael Grzeschik <m.grzeschik@pengutronix.de>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257893-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-0.980];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 01EF410B767
X-Rspamd-Action: no action

On Sun, Feb 8, 2026 at 7:36=E2=80=AFPM Ethan Nelson-Moore
<enelsonmoore@gmail.com> wrote:
> The ARCnet code contains quite a few typos in comments. Fix them.
> Initially noticed by inspection, then augmented using codespell.

Sorry, I forgot net-next was closed. I'll resend these patches when it reop=
ens.

Ethan

