Return-Path: <netdev+bounces-59449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 545D281ADE0
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 05:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC0CAB23D08
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 04:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22765660;
	Thu, 21 Dec 2023 04:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="FWgXHx7N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510805676
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 04:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-35d72bc5cf2so1620285ab.1
        for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 20:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1703131577; x=1703736377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7wEfrxsoyMCToKm0mbL3jfej9Gm21j5lTVLjh8rMy4E=;
        b=FWgXHx7NtIuEufgYhtzHrx+IAU4M6W4VzzPsvU2b7we6H6asa6FkTpNT6C1Vk89SZQ
         FAZyq7rcsuF1fcfdZdcfv78vCTZY/SGNy5YD+gw4nEcWlBzMFeLgXzhqCL/6WzlvgrvZ
         WnUSoq6r6T91Ftuaxuoh4zwkKmFt6gR6cpzukqFWiekwb2vDstv/q5mWUQuWytzLtU7v
         O8TYpeVdBOM3d4bi37Hip56JPnGsJF2vAWuwUVxRX0ouGOo6Rc/orM+AIyjwvTylvScy
         JSagIe1Xxycs+oDJ2e5NT5Tj0gIB6BdnfjbaeUN5DL3zgV3eDim8j+Qwdm6TwstQPIJQ
         G/pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703131577; x=1703736377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7wEfrxsoyMCToKm0mbL3jfej9Gm21j5lTVLjh8rMy4E=;
        b=AjCJMa0rkSNsk9tX+QjX9Tu6EsHgU4UuhY/HYTvBBdgBCqivwfBpYewZBpY8epqqiL
         ioNbdq/5wZ0tQ7qikOZwzpJWGBFspOiD6z8KbJl0+Ji2fLKpaQfqBLn2owZYICJEsEoS
         NL/upaAZaKTgz/Ntjhl2DUlt7ykd20sdJ1g7BNat/K2OuZYbJAyzb8XL9to7XFJTRs13
         lx83jAlg3YdxH4N7mb3QZ5+ZZqWWH0r16OFK6rMu/44JfdEGfbRdQ63aJlxpMJ+c5rdS
         w2jSdGOZg7tRFEku0lvBi3U68M2oDfKcCxKrOZEMR34D1nndDJSHk6gGURFG+3cl4WJ1
         0Prw==
X-Gm-Message-State: AOJu0YwheKuGtJAzQJgG23COVYFrDDDX9ej7jq2VCothngCw13sQkEaf
	fsNQi0w+SbZ8+Nchqrmcoxz2o6jzgtSNUFJIByQ=
X-Google-Smtp-Source: AGHT+IHHE7VDZpjWTGk5AIpCf/kLUUG/kq/i4WhpZ01KTof4kExGuZqfuyfMq+79jDgSAw7m20Rkbg==
X-Received: by 2002:a05:6e02:1a2d:b0:35d:5995:1d5c with SMTP id g13-20020a056e021a2d00b0035d59951d5cmr33542606ile.33.1703131577454;
        Wed, 20 Dec 2023 20:06:17 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id u16-20020a170902a61000b001d072591d77sm502134plq.247.2023.12.20.20.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 20:06:16 -0800 (PST)
Date: Wed, 20 Dec 2023 20:06:14 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Benjamin Poirier <bpoirier@nvidia.com>
Cc: netdev@vger.kernel.org, Petr Machata <petrm@nvidia.com>, Roopa Prabhu
 <roopa@nvidia.com>
Subject: Re: [PATCH iproute2-next 09/20] bridge: vni: Move
 open_json_object() within print_vni()
Message-ID: <20231220200614.274222fd@hermes.local>
In-Reply-To: <20231211140732.11475-10-bpoirier@nvidia.com>
References: <20231211140732.11475-1-bpoirier@nvidia.com>
	<20231211140732.11475-10-bpoirier@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Dec 2023 09:07:21 -0500
Benjamin Poirier <bpoirier@nvidia.com> wrote:

> print_vni() is used to output one vni or vni range which, in json output
> mode, looks like
>       {
>         "vni": 100
>       }
> 
> Currently, the closing bracket is handled within the function but the
> opening bracket is handled by open_json_object() before calling the
> function. For consistency, move the call to open_json_object() within
> print_vni().
> 
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Tested-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>

Acked-by: Stephen Hemminger <stephen@networkplumber.org>

