Return-Path: <netdev+bounces-251083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3D9D3A9E4
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 14:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 12991300816C
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 13:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C21364E9C;
	Mon, 19 Jan 2026 13:06:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F9336405C
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 13:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768828000; cv=none; b=GDr9TOntgUuLwTbKquMDJGdOCXFZYVtbNKclasYvZKeM2Z0ZKESUfzuNPLVyXc9pqGih+iktnGABUyRa7yGJzEHlIw6eobJ8pCIkwAZYYtXX3Y3zdKEHQFSIMqLq1EkPx3BsegG/jxE27vYIJM00wJ9ietpAOlc4Kr+HZ+Hy+J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768828000; c=relaxed/simple;
	bh=/Us8lcYjnMs3hYNfxM80VN6XaA/JNtNkcccthYwsPC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gjs+RzCnWsJr2hkXoPmDLP+5onRZwqXP6rZ47IMJ3qEGbPsI+DsWwmbSVKrWSQzU6OYI4iKYsjqurVsfTwDNTUAhedAOJUIvYCBJRVqny5JPP+mwZNBE/MhwqTz6CIN3Yibv4eAT38buN4mPwqL7WNS2KhBuH18I6CHvfwdXi6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-4043b27ddeaso2523916fac.1
        for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 05:06:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768827998; x=1769432798;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CJJUuT8FNDqR2jqcibTan0S0h66UkUo2QatHFq2fuGY=;
        b=kZkr9EVbQpqu229eixyKkQmBJlna2FHon6EH07YmUOK0yYjLBage8MbkeIzlENHmz3
         PeVECzO/w/+Lv26cJaEJsdp0YxQQnClndwfMH9r4oD1mkIaX52X/Oe1fifiMxMGhX9i6
         plQW93rSWyDaYNRNBvyiT/iU7Vm1EkQl+reLSRDXkSbgDawIUBCIFs7+0W5GEhI4IzvD
         LqqwPJkxfAGBob3l4KAMUHInwlfK75qonBQjdtrmU/Hfsdg0ebv1+bV1zMOua2A5gK6h
         AA3pOP2m1sPbNKsunqIk9O9XCcaABZJgkkjYBM9XRjgQc7nkyCkNq/DJVO3tx9yDF3CJ
         mcdw==
X-Forwarded-Encrypted: i=1; AJvYcCVdF59SgFwyuRtDyNI5E7QDAuX782hB3vcglv2wXMaAKv515gUEAhWB/6vtSPpIpVudJyw8Ylg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDv8U6mPfWL6fUGcNImyxetL9oeiUbUXvS80AhTL9KqUGwrqSo
	iDI1xfSHs16qVYA0LNWLxLNaHaT0wp5j0qRQoI/NvCV5Vcuw8dkJSpaR
X-Gm-Gg: AZuq6aKzoRusmq5ydKiM+bsbxID7Y0fyOZLkr4mkY0HefHxl1tu+q8DoGt+9wDmpA92
	R3E74RTYX6Yipo7B8OrTJTDhUYz6U4b5rHH8dBnWh65BFOv2S2U9b8EiCJeaozY4JjB/QjuiehO
	oGszg+WziOrF4YdtfTAFfnTeZdE93GWVIfkO2AYYD5vrO3eV6mZ2ewiykR4yqhWOVIn9GRcN+NU
	OIKLDyZLVBiuixnB0NA2SSB2x5eu4xUOZgOh5c6NACjkso7NISmn8tLDqDTTQZgdhpAPH7Ya2xt
	mz3Ao9PlZoyUd+/2r4Zc1PTfBuLdXs/irOOH5xprWEEgB3ivY0o3Sz/cyMj3h2JyzTuG0FcMTFb
	XuiXK6hAKjBo42N2JASTnRhaCYiR0DkielcJUh68eNg+FZdIl//cGek7oqiOYvyORjI6GoV38Rx
	6dyw==
X-Received: by 2002:a05:6870:2111:b0:3e8:9dfb:8a21 with SMTP id 586e51a60fabf-4044c4b8903mr5238979fac.42.1768827998302;
        Mon, 19 Jan 2026 05:06:38 -0800 (PST)
Received: from gmail.com ([2a03:2880:10ff:47::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4044bd5cf99sm6454072fac.17.2026.01.19.05.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 05:06:37 -0800 (PST)
Date: Mon, 19 Jan 2026 05:06:35 -0800
From: Breno Leitao <leitao@debian.org>
To: Andre Carvalho <asantostc@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v11 4/7] netconsole: clear dev_name for devices
 bound by mac
Message-ID: <eajjf6bdzw444nw2ggucsqcedhskheu4a3qogati2kxg6nj6c7@5iuyvjsp7nnp>
References: <20260118-netcons-retrigger-v11-0-4de36aebcf48@gmail.com>
 <20260118-netcons-retrigger-v11-4-4de36aebcf48@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260118-netcons-retrigger-v11-4-4de36aebcf48@gmail.com>

On Sun, Jan 18, 2026 at 11:00:24AM +0000, Andre Carvalho wrote:
> This patch makes sure netconsole clears dev_name for devices bound by mac
> in order to allow calling setup_netpoll on targets that have previously
> been cleaned up (in order to support resuming deactivated targets).
> 
> This is required as netpoll_setup populates dev_name even when devices are
> matched via mac address. The cleanup is done inside netconsole as bound
> by mac is a netconsole concept.
> 
> Signed-off-by: Andre Carvalho <asantostc@gmail.com>

Reviewed-by: Breno Leitao <leitao@debian.org>

