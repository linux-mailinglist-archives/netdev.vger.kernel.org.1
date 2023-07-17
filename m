Return-Path: <netdev+bounces-18256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D38075611F
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 13:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBD0F1C20963
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 11:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6754AD24;
	Mon, 17 Jul 2023 11:03:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6BEAD23
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 11:03:53 +0000 (UTC)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 426EFE5A
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 04:03:52 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b71ae5fa2fso62842561fa.0
        for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 04:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689591830; x=1692183830;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KKghZ8QNoXQs8xa/hgGcDNF3Z0ichWHWuDS0ZkXZaf0=;
        b=OFvAfniFDy+IPhA+2zkRJnlkS9ZIRgU/gPAzxv5H1txSL0gHdLuOt6CSRbzBVSIFsr
         YHm4yWg0qdIpQmKtUSY5JBGBIwuAzlrIMzryBYdKPBHapZAjH8F37WiMspoJIIzhQ9ov
         FQwX2nDkUJeJbvJE4PIN2CHvGKPBDLrjtTjESADoFttff+P/c8PvDDF9L6NTQEaScEQ/
         KvtunJ5bKDK0m5fwM7Ex7QJ0RGvuWmhXBPu+f/tNW8Y1N7CD+O5a+kmvIdtvbY1ZAWfS
         1N/Eubm1QIeHRDkx2THCxfYb93M+jtFvqcemQWREAUGjxbMS2dF/wdiWCb0VrtiVyJiG
         974Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689591830; x=1692183830;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KKghZ8QNoXQs8xa/hgGcDNF3Z0ichWHWuDS0ZkXZaf0=;
        b=cmCy+HcItPCKhqI7vWcSHQv6rmSSBMr7xNym4BrxjTbgxLQQraZDq9BsRXGHEhaL0D
         uHvf9171NFvt21ABOkmdtedAcyH/kspVLH+AMCYDra9kLdLnsg3T84MpvnXiG0JWXPwg
         /B4ARjIy0CjYAFDyKomHmzOAcAIaybPPCthSosXn6dbxLtdo/Mfu9EbM6HrgtkJaCMVs
         VFjz2AgaoKVQR+YMStLyLJkPvfLDqDeOYodUx0akaBlgHiDq0A7s242WRNaLOm6nwCfV
         SAP1CaPXf5PbHFEXQYsHB5nl6HSbA8L5ZsJirZPe2pUWIRUgrH3j579bVx6ikMH36diJ
         L4dQ==
X-Gm-Message-State: ABy/qLbHM27mQmuRfRs2oLB6DtdlGEqDNcx0PVweMOXAGFpbrnGVlKgo
	m4riy5HkHMvyXkkNJnCAWco=
X-Google-Smtp-Source: APBJJlEE5jB9UME67AFsptRmyJXgbqYGv6G8ohroOwBf0MilqJaV9sXCL1XPAlMoTefxgo4ORLWrkw==
X-Received: by 2002:a2e:3603:0:b0:2b6:d536:1bba with SMTP id d3-20020a2e3603000000b002b6d5361bbamr8458933lja.18.1689591830164;
        Mon, 17 Jul 2023 04:03:50 -0700 (PDT)
Received: from skbuf ([188.25.175.105])
        by smtp.gmail.com with ESMTPSA id b14-20020a17090636ce00b0098d486d2bdfsm9187482ejc.177.2023.07.17.04.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 04:03:49 -0700 (PDT)
Date: Mon, 17 Jul 2023 14:03:46 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Ar__n__ __NAL <arinc.unal@arinc9.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Daniel Golle <daniel@makrotopia.org>,
	"David S. Miller" <davem@davemloft.net>,
	DENG Qingfang <dqfext@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Landen Chao <Landen.Chao@mediatek.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Matthias Brugger <matthias.bgg@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Sean Wang <sean.wang@mediatek.com>,
	UNGLinuxDriver@microchip.com,
	Woojung Huh <woojung.huh@microchip.com>
Subject: Re: [PATCH net-next 2/3] net: dsa: remove legacy_pre_march2020 from
 drivers
Message-ID: <20230717110346.cpnoahwau6o7ss5f@skbuf>
References: <ZLERQ2OBrv44Ppyc@shell.armlinux.org.uk>
 <ZLERQ2OBrv44Ppyc@shell.armlinux.org.uk>
 <E1qKEqS-00H0xb-G1@rmk-PC.armlinux.org.uk>
 <E1qKEqS-00H0xb-G1@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1qKEqS-00H0xb-G1@rmk-PC.armlinux.org.uk>
 <E1qKEqS-00H0xb-G1@rmk-PC.armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 14, 2023 at 10:12:12AM +0100, Russell King (Oracle) wrote:
> Since DSA no longer marks anything as phylink-legacy, there is now no
> need for DSA drivers to set this member to false. Remove all instances
> of this.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

