Return-Path: <netdev+bounces-59445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A802E81ADD8
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 05:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA3CB1C22A3A
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 04:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6068524E;
	Thu, 21 Dec 2023 04:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="S7vWdx73"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6229B5676
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 04:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3ba00fe4e98so278482b6e.2
        for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 20:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1703131239; x=1703736039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3GEsdfxQYe8pvFlvxg5Yt1lcrlR/+8EQL4lxDWtQKMY=;
        b=S7vWdx73DfeC8MjSiHmRP8/hpPmwz1mqCASnrffYCsDCyZdbDLlRo8RP8yxJruScpA
         6zj6NrQGaHz4PcUnnTgVj6yzcOU3ZrWfM6Wo35eewGiCx3y3Z/oxACk/sICB6ihWqxlL
         IRk+93G7OWJL2C5NdcjX/TdrZ0zLBs8IIbMnayPg6PZEyEcVSkxz08968NToJ2UgKCaR
         8qIG4UZs5wiQN52I6k5Br4YAmu/Y/ccQZobZQ5PmWr0WDfPCs2aU8NTZfzcdu/zGtj3J
         GwEDE5f4tmPMe3yjFWYij+eicqaudZdw3EjP8Lr6sUA0O9Dw7bGCeca0odnz8WmjE+Ep
         c+/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703131239; x=1703736039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3GEsdfxQYe8pvFlvxg5Yt1lcrlR/+8EQL4lxDWtQKMY=;
        b=DQZU2o7j+T7U9UXwvZWEdYi4jheN0F3CyVadaOT8vVE2g/Ay6wSmzgUDc4IvfmAdUk
         zPHrEWRhJs+szYsPvahxKD9wziv0XqJW67P+R27N4Gw29KR6PjzdGCetbSFaccdhx6LZ
         TTMaUodbCaOfu4hS4nO3j1UEHfBlJzY85CxlLdatbbv0+xLAlxS7rlWfJEQ9GgYWJu3j
         YbgXXYK0aB/4Pg+YVP6PanI6sPPFpyJV4jthaG1nXlBo7sz8TUe//EamiMgnNFKCWuHY
         xgOoCO40rTVdlgXxK2zceAuq2/CKbqdgwxvPWIdfSadFSSps6zn4DRy0X1n8KiCZP2ce
         NG9A==
X-Gm-Message-State: AOJu0YwMBfMWmc8RFsH60vWMlsM50InWYQQD6Y3xu2r2q0cFLCEv2+q+
	4S7sM48jqC4dBPeCqedyqLj/Q2Td1ls9nY3djus=
X-Google-Smtp-Source: AGHT+IFdOp7xXVhybJu6IxF+R3X0qC4+Vo86ajbTaD7B6UqJrUZG1XPR+Gpb5j2YdK6SpeRLDIERMA==
X-Received: by 2002:a05:6808:ec6:b0:3b9:e69f:c0a3 with SMTP id q6-20020a0568080ec600b003b9e69fc0a3mr23893928oiv.63.1703131239482;
        Wed, 20 Dec 2023 20:00:39 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id z2-20020a62d102000000b006d9762f2725sm77877pfg.45.2023.12.20.20.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 20:00:39 -0800 (PST)
Date: Wed, 20 Dec 2023 20:00:37 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Benjamin Poirier <bpoirier@nvidia.com>
Cc: netdev@vger.kernel.org, Petr Machata <petrm@nvidia.com>, Roopa Prabhu
 <roopa@nvidia.com>
Subject: Re: [PATCH iproute2-next 05/20] bridge: vni: Fix vni filter help
 strings
Message-ID: <20231220200037.18575c79@hermes.local>
In-Reply-To: <20231211140732.11475-6-bpoirier@nvidia.com>
References: <20231211140732.11475-1-bpoirier@nvidia.com>
	<20231211140732.11475-6-bpoirier@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Dec 2023 09:07:17 -0500
Benjamin Poirier <bpoirier@nvidia.com> wrote:

> Add the missing 'vni' subcommand to the top level `bridge help`.
> For `bridge vni { add | del } ...`, 'dev' is a mandatory argument.
> For `bridge vni show`, 'dev' is an optional argument.
> 
> Fixes: 45cd32f9f7d5 ("bridge: vxlan device vnifilter support")
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Tested-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>
> ---

Acked-by: Stephen Hemminger <stephen@networkplumber.org>

