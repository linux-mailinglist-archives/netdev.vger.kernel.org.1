Return-Path: <netdev+bounces-38803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD7F7BC8BA
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 17:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34AFD281C53
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 15:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947412E643;
	Sat,  7 Oct 2023 15:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k5o+pEhe"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16746DDC8
	for <netdev@vger.kernel.org>; Sat,  7 Oct 2023 15:44:14 +0000 (UTC)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F0EBC;
	Sat,  7 Oct 2023 08:44:13 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40675f06f1fso24945295e9.1;
        Sat, 07 Oct 2023 08:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696693452; x=1697298252; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=V6Z5TerGNyehqM1iknsGWSFNCfXFAQQJnxB4zmAfJjM=;
        b=k5o+pEhe2v7ld13voD6aXTw093Y9u/bgNjH3D7YLy+fDBVoIVbc7G3jacWV1ma9SLP
         y9Nsypuzk6DNbU2nY8GFGJ3m92TkMPkUNkpjv5h5AziFAHBnK+YZIgr1CVt8La2/HXgm
         RRx2azwfuYZifg21PSSL8fVEawQ6OljjSc8b/FsH2jwb+dnM9tkA9JItJesrMGSAb/tb
         KSUcHSLeBkHT4BDvtMRr9W2EjURO5M7ShgN2sdggZIdvvBxiZPGfDFbl7CzxXrF2JNn4
         Q/PNWXl/RbaZBLXxco5uxu3XTg8fdPjFcJZleVg9f8n9mENhxt047pMO5h5Wkv4D9DUh
         Q+8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696693452; x=1697298252;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V6Z5TerGNyehqM1iknsGWSFNCfXFAQQJnxB4zmAfJjM=;
        b=BWFxgWPTkQSwM6lq5Fvo2nR9CFy/RQ2MQL3SxmTyIML7XJWR1WJo1CvrfKXtHjAYFf
         Vu84ebfe7pkDggRnSG0z/F81tPy3w8k70TVKzeS8rFfpnWMEfbJharjEzlTHxPEMdhXK
         3WyMuVop+/JIQbrI3rZLUdlQVaPDbznrgVQBSdsicFMCumF9d3+XMa0MOlgUKwl8CB61
         6Cbw43z3B9l4UAJayKMIAlu/bfhAQoQQ0ZIs8/GRua+exnk9ERbG/V3xyt/8dUqHlTxA
         k7CvOVnUM2AjltOnLWg8/IdHe9Uv0uf/6XwxjzFPOiymNDH18++Bls2h9t9uwRFA/RL3
         682A==
X-Gm-Message-State: AOJu0Yz+5dvVg/Vtc5rPwL5mPu1dvbVA5PUYp4xAaqdFluBfoUqQDTqh
	v/3rIzo+1cBo8Y1biCnWDZNhdjcYNv1wVPAThPM=
X-Google-Smtp-Source: AGHT+IGZrOp/akTMCs9YVCmQd8cDLyrbyRcRdlG4EG6CvG09DIY0ZqWAh+MaTcMWdILxTKUTdgJEBZn6Ge5/h3kGa6w=
X-Received: by 2002:a5d:428b:0:b0:323:3b45:c452 with SMTP id
 k11-20020a5d428b000000b003233b45c452mr5978552wrq.14.1696693451518; Sat, 07
 Oct 2023 08:44:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231005072349.52602-1-dg573847474@gmail.com> <20231007151021.GC831234@kernel.org>
In-Reply-To: <20231007151021.GC831234@kernel.org>
From: Chengfeng Ye <dg573847474@gmail.com>
Date: Sat, 7 Oct 2023 23:43:59 +0800
Message-ID: <CAAo+4rWTq33LWgVonaK+AtZ0o_UYFLrM=ODW=hSX_VtgLvYHNw@mail.gmail.com>
Subject: Re: [PATCH V2] ax25: Fix potential deadlock on &ax25_list_lock
To: Simon Horman <horms@kernel.org>
Cc: jreuter@yaina.de, ralf@linux-mips.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	linux-hams@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Simon Horman,

I think maybe not. My static analysis tool only reported this function, I
also just manually checked the spin_lock(&ax25_list_lock) in other
functions, and it looks like they are basically under rcv callback or timer,
which already have BH disabled. I think the developers who wrote
the code should be aware of this so they used spin_lock() instead of
spin_lock_bh().

But the fixed function is a bit different, as it could be called from .ioctl(),
which is from userland syscall and executes under the process
context, and along the call chain BH is also not disabled explicitly. That's
the reason why only at this place I change to spin_lock_bh().

Thanks,
Chengfeng

