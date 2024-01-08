Return-Path: <netdev+bounces-62347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0A4826B97
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 11:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B9DB281354
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 10:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A15263A5;
	Mon,  8 Jan 2024 10:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Tp9X05Ue"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7118313FF0
	for <netdev@vger.kernel.org>; Mon,  8 Jan 2024 10:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2cd0d05838fso16764741fa.1
        for <netdev@vger.kernel.org>; Mon, 08 Jan 2024 02:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1704709872; x=1705314672; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t08xFHr7Xb15NuDTY59W3WRXFYEHt0zwUBEd40W83NQ=;
        b=Tp9X05Ue7CWYoNr9cYvCo5c1LPUQuGJWph5UrYRZPhIeRmXQGemMdb3iD9q57gGIf7
         xQw0vfNpqTxgAdJ19Rt7n0/f+rTYKaN0d2ZG9GxyRNAxpVr6sNVnEho78y+fUdLx670F
         4qzA/7/6Mpnjk/Qgeeln/sLmBqEOxJvfplEXGiqN4y2xBD9v713jRECirMyiBJMETros
         sQtqx482WrSxAxRuehOStKkveBZdntE0FY82VyJCnsc8QBdbuEzb0VpIhh2N8lUCl2UP
         O6aspOevyvsj7e+z3agRP7qFdZQp0y9T7S193e2D2dvP/GVHNljn4QRvxdHn6mZY6Cpl
         C/qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704709872; x=1705314672;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t08xFHr7Xb15NuDTY59W3WRXFYEHt0zwUBEd40W83NQ=;
        b=c0EalW1+ALJzFC7ytB8IiditE3g3kqaDxBX/6M4A4cwJJWwg7qYmuRxxyTu902eUQL
         EwLiLI7L/RqQ+lwJiiGy1mXqtFJR8qzBXGsaztUV4+AWP9EVD8jLngAYRqbVbKAWa2q1
         A1fE+vXffxUGHeX0Rdd1JMRSyUspkk9cBk1CKNeXrmZ4OdZCWt8udn+RR1rPZBDxGjVJ
         RXMe0Ai60eeSPXaZXdXJji4Y36p+4TFglaUEcQIV+7mz6/BwPQD060WtbXL0mzDpqbau
         ez6D+DrB2ZUruwpgJSbCyuv4rzdyiJe2797vfjvzDqpxPvblLh6FVUno37BzxB9ZowtP
         EiNg==
X-Gm-Message-State: AOJu0YwaNPLenC7I+XyW2d0bnzN32wDOrgVnnkQuYlrop+S3TkQSYazV
	VHBSf3bnXp5cAz6orRXAmA6grRHxuF4FpA==
X-Google-Smtp-Source: AGHT+IH2vRbqNm4A1qlBcHSuWxPBWfU8ozsPU6z4FxN++KiI33gQvjPNCv1CEaDJc3kML2omVml0gw==
X-Received: by 2002:a2e:be8d:0:b0:2cd:4c5c:7b8b with SMTP id a13-20020a2ebe8d000000b002cd4c5c7b8bmr1023346ljr.34.1704709872364;
        Mon, 08 Jan 2024 02:31:12 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id v1-20020adfe281000000b003365aa39d30sm7432512wri.11.2024.01.08.02.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 02:31:11 -0800 (PST)
Date: Mon, 8 Jan 2024 11:31:10 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>, Phil Sutter <phil@nwl.cc>,
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH net v4 2/2] selftests: rtnetlink: check enslaving iface
 in a bond
Message-ID: <ZZvO7lOmdUG9Rpz1@nanopsycho>
References: <20240108094103.2001224-1-nicolas.dichtel@6wind.com>
 <20240108094103.2001224-3-nicolas.dichtel@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240108094103.2001224-3-nicolas.dichtel@6wind.com>

Mon, Jan 08, 2024 at 10:41:03AM CET, nicolas.dichtel@6wind.com wrote:
>The goal is to check the following two sequences:
>> ip link set dummy0 up
>> ip link set dummy0 master bond0 down
>
>Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

