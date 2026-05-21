Return-Path: <netdev+bounces-290610-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2DqPK9ptD2qOLAYAu9opvQ
	(envelope-from <netdev+bounces-290610-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 22:40:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E55A45ABD9C
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 22:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DC5CC30095F2
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 20:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35A6425CEE;
	Thu, 21 May 2026 20:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qXAgPBt6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D860B426EA6
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 20:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779396043; cv=pass; b=GKH7j8Gltn82fEyjFFxhtwAQlZpZeMqvuAzSini9O3DSC5XAWFXPCDkVSpYrApjewPahcnuWAMY30bwylPqBpna4aFH8tJqC3sAGRFwFRNX7JmDnA/vLuJAhEFcJDRxXAGEhpEvOHR1w74becRKBNHtCKQITw6GEuYGa6TOwKlY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779396043; c=relaxed/simple;
	bh=yP8KGy66CLbX3Ukv+ZuUxw1m5EDntCMD0KN/FDeIZaA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eKYEdFWQpbpQWUtC2AlHzM6q7NWgtqA72P+txXCxtI1R6h/JqvsskhtVf9v8FN0Tn0DN++LU7AENOlBb7TG6Uq5ccMciEhwXZ1zaoF08dpjgXLDXwe6AYGeQEzUdqlwzvJPELhDTGRS9lIxSJcWqzWZdQJYc5rAtynX3l3Pszc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qXAgPBt6; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-67389cf78b0so14660481a12.2
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 13:40:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779396037; cv=none;
        d=google.com; s=arc-20240605;
        b=QS4V8zmknwDsTVjyNXlLSMv8C5TzUXbeLffbojV5JQ02Lhkta1ErLacki0cJrGwvFx
         4Rpgl4Eqa6PGfeg663NxW8fPLVga3qp/xoRbi5do2UJfX11h7Uq5j4kcVpMbGEgd4iKb
         y0Adn9w4okjDPEfa67RPHGZyzNY1N+tf0gnf+4okWp+bA3/oyrugwP9qEdGofB45KbiT
         fYBYdQ1pWFUElGkFd0g4Tzeuc6Q++oADSo8tgghpX9t7SGaPqmHw2v1q/fhds2eW5l7L
         dSnk0NTbaejopgO9NVGOSZl98ugp2aXSYkZ/Q0mpoNJaFvRs7q3v0J/U42O6mqsbjGjF
         I/Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ze67pyM2HTEYXUgaYqNlhINPItrK8QSimCWmLndb06M=;
        fh=J7zRM3NUSm8RPsvFlw0KiZEbqAonN4nHNhgOAWnaf4c=;
        b=W2wy+KXr5I7LtSAyQuCoRraFIBlmoqcVWVBXGggUl1tg9Y8OLFlzt3NjJXn4CBw+p7
         RsioLWeiJIchK9G3vtPZ0YsnOuB0lem/P21+xyEuPZgrSBf3VwpTlcEtQZxf9wIklWcP
         8Bd2BEX3tkrvpQCylM6gxP+A8D7aloSTpxxQ5XAsNWJyhlqLI6wWMLwtUtqF/USmkNgE
         /rFJiXigfW9lZ1ko5Tqc8OGJFxx0QvAG23VgrpTpxJr1orswEPiyHd6PDtGqyjF0pbfR
         nDsil19F9gtxhXpDudIruGQSepPAJtQF3Wv4o7ZmorbFBqrKG5iPkGWXiqihaCIAWD6O
         c7/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779396037; x=1780000837; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ze67pyM2HTEYXUgaYqNlhINPItrK8QSimCWmLndb06M=;
        b=qXAgPBt6hsrBJTCth2LPQZa80/CVjMNZyu5nT+fAIHelx5DWBeRtYBiDviN/abN+GA
         qWaywO0C7VHZsg5cDfGac8xRgaY7JYtduhamgJfMiAWab49nz2fvRPqHfy4/WGfVbMAU
         q2FMUl1HZQGXQW0U+G+w0YzZDARXx3Y6Cn5XowezhUoXmuhU+6woXUKl7Qw5/jwqTL6k
         ZeaHEurQQOGe6/Q0g9oUHPcdzD18dj+KW0B5mEUZcK+COMl95N5/yADNaMPaFVCYgMTR
         AOTxHcu0vQy8805IWA5XT6/75olED4NMn+ZW0NUVkRy0P4JrkfiGDblTOtplYMXGtfxy
         KYOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779396037; x=1780000837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ze67pyM2HTEYXUgaYqNlhINPItrK8QSimCWmLndb06M=;
        b=cOypglzTyHqGogl+4Zro9U/8HlnQc8IoceXzEoJY1eJ1uhxpxQGDG34hM6zdYGf3hl
         r5G9Iz9F4wveF9RS6Bm8eHhz9HS5daeUsciY7gbJDx9bB5RJwTlvkb32aGmMiL0o8kYv
         2JNkYHbT9/MAwLoxtOduCXXg1FZXfNNDiaJSVprhqPPryEmeXZH8MJT9cF4FNkeyTZFV
         tTK1ziXD9uPUWM3OwpV30zjItiv3hpUZQyL7ZJzAFWVZjPpcmVHBlUF4Bmvg+7YDgd9i
         /5tq+QBa0xQWE5N6fbvgqW1W1ec/YQ1rTJcFXznYQpUCzsPgR3mKMustnmun+92lTeQq
         kiYg==
X-Forwarded-Encrypted: i=1; AFNElJ9bq5FrczIizhHZtoXrBAE8NvONIyLIF5/m/8Dc6IDl4LeAiFlEG3IQXFHFXhzB3Fr5ret2SbY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJu+DUjOdTsX/F9cY80NsKd4mdwQFGXg7PtSl+heWJUVqwbbe5
	hgaYf8EHgob/i+eA71+exfNywfUfe3Xr+VH8rK7DLBazfrze0YIBddyJP/XCHAmvt3kcAPUZLX/
	wYO0mDNaOYpqZQ3PZPtYUOKwrFoYy6Q==
X-Gm-Gg: Acq92OFMfTha4C4Ofb34egSSbBolJkVqZ6GmKUY76bmwmR9WNQ0nMSGVbafFZhPCfvz
	aps5muNDgAxrb9aea2gvnfwGF3eu+4NpkPlL/lzq8XE1GVO+BZbCmnWI+GaZIRhv0ogQaS8qU+S
	BvDomFpnZ5iOE0k7PyQvXrLF7kFg7zABMUw8mUBfwifunVOLZvwUnky/JciclsfstSBL88ySdJs
	Ub0Lg53EIzWebuZkLIKBKxn498lLcwsxeJrZKaqZKIeS5jXz6pd4m8a+X9gbEjOSj/ZPotXTxzh
	a04=
X-Received: by 2002:a17:907:c081:b0:bd9:60d8:6609 with SMTP id
 a640c23a62f3a-bdd25aeec87mr56952766b.13.1779396037466; Thu, 21 May 2026
 13:40:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520191943.73938-1-arouhi@sitime.com> <20260520191943.73938-2-arouhi@sitime.com>
 <20260521-happy-celadon-hamster-94802c@quoll>
In-Reply-To: <20260521-happy-celadon-hamster-94802c@quoll>
From: Ali Rouhi <rouhi.ali@gmail.com>
Date: Thu, 21 May 2026 13:40:26 -0700
X-Gm-Features: AVHnY4KCHObbT3QYD6a24XRvhNNiY81MoJisfWuLE7Y4SEhAswnLI5R8YD5XQYQ
Message-ID: <CALFSGuoWkHYmtrouvLk2M7bWS1=qTSPUn5GuabFvK92cPBfuZA@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 1/3] dt-bindings: vendor-prefixes: add SiTime Corporation
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: jiri@resnulli.us, vadim.fedorenko@linux.dev, 
	arkadiusz.kubalewski@intel.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, cjubran@nvidia.com, Oleg.Zadorozhnyi@devoxsoftware.com, 
	devicetree@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Ali Rouhi <arouhi@sitime.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290610-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rouhiali@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:email,mail.gmail.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,sitime.com:email]
X-Rspamd-Queue-Id: E55A45ABD9C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> Mismatch in From/DCO.

Acknowledged =E2=80=94 Gmail SMTP relay issue, will fix for v3.

> It looks like you received a tag and forgot to add it.

Thank you for the reminder.  Will carry Conor's tag in v3:

  Acked-by: Conor Dooley <conor.dooley@microchip.com>

Best regards,
Ali

On Thu, May 21, 2026 at 3:18=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On Wed, May 20, 2026 at 12:19:41PM -0700, Ali Rouhi wrote:
> > Add vendor prefix for SiTime Corporation, manufacturer of
> > programmable clock generators and MEMS oscillators.
> >
> > Signed-off-by: Ali Rouhi <arouhi@sitime.com>
>
> Mismatch in From/DCO.
>
> Best regards,
> Krzysztof
>

