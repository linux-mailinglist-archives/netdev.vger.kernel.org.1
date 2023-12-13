Return-Path: <netdev+bounces-57062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D486811EEA
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 20:30:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27D791F215C7
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 19:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1280968273;
	Wed, 13 Dec 2023 19:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jA2GCk2F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FAB49C
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 11:30:09 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-548ae9a5eeaso2029a12.1
        for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 11:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702495807; x=1703100607; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7CTocj9fFaSisGl60m+82/KbfdQizBumOLPEluKuvjI=;
        b=jA2GCk2FomwaZ516h7AkwEfMjm+BWWucFpEP4ytUM4sgz0cH8DNVWGJIh6k0Q/feo/
         a3sNATb3uWYB4bmrSDTl1y51ovVzmCDfSjjxi7G6Z5tjdP8ZoektW2t+bL4oJLmLegpn
         d8FCo965SR4bsDfaref38QMMlCl1pEZSdenKnfX8qDrkOR7UrVZgwdbUufpe5Ji5RpnR
         ogY1q9iZEHIw5PhP8BQDYQt8+PUwbAJ8fHi65xvS1AJI5bG5va00FYPmEdaj6iQy6QdE
         ngJs7XIWVb2k/42jCt5L+iYiQYGv/yC5wR5S5jdW5CDIsEEh1Xcz3uqsp2TaXg0Un+Dn
         ukog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702495807; x=1703100607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7CTocj9fFaSisGl60m+82/KbfdQizBumOLPEluKuvjI=;
        b=BnGA2xtaA1WWL1Nzg03v7YaDzXKsrGGxSXMlrbMzoBPH3y20OEL3qenhCtlrA1FKIV
         YcpqI+oOEaEQX0f9BW95uCq4LDuXGWg4ufvZ63c/i+JsIi/YYe1dzGxj/hoGEiU0NfVk
         nz3LXZxfr6JMdb/e9/H1sJZJNljrPesgWsRkbbwP2cLOOV4EzdRv2B8yuCud8o7ZCI7t
         M2fPR6GXWQw6fKB76H2HPNOCI+3cdKNpFp9VNZdBrNRYtV6mxk20uhzMFRX5IJGcnuUg
         Hr1f5Ayx/Dv3MEIgXtK6wCYylcapNAs5o0BEXXmO2FfD7tAk0mJzu2yJVO1iymWMKSIw
         HbrQ==
X-Gm-Message-State: AOJu0YyrxVmUwy1ChRN9kjq+pgqDhyAjg+A/hKoI7JtJ3BYWTB2FY/wL
	M2WuTWbFBJOdVBl6CGktTCQZbfvbfx2TTDElGZ6hlg==
X-Google-Smtp-Source: AGHT+IEKk9uU9dVpCiAanMCi8gZqQKW7nv8O4wWuE61FM+ADuAPLR5+aFXn7NqcS0bFUuVBarvQo01zrCwv2jdZsKkY=
X-Received: by 2002:a50:bb26:0:b0:552:365c:6962 with SMTP id
 y35-20020a50bb26000000b00552365c6962mr75055ede.2.1702495807432; Wed, 13 Dec
 2023 11:30:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231208182049.33775-1-dipiets@amazon.com> <0d30d5a41d3ac990573016308aaeacb40a9dc79f.camel@redhat.com>
 <CANn89i+98ifRj9SJQbK+QJrCde2UJvWr1h31gAZSuxt4i_U=iw@mail.gmail.com> <20231213110008.2e723723@kernel.org>
In-Reply-To: <20231213110008.2e723723@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 13 Dec 2023 20:29:53 +0100
Message-ID: <CANn89i+0gbPkw+4GdcBfi6TWkypTtf1gBJyBSoH+=q8pdS_ngg@mail.gmail.com>
Subject: Re: [PATCH] tcp: disable tcp_autocorking for socket when TCP_NODELAY
 flag is set
To: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, Salvatore Dipietro <dipiets@amazon.com>, davem@davemloft.net, 
	dsahern@kernel.org, netdev@vger.kernel.org, blakgeof@amazon.com, 
	alisaidi@amazon.com, benh@amazon.com, dipietro.salvatore@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 8:00=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 13 Dec 2023 15:10:00 +0100 Eric Dumazet wrote:
> > > It looks like the above disables autocorking even after the userspace
> > > sets TCP_CORK. Am I reading it correctly?Sal Is that expected?
> >
> > Yes, it seems the patch went too far.
>
> Reverted to avoid it getting to Linus in the meantime, FWIW.

Thanks Jakub.

