Return-Path: <netdev+bounces-46974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3CA07E7835
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 04:44:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F7941C20C4B
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 03:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D4415CE;
	Fri, 10 Nov 2023 03:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eLMIjW+b"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88561841
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 03:44:11 +0000 (UTC)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714FB44BD
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 19:44:11 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-28010522882so1430084a91.0
        for <netdev@vger.kernel.org>; Thu, 09 Nov 2023 19:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699587851; x=1700192651; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CHHcvwkC1mr6DXnHkiARJ5tVdxC+DzxsIHK7L1bvxIY=;
        b=eLMIjW+b82b1GUDbPU7ztS+qO/BQjpk1TDFgOn9Y5ne7T4oMlPy5OYc7uIYxcID8al
         AaJCb44uXFfatbyx1eme1X4zFIxTfFx09U4wPU0N60Ho6w4pQ+9dVKnHeb2sF5HSgO4c
         cXoKg51LOfMHw5+M2E7W1kYkSlA7y2Ww5t0nL8IRTnby38OGi1IaIjJSokUVmYqHAWEh
         1Us+/3adItbhX/y7rMRzLFfUtHLw1evPrNi7UYo14B2kLUIgSDMnd3HlYFMoe+nvJ1aL
         JV4cb7aEBr0tUv5Y68wpAoWrlCjiHOoypk3pLGp9qI1G3qvf6rWZGxBpN2temvnjs7yV
         Nm5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699587851; x=1700192651;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CHHcvwkC1mr6DXnHkiARJ5tVdxC+DzxsIHK7L1bvxIY=;
        b=gtAdGzaYfQageuP5jCNx9/l7vut+gSHLB00TkZW12U+UlhHgp8cNYMdsQedhUt9oTj
         qUjRPn8Z3tQrK+GLkod2Gvm/PTodVqmKbHk+iODsUPC7BzgwMZdR9pJNpb9NX0AcQJzl
         5LybkK32HhTpELNyBa/7bmDBhasSRYfSyvjnATHGrbK3fGutcP3dLjyTtWaZ0e0EXg3E
         IfuDJ/gjjqDnIA27EYxxLig2+o/TQV8hR8nhdsMES7IQpncSflX6aJEbWeurU12poksH
         nl70RJ7wyuUt7EudY8Dl1kw1egfWzxkDY2hrT/44mVAKRNTbiTsmj1Gt06eJeMAMhuKc
         gz7w==
X-Gm-Message-State: AOJu0Yz3sXwnbQsWN/HZqcNXyZVYDQtiJuqMkP6gRoWM3YLrLdam3lja
	0NjSFPuuVeGncHjwQUCBxeQ=
X-Google-Smtp-Source: AGHT+IFm6Foe57Xu/EvDNWO2LAT4m1cJoeBowVSVm5C52tTy/PXbdToHNLnM1LxTFZF6/5IiwBF2mA==
X-Received: by 2002:a17:90b:4d09:b0:283:84c:3871 with SMTP id mw9-20020a17090b4d0900b00283084c3871mr985602pjb.3.1699587850821;
        Thu, 09 Nov 2023 19:44:10 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id t6-20020a1709027fc600b001c444f185b4sm4352710plb.237.2023.11.09.19.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 19:44:10 -0800 (PST)
Date: Fri, 10 Nov 2023 11:44:06 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jay Vosburgh <j.vosburgh@gmail.com>,
	Andy Gospodarek <andy@greyhouse.net>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com, syzbot <syzkaller@googlegroups.com>
Subject: Re: [PATCH net] bonding: stop the device in bond_setup_by_slave()
Message-ID: <ZU2nBgeOAZVs4KKJ@Laptop-X1>
References: <20231109180102.4085183-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109180102.4085183-1-edumazet@google.com>

On Thu, Nov 09, 2023 at 06:01:02PM +0000, Eric Dumazet wrote:
> Commit 9eed321cde22 ("net: lapbether: only support ethernet devices")
> has been able to keep syzbot away from net/lapb, until today.
> 
> In the following splat [1], the issue is that a lapbether device has
> been created on a bonding device without members. Then adding a non
> ARPHRD_ETHER member forced the bonding master to change its type.
> 
> The fix is to make sure we call dev_close() in bond_setup_by_slave()
> so that the potential linked lapbether devices (or any other devices
> having assumptions on the physical device) are removed.
> 
> A similar bug has been addressed in commit 40baec225765
> ("bonding: fix panic on non-ARPHRD_ETHER enslave failure")
> 

Do we need also do this if the bond changed to ether device from other dev
type? e.g.

    if (slave_dev->type != ARPHRD_ETHER)
            bond_setup_by_slave(bond_dev, slave_dev);
    else
            bond_ether_setup(bond_dev);

Thanks
Hangbin

