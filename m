Return-Path: <netdev+bounces-33076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07AA179CA7B
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 10:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF4272811AF
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 08:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E348F5A;
	Tue, 12 Sep 2023 08:45:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4674315AE
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 08:45:28 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9E5AC1736
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 01:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694508326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3hUC4x3FXZvTagHd2cD4t3OZmFD4EPm/rOhyiGmvo8w=;
	b=WrJ/Y6QgUDvKbU/AYHnWU2v0sRosX9XKfH5wsqqzQ9SmPY99v6zzAleQlFO/Z/S3SneFiK
	qxkA1SoCP6vm9vsJuONRGGXj+GePoZf0DYxs4FqM5yQONj6PENxVCGf4cQ2UWyLN3Yn6hp
	um2ryHmERIU78O911yEhLXWxl1ScZRw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-oZ-bZafMONy-DszK91KYpw-1; Tue, 12 Sep 2023 04:45:25 -0400
X-MC-Unique: oZ-bZafMONy-DszK91KYpw-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9a9cd336c9cso133946066b.1
        for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 01:45:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694508324; x=1695113124;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3hUC4x3FXZvTagHd2cD4t3OZmFD4EPm/rOhyiGmvo8w=;
        b=EztXReJOs3rHffc1KHpYP3bxSCOQjzSY0lG7IhumUl/9wADhHLz59Ze5WzxDLyH/Lj
         1NsK+EgmCqAEIpbbCgwa+bD8x1hj8SX79Hjh4FNBOBlk/wrX4vCAMswOQShOlWbsnpYR
         J//q5F8gDvc7yszbWx2b0iEq32Dn5xEX3MQE0l93zh1w4saMLaeEx8L554arbf3Vl2Jl
         Jy161mfbOD4weOP42cxEtBs67eO3JDzVdG3CD1ymjz9exzhGV/UvmRLp80LCn5uOTASG
         tWmskzuohCvZ0lqezdEqZmBN/0PGi6FDCL+t01y0h+UGfOy05TyGUppIQVmfeFvOwC+S
         FYng==
X-Gm-Message-State: AOJu0Yxwz5jpd5lIQCNSxIjR287nhRMfTiLZ95zQix44VxR+t9qGlqPh
	yxLVBCdhQ9YLdT0ln9kNk3v76Bak2qdpqdrOhiB99Osx5HWKedMU1rc2OJgAt3+YNzu703dI4NN
	Vbfc4/qOrFKdjNHVE
X-Received: by 2002:a17:906:254:b0:9a5:a701:2b94 with SMTP id 20-20020a170906025400b009a5a7012b94mr9196363ejl.7.1694508323972;
        Tue, 12 Sep 2023 01:45:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpiSb88bPEZUnnVfXGKy7ahcM0UPN8GF+UlMWw3spQWZk++q+dCMlUOm8PacoxmU0GsjVmFg==
X-Received: by 2002:a17:906:254:b0:9a5:a701:2b94 with SMTP id 20-20020a170906025400b009a5a7012b94mr9196343ejl.7.1694508323670;
        Tue, 12 Sep 2023 01:45:23 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-249-231.dyn.eolo.it. [146.241.249.231])
        by smtp.gmail.com with ESMTPSA id y22-20020a170906449600b0099bc8db97bcsm6473980ejo.131.2023.09.12.01.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 01:45:23 -0700 (PDT)
Message-ID: <2c532d4594ca0cacdc0cfc5d1f5d55d5d758dc1b.camel@redhat.com>
Subject: Re: [net PATCH] octeon_ep: fix tx dma unmap len values in SG
From: Paolo Abeni <pabeni@redhat.com>
To: Shinas Rasheed <srasheed@marvell.com>, horms@kernel.org
Cc: aayarekar@marvell.com, davem@davemloft.net, edumazet@google.com, 
 egallen@redhat.com, hgani@marvell.com, kuba@kernel.org, 
 linux-kernel@vger.kernel.org, mschmidt@redhat.com, netdev@vger.kernel.org, 
 sburla@marvell.com, sedara@marvell.com, vburru@marvell.com,
 vimleshk@marvell.com
Date: Tue, 12 Sep 2023 10:45:21 +0200
In-Reply-To: <20230912070400.2136431-1-srasheed@marvell.com>
References: <20230911180113.GA113013@kernel.org>
	 <20230912070400.2136431-1-srasheed@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2023-09-12 at 00:04 -0700, Shinas Rasheed wrote:
> This change is required in octep_iq_process_completions, as given in the =
patch,
> since the scatter gather pointer lengths arrive as big-endian in hardware=
.

I guess Simon intended asking about octep_iq_free_pending(), and AFAICT
your reply confirm that the change is required there, too.

Additionally the changelog really need to be expanded. I don't
understand how this change relates to endianess: if the ring format is
big endian I expect some be16_to_cpu(len) instead of complement-to-4 of
indexes.

Please clarify and expand the changelog, thanks!

Paolo


