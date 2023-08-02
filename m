Return-Path: <netdev+bounces-23524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9691C76C570
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 08:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C84CC1C2118A
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 06:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57E8EBB;
	Wed,  2 Aug 2023 06:43:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D0C10EC
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 06:43:02 +0000 (UTC)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266E130C0
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 23:42:39 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99bf1f632b8so745782266b.1
        for <netdev@vger.kernel.org>; Tue, 01 Aug 2023 23:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1690958557; x=1691563357;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Tk2a/DqsTI9h2aitSbqX+bRNnV4eF5KhVITnumZ09ps=;
        b=yl9ZBiT/ZKGi7+AZrG5w0MUjfu7qnMaoTqZkA6lf1CkXRMvNmgiLMwqrZDUmrjf22f
         v4AAhnHmOePFXp1JIvbFt52NW5YRevsMXV5f8QA/w5TM4fzT41QkBf56qJyZpne/J9ya
         Mx5OOLkSW0JVkhS+6LQM41SXy8wp+jqnMaJZasRA0ehKSo7V/RJ5BNve4YfNiT0JYEYG
         MD2IZV0VDuvu9xOWDv+0TOWyFpK7cI1IGTd04eTBN1BCPRc5b76pUfpVSlHqvhz2Urg3
         yOlqbRp0kuexgSx5I3z+KQem6a7fk/SYDibYEY7brOOkgXfCNxomILSpsqhMM3BuaAtT
         aA5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690958557; x=1691563357;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tk2a/DqsTI9h2aitSbqX+bRNnV4eF5KhVITnumZ09ps=;
        b=lR/t0H41ViiYHxQ+MLrmwlSPMcqL8hvFAHyaH+fVpOC5jTf9XlOQvOllQnCM1yfTE3
         B7xnjtRxqdZ1Qq7FEWLEfWLyK0picmd6v4n9EI+QakHRRvs/xvlJj9twKDjdTWxw7hkt
         acSom+Ir1BAoBzF8HJ9wZipOjGcI7S+GIA4NaRQGPTBKd9gEqDB/G0EOnvllV+tG31Qq
         1/K5P50HTf800hHDYzYDCpoAulbZkOsdAyFmbpT5SFNVaM7vWnv9oUcT9GMQStyrnd+j
         RFdtwackKa1B2S4vzZRMy+DsvGQrWlrOjbrJ3nr8qYM+2oFPEYEho9YYbm3KMicYn3Do
         hh3Q==
X-Gm-Message-State: ABy/qLbXmUYhXAbjHYcKEmxj9SyFwsGPoeiXJmCaVxuUX4DcW/rGYcCM
	hCXLrlWL1iPXiRkvAej1+I/ekA==
X-Google-Smtp-Source: APBJJlHqIfE9TeKiQbGHL0QAtE7hitbAIbu9x8hmrnK6K2g4CMCcHfnD6bTp2aYkGpMOhTwJ31Y6sQ==
X-Received: by 2002:a17:906:212:b0:98d:f4a7:71cf with SMTP id 18-20020a170906021200b0098df4a771cfmr4063212ejd.62.1690958557617;
        Tue, 01 Aug 2023 23:42:37 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id w11-20020a1709064a0b00b0099bd0b5a2bcsm8657810eju.101.2023.08.01.23.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 23:42:37 -0700 (PDT)
Date: Wed, 2 Aug 2023 08:42:36 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com, moshe@nvidia.com, saeedm@nvidia.com,
	idosch@nvidia.com, petrm@nvidia.com
Subject: Re: [patch net-next 2/8] ynl-gen-c.py: allow directional model for
 kernel mode
Message-ID: <ZMn63DQSLQAUw0cd@nanopsycho>
References: <20230801141907.816280-1-jiri@resnulli.us>
 <20230801141907.816280-3-jiri@resnulli.us>
 <20230801112703.2690f706@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801112703.2690f706@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Tue, Aug 01, 2023 at 08:27:03PM CEST, kuba@kernel.org wrote:
>On Tue,  1 Aug 2023 16:19:01 +0200 Jiri Pirko wrote:
>> Directional model is only considered in uapi mode. No reason to forbid
>> directional model for kernel mode, so lift the limitation.
>
>I mean, the reason is that it's not tested so this way
>I don't get people sending "fixes" claiming stuff that's
>not supported is broken :)

Got it, but I need it for devlink. Works fine as far as I can tell.

