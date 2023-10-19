Return-Path: <netdev+bounces-42653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D3E7CFB8B
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 15:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6E6E2820B6
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 13:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04B628E00;
	Thu, 19 Oct 2023 13:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gqqEwHzb"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEFB27472
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 13:48:03 +0000 (UTC)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E344D11F;
	Thu, 19 Oct 2023 06:48:00 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6b26a3163acso5365522b3a.2;
        Thu, 19 Oct 2023 06:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697723280; x=1698328080; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BliccIy+de7xYxoFZodWYzkchyJ1PaiIyTfG2nYkRFE=;
        b=gqqEwHzbG0McYFx8GMqTPSWdCip0PYCi1yNxGxhRtvzOOokj98T49P5qJBZPFOQNml
         x8JL/lKST7uBxTGDXVCGymUPd1FQG1TEf4krgedZJVy/qouOOkGHZ4m+xZsgMzP1yK7b
         iNFLFItN37OwrO/piP4Y6coMVmqLMmrtYnQsBhCIBSnkBePOOFmHM7gvgHjLgkilG2YL
         oDJRJ13sRboFvJDFRv5C6XWWTi20HuAIVNPH3rwIlR2hS7RyIUY2DVAS5xLCeZlqYCP4
         ZOhCpIGjSsUSEEslHEvawchRJLZFgiHY9v4RExNexEeV1LmZFsW97OxFzR6AXG5yG1fX
         j1yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697723280; x=1698328080;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BliccIy+de7xYxoFZodWYzkchyJ1PaiIyTfG2nYkRFE=;
        b=qYpd6UQ7Vx2IHBI1i94FtB/AtmrduxLZ5B7MOT7nbapyXMYckeI9PLnn7k1Woz+J3Y
         gl/4fPBKHKMrgH675vNn0uIQmxhL1Ty8vWsSZT+OTuW5mgs3S0wOxICdJxYgqBkT3gx/
         3avGrARrApw4ybPwUB/sxTYrzNMGD+VqgezKbkiXmp78zPrqRA5O+nOaz9u6wTXlkYMB
         5ErjEtdnGxHW+35setK1dqXw6iYgzPFo9Sc/NMQ02W2owIzfpJwwMAPZZbJFd4BjBpgT
         LkM8upLQMDvk+GyioK33243hSwH+nQhRbgqL9iTaGyXAFOw/BKRHB8Qym1w6Zsv6hmfx
         AfgA==
X-Gm-Message-State: AOJu0YxUGKrJ3lCa/xeqDNcF54sl1AG09Zryt+2qzUHLp6RnDQVX5k/l
	dCtIJ3XipNFck0IM/tKSv9ZkJ9rYjZJkFQ==
X-Google-Smtp-Source: AGHT+IFls3pZjV2ctOYZBjQmps7xxPwUMRdJUFsqmphuiHlQtlyJ71NSndQuEO/mqkcOewM5dQq+Fw==
X-Received: by 2002:a05:6a00:1408:b0:68f:fa05:b77a with SMTP id l8-20020a056a00140800b0068ffa05b77amr2241339pfu.31.1697723280325;
        Thu, 19 Oct 2023 06:48:00 -0700 (PDT)
Received: from ubuntu ([122.167.60.51])
        by smtp.gmail.com with ESMTPSA id w28-20020aa7955c000000b0068fe76cdc62sm5252528pfq.93.2023.10.19.06.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 06:48:00 -0700 (PDT)
Date: Thu, 19 Oct 2023 06:47:55 -0700
From: Nandha Kumar Singaram <nandhakumar.singaram@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: Manish Chopra <manishc@marvell.com>, GR-Linux-NIC-Dev@marvell.com,
	Coiby Xu <coiby.xu@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	netdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, kumaran.4353@gmail.com
Subject: Re: [PATCH v2 1/2] staging: qlge: Fix coding style in qlge.h
Message-ID: <20231019134755.GB3373@ubuntu>
References: <cover.1697657604.git.nandhakumar.singaram@gmail.com>
 <cec5ab120f3c110a4699757c8b364f4be1575ad7.1697657604.git.nandhakumar.singaram@gmail.com>
 <20231019122740.GG2100445@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019122740.GG2100445@kernel.org>

On Thu, Oct 19, 2023 at 02:27:40PM +0200, Simon Horman wrote:
> On Wed, Oct 18, 2023 at 12:46:00PM -0700, Nandha Kumar Singaram wrote:
> > Replace all occurrnces of (1<<x) by BIT(x) to get rid of checkpatch.pl
> > "CHECK" output "Prefer using the BIT macro"
> > 
> > Signed-off-by: Nandha Kumar Singaram <nandhakumar.singaram@gmail.com>
> 
> Thanks Nandha,
> 
> these changes look good to me.
> But I would like to ask if not updating
> Q_LEN_V and LEN_V is intentional.

Thanks for the review Simon.

I have already sent a patch for Q_LEN_V and LEN_V and it is accepted
by greg k-h, so didn't updated here.

regards,
Nandha Kumar Singaram

