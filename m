Return-Path: <netdev+bounces-33497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0034E79E399
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 11:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95D4D281AA5
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 09:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37161DDD4;
	Wed, 13 Sep 2023 09:27:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52971DDD1
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 09:27:03 +0000 (UTC)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C98199B
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 02:27:02 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-50091b91a83so10805570e87.3
        for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 02:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1694597221; x=1695202021; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QGfCIQ2uXeaGjAP1vJHhSYENJ4MSWSNEKMncc6vme3A=;
        b=XyT+y+VvcEVYjk5tgqdG90zYV580vel1Tmj/WyF/7nZjk67DQsvcAVss9WQrjs6KM7
         2nt4HLxAqupqZC37fVMxStjDf77Zz2Eq/3AHP0LPpL7CNIP2VVLozaH/XHJqXBVmHLr9
         EGabpQbAdYjmdKmKAicw7DJPI2uumzDq10pWtVGlRMK+gtOCAunghRP8mVmDG6VLC4HX
         4f5NWlkQ53CIig/1dgjXPprOTM4yG9phKiaNdnfTfIvsWE0bvabOlWqMMizTcXJo11kA
         bjcoeOwukuVnea6MbaaaBzeyR6MWlzdfhq5N8vkoPGJ6H7RqnOgVkJCMI+WnN4vxfNmi
         yLzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694597221; x=1695202021;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QGfCIQ2uXeaGjAP1vJHhSYENJ4MSWSNEKMncc6vme3A=;
        b=D+QMokg3eRmi8Yr2q01HCF0nUtiQDHDOlETOC5RXYaDFjlKNfLhoGSyAgu7s1AKaGA
         7YKD/x3dVTAs4WNyzGVSh3o5PEC7RqU2zejjeMkfI25G4eyZp2P2sGeK7g7U2G88SO8C
         R1/Tv+fDRMnz2HiEnd1o2BP7kFUpDg6I/EbjMBhtslh9j+6BD/NmmTDnLNkTMl/kvJk5
         zRmLC4xghzvPC4sYz1rv5n3NMifzDarpaGpvLDeODJr+BPC2XsCiprFf6x2FbDhnbgtd
         I1JQPWrwcyKm1I5x43f4XEZNs5VkPzKIwndrnCYBytyyYfJPo6cvFDGDRXeIyCUWDXcm
         a+Vg==
X-Gm-Message-State: AOJu0YzzzAm5KdMCA2pXlsW5pAO/qZHiamvzGBGgPm4yo5G4f9fsWUIA
	arFogYFdd37x2Bqdd8KRreun1w==
X-Google-Smtp-Source: AGHT+IECKPCiYRZXbmWqtRPtTFo/PY54Z5r0OM1fAoe4cIDECnaByX4QUdoEQokQtY4OTXuIq41+8w==
X-Received: by 2002:a05:6512:3196:b0:500:b5db:990b with SMTP id i22-20020a056512319600b00500b5db990bmr1845665lfe.47.1694597220264;
        Wed, 13 Sep 2023 02:27:00 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id az34-20020a05600c602200b00402e942561fsm1489986wmb.38.2023.09.13.02.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 02:26:59 -0700 (PDT)
Date: Wed, 13 Sep 2023 11:26:58 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jinjian Song <songjinjian@hotmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, corbet@lwn.net, loic.poulain@linaro.org,
	ryazanov.s.a@gmail.com, johannes@sipsolutions.net,
	chandrashekar.devegowda@intel.com, linuxwwan@intel.com,
	chiranjeevi.rapolu@linux.intel.com, haijun.liu@mediatek.com,
	m.chetan.kumar@linux.intel.com, ricardo.martinez@linux.intel.com,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, nmarupaka@google.com,
	vsankar@lenovo.com, danielwinkler@google.com
Subject: Re: [net-next v4 0/5] net: wwan: t7xx: fw flashing & coredump support
Message-ID: <ZQGAYiuOYnI/gvXl@nanopsycho>
References: <ME3P282MB270323F98B97A1A98A50F8F7BBF1A@ME3P282MB2703.AUSP282.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ME3P282MB270323F98B97A1A98A50F8F7BBF1A@ME3P282MB2703.AUSP282.PROD.OUTLOOK.COM>

Tue, Sep 12, 2023 at 11:48:40AM CEST, songjinjian@hotmail.com wrote:

pw-bot: changes-requested

