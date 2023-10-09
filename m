Return-Path: <netdev+bounces-39206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C21C07BE504
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 17:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEEAA1C209F6
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 15:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2941374C6;
	Mon,  9 Oct 2023 15:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="NNhLpH+z"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46712358BF
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 15:37:36 +0000 (UTC)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD215195
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 08:37:33 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9b9a494cc59so792754466b.3
        for <netdev@vger.kernel.org>; Mon, 09 Oct 2023 08:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1696865852; x=1697470652; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CLAIgOV2Pw6cnpmJwEYe2WQOHHTWHntilNEE9wyvopE=;
        b=NNhLpH+zLYqVxJpAUIzOo0xV9ADR9ub57zBgQFgIo4JOW2aR3D6rk7oE5bCENbdwLt
         naAtyCpYHzzAP58kpi5wjrFw3c9nsYMgCUjabOACWLToDOjHFU3xSeP7LmzmWWcnT8D0
         nOXdxCCKhJMfOs/R+bhnL3aegSrrcH3xQyLUVpqZE0oXfZMEUuX3LaM/F7XH1wZC7sUK
         n3GAfy3HtD7qBVuVK55qVeruhlApzta9iimkmR/ybhUcCzxn4VkvaeEfgGB5VgkT2bPj
         RUqQj3PYWHJe6GQPsnueXyf1jOjB97TTqwyEKXtX5feUcyPpoea1zohZkWoZ5k6+jHXn
         OsZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696865852; x=1697470652;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CLAIgOV2Pw6cnpmJwEYe2WQOHHTWHntilNEE9wyvopE=;
        b=OXSxVeM2D6qOC8+nGJOjUsa2a8nznOCmGtO8vh8v7opKRWDVsF2iqM/IUT1dQBOrUW
         Um/2cOZpJHteDUTojHf20msRn4za8CPZLpv76ogfdUOiQt266XRhtPSI6jjwfkVaP9g/
         gwZjDfawaRT93Az537iDdPWGZruEC3ZoOBfIOj1d64z4LNwhxHswiEGIX2U/qRAODxdH
         aR8oqZgwu6swEl7r2hLjngUZWZpTGCARK29We9V+MffF6PNbqV5CdIvS6YTGLOtAmf/f
         8p2g81w/hkcTO3GwJAILAkQSFNlk2w9Uvn5yD3C01vMshEgkahLDV+TVWnmxk9NIKWEX
         WK1g==
X-Gm-Message-State: AOJu0YzePU6lLgzgDPbpG3ltNLdxxNshmBx3uvao+Fe3AImB9tQL1tS6
	+OIEs0xt7yPX6oMTpZtQw4TXsA==
X-Google-Smtp-Source: AGHT+IFIF3fVqWgHAPFDoKtTiS9ZurHOgJ2c7OEF95H00vlWbuYajg6xEHwA+UlkuUXlHyfBY9g/oA==
X-Received: by 2002:a17:906:3087:b0:9ad:f7e5:67d9 with SMTP id 7-20020a170906308700b009adf7e567d9mr14785850ejv.4.1696865851759;
        Mon, 09 Oct 2023 08:37:31 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id 17-20020a170906059100b00992f2befcbcsm6830997ejn.180.2023.10.09.08.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 08:37:31 -0700 (PDT)
Date: Mon, 9 Oct 2023 17:37:27 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com, gal@nvidia.com
Subject: Re: [patch net-next] devlink: don't take instance lock for nested
 handle put
Message-ID: <ZSQeNxmoual7ewcl@nanopsycho>
References: <20231003074349.1435667-1-jiri@resnulli.us>
 <20231005183029.32987349@kernel.org>
 <ZR+1mc/BEDjNQy9A@nanopsycho>
 <20231006074842.4908ead4@kernel.org>
 <ZSA+1qA6gNVOKP67@nanopsycho>
 <20231006151446.491b5965@kernel.org>
 <ZSEwO+1pLuV6F6K/@nanopsycho>
 <20231009081532.07e902d4@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009081532.07e902d4@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Mon, Oct 09, 2023 at 05:15:32PM CEST, kuba@kernel.org wrote:
>On Sat, 7 Oct 2023 12:17:31 +0200 Jiri Pirko wrote:
>>> Isn't the PF driver processing the "FW events"? A is PF here, and B 
>>> is SF, are you saying that the PF devlink instance can be completely
>>> removed (not just unregistered, freed) before the SF instance is
>>> unregistered?  
>> 
>> Kernel-wise, yes. The FW probably holds necessary resource until SF goes
>> away.
>
>I think kernel assuming that this should not happen and requiring 
>the PF driver to work around potentially stupid FW designs should
>be entirely without our rights.

But why is it stupid? The SF may be spawned on the same host, but it
could be spawned on another one. The FW creates SF internally and shows
that to the kernel. Symetrically, the FW is asked to remove SF and it
tells to the host that the SF is going away. Flows have to go
through FW.

