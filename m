Return-Path: <netdev+bounces-59451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB2281ADE2
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 05:08:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ECAE1C22D29
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 04:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A80A6103;
	Thu, 21 Dec 2023 04:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="apdM/JNo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B8063C4
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 04:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6d47bb467a9so1098333b3a.1
        for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 20:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1703131723; x=1703736523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ocWVVSZTnZiL7UkykthssBFcNddp5IIwvgAuEJ9AsWk=;
        b=apdM/JNoZqfz1stZzaBFtnc6+jczTzqBJMWqa2V6uIJbTj8HrdFRHrBStbVTQZcON+
         E1J7i/OdEvyv+Jsg5Qg4ntwWC7GNmOzTV1lcln0WhGiLaQKN/sCioRYnQN5EPBD104jg
         yhsAqZsM0GqBKj/4XjjtONYgtbhmoWXtdWWwfNeuyEdtSUtU9wLtEc3PPN0h5e0n0q2/
         A2XAHpuZTSs9b9WnH06Tj6LJTCyKqY4YMr8z6jpagBWpn8cgvE7dtjUfRN4Q8ar621wO
         YUepG6TzHoWUj841e1n9FscTgJboefhq/U9FQpWMeYoLAusVTErbJA7TZlKwk5AGdrn/
         4HFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703131723; x=1703736523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ocWVVSZTnZiL7UkykthssBFcNddp5IIwvgAuEJ9AsWk=;
        b=VDPncgnXzmO1GI80b5Ai5DzOGfPopOvc/FHzgkVMAkv02fUidH3j8bUvoED1PXID5A
         GfJkSUd7A1MSnuVYaikniveovTDiR+TrzljVouUkwPH63EExIrrdJJvt5lNeOOzyJSvS
         G0Dj7cxIqlcQ/oplVrCaaFsZMgik63viLF8kGuycSRZtDbaFFPf5E2PywLr6V3P6HTF5
         rfC03m9G94SbquII6rcIAEFA7wEGNyOVuve1rDfijcCHQFCXJP2fWNHK86esF0aTaUM0
         P1PNPzO3ET51x5u/w/84apmIsp/fKRLHgo409FxQjBWHeig6Q5AQNuilj198/Fw7lOSc
         /NlQ==
X-Gm-Message-State: AOJu0YwlX28NsDVD19uBmQysE35dOffBcTKJTt9gO0SVwOgVlcIBVq+c
	zSMH5GdVIhriJtPDx8JgxXBuyp4g+kBhMEf6jBw=
X-Google-Smtp-Source: AGHT+IH++2rHtcEthrZbdlteknTO8hgABBPCyGAj7s4GiPrqOFSx17cjDES9qzLbkiPfKPHsEq7VOg==
X-Received: by 2002:a05:6a20:54a1:b0:18f:97c:384d with SMTP id i33-20020a056a2054a100b0018f097c384dmr110171pzk.39.1703131723373;
        Wed, 20 Dec 2023 20:08:43 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id g6-20020a63f406000000b005c66e25497dsm557230pgi.83.2023.12.20.20.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 20:08:43 -0800 (PST)
Date: Wed, 20 Dec 2023 20:08:41 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Benjamin Poirier <bpoirier@nvidia.com>
Cc: netdev@vger.kernel.org, Petr Machata <petrm@nvidia.com>, Roopa Prabhu
 <roopa@nvidia.com>
Subject: Re: [PATCH iproute2-next 13/20] bridge: vni: Replace open-coded
 instance of print_nl()
Message-ID: <20231220200841.1c6dae33@hermes.local>
In-Reply-To: <20231211140732.11475-14-bpoirier@nvidia.com>
References: <20231211140732.11475-1-bpoirier@nvidia.com>
	<20231211140732.11475-14-bpoirier@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Dec 2023 09:07:25 -0500
Benjamin Poirier <bpoirier@nvidia.com> wrote:

> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Tested-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>

Acked-by: Stephen Hemminger <stephen@networkplumber.org>

