Return-Path: <netdev+bounces-22074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1251765DD1
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 23:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 541272824B3
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 21:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E831CA01;
	Thu, 27 Jul 2023 21:15:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576E21C9E4
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 21:15:06 +0000 (UTC)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A29130E3;
	Thu, 27 Jul 2023 14:15:04 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-317715ec496so1482110f8f.3;
        Thu, 27 Jul 2023 14:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690492503; x=1691097303;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qRfseTaFLr304DLTt7nKnevuj2u0Rk8R7CojLp+3Nsk=;
        b=sdBinHaItPP1FOSRdJjPB9Wr1YgmwzB0lntxdHHCqp79CStmeT+H6K1xe0f7VcV8lD
         Don1ABgWfC1CAH8JNf1sJN2MoWH1FifyC5UeTv1xiMFest6O9fKEYoyLz+R9I4lII37m
         Zf5DhRr6U6expFyp8MDka3D+dRRgrbLIJfiLzMoNPFjrvga5aTLSUrMXmmIVPgum4siE
         gme1xJRr1T3h7mkEe0cChQrSqejzqI3PPBPU62XnVNCo7Qq0cA+oSH5pTNZD+kfmJtTS
         oMano+ChPIt+q8WweN0dZRq6rssRy3uXINV6k2lmPQ3fOOXDuXUissU8vobvMGd78GU9
         8pkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690492503; x=1691097303;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qRfseTaFLr304DLTt7nKnevuj2u0Rk8R7CojLp+3Nsk=;
        b=ZS3PDn46bQNtb9fpRUyLhPOPbgXYqjSAnJf08cCdTHuks5vzlg5sl0UTlOEo/EWNnH
         TnXnACbz0StRFKFwZ5bSt/99s3x1UgcvCXr39Rg7q6Q1svCs7tPlwQIl+Uw5BcbdJrUO
         PGsK0P5cGdtAiFS2arSjth9EpIjVTc1EZAJS83mwOkU+SRzQchG4lzY4ODZwAVM0yNrb
         5vvZTaVwl4TqJtms0iGq0Uyq1PBNqbeLId3tPZPl1Mtl4JAo9TrA8L6scNpEBW0yuhon
         UyWNQcKgazEY2VjTIAPQlIJNKulkn1UYi5A8picosXamEz1MyCgxUePngyYlykOXy1s/
         7nqg==
X-Gm-Message-State: ABy/qLZA25PZsCFHhIimvt3+H2FmurhTg/PIuU/ROtFqDuPr1rDSCP9K
	rut8Fk+nIVKpwNu4FcaQtGM=
X-Google-Smtp-Source: APBJJlHzXSYdxXFg2S34bYD7NxT6UZUU+p69AY6r3V1v6pQKzWB5HRFe8zFIB4oTltdeCYTbmfFDPg==
X-Received: by 2002:a5d:4109:0:b0:317:5c05:e1c with SMTP id l9-20020a5d4109000000b003175c050e1cmr207894wrp.25.1690492502727;
        Thu, 27 Jul 2023 14:15:02 -0700 (PDT)
Received: from skbuf ([188.25.175.105])
        by smtp.gmail.com with ESMTPSA id o12-20020adfcf0c000000b00301a351a8d6sm2975093wrj.84.2023.07.27.14.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 14:15:02 -0700 (PDT)
Date: Fri, 28 Jul 2023 00:14:59 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Atin Bainada <hi@atinb.me>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH 3/3] net: dsa: qca8k: limit user ports access to
 the first CPU port on setup
Message-ID: <20230727211459.zp36vd3xlvdccrie@skbuf>
References: <20230724033058.16795-1-ansuelsmth@gmail.com>
 <20230724033058.16795-1-ansuelsmth@gmail.com>
 <20230724033058.16795-3-ansuelsmth@gmail.com>
 <20230724033058.16795-3-ansuelsmth@gmail.com>
 <20230726131851.w5ty2mftr7tdl3mi@skbuf>
 <64c2c142.5d0a0220.9ae33.deab@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64c2c142.5d0a0220.9ae33.deab@mx.google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 27, 2023 at 09:10:56PM +0200, Christian Marangi wrote:
> On Wed, Jul 26, 2023 at 04:18:51PM +0300, Vladimir Oltean wrote:
> > On Mon, Jul 24, 2023 at 05:30:58AM +0200, Christian Marangi wrote:
> > > In preparation for multi-CPU support, set CPU port LOOKUP MEMBER outside
> > > the port loop and setup the LOOKUP MEMBER mask for user ports only to
> > > the first CPU port.
> > > 
> > > This is to handle flooding condition where every CPU port is set as
> > > target and prevent packet duplication for unknown frames from user ports.
> > > 
> > > Secondary CPU port LOOKUP MEMBER mask will be setup later when
> > > port_change_master will be implemented.
> > > 
> > > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > > ---
> > 
> > This is kinda "net.git" material, in the sense that it fixes the current
> > driver behavior with device trees from the future, right?
> 
> This is not strictly a fix. The secondary CPU (if defined) doesn't have
> flood enabled so the switch won't forward packet. It's more of a
> cleanup/preparation from my point of view. What do you think?
> 
> -- 
> 	Ansuel

Ah, ok, if packets don't reach the second CPU port anyway then it's fine.

