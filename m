Return-Path: <netdev+bounces-39628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE397C02EC
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 19:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7203D1C20AEF
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 17:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C814225A6;
	Tue, 10 Oct 2023 17:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y7SXQBs9"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D904225A0
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 17:44:24 +0000 (UTC)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471A494
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 10:44:21 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-536ef8a7dcdso1479a12.0
        for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 10:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696959860; x=1697564660; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a0sjHqCd6/2URrAs/VHPqpzV3e9pn6q6U4Y6lheFUoY=;
        b=Y7SXQBs90m2GW5h6pSaFTXk9k9bFP0aBP4UPg+jrwq/pTPloaT/W5idgn9aD9yB2h6
         1oEP2oQgbc2vDnkY6oqR5ZvV7p2JDGsPm3B1VngpXSX+mbwWXkcXjHSReknQYjiLQQA0
         ZqGTWsg0Um6aUseNFc5IpWILGXP2Sj0Hkl73Ou6VA5NpDoV+rSQ/ZTgrerrBcXbenyho
         yBGY0SPt7YmI2cGcUL+tGEDvS6E8eRueN2gWlJ3NSLEKoPuYbmzqRNst2E6JnbhnZhBx
         G1s0Rbxu4+8De2LrL3Rg0unYo/2sz+inknRfmUp99S27LqU7gpPONP/tDKYB8SPbEriJ
         tXKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696959860; x=1697564660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a0sjHqCd6/2URrAs/VHPqpzV3e9pn6q6U4Y6lheFUoY=;
        b=KNzUn5Qr1A7xi77oXzmyKrn3KEfURcmqVOI+n02oNgkSO+tAWtxNMIEy0u6Q17h8Bc
         1kKUuR6zZINEOpnTfH3/ZVsfTon1EbL8T159FbfiJy6iujelt1Km5SJdBTwhTCUVMTDo
         TurbxIV5veHxAcBbSioqpFJ1kqW+gOdriavgta67aqyF9NVjTexAXBF3XmyAN+5+xezI
         mtKm3EhaBN0VGdSBSkv3vgvQNypfO4xFonIDRtn4z+iiyOBBxO6c6Ds2n4LMoFWHDkCb
         DuPUhZNCZB3WRo5PEIdXMGNXxIoiq8PXbOYz9S3nWQ0zcfS1Fam5HEOmTfjLIAKu1P73
         t9dw==
X-Gm-Message-State: AOJu0YzelLKWkQhJKjAligZSrgZSSAJF/1S7Vp2Q0ytr0g4OqoTVKRtZ
	Jn/TuumvTZiuop/MXTqMhqPCxrPoLarLxpzJP3F7D5WcJm3OIH9J6wQ=
X-Google-Smtp-Source: AGHT+IHV/D/K5qAWB24j6mkjbj1ZOdjl0p3Jq2pvvd0FDzmk14mZDm8T4DUAXCLnybuo7x9rj4fcSJ3O+akvf6mSFYQ=
X-Received: by 2002:a50:aada:0:b0:538:50e4:5446 with SMTP id
 r26-20020a50aada000000b0053850e45446mr11053edc.5.1696959859515; Tue, 10 Oct
 2023 10:44:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231010173651.3990234-1-kuba@kernel.org>
In-Reply-To: <20231010173651.3990234-1-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 10 Oct 2023 19:44:08 +0200
Message-ID: <CANn89i+PTPUwdEgBDrXNyCWvnTxCqqhfj9d=iNzqSAL-JZ7htg@mail.gmail.com>
Subject: Re: [PATCH net] net: tcp: fix crashes trying to free half-baked MTU probes
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, 
	dsahern@kernel.org, clm@fb.com, osandov@osandov.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 10, 2023 at 7:36=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> tcp_stream_alloc_skb() initializes the skb to use tcp_tsorted_anchor
> which is a union with the destructor. We need to clean that
> TCP-iness up before freeing.
>
> Fixes: 736013292e3c ("tcp: let tcp_mtu_probe() build headless packets")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---

SGTM, thanks !

Reviewed-by: Eric Dumazet <edumazet@google.com>

