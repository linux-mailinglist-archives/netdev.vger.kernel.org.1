Return-Path: <netdev+bounces-59675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F2F81BB7C
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 17:06:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75061B22837
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 16:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D194F20E;
	Thu, 21 Dec 2023 16:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="oKuBRY5j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4A526AE1
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 16:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6d940d14d69so686657b3a.1
        for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 08:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1703174787; x=1703779587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5JuBiQDwAmVLAv6rjwhFkiTq7LNJJfnHyzaphhX7zJE=;
        b=oKuBRY5j10x2PuHYo4zlqrxxEspz7VdRTUUR442k9O7os9q0Gc3VdNbqs86py1+Wmk
         L9ob/M38UZFF/9yUWzyKhW346gKSc2YAOotFENqTVoIkwvdNWM6PfUD4SeaUuT/wchet
         NMH4DlPC/CSlZGe9amNjDFndUxjiGPZSS9xV/hJKguraPhIKhygFJrXYjMqGaqZKqTiM
         HLAMert9DELW6ztJLs4p6gf6n4MWkaS/qeHZYZN2CXX+0xUqbNeYsPgujkPIxVkbyHoG
         cxL5o5VJulPgqvdwnfKem10cg+68X6MHK6to0/PK8X4Y2yn1UEaY9uP/w4bFB1ef21kk
         n/EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703174787; x=1703779587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5JuBiQDwAmVLAv6rjwhFkiTq7LNJJfnHyzaphhX7zJE=;
        b=tvoRUmiosyFaJoavW1yBkANOC+wHSvHDnShzK9MVeasoY0bnSMPGLmzcl7whXe1k5E
         uDw9B/uw/pIQ7MYhm7wHFO+GHWlQ01SaALUAQZFdKr0YdopVjp33SiRVXd416uwzyHAB
         u3pM5Mmg8ZutgPKO2+euQBdgrHfusSZDLZoTLEG3A9lHOUQRgQfQP1tnJTw4awP85Map
         Us2MmvTjgnuaN/nM+LW8+nyz8qF/caHgRXRMKnPHHLIYxeFMvR3JJBsewYp2cTh4JzOx
         HHXdDq7AzvM9WYXrd6ZD2e10QBDM1iWrXhXeu2MommoNrp95zpr/n0p0wrL7H+FcyXHw
         Ikzw==
X-Gm-Message-State: AOJu0Yxw4Xjz8ksg2go/jHIXdU/YkTZF/CZRO8kHrBN9owUUDfF9o4VE
	/9YFyLr959l/oR+4OpFgA6l+Yw==
X-Google-Smtp-Source: AGHT+IGeCJ+1oEk61wispgNm23D/Jp9GxzyZzSOLCqnqlEOm0CFm4C9I6UQQkxUfK1D5Xsld28acjw==
X-Received: by 2002:a05:6a00:1c83:b0:6d8:a4cb:9f2b with SMTP id y3-20020a056a001c8300b006d8a4cb9f2bmr4757836pfw.26.1703174787577;
        Thu, 21 Dec 2023 08:06:27 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id z188-20020a6265c5000000b006d095553f2asm1847718pfb.81.2023.12.21.08.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 08:06:27 -0800 (PST)
Date: Thu, 21 Dec 2023 08:06:24 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Benjamin Poirier <bpoirier@nvidia.com>
Cc: netdev@vger.kernel.org, Petr Machata <petrm@nvidia.com>, Roopa Prabhu
 <roopa@nvidia.com>
Subject: Re: [PATCH iproute2-next 01/20] bridge: vni: Accept 'del' command
Message-ID: <20231221080624.35b03477@hermes.local>
In-Reply-To: <20231220195708.2f69e265@hermes.local>
References: <20231211140732.11475-1-bpoirier@nvidia.com>
	<20231211140732.11475-2-bpoirier@nvidia.com>
	<20231220195708.2f69e265@hermes.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 Dec 2023 19:57:08 -0800
Stephen Hemminger <stephen@networkplumber.org> wrote:

> On Mon, 11 Dec 2023 09:07:13 -0500
> Benjamin Poirier <bpoirier@nvidia.com> wrote:
> 
> > `bridge vni help` shows "bridge vni { add | del } ..." but currently
> > `bridge vni del ...` errors out unexpectedly:
> > 	# bridge vni del
> > 	Command "del" is unknown, try "bridge vni help".
> > 
> > Recognize 'del' as a synonym of the original 'delete' command.
> > 
> > Fixes: 45cd32f9f7d5 ("bridge: vxlan device vnifilter support")
> > Reviewed-by: Petr Machata <petrm@nvidia.com>
> > Tested-by: Petr Machata <petrm@nvidia.com>
> > Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>  
> 
> Please no.
> We are blocking uses of matches() and now other commands will want more synonyms
> Instead fix the help and doc.

I changed my mind. This is fine. The commands in iproute2 are inconsistent (no surprise)
and plenty of places take del (and not delete??)

