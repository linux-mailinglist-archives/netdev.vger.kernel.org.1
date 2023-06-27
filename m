Return-Path: <netdev+bounces-14251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D473B73FC26
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 14:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36032280E55
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 12:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66299171C5;
	Tue, 27 Jun 2023 12:47:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5948E111E
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 12:47:31 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 233101BCD
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 05:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687870049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=scmLl+GUv3/9o3cooxWYS8MrJgKbkUBRuFLg/a2t5TQ=;
	b=YiQ0mFfohF3QAMyvgtECVDW7xQa9QK7uwG6TkNu9iutzEnb2Oh0HLP0c3Bw1Pl0X4nZv0m
	bRvwRte0C/+XrcNO7TpM7IT+E4tKOMN5etCL8WikoXpIV1znPGMhXKZ93+hblkD40Wli2I
	pmWT6p3GbBP7PAsAmX3jAxhudKV+4kY=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-2CzTDhWDPUO4c3qhw1X2hA-1; Tue, 27 Jun 2023 08:47:27 -0400
X-MC-Unique: 2CzTDhWDPUO4c3qhw1X2hA-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4009ad15222so8938081cf.1
        for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 05:47:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687870047; x=1690462047;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=scmLl+GUv3/9o3cooxWYS8MrJgKbkUBRuFLg/a2t5TQ=;
        b=alYESPxhd8nNhSbZ1ZbaKHcU83O4T13pndnKt3R3+BWbyRg9wxUGODUCYxODE6QBgK
         RHnfI6W+OpgK4kQUY3e7sjTgLaN/S7F56xuuqJcmVL7YKjDEbJ51Pc+USK7rlFTieu6S
         0GwKLVcM58jL5Qab6T/NPNXmdmdU0RsDN8x4TOJJNYv7BQh3Yj+jKc9DZp23PtJdUZ0O
         kyYmAnc9lL0vq2Ms9Nj47FThfb2tcFSe92BLC8CBh9ZC5KQh4ng68NLDY1AnsLrAQdVb
         ht0aXAzCBdNCKTHDbkLu2FcM3GUG/a5OJ2RN13daVE0qBtVVIzHAOM/oOyWA8qZNrQIc
         PQdw==
X-Gm-Message-State: AC+VfDxe5dRnLTYDYJCxoRFYbhfEPJFqTO1reFfBjL2v+0mk8fPsMW0E
	zV0sWugrcItjVEPTHlrj2+yCEfBi/5JIumyfe8kWuwB4OgeuI/Dq+rIdVDI+TFWHhWesmJ0LSfa
	5YVEu28lXEh+T1YoB
X-Received: by 2002:a05:6214:5298:b0:62f:1283:6185 with SMTP id kj24-20020a056214529800b0062f12836185mr38130138qvb.2.1687870047353;
        Tue, 27 Jun 2023 05:47:27 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4nTkp5S5WlZpeXkTUPXXG6QpUi3yQvI4wyuMQU2wA+VUqsfuTw8Knys7hPmVjsiVxOEkWpBQ==
X-Received: by 2002:a05:6214:5298:b0:62f:1283:6185 with SMTP id kj24-20020a056214529800b0062f12836185mr38130116qvb.2.1687870047012;
        Tue, 27 Jun 2023 05:47:27 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-239-6.dyn.eolo.it. [146.241.239.6])
        by smtp.gmail.com with ESMTPSA id ep8-20020a05621418e800b00630182f0191sm4505888qvb.1.2023.06.27.05.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 05:47:26 -0700 (PDT)
Message-ID: <8a832e3d2eb2e3fc14ade43c4feb1cbafc37c5d7.camel@redhat.com>
Subject: Re: [PATCH net] net: phy: mscc: fix packet loss due to RGMII delays
From: Paolo Abeni <pabeni@redhat.com>
To: Vladimir Oltean <olteanv@gmail.com>, Vladimir Oltean
	 <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, Jose Abreu <Jose.Abreu@synopsys.com>, Andrew
 Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 linux-kernel@vger.kernel.org, Harini Katakam <harini.katakam@amd.com>
Date: Tue, 27 Jun 2023 14:47:22 +0200
In-Reply-To: <20230627121352.tsqycdvzyqqpdejb@skbuf>
References: <20230627091109.3374701-1-vladimir.oltean@nxp.com>
	 <20230627121352.tsqycdvzyqqpdejb@skbuf>
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
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 2023-06-27 at 15:13 +0300, Vladimir Oltean wrote:
> On Tue, Jun 27, 2023 at 12:11:09PM +0300, Vladimir Oltean wrote:
> > Two deadly typos break RX and TX traffic on the VSC8502 PHY using RGMII
> > if phy-mode =3D "rgmii-id" or "rgmii-txid", and no "tx-internal-delay-p=
s"
> > override exists. The negative error code from phy_get_internal_delay()
> > does not get overridden with the delay deduced from the phy-mode, and
> > later gets committed to hardware. Also, the rx_delay gets overridden by
> > what should have been the tx_delay.
> >=20
> > Fixes: dbb050d2bfc8 ("phy: mscc: Add support for RGMII delay configurat=
ion")
> > Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> > ---
>=20
> I may have mis-targeted this patch towards "net" while the "net-next"
> pull request has not been yet sent out. Can patchwork be instructed to
> re-run the tests on net-next?

I'm not 110% sure, but I think you have to re-send the patch with a
different prefix to achieve the above.

Cheers,

Paolo
>=20


