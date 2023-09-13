Return-Path: <netdev+bounces-33473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D3F79E141
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 09:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7C4E1C20C04
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 07:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F9F1DA36;
	Wed, 13 Sep 2023 07:56:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1BC1DA35
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 07:56:41 +0000 (UTC)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91CAF1729
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 00:56:40 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-307d20548adso6591594f8f.0
        for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 00:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1694591799; x=1695196599; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jjsp6nkt43jk36+kNehSmi8qVwyQVy4Drdrq5tRKp4g=;
        b=k/HZ2JVV02eu7SCzJ9rDblj+Zqfe+bfB/uaJ0wNDHrNSMD6yktpQcw8ZGjzcJViFkE
         /PjjfiOx2PPT0kVWODQv/SeP8WvWo4pClLra0THPgwO70YFRWODJy+3bzB1xub8ksX38
         /f0pj4sI0Scfx0Fq1w2LaqL/Gmb2VdJWqjj2MsAo6t82EzW7zDu4l5pUBHsEHBNtH8RX
         KEKSGX3XnF1zuZWU13xdyjpYgP4tQU5mwVFw+wUfHS7gUVBoS12yliflvz/W0iXPnDcm
         EE9zJcY7xxtNYzP0H6jz/0z/WfB20WvUyWYgkjXos3DmVPdFwkLPS1bZEcsn3iXUPmwa
         x9mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694591799; x=1695196599;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jjsp6nkt43jk36+kNehSmi8qVwyQVy4Drdrq5tRKp4g=;
        b=a0ScFPl3MtRKKqTen7mytDvN8sqwVZ/IvmyGDdlBL0H79F930X8doK229i62ewK8yt
         rP6xbsxyujBVxJSLDYL9lviDFbNIZckAGHcli5y6mQxhGsS0HbWz87cp3XtxJHShqWkS
         xod5pVrTmYe4nnKDTwsZqmQd018gKz8/YbcC3B3TBR8e0w/KknauRFGO8kTbD7/1SHvL
         /5GmhjxkFfMGzhSdxNc7612DLx73/LlGu2wFHCx0vk6O9HPZv0EX/mSKu6Rhi16sQXY4
         xvDLUG+YST6kTYxjdyN9MbZ8IQbcYD7Zy460nT6d5k05JlivEYA6OudVwh7frTM7GvzS
         K3bg==
X-Gm-Message-State: AOJu0YyxOShqymSZ22LMs+0kJfD0KNvardLXqCk66XgVIOnByfjgI5pC
	NPu6yem19SpHGK+xA3FzuWHrQtzKc9P1tVf8Sco=
X-Google-Smtp-Source: AGHT+IHdmPQ+/lS/U/pw6n6tEBxrZFnOyvigRTE23vrGH0CoIE+N1EykyAOf4mhYInM3FFbRLk1MUQ==
X-Received: by 2002:adf:efd1:0:b0:317:597b:9f92 with SMTP id i17-20020adfefd1000000b00317597b9f92mr1386814wrp.57.1694591799039;
        Wed, 13 Sep 2023 00:56:39 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id b11-20020a5d4d8b000000b0031416362e23sm14872349wru.3.2023.09.13.00.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 00:56:38 -0700 (PDT)
Date: Wed, 13 Sep 2023 09:56:37 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Xabier Marquiegui <reibax@gmail.com>
Cc: netdev@vger.kernel.org, richardcochran@gmail.com, horms@kernel.org,
	chrony-dev@chrony.tuxfamily.org, mlichvar@redhat.com,
	ntp-lists@mattcorallo.com, shuah@kernel.org, davem@davemloft.net,
	rrameshbabu@nvidia.com, alex.maftei@amd.com
Subject: Re: [PATCH net-next v2 1/3] ptp: Replace timestamp event queue with
 linked list
Message-ID: <ZQFrNRPwAl/rxoCz@nanopsycho>
References: <20230912220217.2008895-1-reibax@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912220217.2008895-1-reibax@gmail.com>

Wed, Sep 13, 2023 at 12:02:15AM CEST, reibax@gmail.com wrote:
>This is the first of a set of patches to introduce linked lists to the

You are talking about a set, please introduce a cover letter and do it
there. Let the individual patch descriptions apply only for the
individual patches.


>timestamp event queue. The final goal is to be able to have multiple
>readers for the timestamp queue.
>
>On this one we maintain the original feature set, and we just introduce
>the linked lists to the data structure.
>
>Signed-off-by: Xabier Marquiegui <reibax@gmail.com>
>Suggested-by: Richard Cochran <richardcochran@gmail.com>

