Return-Path: <netdev+bounces-45615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC007DE940
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 01:18:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87935281291
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 00:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410DB39D;
	Thu,  2 Nov 2023 00:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKkP9IYb"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB0B7E
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 00:18:48 +0000 (UTC)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E34FDB;
	Wed,  1 Nov 2023 17:18:47 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6bcdfcde944so94208b3a.1;
        Wed, 01 Nov 2023 17:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698884327; x=1699489127; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s8957ZXAMokJVu3Z7wnJ8VE74hgqLOzUJ6al4SM64Ng=;
        b=JKkP9IYbru2m2sGLIKUPz/TIVekLUsqWanPUqh5f8Ht0fOUS1yxZyAd0MjiNirMb7u
         0uCJD17ETntvRXi015vO+xfzMvM2BVk7k8PWSGEa7WhmumWfIeuC6SjzIu+Q7LfchdY4
         Lkvn6e74KrAQlxEO0USCjRY+n74vi7Dm1ldUFhfd4bQQyJFYmDyqOXuwS+BY3COnU8zt
         PTUNSpwFpqK+V//oiEVBzwKt5z2XAd8VmUj9JO780C6vsHL9aqiIcSSEaQKZkW5TEDwO
         CAL4Cm4JrEgPN/Ewz6lCyC/cvT+Pid1A2fTD7bj3xngWC8l//k2dXlY/kIn8xGtudWgt
         VClg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698884327; x=1699489127;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s8957ZXAMokJVu3Z7wnJ8VE74hgqLOzUJ6al4SM64Ng=;
        b=gpBBclWMdjx6c/zXCSIxkYGExGABZuCV9xGDy25rayHQcdX4MktB39sd/jMfr+MDzt
         gcHu8kZJwBohIC6NCFriN+YRNi80a4uPBoxOA3P54sNdQdQBocJgiTlh7mvbSU4c07Y9
         unk29A+3/EGD+bvSA6h+JDnAxCjqBZC7J99NEBuX4qUQPwI4dK8xmsxiwShc3cAU/3rJ
         RL/+X/67jzW0TQxzXR2e2ArCZdFdsA8ymn1Hm3Gr1xsfjZohtNh6wQTmKK+xXzNTSBAe
         nIOGzNq3ZcUQq1SJ6Uq1EcSG3PWLyr8UCR+0OtitpCECZzcBfTj4LNz/nGr/qKuPWpEh
         xxug==
X-Gm-Message-State: AOJu0Ywd3jpry52lZdooUO2F45DvevLkE4401LzyKONRJq32wJ1Ndhfk
	4tsUeKovcOVzVB5IlE6Hg5Q=
X-Google-Smtp-Source: AGHT+IFflYaHUWBqCJRXS9+gKRfaZkgRQi57kLnq0Fw4deD2a8UANa0uI1zHkwc6lO2flirPhblOmA==
X-Received: by 2002:a05:6a20:2d22:b0:163:c167:964a with SMTP id g34-20020a056a202d2200b00163c167964amr20592204pzl.1.1698884326940;
        Wed, 01 Nov 2023 17:18:46 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2601:640:8000:54:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id l13-20020a056a00140d00b006c2fcb25c15sm1583592pfu.162.2023.11.01.17.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 17:18:46 -0700 (PDT)
Date: Wed, 1 Nov 2023 17:18:44 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Edward Adam Davis <eadavis@qq.com>
Cc: habetsm.xilinx@gmail.com, davem@davemloft.net,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	reibax@gmail.com,
	syzbot+df3f3ef31f60781fa911@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH net-next V2] ptp: fix corrupted list in ptp_open
Message-ID: <ZULq5ILoM07oH1wr@hoboy.vegasvil.org>
References: <tencent_2C67C6D2537B236F497823BCC457976F9705@qq.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_2C67C6D2537B236F497823BCC457976F9705@qq.com>

On Tue, Oct 31, 2023 at 06:25:42PM +0800, Edward Adam Davis wrote:
> There is no lock protection when writing ptp->tsevqs in ptp_open(),
> ptp_release(), which can cause data corruption,

NAK.

You haven't identified any actual data corruption issue.

If there is an issue, please state what it is.

Thanks,
Richard



