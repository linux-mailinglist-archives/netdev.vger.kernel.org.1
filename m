Return-Path: <netdev+bounces-26881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AADF57793DF
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 18:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62FFD281438
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 16:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ABE111716;
	Fri, 11 Aug 2023 15:59:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F05311708
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 15:59:07 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4863596
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 08:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691769540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k1jmRN66/IcvOZEohXuVLy80a9NStdpbaac867hlddU=;
	b=QNDZOOJ63v/PmCF4AWo43muyn8CGa83ILKbm93QLR7+2YBQlK+lnoITfZDK7pYUnTqorAb
	xQyLHX7Gm97neko7TtTILKtAjK8WDZX3YlAKRCsBWuLsuCw4yok+mF0lG0oyQSEwYq0b4c
	LXSKy5gdT2cjQ/xAgNT2Q2kE/yHCTyE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-FgzLXcGINzCZxp45-JdKKw-1; Fri, 11 Aug 2023 11:58:56 -0400
X-MC-Unique: FgzLXcGINzCZxp45-JdKKw-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-99bdee94b84so298727466b.0
        for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 08:58:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691769535; x=1692374335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k1jmRN66/IcvOZEohXuVLy80a9NStdpbaac867hlddU=;
        b=kCTp9xi39uW62PHBPvJKeUnFA5py3kRIc1aqL4GCdFtx5tkvf1G7Op9rShXUH/R8sm
         uF3CHTO7AGigUI41bHZGs9VJfIiXZHNCJ84Fs86Ee12fzlOKtC3ixBFPgqGKvXYIi+iw
         QwqASxqPLP8Qm/G6I94uLmfEJFR4cTLhD0pBu79hIOB1gtlHITi0gtXj4SzXY+lN+65B
         2ZZGfM84FQOmiHN0vpUG8l47NPiyC+LnKV0KhI96bITDc+vnZFi2YWo1Yx3bjJR/xCzK
         thWWuasS3q1W3n9taZ1piLLoB9iMHkRg6qTIOwnv2tDIQtXBzC0yrt9VM9UIzdmOtV+N
         c8Ew==
X-Gm-Message-State: AOJu0Yzk8q9mb5OWEmPZHMpmlVQmvKZEdpbe7mISQ0KfH24ZVtoRgzZS
	+jWdvgTzWcNdUQzu7NTHTImT6n99V9VDV46ogKQMZ3Wn+fsm3EUPV33AlZyb+9zKY4OmDlAq5cV
	oHou1PFuzm63AdMz5zdbY2knh1nVrghch
X-Received: by 2002:a17:907:1c95:b0:98d:f2c9:a1eb with SMTP id nb21-20020a1709071c9500b0098df2c9a1ebmr7721898ejc.24.1691769535656;
        Fri, 11 Aug 2023 08:58:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGeajuV9Adg7B+eSsS9b3BmzIeUp+7JylgIT98tY0PGwZoboRqBb+7df9+h0r3PSlvIX8n36N+nVIP0KpRgeIM=
X-Received: by 2002:a17:907:1c95:b0:98d:f2c9:a1eb with SMTP id
 nb21-20020a1709071c9500b0098df2c9a1ebmr7721881ejc.24.1691769535335; Fri, 11
 Aug 2023 08:58:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230810150114.107765-1-mschmidt@redhat.com> <20230810150114.107765-3-mschmidt@redhat.com>
 <ZNUGu74owyfsAbEW@vergenet.net>
In-Reply-To: <ZNUGu74owyfsAbEW@vergenet.net>
From: Michal Schmidt <mschmidt@redhat.com>
Date: Fri, 11 Aug 2023 17:58:44 +0200
Message-ID: <CADEbmW2tmCd5K852-z7VQfMmp=ae06_gOE66uduhnV3zbA4RcA@mail.gmail.com>
Subject: Re: [PATCH net 2/4] octeon_ep: cancel tx_timeout_task later in remove sequence
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Veerasenareddy Burru <vburru@marvell.com>, 
	Sathesh Edara <sedara@marvell.com>, "David S. Miller" <davem@davemloft.net>, 
	Abhijit Ayarekar <aayarekar@marvell.com>, Satananda Burla <sburla@marvell.com>, 
	Vimlesh Kumar <vimleshk@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 10, 2023 at 5:48=E2=80=AFPM Simon Horman <horms@kernel.org> wro=
te:
>
> On Thu, Aug 10, 2023 at 05:01:12PM +0200, Michal Schmidt wrote:
> > tx_timeout_task is canceled too early when removing the driver. Nothing
>
> nit: canceled -> cancelled
>
>      also elsewhere in this patchset
>
>      ./checkpatch.pl --codespell is your friend here
>
> ...

Hi Simon,
thank you for the review.

I think both spellings are valid.
https://www.grammarly.com/blog/canceled-vs-cancelled/

Do you want me to resend the patchset for this?

Michal


