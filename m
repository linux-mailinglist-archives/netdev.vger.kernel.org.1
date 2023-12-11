Return-Path: <netdev+bounces-56126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED78080DEAF
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 23:57:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB41DB20DFE
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 22:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB1E55C33;
	Mon, 11 Dec 2023 22:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aDsUh2Ze"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8709A
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 14:56:53 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-286b45c5a8dso5244889a91.1
        for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 14:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702335413; x=1702940213; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=25Ppex3BpReCTZyRkHMBPR70vfoKru5tfNxgUTf2Is0=;
        b=aDsUh2Ze+3RyA4+hFqXYEZPHr6agNS5VUXt5x3fmVm8TyavCb+ohfyDCX80O8Sq4DP
         7FNdriBQFCokzzUKaGALVW4834YhkyvUO050o8Rop2o8fLPpPdBoNdo9DEZLNh9Vx6EZ
         O+X2rY/F7Seq7VuId/TYvhU0Ts/BqU+20Hpr7kO/7huo67PiWCRX+ZaWYbHOHMk+qMXU
         l2p6d+nwvsW8XNXsVqPrflvbuerH+jWBScK3aIOLtjDW1q1vBhM8rnn1BRAKYaQEMz0J
         jlCZiXh3gmB9Q/GbZSYEwKuOlsDmFr9whas8wHG0+l3Nnh8hXHJf2EuCV0nE8/c7ZmJk
         KBqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702335413; x=1702940213;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=25Ppex3BpReCTZyRkHMBPR70vfoKru5tfNxgUTf2Is0=;
        b=DjnRAP8rLzqQMurn1/BXUTj+0vOzyS1rre1qKnMAkGLpm+pvE/9q0K7PVqAu7Oernk
         uTiy4Wfod6YFaw4Dt39a0Sn674qIoolm4TFK5pMgdLtBdGq31HEzykFNPafJFb59C/Ey
         nuR2eu7cmU+hYNJlVlcVbuQFpIwqjjfuvVYstW1RoSQEr8BLpDrK5/9H2fVhjmur36PK
         yXeXGftxjFXPitV6o9LRq55nMC3ODdiBYTJxOkMTSI3/IG0HWeTTpAJeEGXcSPXhC/nP
         A8dQsq+N3AYGsxbGHqyjCb52zl3Ih6jkquPh9OauXEnNHkCHtHa8GkSNV/cXu5gr8zPZ
         5u3w==
X-Gm-Message-State: AOJu0YzM+qQQRoNj4hkvNrOdkLq6OkRhNQsBLobSoyYuAmIOUQChIqZV
	YfwDWRufT/rCJeB5OtuqutGsOSidC2w=
X-Google-Smtp-Source: AGHT+IG1WUlxk6Br+yfT7le/r0+pioa5OpaZbtQo8/a+i8JjwOJVIT4vNrsSJpRvpxmqij4ef08BQA==
X-Received: by 2002:a17:90a:f98e:b0:286:975a:aca3 with SMTP id cq14-20020a17090af98e00b00286975aaca3mr3758725pjb.72.1702335413261;
        Mon, 11 Dec 2023 14:56:53 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id qj12-20020a17090b28cc00b0028672a85808sm7594587pjb.35.2023.12.11.14.56.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Dec 2023 14:56:52 -0800 (PST)
Message-ID: <07939e61-3076-4fc1-b35a-12e21665ae38@gmail.com>
Date: Mon, 11 Dec 2023 14:56:50 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next 4/8] net: dsa: mv88e6xxx: Give each hw stat an
 ID
Content-Language: en-US
To: Tobias Waldekranz <tobias@waldekranz.com>, davem@davemloft.net,
 kuba@kernel.org
Cc: andrew@lunn.ch, olteanv@gmail.com, netdev@vger.kernel.org,
 Vladimir Oltean <vladimir.oltean@nxp.com>
References: <20231211223346.2497157-1-tobias@waldekranz.com>
 <20231211223346.2497157-5-tobias@waldekranz.com>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231211223346.2497157-5-tobias@waldekranz.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/11/23 14:33, Tobias Waldekranz wrote:
> With the upcoming standard counter group support, we are no longer
> reading out the whole set of counters, but rather mapping a subset to
> the requested group.
> 
> Therefore, create an enum with an ID for each stat, such that
> mv88e6xxx_hw_stats[] can be subscripted with a human-readable ID
> corresponding to the counter's name.
> 
> Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


