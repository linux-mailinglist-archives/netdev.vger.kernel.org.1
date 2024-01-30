Return-Path: <netdev+bounces-67141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7093F8422DB
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 12:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 094B11F20356
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 11:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D268F66B24;
	Tue, 30 Jan 2024 11:21:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082BB60ED3;
	Tue, 30 Jan 2024 11:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706613687; cv=none; b=qYcQ51KMp2Uxj381YNMJpz29v2aqByErtowxlXPfeQT1R23FpuNTi+GojxI67OHqNPPhgjDDGg4K4Axi4gYBeFw9YOBUAgHIcz0Ae6NuzNpGPzlo+gh7G2a8QBeAl8fMxiaXoFevK76VVA7Tf+sKCzoJPmacomcH5yxrdZsMaTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706613687; c=relaxed/simple;
	bh=r7E9aI8PsQzjJF0xE6OvvXDFFiTiekJb0tpJzhwd5k8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jJ8dS/6/DN3iXhagZYMUFxDnj7T8BN4nnaYUI9vl+S9VQ8Cp1IteHIE2aAYKIsYyRPpKryT0MSFUt2iG3yoApyk0tKs/SaszKfva1F8n9gnqIt/qyxe1z6kkc0SMBJ2vmKCg8sgdkNXEGSG3b6mLGKO/T6EFcZ17CmGnRPfzgmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-55f13b682d4so2479463a12.1;
        Tue, 30 Jan 2024 03:21:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706613682; x=1707218482;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XsybA84RDFiKJs5uUFCm5D1iyOzOmdHrpIqq5Pbn3Gk=;
        b=qMkLpBskCo956qq764KnSuLuqFyQTrc/Dq2JwrxAtuKqJdiOqgX5GVenEKiJiCeHyl
         LlwexqLPfooZD5549vw2zrdp6kRG9OOc/SRaEbZko6DA9F4yP57lea8chWVgezt6XR/w
         uvEnZUA2b9EgfEgiVXDXdb075uByXKEp08AHOZk23BBffR/xUAt2CH6rlHW5u/jx4tRf
         JygloX+SeV/pYssyWrmozgJlXEfO9zRZVL8wtyk+UIAoV1vBQgcXZCoOtjPVk78h92Vq
         37fHOvcO7BnJpkjjImo6PPRNQgS1fKKk/mCn8nrytJCTtl8YXQIbKUoZvOJiy4DRwKBt
         rs7g==
X-Gm-Message-State: AOJu0YzEhAz5Cy8s6oCpbFMJRRqmijvWG0GNfyecChVgaZPct0RdjlnX
	2YGX3pId6xFSf/kD5uxjELr74pvU9bjEin7PQfJTxBCYCd/NVUKP/KTkBKFsEpTklSax
X-Google-Smtp-Source: AGHT+IFXiCLKcSRrQ7w1s9lFeg3HKhnbiyCrKrdd5UsPMQvcYKPs5+YW6e8Y2OXMxxQzYl4bACzMcQ==
X-Received: by 2002:a05:6402:504:b0:55e:f164:7765 with SMTP id m4-20020a056402050400b0055ef1647765mr4099903edv.32.1706613681803;
        Tue, 30 Jan 2024 03:21:21 -0800 (PST)
Received: from gmail.com (fwdproxy-cln-013.fbsv.net. [2a03:2880:31ff:d::face:b00c])
        by smtp.gmail.com with ESMTPSA id s4-20020a056402014400b0055f4558c602sm443726edu.67.2024.01.30.03.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 03:21:21 -0800 (PST)
Date: Tue, 30 Jan 2024 03:21:19 -0800
From: Breno Leitao <leitao@debian.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Alessandro Marcolini <alessandromarcolini99@gmail.com>,
	donald.hunter@redhat.com
Subject: Re: [PATCH net-next v2 04/13] tools/net/ynl: Refactor fixed header
 encoding into separate method
Message-ID: <Zbjbr0eAqx8u5jW4@gmail.com>
References: <20240129223458.52046-1-donald.hunter@gmail.com>
 <20240129223458.52046-5-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129223458.52046-5-donald.hunter@gmail.com>

On Mon, Jan 29, 2024 at 10:34:49PM +0000, Donald Hunter wrote:
> Refactor the fixed header encoding into a separate _encode_struct method
> so that it can be reused for fixed headers in sub-messages and for
> encoding structs.
> 
> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>

Reviewed-by: Breno Leitao <leitao@debian.org>

