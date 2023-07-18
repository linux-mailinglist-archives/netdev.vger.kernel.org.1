Return-Path: <netdev+bounces-18520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 925A4757783
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 11:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EFDA1C20C85
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 09:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24900D52C;
	Tue, 18 Jul 2023 09:13:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BE8A941
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 09:13:46 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23EF186
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 02:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689671625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+xQVi+1cDmFmde3CAW+nWXYiT+uL7nvMDhCcLeOQ/Lc=;
	b=F40+tGgIPx0ZeIQlufut2VXOKC9/jJD1O4S1kT8ooMtWB/MB9yFmpAQzYms2XKRnHq+pxN
	tMjTSRgMXMZ8c+mEOmTeEqorwNmwySLCbHGGW6fEdlJK6IFhCD+h/jOjUo7ugZh+J5EH83
	Fz1K4lah1ssngbWjm0ZrMFVZtJ/linU=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389-y5IRylriOxy9RjJQrjJdOQ-1; Tue, 18 Jul 2023 05:13:40 -0400
X-MC-Unique: y5IRylriOxy9RjJQrjJdOQ-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-40234d83032so8368071cf.1
        for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 02:13:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689671620; x=1690276420;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+xQVi+1cDmFmde3CAW+nWXYiT+uL7nvMDhCcLeOQ/Lc=;
        b=je3TqcNlTeAAXd6gzlPKv7SjT3exmqL+FSc5QFFsgK2X3pYnVrZuCUXnrLfuxl9nvd
         6eogmb8JHYH3i1HKbUmc/fdNm4X/yGPbZRfFfGH+hDdYdTFsWjwGnj5rBPs/LPDTbCma
         xAjyGfkT5YFX6SliNRvmC58KTbaxUAACYnmetknoHMmW6UHro+6BdQJ28aufIzmHpKuB
         AS3g72Ogodcxmj0Mj2fAU1yFP6Zru2wuPkvEz8C5vUCWW+R3FzPAWqPy1dT/jAV6/PrB
         q2dSyPXTvVA1bgxaWZpeIRkQDf4n8kd2oxRy2IQ0Z/1LFL9/vgMb5Jv0ia+L3JW/VyLC
         wEDg==
X-Gm-Message-State: ABy/qLbprFNiM3sTvcPVwUKPiYIezwXU6MBn8Mc6f1PEwFhuMkbm9dDj
	TzEkNRBVH7LPH93l6FSKVS3eWZ0A+Ff3dsFPgaLyqzmlOzLGwhxe78Ja3ANiFTqj5T91YH1XT2C
	8QSopFjSvTiwGJooV
X-Received: by 2002:ac8:5e51:0:b0:400:9ed9:7267 with SMTP id i17-20020ac85e51000000b004009ed97267mr18486001qtx.3.1689671620365;
        Tue, 18 Jul 2023 02:13:40 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH0jzXpTnM/0x9IlIDIkxfyPZicW+zEoqycjC6QNj3AX2IVOjMMKoY90EFmlcoV29fqvdjw8g==
X-Received: by 2002:ac8:5e51:0:b0:400:9ed9:7267 with SMTP id i17-20020ac85e51000000b004009ed97267mr18485980qtx.3.1689671619973;
        Tue, 18 Jul 2023 02:13:39 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-226-170.dyn.eolo.it. [146.241.226.170])
        by smtp.gmail.com with ESMTPSA id hf10-20020a05622a608a00b003e4d9c91106sm513473qtb.57.2023.07.18.02.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 02:13:39 -0700 (PDT)
Message-ID: <164e816460523a9b54b06b1586f89b3bd2d09fc9.camel@redhat.com>
Subject: Re: [PATCH net-next v2] net: dsa: mv88e6xxx: Add erratum 3.14 for
 88E6390X and 88E6190X
From: Paolo Abeni <pabeni@redhat.com>
To: Ante Knezic <ante.knezic@helmholz.de>, netdev@vger.kernel.org
Cc: andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
 davem@davemloft.net,  edumazet@google.com, kuba@kernel.org,
 linux-kernel@vger.kernel.org
Date: Tue, 18 Jul 2023 11:13:36 +0200
In-Reply-To: <20230714160612.11701-1-ante.knezic@helmholz.de>
References: <20230714160612.11701-1-ante.knezic@helmholz.de>
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
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, 2023-07-14 at 18:06 +0200, Ante Knezic wrote:
> Fixes XAUI/RXAUI lane alignment errors.
> Issue causes dropped packets when trying to communicate over
> fiber via SERDES lanes of port 9 and 10.
> Errata document applies only to 88E6190X and 88E6390X devices.
> Requires poking in undocumented registers.
>=20
> Signed-off-by: Ante Knezic <ante.knezic@helmholz.de>

It does not apply cleanly to net-next. Please respin. You can retain
Andrew's Reviewed-by tag.

Thanks!

Paolo


