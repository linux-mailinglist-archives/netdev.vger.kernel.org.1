Return-Path: <netdev+bounces-44184-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5E37D6D99
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 15:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2107B21039
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 13:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1181C28DA5;
	Wed, 25 Oct 2023 13:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QZTn50+o"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9180226E08
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 13:49:04 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C2A138
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 06:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698241742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C+FBy7j+UscI5hRgAfAFa6mgEZdbgMkSmr4F2qKqMP0=;
	b=QZTn50+ok8ywzFPF0pR6NgPgqbYP0Q8f050uk/QJEHs8jfpbYFq7cB7Mn+NsQkY7KAi7IF
	uEJIqzz4R9d4LVw5ERy7ozCeSMR1XaB1/I8xStsdY0hHd8prin/WVQE0rJA4m+L8XINsFh
	xeP+deP3ZjdbS/OoNelTV+yErg3xS0c=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-wASTvVRjNlGQhRsAalMhGQ-1; Wed, 25 Oct 2023 09:48:59 -0400
X-MC-Unique: wASTvVRjNlGQhRsAalMhGQ-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-507df68e881so1218969e87.0
        for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 06:48:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698241737; x=1698846537;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C+FBy7j+UscI5hRgAfAFa6mgEZdbgMkSmr4F2qKqMP0=;
        b=QqsRz5nlOm5yua3iR1qujFJkaotBcjoWIDtwQ4tHDoQ55BDApZfWkva9GYWZ6zw3yG
         SUvwjy03EPfdo4UwM7M1TguaY+BjeC4FVbVuQsxhizXpKLjFFJEd8MSOna386n92rrkL
         JCUJDlJgrmZvcCLDWXVz61ld5G6gND+aVF0TtXJEvJ3u4y1FwxCdQZ2DVYmXsDYzJckN
         Rtdzx5ZzLXfXTtAbMJA6kW1rlSFqyhf4a0vW15p4Wi9TPBCOoGuChzITxoGiiiERN67h
         0FC+ij/zB9D1KgkaebHONZAnzsQAAqQPv4QdAr2uP6NfGKD10646us/pixnEN0pBxKeh
         sUuw==
X-Gm-Message-State: AOJu0YyXVcdb3VbvFP0+N9jetRSSy/xQHPOYOhKCT0tNDzj4wHbcMvyh
	mTD5WLl4cPoyzMJuS8XAL9ExDdXmHjUs7wxWt+0cBzCfIuT2jVGzEImrI1eeCaN/NWsqeSjbCGu
	SZjYJRxmoHkWUOIEx
X-Received: by 2002:a05:6512:3b21:b0:508:1a11:16e6 with SMTP id f33-20020a0565123b2100b005081a1116e6mr909673lfv.2.1698241737512;
        Wed, 25 Oct 2023 06:48:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGELiz73Ars3ifhTm/Nm0fTnz/Fa2njbwHuQw0/bI4RiuAtJNEZN3536/KqPyQZgv+4JK1wXA==
X-Received: by 2002:a05:6512:3b21:b0:508:1a11:16e6 with SMTP id f33-20020a0565123b2100b005081a1116e6mr909640lfv.2.1698241737075;
        Wed, 25 Oct 2023 06:48:57 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-235-10.dyn.eolo.it. [146.241.235.10])
        by smtp.gmail.com with ESMTPSA id b59-20020a509f41000000b005402b190108sm6260252edf.39.2023.10.25.06.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 06:48:56 -0700 (PDT)
Message-ID: <bfd0a37b09540fd3cf4107f9bea1b9efb70d5b33.camel@redhat.com>
Subject: Re: [PATCH net-next 1/9] mptcp: add a new sysctl for make after
 break timeout
From: Paolo Abeni <pabeni@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>, Mat Martineau <martineau@kernel.org>
Cc: Matthieu Baerts <matttbe@kernel.org>, "David S. Miller"
	 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	netdev@vger.kernel.org, mptcp@lists.linux.dev
Date: Wed, 25 Oct 2023 15:48:08 +0200
In-Reply-To: <20231024175454.11b3305b@kernel.org>
References: <20231023-send-net-next-20231023-2-v1-0-9dc60939d371@kernel.org>
	 <20231023-send-net-next-20231023-2-v1-1-9dc60939d371@kernel.org>
	 <20231024175454.11b3305b@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2023-10-24 at 17:54 -0700, Jakub Kicinski wrote:
> On Mon, 23 Oct 2023 13:44:34 -0700 Mat Martineau wrote:
> > +		.procname =3D "close_timeout",
> > +		.maxlen =3D sizeof(unsigned int),
> > +		.mode =3D 0644,
> > +		.proc_handler =3D proc_dointvec_jiffies,
>=20
> Silly question - proc_dointvec_jiffies() works fine for unsigned types?

AFAICS, yes: proc_dointvec_jiffies() internally uses
__do_proc_dointvec(), which parses the buffer to a 'long' local
variable and then do_proc_dointvec_jiffies_conv() converts it to
integer taking care of possible overflows.

Cheers,

Paolo


