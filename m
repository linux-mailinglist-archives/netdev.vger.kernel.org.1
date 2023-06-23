Return-Path: <netdev+bounces-13475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3397373BBCA
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 17:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64BEE1C21267
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 15:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6CAC2F5;
	Fri, 23 Jun 2023 15:36:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DFFC2CB
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 15:36:49 +0000 (UTC)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50CE42105;
	Fri, 23 Jun 2023 08:36:48 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-31129591288so780926f8f.1;
        Fri, 23 Jun 2023 08:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687534607; x=1690126607;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dUmXKuqpQIDQ702ACICUI+29N64ElVVWQzyk6zwgNlI=;
        b=e99p2+0S1VKHfwEJtjYUvPcW/kkaUomvy2lIPWDa6FKRtfUTxvAOSoiNZ/FP6yR3FZ
         pv2Ecd9JNrIM79V9k9ZT3WerXbcq/RqfqlFfw3MQq6do/OdbS8TuYS3hWWYgNDU/+x71
         S8kufrUAH/qYlGF7PuZGjDKN2Fzq2JLrkChNADzRaJm6532aJ8tgm1aM0hDEN0fbTOD2
         4fz9p/kgJmJh4dUsUFzi+5vbwOq/Rl35348Dw093wenckKytT6dg5mRjKDB1nqCARoZI
         VyugW17MWVQWKGu8/ml4pHDVP6wl9OPMD972RQ/QPK9Tm4MKpalkhy4etvknBappIVha
         cK/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687534607; x=1690126607;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dUmXKuqpQIDQ702ACICUI+29N64ElVVWQzyk6zwgNlI=;
        b=i6k8Q+I6eDi7WiacJI8oicjleVRSo3kPcvPZr53qLfwNMqQdik/aciRYdowc2BUMLa
         VrnaIrSSofbap3abtWeQjBnxCeJZDjGPUZBRR9jyp/0SsPLv2svR3tFTov98pxmikkOu
         Q9pNpw53xU+A7uqWOLf+b5GtmgYBBOvrW3BLFCd6bvnzQkYDrYlYU+8nxHivL6v7W0Sw
         DMVy52RwGJEXF6NiTxmxmc8WJBNDZkPhmFPx7GT/LWXyKch+EkvyImkvNbevw8vnFSir
         31cFeV1j9lMBnyPmDGpGLT1iaGNft/Ic5ABfpZJMruOL5/6K1pWp8Y7DiXxrqa5NpdUX
         jtTQ==
X-Gm-Message-State: AC+VfDxIgEywpXoc3RAwG/Fwb6FWxM0AC0mBZseQNYam0w28g7P1gurn
	ZnIF60yH+9g0T5meMXDxZs4=
X-Google-Smtp-Source: ACHHUZ726aHLZKM0sXJfwF6uxqEpVi6J9wFasYv9rvgOQTze+JAnAI+cU80/mIQBBJqn16CZ5K7Keg==
X-Received: by 2002:a5d:4cc2:0:b0:309:5068:9ebe with SMTP id c2-20020a5d4cc2000000b0030950689ebemr14119437wrt.50.1687534606478;
        Fri, 23 Jun 2023 08:36:46 -0700 (PDT)
Received: from Ansuel-xps. (93-34-93-173.ip49.fastwebnet.it. [93.34.93.173])
        by smtp.gmail.com with ESMTPSA id x7-20020a5d54c7000000b0031270cf1904sm9863981wrv.59.2023.06.23.08.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 08:36:45 -0700 (PDT)
Message-ID: <6495bc0d.5d0a0220.2963.d640@mx.google.com>
X-Google-Original-Message-ID: <ZJW6khfRAYLhZeK0@Ansuel-xps.>
Date: Fri, 23 Jun 2023 17:30:26 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Pavel Machek <pavel@ucw.cz>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH] net: dsa: qca8k: add support for additional
 modes for netdev trigger
References: <20230621095409.25859-1-ansuelsmth@gmail.com>
 <20230622193120.5cc09fc3@kernel.org>
 <64956c02.5d0a0220.ed611.6b79@mx.google.com>
 <20230623083442.02b17d69@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230623083442.02b17d69@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 23, 2023 at 08:34:42AM -0700, Jakub Kicinski wrote:
> On Fri, 23 Jun 2023 05:10:47 +0200 Christian Marangi wrote:
> > > Something may be funny with the date on your system, FWIW, because your
> > > patches seem to arrive almost a day in the past.  
> > 
> > Lovely WSL istance (Windows Subsystem for Linux) that goes out of sync with
> > the host machine sometimes. Does the time cause any problem? I will
> > check that in the future before sending patches...
> 
> Unfortunately for some reason patchwork orders patches by send time,
> not by the time the patches arrived, and we use a time-bound query to
> fetch new patches. So if the date is too far back the patches won't get
> fetched for the build tester.

!!! No idea! Sorry for any problem that I might have caused. Will make
sure this won't happen again.

-- 
	Ansuel

