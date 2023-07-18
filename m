Return-Path: <netdev+bounces-18553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C953757985
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 12:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5737C281463
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 10:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E73C142;
	Tue, 18 Jul 2023 10:47:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878E65671
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 10:47:57 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32F8B0
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 03:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689677275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Eu4TsjBdJCp0UdHhQZC9rVvZf27i7sYMjj86lM+sqQQ=;
	b=KlETqosPiL3YArMHvN99jcZwciNpUxnb1a5roDjs5im4VK7JeRY+KNX4RB+ZlS2gbes0L5
	hGObG/qSmAajnOgQZETbUAfIcDKcbOY3MDmHSDvyQmzaFBleE+SoN66tw0BBjAMNYEicFJ
	El6FZFRDRsu/oz8zNbRDEJ4NsOKFAYY=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-26AScseNN3e3Gxiux4aPpA-1; Tue, 18 Jul 2023 06:47:53 -0400
X-MC-Unique: 26AScseNN3e3Gxiux4aPpA-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-767ca6391aeso137700885a.1
        for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 03:47:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689677273; x=1692269273;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Eu4TsjBdJCp0UdHhQZC9rVvZf27i7sYMjj86lM+sqQQ=;
        b=ddQx3YLrLFU6yzruT0rrFt2RI0cOeQvLLliFUNzM+2HjGKnav0ihhZh7hRcYG4Rljp
         4GqTswiPUwoQRGEEFpljLRtm/hXZ3S3t1+1dJ5GvruA3s4ODfPX4/JA/1UHq5QR2h39s
         /6vlVuU0q702kTMBbJsm0Mva8KcO7CJunN3F7pxnW9azewqLwulzmQ3SkA+c2MP05i9U
         TulDd20xYzzteVwSjqGQ3CRZ8H37eWq/K/HJCkZ0TF45igrVeE6lhgZIFCGLhlSW89/i
         odRbePHJhG0+sr3yY+AwEeHuUEQEIAY5Et9IvGRMBdSwHH22+xwpeq5oohN5GoGfL28R
         ZMog==
X-Gm-Message-State: ABy/qLaI+9hnHv1e5cDXunhnsfKk1el11Qz2wATKRIiUJqcauzWE5jYu
	2okYeuM0jA5VVGUAfsybNzz1KAkSDcihtrQhwRgjlX1CKXJJqOAn6TJFplN42IeJtka6PiOUuKg
	oYE9qXD+S5jmDL/bCrmVdOpt8
X-Received: by 2002:a05:6214:d0b:b0:62d:fc81:44fc with SMTP id 11-20020a0562140d0b00b0062dfc8144fcmr10938627qvh.6.1689677273200;
        Tue, 18 Jul 2023 03:47:53 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGGXdwqnc3UFtmDdUhsu9zMOSwMCnzF5II7I+sJYtaYvWigALv+bDt0JyKBDrAYtUk145rwrQ==
X-Received: by 2002:a05:6214:d0b:b0:62d:fc81:44fc with SMTP id 11-20020a0562140d0b00b0062dfc8144fcmr10938613qvh.6.1689677272916;
        Tue, 18 Jul 2023 03:47:52 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-226-170.dyn.eolo.it. [146.241.226.170])
        by smtp.gmail.com with ESMTPSA id u2-20020a0c8dc2000000b0062de1ed9d15sm616378qvb.102.2023.07.18.03.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 03:47:52 -0700 (PDT)
Message-ID: <b3faaa6387edd97c93862cd6838808d051e338e6.camel@redhat.com>
Subject: Re: [PATCH] net: delete "<< 1U" cargo-culting
From: Paolo Abeni <pabeni@redhat.com>
To: Alexey Dobriyan <adobriyan@gmail.com>, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org
Cc: netdev@vger.kernel.org
Date: Tue, 18 Jul 2023 12:47:50 +0200
In-Reply-To: <7b6fdc07-fd7c-48eb-ad17-cc5e436c065b@p183>
References: <7b6fdc07-fd7c-48eb-ad17-cc5e436c065b@p183>
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
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, 2023-07-15 at 13:19 +0300, Alexey Dobriyan wrote:
> 6.5.7 =C2=A73 "Bitwise shift operators" clearly states that
>=20
>         The type of the result is that of the promoted left operand
>=20
> All those integer constant suffixes in the right operand are pointless,
> delete them.

Indeed. Still this patch is quite invasive and the net benefit looks
quite marginal - if any at all.

Older compiler could adhere to the standard less strictly or macro
expansion - when the left '<<' operand is a macro argument - could be
tricky.

I think we are better of not applying this.

Cheers,

Paolo



