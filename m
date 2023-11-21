Return-Path: <netdev+bounces-49530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 976197F2479
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 04:06:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F173282803
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 03:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFDCB14299;
	Tue, 21 Nov 2023 03:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F3v7ue+L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B7ACB
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 19:06:10 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3b2e330033fso3397546b6e.3
        for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 19:06:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700535970; x=1701140770; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ATUSdrBcD3z9iPp6ArJ1NAA3tvepevD9iVXPfvwdkuc=;
        b=F3v7ue+L6RpgmUQLDa21poL18FkLRygokWYajQXSday9Oe/4Rq3lI7VpL4WZraPFIS
         P0vgC9Vdn5G5JU58zCZ+lHv4NcbX0rULeydZY5DMNocwLNRmLIgIL3Jjs8Hoas4ax55n
         OZxeAxXTk5UirqAzDbLWsj7EzWxx6WT/8Q2nfmFHKsaxnw6t7h/fSbbDsxH1/1LbtT/T
         sPjiSH811k6J4l5jJ9QjhDIcA9VSCxOLpb53WrMf1IYJFzOSeEjoO4xFC6SCIrHEqwcR
         2vob50E/XsJUPz+7uAkWpXFoxciETfddRilWzD3zlCGyUZ1gP/WciRlDhgUIqVGpZbK8
         aT+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700535970; x=1701140770;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ATUSdrBcD3z9iPp6ArJ1NAA3tvepevD9iVXPfvwdkuc=;
        b=V/mHj2e4D2/q9WbQiXSIQftj4oxrdwd9UAyldQlGlgTnn2hSxGpqIdNqtHjVcVdhuT
         K5Q96/9H8HEVivN9SQWLMlFkaiekbPt6ryUJfAmW1clLN1xh1fySYg9s7/4JZoWpjDmF
         tKwc8f9jsrQIRrOVc/iG+ixNbApWw5Grhnym1qOnLiHIsUz9PHweF1xVvckyYzWbnIUE
         qfx71wC+IzzC7XFJYybwtylvmdq4mjCLb43zuMT2tx7Ek5zTjclNwGFuh9Ii5humYXed
         qCtfFQkgXrBrk0+qx87EF9F7gJ8GD99LFpI1VXioPZQMg7tMrC9gdmZuc6M2mRJlG6rv
         ATGQ==
X-Gm-Message-State: AOJu0YzvzUQzQBDZ2RRsz/wwOE9RFFqxiZonpcM9DtDALP9Onm8I26qy
	PVLK2fJLwrqKCuNQpqtfwmM=
X-Google-Smtp-Source: AGHT+IElixDUb5/p5MRC1dbWWUkdpSMng+Nkjdb5OY9LfzLB8qRPpUPgGg+awacHcvCQwftHM5V04Q==
X-Received: by 2002:a05:6808:444c:b0:3a7:d566:8b5e with SMTP id ep12-20020a056808444c00b003a7d5668b5emr11511259oib.44.1700535970058;
        Mon, 20 Nov 2023 19:06:10 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id g13-20020aa7874d000000b006cb8e394574sm3025096pfo.21.2023.11.20.19.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 19:06:09 -0800 (PST)
Date: Tue, 21 Nov 2023 11:06:03 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Vladimir Oltean <olteanv@gmail.com>
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
	Jiri Pirko <jiri@resnulli.us>, Marc Muehlfeld <mmuehlfe@redhat.com>
Subject: Re: [PATCH net-next 01/10] net: bridge: add document for IFLA_BR enum
Message-ID: <ZVwem+r3C9FOVvN8@Laptop-X1>
References: <20231117093145.1563511-1-liuhangbin@gmail.com>
 <20231117093145.1563511-2-liuhangbin@gmail.com>
 <20231119164625.d2yzi3mpxv72t6pp@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231119164625.d2yzi3mpxv72t6pp@skbuf>

On Sun, Nov 19, 2023 at 06:46:25PM +0200, Vladimir Oltean wrote:
> On Fri, Nov 17, 2023 at 05:31:36PM +0800, Hangbin Liu wrote:
> > + * @IFLA_BR_MAX_AGE
> > + *   The hello packet timeout, is the time until another bridge in the
> 
> No comma between subject and predicate.
> 
> > + *   spanning tree is assumed to be dead, after reception of its last hello
> > + *   message. Only relevant if STP is enabled.
> > + *
> > + *   The valid values are between (6 * USER_HZ) and (40 * USER_HZ).
> > + *   The default value is (20 * USER_HZ).
> > + *
> > + * @IFLA_BR_GROUP_FWD_MASK
> > + *   The group forward mask. This is the bitmask that is applied to
> > + *   decide whether to forward incoming frames destined to link-local
> > + *   addresses. The addresses of the form is 01:80:C2:00:00:0X, which
> > + *   means the bridge does not forward any link-local frames coming on
> > + *   this port).
> > + *
> > + *   The default value is 0.
> 
> I'm confused by this description, I believe some of the wording is
> misplaced. Maybe:
> 
>    The group forwarding mask. This is the bitmask that is applied to
>    decide whether to forward incoming frames destined to link-local
>    addresses (of the form 01:80:C2:00:00:0X).
> 
>    The default value is 0, which means the bridge does not forward any
>    link-local frames coming on this port.
> 
> > + * @IFLA_BR_VLAN_DEFAULT_PVID
> > + *   The default PVID (native/untagged VLAN ID) for this bridge.
> 
> I don't think that "native VLAN" is a good description of this.
> The native VLAN should be the only egress-untagged VLAN of a port.
> 
> I would say "VLAN ID applied to untagged and priority-tagged incoming
> packets".
> 
> > + *
> > + *   The default value is 1.
> 
> I would also mention that the special value of 0 makes all ports of
> this bridge not have a PVID by default, which means that they will
> not accept VLAN-untagged traffic.

Thanks for the comments. I will update it in next version.

Hangbin

