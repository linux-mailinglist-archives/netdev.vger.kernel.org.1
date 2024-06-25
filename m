Return-Path: <netdev+bounces-106378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D2C916095
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 10:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E88DD1F21212
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 08:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B7D145A0A;
	Tue, 25 Jun 2024 08:02:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41387344F
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 08:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719302550; cv=none; b=A4Tpyh49JQY0pCR+wa9o3uh+3Fusgbmwc/DxpDM9a4ZqKOugwh4CZRjtA9YeNjhlF+qpnBR4Yhj/0m8haJrE/mTIe83sqyH0a+Q5nuyZjYrrOsKAifZPBcF6/JMq6hCQbvRyXOhK1U9yVoHabPII4OHAnVm3GyJ9+jE1Tx0yeqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719302550; c=relaxed/simple;
	bh=1th7gwbJFWbKEpzq8+H54Lo1xGHWlsrwmHeDXcLm8WA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i2wY+giEVaTJ85X4N02+3PoNI/mkl1N09Nkks7uQatYFRf7wvRF+t6EaH2PfL7L5dUWknp4HVyhkJQQKhxYz0wB+PMKWTTTAZri50c7V+u2zWBXHJvK4vNK/3LLilU6URzqM7uC/RcPXTds48xNUl/f/p84W4TLg6F8QeI1elG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-57cbc66a0a6so5252304a12.1
        for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 01:02:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719302547; x=1719907347;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SBueNGYQm1KDw1uplbdczSosYxUYjyuknzMi/VzT0uM=;
        b=Zov1N+rkBITaI5CrSTOx/33u68nIAT8HFrRLhdjBnI/e+smFuC17XYIQUExEPGYP1i
         SQGuz7d2HazU2V8GLOyrSLbdlHCjL6WZnD4GCave6evYBHTQEmus4/6feCkAY0woSJ1O
         8ZnARB9/2YfI1WyCLWoBAbUyOlI7aSoVvNmV1NN6wo/Toj6UYd/zGev1EwQXGzBMR60Z
         OKZkh8B+DBMrHuubx3eMNZ332IHOyr2GtJlVe6GzDbcJ++uQSXyCW5hQnJdIpBkQ9hEj
         6axhSd3iiTancbGGgRll3ip7/1APaDOMR5P0HXijUUVk658lyATkwb3y676Jm5QXuZGM
         S+MA==
X-Forwarded-Encrypted: i=1; AJvYcCW4nnl3Dv99L+C8U6Zxrf54ugl7BxZkNlIWTZqUe6x4JfHQ7DCtYXdHCrSPYwYppZ+AiKjJDO4mmuUw+8k+zvBgVsYY/gQv
X-Gm-Message-State: AOJu0YwxUXy51LCGsFqPDr5qX4fTb/F/9SvhAAyIsm87je+G+ZD6OIfr
	YvVEjsU6YZXtQ5Iq283eCN/y9z+Haf6g8W9r2dKLodP3EP6w7u853lOgTLzK
X-Google-Smtp-Source: AGHT+IF54XTL8tvTNeASXgIxArE5npTa/LhGGLIfWqhSoHEZw7RjIhuLr9nNBNKGahY00DQRDjFnIg==
X-Received: by 2002:a50:d75a:0:b0:57c:f948:bf19 with SMTP id 4fb4d7f45d1cf-57d701d0338mr1434166a12.7.1719302546967;
        Tue, 25 Jun 2024 01:02:26 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-008.fbsv.net. [2a03:2880:30ff:8::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d30582262sm5555691a12.94.2024.06.25.01.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 01:02:26 -0700 (PDT)
Date: Tue, 25 Jun 2024 01:02:24 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, willemdebruijn.kernel@gmail.com,
	ecree.xilinx@gmail.com, dw@davidwei.uk,
	przemyslaw.kitszel@intel.com, michael.chan@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: Re: [PATCH net-next v2 1/4] selftests: drv-net: try to check if port
 is in use
Message-ID: <Znp5kEhm79Myg4zW@gmail.com>
References: <20240625010210.2002310-1-kuba@kernel.org>
 <20240625010210.2002310-2-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625010210.2002310-2-kuba@kernel.org>

On Mon, Jun 24, 2024 at 06:02:07PM -0700, Jakub Kicinski wrote:
> We use random ports for communication. As Willem predicted
> this leads to occasional failures. Try to check if port is
> already in use by opening a socket and binding to that port.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> v2:
>  - remove v4 check (Willem)
>  - update comment (David, Przemek)
>  - cap the iterations (Przemek)
> ---
>  tools/testing/selftests/net/lib/py/utils.py | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/lib/py/utils.py b/tools/testing/selftests/net/lib/py/utils.py
> index 0540ea24921d..16907b51e034 100644
> --- a/tools/testing/selftests/net/lib/py/utils.py
> +++ b/tools/testing/selftests/net/lib/py/utils.py

> +        except OSError as e:
> +            if e.errno != 98:  # already in use

To make it a bit clearer, you can use something as:

	import errno

	if e.errno != errno.EADDRINUSE

