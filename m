Return-Path: <netdev+bounces-280499-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPWxME/46GkgSQIAu9opvQ
	(envelope-from <netdev+bounces-280499-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 18:33:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 327A3448B50
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 18:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1785030E203A
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 16:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8138C37CD5A;
	Wed, 22 Apr 2026 16:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=allelesecurity.com header.i=@allelesecurity.com header.b="mR/8kxtP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BB938237E
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 16:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776875124; cv=pass; b=SAkwmECfz/tem1jH2F2Zw0R8kCVwWsOIE0wvsKOYnMtlY7wbrjelxNa0T98Dmv/mIlrbKdEgov3L2KQwaBM1Vt8NHk1O4wuCHi9vR5glecCKlI/zviPaVbyfo+RavLF0eusZXDkPDQEZ53TwGL73/u3gGtPJWNg/G8iOcCpzaCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776875124; c=relaxed/simple;
	bh=Cp79fSO3GK2SRrsyvdg3YBqv98osqbRxtch40zv0Iy4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pqi7x0Ayln3xKDP9LupFiFeXnn5dHmXh8bRrp83vXUW7q5pxQSgPoc59bb6QYQeC2UAgSwJyUSEJQnO8KYc8OR1ied/RQxfjm4vVr514fQqBKUZtigCDzCuaspjd5JEYgm21kpF+FV7WEvUpJH6pILaeL9Qi7pcu9Ncdepg4KIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=allelesecurity.com; spf=pass smtp.mailfrom=allelesecurity.com; dkim=pass (1024-bit key) header.d=allelesecurity.com header.i=@allelesecurity.com header.b=mR/8kxtP; arc=pass smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=allelesecurity.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=allelesecurity.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-56d958880ecso1907720e0c.2
        for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 09:25:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776875122; cv=none;
        d=google.com; s=arc-20240605;
        b=Hnde7deZxtl57TDpX0m/ju9X3ESPHH9X9JnqGNjGV1ElIcK6Y4ijix6abHIR2/Oc6+
         K+xM0ZMMWfCfcCk++la9FY65tp7McCs49XeU+rgDl82CbKwk0GfqEvvJouUybdZ5THon
         f+pSpUeiz7FQMzSlZyHb9vt1xKU6Cr25ZoqRlnQkhEwCcmNmXCAaMb1kOiTK76EGgXYR
         ve6s7vRl0q8tsjslaMj/azYqvjB9WSy8u8O+wisQh1AvGKjRfKJnBJNKfqkxrais+7u7
         gGiGuJ41KEJ+KFpCH0pmI6/oebkSqxy/uw+Pt6Rmupdcq6ObsB5Zn4Y4wg8YHCkpAchU
         taAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Cp79fSO3GK2SRrsyvdg3YBqv98osqbRxtch40zv0Iy4=;
        fh=Mi/k46xFtaw1L6Ge/q6PCztNOC4H8StGBCKOXNkhO6Q=;
        b=CTjDwno0PuV6BEtC4gwAchlq+ypFas10mhUumGDR7XP+a7ID1V5y+wYvVchC5JOeJw
         OoU9DBhYFHBXOIXEfQfATALB4lmvspjUX3PHJu5BsX70yojwz4gWtaCjGo/Q5l74UtzH
         mVT876I9oDINMzwTPm/A/BlqkmX2pm7dnCadi+r167NbVl4FyzILHy91u+UNI9ljnDlp
         c6uaKpcuJsD5tIVfBJ3CBNtfFXfV7GFKo3SLvm5RWKMU1R0b49gGIaGyX9dB7FGkF3h3
         rVG/q8m33DSKEZee1JJqz7OSJV9wOwLcB/lardNCYNikbGK5VqWoXzvxypzJJQp8ceaw
         kIbw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=allelesecurity.com; s=google; t=1776875122; x=1777479922; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cp79fSO3GK2SRrsyvdg3YBqv98osqbRxtch40zv0Iy4=;
        b=mR/8kxtPde2qm99A+m3GY3pD0pfjmVPBB+b24KoA7cmrER8UJYll9Z6jZ+VbpW3AUk
         Ws9t1A+Qc9dOF+gSd8JgbsCcKDwhwzhVnLYLZJYrdGEWNFh8/OfH+uvfFthTUE9GtRRx
         zPFB2sFwjGgoOG8WOy4Lzh8kaIZpI0WIOFxY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776875122; x=1777479922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Cp79fSO3GK2SRrsyvdg3YBqv98osqbRxtch40zv0Iy4=;
        b=SGb2thf7KmYWeYfAbRRojrCr6G4suxs/b2piVb+gbmM/uKAXmiWn4VL3+NaYLSB426
         KxI33uCtEVJDyEanAkeCG+KBoFcAr1gXhxTrFIh/8XvR/BuP/1PXp0XQQP5tbF2a/aFa
         VXe7cIw3AeNG6nMo2pGo5UhS3jU6ATHSwYKn5AmMSZPayo/Qy2ltfTd/gZDi5RjHFnqu
         QrwxM7hBqREapwNJJVBn2oNMplWEJycWHLDZgL6N4mw7vU6o6DMUV0GHWH8cksXjXnb+
         aGd7XgNHfFXv6HO7qboFI9Tc+kdmIcuUXNl50z3RRLrSzVcnO57nBwv8xGT8EnYnePvy
         XLpg==
X-Gm-Message-State: AOJu0YxOac4PszouHtoRhkGX7FkbbR6vuYcSfmX3cviHjsbz7d4ZrVMg
	Pp6xTYw19gn6XImqhMyKuF3z7tRi0DMiH40Vt/VgL9ZtjMvyrZVZFZmYFrX9WD4zROR3JEa4tym
	xZWxzwJ/Ult9N6vlmXZGN1MDDrqVPTCcv501BkJ8M9w==
X-Gm-Gg: AeBDievPufpKR1ZiJopIrRBS84sRU62yp9YgE0ETdL/+PIpffjkuG5vPl4nkPTrDv7u
	90efHV71qGTpXno+ELm20u/C5OSWb6owVkpi0cynHyTOxiZIit/UlTnDYO3rTkxCJlI4ADTV7Fc
	0hlg3EmZ+z3i4NsQVLaUGAwqLUauBp/wQw9QbaNHJBFc+dg+GX2ejmPFgHfJ/Qs63cHAt3jqSn3
	4IXX7bA4R9BK9BJKqh+Rb+yD3+PI2YNCCgCxIm49yFUq8thXy0hvzwhwQEurUV0F17rDjR7vd5o
	wccy/6/lyYs3d5b58zY=
X-Received: by 2002:a05:6122:218e:b0:56c:d34e:bb1a with SMTP id
 71dfb90a1353d-56fa5828722mr11987755e0c.4.1776875121999; Wed, 22 Apr 2026
 09:25:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPhRvkyFrKO3O=D9YZoWWVwykCZ1-fXkzA9NyaJ8aaX9b-pcXw@mail.gmail.com>
 <2593154.1776874118@warthog.procyon.org.uk>
In-Reply-To: <2593154.1776874118@warthog.procyon.org.uk>
From: Anderson Nascimento <anderson@allelesecurity.com>
Date: Wed, 22 Apr 2026 13:25:11 -0300
X-Gm-Features: AQROBzB03wIIgYtDLCMFBhc4ROpTIV-FOI4DzvQ0tcfmArUuGHXrJKPx6PIENa8
Message-ID: <CAPhRvkyCQQM1cv+zQgZjbQDhQ2YVxJ26PG9UrkA6B7uTCguhPQ@mail.gmail.com>
Subject: Re: [BUG] rxrpc: Client connection leak and BUG() call during kernel
 IO thread exit
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, Marc Dionne <marc.dionne@auristor.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org, 
	Jeffrey Altman <jaltman@auristor.com>, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[allelesecurity.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[allelesecurity.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280499-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[allelesecurity.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anderson@allelesecurity.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,allelesecurity.com:dkim,allelesecurity.com:url]
X-Rspamd-Queue-Id: 327A3448B50
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi David,

On Wed, Apr 22, 2026 at 1:08=E2=80=AFPM David Howells <dhowells@redhat.com>=
 wrote:
>
> Do you by any chance have a reproducer program for this?
>

Sorry, I mixed things up and ended up sending a different reproducer.
I do have it, I will test it now and send here in a few minutes.

> David
>


--=20
Anderson Nascimento
Allele Security Intelligence
https://www.allelesecurity.com

