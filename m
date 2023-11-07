Return-Path: <netdev+bounces-46378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7537E365D
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 09:08:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4228B20B7C
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 08:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6862D512;
	Tue,  7 Nov 2023 08:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nOq+TIFd"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6442563D8
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 08:08:13 +0000 (UTC)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702C2129;
	Tue,  7 Nov 2023 00:08:08 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6b497c8575aso5693566b3a.1;
        Tue, 07 Nov 2023 00:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699344488; x=1699949288; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ttXqTP+4Vn5umWykt6+NuZt9O79QAnsU1LGP6YXU9Zk=;
        b=nOq+TIFdoZ9YDPP6S06U/qln8h+8+p6GvQ9CIwjanfZOItZ59CZ5730n/8+j6wMtSn
         65AFjC0Dcx1BejqRVFEBt+zXcBdSJ9w0L3FOetiD6uv1MesuUHognXnb24/zA8QUOC5I
         1j3106UoIN2lLkaZ5Lb86MVs7VerS9YwczgdUo7SMSz39N00kSKwQuMHpk1OPHJj+PJE
         zCfRo4HGjhJ3rp9mP/OlVscGeLcWZuXB3o8KU4Uf1vxeYZfQ+Ex0q9MtRQ6jwoi5CxuX
         OXZvkAp2zmWGhrJZhkKqccknNsdfmYDTHJqIp34d/3/KD9qxLjJnvnqH9N10qCsWHCxi
         VPhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699344488; x=1699949288;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ttXqTP+4Vn5umWykt6+NuZt9O79QAnsU1LGP6YXU9Zk=;
        b=uyAPvyOJXKtM6CLlOHeG16KWN/3myp95PAMCK+X59RoHXdpH5vG8MWxwjtZB/MoOTZ
         rAAJNtE3ROPcwB4qMp2DNtn1jpZPA6SwYzlOm+4UA1ErbtarUWm14JV7ypqi8bXJKqe4
         3ujcNYtSzVYINsOWxgs1Cx6DSrEO7/r5/b7eg3jUTUPWlSvkhmuqPskxbOVklVDOeav+
         c8PtqFxeVHGRPhWtngjTIp4rAz80HKlv4TyFNzqPfEtScUV4T99En2zK9miMBz2Mm4hZ
         QaZtHcY54oLpCykP3VFf19bcsmQijsb1bOxpx5oKjVKQ2vGTUgW6ZEDOhgljlUWZfXQT
         cmkA==
X-Gm-Message-State: AOJu0YyXMa+JccRA+g3xN2QIgOSX7/GQQzbuJXXqTevU7boPE3XdpNLV
	ZxzWQvNj8ri2yHONtVQWqIyjG+z5cPeJ0A==
X-Google-Smtp-Source: AGHT+IGC5IkahBSjMohONTov0dfX7L8VtsuNs4X0P2KeXZfzd3gzSmHwdNM2Jbr2u4FrddXTkIPd/Q==
X-Received: by 2002:a05:6a00:2d09:b0:6bc:f819:fcf0 with SMTP id fa9-20020a056a002d0900b006bcf819fcf0mr37849993pfb.1.1699344487663;
        Tue, 07 Nov 2023 00:08:07 -0800 (PST)
Received: from dragonet (dragonet.kaist.ac.kr. [143.248.133.220])
        by smtp.gmail.com with ESMTPSA id w2-20020a056a0014c200b0069ee4242f89sm6941581pfu.13.2023.11.07.00.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 00:08:07 -0800 (PST)
Date: Tue, 7 Nov 2023 17:07:03 +0900
From: "Dae R. Jeong" <threeearcat@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: borisp@nvidia.com, john.fastabend@gmail.com, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, ywchoi@casys.kaist.ac.kr
Subject: Re: Missing a write memory barrier in tls_init()
Message-ID: <ZUnwJwuqZMFNYE3x@dragonet>
References: <ZUNLocdNkny6QPn8@dragonet>
 <20231106143659.12e0d126@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231106143659.12e0d126@kernel.org>

Hi, Jakub,

Thank you for your reply.

On Mon, Nov 06, 2023 at 02:36:59PM -0800, Jakub Kicinski wrote:
> On Thu, 2 Nov 2023 16:11:29 +0900 Dae R. Jeong wrote:
> > In addition, I believe the {tls_setsockopt, tls_getsockopt}
> > implementation is fine because of the address dependency. I think
> > load-load reordering is prohibited in this case so we don't need a
> > read barrier.
> 
> Sounds plausible, could you send a patch?

Sure. I am doing something else today, so I will send a patch tomorrow
or the day after tomorrow.


> The smb_wmb() would be better placed in tls_init(), IMHO.

It sounds better. I will write a patch in that way.


Best regards,
Dae R. Jeong

