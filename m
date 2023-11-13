Return-Path: <netdev+bounces-47291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A1E47E96FB
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 08:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7DA21F21039
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 07:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18BA611C9E;
	Mon, 13 Nov 2023 07:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YtZiFWpE"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D657C13FEF
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 07:12:05 +0000 (UTC)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA70810E6
	for <netdev@vger.kernel.org>; Sun, 12 Nov 2023 23:12:04 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6b709048f32so3369852b3a.0
        for <netdev@vger.kernel.org>; Sun, 12 Nov 2023 23:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699859524; x=1700464324; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BJFimIUP8RM4XH47tH2SKKf1cAvNsG4+le7Jezyi0oI=;
        b=YtZiFWpEhZwjTh5flznMGVGFZ6xgmNLgFI3LTgIPUChHCTB6K4qMqeO8/gzjw8cMhB
         CpETUapZCFth7I02idpoBZx5cRYQMV8TBv1iKhsbsMmAPSFNTJ56fjTNF1JmP/q3D4/2
         ypX9VRAUl3X6ThpVVY4NUzFakzV6u11yx+DGxE9DywTiFekwDS3oyku9DQfDs8CIbA6u
         cNLfEWvXvouXSqBJaEsN/jUNiuFxA98ce/CliPFmqqE/1eeS8FfVE8Dmp5S3ERv4tlCG
         z86fIF0Yrnlc7kVH4630JgH6ne8B+QRXzYK5c9T/oXtXi9gPE69gHcQDPGaMpkr63PS7
         HqUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699859524; x=1700464324;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BJFimIUP8RM4XH47tH2SKKf1cAvNsG4+le7Jezyi0oI=;
        b=sXhLQ0ZvQsgBkbuw/QVi9Y/+MWS/+YxIw4aFFccp6ASOyiGuqHPbnDWykiikIdi2/v
         SzjRFraDNXYAdPMhZaW3dzY/Ul9I1rkULjXbQ++ES7oGeshewcUzehhpL6yLCQO72DTC
         VIMv8JZwxpVYZwGyJ0+boyS3d+RLsLF9nQHRHdfgiqmB2veJXNHMkYYzpRNPu1BpKqvF
         86zta5/EFd0Z7oGJVh65m+B3Ls5DqXHNsnNP8JqtHd88Mgn1uLrwsXOnfou3geIRENpR
         FCEKYkASeY65c96CGcFx0GonBRaWKGZ5ezXfZptExADAJmnKeJJreIDkfw0kkaEPuG4l
         NSpA==
X-Gm-Message-State: AOJu0YyHn4AtRHPVY0p++uNSLImOdpoHsdAKu9cj9qcmZR2W0EtQ+E6N
	1re+EMrN1FtypvizSir7Qjxb3s1Ro9YIWA==
X-Google-Smtp-Source: AGHT+IGjOApaRXmr++SjbH0e0Hk000Ox9onXQi32NLJO4NTqEcmTvaNfL08WpncyPrvUltfh/jZ2qg==
X-Received: by 2002:a05:6a20:1587:b0:15e:a8:6bb4 with SMTP id h7-20020a056a20158700b0015e00a86bb4mr3602456pzj.8.1699859523921;
        Sun, 12 Nov 2023 23:12:03 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id f6-20020a63e306000000b005b529d633b7sm3507854pgh.14.2023.11.12.23.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Nov 2023 23:12:02 -0800 (PST)
Date: Mon, 13 Nov 2023 15:11:57 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@idosch.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Roopa Prabhu <roopa@nvidia.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Florian Westphal <fw@strlen.de>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>, Jiri Pirko <jiri@resnulli.us>
Subject: Re: [RFC PATCHv3 net-next 02/10] net: bridge: add document for
 IFLA_BRPORT enum
Message-ID: <ZVHMPRBbvfbZGMgJ@Laptop-X1>
References: <20231110101548.1900519-1-liuhangbin@gmail.com>
 <20231110101548.1900519-3-liuhangbin@gmail.com>
 <20231111190237.GB705326@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231111190237.GB705326@kernel.org>

On Sat, Nov 11, 2023 at 07:02:37PM +0000, Simon Horman wrote:
> On Fri, Nov 10, 2023 at 06:15:39PM +0800, Hangbin Liu wrote:
> > Add document for IFLA_BRPORT enum so we can use it in
> > Documentation/networking/bridge.rst.
> > 
> > Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> > ---
> >  include/uapi/linux/if_link.h | 227 +++++++++++++++++++++++++++++++++++
> >  1 file changed, 227 insertions(+)
> > 
> > diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
> > index 32d6980b78d1..a196a6e4dafb 100644
> > --- a/include/uapi/linux/if_link.h
> > +++ b/include/uapi/linux/if_link.h
> > @@ -792,11 +792,238 @@ struct ifla_bridge_id {
> >  	__u8	addr[6]; /* ETH_ALEN */
> >  };
> >  
> > +/**
> > + * DOC: The bridge mode enum defination
> 
> nit: definition.
> 
> Also in patch 2/10.
> And fields is misspelt in patch 4/10.
> 
> As flagged by checkpatch --codespell

Thanks, I used to use --strict and didn't aware --codespell before.
I will add this parameter in future.

Regards
Hangbin

