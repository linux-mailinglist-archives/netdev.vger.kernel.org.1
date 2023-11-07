Return-Path: <netdev+bounces-46352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2B37E3519
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 07:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B43B1B20B67
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 06:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFACF947A;
	Tue,  7 Nov 2023 06:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQadve3r"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C37E323B
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 06:13:31 +0000 (UTC)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79170119;
	Mon,  6 Nov 2023 22:13:30 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6c343921866so792349b3a.0;
        Mon, 06 Nov 2023 22:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699337610; x=1699942410; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kp7jbiihYbJYm0zzWTzb+AIe0679YmZMzyU1A+ycvSI=;
        b=QQadve3r6mE9ARcVpgO1YwH8yQCycCkEtLSsjXyFf4M7QV8JubnAIxbu3myWMinL9E
         5UjkcsMyATqDgAFLW7kgvylKWveTv4FxoBlpC/+V/RzsEb5oq6EtXJBLTO+B0OaOQmzy
         yCRo4G0QnLxzhDBP6nhf/fj3jZDzwn+V911d/P1mqdzwLNnT6GNsdM3r2L9NbzIlFeKl
         NeryydE0drGYchglywTKJV2fxZ9C4CfSmo2US5SYjfyVpGLzkcfE0nOkYkKWoqo10IbP
         bA1nmwSMQ8kJsLgcvnxOEm1axmJLv3SdQ6RcDKXZfDw0k3cX2MUfVFq3BbJFjLlaezsu
         fdlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699337610; x=1699942410;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kp7jbiihYbJYm0zzWTzb+AIe0679YmZMzyU1A+ycvSI=;
        b=KcctOlfghmL43kgpB8A5dqVhwcLUgNk63MsHCvvb2jLTmlFwYSUT9lBxzEfE/VdRhh
         z4sLSxqGSNh9ElwYSWKdOtr8Q0cIxF2s4wK/hAx0hD7qmdQGYxczupyuGR8JGHegFRub
         hvUuUfQOHb718GJqUbgf86v+AgPoMoYONDuJSpZGK34yBRS72Nvk21v4lQeF1mbxNql4
         A1KgL5tTw4LJv+u5AeD3yaw6llyv7mAPqgCx/GvwGDvPQCm/RhCoNGfOapoOhzyUC8L3
         89Wq5gjICsEUp0baKYz+WdXOrxi/Eg3oDfARJWNzCYzguX1x9uQI3uhTRzXVbZekxzuu
         R3Wg==
X-Gm-Message-State: AOJu0YzbHY58TzwS+M2GCklHxox8ygbDf5VOEiI9/iZ7l12sVebW97nc
	6zgLU5Wc5nQbly8EIzN5ueM=
X-Google-Smtp-Source: AGHT+IHJ/zV7B/Knw714zPDTcGbgSSiBPrlmkDERaU69DQfdwqHRcNkkQLHXZpmLDrcX3vrWpmJpJw==
X-Received: by 2002:a05:6a00:4a81:b0:6bc:ff89:a2fc with SMTP id dr1-20020a056a004a8100b006bcff89a2fcmr29866425pfb.2.1699337609931;
        Mon, 06 Nov 2023 22:13:29 -0800 (PST)
Received: from hoboy.vegasvil.org ([2601:640:8000:54:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id gx18-20020a056a001e1200b006933f504111sm6692681pfb.145.2023.11.06.22.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 22:13:29 -0800 (PST)
Date: Mon, 6 Nov 2023 22:13:27 -0800
From: Richard Cochran <richardcochran@gmail.com>
To: Edward Adam Davis <eadavis@qq.com>
Cc: davem@davemloft.net, habetsm.xilinx@gmail.com, jeremy@jcline.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	reibax@gmail.com,
	syzbot+df3f3ef31f60781fa911@syzkaller.appspotmail.com
Subject: Re: [PATCH net-next V8 2/2] ptp: fix corrupted list in ptp_open
Message-ID: <ZUnVhxktZCpFYwEg@hoboy.vegasvil.org>
References: <20231106143127.3936908-3-eadavis@qq.com>
 <tencent_1372C3B5244E7768777606C0F36563612905@qq.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_1372C3B5244E7768777606C0F36563612905@qq.com>

On Mon, Nov 06, 2023 at 10:31:28PM +0800, Edward Adam Davis wrote:
> There is no lock protection when writing ptp->tsevqs in ptp_open() and
> ptp_release(), which can cause data corruption, use spin lock to avoid this
> issue.
> 
> Moreover, ptp_release() should not be used to release the queue in ptp_read(),
> and it should be deleted altogether.
> 
> Reported-and-tested-by: syzbot+df3f3ef31f60781fa911@syzkaller.appspotmail.com
> Fixes: 8f5de6fb2453 ("ptp: support multiple timestamp event readers")
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>

(This should go to net and not net-next.)

Acked-by: Richard Cochran <richardcochran@gmail.com>

