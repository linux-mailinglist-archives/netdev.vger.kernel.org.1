Return-Path: <netdev+bounces-296706-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BGdnIXwcJ2o4sAIAu9opvQ
	(envelope-from <netdev+bounces-296706-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 21:48:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D426C65A25B
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 21:48:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=multikernel-io.20251104.gappssmtp.com header.s=20251104 header.b=qeQ8Z1nn;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296706-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296706-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 69D18303CE23
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 19:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0398C3E7BCA;
	Mon,  8 Jun 2026 19:45:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E9D3E638F
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 19:45:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780947917; cv=none; b=mlTd4mmOvebv8kXBWg+NHZGvC8OjFYY3TDN+mIc0E09gybt02Tl5cb7hccRoWczq8BQOZojwUo1WitTlhvekHQWW4M9P/dpxQn5wKCUaN4ogvyHauhowRHdoduY4758b5P6ftnnyVcs7IzPzgIgUTA60UMqSxM7qwUceEoL4Nkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780947917; c=relaxed/simple;
	bh=+/m2Jc5cDHgqwSYHsDLOxl5ahjyfPi/PBsiM5lb0wxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V3qTM8zoQ0GJS/iv0zTobNGIqaFwT0NsiP1s8MsA3ImE+HzTNJZMlRWICyYQnO8tTawqzcTjqR4xYjQWqhhkxyoGo2nsTNrDCJzB61LuetSEi9lr6i0oebBACLZsjzW9TCUi7zVmValDk0KlOKrRbhNjoNIUPL4LrhsihPexpvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=multikernel.io; spf=pass smtp.mailfrom=multikernel.io; dkim=pass (2048-bit key) header.d=multikernel-io.20251104.gappssmtp.com header.i=@multikernel-io.20251104.gappssmtp.com header.b=qeQ8Z1nn; arc=none smtp.client-ip=74.125.82.171
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-304df7ff4c2so3437639eec.0
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 12:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=multikernel-io.20251104.gappssmtp.com; s=20251104; t=1780947916; x=1781552716; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D28tLr2noqwRAaZT9V54hYMh7qTZZ9F05GZJj5pbMfs=;
        b=qeQ8Z1nnCNKxoba2bvHPUsqsG8Tg57W87ZV99xSvOJhebbrjjP42FcRrdKHahZLjGT
         hYUVeJXxWcflVltUHizqntR/RZkiYeNQAXIsL4DybOwlZYhoR8IgEkjZD1FBxnzPIkME
         3OVlymLl0HKprHhsaq15o7r2LcfWfZsDGXWN+aNxE9li5p4sEt58e8n63HniqaSTdsz4
         7ZNoZ3DYyzRMEXPcGqpfNkx58/t4oKGVkm5JbR0c0CxtbqpuTJW7nRzVOLEzEvKfO/dT
         P7aauHxbZYqiAWH3vXrQ2t1jZAUCsKyZehhVkYi70SQd1mfJzRSzq8FWA7659xkmSZ2J
         gB/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780947916; x=1781552716;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D28tLr2noqwRAaZT9V54hYMh7qTZZ9F05GZJj5pbMfs=;
        b=dZCcM/uGN1DITiJlkYzhtxJrMnCjNo/9LIPMRA+zDiymVeHrG/k9QlOqzTjbdt92u4
         G35LB8zIK/NYnOIQYcEDkmaWrg1K1Cuaxrnx7g967VFmO1VgkFM2Ioe4Noaw8B2hmH+F
         AwUy3Jk+0A4Y/XtpzSxA9+fUR4zzpf6ElZXqGVizB63LGxuV5/3xiZ73kkLshWHchkf2
         4BH76mexHPGZ3mX4M9h/e4LFByAiAtPWmUz7l+IM3vpNyUXosk7hJ+Q6hlwh5CfIfG+O
         nQmuureSqawhe3eRCjNnY1CpJ2bVhiNTI1rTaO4C1C4oGTlJ89xwPJqM/cMo28vRd/aI
         O7bw==
X-Gm-Message-State: AOJu0YzgGydkoy2+MuYDljRqfXJe7MdqnWXpw2LDKMThxTRfDfbdA2vX
	FU+iiOuNi9m4My9AVRwdGs2EIzVKMxnD6X01RJdd0vuEUko97a/rN8mPZu0vYGMG0XwyUilmewC
	O5uV4
X-Gm-Gg: Acq92OHDV7ov1Yif4jWmgGU7/yklejxTkCjTynTK/WiXUcEQq4Gkh2/AU+8tHGTylwO
	+Dwzefeaj70jHzd4GnmosL+LloTii5A0SsbhK3ucGN8ldusNi/NwxiNThm6cWj26osUAxyPYjsA
	o6lgqHo4vRfdyf5wuMcKhFQYRRJaEIlQ3MFpxpsdZy8nKiHKH7nZmfpnj0GyhWiNjvvLPcv1Y+U
	HC9X7GQNNaCgpYZNydk/vEPbyWBz52/IgO2D5mL211mzkb8vYWGOfZ2kT45lbDzkLb/hevsFN9J
	z2Zi6W8axoOmN5xlI90veN7G9Yc7/aOcaDSGv6bbZ1Qc6hL06IH7mqjgpvG/8xRbqaRecgqTgHr
	ubaaId8VJMinygemxNoxCczFvYkANdZ/SiYbImjswWiGrFYcGA9NANAqrE7EzNsM09nLmcxh3hA
	6iSk7ocKvItBRwwrbVMvQzvaZh9+bGTy0fW5MXUZpnBhkt8gflWbB23ZfVzdDr6f5oHKI=
X-Received: by 2002:a05:7300:8609:b0:2df:498e:811b with SMTP id 5a478bee46e88-3077fe2d242mr7395561eec.7.1780947915526;
        Mon, 08 Jun 2026 12:45:15 -0700 (PDT)
Received: from localhost ([2601:647:6802:dbc0:44bd:f433:15c2:72b7])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074db528dcsm21694115eec.3.2026.06.08.12.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 12:45:14 -0700 (PDT)
Date: Mon, 8 Jun 2026 12:45:13 -0700
From: Cong Wang <cwang@multikernel.io>
To: John Ericson <mail@johnericson.me>
Cc: network dev <netdev@vger.kernel.org>
Subject: Re: [RFC] connectat()/bindat() or an alternative design
Message-ID: <aicbyQIC2qEveNd-@pop-os.localdomain>
References: <b1af80fc-a57c-408d-bdfe-fa6bae26eaca@app.fastmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1af80fc-a57c-408d-bdfe-fa6bae26eaca@app.fastmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[multikernel-io.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mail@johnericson.me,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-296706-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[multikernel.io];
	FORGED_SENDER(0.00)[cwang@multikernel.io,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[multikernel-io.20251104.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cwang@multikernel.io,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[multikernel.io:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,pop-os.localdomain:mid,multikernel-io.20251104.gappssmtp.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D426C65A25B

Hi John,

On Mon, May 18, 2026 at 03:09:43PM -0400, John Ericson wrote:
> Hello, I am interested in seeing something like the BSD's connectat/bindat in
> Linux.
> 
> The deficiencies with traditional `bind`/`connect` for unix sockets are
> well-known. The advantages of openat2 over openat over open are also well-known, so I
> won't waste anyone's time restating either.
> 
> https://lore.kernel.org/netdev/4FCF171B.8000207@parallels.com/
> https://lore.kernel.org/all/CAEnbY+co6YLXANfeMnfBOBs8Ba_Sbdqz0Ahm8RzAhRF7MrxL4Q@mail.gmail.com/
> 
> Here are two previous times this was raised, unfortunately with no replies.
> Hoping this third time is the charm!
> 
> To hopefully give the discussion a bit more concreteness, I have taken a stab at
> two refactors (with an LLM, full disclosure) to get a sense of what the
> approaches look like. (To be clear, these are not patches I am trying to
> formally submit, these are just sketches to guide the conversation. I haven't
> built or tested them, just read them.)
> 

Thanks for bringing this up.

I have no doubt connectat()/bindat() helps closing TOCTOU for Unix
sockets. However, it would be nicer to describe your use case here,
especially what the problems are without it. This would help more to
jusify your proposal here than just getting aligned with openat() or
BSD.

Hope this helps.

Regards,
Cong

