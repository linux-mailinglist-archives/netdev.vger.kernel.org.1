Return-Path: <netdev+bounces-62664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C46882864C
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 13:52:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF3111F24955
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 12:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3325381CF;
	Tue,  9 Jan 2024 12:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mfNTKuqe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4A338DCD
	for <netdev@vger.kernel.org>; Tue,  9 Jan 2024 12:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3376f71fcbbso1352736f8f.1
        for <netdev@vger.kernel.org>; Tue, 09 Jan 2024 04:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704804727; x=1705409527; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZUfn3A6LMXwVtxZJmmWLULXnR+7Lbby3BO0v8WupMT4=;
        b=mfNTKuqeK/7QlJcp4mDOwMhOmyyLgfHe0NV6GVvWR5saDRTrErod4gsnegW5/q/Y16
         MIcWAn9e8AepeeI1aI16QiPU4v3Upor0Df1rYzrImICLUvsNjzySooh9aTBL9QLbH7ug
         MGjG8+UkshPfCmP7QJEC1RNJ2c1RXBd/Gypy9KgmveV5S/U/Kz/tvzwDOKXvIk9+IQnr
         bNyj8UvOePQ7hhRNVFzU9i3TD9VsGHF1oZn8S6IGTEcE3CODOjpo2iROW+yLmudOC5B3
         U9/evxxEC7vH+uq0R0l9mEBMY0h3p8hLuIKdF/0KM82idofwMt4X3nVU2hEQbBPuuMr+
         fQLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704804727; x=1705409527;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZUfn3A6LMXwVtxZJmmWLULXnR+7Lbby3BO0v8WupMT4=;
        b=EiYVl40+kTZL95ITfklIZMgYI7tziBYwEy8cRCl1UIDIeKPjK2mbDDfYFjnAHZnHL1
         wPKDQwvdvwqi/AL5ofBG4JmwSfOC0Hgd3lky8aktHbCbmafnugO3UimE/bcASg2DlZmd
         HDI8YzfpOXJ5CqS9tUZ977SgMlXdhnVzqQwwZ/i4PKIji/UVsRdXh7BWTLlzb4yeNipk
         2d0xWkXZsd6aW7qBM7vh4ODKkU8emlhzPPrj4A1nKcEWfyzxND7ONaBxwFkYzBYEpEm8
         1jEIlqkN+sgwHnfK8Wd7kVLoZ+0n4OjQTDHWxmnAHSTLcT7p24X4MNL7ic93hkyKf+0Z
         tWoA==
X-Gm-Message-State: AOJu0Yxg2S7OqDe/lf/E4Xz+8lWECMbVwsBBakwwQApVjVgp8VhUapg/
	lj1PwB3LBHLTQqWm8XT2d88=
X-Google-Smtp-Source: AGHT+IGKdDJeCF7FCJS/mrVeeK2YzY6sKx0ddSilLLQRFV30aY+or2nILTLQf1bZgDtIkH9lorqjEw==
X-Received: by 2002:a5d:6d84:0:b0:337:5554:9f71 with SMTP id l4-20020a5d6d84000000b0033755549f71mr350622wrs.28.1704804727259;
        Tue, 09 Jan 2024 04:52:07 -0800 (PST)
Received: from skbuf ([188.25.255.36])
        by smtp.gmail.com with ESMTPSA id bf2-20020a0560001cc200b0033763a9ea2dsm2350576wrb.63.2024.01.09.04.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 04:52:07 -0800 (PST)
Date: Tue, 9 Jan 2024 14:52:05 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Lukasz Majewski <lukma@denx.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Tristram.Ha@microchip.com,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	George McCollister <george.mccollister@gmail.com>
Subject: Re: [net][hsr] Question regarding HSR RedBox functionality
 implementation (preferably on KSZ9477)
Message-ID: <20240109125205.u6yc3z4neter24ae@skbuf>
References: <20230928124127.379115e6@wsk>
 <20231003095832.4bec4c72@wsk>
 <20231003104410.dhngn3vvdfdcurga@skbuf>
 <20230922133108.2090612-1-lukma@denx.de>
 <20230926225401.bganxwmtrgkiz2di@skbuf>
 <20230928124127.379115e6@wsk>
 <20231003095832.4bec4c72@wsk>
 <20231003104410.dhngn3vvdfdcurga@skbuf>
 <20240109133234.74c47dcd@wsk>
 <20240109133234.74c47dcd@wsk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240109133234.74c47dcd@wsk>
 <20240109133234.74c47dcd@wsk>

Hi Lukasz,

On Tue, Jan 09, 2024 at 01:32:34PM +0100, Lukasz Majewski wrote:
> However, I'm wondering how the mainline Linux kernel could handle HSR
> RedBox functionality (on document [1], Figure 2. we do have "bridge" -
> OSI L2).
> 
> To be more interesting - br0 can be created between hsr0 and e.g. lan3.
> But as expected communication breaks on both directions (to SAN and to
> HSR ring).

Yes, I suppose this is how a RedBox should be modeled. In principle it's
identical to how bridging with LAG ports (bond, team) works - either in
software or offloaded. The trouble is that the HSR driver seems to only
work with the DANH/DANP roles (as also mentioned in
Documentation/networking/dsa/dsa.rst). I don't remember what doesn't
work (or if I ever knew at all). It might be the address substitution
from hsr_xmit() that masks the MAC address of the SAN side device?

> Is there a similar functionality already present in the Linux kernel
> (so this approach could be reused)?
> 
> My (very rough idea) would be to extend KSZ9477 bridge join functions
> to check if HSR capable interface is "bridged" and then handle frames
> in a special way.
> 
> However, I would like to first ask for as much input as possible - to
> avoid any unnecessary work.

First I'd figure out why the software data path isn't working, and if it
can be fixed. Then, fix that if possible, and add a new selftest to
tools/testing/selftests/net/forwarding/, that should pass using veth
interfaces as lower ports.

Then, offloading something that has a clear model in software should be
relatively easy, though you might need to add some logic to DSA. This is
one place that needs to be edited, there may be others.

	/* dsa_port_pre_hsr_leave is not yet necessary since hsr devices cannot
	 * meaningfully placed under a bridge yet
	 */

> 
> Thanks in advance for help :-)
> 
> Link:
> 
> [1] -
> https://ww1.microchip.com/downloads/en/Appnotes/AN3474-KSZ9477-High-Availability-Seamless-Redundancy-Application-Note-00003474A.pdf
> 
> 
> Best regards,
> 
> Lukasz Majewski

