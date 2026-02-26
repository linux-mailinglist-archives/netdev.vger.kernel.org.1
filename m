Return-Path: <netdev+bounces-261395-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJcrHc9loGkejQQAu9opvQ
	(envelope-from <netdev+bounces-261395-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 16:25:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5A41A8A04
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 16:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4411E30817D9
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 15:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338D241C31C;
	Thu, 26 Feb 2026 15:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Xs4qOZM2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f225.google.com (mail-pf1-f225.google.com [209.85.210.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E7141325F
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 15:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.225
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772118727; cv=pass; b=UFps8CGZXZeMEXlGFGvW2I5RvOBz2LKcfQQ2JDRNioBx6xb1y1pjB/JC7elINmFSneqSVON+agGvI6geQpC1ncPet5P5meoYSjnSkCqhDvi9s64dsKwfiGvkInR+/RZ9x/06MwcjOjNk1tN/l0PdoVM2yLgVojwYAgtyT/VJSiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772118727; c=relaxed/simple;
	bh=NbJET6KxkAXnaJPsRNK+gXgAfNUd5YHwy/v7Bw6FEBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=brgfeAqbWIJ4BL87XaSkiFlijFXaicWXaeefBBgn4MW9qnroQS36NU7sXBQhfd5yYr/IVpuFcHBFQACiNSw4ULH7pgzIUl+Z1eJgD5/a2yldnY3c0963/95nHukJ4r38zI05oSyqxmnGGBvsN+SIFA1m/Vga+IincikDeh/13/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Xs4qOZM2; arc=pass smtp.client-ip=209.85.210.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f225.google.com with SMTP id d2e1a72fcca58-8272ccb554fso847491b3a.2
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 07:12:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772118721; x=1772723521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NbJET6KxkAXnaJPsRNK+gXgAfNUd5YHwy/v7Bw6FEBY=;
        b=WD83vY4n2a4F0rD+42qA7xPL7/9HOuG2lf9TdPiSxr1wYvCksF2p3ILBZjyylx48qU
         Tl69MdlxeiF5OTfjrRTGxrUjHrrtAaFz9DWL6yHdK4Gz9EW+vkUKA9gByfKvesQEiLQB
         A8yoZgMja9DBWxOfInCADgPgopziTp/pz3sfW2Ti6cZoz/k0mU7DY/I08+mKgWpXqGd7
         1RWPPsTAS+bUzbRZ4E7T+kBsP3netqet5KWiHfcpO+vVZfvFouJoQaixkDyzV/RhN9hj
         ciR6oclbRvYeN6V2btgKCcsNvyS9/2RP7PxEcnbjmbxowSfr1myRgeHVx2opdIfpP0sw
         iMtA==
X-Forwarded-Encrypted: i=2; AJvYcCVtx5KLYjKeqfDFOV7ZPZPdZPBeWkTk21qO5C3dAJSP8tkLA1xkxXb4dZSZPFdGadrAIqPHuUw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLw97Ium3WTOdNga2cS4RWL0JB2USg+WcB0ac5jgNEeCrFk3YF
	YpGIAB+hh6FQd2Mg9VSW0hQByoIlU/af1+dYCkgUaQNL6Tii2CTpksrpblDdgEIr7bw/EBM6fyG
	fFMZrfVZEQ3fwBkbi9KtdAkcsZuQQPYQcHsaVZZUS+Ghn8soFEk3dQbhiZ5n+PFiZ/RFLCFVHZs
	eQn43yJBOGsOXFup62NZx7VdPrr89DN3Wt80QEGW1rNjs0HzdRm5q9iuw77h7nG3ituC+iv/ONL
	gqASajhIQ==
X-Gm-Gg: ATEYQzwNy8gMmBW9H/dbjU65hL8BbDTs6jsrvj3hfYAnGHA6CaT1Larv5WABGrkddMg
	x6tD05K14nahi4OWX8GF6xd9UbPzw9LuPsK4QvgEE2Xa4ttLUG2VxuLzIKiIs0GzOCGWa5zzXXZ
	dRArbvo/543UN8Q08R79zcD3S1h6ORfw8UF/R9rE463GzJtLfhGvehw10+bF13gmdic7RazREQE
	HYPJpisdxaodbxte0ULzV9otxS7lyC1vLvE2olTnR/K8OLcXym+1NGqC4mIu9YlzR5RSLtMNYjL
	6TIkHxtxmcC0sZ6Imkn5ImMuTSWg+f9/ml6E/4zSUS6fT0tq9lzcyvZzn8iO3FPMI5XiP8bB0F6
	sjNw30GgMK1WoKBzpEQGOgwSnRq5ZyorlsVRvDxtJWuHuEllM6mHKVePOFYkRvfErVjrJrIrstZ
	gIKCqHQO0A5ff8JsNdf3sIb8AuKYWrTqZVDKRiCUk9je1JUOGGa8M/j14=
X-Received: by 2002:a05:6a20:1604:b0:393:8fc:5284 with SMTP id adf61e73a8af0-39546027fb1mr19152726637.70.1772118721194;
        Thu, 26 Feb 2026 07:12:01 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-95.dlp.protect.broadcom.com. [144.49.247.95])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-c70fa5eb78dsm164960a12.4.2026.02.26.07.12.00
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Feb 2026 07:12:01 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3594620fe97so2572487a91.1
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 07:12:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772118719; cv=none;
        d=google.com; s=arc-20240605;
        b=Rz909PUxcpB+4CjA7MQEzo5WWhqlGR12kjQLZV6xC/tJHpq3BuwWZnnRFc/X6pwOIh
         fvDhLrsCAvBU9wxn19SzO6GejPbvDoTF0Xu/GGfadBamSlL+xKQFMt+n0UGOfm9MlYHU
         vVhQXUI7YYQhRIAzgWs8SDYnIG6N6Hg1n66L6c9L+MRVtwy4iyGfdN7hWNjrivu+LLOV
         P7ENnUt0Zj0S9Fp90mh/0Wuz+iV1/DZImZm6s86dZp/qPUDTkzaSNZBLaLInNVjOGVz8
         KsczA1d2s5mg71EyS080W/u+Qs6OeHfVzVhy585jxwPP4F+by3YKw/5qEdZi51YiGuS2
         RkgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NbJET6KxkAXnaJPsRNK+gXgAfNUd5YHwy/v7Bw6FEBY=;
        fh=7bwWSC4wo//SNCFkq7qpunPY6LAJSkK1wOJFOJWDqEw=;
        b=D8iWPqzjHFpukN6X+M1g/A/u9mbgm2HndCCN0g3/ldn8iZk1N/eHF1ICGBV45Ww4OV
         LbTkmb+/Jp7Col7VCyF+zwEGGhvWBozqN7kq4P/0WP3a7blzOIafuN5kJQygR+aUR5za
         RhKLJdYyx3pfqu7Ykp7DJjC8uwbZz0Mmgock959PqRlgvHqdPlka5T1LiajLTDqHglin
         B0e08Ro9zBXG45dpBgxvyromxhd4VJbhL/kwO/NzzIMWjHiKXUtBy6SDXvQ8mIYTSUGT
         8r/IHiydeydnXNCohhHr4YDUjpcMxnn68CVvlcoRWNq4cGN80Q5t4sBkF8u0l3QW0f4s
         brZw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1772118719; x=1772723519; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NbJET6KxkAXnaJPsRNK+gXgAfNUd5YHwy/v7Bw6FEBY=;
        b=Xs4qOZM2Ax2hHJZ5a6lXAaVtxzgBYKzbhar2EmUBtvAz8bmekiBRE6kMlR3uSWDkER
         +htrEv0lqIAm8cD+1u1l9JAJtNh0jxadMUQI2Fj5YtrJzyF6xbXrD77lt6aYPLyw256k
         lALqs8J2mEfRe8YJno4uzB2Rl2j+opxCU089Y=
X-Forwarded-Encrypted: i=1; AJvYcCU87WpjsTSGPdD2fep6sdSMhi/3nPDHLD78w6KAfq+B5Ou0BbET0oM8YPAqHthUEbwxxqEHgpw=@vger.kernel.org
X-Received: by 2002:a17:90b:17c8:b0:349:9d63:8511 with SMTP id 98e67ed59e1d1-358ae8d5ac1mr15851878a91.25.1772118719455;
        Thu, 26 Feb 2026 07:11:59 -0800 (PST)
X-Received: by 2002:a17:90b:17c8:b0:349:9d63:8511 with SMTP id
 98e67ed59e1d1-358ae8d5ac1mr15851856a91.25.1772118718922; Thu, 26 Feb 2026
 07:11:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223191154.2800616-1-kiran.kella@broadcom.com>
 <20260223191154.2800616-2-kiran.kella@broadcom.com> <0a850f65-be67-4a66-941f-17d8440e987b@gmail.com>
 <CAPHeo3eJRYc503Ta24h9r+Uu1cGqb1dCfmnxuZQ4MJLCTFd9Lw@mail.gmail.com> <aed01ac3-a393-486f-9fee-09928fea9a94@gmail.com>
In-Reply-To: <aed01ac3-a393-486f-9fee-09928fea9a94@gmail.com>
From: Kiran Kella <kiran.kella@broadcom.com>
Date: Thu, 26 Feb 2026 20:41:20 +0530
X-Gm-Features: AaiRm53rO7ITBP5JMVQy16JE7syQMnZbBMripOsAUWzzka_WcVUpPNBSdhG2tOk
Message-ID: <CAPHeo3fo2KBv+5K+Jmz2cNALf8ohDa_bah8AScsTgvyhkczrdg@mail.gmail.com>
Subject: Re: [net-next, v2 1/2] psp: Support for transmit on logical device
 when the underlying transport device supports PSP.
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	willemb@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch, 
	horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jayakrishnan.udayavarma@broadcom.com, ajit.khaparde@broadcom.com, 
	akhilesh.samineni@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261395-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kiran.kella@broadcom.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[broadcom.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: CC5A41A8A04
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 7:41=E2=80=AFPM Daniel Zahka <daniel.zahka@gmail.co=
m> wrote:
>
>
>
> On 2/26/26 6:46 AM, Kiran Kella wrote:
> > On Wed, Feb 25, 2026 at 2:28=E2=80=AFAM Daniel Zahka <daniel.zahka@gmai=
l.com> wrote:
> >> The lack of support for netns is a bit of a gap for this feature. It m=
ay
> >> make sense to see if what was posted in
> >> https://lore.kernel.org/netdev/20260224002410.1553838-1-weibunny@fb.co=
m/
> >> is sufficient for your use case, as it handles cases where upper devic=
es
> >> are in a different netns from psd->main_netdev.
> > Thanks. Went through the changes in
> > https://lore.kernel.org/netdev/20260224002410.1553838-1-weibunny@fb.com=
/
> > It is sufficient for my use case too, although it specifically
> > addresses the cross-netns virtual devices use case.
> > But the same net-ns stacked devices like VLANs can be handled with
> > this patch implicitly, without user intervention through dev-assoc.
> > I think both approaches can co-exist without conflict.
>
> I agree they can co-exist, and automatically propagating psp devices is
> useful. I was just pointing out that support for upper devices will
> eventually need to deal with netns, because when I looked at this patch
> things like ipvlan and macvlan came to mind.

Ack

