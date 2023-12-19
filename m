Return-Path: <netdev+bounces-58865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9849818674
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 12:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66EBA1F2221B
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 11:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936A3154BF;
	Tue, 19 Dec 2023 11:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WJ8sS9LV"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479FA18623
	for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 11:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702985643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rQTceY2nO1i2VDKrUxTBKlvQFwYdOuT3KwV13QDDYdc=;
	b=WJ8sS9LVIddCg+LRhzkacOQOT5fZ8ueMbvwhQzF4xrvZ9gw3aVW0n386rSeVhBZLcv75Nr
	V3lzZ9iV2w/edJR/xxAbhsnpDyZnRuYskABXraZ4Qjesrmz7+tE7zbETF1yj7JildOh5EE
	87WM1w22qPIRVWqX2W0E2lxaS9SLYxM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-lv0Ta_uxN_GN4K6PIPm2yg-1; Tue, 19 Dec 2023 06:34:02 -0500
X-MC-Unique: lv0Ta_uxN_GN4K6PIPm2yg-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a236e1a1720so9713866b.0
        for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 03:34:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702985640; x=1703590440;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rQTceY2nO1i2VDKrUxTBKlvQFwYdOuT3KwV13QDDYdc=;
        b=JiOfvTnuvzkJhbp71zKNJYuwpIPjLOIP/1pP9AeMEe6lioQ+0WQamUYqPPEh5MViYo
         8gxV/+wfKrYlFZxJZ5Mu64dH2TTtWXWZI08d8vaIFhNB+knNffrD9EWZcalexNy0wfeF
         CQY0+CTVT8t4/3U0qxLy68NxF68BwOT97vRI+/hHi8zLSBmi3wqCLRcTTZ9KirPUT4I8
         ovz6J5jBBhtlAfELIT0pTHCHxJaNY+pfuwohvU1H5SRFJ2EN+SFir1ZKN9g0Mgx5W+0x
         zslu56c4P48Ut3sKhtf/NojTMNgM7N/B6uh5SbuxFXXR+NNC/oZrjlMdQVoWqUB0eoWX
         NVYg==
X-Gm-Message-State: AOJu0YwCrxAKN+k0dwulQaWs5JOSAYfGFM++C1kaWlvTXFTQXQCvyjP7
	Pxyx7klwJ8+Pyjue4U+1EZxQdNHYBwvDgSPlIHC51VtZ23Evg1z4CyGca+3jIxW0TRoyjxVMYkz
	e82t0eBei8j5k34XiqcSPFvHe
X-Received: by 2002:a17:907:a70f:b0:a00:211c:9a9a with SMTP id vw15-20020a170907a70f00b00a00211c9a9amr20062527ejc.5.1702985640638;
        Tue, 19 Dec 2023 03:34:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHZNXgVy86W8qiS+vmxrJAs3gGruL7yeaLLuHdTSOv2hypeiPLYjwDCjrYQk3fjloj34YzECw==
X-Received: by 2002:a17:907:a70f:b0:a00:211c:9a9a with SMTP id vw15-20020a170907a70f00b00a00211c9a9amr20062514ejc.5.1702985640258;
        Tue, 19 Dec 2023 03:34:00 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-246-245.dyn.eolo.it. [146.241.246.245])
        by smtp.gmail.com with ESMTPSA id fw10-20020a170906c94a00b00a2349073119sm3008134ejb.134.2023.12.19.03.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 03:33:59 -0800 (PST)
Message-ID: <96daa3fe4db8169be920d40770d3b92a30e7f200.camel@redhat.com>
Subject: Re: [PATCH] RFC: net: ipconfig: temporarily bring interface down
 when changing MTU.
From: Paolo Abeni <pabeni@redhat.com>
To: Graeme Smecher <gsmecher@threespeedlogic.com>, David Ahern
	 <dsahern@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, claudiu.beznea@tuxon.dev, 
 nicolas.ferre@microchip.com, mdf@kernel.org
Date: Tue, 19 Dec 2023 12:33:58 +0100
In-Reply-To: <20231216010431.84776-1-gsmecher@threespeedlogic.com>
References: <58519bfa-260c-4745-a145-fdca89b4e9d1@kernel.org>
	 <20231216010431.84776-1-gsmecher@threespeedlogic.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2023-12-15 at 17:04 -0800, Graeme Smecher wrote:
> Several network drivers (sh_eth, macb_main, nixge, sundance) only allow
> the MTU to be changed when the interface is down, because their buffer
> allocations are performed during ndo_open() and calculated using a
> specific MTU.

I think we have to address that in the relevant device drivers. This
could cause significant regressions: changing the MTU may causes the
device to stay down afterwards - if the device fails to re-initialize.

That even for drivers that before failed gracefully.

Instead, at the device level, the driver could allocate in advance the
new ring, and restore the previous one if the allocation fails, always
leaving the device in a consistent status.

Cheers,

Paolo


