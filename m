Return-Path: <netdev+bounces-106380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D0D91609E
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 10:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45BCE1F21292
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 08:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F46145B3F;
	Tue, 25 Jun 2024 08:05:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C6F7344F
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 08:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719302751; cv=none; b=KyVfrYuHAdgK5p9ajPvNK1/X7ATo0oAKGFlW5Eh4Qc1nXtc4O5BrtttN7X7FJJcuPwo4fi7JkmZDijxtlrgQk46sKbzSPrhutNnJj3r13MlmkyeGMAk72hYPW21o9jpXpf2Fa/qBFtGHvQ1cUAxOIMM9RnC/y5ANXdyg8MfnVPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719302751; c=relaxed/simple;
	bh=+B1LA1OvSn88c81Afbs35zL+Bj2cFxU/MqGF20fO+74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pBY9pOL6KgjCp+u1RGG40GMN7ggBKoXQi6ZdEe2g2HrN5Y/JPBQ/1rCZo1J7ZgTaCf+cwaRPTqX8vELwxBOmx0H+LoQkh+vUEDG7RpEQU+Jnq9MpZNfm498V9fSbR/mDzr7Kg0FMD84QPFGPkCSz+XNcyr5C/aW2Qml6VFYFNkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a72477a60fbso256373766b.2
        for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 01:05:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719302748; x=1719907548;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vCCcagzdvgmYDqJNQl4O4bjAfsebU8ARQiJkHvG/cGI=;
        b=FEmBVbBTbmAiLiYykxPRiAhQ3r7qya8dlDzhUAdJ+cbnott5Ydjyv1JupNcWSyP4c/
         +jo1FwYHhK4GjE8BM3sLDQw9ZsadkX3GQHawcCdaFDny6um2rAp/0nROtGxWp2dykLFk
         nectGynF4RMq4wWEFTydw5mXSgpGdYCaLlYmcnJmz8TP32QA/5uzf/TSg3IEEYu/5H02
         bNSLFmgnu2YPI3mDh6wlR28KVCzlRLof2TXmkESKtf2c2Rj2qCris2vAzX7AvcEqqwDw
         SVDgjS+F0YSGgkrwkb8JxzWHrHjL27WGgfcw40NnPy4UDXaBfIXQ9xKLRSSaKXptSVSU
         6B+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVaygWlrcFMtOw821xe/03f5b/X9s5QlEikMq/LG1FK8fD79L5tLjKAAfpJmpprDcMLMsPGkvaQaokL7OMCU+rbxq0zfuQk
X-Gm-Message-State: AOJu0Yw4xXO459gpccMqcFuDxKyPdurQKKfeEQQZE6LYZvBef9B5z0nK
	pe0ksd1Gd6MLg4OhG3pIkn+AA+noVswh+flOg60z2kZI6JuAEQfE
X-Google-Smtp-Source: AGHT+IG4ayQEyXlsIBoM9hNSPBa3g5E6FzFQXa7AkkLcNVO+kCxF2FJKnKuclAnwTxTLp7VBjG2Mnw==
X-Received: by 2002:a17:907:3ad4:b0:a6f:4de6:79f with SMTP id a640c23a62f3a-a7245bad98emr353604266b.40.1719302747853;
        Tue, 25 Jun 2024 01:05:47 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-004.fbsv.net. [2a03:2880:30ff:4::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a724c8b4137sm238404466b.45.2024.06.25.01.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 01:05:47 -0700 (PDT)
Date: Tue, 25 Jun 2024 01:05:45 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, willemdebruijn.kernel@gmail.com,
	ecree.xilinx@gmail.com, dw@davidwei.uk,
	przemyslaw.kitszel@intel.com, michael.chan@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: Re: [PATCH net-next v2 3/4] selftests: drv-net: add ability to wait
 for at least N packets to load gen
Message-ID: <Znp6WYk5qQGsrNvN@gmail.com>
References: <20240625010210.2002310-1-kuba@kernel.org>
 <20240625010210.2002310-4-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625010210.2002310-4-kuba@kernel.org>

On Mon, Jun 24, 2024 at 06:02:09PM -0700, Jakub Kicinski wrote:
> Teach the load generator how to wait for at least given number
> of packets to be received. This will be useful for filtering
> where we'll want to send a non-trivial number of packets and
> make sure they landed in right queues.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviwed-by: Breno Leitao <leitao@debian.org>

