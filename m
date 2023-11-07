Return-Path: <netdev+bounces-46360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CEA37E35DA
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 08:25:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C282AB20B9C
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 07:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00931C2F0;
	Tue,  7 Nov 2023 07:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="pyYAjLRH"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81315D2E0
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 07:25:01 +0000 (UTC)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4723591
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 23:24:58 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-53ed4688b9fso8860733a12.0
        for <netdev@vger.kernel.org>; Mon, 06 Nov 2023 23:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1699341897; x=1699946697; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qjAsq9l/JW+UIIFNfNm36QaiEOOJSZRtCm9k6IwqkqI=;
        b=pyYAjLRHmqS63Cav9ALGPaeHVQM5cxK9eyyleASmLMckMipr2NotUmMv5ssyxlkk6N
         RoHloI3XVekgqOXU9WCljmk7/cZxEcBEGAe6qK/IpcLtSIpDlFjdRBjUn8BtcFYNNrEm
         VF2psMyBOta3Gre6qpHIELqvwmtJzs5MKetUz89/P0oGjXtoauGgz8EXkaZ2nFZ4+FIH
         tiP2VaV7iFuJ0fUc12IPS5jwXCh/Tn64DrR/cN6nstnkr1DTrnAH713SyRhPoRshsguS
         bPhruGLQvIPfMX+3QTWNhqw9vIS0JdfB98HbdBu2zAKCjdRTCRaW3VFWeyPy4irLPLxx
         /55Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699341897; x=1699946697;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qjAsq9l/JW+UIIFNfNm36QaiEOOJSZRtCm9k6IwqkqI=;
        b=Yv8TiXJOD8/W3H5s87EAyk+e9YoOfjoHaOMxQpP8AT3PNvSoz4Wuy2RQ6RZ0Cua1dL
         REuHZGs2M/c6wVPZPLN+qGm8LWSh3vaam9hb8NinGg2cY58oBBM1vr/wxqVQz12dSb4l
         3Ue6mQbOvxpD8bcKxa6ldi0fBc+WrqWQYmdY+noV7T24uqE1zpMx9ekNSVQ/Khay6INv
         IEzbT8CDbV55H0HBQCKpIiXlqLK+hB+VtHZ9YUU2ZR6NwA1f+xdH3KPZdt6+QIbaj6xF
         bR4FPc17dTbaOk3Zds160jIMFkIiECxJBXlqljZTYGM87N6ErdCDOiktrqsbozKpcVHJ
         ZE+g==
X-Gm-Message-State: AOJu0Yx02vuIv+0u8ah8YP5apV0YXvf8deaK+fA7RgKm01zqhLWZ+Cc0
	t9ACcS0ucSxo1qazcC4tibm+Lw==
X-Google-Smtp-Source: AGHT+IHakqVGDwjdPctSsf30yzOMsdUMf1WCAaNtJwp6aQFh80ghU2pH9Q5DblqDV3kXMewNNBzMBQ==
X-Received: by 2002:aa7:cf90:0:b0:53e:1721:146b with SMTP id z16-20020aa7cf90000000b0053e1721146bmr23831035edx.28.1699341896525;
        Mon, 06 Nov 2023 23:24:56 -0800 (PST)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id t22-20020a50ab56000000b005407ac82f4csm5212856edc.97.2023.11.06.23.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 23:24:55 -0800 (PST)
Date: Tue, 7 Nov 2023 08:24:54 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: David Ahern <dsahern@gmail.com>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org,
	daniel.machon@microchip.com
Subject: Re: [patch net-next v4 1/7] ip/ipnetns: move internals of
 get_netnsid_from_name() into namespace.c
Message-ID: <ZUnmRis0BCFjDr5s@nanopsycho>
References: <20231027101403.958745-1-jiri@resnulli.us>
 <20231027101403.958745-2-jiri@resnulli.us>
 <6a13b47a-c040-417b-a4e2-8796b72faf85@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6a13b47a-c040-417b-a4e2-8796b72faf85@gmail.com>

Mon, Nov 06, 2023 at 06:11:29PM CET, dsahern@gmail.com wrote:
>On 10/27/23 4:13 AM, Jiri Pirko wrote:
>> From: Jiri Pirko <jiri@nvidia.com>
>> 
>> In order to be able to reuse get_netnsid_from_name() function outside of
>> ip code, move the internals to lib/namespace.c to a new function called
>> netns_id_from_name().
>> 
>> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>> ---
>> v3->v4:
>> - removed namespace.h include
>> v2->v3:
>> - s/netns_netnsid_from_name/netns_id_from_name/
>> v1->v2:
>> - new patch
>> ---
>>  include/namespace.h |  2 ++
>>  ip/ipnetns.c        | 45 +----------------------------------------
>>  lib/namespace.c     | 49 +++++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 52 insertions(+), 44 deletions(-)
>> 
>
>
>dcb
>    CC       dcb.o
>In file included from dcb.c:11:
>../include/namespace.h:61:31: warning: ‘struct rtnl_handle’ declared
>inside parameter list will not be visible outside of this definition or
>declaration
>   61 | int netns_id_from_name(struct rtnl_handle *rtnl, const char *name);
>      |                               ^~~~~~~~~~~

Ah, I wonder why I didn't hit it. Will fix, thanks!

>
>--
>pw-bot: cr

