Return-Path: <netdev+bounces-53258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2959D801D41
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 15:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ED982819E0
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 14:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F6618B1F;
	Sat,  2 Dec 2023 14:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZDMpiuF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E7011C
	for <netdev@vger.kernel.org>; Sat,  2 Dec 2023 06:18:51 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-77dc404d926so180233185a.2
        for <netdev@vger.kernel.org>; Sat, 02 Dec 2023 06:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701526731; x=1702131531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/vd3M27iMTv991NoLV/BszcRpbpnWZ/qNg4aOGoZi74=;
        b=eZDMpiuFyNolCsOqstIsC7v622zVDCqUdl8pOB7IKjk15FE/luuphv3vC9GVOFfoft
         NQEtree1E2DYNuAwyozc0zLQxAX7uwviWGTNEzQGr+0kroziQAuahccxK0bAYxhXxB6r
         dw09v85wvf7Zk301Lj2IU1T+IYRqJuZM7LNa9nefiR3lYdue+QOu9iHItZKQaOngCFfG
         anvNPcce8SIW16h2N2ISvL9oPlmOSl68H9g6YoHifbbNxF/xHzTg3hbzrMwXnhq9AaZz
         fZTr4rfqkQGnZtSGfibkx6RS6/3uusBSDUbrLh2NAR1fen6gmIElfiw9Ea/aRsQxNked
         YKHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701526731; x=1702131531;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/vd3M27iMTv991NoLV/BszcRpbpnWZ/qNg4aOGoZi74=;
        b=tEYONnfuJSwDwvmgRgYY4wpVRRPuxr3wD4u5E5fO75rnC8Vl7ft6a/ZrESPukWY2RF
         QTp+mmhoSxU33GYkAfu2f0DqmLhGRYvq4tpB5UPNwhXM8wtvdYF3D8CjejAPWWoo1GS/
         /kG4rBBtLVgCFvKymK1JtYR0h5Zhv1F5ditJav8c7QoAfDvKH3FEH42b6WgLtrlYT+yi
         yCbue9yI71j8WQBAgmUCW5mX+GjBMvVd5SXzPeOO5PNLwI8BaTA/gO0v70//EHPxz11S
         Zan0OpgN+LzK0YOpxMqUCh0A6CEyCURd/yTP+gTiSrOrpGGBS1gRN8Dj+wzGGFJpjo1O
         oJzw==
X-Gm-Message-State: AOJu0YyT3FdLNtdb38i65bdjtqxq/GGKt9w2gDnXpZK914u1MSHLtf5d
	UXZFZkXqYA5UOj4KuXkzdaA=
X-Google-Smtp-Source: AGHT+IH02f7XiHlNreb0NePwaUMuCWJadadYwzpju2pkrleHETbzTJT+5NlyWapJ1J2Di6HBCLDzAA==
X-Received: by 2002:a05:620a:438b:b0:77d:bdc2:1dc2 with SMTP id a11-20020a05620a438b00b0077dbdc21dc2mr1728309qkp.33.1701526730797;
        Sat, 02 Dec 2023 06:18:50 -0800 (PST)
Received: from localhost (114.66.194.35.bc.googleusercontent.com. [35.194.66.114])
        by smtp.gmail.com with ESMTPSA id ez16-20020ad45910000000b0067aa25438fdsm1084922qvb.40.2023.12.02.06.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Dec 2023 06:18:50 -0800 (PST)
Date: Sat, 02 Dec 2023 09:18:50 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Zhengchao Shao <shaozhengchao@huawei.com>, 
 netdev@vger.kernel.org, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com
Cc: weiyongjun1@huawei.com, 
 yuehaibing@huawei.com, 
 shaozhengchao@huawei.com
Message-ID: <656b3cca535fd_1a6a2c29494@willemb.c.googlers.com.notmuch>
In-Reply-To: <20231202130658.2266526-1-shaozhengchao@huawei.com>
References: <20231202130658.2266526-1-shaozhengchao@huawei.com>
Subject: Re: [PATCH net-next,v2] macvlan: implement .parse_protocol hook
 function in macvlan_hard_header_ops
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Zhengchao Shao wrote:
> The .parse_protocol hook function in the macvlan_header_ops structure is
> not implemented. As a result, when the AF_PACKET family is used to send
> packets, skb->protocol will be set to 0.
> Macvlan is a device of type ARPHRD_ETHER (ether_setup). Therefore, use
> eth_header_parse_protocol function to obtain the protocol.
> 
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

Macvlan does not use skb->protocol in its ndo_start_xmit often. But
does use it once, in macvlan_broadcast, to not broadcast ETH_P_PAUSE
frames.

