Return-Path: <netdev+bounces-14568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACDBC7426F4
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 15:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F5CC280CB0
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 13:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A0A2584;
	Thu, 29 Jun 2023 13:05:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739D32565
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 13:05:33 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E44230C4
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 06:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688043929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RuqwY8/gS82e1/jf17RcGvVlu8cmWt3V0VXO9BfoCxE=;
	b=fm7EpfTM65wEonesNZIlkTPM+NOzYSnjhT5WUDt0cJeOegUDP9ZJCYkEz3HCllyP428MjK
	pknKoFEoO5AboHDH4jkmcimKEqUBoRqxqhXzpCONyb88tspfxZhaFuZE8aYf7FkRsuWJQJ
	CO0QktagW7wpqSzBNEImTTLjdHBtzjo=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-A67FwyEtMC6g0PqpNcSWJg-1; Thu, 29 Jun 2023 09:05:27 -0400
X-MC-Unique: A67FwyEtMC6g0PqpNcSWJg-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-76716078e78so14203085a.1
        for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 06:05:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688043927; x=1690635927;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RuqwY8/gS82e1/jf17RcGvVlu8cmWt3V0VXO9BfoCxE=;
        b=K6az2uHhC8fqJjz0yvfbuex0rG35haPakYVxLPAJqqC3oZInaURhwj2cexzo5tH030
         O777cwDHbGzgUHVwcc4hM+qiFaIQNQGYnQa5H4CZltWU9I16hVozH/OQIJ8qnNEXbGPH
         BQa45bxi7lqESIRXm9Rc/hT1ZfkfXniHXOph8eMpqZTHymRXbtG01km3ueL+j2J5uHKr
         tnRvyExNrY6v0LKt8YTRaaBN/mOOL2vDneHsjPZeyr8vBpmRM2zpT1urEGa8xwvrm64P
         4C6TdCYOE+JRStGgNR+V/SIk502+olzdlWpItwNcWH+T39K+QOo7EDc6ZcbwXtcOvy2j
         vQsg==
X-Gm-Message-State: AC+VfDy57OGfkzJNnOC3CaKJTY5n+cohuQJh7Nv4CrqknOjeSDcKHQZ1
	YlPzWixf1sRFKE8lrJilKRMDOp4nDcdVzCFAUqf5ZlocS3RdGNcnTKA4SwusJRfJpcAg/C8ZTv0
	WilSCdOUchKWJD3i4
X-Received: by 2002:a05:620a:3955:b0:75b:23a1:82a4 with SMTP id qs21-20020a05620a395500b0075b23a182a4mr3119017qkn.5.1688043927396;
        Thu, 29 Jun 2023 06:05:27 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ53zxq1krSKA1rYCWbi9iXjsVV1RVgAxxlVVAGIM7eh3ieMXpDfidkUyqa/sPpBWwmlyENA3A==
X-Received: by 2002:a05:620a:3955:b0:75b:23a1:82a4 with SMTP id qs21-20020a05620a395500b0075b23a182a4mr3118995qkn.5.1688043927136;
        Thu, 29 Jun 2023 06:05:27 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-231-196.dyn.eolo.it. [146.241.231.196])
        by smtp.gmail.com with ESMTPSA id x13-20020ae9e90d000000b00767291640e8sm1408731qkf.90.2023.06.29.06.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 06:05:26 -0700 (PDT)
Message-ID: <aa84a2f559a246b82779198d3ca60205691baa94.camel@redhat.com>
Subject: Re: [PATCH] Add MODULE_FIRMWARE() for FIRMWARE_TG357766.
From: Paolo Abeni <pabeni@redhat.com>
To: Michael Chan <michael.chan@broadcom.com>, Tobias Heider <me@tobhe.de>
Cc: Siva Reddy Kallam <siva.kallam@broadcom.com>, Prashant Sreedharan
	 <prashant@broadcom.com>, Michael Chan <mchan@broadcom.com>, 
	netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	linux-kernel@vger.kernel.org
Date: Thu, 29 Jun 2023 15:05:23 +0200
In-Reply-To: <CACKFLinEbG_VVcMTPVuHeoQ6OLtPRaG7q2U5rvqPqdvk7T2HwA@mail.gmail.com>
References: <ZJt7LKzjdz8+dClx@tobhe.de>
	 <CACKFLinEbG_VVcMTPVuHeoQ6OLtPRaG7q2U5rvqPqdvk7T2HwA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 2023-06-27 at 18:31 -0700, Michael Chan wrote:
> On Tue, Jun 27, 2023 at 5:13=E2=80=AFPM Tobias Heider <me@tobhe.de> wrote=
:
> >=20
> > Fixes a bug where on the M1 mac mini initramfs-tools fails to
> > include the necessary firmware into the initrd.
> >=20
> > Signed-off-by: Tobias Heider <me@tobhe.de>
>=20
> Thanks.
> Reviewed-by: Michael Chan <michael.chan@broadcom.com>

This is a borderline situation, but ...=C2=A0

Is there a suitable 'Fixes:' tag we can add here?

Thanks!

Paolo


