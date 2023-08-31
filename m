Return-Path: <netdev+bounces-31523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CD978E87E
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 10:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B31E28141D
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 08:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6375C79C8;
	Thu, 31 Aug 2023 08:40:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5660233C8
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 08:40:52 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB1310C6
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 01:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1693471155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4U5OavrGGzIX2SQggveJnFodx3l4/uKCAkVfx0r7+WA=;
	b=PG1GuOcOUQjuDo1iVEs8jVGEADNfMRqGoYDbHSLNJWzya2K1irQks0IpiW1sJ4zTwh4RzT
	0yafCKFruiGSSwHt4P3KDutLLQmQ9qGj7KCyvGQ4LM2RoTzyzr4tUvTIAXcTgtQr2n0Hzf
	+dIEz0FhviX/rBSgwrCLdUd7R7zCZJg=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-a10u9IBMNNSa-aTwcafMUw-1; Thu, 31 Aug 2023 04:39:14 -0400
X-MC-Unique: a10u9IBMNNSa-aTwcafMUw-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-51e3bb0aeedso140816a12.0
        for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 01:39:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693471153; x=1694075953;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4U5OavrGGzIX2SQggveJnFodx3l4/uKCAkVfx0r7+WA=;
        b=PXysQ9ilLrrkF4JhqEvqYqPiuufu7vqOQWu0+vLsWFrCV9NBQv0ffFlT4URXDVbHzx
         4u6T+KwT4lcb4A6K3pgdZODXrvkoSSTYp1LDi+A0w1R+6LpJ5XRhGAR5P3lEOM4qYqB5
         sKOvXelypVL7he66M6khna1lySIJ6bJl/Pn8Gdx8Krsie6b6MdPKMOAMGuism+oxywxK
         IVHXBPsM1d8mJtdgvPL4Ps2vmQKxtfiiibtpXSr9Qk4x2SNvQoBi2VaPMo7fFv8H3TAT
         yFb5Slter32t0DtZuyewn0+L3lpxwocruxwWyLM+EWL/OlyoDML6yTledYy4j9hCfyfc
         yF1w==
X-Gm-Message-State: AOJu0YyeHk8K9RVNtIfcPrUznD/vV0qWctBS7JasO0sZZqjqExZ51BWW
	kAQvNxoNZD8ulCwaKW4hpcqwd2HkAd9QXI72z3PCyPLjXXfwnUbPfIG6y5B+LtQgQP1u4Lsz6nL
	vudGkNPiCIlYuKgIK
X-Received: by 2002:a17:906:1011:b0:9a1:aea8:cb5a with SMTP id 17-20020a170906101100b009a1aea8cb5amr3100544ejm.1.1693471153153;
        Thu, 31 Aug 2023 01:39:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQznoCZsudp4h/5hjJwGDh0u7T82ZLRGV1HdyxcWpDsY7QFEeILa81CM1hRRlYaWdPtDLTJA==
X-Received: by 2002:a17:906:1011:b0:9a1:aea8:cb5a with SMTP id 17-20020a170906101100b009a1aea8cb5amr3100525ejm.1.1693471152865;
        Thu, 31 Aug 2023 01:39:12 -0700 (PDT)
Received: from gerbillo.redhat.com (host-87-20-178-126.retail.telecomitalia.it. [87.20.178.126])
        by smtp.gmail.com with ESMTPSA id s19-20020a170906455300b0098e0a937a6asm502302ejq.69.2023.08.31.01.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 01:39:12 -0700 (PDT)
Message-ID: <d672e49458e257516d66213b83aeaa686fe66ea1.camel@redhat.com>
Subject: Re: [PATCH net] virtio: kdoc for struct virtio_pci_modern_device
From: Paolo Abeni <pabeni@redhat.com>
To: Shannon Nelson <shannon.nelson@amd.com>, jasowang@redhat.com, 
 mst@redhat.com, virtualization@lists.linux-foundation.org,
 brett.creeley@amd.com,  netdev@vger.kernel.org
Cc: simon.horman@corigine.com, drivers@pensando.io
Date: Thu, 31 Aug 2023 10:39:11 +0200
In-Reply-To: <20230828213403.45490-1-shannon.nelson@amd.com>
References: <20230828213403.45490-1-shannon.nelson@amd.com>
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
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On Mon, 2023-08-28 at 14:34 -0700, Shannon Nelson wrote:
> Finally following up to Simon's suggestion for some kdoc attention
> on struct virtio_pci_modern_device.
>=20
> Link: https://lore.kernel.org/netdev/ZE%2FQS0lnUvxFacjf@corigine.com/
> Cc: Simon Horman <simon.horman@corigine.com>
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>

IMHO this is net-next material and net-next is closed, so please repost
this with a proper tag when net-next reopens in ~2w.

Thanks,

Paolo


