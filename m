Return-Path: <netdev+bounces-47918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C172D7EBEBE
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 09:45:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CE03B20B41
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 08:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348B12E835;
	Wed, 15 Nov 2023 08:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZpgQ84f"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09FE7E
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 08:45:00 +0000 (UTC)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9EB10E
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 00:44:59 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1cc394f4cdfso49672205ad.0
        for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 00:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700037899; x=1700642699; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vlZrY0+JE4q6lJIqTuynycpilaiq+mrZgqppDYtZgHw=;
        b=JZpgQ84fqamX6/jrKAuyXlb2mmCfSpei2T89uG3gx5ziq4tY+Mk2gFZmPT/FePvGWw
         8gL56vFnsw4Djm317npveRq3jyrJNToSbVh2Rksvd9nlFLTeXShes+wFfFHqhZs6rcg0
         A+m3x/Q47HHhKyM6OXwAGRm+IQ5aHyxIVHl9V5GPiaLD9mfdjyh0IWAF4m58gz87e0+l
         rWen34ZnHXSL0rIdXITdLQcG+SR2QhWrrse3h8QzVj2E7OkEdJToZU3UANb624iY04RT
         aaD2SIEaKZPgGwI3uDm2JgOdxu2rfFGSJQbUhBv+c35EtaCWy3jC7IowWkfqvYIUR5Nv
         tC4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700037899; x=1700642699;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vlZrY0+JE4q6lJIqTuynycpilaiq+mrZgqppDYtZgHw=;
        b=uvxgsYxSy4QzvIGwTP93z3Mv+SfN4cToP/Ei8PDBkCA9S9+yLZcEosNM8EMTPfiK/3
         5gHF+EPRWkDR+jA8fLNyoLbSIxFOmDFvEUmYDGw1X1qD21dKYXcnKkSFWR7HaJMl2sAE
         86zWVTZk6C4MFs6gyphQzU6WfRdyylZwMoVjT7cQCxg5zn3P2Qj6wqZ/1eQpyRYvEDOR
         XvjsD+7NKq5PYR4mfU2BtROJ8hS2vspiDMP+5zHgoYRGV6rDzIbdg2sSkU6kYiC0atBZ
         n0vMzo2e3fubKIx+he8M5aGhZU29FTDLvsTEtyFWyh9z/qYSWcddLrhrNJvVK63MBIXA
         2WpA==
X-Gm-Message-State: AOJu0YztkX6C5WqR1igqFDcF3vtR1G0u9GNZU+XchGo6EK7QVCb+x2v8
	PwM43Y1ep6OpoQcV1CMBfA0=
X-Google-Smtp-Source: AGHT+IF4M5uVriRTmlQOenlbfvEtWrGmb3NtO/kigJ0zFdZadV4HwIKeyizdpTavt4LrEEg1Hj0Cbw==
X-Received: by 2002:a17:902:eecd:b0:1cc:4921:af1b with SMTP id h13-20020a170902eecd00b001cc4921af1bmr4608334plb.7.1700037899352;
        Wed, 15 Nov 2023 00:44:59 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id iz13-20020a170902ef8d00b001c726147a46sm6952659plb.234.2023.11.15.00.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 00:44:58 -0800 (PST)
Date: Wed, 15 Nov 2023 16:44:53 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@idosch.org>, Roopa Prabhu <roopa@nvidia.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Florian Westphal <fw@strlen.de>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>, Jiri Pirko <jiri@resnulli.us>
Subject: Re: [RFC PATCHv3 net-next 02/10] net: bridge: add document for
 IFLA_BRPORT enum
Message-ID: <ZVSFBcC+bv3hR6kR@Laptop-X1>
References: <20231110101548.1900519-1-liuhangbin@gmail.com>
 <20231110101548.1900519-3-liuhangbin@gmail.com>
 <32765b21-cab2-56f0-3e90-1f5d5c376280@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32765b21-cab2-56f0-3e90-1f5d5c376280@blackwall.org>

On Mon, Nov 13, 2023 at 11:44:21AM +0200, Nikolay Aleksandrov wrote:
> > + * @IFLA_BRPORT_LEARNING
> > + *   Controls whether a given port will learn MAC addresses from received
> > + *   traffic or not. If learning if off, the bridge will end up flooding any
> > + *   traffic for which it has no FDB entry. By default this flag is on.
> 
> The second sentence is not necessary, that is the default behaviour
> for unknown destinations whether learning is enabled or not, it has no
> effect on it. You can mention that it learns source MAC addresses
> explicitly.

Thanks, I will change this paragraph to:

Controls whether a given port will learn *source* MAC addresses from
received traffic or not. By default this flag is on.

Hangbin

