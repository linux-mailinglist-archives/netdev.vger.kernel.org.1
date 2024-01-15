Return-Path: <netdev+bounces-63585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5736B82E25C
	for <lists+netdev@lfdr.de>; Mon, 15 Jan 2024 22:54:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE0A21F22F00
	for <lists+netdev@lfdr.de>; Mon, 15 Jan 2024 21:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128F21B295;
	Mon, 15 Jan 2024 21:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kjcNIt0D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C80C1B581
	for <netdev@vger.kernel.org>; Mon, 15 Jan 2024 21:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-558ac3407eeso5121078a12.0
        for <netdev@vger.kernel.org>; Mon, 15 Jan 2024 13:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705355675; x=1705960475; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+jmOzMPzlo9pa5YkW6/VtxDUg2ecd/+H7Npg1caunVo=;
        b=kjcNIt0DfI8pjttDVtGucdWWbjcjtL0FHMJcMK8bk7svc3glwH47pmWKiSHv3ZQYA8
         VPAdB6vsSgzyqvk1S8gsOcYA6CZp18P8Nn0TqnxGlMkHoWkbqeQqe69UkgUciDJ9xEnG
         DCcamVxktUHcYTTiPdr8jxHKkRj9lGMBdgCOcuGH8RFEMyzFlHcZNzC4kBO8R0392ZIr
         dHZ4jTJwOwx+fLDY3VjkQsc5s07v3vFECB50JWUkFmKXVG6wZO6XN2IoUIsJLcU+j3Cv
         rRICfcxEtgt+v/nhnPtVJNecqYc+nC1LdBvjpxBzNEu5WpZMRUeg6rNgih6xfFNkzoMp
         LQ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705355675; x=1705960475;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+jmOzMPzlo9pa5YkW6/VtxDUg2ecd/+H7Npg1caunVo=;
        b=ngvip2bVvvd8/Zmxz4walpHSsCtkO2Xt4JXSzHmn23REVO43Rs59lNA8CyvfIOurPu
         W1ql2hTYon8f1XMbGgB4nJUEounDq+jZl7XpJLDqX7/mwMr3iPwQoAAFF4kSZwb1tD9h
         tr2YvlA8UtVNQ58Ag6VuyiP123fpwGwVwCW8haCivF9iQ2yLX33oGdmCDSr6tGShZnvV
         E9cL7ss7oBvTU1lzC6gz7LTnqDRiZSz8ednb2Lmt2K5VfRoLH3LG7e3Wrz8ZohFGogc5
         xU9TSGc1OHY12AmkfouIe/ooPP+bJK6tQa7KME4k4MHaLhxGYhqF2v8grhpuHuWutrC4
         x7Gg==
X-Gm-Message-State: AOJu0Ywj0a2F7P41hj+f2BDKWQZyrMUXA6BJn9Lqklr6pWhfDaz8x+De
	q7JNRttHiyszzf53+QU8ZgQ=
X-Google-Smtp-Source: AGHT+IHARCtpFqcgbnMJCumVR4VDapK3JwS7G4FAMEMlzvIpbxCk0a+mNZoAECFRBQZvFKGUYR8zPg==
X-Received: by 2002:a17:907:a094:b0:a2b:5d55:c322 with SMTP id hu20-20020a170907a09400b00a2b5d55c322mr3081613ejc.25.1705355674657;
        Mon, 15 Jan 2024 13:54:34 -0800 (PST)
Received: from skbuf ([188.25.255.36])
        by smtp.gmail.com with ESMTPSA id w17-20020a17090652d100b00a28116285e0sm1351336ejn.165.2024.01.15.13.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 13:54:34 -0800 (PST)
Date: Mon, 15 Jan 2024 23:54:32 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: netdev@vger.kernel.org, linus.walleij@linaro.org, alsi@bang-olufsen.dk,
	andrew@lunn.ch, f.fainelli@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	arinc.unal@arinc9.com
Subject: Re: [PATCH net-next v3 0/8] net: dsa: realtek: variants to drivers,
 interfaces to a common module
Message-ID: <20240115215432.o3mfcyyfhooxbvt5@skbuf>
References: <20231223005253.17891-1-luizluca@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231223005253.17891-1-luizluca@gmail.com>

On Fri, Dec 22, 2023 at 09:46:28PM -0300, Luiz Angelo Daros de Luca wrote:
> The series begins by removing an unused function pointer at
> realtek_ops->cleanup.
> 
> Each variant module was converted into real drivers, serving as both a
> platform driver (for switches connected using the SMI interface) and an
> MDIO driver (for MDIO-connected switches). The relationship between the
> variant and interface modules is reversed, with the variant module now
> calling both interface functions (if not disabled at build time). While
> in most devices only one interface is likely used, the interface code is
> significantly smaller than a variant module, consuming fewer resources
> than the previous code. With variant modules now functioning as real
> drivers, compatible strings are published only in a single variant
> module, preventing conflicts.
> 
> The patch series introduces a new common module for functions shared by
> both variants. This module also absorbs the two previous interface
> modules, as they would always be loaded anyway.
> 
> The series relocates the user MII driver from realtek-smi to common. It
> is now used by MDIO-connected switches instead of the generic DSA
> driver. There's a change in how this driver locates the MDIO node. It
> now only searches for a child node named "mdio", which is required by
> both interfaces in binding docs.
> 
> The dsa_switch in realtek_priv->ds is now embedded in the struct. It is
> always in use and avoids dynamic memory allocation.

git format-patch --cover-letter generates a nice patch series overview
with a diffstat and the commit titles, you should include it next time.

