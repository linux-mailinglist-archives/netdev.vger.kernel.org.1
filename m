Return-Path: <netdev+bounces-39447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B2657BF455
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 09:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07040281A6A
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 07:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64548D2F6;
	Tue, 10 Oct 2023 07:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="jGNBxfw1"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E419463
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 07:31:25 +0000 (UTC)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E48392
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 00:31:24 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-50437c618b4so6675969e87.2
        for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 00:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1696923082; x=1697527882; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fChJqx5cBSonhxzgazgc/CDqonE95T5jrDr9t24bTwY=;
        b=jGNBxfw12t6KDgK+H+g6TStcQv3vLaEE5cM7Tpz0/euEHP0yNBLDKBBp3qGf3R3IuO
         GSvFHdKQmqoN9VniAzUCGJL8XPyIB1p/Ig8T7XH4L3rLOqENqKFqGrj9pjb+gGBXsmxC
         IFbl4tfMVfcJEKFwO14UoDYN/ZCgUfPZayQED3/s3rfV/Elg2Lewz69byyWzjNfQamp3
         89adZ8FiJLyQgY/hnK5IlahCfrnsPDIxyys5XYfbe3ybrqo4WatgdgPCa0sV5gEdZPFe
         gM9BUWZsWs+koBhWB7E5FtxrphkNl8EQP6bX8BGJx1VMGIRm28/tZg/UMRUbINCQkXjY
         mnAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696923082; x=1697527882;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fChJqx5cBSonhxzgazgc/CDqonE95T5jrDr9t24bTwY=;
        b=N1V1L+yPdSWymVlLu+2k7xNkWPq9UkpPw/2+aNFcWJw6y8xw2VDzZ+/rpNk24aS2GI
         Lnpvh932ImG1jrEmSyCPURaOZVeZqS0SkW+s+toemrsF/e13jCgGGHXx6F/SXQot7xX9
         ac7MbBRoO+7LOg3AwhP75+bfMPdYmw99TSSZ8h6Jr7eyVyuppsme2hY0FRee1+MneZOS
         NyuoFobN7/qUZraZm3QA9XcvGJOIHck7s54e+2YcX7tRJLAl975E1uPi9p6V60vqgcvY
         vrpNEr2JLXRh4BwFGGwDnR03wWEGFL49L49dYyiKKDdN/yjarMNf/dvR+PfXYlwikS4O
         JDTw==
X-Gm-Message-State: AOJu0YwIY6mIIhiR39eKg8/xUE5ZBkdWedstRT2ZDdYZtsZr4nAAfrHi
	nGGz2QdpApWXR+4YvHSNRh2qDQ==
X-Google-Smtp-Source: AGHT+IFWj7xyqqt3wBYj5wrlLAxyQ2P2Xc+cdtIhu5CVzxQrTqP2u7GpgqCEEXD7decz+bT/o70Y5w==
X-Received: by 2002:a19:910d:0:b0:501:ba04:f34b with SMTP id t13-20020a19910d000000b00501ba04f34bmr12955485lfd.44.1696923081904;
        Tue, 10 Oct 2023 00:31:21 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id f19-20020a1c6a13000000b00402d34ea099sm15451822wmc.29.2023.10.10.00.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 00:31:21 -0700 (PDT)
Date: Tue, 10 Oct 2023 09:31:20 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com, gal@nvidia.com
Subject: Re: [patch net-next] devlink: don't take instance lock for nested
 handle put
Message-ID: <ZST9yFTeeTuYD3RV@nanopsycho>
References: <20231003074349.1435667-1-jiri@resnulli.us>
 <20231005183029.32987349@kernel.org>
 <ZR+1mc/BEDjNQy9A@nanopsycho>
 <20231006074842.4908ead4@kernel.org>
 <ZSA+1qA6gNVOKP67@nanopsycho>
 <20231006151446.491b5965@kernel.org>
 <ZSEwO+1pLuV6F6K/@nanopsycho>
 <20231009081532.07e902d4@kernel.org>
 <ZSQeNxmoual7ewcl@nanopsycho>
 <20231009093129.377167bb@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009093129.377167bb@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Mon, Oct 09, 2023 at 06:31:29PM CEST, kuba@kernel.org wrote:
>On Mon, 9 Oct 2023 17:37:27 +0200 Jiri Pirko wrote:
>> >I think kernel assuming that this should not happen and requiring 
>> >the PF driver to work around potentially stupid FW designs should
>> >be entirely without our rights.  
>> 
>> But why is it stupid? The SF may be spawned on the same host, but it
>> could be spawned on another one. The FW creates SF internally and shows
>> that to the kernel. Symetrically, the FW is asked to remove SF and it
>> tells to the host that the SF is going away. Flows have to go
>> through FW.
>
>In Linux the PF is what controls the SFs, right?
>Privileges, configuration/admin, resource control.
>How can the parent disappear and children still exist.

It's not like the PF instance disappears, the devlink port related to
the SF is removed. Whan user does it, driver asks FW to shutdown the SF.
That invokes FW flow which eventually leads to event delivered back to
driver that removes the SF instance itself.


>
>You can make it work with putting the proprietary FW in the center.
>But Linux as a project has its own objectives.

