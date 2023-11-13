Return-Path: <netdev+bounces-47542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C107EA723
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 00:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7A8E280F74
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 23:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267413E461;
	Mon, 13 Nov 2023 23:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="GAzwpJec"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3780C3D988
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 23:38:33 +0000 (UTC)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80DD2D6C
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 15:38:31 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-2802c41b716so4321204a91.1
        for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 15:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1699918711; x=1700523511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YGVDrs1dPOe05s0Ikf2zO3iHd4KSPZQpgv/WPATEGYk=;
        b=GAzwpJecV4hWjeC9Rb5z8FhLPrRhhCcaPsr3ki3cXM7cYEGnapVmnbq48pBXcZfpHV
         ntd35dUzzWqG1AQUR9ovsjb8IGafrnpfduAdQyti2XzCb1dLAxt0nhrPpzaHFFu2tM32
         DRfjGksl7JYLx65/GLpHLqaAaiTAviA2jzRWhIcqU79WaHVQSegQ2SncbFbUa6pS5itA
         km8ykEc7PtCAGW5ucvApNFpB8YxtxQ3jn+oidPG6cEaOpxgwpDQpc1PR1LCgE67O4YzZ
         MGJdosXDMJf8xz302GEFVLcQMj8z98ugUpROa3DZQPuKcYbPKahXAE9kRoWzaldKzYso
         Pvyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699918711; x=1700523511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YGVDrs1dPOe05s0Ikf2zO3iHd4KSPZQpgv/WPATEGYk=;
        b=RpYhISD/FyDOjUw5ATFtTtcEugodhoQMJdHTfwfc7WbIdLliaHiQBaY8sMbNa5npRi
         BPTUt5vOHk52Q9CAnoor2/LOSNcwomnMuULEfL20DUxCXXfPUlUHxFnoXTteT4fV3l2S
         KVpd9e++Xds2zC9h8C/p5uI4L4s6GuZCyjtw2syrfc3gLIDi4k1GcQ906SAp7Fv1sS/E
         Y6rb1SG0JXcYULLjXUXHjcWf2zjYvEFhqft9d1CqsLve8m5mwxjgnY2/D21FE8MZdmZ8
         beZdpeg8Fk1up6hvCbMpY2mtZhUBRrjm2Qtva5Fxx5C6GMG/CsR4D6k0qzFiulIOJmyA
         iFow==
X-Gm-Message-State: AOJu0YwuLbU5KEeywok5Kjg0js66+kwrY3omOwEQimtp78SftO3yPIIX
	7cRUa5Xe3XWDmywD7zH5UslOZg==
X-Google-Smtp-Source: AGHT+IGKDTbhiQLtd2EaTcDhXIkTP+MdZvEa1SZy1Glq5U4jiWPEFNINTxjziLJd/vZmxGuJuXlDgQ==
X-Received: by 2002:a17:90b:1651:b0:27d:6d9c:6959 with SMTP id il17-20020a17090b165100b0027d6d9c6959mr5458555pjb.25.1699918710978;
        Mon, 13 Nov 2023 15:38:30 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id l16-20020a17090aec1000b002800d17a21csm6071959pjy.15.2023.11.13.15.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 15:38:30 -0800 (PST)
Date: Mon, 13 Nov 2023 15:38:28 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Andrea Claudi <aclaudi@redhat.com>
Cc: Luca Boccassi <luca.boccassi@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH iproute2] Revert "Makefile: ensure CONF_USR_DIR honours
 the libdir config"
Message-ID: <20231113153828.31ebef51@hermes.local>
In-Reply-To: <ZVJnKjhLm-MiHn6e@renaissance-vector>
References: <20231106001410.183542-1-luca.boccassi@gmail.com>
	<169989362317.31764.14802237194303164325.git-patchwork-notify@kernel.org>
	<ZVJnKjhLm-MiHn6e@renaissance-vector>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 Nov 2023 19:12:58 +0100
Andrea Claudi <aclaudi@redhat.com> wrote:

> On Mon, Nov 13, 2023 at 04:40:23PM +0000, patchwork-bot+netdevbpf@kernel.org wrote:
> > Hello:
> > 
> > This patch was applied to iproute2/iproute2.git (main)
> > by Stephen Hemminger <stephen@networkplumber.org>:
> > 
> > On Mon,  6 Nov 2023 00:14:10 +0000 you wrote:  
> > > From: Luca Boccassi <bluca@debian.org>
> > > 
> > > LIBDIR in Debian and derivatives is not /usr/lib/, it's
> > > /usr/lib/<architecture triplet>/, which is different, and it's the
> > > wrong location where to install architecture-independent default
> > > configuration files, which should always go to /usr/lib/ instead.
> > > Installing these files to the per-architecture directory is not
> > > the right thing, hence revert the change.
> > > 
> > > [...]  
> > 
> > Here is the summary with links:
> >   - [iproute2] Revert "Makefile: ensure CONF_USR_DIR honours the libdir config"
> >     https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=deb66acabe44
> > 
> > You are awesome, thank you!
> > -- 
> > Deet-doot-dot, I am a bot.
> > https://korg.docs.kernel.org/patchwork/pwbot.html
> > 
> >  
> 
> Hi Stephen, actually Luca and I agreed on a different solution, see
> "[PATCH iproute2] Makefile: use /usr/share/iproute2 for config files".
> 
> I can rebase that patch on top of this one, if this is ok for you.
> 
> Regards,
> Andrea
> 

Send a new patch please. 

