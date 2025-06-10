Return-Path: <netdev+bounces-195974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3D4AD2F80
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 10:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 784D216442E
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 08:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A0F27A92D;
	Tue, 10 Jun 2025 08:06:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB757E9;
	Tue, 10 Jun 2025 08:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749542790; cv=none; b=BkeR7J2huLucPCLxqml2/Hhm4mpEX6I7Ci1MoOxwkdbAVqFjUMxF8TCd6S/F3ZaXcrTDV95biTOgRzAWcn4aFj6d2DBPi7MwV5sJQSHOufB+5bxeQzdxt8xUgKQ1WWokmv8Yr4YfFCLR1MmRfE/J/RxbgEVHKZYQOxQ4/E2I1us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749542790; c=relaxed/simple;
	bh=oofEe6usbj+qKOpysPdU+fJP4MUaYO5/A/AQXFZCWa8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sFn9b2RdWww0fYU4OU6S/6SkM6JuUw8aYkfPWxIUgmY41nrEPKTzXcWcbiwbkDD7N6PRgM5bj3yo2Cp8JI2y3mtlHmc4hjXDGNtpxM4r3pp42Us5At4DGjrH16pWZgj8SWMQCtK7krzfzL3+cYMPWryZVtCuhq1c9u9Q/EQfXBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ade76b8356cso141460566b.2;
        Tue, 10 Jun 2025 01:06:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749542787; x=1750147587;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BU+jtFAxsbmD1oSGWe/PHbt+kKKNnnYvXpq5CdpQ3QA=;
        b=qFndv5P7G8KW3UArPuF2FinAUIQFOUL8g7mHzVvPoNa9WNLLqPWAos2azaHpuYtpBx
         krtmkt0wA8VMlbpvhP856OylLK1sTCHBIT5oz+QHYSgQt3GprmcQDeKFK2qlzHnoaE+v
         Hbq5CsAWIstG62deZDe/YaOIgAo5iysnD17gOsQa9dNcXUWb7Unx2/MdO7ZDYi1U/0Sl
         X8+uA0UP6iYdovBPKZTDWWNPXPbZd50cxNZCwvCkzGe1UxqXch+rZ0aY0spNbAD8KgYr
         sGxyBnSZ00fp7X7TpBwzvbtDCfyHhCK2d/twqxuVXPa+HvLiZJPKjxQoTZOrjWrT2rwQ
         Ly4w==
X-Forwarded-Encrypted: i=1; AJvYcCVfdTYRHwoE/9gNx9nnRYZTT7kW2rIr+P6UM8ciVV2TpOIrhAfp4UVjUb4HbrzoHFjrjml8ryam@vger.kernel.org, AJvYcCViykZKAyfdj9A0I2hyxqnA4ES50Y0Z0wU6YZLrWVl5YI2f7xc5n5As45Gdo37dNXxdiACV9ZgVnEOyh/o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvYqnO141fjfIcJlP7RzKxdpsjWKVNIWGhaUoYoOQotIIj7ha1
	wRgoKuxNe0zAuVCc7WXPMzKjREKnqYglNc4kCxxkXb9vG7GQDQrHifzP
X-Gm-Gg: ASbGnctjnyujE4PrKYoxU1OBbqXdGen/h9xA/8EbFROSvTTU0R+kPogIDGMB6suYbbh
	guRot3ZZ5UTjRI1bmacU0CNAjfBeF5tg3h2eaeXgjGExoFMIARys/+v7AdCDBCf92CnagmQMvNP
	EHkTLm6SV/3otsAfjCrYtXyjuZgytSaQ63LlaAjeFZMGtfC2gi4InEFJU7DopvcvNbq9YBDIvTW
	WoAtrdvQz9LacVFKoXm4nEEXlBmoJnSLjeYTOPyNmYkLtxvgn4PK7BNyyJwZ4+H0FjEMH+MqT7p
	4lBPBdmizUUUCtmUjjismsnoiL0qzpkb4EGvLFJFopOBJG8uPtfO
X-Google-Smtp-Source: AGHT+IHvp9ssXqL+sQbF0Pqu3m/lzBCQFqu7LbWBTPnLJ9OumSC65Ukoyd3wQye+bHoOL3D/2IKl3g==
X-Received: by 2002:a17:906:3e0d:b0:ade:3eb6:3b0 with SMTP id a640c23a62f3a-ade3eb609ffmr791351566b.31.1749542787282;
        Tue, 10 Jun 2025 01:06:27 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:5::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade1e361462sm672758066b.184.2025.06.10.01.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 01:06:26 -0700 (PDT)
Date: Tue, 10 Jun 2025 01:06:24 -0700
From: Breno Leitao <leitao@debian.org>
To: Gustavo Luiz Duarte <gustavold@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] netconsole: fix appending sysdata when
 sysdata_fields == SYSDATA_RELEASE
Message-ID: <aEfngKdDKgQH2yZq@gmail.com>
References: <20250609-netconsole-fix-v1-1-17543611ae31@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250609-netconsole-fix-v1-1-17543611ae31@gmail.com>

On Mon, Jun 09, 2025 at 11:24:20AM -0700, Gustavo Luiz Duarte wrote:
> Before appending sysdata, prepare_extradata() checks if any feature is
> enabled in sysdata_fields (and exits early if none is enabled).
> 
> When SYSDATA_RELEASE was introduced, we missed adding it to the list of
> features being checked against sysdata_fields in prepare_extradata().
> The result was that, if only SYSDATA_RELEASE is enabled in
> sysdata_fields, we incorreclty exit early and fail to append the
> release.
> 
> Instead of checking specific bits in sysdata_fields, check if
> sysdata_fields has ALL bit zeroed and exit early if true. This fixes
> case when only SYSDATA_RELEASE enabled and makes the code more general /
> less error prone in future feature implementation.
> 
> Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>

Fixes: dd30ae533242 ("netconsole: append release to sysdata")

Reviewed-by: Breno Leitao <leitao@debian.org>

Thanks for the fix,
--breno

