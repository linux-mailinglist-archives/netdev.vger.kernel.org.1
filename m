Return-Path: <netdev+bounces-106981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70625918571
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 17:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1F151C221AF
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 15:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B7A1891DF;
	Wed, 26 Jun 2024 15:12:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6513E18A922;
	Wed, 26 Jun 2024 15:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719414777; cv=none; b=kU2RU+kmzobCZHRZnzt4Wp8EKmBpP7uG9X2xnejJbrySfLWBwJmpXwPvSn8DrgFuc8K8pxz0g4AUltYXIY4OfM3brjfA8VtfR6JnW6+MQH4jvdKjCX8lvM1ZbZTF2ju0/dpFji8iF2t+UqbQwx6Iu0GbkrvfWtAyjW3wOk+lJBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719414777; c=relaxed/simple;
	bh=3aVsfSayzLgkpGdE7jOuKef/gUYNqPrEs9FdLQLWT4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nuQbrNTudAlY8r3NzvXVws2EorYav9IDIV9GDPp+Zz1Jy/5iHgk/mKI80kRKvYELFNFhH7kwLMXnHB+2I2MD3PIcEde7EQQ8ufHM6nKt/4FwThbMClWwsCFR27ik41JLz06wsJWxCYHS89lquNZSmyPpYYd/aWcTO16FMSZL87E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a72585032f1so453206066b.3;
        Wed, 26 Jun 2024 08:12:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719414775; x=1720019575;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e1GHg0adTDcx7aelMd7sHYAvXl2IXilBtvZqQq6vi+0=;
        b=jY1193NZKROoImXU3yUbKktXpX+v9fg1mRV8SOBKlfAeNTT4l1yqzMMdC0Cosqb6hs
         c3T0SSCP9xAKNHN9xpwsqzgh7wfHIOpl9wPdaYI1CEYFjws3L/lu/2NaBxNDa0txUzHy
         LRsIdMZ5n5bS3lHRACOVnlV2z5Tmdry/9VZ/6MGUFlFSabDuWrAKrlMv9FUtmGRgMnGn
         dks9Cp2TLJqjjpS7nGkvhpGqi7xV5d3S1NmWdadJR6NcD+Ez8ewVYIGLFdRS5LK+m2DS
         VTiAzayByPdpgNabDxzrYetajewhMgyjSvnmO/cgZJb0A6p/KIE7oKnFG4evpG2nAl7l
         qK4A==
X-Forwarded-Encrypted: i=1; AJvYcCVkBIzu1xgS2DFpiaZc9GNgkeQREH5nKETAgEcBqTxA9beqiiniY3R0cZgHZ96vtWrQwG6PSb75ZeO2NOMOH+tBJ9tC0ayJrQXDYzHOi8WRQOlI8XFUV2h8elk5m7Pj/l1EEuQG
X-Gm-Message-State: AOJu0YxR5fd89G+q9uEACKvQn+E+61mKya3xvUYyMDtNiZDFoJfBf3qr
	LPNnS0VC88sdJKy+vCj/Y3gf3iSOjVjFN8HundXIo02sPaYsrzXmiBdCkQ==
X-Google-Smtp-Source: AGHT+IHlNljuWeKDcLWfXayPDJUHx5Lh29W+LGEbEWNZhl8VBElSvXc8Crp+UM6H/K7zRlBb/fSC5Q==
X-Received: by 2002:a17:907:a096:b0:a72:65c5:315e with SMTP id a640c23a62f3a-a7265c53ea1mr511015666b.21.1719414774523;
        Wed, 26 Jun 2024 08:12:54 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-006.fbsv.net. [2a03:2880:30ff:6::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a725459233csm326571866b.96.2024.06.26.08.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 08:12:54 -0700 (PDT)
Date: Wed, 26 Jun 2024 08:12:51 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Sunil Goutham <sgoutham@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	horms@kernel.org,
	"moderated list:ARM/CAVIUM THUNDER NETWORK DRIVER" <linux-arm-kernel@lists.infradead.org>,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: thunderx: Unembed netdev structure
Message-ID: <Znwv8y03Ftzu0LP8@gmail.com>
References: <20240624102919.4016797-1-leitao@debian.org>
 <20240625175434.53ccea3a@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625175434.53ccea3a@kernel.org>

On Tue, Jun 25, 2024 at 05:54:34PM -0700, Jakub Kicinski wrote:
> On Mon, 24 Jun 2024 03:29:18 -0700 Breno Leitao wrote:
> >  static void bgx_lmac_handler(struct net_device *netdev)
> >  {
> > -	struct lmac *lmac = container_of(netdev, struct lmac, netdev);
> > +	struct lmac *lmac = netdev_priv(netdev);
> 
> I think you are storing a pointer to lmac, so:
> 
> 	struct lmac **priv = netdev_priv(netdev);
> 	struct lmac *lmac = *priv;

Good catch. you are absolutely correct. I will update.

