Return-Path: <netdev+bounces-25966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9157764C1
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 18:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2681281A3D
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 16:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4061C9E8;
	Wed,  9 Aug 2023 16:12:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DA518AE4
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 16:12:21 +0000 (UTC)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877C91FD8
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 09:12:20 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fe1e1142caso66115305e9.0
        for <netdev@vger.kernel.org>; Wed, 09 Aug 2023 09:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691597539; x=1692202339;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WbDeNlEYWPdJoa3ceoarX3ZLlHYavqyNcnCfDnanXgo=;
        b=QYatahhD01q8vy7Vlg55LYfrw577ssatvXKDIv2B7Yb7ANEFudV3q73Ct/fJf3Crfe
         if303lJhGpiFCcj/akfOzR2LIDxb7/qEwVpFtKUIUdnJ/F2rwVhsCzKW3inYE9Bobebg
         EFW2IG+nSbWh7uq/G8NP/piqERpOrxjwzoBg35RvYuqao1kLrqs9s/zw6R2boHIgzQM7
         tKeq9rEsEQSte26yDz1PrlI713TksZU23tQW4zx31v30zIZs7g8fYVageP+U8jJ8mdiA
         TOGCmuPy8rVqqU2YfjRpqdYB+8wax+jvyE7/+xlEbxFGbmm5uHpAviW16mKkGC7t0czf
         nbjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691597539; x=1692202339;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WbDeNlEYWPdJoa3ceoarX3ZLlHYavqyNcnCfDnanXgo=;
        b=VMWHyRJx3shbbcxn7TloNPmrWOpGLmp2G8Xo/g1QyTwPb38PExOeLa9RbxtQHqWql6
         6oypPfYmrhVvjzszsC1ogcA6CZIqpvaQ27L8d5UMq5wbEao9ghaERQF2TiLGtHd0tAOh
         RIb9bmXYGLFeH84+F1mrsW4vOy5P0dzlfBfaEbqSFzaakXojiIFnr2vXabIY1Zt2sMyO
         yszazladvHFVgwwyNukcldJrXQYuull3IvAdcxut9rz1JFZkPN/nybgaQaa228pEz5w8
         48CX+sUZnf2yUSePfzeQv7W/kWxEjfekWtOiGFcRiSWIQs4KC0h9BpxN1lGwrccb0tdS
         dqyQ==
X-Gm-Message-State: AOJu0YyMhfCHlF3GgtwjGiFadbYvtHlq0/yUEdSSR+Wi/P+l3VKFr1Ex
	rkCnkxSe7hy6v3Gm+Q6xFU1t0lOA/+c=
X-Google-Smtp-Source: AGHT+IFrBEQhf/s3Eyr4vUu+MqgDniTYomXM699VoOAoZCkRnX7nhlJUb6chgqK2HmzVyyHUfN1HWg==
X-Received: by 2002:a05:600c:228a:b0:3fe:2120:a87a with SMTP id 10-20020a05600c228a00b003fe2120a87amr2566072wmf.37.1691597538573;
        Wed, 09 Aug 2023 09:12:18 -0700 (PDT)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id s13-20020a7bc38d000000b003fc0505be19sm2419069wmj.37.2023.08.09.09.12.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 09:12:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 09 Aug 2023 18:12:17 +0200
Message-Id: <CUO5A4R7X3NQ.38YMATQUB5CJQ@syracuse>
From: "Nicolas Escande" <nico.escande@gmail.com>
To: "Ido Schimmel" <idosch@idosch.org>
Cc: <stephen@networkplumber.org>, <netdev@vger.kernel.org>
Subject: Re: [iproute2,v2] man: bridge: update bridge link show
X-Mailer: aerc 0.15.1
References: <20230804164952.2649270-1-nico.escande@gmail.com>
 <ZNIowqAsMJhhUtoq@shredder>
In-Reply-To: <ZNIowqAsMJhhUtoq@shredder>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue Aug 8, 2023 at 1:36 PM CEST, Ido Schimmel wrote:
> On Fri, Aug 04, 2023 at 06:49:52PM +0200, Nicolas Escande wrote:
> > Add missing man page documentation for bridge link show features added =
in
> > 13a5d8fcb41b (bridge: link: allow filtering on bridge name) and
> > 64108901b737 (bridge: Add support for setting bridge port attributes)
>
> FYI, the convention is to refer to a commit in the following format:
>
> 13a5d8fcb41b ("bridge: link: allow filtering on bridge name")
>
> See [1], near the end of the section.
>
> [1] https://www.kernel.org/doc/html/latest/process/submitting-patches.htm=
l#describe-your-changes
>
> > Signed-off-by: Nicolas Escande <nico.escande@gmail.com>
>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
>
> Thanks

Damn, I did read it but I missed the double quotes indeed.
If needed I can respin it.

