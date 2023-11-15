Return-Path: <netdev+bounces-47924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1757EBF64
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 10:23:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1FB21F26725
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 09:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8805660;
	Wed, 15 Nov 2023 09:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C16J+4iv"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDBA6103
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 09:23:45 +0000 (UTC)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B79B811F
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 01:23:44 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1cc53d0030fso5285355ad.0
        for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 01:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700040224; x=1700645024; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MLzymri8uLxcQTaUHDsTQ+w2JpDA5ZUDzvuij0JwzU0=;
        b=C16J+4iv7SpmveC82/lueRQRiGYc1OUaFQWw342gL+y21rpOUJtlM8qKcIBWWCpzAB
         EnTLOOfL1yYU4d7NO+CNlL/qhcJvJSxVZcVkCxp7h+JYLSV0t6X/BrCVcr2jsdQrmLrk
         TnvG4xBxmuH51cpM+fH/1Nw0C8MYYB9lscOKbQp+1jX4jNRLy88kXtt2RueiMsCH2CXG
         eAyA0k5kVNg6h8QanwRRTe4aCwNgVsetF1EsJpIxkj1KEoNt0gPaWzoC0JQ8gC8XBHo6
         hDw5DyD7ylek8QUl4HPGxRll5/sVnha955XUNqKsC3NBm8hv9wnOEiJHbJmxRAGbQnH/
         eeeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700040224; x=1700645024;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MLzymri8uLxcQTaUHDsTQ+w2JpDA5ZUDzvuij0JwzU0=;
        b=P1hg1T04jUhkMEJ8U+2tZ3YNNFgPAh/lorosV/9JvUMprGj6h8LFHv0RLEQe4/dgsi
         NDM58gNMQYdZV4QxJjwnY+lxgtytReKO0SzbPHhPhWTTdAJ1OjAhxbzuZPWpcIEJ5Wxa
         bSTJ8CclJ4gpqnOUrnZXY4qezaST1lw/X7YAXYH4anXpZ75lYS6JmumpBTPMwqxSf4Xe
         BQB4fT227VcvdWqMhe6YyNJD0F1yOhYQX3vB4urWmPclneI7i8Xj+mXavpDuBE7lAmCf
         QXi5/REHExllXEkoxGrPVYYjKvy3Fv+pk9sJHFPs4kace8ylWvmTM6YQjmpyITxkpHeK
         i7iA==
X-Gm-Message-State: AOJu0YxaJiWDiVtn5UHWTsfN7Jc79Fdv8toWQP8YaORPwzJQb9Dnthdg
	bg4Ug3dGuNInKIW6DTnIMu4=
X-Google-Smtp-Source: AGHT+IFdXHshEbjmsR92W9yFesi+RWAF4rzqcoynKKay2xBcg3Liq6KGM1MiiyzzuRpdmmtXYwEQag==
X-Received: by 2002:a17:902:ec91:b0:1c6:362:3553 with SMTP id x17-20020a170902ec9100b001c603623553mr6791914plg.31.1700040224222;
        Wed, 15 Nov 2023 01:23:44 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id t12-20020a170902e84c00b001cc29b5a2aesm6995016plg.254.2023.11.15.01.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 01:23:43 -0800 (PST)
Date: Wed, 15 Nov 2023 17:23:38 +0800
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
Message-ID: <ZVSOGvpkyEzCWH2Q@Laptop-X1>
References: <20231110101548.1900519-1-liuhangbin@gmail.com>
 <20231110101548.1900519-7-liuhangbin@gmail.com>
 <794505c1-da3c-c52a-ece8-9629ab6f32db@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <794505c1-da3c-c52a-ece8-9629ab6f32db@blackwall.org>

On Mon, Nov 13, 2023 at 11:54:36AM +0200, Nikolay Aleksandrov wrote:
> > +The `VLAN filtering <https://lore.kernel.org/netdev/1360792820-14116-1-git-send-email-vyasevic@redhat.com/>`_
> 
> drop "The", just VLAN filtering
> 
> > +on bridge is disabled by default. After enabling VLAN
> 
> on a bridge
> 
> > +filter on bridge, the bridge can handle VLAN-tagged frames and forward them
> 
> filtering on a bridge, it will
> 
> But here it sounds a bit misleading, as if vlan-tagged frames are not
> handled otherwise. They are, just vlan tags are not considered when
> making forwarding decisions (e.g. FDB lookup).

How about:

VLAN filtering on a bridge is disabled by default. After enabling VLAN filtering
on a bridge, it will start forwarding frames to appropriate destinations based
on their VLAN tag.

Thanks
Hangbin

