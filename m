Return-Path: <netdev+bounces-47933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7FB97EBFC9
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 10:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B7E31F26811
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 09:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C2B9465;
	Wed, 15 Nov 2023 09:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hkvX0dpo"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6167E
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 09:56:03 +0000 (UTC)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2DA511C
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 01:56:02 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6c396ef9a3dso5715157b3a.1
        for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 01:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700042162; x=1700646962; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qD0bQuuTi8xwLp9nUOcJhiWY+SrfRPdiiiXa8bGFI0M=;
        b=hkvX0dpovKXFLDIp91lAg2gVfivaEwkZBV+2tVPV7gW2+SEM+rZNGYTs8GqAT3mKYQ
         QOckA4lS6l86szwZMinOjRAsXNfC3DA5aNuuJ6nehjfzI0MF08YEFcNlngktLuPc/+f/
         PC378ImDK+IuQ92ZU4ukIQDIIRMER/z/5RgEUsCh9uVKFSbTqvb3+BLkrJDbHgMnqKjF
         syQFGEcLVu10eWYABi4ycdpVqXN6lV4Z9hvVxLX+IcAib34TeYFQyIa7qPimH+GK9b3x
         IWkkYpGLahGHqy7Ogps7wFyJmIybkzcG3jwpsIPK7MN6umZFC1tUq+NS9rWgy879sNaH
         eIOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700042162; x=1700646962;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qD0bQuuTi8xwLp9nUOcJhiWY+SrfRPdiiiXa8bGFI0M=;
        b=CPoW1/ng8BXXrte0UqZn300f4HyUOxHNrQyCkLmmJg0vtOH7u6qoTMc+TIDt/H/dxV
         Mja4G337+khKkCt8A889kQpIZLfbIkudZgzItcH/nQ4d80TTJJ+Qy8ZeHRN4lniw+ljq
         yJgELUBr5T4K7+UK2Tunk9wbbSOaKqQYe17eEc+b5BLCxYdmwqU74rmrZjC5qlq+74PR
         5U40xpbL8l+87vZ7u4Zdyr0fLOnelfnddIr6acVGHErgOj1lXEHSkEgzrO5vpzeps9qB
         wFK/N4ar1NjlqCF+JHaNLmXLTHZUbxnu3nFBAgXrqlwA3dfHGLtKobBavm2bSk7vKXTl
         Owzw==
X-Gm-Message-State: AOJu0YwPvUmFBRhlAJIA3Sd5ij/CYEa0vNrehJRs6fhTyVFno7FyF/CW
	7XOgOi4ls94oAUTR915/1mk=
X-Google-Smtp-Source: AGHT+IHxjWczp8rXDr7uSNcSdVIOJpct9XOCdnVSV3QESIfBBZEbJ+uV5HvMwtmjZK67AKuMrMNfjw==
X-Received: by 2002:a05:6a20:8f25:b0:125:517c:4f18 with SMTP id b37-20020a056a208f2500b00125517c4f18mr10932510pzk.8.1700042161879;
        Wed, 15 Nov 2023 01:56:01 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id u7-20020a170902e80700b001c5fc11c085sm7040415plg.264.2023.11.15.01.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 01:56:01 -0800 (PST)
Date: Wed, 15 Nov 2023 17:55:55 +0800
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
Subject: Re: [RFC PATCHv3 net-next 06/10] docs: bridge: add VLAN doc
Message-ID: <ZVSVq0fQ9qO9qTL3@Laptop-X1>
References: <20231110101548.1900519-1-liuhangbin@gmail.com>
 <20231110101548.1900519-7-liuhangbin@gmail.com>
 <794505c1-da3c-c52a-ece8-9629ab6f32db@blackwall.org>
 <ZVSOGvpkyEzCWH2Q@Laptop-X1>
 <588c2b90-2f57-f40d-2dfe-0c0131788497@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <588c2b90-2f57-f40d-2dfe-0c0131788497@blackwall.org>

On Wed, Nov 15, 2023 at 11:47:02AM +0200, Nikolay Aleksandrov wrote:
> > > But here it sounds a bit misleading, as if vlan-tagged frames are not
> > > handled otherwise. They are, just vlan tags are not considered when
> > > making forwarding decisions (e.g. FDB lookup).
> > 
> > How about:
> > 
> > VLAN filtering on a bridge is disabled by default. After enabling VLAN filtering
> > on a bridge, it will start forwarding frames to appropriate destinations based
> > on their VLAN tag.
> 
> How about a little tweak like: ... it will start forwarding frames to
> appropriate destinations based on their destination MAC address and VLAN
> tag (both must match).

Sure, thanks for your modification.

Hangbin

