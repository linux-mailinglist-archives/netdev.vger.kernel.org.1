Return-Path: <netdev+bounces-35466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CDA77A99CE
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 20:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A72DE1C213B7
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 18:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF3045F77;
	Thu, 21 Sep 2023 17:24:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8893D171BC
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 17:24:32 +0000 (UTC)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801387A88
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 10:24:02 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-415155b2796so20421cf.1
        for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 10:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695317041; x=1695921841; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aUGHn2/gI9j3NzRJM1gxBEZKInO24aduauGS7SH0sCI=;
        b=Tcu8RbBWxGMPU/FQuU/013V/qWKKWoKwEKsGXLzO/YVb2YjIou8Tran23o0IEiEO4f
         3OtPli2raXdNVY/RF6z0bsNzZ64RdbQw7qV9NCpvytiNjTV7a1n0X/ytTTSCV9HAvPjo
         C6SUmsUiYCvtlO8OUnQrMKwcyvZxgbKu80w6npfKgzYuQo9j2o7y+KVDZ6gxrZeMnrXf
         syJJop11iXvxadtAbDuHXYcKrIs/ZG/duvcj1XKnqQViHvP7CeNl/LtFLu843gnnVQGo
         2dEjheDgs62Jefiw0LwtyOyk5a52H4KYCeHVEDVQUfYhuNiJ+3mJLANNOcUwWsgRpoyi
         B5mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695317041; x=1695921841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aUGHn2/gI9j3NzRJM1gxBEZKInO24aduauGS7SH0sCI=;
        b=OxJZuy3RDaA0ryoDI2l4TFa0cA3bKaKogdCcMGOl5JR8X5ixtRF29X1m6hYPmdY1Od
         eLDZriH3dz4b/18swdKDadvw2arvfiB5JyWWQb5HkUCakPXY0HFnvq1PKVtz5SZsUI4/
         zZAz3Bl6zxJyRVmJMI3v13yvNHRfIvXF0+9yV5BfeUTVgS2x670k4yjPpf5wwSgBsnh5
         FbNVie2kAkXC4BbVkU+ak0dga9Kaq5pJcMQrlLcy310vTKk3wgESsbBj55zzkrkCSgSt
         djoPHSxd5BUgtmDAfQ8WIEi2YTdWHNDG5FR+VC8k7NSltU4esYehXpwK9+YInaaxYK26
         tJTQ==
X-Gm-Message-State: AOJu0YxzI8l4jL7WUmxM9p15749ZGdBKmDtHwxzj8n52F7RsqQ7DcAA5
	IbUslkHJl9kYVQBFLEP1eXxIk/j7Dh/7MdHUVylCAs2A+JGLYJXGQpI=
X-Google-Smtp-Source: AGHT+IH54PnJyai/Tj0QEgtzDr/XdDXrcZAV7Z1pmVaahytXzpjF8lfhyz8U5UqBYkEjRpJrHHegqISd/GrE8K59+oU=
X-Received: by 2002:a05:622a:449:b0:3fa:3c8f:3435 with SMTP id
 o9-20020a05622a044900b003fa3c8f3435mr197770qtx.27.1695301094471; Thu, 21 Sep
 2023 05:58:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230920172943.4135513-1-edumazet@google.com> <20230920172943.4135513-4-edumazet@google.com>
 <89a3cbd7-fd82-d925-b916-e323033ffdbe@kernel.org> <CANn89i+-3saYRN9YUuujYnW8PvmkyUTHmRDX3bUXdbYoGfo=iA@mail.gmail.com>
 <e4aeef69-9656-d291-82a3-a86367210a81@kernel.org>
In-Reply-To: <e4aeef69-9656-d291-82a3-a86367210a81@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 21 Sep 2023 14:58:03 +0200
Message-ID: <CANn89i+bXkgHWSgkqYToAGofE4qdJC142MmSR4eV2uD4408nVA@mail.gmail.com>
Subject: Re: [PATCH net-next 3/3] tcp: derive delack_max from rto_min
To: David Ahern <dsahern@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Soheil Hassas Yeganeh <soheil@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Yuchung Cheng <ycheng@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-16.0 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 21, 2023 at 2:37=E2=80=AFPM David Ahern <dsahern@kernel.org> wr=
ote:
>

> My comment is solely about mismatch on data types. I am surprised use of
> max_t with mixed data types does not throw a compiler warning.

This was intentional.

This is max_t() purpose really.

Perhaps you are thinking about max() ?

