Return-Path: <netdev+bounces-42946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE09C7D0BB3
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 11:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23AD71C20FD6
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 09:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F2412E6D;
	Fri, 20 Oct 2023 09:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WIpyNE75"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED6112E57;
	Fri, 20 Oct 2023 09:27:36 +0000 (UTC)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55919D49;
	Fri, 20 Oct 2023 02:27:35 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-5079f9675c6so834131e87.2;
        Fri, 20 Oct 2023 02:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697794053; x=1698398853; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9HqcVJytl5bv/aF+KxQt5JHBD+CsHQ2qMEG4kdAlh5s=;
        b=WIpyNE75romXiEXoDRTjusg8AGAmw9R9BwCd22pkVXrUPibIi6ST6ISa60rxJeFGBn
         W+mrDAQ8pHRk7a+P+uvtAsWOI75yL9hM4OJe0ZsdKU9SNv+h8tkYYSTQT8Av968D34as
         KsdLnoHv5oKvqff4vItMW0ipfMyO9PxUJXe2st6kuuiJ0VLNRSpchCivf2khnU4qEPbC
         OcdhFu77ZfDITW3NuT4EWgsbOmSw4I1yNTvFK06MlDetb/vTAMZzH9sNsHM5sh7o68Cy
         X2rWigxBqBLpnOOLe8f4EuQPYQHzvBjHb07MHaosJw/GPx9snj0AF58A2462GiI75uUm
         H/7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697794053; x=1698398853;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9HqcVJytl5bv/aF+KxQt5JHBD+CsHQ2qMEG4kdAlh5s=;
        b=oCRnoVVyi1t8ollQ+AQ+FylcQbW0I4YsDeming8TYvCE5Xt+PmPl7L2Q3258cCqPNW
         MdyUQ86FXuNOGEcFdTb1k+XhYjIqEzrA2YjcIpBBZ2+N1BphSpSBjPSJrjkvHSnuUw2v
         ggE3KY62iJR/EVmhAKnUbsNP7tLhtCK2FHMnXE/NBZR6dCcikhEI9SAcpnVjDM7yV5wx
         dJLn/+aND9Aryk3IelOCJz+t5Zcz4C8WlAPX4sXEalClnv7XA0ULSMCAiAQIdWzjD2XF
         Q44NCEncLz3R6dn8UOVusfP8ZVoNpP53khCtHJqA8xbY2aG3oz+seR3+BjVyzr7BHXiS
         azDA==
X-Gm-Message-State: AOJu0Yz+ft1lLBKSLbTpHRzl72IgBA8iwgFCKTWfw/asyCX6EhkqRGmq
	Fe1Cr7h6veayspMiePlKryQlgEKlAnleXA==
X-Google-Smtp-Source: AGHT+IFQ08ub3og0Zp1kbIM98EmTalF0t0kVjHMIiibOFN0/Jw5V/kHj+j6LWfgM1fKeOEK1MVmT7Q==
X-Received: by 2002:a05:6512:3247:b0:501:c779:b3bb with SMTP id c7-20020a056512324700b00501c779b3bbmr812270lfr.60.1697794053180;
        Fri, 20 Oct 2023 02:27:33 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id a3-20020adfe5c3000000b0032da40fd7bdsm1307189wrn.24.2023.10.20.02.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 02:27:32 -0700 (PDT)
Date: Fri, 20 Oct 2023 12:27:29 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Ante Knezic <ante.knezic@helmholz.de>
Cc: UNGLinuxDriver@microchip.com, andrew@lunn.ch, conor+dt@kernel.org,
	davem@davemloft.net, devicetree@vger.kernel.org,
	edumazet@google.com, f.fainelli@gmail.com,
	krzysztof.kozlowski+dt@linaro.org, kuba@kernel.org,
	linux-kernel@vger.kernel.org, marex@denx.de, netdev@vger.kernel.org,
	pabeni@redhat.com, robh+dt@kernel.org, woojung.huh@microchip.com
Subject: Re: [PATCH net-next v3 2/2] net:dsa:microchip: add property to select
Message-ID: <20231020092729.gpbr7s2cbmznmal7@skbuf>
References: <20231019165409.5sgkyvxsidrrptgh@skbuf>
 <20231020084620.4603-1-ante.knezic@helmholz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231020084620.4603-1-ante.knezic@helmholz.de>

On Fri, Oct 20, 2023 at 10:46:20AM +0200, Ante Knezic wrote:
> Ok, will do. I am guessing I should leave the existing 
> ksz8795_cpu_interface_select() as it is?

I would encourage moving it to the simpler call path as well, but
ultimately this is up to you.

