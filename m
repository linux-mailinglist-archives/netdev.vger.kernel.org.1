Return-Path: <netdev+bounces-305123-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5fRxJa7MS2rraQEAu9opvQ
	(envelope-from <netdev+bounces-305123-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 17:41:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4646D712BA0
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 17:41:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=QV+HHMuA;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305123-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305123-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 08A7E30FE276
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 15:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD693AC0FF;
	Mon,  6 Jul 2026 15:28:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9383A38BF61
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 15:28:56 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783351737; cv=pass; b=UXK725PTSA2VmTo6ZXcfDUZ8oWPSNDdr4R1MVXSekceB8u3AxFcnnN0ZqQZ9c7ALttgjvTAnrP/kGEpMS/5A+xTcmfjGorptMotO8FthLKLlDdLf+4zvEZvs0msdImz7XHWNg5eaaov5uogr4leuOOm9Vy93fesnuqb7qbRtOyE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783351737; c=relaxed/simple;
	bh=7k6DeL6ujQWC8Az3boiJtx4HMnVIMtLm4gOs7Ec0JAo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rmh2O7d1pPU45a+V1gwXnPNvrpaXqzwOjiICoMn760fROme39Um7EKGSRiPvz1tosOKDpxQlzuIfUV3quuOK50VxVb0p4ICSlKwRBu/DES1akJXy/rlxdd6IaHL2348uCl/RuXeGEDxzABtzOUiNqHkvJlGWtTJ/SGh1hUQcGZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QV+HHMuA; arc=pass smtp.client-ip=209.85.216.43
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-381d656c36eso133146a91.1
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 08:28:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783351736; cv=none;
        d=google.com; s=arc-20260327;
        b=OmByHKA5r2j/vAqps1mlPYoPX1WEkDR5vfhaxOcGNbxQWlzYefTm1OQMQi7qTAYOv5
         yqPUs+slliNrGqECu8R3Br7hFFAB6P3TEnhiux95g7WUcNj0bBcGXLr5Fkss3V6DvCKZ
         j/puwlR//Oy8cevXqLVH7hv9ymDOqXlc+heUG+HjYOjAydlDhZmKGACGTjyGSXXw55BX
         wloCoPSlrFd6lB3P+NMcyN0P6DymS8RdpHTZ8yduQlhZlvBfo11R+8P64OnD42886WLi
         y5lveUAY/WyVgRqxARkyRFA86SAkwMhQDnuZvlu+ZmnETJRYSxttn92p3yhHfIXFoOe7
         /mbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7k6DeL6ujQWC8Az3boiJtx4HMnVIMtLm4gOs7Ec0JAo=;
        fh=Mn/HLZTdb4pePd/5QymBC84atmqbP2xBlSULmBc4aJ4=;
        b=LIvhElj/EihvZ6p+Y3IwM7MHyprL4oAdyI8GIJc+duD2rnJt2ACJslTOz6KHRD96qz
         tYpsOJAZ9GYtMvI1k87KhNsq0vloQfabHdT7cDPb9goYQlc+vpysqjwvnBAcM0aeUTGW
         vMZpFesMzur0xB+kO43MotdY0v/Zd0mcGx6CHc2sv8nRRqRs+eZZ7DEP0Tk1wwHObxlN
         5RmhpU5dfa7ZWCYVQ43GtMtJo0kEraSMQ3O8Snt6/RUcjRMx2zrzMrzc7vKpFKh92LzG
         07owBoisar6t3QRavUx6pqKUIXVpQ6kYyZ71dP9Qtzmj6/OFfyN2cibe7t2Gotbtg7H1
         DWlQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783351736; x=1783956536; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7k6DeL6ujQWC8Az3boiJtx4HMnVIMtLm4gOs7Ec0JAo=;
        b=QV+HHMuAgmhD9PRk7fji0v+Sh36Fvq1RksQaTL9n0iOtkpZY6+9QPKSWp6Umr32jam
         uel8jtMbwg7/CtR45PZ6y1b9MZrNdYOqo/QEkIr0olc6KZtYaj4pphx5GGLcVzQhfZkS
         yx4YvmhNpUwiHqtHTvzyhIymGLK644FHzObRncaNYriF6JnZHQ6uAOznqOKi/34yA045
         JAyqn+lKld72NVADINM4hbdfA39EhqibDLpAuoYN2Av/6LgOurQAwdj33/Mn4uxrvLBH
         F0cnTPjQDcwPBQbmH7m2BfSyIuG/fTfVJG31F1rnGawzFgiTusXihndTKWXM/vPpinig
         HLKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783351736; x=1783956536;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7k6DeL6ujQWC8Az3boiJtx4HMnVIMtLm4gOs7Ec0JAo=;
        b=W7JgYy7+zaKBFeoaa3GaWR1CWauXc8WSmYUXWCp7HJBIMUxjfrzS8J4/k7h6BrLz2Y
         4hc3tvWlBqiyKe2EkxUHkrXA4BCGZCp6pk+iFuheXvHV9dGYbM0DmM6TnmHKCm+uUr5D
         cQM7yoGrRgcyLTG/ykrrHNJCW9RO5pI0VhUKmbvLML1+z6Ve79xJGaQ7MevOqjOwSwxQ
         2vkLvy1Mqo27lqt08BYelA2gCiZX6BJQqeO9UDpdatTFSOcHpusB5nIVMGhFdslBwOt9
         4lwNnaHwja2NmfWW3vYrarbp86wb9GaPcc+JXr7V3gUMovw1GA+EW6HMu9b1UPCfRv3n
         h9SQ==
X-Forwarded-Encrypted: i=1; AHgh+RoL5Cxsmnr5RQXAvqsLxSGRkfzRcUkWIKzExpwPVubzGiiGP09+m8xL3LPD3cfRoOGx+0Mbxno=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ1pyeN8It0q6wparzi9A3Oxx+XcujpoZvsH1Uw5npQZMaSGvC
	Wl+vSPhw3dczyT5BdSOJE6WEaNeOVJYA5MTRO+FFbkvSFDn/XHoRbc4Tcl7TXkxaYKdnKKoOohI
	OYJoK7wwTsixMGdcTQDuzeNLXP4pptJI=
X-Gm-Gg: AfdE7clPzFw5bfWWaKcCn9hBvmW9++1gQLM7WqjE6SHo6pLr+EOHYK11qNjp7AVQsPx
	pEnBnlCmsBfj32gZGagXDeLAAboKRn2eJKpiIdihB7A4GlAiTmPCqIxOGsL4bOv6li7tF/BEa67
	W8TwAlMCadwty/IQ1vS6WcO+K5SbfVTzCa06JqcgLKHPRS0GGt35Yec1U2sNQus4arI2M3PB0a7
	/dftLF7XjQ5/X78dOB3b3SfNWlfQGTBVdpXDJAbchTgJMw5zHIrsIALmo0I2xFCIqbcgxfZwVmr
	722nA6I9W5Tb0pzpMyIHxUE6AzI8Revgpf/9CjEkRZLVrk28JVjLULFWPUjjkj6ZCAIKFCDUqeH
	AKGoLvoCq9qnU
X-Received: by 2002:a17:90b:3c91:b0:380:7688:fc06 with SMTP id
 98e67ed59e1d1-382a00c393dmr6538387a91.8.1783351735962; Mon, 06 Jul 2026
 08:28:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260705-net-vert-imp-v1-0-95a35ddff411@gurudas.dev>
 <20260705-net-vert-imp-v1-2-95a35ddff411@gurudas.dev> <d2c1e11e-e616-4b2f-aa17-5eb96f045833@lunn.ch>
 <DJRKZD8LBXXH.MCISM5ZLNVMP@garyguo.net>
In-Reply-To: <DJRKZD8LBXXH.MCISM5ZLNVMP@garyguo.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 6 Jul 2026 17:28:41 +0200
X-Gm-Features: AVVi8CeWDj_fcpRxlY9LHajh2MWaBpJDhHsu09AJf5QyOF1UjwXW4i4yZ6uAlV8
Message-ID: <CANiq72=-pEL+CHL5uhmnGna4xjEWnrJuD=FwHBwtdJryie+X4g@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] net: phy: qt2025: Use vertical import style
To: Gary Guo <gary@garyguo.net>
Cc: Miguel Ojeda <ojeda@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Guru Das Srinagesh <linux@gurudas.dev>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Trevor Gross <tmgross@umich.edu>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:gary@garyguo.net,m:ojeda@kernel.org,m:andrew@lunn.ch,m:linux@gurudas.dev,m:fujita.tomonori@gmail.com,m:tmgross@umich.edu,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:rust-for-linux@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:fujitatomonori@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-305123-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[miguelojedasandonis@gmail.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,gurudas.dev,gmail.com,umich.edu,armlinux.org.uk,davemloft.net,google.com,redhat.com,vger.kernel.org];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4646D712BA0

On Mon, Jul 6, 2026 at 5:16=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> Miguel, do you think it's worth moving to Rust style edition 2024 before =
we
> switch the lang edition?

Maybe -- we could easily do it when we remove the `//` comments, i.e.
we could have a couple automated commits applied at once by Linus
before an -rc1.

Cheers,
Miguel

