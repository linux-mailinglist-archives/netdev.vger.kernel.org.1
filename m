Return-Path: <netdev+bounces-47886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F09A07EBBEB
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 04:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80541B20AC1
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 03:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED05647;
	Wed, 15 Nov 2023 03:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="PndFn3/v"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5192710F7
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 03:33:55 +0000 (UTC)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269C2C3
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 19:33:53 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6ce2ee17cb5so3731166a34.2
        for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 19:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1700019232; x=1700624032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q9mR0uJsLZvnAKSM9CRg1gQRRs6aLmyMmg5KTHQ4ljE=;
        b=PndFn3/vVRX2TJ5b4Axv71aLuOqKnik+nlPGEvippMjRc/CAc5DTNXYWe8izWMeIWR
         ofXT/WKzCV//0qcv28/pFsjvyosy7MjN1SGiWIaa3/kIf1W3sCLNwvaMJYcB6O2iplE/
         Sgs53vSVb3suVeX0XmSW47ADGtFucxRun6OmCJYGS8kj2JwMtjuexCf5ETdMdNwY55TW
         4yVDRLMjBhdsWGIgIZhNNvw5TSsCPyFlMq74U4ErLafwlFgUWciP3/K6RK1XPetyfVms
         O8nk5RtvbnY9Je82DqzsJAGLVaT4I4pig1Q/tkikPpTOhVCgM646Fvd8RXisRU+xRTyt
         1ZKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700019232; x=1700624032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q9mR0uJsLZvnAKSM9CRg1gQRRs6aLmyMmg5KTHQ4ljE=;
        b=rCOJoHG9RMSMO917ludmg7XtJZ9olcxBhvXNnSpOsAwVP+/ZH0Br4G+uoAXrFcAQWl
         xE6IE7WOX/bSc4NKPOEOp0jYF1djWoXBaSclxyjQOqM7Mg+BVR8UpWCbR4wV+VulWhZu
         hox9Zn3fYlcjKwGTm6UqOrq9gq34XcY8v6jE77HbCXbjlXFDXrRiLzG4m48RjAJsCjoX
         3QsNtcj8GRbPlAKJPGhsx/yHBcroC/qItFdFzEot7k36pIgJTNnX/oxPj0gausT398xz
         2k2aOv8y/nC1zSMEGVbII+uu37U6HCDkif0PH3FGr0nva3qY+VJetSOSisEiWqD01L3t
         6nng==
X-Gm-Message-State: AOJu0YwBWtNOA2dDxUR2kOBa0lv7ZadAduN9nmcXAC5PlqA8xVPS40M9
	OqegiCdJqGBBZvOWRM73B3bdYUuJyL1adZ92DzY=
X-Google-Smtp-Source: AGHT+IGVWv8WYumO67U3hxps1H5BEMVUD/eCfSOA0haJ7otaOGTiu83jfVPj5wwZLZryZvHZtJCIPA==
X-Received: by 2002:a9d:6c43:0:b0:6d6:4c92:1ad with SMTP id g3-20020a9d6c43000000b006d64c9201admr4400971otq.32.1700019232447;
        Tue, 14 Nov 2023 19:33:52 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id r4-20020a632b04000000b005b7e803e672sm290969pgr.5.2023.11.14.19.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 19:33:52 -0800 (PST)
Date: Tue, 14 Nov 2023 19:33:50 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: heminhong <heminhong@kylinos.cn>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH v2] iproute2: prevent memory leak
Message-ID: <20231114193350.475050ae@hermes.local>
In-Reply-To: <20231115023703.15417-1-heminhong@kylinos.cn>
References: <20231114163617.25a7990f@hermes.local>
	<20231115023703.15417-1-heminhong@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 15 Nov 2023 10:37:03 +0800
heminhong <heminhong@kylinos.cn> wrote:

> When the return value of rtnl_talk() is less than 0, 'answer' does not
> need to release. When the return value of rtnl_talk() is greater than
> or equal to 0, 'answer' will be allocated, if subsequent processing fails,
> the memory should be free, otherwise it will cause memory leak.
>=20
> Signed-off-by: heminhong <heminhong@kylinos.cn>

No null check needed before free().

   free()
       The  free()  function  frees  the memory space pointed to by ptr, wh=
ich
       must have been returned by a previous call to malloc() or related fu=
nc=E2=80=90
       tions.  Otherwise, or if ptr has already been freed, undefined behav=
ior
       occurs.  If ptr is NULL, no operation is performed.

