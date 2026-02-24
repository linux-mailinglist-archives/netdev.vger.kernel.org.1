Return-Path: <netdev+bounces-260587-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eEp9LlDRnWn4SAQAu9opvQ
	(envelope-from <netdev+bounces-260587-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 17:26:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2100D189C94
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 17:26:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5CCD9304E72A
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 16:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B993A7F52;
	Tue, 24 Feb 2026 16:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nv0SnCEv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E03F3A7F51
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 16:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771950171; cv=pass; b=SstGyEJdxOKi3w0eNfCXFfMpeADtEVU2MnaHBdUoEyEDZ8+jBcy/oVYrOSYg75KSjKi2BVyFapVH09rlcU27f8/+KJN4ENgW1IcU5TOp2gVgRqMjKOCXX3qNasEKRiRvD7u+1bOgXWARZ5GTdNCVmeKE43ClGAz+GTiFS2I9DvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771950171; c=relaxed/simple;
	bh=zElRkeIVBB4cVrg9UxuI6BIZLT/u0RFeegdXTtGlAq8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TUuvCi4tmcl5r+WIxUGkZq9WEl01O/QzTrYXSSCeX5Yebob2Hkc2Kjx8M4iHy/TSswlaY9xZun2i0FzPNVGTliHBF0FxljU4iDKpDZdXGFEe3RfgaDXHci+yuoUrunZ6DTgYj8aD6vw60GC66L25KHJ9Cjle6YKrjoJtCcTLYKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nv0SnCEv; arc=pass smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48374014a77so59591045e9.3
        for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 08:22:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771950169; cv=none;
        d=google.com; s=arc-20240605;
        b=M1DhBUUBcjchfKj7Vz/HI8t9PfuXhF+eP1PujJEIfD2F5us+xnUHQRIdCWnGZkxD+V
         x61z/4ledD0GCS7YvYeOBW9+bXPn8XKtvrY5XAH+6Kt+/9y3TChzTEiY9iWaUpr+sWWq
         tQVz1YBwT4p8cphUVxaUC7LDkRwi7TkDy4wyHY6AzGMRafGqtkahGbnwxegtWSfcx+nu
         CeSPlHPIBUe0804TpW77pxTN4nNEVOa2dejMfvH1ownHffwa3/nJbK+umxXhb0YlVfmb
         mricTqGScovH83LG8QwPrjcpChrXg2aY9e6pohjKCg6NBWiRYjvCKsFQo2jasWQ3yg8H
         9hrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JGercx3vkdEAz0Gc46HRTj3KBzubttjIgevwNppmhDA=;
        fh=BrkP7dtj797oewyJkzMyPoRHXsQPNBthzP/KYBvRvgc=;
        b=jVAS57Xa4BRQscDQHynNpNJDTa9WhCuB/QN7znWpVS/5LJVRMXHR5bcG+EvH08kcm/
         Gq8BeC4tXRO15hrgFlxWVpvAGvN7VORYT0S/TRuKDOl8QhcxlnOhvc3uJrBaeQzwc06d
         q2EwBo/9WFDz3MEnGSSZnNSLGgtQ7hEFmgaaeW+zNkGAYtqGBBIDRCo3nk5Xy76GucxR
         Loe97ATELZQCJU3SxQHBl4clwQNQHeKWKlnALNREtNW7Zv+dWd994xWNRXjK76zkEnR+
         Mp/NghP3lK/ntrtoOl9xfS45dbNbxps8zNFYPQQuHufJd/JToj6aO9bEistNQ4OviZOP
         jMug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771950169; x=1772554969; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JGercx3vkdEAz0Gc46HRTj3KBzubttjIgevwNppmhDA=;
        b=Nv0SnCEvj1E03ViLsMVPWP2wy9007Zy3z0M2SnacQXYCJdciFiNBQjYG8+SZ5rHWMQ
         horLoTFoFgwwy/73BDzujVnYhfVgxCjj0XlGTVLeZE2WrMG02fJ4BEKclUEcmosZKDcZ
         TBikCiqnYHr14L72t3rToEdYQy42yp+QAH8cGdSC6Cz++9H5cRV/d3CQe09he1sEzuEX
         2uG8rLXuNUt8pHYaIAqxM1ChPl87ZqG+WeRPBT5iy8NzlHLx8pLN94HXdD/DJlCqGzGQ
         l6D3bmI8jVlM4YDR7TmYof13Hxa4baLpZfJEwlGaWsEAQ5itbew1PT191Ou4LkEoayFf
         RI0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771950169; x=1772554969;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JGercx3vkdEAz0Gc46HRTj3KBzubttjIgevwNppmhDA=;
        b=Dd+cy2BiPAoTW2XHEo6m6fNEyrsBpfBNycuif/CFsN9FFUX23HnILdLw2Eo9abdOcd
         e+1FwB5JTMotSgx1r4BZNvEhEiBH6D4fdybRDAhkgZk1GQR0DDlNdjjStB3HwVRsjhDj
         GFItw1OMmusT/njwKIKZwlOyUw502of+1ep8uP2UxlGSuR3T1gUNP1M8/0I6F/mBu+N+
         uirPuruYtuhL7sO/TCqv2nUf3cy0YeEogoPOXVREmS8l2gmA94iOWoEg3RTQeM9eRCR1
         FPjIZCEHwfLDdkMFIRE9WNI2uWk+LLQG+IA2WO9CmAjLmHbvst34CSbvWp1ZVW2UbZTe
         SNug==
X-Forwarded-Encrypted: i=1; AJvYcCV4veAsdc64p+icJnhtajpYZmtLEBgqYukPPV29C8T0hSy1QKWPqb2Wy8MkEAFUc+Kdt0r9myA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgfR0sYp/c2oIwZclWvBLLLKygnrL8yRbMugpcNR//MgPm83WW
	KJFH1ix2wd1S/Pqwm92A8d2GVphfuk6EHR3krOQzDMzL/zhFqp7YWd8GonDpe+1GsqsDfrHB2cX
	Wo5oYGpNEUyInDEyuf+PX7PySB9hShyU=
X-Gm-Gg: AZuq6aJXhmY4zN/ds2r7xDNFJEhn9mPEgxg/I/w3akEguu13/PS20gohlsYnIZW/RZ1
	Iv4Kn7NB6QADc8XAxAZeen3WFLoTreYGTYvWO6BLNOeOepa1cefxW8nlUSn5u355qFRFbqo31V9
	jRfYiACbD59Y9pYouheEF5a7q3tODevdRlP24GfjScStiatKTOxK9a4fKLQrOGkTRMQPKjnYuZf
	AyCw0sqPcyLMC0Ik76Rk/aAWMpIC3RK5XoTs4TRQUjBMzTXKRNzNMmilLt+RnOGy4VWFGRCXJfe
	9IyqQqPZEUirkg8xbPRvzuEaEhHkIxBq55ZcgoRh6VY7+uppJbN06notsm897owQmUclQQKnTuY
	hqlRrgrcQ
X-Received: by 2002:a05:600c:45ce:b0:477:93f7:bbc5 with SMTP id
 5b1f17b1804b1-483a95b5835mr212494515e9.10.1771950168684; Tue, 24 Feb 2026
 08:22:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aZ2cBWyiG_fKSjIq@sirena.org.uk>
In-Reply-To: <aZ2cBWyiG_fKSjIq@sirena.org.uk>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 24 Feb 2026 08:22:36 -0800
X-Gm-Features: AaiRm51o_zqO5Ia2dOB6XYBIYz_d7zJjJJTNTIBgDEBW7i99NJvSUvxyxg52aCg
Message-ID: <CAADnVQKoX=Tg63QiyuUZ9aWVYUPi3-gQFCs47s5AiWKjqT=oZw@mail.gmail.com>
Subject: Re: linux-next: manual merge of the bpf-next tree with the bpf tree
To: Mark Brown <broonie@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Networking <netdev@vger.kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260587-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[iogearbox.net,kernel.org,vger.kernel.org,gmail.com,linux.dev];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexeistarovoitov@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 2100D189C94
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 4:39=E2=80=AFAM Mark Brown <broonie@kernel.org> wro=
te:
>
> Hi all,
>
> Today's linux-next merge of the bpf-next tree got a conflict in:
>
>   tools/testing/selftests/bpf/prog_tests/align.c
>
> between commit:
>
>   05849ec34f3d7 ("selftests/bpf: Replace strncpy() with strscpy()")
>
> from the bpf tree and commit:
>
>   f632de6e19553 ("selftests/bpf: Migrate align.c tests to test_loader fra=
mework")
>
> from the bpf-next tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>
> (deleted the file)

Thanks for heads up.
Since the file is deleted in bpf-next anyway I dropped this hunk
of patch 05849ec34f3d7 and force pushed bpf tree.
There should be no conflict anymore. Saves the headache for us
to resolve it when bpf goes to Linus and then back to bpf-next.

