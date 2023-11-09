Return-Path: <netdev+bounces-46873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D807E6DF8
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 16:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8B251C208C5
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 15:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597651DA3A;
	Thu,  9 Nov 2023 15:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="B3g/C+h5"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAD1208D5
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 15:47:17 +0000 (UTC)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD1B65FC3
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 07:47:16 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-53d8320f0easo1586788a12.3
        for <netdev@vger.kernel.org>; Thu, 09 Nov 2023 07:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1699544835; x=1700149635; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V86YdR3Hfd873OI39zmWJwzhpNlFt7JR8odQ1dpLszY=;
        b=B3g/C+h5vqBuyoGLCXK0Wy5tg+XNZ/KEDzSCkHcpuwb8NOCS6Kmq4TMferlU4Lp7M9
         y814Aj+ykAKfqBlL1Og7mR3Gg2v35gExL4H6gKtiB6SxyjUWnYkcSgkA8kSj3u4IFErU
         L6n/GHC94dFTGW8i7DYzM8pKrTgbWPvXiQNlPMRm1NSPRzNShZRIO3dfXaZIdcO+W2lJ
         d+vQipqSPfe/IqufCft78Pmf920h6m26N7h4n/ZVRjaHxIArQJ2uZfmlWiPgYCWm75sH
         sv0CGEYCWdaCeDQCsiUZgOZuGPVESn7FeQ1MOjslwYmXuWjMPpo3CQzEsInUCizfjZrg
         ULgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699544835; x=1700149635;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V86YdR3Hfd873OI39zmWJwzhpNlFt7JR8odQ1dpLszY=;
        b=ie+DTXa2AkKa+9HlnTYnU3L7NrWHXx+PfQqITr8W640y/TaCdLKINqAYHmSfhndVnt
         WVF/UnUKOYOgKfDpSSRmtcedUF59ZOKkT6vVAhOtFOFeut7K010/yu3scS2SkJz4uVnI
         DoVX6jmKBDmOETxvTOEbK96tz/xLdACj2bb5reSyCOMk+UZ4S+3d1z5inhdqgMeZFEHj
         mVFbBidJ6n/16E53GwtrsJLdicgraH+oKnNbG+lmKpZSz8GdmCSz4dbIbM/feGcIoJCn
         sGAphcJPdyijQLngMbeomAX67Azw2sCgoXyNo5cdjVo/JKJkJQJgwc02MnlxKXFLoGEw
         ptwA==
X-Gm-Message-State: AOJu0Yw3znSSHf+le3m8sh+Fg2UwnI3AIKaB62IKULMTnqILDskQDq52
	SdK/dxdzLsLzF5FLlb7cZ6Ylmg==
X-Google-Smtp-Source: AGHT+IF6F9GAAxLVxsMGP4dOKKwmzN2I5Tj8yfH0Uqd81zsaR0/UK0fOHyDdH21sTUAUD+0vYB4vaQ==
X-Received: by 2002:a17:907:94cf:b0:9be:2991:81fb with SMTP id dn15-20020a17090794cf00b009be299181fbmr5167814ejc.36.1699544834901;
        Thu, 09 Nov 2023 07:47:14 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id jt6-20020a170906dfc600b009dd7097ca22sm2705598ejc.194.2023.11.09.07.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 07:47:14 -0800 (PST)
Date: Thu, 9 Nov 2023 16:47:12 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Haifeng Xu <haifeng.xu@shopee.com>
Cc: j.vosburgh@gmail.com, andy@greyhouse.net, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] boning: use a read-write lock in bonding_show_bonds()
Message-ID: <ZUz/AB/kdChj5QHE@nanopsycho>
References: <20231108064641.65209-1-haifeng.xu@shopee.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231108064641.65209-1-haifeng.xu@shopee.com>


s/boning/bonding/
?

