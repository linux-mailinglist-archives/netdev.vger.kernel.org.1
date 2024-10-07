Return-Path: <netdev+bounces-132787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 036219932F3
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 18:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A98251F24056
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 16:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FFE51DA0F1;
	Mon,  7 Oct 2024 16:19:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B821D9A59;
	Mon,  7 Oct 2024 16:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728317963; cv=none; b=bmat7TAxGK0N+UhYs6dA//3MUvDtO2hv3H2TG+WOWAxHAYTJcwgmO6fOpwj/u2r515wyfanGXcevFyCxMkeDIesNTpDMoYaMysFgUdfX68znhIaYkCFm9G0Tb230rfFNgCo+xHC5zLodPTa/POmh5VLiEteJK6+OBgmtdvbQq7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728317963; c=relaxed/simple;
	bh=cvWWyeCoWbSMT6fGZuyoTXn3fRV6KpNuA3QiJoF4LDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aF/0ybVbRxDRJWizDyzU5uKvBeEMJF+e5oVEORe53+qhIOj2hS2CzyoT43ih3tj6zRittNvIgUA4+7Cwt9nLgufB/jxwLzlsGDcUFnvG9am6rIREmBUj7UqRE3M9zuMx7e+/hSUFRi+wx2CsQAGouYDa1fwvwInj/VA2elcei2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9960371b62so80106366b.3;
        Mon, 07 Oct 2024 09:19:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728317960; x=1728922760;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PC5M7B4TiJSMtKjhRiE4COzG8hnL1nXRW0kL9PA6EW4=;
        b=IeVRNYf3oM1MX91A/qJDTS3HoR1kfuEZpnAN56bChm5hstO+CmzZObNxkaGiyObwGl
         0xbY/OMawC2kJwduyVDkiU7JUdD/ow461aOABSTn6uxtHSF1lTDAO8ScKet6L7xRJqrL
         RYq+3rRvC9gE6pUnxd6TIll0hK4qXZrPr+pASodP2sEL97cwJ5cZ6a8Czy4+sGcNQmd2
         UXPez5noZKqPEOALLqda8pFbcmHYibdxH8G977cfKBRTiNEBIlTYdM7ka7+fB9kVOBdP
         /t8CiT12w9BOSOMjFljxwP0HJ3YQFxW5VfbIO+qG1B3Ogu7AOE9JRDcCH/4cEckryx+3
         vz/w==
X-Forwarded-Encrypted: i=1; AJvYcCU5R08YSHpGBwKBB3J+VfwC9nUoQgQaTCtnLs8TsCmWQCYM2PKI3a8s5G+JRWSuTbHP8hYzGX/K@vger.kernel.org, AJvYcCUU52BiOSqBUSyCx+43mg2hHPvTlEWIIpkVnq26hRoeCYLlotbclwleHfbQ66FuB6vJmdl39k085Gw=@vger.kernel.org, AJvYcCXhMStW/13AAIW6ecGBkc7epaODyTfKMOiyEsvZLnKLPatTMztpoZ6QKhquOvo9JdkB6ZZ7DSWQhwqPcVad@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4Wv2HzyiL1veHtIaKOcld6hWAgJ9a9GXhuJzYXPvOGD1/FDoA
	g0XACeSD0jqMV5GfhF88bilz0FTuToejEkTXQ4wo/ANDXdvYrySu
X-Google-Smtp-Source: AGHT+IEONJOD8PtUeKqYrUOv3KIMn+wPgs7bQ6fXHAnHnBRWLX7UdM9imIVq7zOIvUS2t2sp2mU+UA==
X-Received: by 2002:a17:907:1c93:b0:a90:d17f:eced with SMTP id a640c23a62f3a-a991bd04dd2mr1324581566b.5.1728317960232;
        Mon, 07 Oct 2024 09:19:20 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-007.fbsv.net. [2a03:2880:30ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9952bd2b24sm171498866b.163.2024.10.07.09.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 09:19:19 -0700 (PDT)
Date: Mon, 7 Oct 2024 09:19:17 -0700
From: Breno Leitao <leitao@debian.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: akinobu.mita@gmail.com, aleksander.lobakin@intel.com,
	almasrymina@google.com, asml.silence@gmail.com, corbet@lwn.net,
	davem@davemloft.net, edumazet@google.com, horms@kernel.org,
	kuba@kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, willemb@google.com
Subject: Re: [PATCH net-next] net: Implement fault injection forcing skb
 reallocation
Message-ID: <20241007-impartial-zebra-of-enhancement-9a2b63@leitao>
References: <20241002113316.2527669-1-leitao@debian.org>
 <20241002152540.51408-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002152540.51408-1-kuniyu@amazon.com>

On Wed, Oct 02, 2024 at 08:25:40AM -0700, Kuniyuki Iwashima wrote:
> From: Breno Leitao <leitao@debian.org>
> Date: Wed,  2 Oct 2024 04:32:54 -0700
> > diff --git a/net/Kconfig.debug b/net/Kconfig.debug
> > index 5e3fffe707dd..f61935e028bd 100644
> > --- a/net/Kconfig.debug
> > +++ b/net/Kconfig.debug
> 
> This config is networking-specific, but I think lib/Kconfig.debug would be
> a better fit as other fault injection configs are placed there together.
> 
> Now we need to enable fault injection first and go back to the net-specific
> items in menuconfig.

Makes sense. Let me move it to lib/Kconfig.debug.

