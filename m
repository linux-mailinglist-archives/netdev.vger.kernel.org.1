Return-Path: <netdev+bounces-35584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5857A9CB8
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 21:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F07C01C21467
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 19:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80DC99CA43;
	Thu, 21 Sep 2023 19:24:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD5B168CE
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 19:24:04 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE87D3160
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 12:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695323189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fDPElF5fbv46uRKTOW4yOLPXCpK6plAuYJE21eTW+f8=;
	b=Tt81OtoYiun7oDGTPJcykLfbCKw4WRvQoGBRx7ccVXuVK7e7/20NwNW9ZJvjuztBi1aWBC
	CiNVFEKhTfbPUA/GmA6vmwg9snHwqXsNiCkgId2mYLGf5GJvT8TZMexdTlWEAnfWV4nQC9
	aoT+LSjD3xJBjFyaZ934IMqYJZiWxBg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-Rle29Av3PDGkoIPQ6oA42Q-1; Thu, 21 Sep 2023 15:06:27 -0400
X-MC-Unique: Rle29Av3PDGkoIPQ6oA42Q-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9ae5101b152so31142266b.1
        for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 12:06:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695323186; x=1695927986;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fDPElF5fbv46uRKTOW4yOLPXCpK6plAuYJE21eTW+f8=;
        b=R6wTgUKGmuXoYkt0FJ3q3PaWLn9W3DOHDTt5gGimBdocjU3CSEUdlgtgRB0h3uxa3+
         +crfri9WmsEAan0kFzuaNl86AuDIfwxutF5oCjJ+OUFscal3Kbv+R6yokAPmJLQmyLe6
         pZ+zBmM5/SdsS7r1dH670DzU8uAsfERBoFBDp7qzgBsvaSq24ExcQ3hOU/znlmRDZ2iU
         QFW0y+CuFb7gXYxBwVOVPRVOpBXrJykZNBC/F9Hf+P+778HXXa2UzkwoCFEUIC9I8+2o
         Yd/EH6dCD9H3jmhAKbOAV/l52THBooj6xlpv7iHgvi3ruuGz/P3QqBcR/WqBY8imGbjW
         5/Pg==
X-Gm-Message-State: AOJu0YzagQI1D5AhIXzCvrxdZJ3j8ALACm1aT+YkNcz9EvfdPcX+ZWFr
	ehEsgf3ngqDa7ujDZBsBJlJEh9U3KIfsp7QMi5yjWMVYO/fTWv83PRbZ2WQFM+YirZ6mVFaoIdh
	1VM6UaB+7bfqDK6dlYfvhDptW5iI=
X-Received: by 2002:a17:906:535e:b0:9a2:1e03:1570 with SMTP id j30-20020a170906535e00b009a21e031570mr4984711ejo.0.1695323185861;
        Thu, 21 Sep 2023 12:06:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLZS6/xYFBep1mcS+XqWUS4NAEaA4kUx8Q1oVSWNtB1xILFo4hy4Nk4J2xTi4tE2TiQVW7Bg==
X-Received: by 2002:a17:906:535e:b0:9a2:1e03:1570 with SMTP id j30-20020a170906535e00b009a21e031570mr4984702ejo.0.1695323185514;
        Thu, 21 Sep 2023 12:06:25 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-251-4.dyn.eolo.it. [146.241.251.4])
        by smtp.gmail.com with ESMTPSA id k20-20020a170906681400b009adca8ada31sm1484792ejr.12.2023.09.21.12.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 12:06:25 -0700 (PDT)
Message-ID: <ccd7930fd410540c4d9c971feb470466386e8977.camel@redhat.com>
Subject: Re: [GIT PULL] Networking for 6.6-rc3
From: Paolo Abeni <pabeni@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Thu, 21 Sep 2023 21:06:24 +0200
In-Reply-To: <CAHk-=whsTjLdt7RX-f-sFxqu_PieiBz=2OTjBF1CgW4j+OHfag@mail.gmail.com>
References: <a15822902e9e751b982a07621d180e3fa00353d4.camel@redhat.com>
	 <CAHk-=whsTjLdt7RX-f-sFxqu_PieiBz=2OTjBF1CgW4j+OHfag@mail.gmail.com>
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
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, 2023-09-21 at 11:30 -0700, Linus Torvalds wrote:
> On Thu, 21 Sept 2023 at 07:35, Paolo Abeni <pabeni@redhat.com> wrote:
> >=20
> > I'm wondering is if my PR reached somehow your inbox and/or if I have
> > to re-send it.
>=20
> I got it fine, and just merged it (still going through the build test etc=
)

Ah, better! Thank you for the feedback!

Cheers,

Paolo


