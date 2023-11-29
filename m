Return-Path: <netdev+bounces-52030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D86F77FD00D
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 08:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE2DF28258C
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 07:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE49D10A3A;
	Wed, 29 Nov 2023 07:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JEMLej/B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D5B10CB
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 23:43:31 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-3b565e35fedso3711935b6e.2
        for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 23:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701243810; x=1701848610; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gwSJqf/p/hsIuruQYBbSZo4gn3LejwuZg59tE4EOm5k=;
        b=JEMLej/B+yvQnIXNVwdFzxOlnZD4MWZ91ECqUFdr+k2falaw1WPRFL3qgeSYdJUfWw
         oOdapQqQ01KsUn/ON3yqVHStSm5oIwHy+VOkxkkyE8S4wkmEQ2fAIzKO84B9UnFNf0Xu
         XJrNgARZWe7V8olyk9VeOcAkrK286LrnDRZz4P3JyddAO2V4i/f/l7NKe0+gUdp494v2
         Hlkmb9hnU6fhiaFTeoDZrFmSZ2Ae5n6CkzOCGkxrhqSkTuQ577Xh6t/F9IQloQKMs5W4
         ohpb4JNpB7CySNw1MK5wGnlosmfm9u9+5jj9m49UUC7d3yKZFMC8lLuZU+7QxfdCKo+s
         OL2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701243810; x=1701848610;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gwSJqf/p/hsIuruQYBbSZo4gn3LejwuZg59tE4EOm5k=;
        b=S0eeePo+GJE8hoBk4TPe3zKXxBH3WA1T0Nm0Akv7/DfzYUwOgx0bNUjr/A+FjJDd4w
         6OGo8W06dLalTKq3ZB7Q4dHhT0QvyIlY3TLxW1PkO8Uralsbp0Hg/iPDIHD8CHRjNovf
         F72WNOvA2pdRyc33s7yyHhrkNh9JE6KM12RtX4Z3cXANqiVlHfrsqsGHGNjyViXtB8yW
         SLDJsDJnirINjLpDTmcNCofEY1BpTpUXpb3BcA9F/eXsnyV+uGJYcSRkG7V7Opm3IfSh
         8l0SUCSAxdoCU8wB1cX64ACXI4H8j5O8S01bI3W10NxXEYlcIFbjEiDepLVDTIx4kSYC
         YKMw==
X-Gm-Message-State: AOJu0Yw+ywuReXYSmB6qxL8GpRNkiXSRtaVKUHfU0xPOj2WDgwA0pP6M
	6BOU458xmZTwjGB2JVjTP0A=
X-Google-Smtp-Source: AGHT+IHBrBuntsW3+m6f/Gdh+/zN3ryLEk1Dyz3J8SVTUPFDF31k0VYnP9dl0baXTGTAFTmUi+q0eA==
X-Received: by 2002:a05:6808:494:b0:3b8:4614:8b27 with SMTP id z20-20020a056808049400b003b846148b27mr18722253oid.50.1701243810419;
        Tue, 28 Nov 2023 23:43:30 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id r1-20020a62e401000000b0069ee4242f89sm10473755pfh.13.2023.11.28.23.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 23:43:29 -0800 (PST)
Date: Wed, 29 Nov 2023 15:43:24 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@idosch.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Roopa Prabhu <roopa@nvidia.com>, Florian Westphal <fw@strlen.de>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	Marc Muehlfeld <mmuehlfe@redhat.com>
Subject: Re: [PATCHv3 net-next 05/10] docs: bridge: add STP doc
Message-ID: <ZWbrnK9VKczMrCMb@Laptop-X1>
References: <20231128084943.637091-1-liuhangbin@gmail.com>
 <20231128084943.637091-6-liuhangbin@gmail.com>
 <20231128144840.5d3ced05@hermes.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128144840.5d3ced05@hermes.local>

On Tue, Nov 28, 2023 at 02:48:40PM -0800, Stephen Hemminger wrote:
> On Tue, 28 Nov 2023 16:49:38 +0800
> Hangbin Liu <liuhangbin@gmail.com> wrote:
> 
> > +STP is a Layer 2 protocol that operates at the Data Link Layer of the OSI
> > +model. It was originally developed as IEEE 802.1D and has since evolved into
> > +multiple versions, including Rapid Spanning Tree Protocol (RSTP) and
> > +`Multiple Spanning Tree Protocol (MSTP)
> > +<https://lore.kernel.org/netdev/20220316150857.2442916-1-tobias@waldekranz.com/>`_.
> > +

The STP was originally developed as IEEE 802.1D. So how about keep this part,

> 
> Last time I checked, IEEE folded RSTP into the standard in 2004.
> https://en.wikipedia.org/wiki/IEEE_802.1D

and add a new paragraph like:

The 802.1D-2004, removed the original Spanning Tree Protocol, instead
incorporating the Rapid Spanning Tree Protocol (RSTP). By 2014, all the
functionality defined by IEEE 802.1D has been incorporated into either
IEEE 802.1Q-2014 (Bridges and Bridged Networks) or IEEE 802.1AC (MAC Service
Definition). 802.1D is expected to be officially withdrawn in 2022.

Thanks
Hangbin

