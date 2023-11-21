Return-Path: <netdev+bounces-49531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F27C37F2482
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 04:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F14BB21A22
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 03:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB541549C;
	Tue, 21 Nov 2023 03:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PkPKKKci"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E8DBC
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 19:10:30 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-2839cf9ea95so2229225a91.1
        for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 19:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700536229; x=1701141029; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4Ukj6CaxUhfxNn0AfylFpzIaTN++R+b331fvGhFHuSg=;
        b=PkPKKKcipOr+bRLrZXQLdMzAlJe5UsWTeUkicKJqNRWg0hpKSCNIqamoY8WeD/5KXy
         ACqYeeI+wR3EfF0U5uH1eQgcFCdqUGN5AHTFjOp/+1hUtv9RjUYPUxgBFhvvJyOAQG+a
         DDAWWCNCaSqCeZho0AEa8iYsc3E9Q7PNX/0rzy1rRgXw0Xi/GRNnzzr1O9wsl2vRJiJT
         JxyGDV0xYhx8WXClj6MEbKBCr3Z9HPQKipO9V3+BGbdZpeRrKyYKJFNvn8uyrL3cXbqK
         Z60eEVQu47vMhN4xJk8TxDbZ0xxV+zXhoHxB8Xq0caQTjyMM+qvItOHBQDjSBthLznxG
         GSVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700536229; x=1701141029;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Ukj6CaxUhfxNn0AfylFpzIaTN++R+b331fvGhFHuSg=;
        b=fChuC1QaW2/OS56ra9Id2eGCYazVN4bgssStHZMWf9V1TqWryM0XreQWtA3ttEcIuT
         McZ/o3aTd2jeRzVmVbQZ/DitGaiitLVBLQgLZzxpbVmhBU+0gRUZtv9ylfp/7Ab8ni30
         oWB+Porvv7OR2zyhpTYvcdpHC4NKD35bOUTffW23/qsurcm8b2weOib8k1J7IoVK1Pn2
         Y8UbShTZN1ZcHYAV77UEn1IAfMqExF+cb2DC+OMfvnVgj+OK1uzEYDomvZswfLtrKgSI
         9icoVfSMUd3E4U5y2P07/wxe+PybR59inOp2ncGm/jxPSJWv5qhTNLmCW/9Vn5GCohPz
         dLkw==
X-Gm-Message-State: AOJu0YyJYnsydRG6LgYKmm2m1xCUpfDvVl68Q5gVnenPTl9qYCnM7fa+
	LoVULgZUnr3sz02z3hyvQ7I=
X-Google-Smtp-Source: AGHT+IERuyX7I+bqmQGmV1Jgspz8J87INYYWCnH18r/rjzP55wd4TmYcqs74fOiihQdELHI2sS7Alw==
X-Received: by 2002:a17:90b:1c81:b0:280:f4a:86b4 with SMTP id oo1-20020a17090b1c8100b002800f4a86b4mr7557705pjb.17.1700536229429;
        Mon, 20 Nov 2023 19:10:29 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id p7-20020a17090a680700b002800e0b4852sm7951655pjj.22.2023.11.20.19.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 19:10:28 -0800 (PST)
Date: Tue, 21 Nov 2023 11:10:22 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Vladimir Oltean <olteanv@gmail.com>, netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@idosch.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Roopa Prabhu <roopa@nvidia.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Florian Westphal <fw@strlen.de>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>, Marc Muehlfeld <mmuehlfe@redhat.com>
Subject: Re: [PATCH net-next 01/10] net: bridge: add document for IFLA_BR enum
Message-ID: <ZVwfniWZnX65w6sj@Laptop-X1>
References: <20231117093145.1563511-1-liuhangbin@gmail.com>
 <20231117093145.1563511-2-liuhangbin@gmail.com>
 <20231119164625.d2yzi3mpxv72t6pp@skbuf>
 <86124486-3290-4507-8158-57eaf5bbb8a4@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86124486-3290-4507-8158-57eaf5bbb8a4@lunn.ch>

On Sun, Nov 19, 2023 at 07:21:25PM +0100, Andrew Lunn wrote:
> > > + * @IFLA_BR_GROUP_FWD_MASK
> > > + *   The group forward mask. This is the bitmask that is applied to
> > > + *   decide whether to forward incoming frames destined to link-local
> > > + *   addresses. The addresses of the form is 01:80:C2:00:00:0X, which
> > > + *   means the bridge does not forward any link-local frames coming on
> > > + *   this port).
> > > + *
> > > + *   The default value is 0.
> 
> Where was the default value of 0 derived from?

I doc it as 0 because I saw in br_dev_setup()

        br->stp_enabled = BR_NO_STP;
        br->group_fwd_mask = BR_GROUPFWD_DEFAULT;
        br->group_fwd_mask_required = BR_GROUPFWD_DEFAULT;

and #define BR_GROUPFWD_DEFAULT     0

Thanks
Hangbin
> 
> br_handle_frame() seems to handle 01-80-C2-00-00-00 using is used for
> BPDUs. 01-80-C2-00-00-01 is explicitly dropped, since its Pause, which
> i doubt you want to forward. LLDP has some level of processing.
> 
> Should the default value reflect this?
> 
>        Andrew

