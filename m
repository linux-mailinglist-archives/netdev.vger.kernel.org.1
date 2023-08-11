Return-Path: <netdev+bounces-26669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E981577886E
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 09:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A39D42814AA
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 07:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598775230;
	Fri, 11 Aug 2023 07:37:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECB91E1C4
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 07:37:52 +0000 (UTC)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93FAFE73
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 00:37:50 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-4036bd4fff1so137351cf.0
        for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 00:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691739469; x=1692344269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wpdbPkPSTDtpRUF5KB9ed/xKbYs10zrfWTQAWipjf7Q=;
        b=HfLbTV191BwrwGZH0l9N3aRjOqUmEPk50LIAWPnlYvy+Yu3yMWspzwWCqBxQfXIm2g
         45eCYtF7useuUGRRQ/C+n1S6W5gbPxAtLr6tyW+JEaIcZuznLXV9yx11KUCMOfWrSGom
         ksnWoNRdaz/NpLE/D/7MKpYEM/AOx0esaH1en7tDyPYRajYrZVrgO9v9VrZgLpYlNPHX
         50WThlmlqeRKRp6oc2SZdeUfnFMMDoPpgqA4P6kuEgejPMkr/I4pN++3Y813D7ExsRAz
         j/sn5/4WBV3Vci1UEyrP6O4eVjIHY5vD2RfY1rAqdRhAUjSmzlA81Qm0p4J7qAB2yGic
         JAPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691739469; x=1692344269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wpdbPkPSTDtpRUF5KB9ed/xKbYs10zrfWTQAWipjf7Q=;
        b=M+oqjPnpPYlTHWNEhihNA9YudEUnSx3tvpbSIPYLKU3/QWpnuEm1a8WQ5UfYDseGTn
         fer0mE0d5TASw7bNwBj2tH1Rf87E+1qCoAPNrtcLlSu1dbEohpMiI+sIANJMH6WhFb8v
         o3EGSPXeQe2OF/yCsTl9TtgpqClLhQS0RPGwIENZqhCuxVf9KPu/ODDF1LkKEKDqamtJ
         zJe1dHURB1BWskwTCqN3dlrnox0H+gNU6H50cpti8SQGHa/AGm7YxaZXHp2odcST1NUv
         tnM4CSwLgcfhRqcRR8FFJiQMY8BstgqOQ+/KF42Pl2B28ocDTEyoqzU4kEFbcFdLjekV
         utTQ==
X-Gm-Message-State: AOJu0Yy4q6ThuGlc7pGx6kfdJ83z/8siJA6BqG9jq7H1FHcYHcL9viSu
	N2A+NyE7pRCZk0YrgrG+VSSQ3FEKZiDmmFnfH5Df9Q==
X-Google-Smtp-Source: AGHT+IHokTJXsTmIZ6lawwV3YIQ4KB/b5AAm++XyHzNyltjHBpPBiT+Ex6hVbdTqBacgWRKasMN3WCy8jlZbVcrmfPs=
X-Received: by 2002:a05:622a:190b:b0:403:eeb9:a76 with SMTP id
 w11-20020a05622a190b00b00403eeb90a76mr119206qtc.17.1691739469579; Fri, 11 Aug
 2023 00:37:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230811025530.3510703-1-imagedong@tencent.com> <20230811025530.3510703-2-imagedong@tencent.com>
In-Reply-To: <20230811025530.3510703-2-imagedong@tencent.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 11 Aug 2023 09:37:38 +0200
Message-ID: <CANn89i+7YeP+N-4bWgU=dMBEhRZBjaY4njv+WhbvbVde_7DoOg@mail.gmail.com>
Subject: Re: [PATCH net-next v4 1/4] net: tcp: send zero-window ACK when no memory
To: menglong8.dong@gmail.com
Cc: ncardwell@google.com, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, flyingpeng@tencent.com, 
	Menglong Dong <imagedong@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 11, 2023 at 5:01=E2=80=AFAM <menglong8.dong@gmail.com> wrote:
>
> From: Menglong Dong <imagedong@tencent.com>
>
> For now, skb will be dropped when no memory, which makes client keep
> retrans util timeout and it's not friendly to the users.
>
> In this patch, we reply an ACK with zero-window in this case to update
> the snd_wnd of the sender to 0. Therefore, the sender won't timeout the
> connection and will probe the zero-window with the retransmits.
>
> Signed-off-by: Menglong Dong <imagedong@tencent.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

