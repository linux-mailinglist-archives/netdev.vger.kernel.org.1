Return-Path: <netdev+bounces-32028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E1A7921BA
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 11:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E2D2281087
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 09:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02AC79D3;
	Tue,  5 Sep 2023 09:59:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E103234
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 09:59:38 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 885C418C
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 02:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1693907976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gBZlfxKxk2LlWUUOkePqfSkX4AXTiRxfnDP4dVmsSes=;
	b=N+OEwLhSiTO2f6uUURFlCF+cqAdQMN96wUtRvo1gqgSGOuFNji2BQyV3XDGPjukj0tVcAR
	8WerztIjjhA1T/npNRu+TRY/D3O2aAOd2gj4MHmLgi3I99Zona3UrkkLx5rV3wXFiDhPXf
	uPnmEmeMp0s0hBHDYx9aFK1BimLWerY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-1xAlYgsuPkyvVWp_A0zm4w-1; Tue, 05 Sep 2023 05:59:35 -0400
X-MC-Unique: 1xAlYgsuPkyvVWp_A0zm4w-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9a21e030751so28130466b.0
        for <netdev@vger.kernel.org>; Tue, 05 Sep 2023 02:59:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693907974; x=1694512774;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gBZlfxKxk2LlWUUOkePqfSkX4AXTiRxfnDP4dVmsSes=;
        b=foLy2oOfaAEFmoP/oPv37n/lHU+dxj8Qa6RKbo8G/oS5g7nriPDJjdIJLt34ACoQiu
         g+MR/gdE6yq+XMAwZaJGlpfiPU7RgNIDshgv42W6VDTA1CI4BfcVsWl8sTmSZUZkVnUd
         /dFEt67ozTDASJ7UppfkNLuw0TR9YzC+/GORSp0XVn+YhjW5MbooY8Wp1BbpYCmfhEYt
         HaYDVNxlUhMrnmLXrLznFUBeoBoUXCXJruDP/WTHH9sONAxr5aLk6wEY0eIOMpRvf3bw
         OtPaz1oIc4EbOPocz0AG23aj4plq4IWnXWchMYce3zL0qk8PBg0ixh4/nC4/CsvT7qPQ
         q0yQ==
X-Gm-Message-State: AOJu0YyHU8z88qozp2mm7FM7PS+c7pjxtHYR6cO7qOQyZVZtnkpKObvi
	0/g+eBB4yKfjQfb7Wy2YCbcN3lqIX3VvaQs0Gqt45B3TN1ISz67cmIfM/w3E46m+T0G4KD/iBYL
	zXARGL8+UIs+gNEdx
X-Received: by 2002:a17:907:97ce:b0:9a6:5018:9a28 with SMTP id js14-20020a17090797ce00b009a650189a28mr4399995ejc.1.1693907974517;
        Tue, 05 Sep 2023 02:59:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2AD8+Sy5IvG9q1nXmdfGrdgGDhAg33NX/ajK3tvzkl8SJKP2c1kga3FsUVMVmcTRWbw1aaA==
X-Received: by 2002:a17:907:97ce:b0:9a6:5018:9a28 with SMTP id js14-20020a17090797ce00b009a650189a28mr4399980ejc.1.1693907974198;
        Tue, 05 Sep 2023 02:59:34 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-254-194.dyn.eolo.it. [146.241.254.194])
        by smtp.gmail.com with ESMTPSA id a6-20020a170906244600b0099cce6f7d50sm7463220ejb.64.2023.09.05.02.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 02:59:33 -0700 (PDT)
Message-ID: <a88c3486dafcc9e7a8cb5eecf14b6e6b93a13c65.camel@redhat.com>
Subject: Re: [PATCH v2 1/1] xfrm: Use skb_mac_header_was_set() to check for
 MAC header presence
From: Paolo Abeni <pabeni@redhat.com>
To: Marcello Sylvester Bauer <email@vger.kernel.org>, Steffen Klassert
 <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Marcello Sylvester Bauer <sylv@sylv.io>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Tue, 05 Sep 2023 11:59:32 +0200
In-Reply-To: <0490137bbc24e95eadf01bed9c31eb1d0a856a21.1693823464.git.sylv@sylv.io>
References: 
	<0490137bbc24e95eadf01bed9c31eb1d0a856a21.1693823464.git.sylv@sylv.io>
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
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 2023-09-04 at 12:32 +0200, Marcello Sylvester Bauer wrote:
> From: Marcello Sylvester Bauer <sylv@sylv.io>
>=20
> Add skb_mac_header_was_set() in xfrm4_remove_tunnel_encap() and
> xfrm6_remove_tunnel_encap() to detect the presence of a MAC header.
> This change prevents a kernel page fault on a non-zero mac_len when the
> mac_header is not set.
>=20
> Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>

Please include a suitable fixes tag.

Please also include in the commit message the stacktrace:

https://lore.kernel.org/netdev/636d3434-d47a-4cd4-b3ba-7f7254317b64@sylv.io=
/

trimming the asm code and lines starting with ' ? '=20

I think the real issue could be elsewhere, we should not reach here
with mac_len > 0 && !skb_mac_header_was_set().

Could you please try the following debug patch in your setup, and see
if hints at some other relevant place?=20

Thanks,

Paolo

---
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 4174c4b82d13..38ca2c7e50ca 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -2793,6 +2793,7 @@ static inline void skb_reset_inner_headers(struct sk_=
buff *skb)
=20
 static inline void skb_reset_mac_len(struct sk_buff *skb)
 {
+	WARN_ON_ONCE(!skb_mac_header_was_set(skb));
 	skb->mac_len =3D skb->network_header - skb->mac_header;
 }
=20


